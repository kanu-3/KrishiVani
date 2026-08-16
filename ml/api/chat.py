from typing import Optional
from pydantic import BaseModel
from rag.models.diagnosis import DiagnosisContext
from rag.rag_service import RAGService

class ChatRequest(BaseModel):
    message: str

    diagnosis: Optional[DiagnosisContext] = None

class ChatResponse(BaseModel):
    response: str

rag_service = RAGService()

def generate_chat_response(
        message: str,
        diagnosis: Optional[DiagnosisContext] = None,
) -> str:

    if diagnosis is not None:
        if (
                not diagnosis.crop.strip()
                or not diagnosis.disease.strip()
                or diagnosis.confidence <= 0
        ):
            diagnosis = None

    return rag_service.answer(
        query=message,
        diagnosis=diagnosis,
    )