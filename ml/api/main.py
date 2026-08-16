from fastapi import FastAPI, File, UploadFile, HTTPException
from PIL import Image
import io
import numpy as np
from fastapi.middleware.cors import CORSMiddleware
from api.chat import ChatRequest, ChatResponse, generate_chat_response
from api.model import model, class_names
from api.preprocessing import preprocess_image
from api.market import generate_market_forecast

app = FastAPI(
    title="KrishiVani CNN API",
    description="Plant disease classification API",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {
        "message": "KrishiVani API is running",
        "classes": len(class_names),
    }


@app.get("/health")
def health():
    return {
        "status": "healthy",
        "model_loaded": model is not None,
    }

@app.post("/predict")
async def predict(file: UploadFile = File(...)):

    if not file.content_type or not file.content_type.startswith("image/"):
        raise HTTPException(
            status_code=400,
            detail="Please upload an image file.",
        )

    try:
        image_bytes = await file.read()

        image = Image.open(io.BytesIO(image_bytes))

        processed_image = preprocess_image(image)

        predictions = model.predict(
            processed_image,
            verbose=0,
        )

        probabilities = predictions[0]

        predicted_index = int(np.argmax(probabilities))

        predicted_class = class_names[predicted_index]

        confidence = float(probabilities[predicted_index])

        print("Predicted index:", predicted_index)
        print("Predicted class:", predicted_class)
        print("Confidence:", confidence)
        print("Class names length:", len(class_names))

        return {
            "disease": predicted_class,
            "confidence": confidence,
        }

    except Exception as e:
        print("Prediction error:", repr(e))

        raise HTTPException(
            status_code=500,
            detail=f"Prediction failed: {str(e)}",
        )

@app.post(
    "/chat",
    response_model=ChatResponse,
)
async def chat(request: ChatRequest):

    if not request.message.strip():
        raise HTTPException(
            status_code=400,
            detail="Message cannot be empty.",
        )

    try:
        answer = generate_chat_response(
            message=request.message,
            diagnosis=request.diagnosis,
        )

        return ChatResponse(
            response=answer,
        )

    except HTTPException:
        raise

    except Exception as e:
        print("Chat error:", repr(e))

        raise HTTPException(
            status_code=500,
            detail=f"Chat failed: {str(e)}",
        )

@app.post("/market/forecast")
def market_forecast():

    try:

        latest_data, predictions = (
            generate_market_forecast()
        )

        return {
            "crop": "tomato",

            "district": (
                "Gautam Buddha Nagar"
            ),

            "historical_days_used": 30,

            "historical_data": {

                "start_date": (
                    latest_data["date"]
                    .iloc[0]
                    .strftime("%Y-%m-%d")
                ),

                "end_date": (
                    latest_data["date"]
                    .iloc[-1]
                    .strftime("%Y-%m-%d")
                ),
            },

            "forecast_days": 7,

            "forecast": [

                {
                    "day": i + 1,

                    "predicted_price": round(
                        float(price),
                        2
                    ),
                }

                for i, price in enumerate(
                    predictions
                )
            ],
        }

    except ValueError as e:

        raise HTTPException(
            status_code=400,
            detail=str(e),
        )

    except Exception as e:

        raise HTTPException(
            status_code=500,
            detail=(
                f"Market prediction failed: "
                f"{str(e)}"
            ),
        )