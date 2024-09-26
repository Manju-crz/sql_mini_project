use sql12732768;

select * from customers;
select * from brands;

show tables;

DESCRIBE brands;
DESCRIBE categories;
DESCRIBE customers;
DESCRIBE order_items; -- QUANTITY, LIST_PRICE, DISCOUNT
DESCRIBE orders;
SELECT distinct order_status FROM orders;
DESCRIBE products;
DESCRIBE staffs;
DESCRIBE stocks; -- QUANTITY
DESCRIBE stores;

show columns from stores;

SELECT * FROM brands;

SELECT * FROM order_items;

/*
count, sum, average, minimum, and maximum for numerical columns.
	Example: Calculate the total sales, average order value, and total number of transactions.
*/
SELECT SUM(list_price), MAX(list_price),MIN(list_price),AVG(list_price) FROM order_items;
SELECT SUM(QUANTITY), MAX(QUANTITY),MIN(QUANTITY),AVG(QUANTITY) FROM order_items;
SELECT COUNT(*) FROM order_items;
SELECT * FROM order_items;

SELECT SUM(QUANTITY), MAX(QUANTITY),MIN(QUANTITY),AVG(QUANTITY) FROM stocks;
SELECT COUNT(*) FROM stocks;
SELECT * FROM stocks;

/*
o	Data Cleaning:
	Write queries to identify and handle missing or inconsistent data.
	Example: Find rows with NULL values in important columns and decide how to handle them (e.g., filling, removing).

*/

SELECT count(*) FROM customers where phone is null;
SELECT count(*) FROM staffs where phone is null;
SELECT count(*) FROM orders where shipped_date is null;