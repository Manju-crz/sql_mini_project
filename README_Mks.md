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
    - To run from your local/azure database server:
        Open the queries file 'file_to_run' and do run all
    - You may also utilize the app.hex platform to run the queries by connecting to Azure database.
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