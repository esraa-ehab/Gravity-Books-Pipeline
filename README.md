# Gravity Books Data Warehouse (ETL)

This project builds a **star schema data warehouse** for the Gravity Books dataset using an **ETL process**.

It was implemented using **two approaches**:

1. **SQL scripts**
2. **SSIS package**

## Project Goal

Take transactional bookstore data from `gravity_books` and load it into `gravity_books_dwh` in analytics-friendly star schema form.

## Data Model (Star Schema)

- **Fact table**: `Sales_fact`
- **Dimension tables**:
  - `Address_dim`
  - `Book_dim`
  - `Customer_dim`
  - `Date_dim`
  - `Order_status_dim`
  - `Shipping_method_dim`

Model files:
- Draw.io source: `Data_Model_Diagram/data_model.drawio`
- PNG preview: `Data_Model_Diagram/Gravity_Books_dm.png`

![Star Schema](Data_Model_Diagram/Gravity_Books_dm.png)

## Repository Structure

- `Data/` → source backup (`gravity_books.bak`)
- `SQL/` → SQL-based ETL implementation
  - `schema/`
  - `stage_layer/`
  - `load_layer/`
- `SSIS/` → SSIS-based ETL implementation
- `assets/screenshots/` → ETL and output screenshots

## Approach 1: SQL Scripts

The SQL implementation follows a classic ETL sequence:

- **Schema creation**
  - Creates all dimension and fact tables in the warehouse.
  - Defines keys and relationships needed for star schema analytics.

- **Staging layer**
  - Extracts source records into staging tables.
  - Separates raw ingestion from final warehouse loading.

- **Dimension loading**
  - Transforms and loads descriptive entities (books, customers, dates, addresses, shipping methods, order status).
  - Prepares clean lookup dimensions for fact loading.

- **Fact loading**
  - Loads transaction-level sales records into `Sales_fact`.
  - Resolves dimension keys and computes core business metrics like `total_sales`.

## Approach 2: SSIS

SSIS implementation is under `SSIS/GravityBooks_ETL/`.

Main package:
- `SSIS/GravityBooks_ETL/Package.dtsx`

## ETL Screenshots

### Control Flow
![Control flow](assets/screenshots/Control%20flow.jpeg)

### Fact Load (Lookups)
![Fact Load](assets/screenshots/Fact_Load_Lookups.jpeg)


## Quick Start

1. Restore `Data/gravity_books.bak`.
2. Create/use database `gravity_books_dwh`.
3. Run SQL approach from `SQL/` **or** run SSIS package from `SSIS/`.