from dataclasses import dataclass
from pathlib import Path

@dataclass
class Document:
    content: str
    metadata: dict

class MarkdownLoader:
    def __init__(self, knowledge_base_path: str):
        self.knowledge_base_path = Path(
            knowledge_base_path
        )

    def load(self) -> list[Document]:
        documents: list[Document] = []

        for file_path in self.knowledge_base_path.rglob("*.md"):
            content = file_path.read_text(
                encoding="utf-8"
            )

            metadata = self._build_metadata(
                file_path
            )

            documents.append(
                Document(
                    content=content,
                    metadata=metadata,
                )
            )

        return documents

    def _build_metadata(
            self,
            file_path: Path,
    ) -> dict:
        relative_path = file_path.relative_to(
            self.knowledge_base_path
        )

        category = relative_path.parts[0]

        metadata = {
            "filename": file_path.name,
            "category": category,
            "path": str(relative_path),
        }

        if category in {"diseases", "healthy"}:
            metadata["type"] = category

            name = file_path.stem
            parts = name.split("___")

            if len(parts) == 2:
                metadata["crop"] = parts[0]
                metadata["condition"] = parts[1]

        elif category == "general":
            metadata["type"] = "general"
            metadata["topic"] = file_path.stem

        return metadata