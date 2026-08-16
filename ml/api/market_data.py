import pandas as pd
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent
DATA_PATH = BASE_DIR / "tomato_daily.csv"

def get_latest_prices(days=30):

    df = pd.read_csv(
        DATA_PATH,
        parse_dates=["date"]
    )

    df = df.sort_values("date").reset_index(drop=True)

    if len(df) < days:
        raise ValueError(
            f"Not enough historical data. "
            f"Required {days}, found {len(df)}."
        )

    latest = df.tail(days)

    return latest[["date", "price"]]


if __name__ == "__main__":

    data = get_latest_prices(30)

    print("Latest 30 observations:")
    print(data)

    print("\nNumber of observations:", len(data))
    print(
        "Date range:",
        data["date"].iloc[0],
        "→",
        data["date"].iloc[-1]
    )