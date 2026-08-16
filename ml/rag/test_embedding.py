from embeddings.embedding import NomicEmbedder

embedder = NomicEmbedder()

text = """
Tomato early blight is caused by Alternaria solani.
It commonly affects older leaves and produces
brown lesions with concentric rings.
"""

embedding = embedder.embed(text)

print(f"Embedding dimensions: {len(embedding)}")
print(f"First 10 values: {embedding[:10]}")