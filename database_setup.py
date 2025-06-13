"""
This script sets up the database for the AI Job Market and Salary Trends 2025 dataset.
It downloads the dataset from Kaggle and stores it as a duckdb database.
"""

import requests
import duckdb
from pathlib import Path
import logging
import zipfile
import os
import shutil
from rich.console import Console
from rich.table import Table
from rich.logging import RichHandler
import logging 

logging.basicConfig(
    level=logging.INFO,
    handlers=[RichHandler(rich_tracebacks=True)],
    format="%(message)s",
)

# Define constants for dataset URL and storage paths
DATASET_URL = (
    "https://www.kaggle.com/api/v1/datasets/download/olistbr/brazilian-ecommerce"
)
DATA_STORAGE_PATH = Path("data")
DATABASE_NAME = "olist.duckdb"
LANDING_SCHEMA = "_LANDING"


def prep_data_dir():
    """
    Deletes all contents of the data/ directory before setup.
    """
    if DATA_STORAGE_PATH.exists():
        logging.info("🧹 Cleaning up existing data directory...")
        for item in DATA_STORAGE_PATH.iterdir():
            if item.is_file():
                item.unlink()
            elif item.is_dir():
                shutil.rmtree(item)
        logging.info("✅ Data directory cleaned.")

    else:
        logging.info("📂 Creating data directory...")
        DATA_STORAGE_PATH.mkdir(parents=True, exist_ok=True)
        logging.info("✅ Data directory created.")


def download_dataset() -> None:
    """
    Downloads the dataset from Kaggle and saves it to the specified path.
    """

    zip_path = DATA_STORAGE_PATH / "data.zip"
    response = requests.get(DATASET_URL)
    if response.status_code == 200:
        with open(zip_path, "wb") as file:
            file.write(response.content)

        logging.info("Downloaded dataset to %s", zip_path)

        with zipfile.ZipFile(zip_path, "r") as zip_ref:
            zip_ref.extractall(DATA_STORAGE_PATH)
            logging.info("Extracted dataset to %s", DATA_STORAGE_PATH)

    else:
        logging.error(
            f"Failed to download dataset. Status code: {response.status_code}"
        )
        raise Exception("Dataset download failed.")


def create_table_from_csv(conn: duckdb.DuckDBPyConnection, csv_file: str) -> dict[str, any]:
    """
    Creates a table in the DuckDB database from a CSV file.

    Args:
        conn: The DuckDB connection object.
        csv_file: The path to the CSV file.
    """
    landing_table_name = csv_file.stem.lower().replace("-", "_")
    landing_locator = f"{LANDING_SCHEMA}.{landing_table_name}"
    conn.execute(
        f"""
        CREATE OR REPLACE TABLE {landing_locator} AS
        SELECT * FROM read_csv_auto('{csv_file}', header=True);
    """
    )

    conn.execute(
        f"""
        SELECT COUNT(*) AS row_count
        FROM {landing_locator};
    """
    )
    row_count = conn.fetchone()[0]
    return {
        "csv_file": str(csv_file),
        "landing_locator": landing_locator,
        "row_count": row_count,
    }

def report_loading_summary(loading_summary: list[dict[str, any]]) -> None:
    """
    Reports the summary of loaded tables in a formatted table.

    Args:
        loading_summary: A list of dictionaries containing loading information.
    """
    console = Console()
    table = Table(title="Loading Summary", show_header=True, header_style="bold magenta")
    table.add_column("CSV File", style="cyan", no_wrap=True, justify="left")
    table.add_column("Landing Locator", style="green", no_wrap=True, justify="left")
    table.add_column("Row Count", style="yellow", no_wrap=True, justify="right")

    for line in loading_summary:
        table.add_row(
            line["csv_file"],
            line["landing_locator"],
            str(line["row_count"]),
        )

    console.print(table)

def setup_database() -> None:
    """
    Sets up the DuckDB database and creates a table for the AI Job Market and Salary Trends 2025 dataset.
    """

    csv_files = list(Path(DATA_STORAGE_PATH).glob("*.csv"))
    if not csv_files:
        raise FileNotFoundError("No CSV files found in the directory.")

    if os.path.exists(DATA_STORAGE_PATH / DATABASE_NAME):
        # always create a new database to avoid conflicts
        os.remove(DATA_STORAGE_PATH / DATABASE_NAME)

    db_path = DATA_STORAGE_PATH / DATABASE_NAME
    logging.info(f"Created DuckDB database at {db_path}")

   
    # Create a table for the dataset
    with duckdb.connect(str(db_path)) as conn:

         # Create schema and table if they do not exist
        conn.execute(f"""CREATE SCHEMA IF NOT EXISTS {LANDING_SCHEMA}""")
        logging.info("Schema %s created in the database.", LANDING_SCHEMA)

        loading_summary = []
        for csv_file in csv_files:
            loading_log = create_table_from_csv(conn, csv_file)
            loading_summary.append(loading_log)

        report_loading_summary(loading_summary)

if __name__ == "__main__":
    try:
        prep_data_dir()
        download_dataset()
        setup_database()
        logging.info("Database setup completed successfully.")
    except Exception as e:
        logging.error(f"An error occurred: %s", e)
