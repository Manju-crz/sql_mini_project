# 📊 BIKE STORE DATA ANALYSIS 🎹

**MYSQL for Data Science Mini Project**

    To understand the dataset, uncover underlying patterns, and generate insights that could guide further analysis or decision-making.
        - Select a dataset
        - Perform data cleaning 
        - Pre-processing, 
        - Conduct data analysis
        - Present the findings


By,
* **Abhijith S D**
* **Arvind C R**
* **Ayyasamy S**
* **Gurumurthy Kalyanpur Viswanathaiah**
* **Manjunath**


## Requirements
    - MYSQL Database Server
    - Client Workbench - MySQL WorkBench
    - Azure Databse Connection (to access online setup databse)
        Connection name: group3.mysql.database.azure.com
        Host: group3.mysql.database.azure.com
        port : 3306
        user : group3
        password : SQLgroup3project


## Getting Started

Follow these below steps to run the queries:

### 1. Download the schemas / data set.
    - Need to unzip the submitted 'SQL_Mini_Project', and store it into your preferred local directory.
        Unzipped directory contains the queries schema files and data set related csv files along with reference documents.
        Note : Instead, you may also download the data set CSV files from the kaggle link - https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database/data
    - Currently we have the data from 2016 to 2018 in this data set

### 2. Connect to the server
        Before opening the database connection, you would be required to edit the connection from settings:
        Goto advanced tab, append the setting on Others tab like: OPT_LOCAL_INFILE=1
    - Local database connection:
        To use the local database, by default you would be having your local server connection existing. You may utilize the same.
    - Azure database connection:
        : To use the azure online database, You may refer to the abive given Azure database server details and connect

        Azure Database Connection refers to the process of connecting applications to Azure's various database services, such as Azure SQL Database, Azure Cosmos DB, Azure Database for MySQL, and Azure Database for PostgreSQL. Azure provides scalable, secure, and managed database solutions that are ideal for cloud applications.
            Key Components:
                Connection Strings: A connection string is a string used to establish a connection to a database. It contains necessary parameters like the server name, database name, user credentials, and more.
                Authentication: Azure supports various authentication methods, including SQL authentication (username and password) and Azure Active Directory authentication, which enhances security and allows for centralized user management.
                Firewall Rules: To enhance security, Azure databases come with built-in firewall rules that restrict access to specified IP addresses. Users must configure these rules to allow their applications to connect.
                Connection Pools: Azure databases support connection pooling, which helps improve performance by reusing existing connections instead of creating new ones for each database operation.
                Data Encryption: Azure provides features for data encryption both at rest and in transit to ensure data security.
                Benefits:
                Scalability: Easily scale your database resources based on application needs.
                Managed Services: Azure handles maintenance tasks like backups, updates, and monitoring.
                Global Availability: Access your databases from anywhere, with data replication options for high availability.

### 3. Load the schema files into the workbench
    - Open the database connection and Import the schema files into your workbench

### 4. Load the schema files into the workbench
    - Copy the location of the directory 'SQL_Mini_Project' (Make sure the path is pointing to csv files)
    - Open the file 'BikeStores-load_data', and replace all the text 'CSV_FILES_PATH' to copied path (eg- C:\\DATA\\VS_Code_Notes\\SQL_Mini_Project) Note- You may have to use single forward slash in case of mac

### 5. Run the queries:

    - Offline Execution: To run from your local/azure database server:
        Open the queries file 'file_to_run' and do run all

    - Online Execution: You may also utilize the app.hex platform to run the queries by connecting to Azure database.
        Hex is a collaborative data analysis platform designed to help teams explore, analyze, and visualize data seamlessly. It combines coding, documentation, and interactive data applications in one environment. Users can leverage SQL, Python, and other tools to perform data analysis while collaborating with team members in real-time.
            Key Features:
            Collaborative Environment: Multiple users can work together on data projects, sharing insights and findings.
            No-Code Options: For those less familiar with coding, Hex offers no-code tools to create visualizations and dashboards.
            Integrated Workflows: Combines data extraction, analysis, and reporting in a single platform.
            Custom Visualizations: Users can create interactive visualizations that can be shared or embedded.
            Version Control: Track changes and collaborate efficiently without losing previous work.
            Hex is aimed at data teams, analysts, and business intelligence professionals looking for a streamlined way to handle data-driven projects.
    - Navigate to the link - https://app.hex.tech/link/DJC9CVT2KuPJ_0KBg1I_gCCH
        Sign-In to the workspace (You may signup for the first time)
        Do run all to see the results


