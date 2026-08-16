import requests

class NomicEmbedder:
    def __init__(
            self,
            model: str = "nomic-embed-text:latest",
            base_url: str = "http://localhost:11434",
    ):
        self.model = model
        self.base_url = base_url.rstrip("/")

    def embed(self, text: str) -> list[float]:
        response = requests.post(
            f"{self.base_url}/api/embed",
            json={
                "model": self.model,
                "input": text,
            },
            timeout=120,
        )

        response.raise_for_status()

        data = response.json()

        embeddings = data.get("embeddings")

        if not embeddings:
            raise ValueError(
                f"Invalid embedding response: {data}"
            )

        embedding = embeddings[0]

        if not isinstance(embedding, list):
            raise ValueError(
                "Embedding response is not a list."
            )

        return embedding