from supabase import create_client
from rag.config import (
    SUPABASE_URL,
    SUPABASE_SERVICE_ROLE_KEY,
)
from rag.embeddings.embedding import NomicEmbedder

class RAGRetriever:
    def __init__(
            self,
            top_k: int = 5,
    ):
        self.top_k = top_k

        self.supabase = create_client(
            SUPABASE_URL,
            SUPABASE_SERVICE_ROLE_KEY,
        )

        self.embedder = NomicEmbedder()

    def retrieve(
            self,
            query: str,
            diagnosis=None,
    ):
        retrieval_query = query

        if diagnosis is not None:
            retrieval_query = (
                f"Crop: {diagnosis.crop}\n"
                f"Disease: {diagnosis.disease}\n"
                f"User question: {query}"
            )

        query_embedding = self.embedder.embed(
            retrieval_query
        )

        response = self.supabase.rpc(
            "match_rag_documents",
            {
                "query_embedding": query_embedding,
                "match_count": self.top_k,
            },
        ).execute()

        return response.data