/*
--------------------------------------------------------------------
Name   : BikeStores
Link   : https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database/data
Version: 1.0
--------------------------------------------------------------------
*/
-- use schemas
use bikestore;

-- setting local infile true
SET GLOBAL local_infile=1;

-- load data for categories
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$categories.csv'
    INTO TABLE categories FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for brands
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$brands.csv'
    INTO TABLE brands FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for products
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$products.csv'
    INTO TABLE products FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for customers
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$customers.csv'
    INTO TABLE customers FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for stores
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$stores.csv'
    INTO TABLE stores FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for staffs
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$staffs.csv'
    INTO TABLE staffs FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for orders
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$orders.csv'
    INTO TABLE orders FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for order_items
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$order_items.csv'
    INTO TABLE order_items FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

-- load data for stocks
LOAD DATA LOCAL INFILE '$CSV_FILES_PATH$stocks.csv'
    INTO TABLE stocks FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;
            
               
-- setting local infile false
SET GLOBAL local_infile=0;