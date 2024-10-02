# 📊 BIKE STORE DATA ANALYSIS 🎹

**MYSQL for Data Science Mini Project**

    To understand the dataset, uncover underlying patterns, and generate insights that could guide further analysis or decision-making.
        - Select a dataset
        - Perform data cleaning 
        - Pre-processing, 
        - Conduct exploratory data analysis (EDA)
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

The **BikeStores** database contains information related to a bike store chain, including products, customers, orders, and staff. The primary tables in the schema are:

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

### ER Diagram for BikeStores

### Entities and Attributes

### Brands
- `brand_id` (INT)
- `brand_name` (VARCHAR(255))

### Categories
- `category_id` (INT)
- `category_name` (VARCHAR(255))

### Customers
- `customer_id` (INT)
- `first_name` (VARCHAR(255))
- `last_name` (VARCHAR(255))
- `phone` (VARCHAR(25))
- `email` (VARCHAR(255))
- `street` (VARCHAR(255))
- `city` (VARCHAR(50))
- `state` (VARCHAR(25))
- `zip_code` (VARCHAR(5))

### Order Items
- `order_id` (INT)
- `item_id` (INT)
- `product_id` (INT)
- `quantity` (INT)
- `list_price` (DECIMAL(10,2))
- `discount` (DECIMAL(4,2))

### Orders
- `order_id` (INT)
- `customer_id` (INT)
- `order_status` (TINYINT)
- `order_date` (DATE)
- `required_date` (DATE)
- `shipped_date` (DATE)
- `store_id` (INT)
- `staff_id` (INT)

### Products
- `product_id` (INT)
- `product_name` (VARCHAR(255))
- `brand_id` (INT)
- `category_id` (INT)
- `model_year` (SMALLINT)
- `list_price` (DECIMAL(10,2))

### Staffs
- `staff_id` (INT)
- `first_name` (VARCHAR(50))
- `last_name` (VARCHAR(50))
- `email` (VARCHAR(255))
- `phone` (VARCHAR(25))
- `active` (TINYINT)
- `store_id` (INT)
- `manager_id` (INT)

### Stocks
- `store_id` (INT)
- `product_id` (INT)
- `quantity` (INT)

### Stores
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


#### Example of Relationships:

- A `Customer` places an `Order`, which contains multiple `Order Items`. Each `Order Item` refers to a specific `Product`. 
- Each `Product` belongs to a `Brand` and a `Category`.
- `Staff` members manage `Orders` and work at a `Store`.
- `Stores` stock `Products`, and the `Stocks` entity tracks their quantities.



### Acknowledgement :

- **MySQL Database Server**
We would like to acknowledge the use of MySQL Database Server, a powerful and widely-used relational database management system that provides an efficient and robust platform for managing and storing our data. Its reliability and performance have greatly enhanced our application's data handling capabilities.

- **MySQL Workbench**
Special thanks to MySQL Workbench for providing an intuitive and comprehensive interface for database design, development, and administration. This client tool has significantly improved our workflow by simplifying database management tasks and facilitating efficient query execution.

- **Azure Database Connection**
We extend our gratitude to Azure for its cloud database solutions, which allow us to securely access and manage our online databases. The scalability and managed services offered by Azure have been instrumental in supporting our application's needs and ensuring high availability.



## Contact Information
    - Abhijith S D  - (+91)-97314 14414 - abhinomega135@gmail.com
    - Arvind C R    - (+91)-94454 53443 - arvindcr4@gmail.com
    - Ayyasamy S    - (+91)-98860 01482 - samysubu12@gmail.com
    - Gurumurthy    - (+91)-99000 61441 - gurumurthy.kv@gmail.com
    - Manjunath     - (+91)-96118 84272 - manju.crz@gmail.com

