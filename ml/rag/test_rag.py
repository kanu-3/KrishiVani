from rag.rag_service import RAGService

rag = RAGService(top_k=5)

query = "What is a tomato?"

answer = rag.answer(query)

print("\n" + "=" * 70)
print("USER")
print("=" * 70)
print(query)

print("\n" + "=" * 70)
print("VANNI AI")
print("=" * 70)
print(answer)