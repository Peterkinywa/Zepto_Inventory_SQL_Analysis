# Zepto_Inventory_SQL_Analysis
End-to-end SQL Data Analysis of Zepto E-commerce Inventory data using PostgreSQL.

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