## Schema Overview

The **BikeStores** database contains information related to a bike store chain, including products, customers, orders, and staff.
The primary tables in the schema are:

- **Stores**: Information about store locations.
- **Staffs**: Details of staff members and their roles.
- **Brands**: Brands of the products sold.
- **Categories**: Categories of the products.
- **Products**: Detailed product information.
- **Stocks**: Inventory levels of products in stores.
- **Customers**: Customer information.
- **Orders**: Orders placed by customers.
- **Order Items**: Details of products within each order.

### Data Cleaning

    - Identified rows with `NULL` values in important columns such as `phone` in the `customers` and `staffs` tables.
    - Found missing `shipped_date` entries in the `orders` table, which could affect shipping time analyses.
    - Decided to retain these entries.


### Entities and Attributes

#### Brands
- `brand_id` (INT)
- `brand_name` (VARCHAR(255))

#### Categories
- `category_id` (INT)
- `category_name` (VARCHAR(255))

#### Customers
- `customer_id` (INT)
- `first_name` (VARCHAR(255))
- `last_name` (VARCHAR(255))
- `phone` (VARCHAR(25))
- `email` (VARCHAR(255))
- `street` (VARCHAR(255))
- `city` (VARCHAR(50))
- `state` (VARCHAR(25))
- `zip_code` (VARCHAR(5))

#### Order Items
- `order_id` (INT)
- `item_id` (INT)
- `product_id` (INT)
- `quantity` (INT)
- `list_price` (DECIMAL(10,2))
- `discount` (DECIMAL(4,2))

#### Orders
- `order_id` (INT)
- `customer_id` (INT)
- `order_status` (TINYINT)
- `order_date` (DATE)
- `required_date` (DATE)
- `shipped_date` (DATE)
- `store_id` (INT)
- `staff_id` (INT)

#### Products
- `product_id` (INT)
- `product_name` (VARCHAR(255))
- `brand_id` (INT)
- `category_id` (INT)
- `model_year` (SMALLINT)
- `list_price` (DECIMAL(10,2))

#### Staffs
- `staff_id` (INT)
- `first_name` (VARCHAR(50))
- `last_name` (VARCHAR(50))
- `email` (VARCHAR(255))
- `phone` (VARCHAR(25))
- `active` (TINYINT)
- `store_id` (INT)
- `manager_id` (INT)

#### Stocks
- `store_id` (INT)
- `product_id` (INT)
- `quantity` (INT)

#### Stores
- `store_id` (INT)
- `store_name` (VARCHAR(255))
- `phone` (VARCHAR(25))
- `email` (VARCHAR(255))
- `street` (VARCHAR(255))
- `city` (VARCHAR(255))
- `state` (VARCHAR(10))
- `zip_code` (VARCHAR(5))


### Relationships

- **Products** are associated with **Brands** and **Categories**.
- **Customers** place **Orders**.
- **Orders** contain **Order Items**.
- **Order Items** refer to **Products**.
- **Orders** are handled by **Staffs** and belong to **Stores**.
- **Staffs** work at **Stores** and may manage other **Staffs**.
- **Stocks** track **Products** in **Stores**.


##### Example of Relationships:

- A `Customer` places an `Order`, which contains multiple `Order Items`. Each `Order Item` refers to a specific `Product`. 
- Each `Product` belongs to a `Brand` and a `Category`.
- `Staff` members manage `Orders` and work at a `Store`.
- `Stores` stock `Products`, and the `Stocks` entity tracks their quantities.


## Database Folders and SQL scripts description:


### online-database-setup/local-database-setup - Folder

#### BikeStores-create_objects.sql
	- sql script to create all tables and with required attributes
	- created tables brands,categories,customers,order_items,orders,products,staffs and stocks
	- taken care of types like INT, VARCHAR, TINYINT,DATE, etc,.. 
	- Keys also allocated for each table of attributes like primary key, foriegn keys etc...

#### BikeStores-drop_all_objects.sql
	- used to drop the existing tables from database if we want to create newly
	
#### BikeStores-load_data.sql
	- Update all records to respective tables in a schema
	- #explicit for local loading of databases
		-- setting local infile true in script
				SET GLOBAL local_infile=1;
		-- Add "OPT_LOCAL_INFILE=1"  in SQL work bench application under " connection -->advanced --> others" tab.
		

