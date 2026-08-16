from rag.retrieval.retriever import RAGRetriever

retriever = RAGRetriever(top_k=5)
query = "What are the symptoms of tomato early blight?"
results = retriever.retrieve(query)

print(f"\nQuery: {query}")
print(f"Retrieved chunks: {len(results)}")

for index, result in enumerate(results, start=1):
    print("\n" + "=" * 70)
    print(f"RESULT {index}")
    print(f"Similarity: {result['similarity']}")
    print(f"Metadata: {result['metadata']}")
    print("=" * 70)
    print(result["content"])