from dataclasses import dataclass

@dataclass
class DiagnosisContext:
    crop: str
    disease: str
    confidence: float