# Zepto_Inventory_SQL_Analysis
End-to-end SQL Data Analysis of Zepto E-commerce Inventory data using PostgreSQL on pgAdmin 4.

## Dataset Overview
The dataset was sourced from Kaggle and was originally scraped from Zepto’s official product listings. It mimics what you’d typically encounter in a real-world e-commerce inventory system.

Each row represents a unique SKU (Stock Keeping Unit) for a product. Duplicate product names exist because the same product may appear multiple times in different package sizes, weights, discounts, or categories to improve visibility – exactly how real catalog data looks.

### Columns
- sku_id: Unique identifier for each product entry (Synthetic Primary Key)
- name: Product name as it appears on the app
- category: Product category like Fruits, Snacks, Beverages, etc.
- mrp: Maximum Retail Price (originally in paise, converted to Rupee)
- discountPercent: Discount applied on MRP
- discountedSellingPrice: Final price after discount (also converted to ₹)
- availableQuantity: Units available in inventory
- weightInGms: Product weight in grams
- outOfStock: Boolean flag indicating stock availability
- quantity: Number of units per package (mixed with grams for loose produce)

## Project Workflow
1. Database & Table creation - We start by creating a SQL table with appropriate data types:
```sql
drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
Category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);
```
2. Data Import
- Loaded CSV using pgAdmin's import feature.
- If you're not able to use the import feature, write this code instead:
```sql
\copy public.zepto(category, name, mrp, discountpercent, availablequantity,
discountedsellingprice, weightingms, outofstock, quantity)
FROM 'C:/Users/USER/Desktop/DATA-A/1/ZEPTO~1/zepto_v2.csv'
WITH (
  FORMAT csv,
  HEADER,
  DELIMITER E'\t',
  ENCODING 'UTF8',
  QUOTE '"'
);
```
- Faced encoding issues (UTF-8 error) which were fixed by saving the CSV file using CSV UTF-8 format.
3. Data Exploration
- Counted the total number of records in the dataset
- Viewed a sample of the dataset to understand structure and content
- Checked for null values across all columns
- Identified distinct product categories available in the dataset
- Compared in-stock vs out-of-stock product counts
- Detected products present multiple times, representing different SKUs
4. Data Cleaning
- Identified and removed rows where MRP or discounted selling price was zero
- Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability
5. Business Insights
- Found top 10 best-value products based on discount percentage
- Identified high-MRP products that are currently out of stock
- Estimated potential revenue for each product category
- Filtered expensive products (MRP > 500) with minimal discount
- Ranked top 5 categories offering highest average discounts
- Calculated price per gram to identify value-for-money products
- Grouped products based on weight into Low, Medium, and Bulk categories
- Measured total inventory weight per product category

## How to use this repo
1. Clone the repository
```bash
git clone https://github.com/Peterkinywa/Zepto_Inventory_SQL_Analysis.git
cd Zepto_Inventory_SQL_Analysis
```
2. Open zepto_SQL_data_analysis.sql
This file contains:
- Table creation
- Data exploration
- Data cleaning
- SQL Business analysis
3. Load the dataset into pgAdmin or any other PostgreSQL client
- Create a database and run the SQL file
- Import the dataset (convert to UTF-8 if necessary)

## Author
Peter Kinywa Mutua, Data Analyst

## License
Feel free to fork, star and use in your portfolio.

![License](https://img.shields.io/badge/License-Internal-orange)

