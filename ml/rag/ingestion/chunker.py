import re
from rag.ingestion.loader import Document

class MarkdownChunker:
    def __init__(
            self,
            max_chunk_size: int = 1500,
            overlap: int = 200,
    ):
        self.max_chunk_size = max_chunk_size
        self.overlap = overlap

    def split(
            self,
            document: Document,
    ) -> list[Document]:
        sections = self._split_sections(
            document.content
        )

        chunks: list[Document] = []

        for section in sections:
            section_chunks = (
                self._split_large_section(section)
            )

            for chunk in section_chunks:
                chunks.append(
                    Document(
                        content=chunk,
                        metadata={
                            **document.metadata,
                            "chunk_index": len(chunks),
                        },
                    )
                )

        return chunks

    def _split_sections(
            self,
            text: str,
    ) -> list[str]:
        sections = re.split(
            r"\n(?=## )",
            text,
        )

        return [
            section.strip()
            for section in sections
            if section.strip()
        ]

    def _split_large_section(
            self,
            section: str,
    ) -> list[str]:
        if len(section) <= self.max_chunk_size:
            return [section]

        paragraphs = re.split(
            r"\n\s*\n",
            section,
        )

        chunks: list[str] = []
        current = ""

        for paragraph in paragraphs:
            paragraph = paragraph.strip()

            if not paragraph:
                continue

            candidate = (
                paragraph
                if not current
                else f"{current}\n\n{paragraph}"
            )

            if len(candidate) <= self.max_chunk_size:
                current = candidate
                continue

            if current:
                chunks.append(
                    current.strip()
                )

            if len(paragraph) > self.max_chunk_size:
                chunks.extend(
                    self._split_by_characters(
                        paragraph
                    )
                )
                current = ""
            else:
                current = paragraph

        if current:
            chunks.append(
                current.strip()
            )

        return chunks

    def _split_by_characters(
            self,
            text: str,
    ) -> list[str]:
        chunks: list[str] = []

        start = 0

        while start < len(text):
            end = start + self.max_chunk_size

            chunks.append(
                text[start:end].strip()
            )

            if end >= len(text):
                break

            start = end - self.overlap

        return chunks