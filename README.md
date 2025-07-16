# Walmart-Sales-Analysis

This project aims to deliver actionable business insights from Walmart sales data using a structured workflow that combines Python for data processing and MySQL for relational analytics. The goal is to assist stakeholders in making data-driven decisions related to product performance, customer behavior, and sales trends.

 Workflow Description
- Data Exploration and Cleaning (Jupyter Notebook + Pandas)
The project began in Jupyter Notebook, where raw sales data was imported and explored using Pandas. Key preprocessing tasks included:
- Handling missing values
- Converting data types for consistency
- Filtering out irrelevant records
- Normalizing fields for better readability
- Data Migration to MySQL
Once cleaned, the dataset was programmatically uploaded to a MySQL database using Python libraries such as mysql.connector and SQLAlchemy.
This step enabled efficient querying and structured data analysis on a scalable platform.

- Business Problem Solving in MySQL
A range of business-focused queries were executed on the MySQL platform to uncover insights such as:

| Business Problem | Strategic Purpose |
|-----|------------------|--------------------|
| 1 | Analyze Payment Methods and Sales | Understand customer preferences for payment methods, aiding in payment optimization strategies. |
| 2 | Identify the Highest-Rated Category in Each Branch | Promote popular categories in specific branches to enhance satisfaction and branch-specific marketing. |
| 3 | Determine the Busiest Day for Each Branch | Optimize staffing and inventory management to accommodate peak days. |
| 4 | Calculate Total Quantity Sold by Payment Method | Track sales volume by payment type to study purchasing habits. |
| 5 | Analyze Category Ratings by City | Guide city-level promotions based on regional preferences. |
| 6 | Calculate Total Profit by Category | Identify high-profit categories and refine pricing and expansion strategies. |
| 7 | Determine the Most Common Payment Method per Branch | Streamline payment processing by recognizing branch-specific preferences. |
| 8 | Analyze Sales Shifts Throughout the Day | Manage staff shifts and stock schedules during high-sales periods. |
| 9 | Identify Branches with Highest Revenue Decline YoY | Investigate local issues and strategize revenue recovery methods. |
| 10 | Track Monthly Sales Trends Across Branches | Plan for seasonal fluctuations with optimized staffing, inventory, and promotions. |
| 11 | Compare Average Transaction Value by Payment Method | Highlight payment types linked to larger purchases for loyalty incentives. |
| 12 | Determine Most Popular Item per Category | Spotlight bestsellers and inform inventory prioritization. |
| 13 | Evaluate Sales Performance by Hour | Target specific hours for discounts and refine shift planning. |
| 14 | Identify High-Revenue Categories by City | Align category-level investments with city-specific performance. |
| 15 | Analyze Customer Ratings by Gender | Tailor product offerings and marketing campaigns to gender-based preferences. |
