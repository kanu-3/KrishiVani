from pathlib import Path
import time

from supabase import create_client

from rag.config import (
    SUPABASE_URL,
    SUPABASE_SERVICE_ROLE_KEY,
)

from rag.ingestion.loader import MarkdownLoader
from rag.ingestion.chunker import MarkdownChunker
from rag.embeddings.embedding import NomicEmbedder


BASE_DIR = Path(__file__).resolve().parent.parent
KNOWLEDGE_BASE_PATH = BASE_DIR / "knowledge_base"

BATCH_SIZE = 25
MAX_RETRIES = 3


def get_existing_chunks(supabase):
    print("Checking existing chunks...")

    response = (
        supabase
        .table("rag_documents")
        .select("metadata")
        .execute()
    )

    existing = set()

    for row in response.data:
        metadata = row.get("metadata") or {}

        path = metadata.get("path")
        chunk_index = metadata.get("chunk_index")

        if path is not None and chunk_index is not None:
            existing.add(
                (path, int(chunk_index))
            )

    print(
        f"Existing chunks found: {len(existing)}"
    )

    return existing


def insert_with_retry(supabase, rows):
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            response = (
                supabase
                .table("rag_documents")
                .insert(rows)
                .execute()
            )

            return response.data

        except Exception as e:
            print(
                f"Insert failed "
                f"(attempt {attempt}/{MAX_RETRIES}): "
                f"{type(e).__name__}: {e}"
            )

            if attempt == MAX_RETRIES:
                raise

            wait_time = attempt * 3

            print(
                f"Retrying in {wait_time} seconds..."
            )

            time.sleep(wait_time)


def main():
    print("Starting RAG ingestion...")

    supabase = create_client(
        SUPABASE_URL,
        SUPABASE_SERVICE_ROLE_KEY,
    )

    loader = MarkdownLoader(
        str(KNOWLEDGE_BASE_PATH)
    )

    documents = loader.load()

    print(
        f"Documents loaded: {len(documents)}"
    )

    chunker = MarkdownChunker()

    chunks = []

    for document in documents:
        document_chunks = chunker.split(
            document
        )
        chunks.extend(document_chunks)

    print(
        f"Chunks created: {len(chunks)}"
    )

    existing_chunks = get_existing_chunks(
        supabase
    )

    remaining_chunks = []

    for chunk in chunks:
        metadata = chunk.metadata or {}

        path = metadata.get("path")
        chunk_index = metadata.get("chunk_index")

        key = (
            path,
            int(chunk_index)
            if chunk_index is not None
            else None,
        )

        if key in existing_chunks:
            continue

        remaining_chunks.append(chunk)

    print(
        f"Chunks remaining: "
        f"{len(remaining_chunks)}"
    )

    if not remaining_chunks:
        print(
            "All chunks are already ingested."
        )
        return

    embedder = NomicEmbedder()

    total_inserted = 0

    for batch_start in range(
            0,
            len(remaining_chunks),
            BATCH_SIZE,
    ):
        batch = remaining_chunks[
            batch_start:
            batch_start + BATCH_SIZE
        ]

        rows = []

        for index, chunk in enumerate(
                batch,
                start=batch_start + 1,
        ):
            print(
                f"Embedding remaining chunk "
                f"{index}/{len(remaining_chunks)}..."
            )

            embedding = embedder.embed(
                chunk.content
            )

            rows.append(
                {
                    "content": chunk.content,
                    "embedding": embedding,
                    "metadata": chunk.metadata,
                }
            )

        inserted_rows = insert_with_retry(
            supabase,
            rows,
        )

        inserted = len(inserted_rows)

        total_inserted += inserted

        print(
            f"Inserted batch: {inserted} | "
            f"Total newly inserted: "
            f"{total_inserted}/{len(remaining_chunks)}"
        )

    print(
        "Finished successfully."
    )

    print(
        f"New chunks inserted: "
        f"{total_inserted}"
    )

    print(
        f"Previously existing chunks: "
        f"{len(existing_chunks)}"
    )

    print(
        f"Total expected chunks: "
        f"{len(chunks)}"
    )


if __name__ == "__main__":
    main()