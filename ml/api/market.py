import numpy as np
import joblib
from tensorflow.keras.models import load_model
from pathlib import Path
from api.market_data import get_latest_prices

BASE_DIR = Path(__file__).resolve().parent.parent
MODEL_PATH = BASE_DIR / "api" / "tomato_lstm.keras"
SCALER_PATH = BASE_DIR / "api" / "tomato_scaler.pkl"

back = 30
days = 7

market_model = load_model(MODEL_PATH)
market_scaler = joblib.load(SCALER_PATH)

def predict_market_prices(prices):

    if len(prices) != back:
        raise ValueError(
            f"Expected {back} prices, got {len(prices)}"
        )

    prices = np.array(prices).reshape(-1, 1)

    scaled_prices = market_scaler.transform(prices)

    X = scaled_prices.reshape(1, back, 1)

    prediction_scaled = market_model.predict(
        X,
        verbose=0
    )

    prediction = market_scaler.inverse_transform(
        prediction_scaled.reshape(-1, 1)
    )

    return prediction.flatten()


def generate_market_forecast():

    latest_data = get_latest_prices(back)

    prices = latest_data["price"].tolist()

    predictions = predict_market_prices(prices)

    return latest_data, predictions