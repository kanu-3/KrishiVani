from rag.retrieval.retriever import RAGRetriever
from rag.llm.qwen import QwenClient
from rag.prompts.rag_prompt import build_rag_prompt

class RAGService:
    def __init__(self, top_k: int = 5):
        self.retriever = RAGRetriever(
            top_k=top_k,
        )
        self.llm = QwenClient()

    def answer(
            self,
            query: str,
            diagnosis=None,
    ) -> str:

        results = self.retriever.retrieve(
            query=query,
            diagnosis=diagnosis,
        )

        if not results:
            retrieved_context = (
                "No relevant information was found "
                "in the KrishiVani knowledge base."
            )
        else:
            retrieved_context = "\n\n".join(
                result["content"]
                for result in results
            )

        prompt = build_rag_prompt(
            query=query,
            retrieved_context=retrieved_context,
            diagnosis=diagnosis,
        )

        return self.llm.chat(prompt)