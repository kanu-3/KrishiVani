from rag.models.diagnosis import DiagnosisContext
from rag.rag_service import RAGService


diagnosis = DiagnosisContext(
    crop="Tomato",
    disease="Early Blight",
    confidence=0.97,
)

rag = RAGService(top_k=5)

query = "What should I do to manage this disease?"

answer = rag.answer(
    query=query,
    diagnosis=diagnosis,
)

print("\n" + "=" * 70)
print("DIAGNOSIS")
print("=" * 70)

print(f"Crop: {diagnosis.crop}")
print(f"Disease: {diagnosis.disease}")
print(f"Confidence: {diagnosis.confidence:.2%}")

print("\n" + "=" * 70)
print("USER")
print("=" * 70)
print(query)

print("\n" + "=" * 70)
print("VANNI AI")
print("=" * 70)
print(answer)