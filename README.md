# Unified Star Schema Demo

This repository showcases the Unified Star Schema (USS) approach using [dbt](https://www.getdbt.com/), [Lightdash](https://www.lightdash.com/) and [Rill](https://www.rilldata.com/). It loads the Brazilian e‑commerce dataset into DuckDB and builds a sample reporting model.

## Prerequisites

- Python 3.13
- `uv` or `pip` for installing dependencies
- A Kaggle account and API credentials to download the dataset

## Installation

1. Clone the repository and navigate into it:
   ```bash
   git clone https://github.com/your-org/unified-star-schema-demo.git
   cd unified-star-schema-demo
   ```
2. Create and activate a virtual environment (using `uv` or `venv`):
   ```bash
   uv venv              # or: python3.13 -m venv .venv
   source .venv/bin/activate
   ```
3. Install the Python dependencies from `uv.lock`:
   ```bash
   uv pip install -r uv.lock
   ```
   (You can also run `pip install -e .` if you prefer.)
4. Ensure Kaggle API credentials are available as the environment variables
   `KAGGLE_USERNAME` and `KAGGLE_KEY`.
5. Prepare the demo database:
   ```bash
   python database_setup.py
   ```
   This downloads the dataset and creates `data/olist.duckdb`.

## Building the models

Run the dbt project from the `dbt` directory:
```bash
cd dbt
# install dbt packages if any
# dbt deps
# load seeds if provided
# dbt seed

dbt run    # build the tables
 dbt test   # run tests
```
The profile in `dbt/profiles.yml` points to the DuckDB database created in the previous step.

## Exploring the data

To launch Rill dashboards:
```bash
rill start
```
For Lightdash, run:
```bash
lightdash quickstart
```
Both commands will print a URL where you can explore the generated models.

## Repository layout

- `database_setup.py` &ndash; script that downloads and loads the dataset.
- `dbt/` &ndash; dbt project with staging and mart models.
- `rill/` &ndash; example Rill configuration for dashboards.

---
