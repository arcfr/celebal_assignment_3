# Celebal Assignment 3 – SQL Subqueries,CTE and Window Functions

Overview
Performed SQL operations as stated on the LMS portal using a Superstore dataset, including data exploration, using subqueries, aggregation, window functions and CTEs
Dataset
- `data/SampleSuperstore.csv` – raw dataset used for loading into the database.

File Structure
- `data/` – dataset files  
- `sql-scripts/` – SQL scripts for setup, insertion, and analysis  
- `python-scripts/` – script to load CSV data into database  

## Steps Performed

1. Database Setup
   - Created schema and tables structure using `setup.sql`

2. Data Loading
   - Inserted dataset into database using `insert_data.sql`
   - Automated csv loading into the initial database table named "superstore_raw" using `load_data.py`

3. Data Analysis
- This Can be found in `operations.sql`
- Inspected table schema and validated imported records
- Applied SQL subqueries for:
  - Above-average sales filtering
  - Highest-value order per customer
- Used Common Table Expressions (CTEs) to:
  - Compute total sales per customer
  - Reuse aggregated customer sales data
- Applied Window Functions for ranking and analysis:
  - `RANK()` for customer sales ranking
  - `ROW_NUMBER()` for ordered analysis
- Combined `JOIN + CTE + Window Functions` to generate:
  - Customer name
  - Total sales
  - Customer rank
- Solved business queries including:
  - Top customers by sales
  - Lowest spending customers
  - Single-order customers
  - Customers with above-average sales
- Created reusable sales summaries using SQL Views
- Performed data validation and duplicate handling during table population

8. **Data Validation**
   - Verified row counts
   - Checked data consistency and quality

By
Archit Sahay
