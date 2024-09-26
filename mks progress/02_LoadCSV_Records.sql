
/*
We have a text FOLDER_PATH in the bellow list of queries.
Replace the text FOLDER_PATH to copied upload directory's path.
Make sure to bring the path to string format, by appending second back slash, as shown below:
C:\\ProgramData\\MySQL\\MySQL Server 9.0\\Uploads\\
*/

LOAD DATA INFILE 'FOLDER_PATHcategories.csv'
INTO TABLE categories FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA INFILE 'FOLDER_PATHbrands.csv'
INTO TABLE brands FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;


LOAD DATA INFILE 'FOLDER_PATHproducts.csv'
INTO TABLE products FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA INFILE 'FOLDER_PATHcustomers.csv'
INTO TABLE customers FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA INFILE 'FOLDER_PATHstores.csv'
INTO TABLE stores FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA INFILE 'FOLDER_PATHstaffs.csv'
INTO TABLE staffs FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

ALTER TABLE orders
MODIFY order_date varchar(32) NULL, -- Error Code: 1292. Incorrect date value: '01-01-2016' for column 'order_date' at row 1	0.000 sec
MODIFY required_date varchar(32) NULL, -- Error Code: 1292. Incorrect date value: '03-01-2016' for column 'required_date' at row 1	0.000 sec
MODIFY shipped_date varchar(32) NULL; -- Error Code: 1292. Incorrect date value: '03-01-2016' for column 'shipped_date' at row 1	0.000 sec
LOAD DATA INFILE 'FOLDER_PATHorders.csv'
INTO TABLE orders FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA INFILE 'FOLDER_PATHorder_items.csv'
INTO TABLE order_items FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA INFILE 'FOLDER_PATHstocks.csv'
INTO TABLE stocks FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