### Data - Folder

#### brands.csv 	
	- contains data related to the brands available in the bike store. It includes two attributes: 'brand id' and 'brand name'
	- brand_id: This is a unique identifier for each brand. It is typically an integer value that serves as the primary key for the brand.
	- brand_name: This is the name of the brand. It is a string value that provides a human-readable name for the brand.

#### categories.csv 
	- Contains 'category_id' and 'category_name' as atrributes, 
	- In the context of a bike store database, this CSV file could be used to populate a Categories table
	- 'category_id' : A unique identifier for each category,Serves as the primary key in the categories table, ensuring each category can be distinctly referenced.
	- 'category_name' : The name of the category (e.g., "Mountain Bikes", "Road Bikes", "Hybrid Bikes") which is of type charecter.
				
#### customers.csv 
	- contains data related to the customers of the bike store. It includes multiple attributes
	- customer_id: A unique identifier for each customer, usually an integer
	- first_name/last_name: The first name of the customer / The last name of the customer
	- email/phone/street/city/state/zip_code: provide details of the each customer

#### order_items.csv 
	- contains data related to the items included in each order placed at the bike store and includes several attributes
	- This file is essential for linking orders to specific products (in this case, bikes) and tracking details about each item in the order. 
	- Here are the key attributes that you might expect in an order_item.csv
	- order_id,item_id,product_id,quantity,list_price and discount

#### orders.csv 
	- contains data related to the total orders placed at the bike store.It is essential for tracking the overall order details placed by customers
	- order_id, customer_id, order_status, order_date, required_date,shipped_date, store_id and staff_id are the attributes
	- provides datewise information of the orders placed
    - ex: The current status of the order (e.g., Shipped, Pending, Delivered, Cancelled). here we have 4 as an indicator means order confirmed and shipped	   

#### products.csv 
	- contains data related to the products available at the bike store for sales. Essential for managing product details, inventory, and pricing	
	- product_id,product_name,brand_id,category_id, model_year and list_price are the attributes
	- These attributes facilitate comprehensive product management, allowing for effective inventory tracking, sales reporting, and customer service.
			 
#### staffs.csv 
	- contains information about the employees working at a bike store. This file is important for managing employee details, roles, and contact information.
	- staff_id,first_name,last_name,email,phone,active,store_id and manager_id are the attributes of this data file
	- 'staff_id' is the unique identifier for each staff member, usually an integer. Serves as the primary key for the staff table.
	- all other attributes provide a comprehensive overview of the staff, facilitating effective human resource management, communication, and operational efficiency.

#### stocks.csv 
	- likely contains data related to the stock levels of products at the bike store. It includes several attributes that provide detailed information about each stock entry
    - 'store_id' : represents a unique identifier for each store in a multi-store setup
	- 'product_id' : The unique identifier of the product. Acts as a foreign key linking to the Products table, identifying which product this stock record refers to.
	- 'quantity' : 	quantity of the product available in stock at the specified location
	
### analysis - Folder

