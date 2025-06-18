# Unified Star Schema Demo

The Unified Star Schema (USS) was introduced by Bill Inmon and Francesco Puppini in the book [Unified Star Schema: An Agile and Resilient Approach to Data Warehouse and Analytics Design (2020)](https://books.google.de/books/about/The_Unified_Star_Schema_An_Agile_and_Res.html?id=q88AEAAAQBAJ).

It addresses key challenges in traditional data modeling:
❌ Too many star/snowflake schemas: Fragmented models make cross-domain analysis complex.
❌ Inconsistent dimensions and logic: Duplicated definitions lead to governance and maintenance issues.
❌ Difficult joins and loops: Navigating snowflake relationships can require complex, error-prone joins.
❌ Business requirements outpace mart building: Traditional data marts take time to build and align, while business teams need fast, cross-cutting insights. As business needs evolve, existing marts quickly become outdated and hard to repurpose.

USS solves these by using a single stable unbiased star schema with a central bridge table, making analytics simpler, more consistent, and easier to scale.

A great summary you could find in the article [Unified Star Schema to model Data Products by Paolo Platter](https://www.agilelab.it/blog/unified-star-schema-to-model-data-products).


This repository implements the methology using:
* [Brazilian e‑commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data)
* [dbt](https://www.getdbt.com/)
* [Rill](https://www.rilldata.com/)
* [duckdb](https://duckdb.org/)


## Prerequisites

- Python 3.13
- [uv](https://docs.astral.sh/uv/getting-started/installation/)
- [Rill](https://docs.rilldata.com/home/install)

## Installation

1. Clone the repository and navigate into it:
   ```bash
   git clone https://github.com/Hoanglinh1201/unified-star-schema-demo.git
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
