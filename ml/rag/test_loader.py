from pathlib import Path

from ingestion.loader import MarkdownLoader

BASE_DIR = Path(__file__).resolve().parent
knowledge_base_path = BASE_DIR / "knowledge_base"
loader = MarkdownLoader(str(knowledge_base_path))
documents = loader.load()

print(f"Loaded documents: {len(documents)}")

for document in documents:
    print("\n--- DOCUMENT ---")
    print(document.metadata)
    print(document.content[:300])