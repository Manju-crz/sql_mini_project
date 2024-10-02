/*
--------------------------------------------------------------------
Name   : BikeStores
Link   : https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database/data
Version: 1.0

workbench connection 

host: group3.mysql.database.azure.com
user : group3
port: 3306
pass : SQLgroup3project

options flag: 
OPT_LOCAL_INFILE=1
--------------------------------------------------------------------
*/
-- use schemas
use bikestore;

-- load data for categories
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/categories.csv'
    INTO TABLE categories FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for brands
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/brands.csv'
    INTO TABLE brands FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for products
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/products.csv'
    INTO TABLE products FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for customers
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/customers.csv'
    INTO TABLE customers FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for stores
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/stores.csv'
    INTO TABLE stores FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for staffs
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/staffs.csv'
    INTO TABLE staffs FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for orders
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/orders.csv'
    INTO TABLE orders FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for order_items
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/order_items.csv'
    INTO TABLE order_items FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for stocks
LOAD DATA LOCAL INFILE '/Users/abhijithdasharathi/study/Mtech/SQL/sql_project/BikeStores/stocks.csv'
    INTO TABLE stocks FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;