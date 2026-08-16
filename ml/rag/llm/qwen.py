import requests
from rag.prompts.rag_prompt import SYSTEM_PROMPT

class QwenClient:
    def __init__(
            self,
            model: str = "qwen2.5vl:3b",
            base_url: str = "http://localhost:11434",
    ):
        self.model = model
        self.base_url = base_url.rstrip("/")

    def chat(self, prompt: str) -> str:
        response = requests.post(
            f"{self.base_url}/api/chat",
            json={
                "model": self.model,
                "messages": [
                    {
                        "role": "system",
                        "content": SYSTEM_PROMPT,
                    },
                    {
                        "role": "user",
                        "content": prompt,
                    },
                ],
                "stream": False,
            },
            timeout=300,
        )

        response.raise_for_status()

        data = response.json()

        message = data.get("message")

        if not message or "content" not in message:
            raise ValueError(
                f"Invalid Ollama response: {data}"
            )

        return message["content"]