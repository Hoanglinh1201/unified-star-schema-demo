# Unified Star Schema Demo

This repository showcases the Unified Star Schema (USS) approach using
* [dbt](https://www.getdbt.com/)
* [Rill](https://www.rilldata.com/)
* [Brazilian e‑commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data) into DuckDB and builds a sample reporting model.

Read more about Unified Star Schema approach [here]()
## Prerequisites

- Python 3.13
- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- [Rill](https://docs.rilldata.com/home/install)

## Installation

1. Clone the repository and navigate into it:
   ```bash
   git clone https://github.com/your-org/unified-star-schema-demo.git
   cd unified-star-schema-demo
   ```
2. Create and activate a virtual environment using uv
   ```bash
   uv venv
   source .venv/bin/activate
   ```
3. Install the Python dependencies from `uv.lock`:
   ```bash
   uv sync
   ```

4 Prepare the demo database:
   ```bash
   python database_setup.py
   ```
   This downloads the dataset, unzip it and creates `data/olist.duckdb`.

## Building the models

Run the dbt project from the `dbt` directory:
```bash
cd dbt
dbt run    # build the tables
```
The profile in `dbt/profiles.yml` points to the DuckDB database created in the previous step.

## Exploring the data
To launch Rill dashboards:
```bash
rill start
```

## Repository layout

- `database_setup.py` &ndash; script that downloads and loads the dataset.
- `dbt/` &ndash; dbt project
   - `mart` models represents USS implementation with bridge and final dataset models.
- `rill/` &ndash; example Rill configuration for dashboards and metrics

---
