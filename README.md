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

