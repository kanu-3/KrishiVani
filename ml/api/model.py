import json
from pathlib import Path
import tensorflow as tf

BASE_DIR = Path(__file__).resolve().parent

MODEL_PATH = BASE_DIR / "best_model.keras"
CLASS_NAMES_PATH = BASE_DIR / "class_names.json"

model = tf.keras.models.load_model(MODEL_PATH)

with open(CLASS_NAMES_PATH, "r") as file:
    class_names = json.load(file)


print(f"Model loaded from: {MODEL_PATH}")
print(f"Number of classes: {len(class_names)}")