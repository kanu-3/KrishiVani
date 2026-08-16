from pathlib import Path
from ingestion.loader import MarkdownLoader
from ingestion.chunker import MarkdownChunker

BASE_DIR = Path(__file__).resolve().parent

knowledge_base_path = BASE_DIR / "knowledge_base"

loader = MarkdownLoader(str(knowledge_base_path))
documents = loader.load()

chunker = MarkdownChunker()

for document in documents:
    chunks = chunker.split(document)

    print(f"Document: {document.metadata['filename']}")
    print(f"Total chunks: {len(chunks)}")

    for chunk in chunks:
        print("\n" + "=" * 60)
        print(f"Chunk index: {chunk.metadata['chunk_index']}")
        print("=" * 60)
        print(chunk.content)