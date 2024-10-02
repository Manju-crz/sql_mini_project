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

### 3. Load the schema files into the workbench
    - Open the database connection and Import the schema files into your workbench

### 4. Load the schema files into the workbench
    - Copy the location of the directory 'SQL_Mini_Project' (Make sure the path is pointing to csv files)
    - Open the file 'BikeStores-load_data', and replace all the text 'CSV_FILES_PATH' to copied path (eg- C:\\DATA\\VS_Code_Notes\\SQL_Mini_Project) Note- You may have to use single forward slash in case of mac

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

# ER Diagram for BikeStores

## Entities and Attributes

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

## Relationships

- **Products** are associated with **Brands** and **Categories**.
- **Customers** place **Orders**.
- **Orders** contain **Order Items**.
- **Order Items** refer to **Products**.
- **Orders** are handled by **Staffs** and belong to **Stores**.
- **Staffs** work at **Stores** and may manage other **Staffs**.
- **Stocks** track **Products** in **Stores**.

## Example of Relationships:

- A `Customer` places an `Order`, which contains multiple `Order Items`. Each `Order Item` refers to a specific `Product`. 
- Each `Product` belongs to a `Brand` and a `Category`.
- `Staff` members manage `Orders` and work at a `Store`.
- `Stores` stock `Products`, and the `Stocks` entity tracks their quantities.