#### analysis.sql
	- data analysis done on Bikestore databse from kaggle https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database/data
	- Data base connection details
		host: group3.mysql.database.azure.com
		user : group3
		port: 3306
		pass : NA
	- Listing out all Tables and their Fields
	- Descriptive statistics
		Calculate total sales revenue across all orders
		Calculate average order value
		Count total number of transactions
		Calculate average discount offered
		Count total number of unique customers
		Find minimum and maximum order values
		Calculate total sales by staff member
	- Data Cleaning
		Find phone numbers that do not match the standard format
		Identify potential duplicate customers based on name and email
		Update 'first_name' and 'last_name' fields to remove extra spaces
		cleaning null values for customers
	- Aggregation and Grouping
		find all active staff members and their store names
		list all customers with their full names, email, and phone number
		count the number of products in each category
		list the total number of orders placed by each customer in descending order
		list all customers who have placed at least one order, including their full name and total number of orders
        All the agregate functions have been utilized mostly in the queries
	- Joins and Relationships 
		find the top 5 customers who have spent the most money
		calculate the total sales amount for each product (considering quantity, list price, and discount)
	-	Subqueries and CTEs	
		count of orders associated to each order status
		Stock availability: find the total quantity of each product available in all stores
		Revenue by store:  calculate the total revenue generated by each store
		Monthly sales analysis: calculate the total sales amount for each month
	- Advanced SQL Functions:
        - Advanced SQL functions used in many below analysis like:
        - Top selling products and least selling products
        - On which product we have the most profit as a store
        -  Segment products into quartiles based on total sales
        - Date related functions used to summaries sales based on months and years etc, and customer order analysis.
        - Also in analysing the delays in the order fulfillments
        - In order to Predict future sales using LEAD()
            and many more queries have similar window functions alltogether.
		- OVER: keyword is used in conjunction with window functions. It defines a window or a set of rows that the function should operate on, allowing you to perform calculations across a specified range of rows related to the current row
        - The NTILE: function in SQL is a window function that divides a result set into a specified number of roughly equal parts, or "tiles." It assigns a bucket number (from 1 to the number of tiles specified) to each row based on the order of the rows in the partition.
        - The YEAR: function in SQL is used to extract the year from a date or datetime value. It returns the year as a four-digit integer, which can be useful for filtering, grouping, or performing calculations based on the year.
        - The MONTHNAME: function in SQL is used to retrieve the name of the month from a date or datetime value. It returns the full name of the month as a string, which can be useful for reporting, formatting dates, or grouping results based on month names.
        - The LEAD: function in SQL is a window function that provides access to the subsequent row in a result set without the need for a self-join. It allows you to retrieve data from a following row based on a specified order, making it useful for various analytical tasks, such as calculating differences between rows or comparing values
        - The COALESCE: function in SQL is used to return the first non-null value from a list of arguments. It's particularly useful for handling NULL values in your data, allowing you to provide default values or perform conditional logic.
        
### analysis_output_csv - folder

	- All analysis output will be stored in .csv format into  this folder
	- "sql 1_2024-10-02T1406"  will have date and the sequnce number in the order of execution 
	- Eample:
		sql 1_2024-10-02T1406.csv
		sql 3_2024-10-02T1406.csv
		sql 4_2024-10-02T1406.csv
		sql 5_2024-10-02T1406.csv
		sql 6_2024-10-02T1407.csv
	
### Bikestores_ER_ Diagram.sql 
	- Entity-Relationship (ER) diagram for the bike store, we need to identify the entities and their relationships based on the provided CSV files.
	
***Relationships:*** 
	- customers to orders: One-to-Many (One customer can place multiple orders).
	- orders to order_items: One-to-Many (One order can contain multiple order items).
	- order_items to products: Many-to-One (Many order items can reference the same products).
	- products to categories: Many-to-One (Many products can belong to one category).
	- products to stocks: One-to-many (Each product has a corresponding inventory record).
	- Staffs to stores: Many to one (working staffs associated with stores).

***### BikeStoresERDiagram.pdf***
	- Entity-Relationship (ER) diagram for the bike store in PDF format
	


## Acknowledgement :

- **MySQL Database Server**
We would like to acknowledge the use of MySQL Database Server, a powerful and widely-used relational database management system that provides an efficient and robust platform for managing and storing our data.
Its reliability and performance have greatly enhanced our application's data handling capabilities.

- **MySQL Workbench**
Special thanks to MySQL Workbench for providing an intuitive and comprehensive interface for database design, development, and administration. This client tool has significantly improved our workflow by simplifying database management tasks and facilitating efficient query execution.

- **Azure Database Connection**
We extend our gratitude to Azure for its cloud database solutions, which allow us to securely access and manage our online databases. The scalability and managed services offered by Azure have been instrumental in supporting our application's needs and ensuring high availability.

- **Hex Platform**
We would like to acknowledge the Hex platform for its innovative approach to collaborative data analysis. Hex has empowered our team to seamlessly explore, analyze, and visualize data in an integrated environment. Its combination of coding capabilities and no-code options has greatly enhanced our workflow, allowing for effective collaboration and insight sharing among team members. We appreciate the tools and features Hex provides, which have significantly contributed to the success of our data-driven projects.


## Contact Information
    - Abhijith S D  - (+91)-97314 14414 - abhinomega135@gmail.com
    - Arvind C R    - (+91)-94454 53443 - arvindcr4@gmail.com
    - Ayyasamy S    - (+91)-98860 01482 - samysubu12@gmail.com
    - Gurumurthy    - (+91)-99000 61441 - gurumurthy.kv@gmail.com
    - Manjunath     - (+91)-96118 84272 - manju.crz@gmail.com

