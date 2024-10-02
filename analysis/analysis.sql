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

/*
--------------------------------------------------------------------
The first 5 rows of all tables

Lists of Tables and their Fields

brands [brand_id, brand_name]

categories [category_id, category_name]

customers [customer_id, first_name, last_name, phone, email, street, city, state, zip_code]

order_items [order_id, item_id, product_id, quantity, list_price, discount]

orders [order_id, customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id]

products [product_id, product_name, brand_id, category_id, model_year, list_price]

staffs [staff_id, first_name, last_name, email, phone, active, store_id, manager_id]

stocks [store_id, product_id, quantity]

stores [store_id, store_name, phone, email, street, city, state, zip_code]
--------------------------------------------------------------------
*/

SELECT *
FROM brands
LIMIT 5;

SELECT *
FROM categories
LIMIT 5;

SELECT *
FROM customers
LIMIT 5;

SELECT *
FROM order_items
LIMIT 5;

SELECT *
FROM orders
LIMIT 5;

SELECT *
FROM products
LIMIT 5;

SELECT *
FROM staffs
LIMIT 5;

SELECT *
FROM stocks
LIMIT 5;

SELECT *
FROM stores
LIMIT 5;

/*
--------------------------------------------------------------------
List all products: Write a query to retrieve all product names and their corresponding brand names.
Find active staff: Write a query to find all active staff members and their store names.
Customer details: Write a query to list all customers with their full names, email, and phone number.
Product categories: Write a query to count the number of products in each category.
Orders by customer: Write a query to list the total number of orders placed by each customer in descending order.
--------------------------------------------------------------------
*/

SELECT p.product_name, b.brand_name
FROM products as p
join brands as b
on p.brand_id = b.brand_id;

SELECT sta.first_name, sta.last_name, sta.active as staff_status, sto.store_name
FROM staffs as sta
JOIN stores as sto
    ON sta.store_id = sto.store_id 
WHERE sta.active = 1;

SELECT first_name, last_name, email, phone
FROM customers;

SELECT c.category_name as category_name, COUNT(1) as num_product
FROM categories as c
JOIN products as p
    ON p.category_id = c.category_id 
GROUP BY category_name;

SELECT  c.customer_id, concat_ws(' ',c.first_name,c.last_name) AS customer_name, COUNT(1) as num_orders
FROM customers as c
INNER JOIN orders as o
    ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY 3 DESC;

/*
--------------------------------------------------------------------
Total sales per product: Write a query to calculate the total sales amount for each product (considering quantity, list price, and discount).
Orders by status: Write a query to count the number of orders for each order status.
Customer orders: Write a query to list all customers who have placed at least one order, including their full name and total number of orders.
Stock availability: Write a query to find the total quantity of each product available in all stores.
Revenue by store: Write a query to calculate the total revenue generated by each store.
--------------------------------------------------------------------
*/

with total_revenue AS
             (SELECT oi.order_id,  
                     ot.store_id,
					 product_name,
                     s.store_name,
                     ot.order_date, 
                     oi.product_id,
                     oi.quantity as unit_sold, 
                     oi.list_price, 
                     oi.discount, 
                    ((oi.quantity * oi.list_price) * (1-oi.discount)) AS total_sale_product
              FROM order_items as oi
              JOIN products as p
			  ON oi.product_id = p.product_id
              LEFT JOIN orders as ot
              ON oi.order_id = ot.order_id 
              LEFT JOIN stores as s
              ON ot.store_id = s.store_id) 
              
              
        SELECT product_name, 
               SUM(total_sale_product) as revenue,
               ROUND((SUM(total_sale_product) / ((SELECT SUM(total_sale_product) FROM total_revenue))*100),2) as percentage
        FROM total_revenue
        GROUP BY product_id
        ORDER BY revenue DESC;
        
SELECT  order_status, COUNT(1) as num_orders
FROM orders 
GROUP BY order_status;

SELECT c.customer_id, concat_ws(' ',c.first_name,c.last_name) as full_name, COUNT(1) as num_order 
FROM customers as c
JOIN orders as o
    ON c.customer_id = o.customer_id 
GROUP BY c.customer_id
ORDER BY num_order DESC, c.customer_id;

SELECT 
    s.product_id, 
    p.product_name, 
    SUM(s.quantity) as total_q_in_all_stores
FROM stocks as s
    INNER JOIN products as p
    ON p.product_id = s.product_id
GROUP BY s.product_id;

with total_revenue AS
             (SELECT oi.order_id,  
                     ot.store_id,
                     s.store_name,
                     s.state,
                     ot.order_date, 
                     oi.product_id,
                     oi.quantity, 
                     oi.list_price, 
                     oi.discount, 
                    ((oi.quantity * oi.list_price) * (1-oi.discount)) AS total_sale_product
              FROM order_items as oi
              LEFT JOIN orders as ot
              ON oi.order_id = ot.order_id 
              LEFT JOIN stores as s
              ON ot.store_id = s.store_id) 
              
              
        SELECT store_id,
               store_name,
               state,
               SUM(total_sale_product) as revenue,
               ROUND((SUM(total_sale_product) / ((SELECT SUM(total_sale_product) FROM total_revenue))*100),2) as percentage
        FROM total_revenue
        GROUP BY store_id
        ORDER BY revenue DESC;
        
/*
--------------------------------------------------------------------
Monthly sales analysis: Write a query to calculate the total sales amount for each month.
Top customers: Write a query to find the top 5 customers who have spent the most money.
Employee hierarchy: Write a query to list all staff members along with their managers' names.
Product performance: Write a query to determine which products have the highest sales volume in the current year.
Customer location analysis: Write a query to aggregate the total sales, average order value, and maximum order value for customers in each city and state.

Order fulfillment: Write a query to find the average number of days taken to ship orders after the required date.
Customer order patterns: Write a query to identify customers who placed orders in each month for the last six months.
Store stock levels: Write a query to find stores that have stock levels below a certain threshold for any product.
Sales growth: Write a query to calculate the month-over-month sales growth for the past year.
--------------------------------------------------------------------
*/

SELECT
    YEAR(o.order_date)as year_value,
    MONTHNAME(o.order_date) as month_name,
    SUM(oi.quantity) as unit_sold
FROM orders o
    INNER JOIN
    order_items oi
        ON o.order_id = oi.order_id
GROUP BY year_value,month_name;

SELECT 
    c.customer_id, 
    concat_ws(" ",first_name,last_name) as customer_name,
    SUM(SUM((oi.list_price * (1 - discount))*quantity)) OVER (PARTITION BY c.customer_id)  AS total_spending
FROM
    customers c
INNER JOIN
    orders o
    ON o.customer_id = c.customer_id
INNER JOIN
    order_items oi
    ON oi.order_id = o.order_id 
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 5;

SELECT 
    s1.staff_id AS staff_id, 
    concat_ws(" ",s1.first_name,s1.last_name) AS staff_name,
    concat_ws(" ",s2.first_name, s2.last_name) AS manager_name
FROM 
    staffs s1
LEFT JOIN 
    staffs s2 
ON 
    s1.manager_id = s2.staff_id
ORDER BY 
    s1.staff_id;

SELECT 
        oi.product_id,
        year(o.order_date) as order_year,
        product_name,
        SUM(oi.quantity) as total_unit_sold
    FROM 
        order_items as oi
        JOIN products as p
            ON oi.product_id = p.product_id
        INNER JOIN orders o
    WHERE YEAR(o.order_date) = '2018'
    GROUP BY product_id,order_year
    ORDER BY total_unit_sold DESC;
    
SELECT 
    c.city, 
    c.state, 
    COUNT(c.customer_id) AS customer_count,
    SUM(quantity * oi.list_price * (1 - oi.discount)) AS total_sales,
    AVG(quantity * oi.list_price * (1 - oi.discount)) AS average_order_value,
    MAX(quantity * oi.list_price * (1 - oi.discount)) AS max_order_value
FROM 
    customers c
JOIN 
    orders o 
    ON c.customer_id = o.customer_id
JOIN
    order_items oi 
    ON o.order_id = oi.order_id
GROUP BY city,state
ORDER BY total_sales DESC;


SELECT 
    avg(datediff(shipped_date,required_date)) avg_delay
FROM orders;

/*
If we look at the previous monthly sales analysis , we may identify a problem of customer order patterns after June 2018. Therefore, we need to investigate this issue.

First, we want to write a query to identify customers who placed orders in each month for the last six months.
*/

SELECT
    year(o.order_date) as year,
    month(o.order_date) as month,
    c.customer_id
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
WHERE 
    year(o.order_date) = 2018 AND
    month(o.order_date) >= 6
ORDER BY 2 ASC, 3 ASC;



WITH customer_stats AS (
    SELECT
        customer_id,
        SUM(quantity * list_price * (1 - discount)) AS total_spending,
        COUNT(DISTINCT o.order_id) AS total_orders,
        to_days('2018-12-31') - to_days(MAX(order_date)) AS days_since_last_purchase
    FROM
        orders o
    INNER JOIN
        order_items oi
    ON
        o.order_id = oi.order_id
    GROUP BY
        1
)

SELECT
    customer_id,
    CASE WHEN total_orders > 1 THEN 'repeat buyer'
         ELSE 'one-time buyer'
         END AS purchase_frequency,
    CASE WHEN days_since_last_purchase < 360 THEN 'recent buyer'
         ELSE 'not recent buyer'
         END AS purchase_recency,
    CASE WHEN total_spending/(SELECT MAX(total_spending) FROM customer_stats) >= .65 THEN 'big spender'
         WHEN total_spending/(SELECT MAX(total_spending) FROM customer_stats) <= .30 THEN 'low spender'
         ELSE 'average spender' 
         END AS buying_power
FROM
    customer_stats;
  
/*
From the query above, we can say the data after May 2018 is messed up.
We just then use the data from 2016 andd 2017 to make the calculations.
*/
SELECT
    year(order_date) as year,
    monthname(order_date) as month,
    SUM(quantity) as unit_sold,
    SUM(quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM orders o
    INNER JOIN
    order_items oi
        ON o.order_id = oi.order_id
GROUP BY 1,2;

WITH sales_data AS (
    SELECT
        year(o.order_date) as year,
        monthname(o.order_date) as month,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as sales_amount,
        LAG(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 1) OVER (ORDER BY monthname(o.order_date)) AS prev_sales_amount
    FROM
        orders o
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    WHERE year(o.order_date) = 2016
    
    GROUP BY
        year,month
)

SELECT
    month,
    year,
    sales_amount,
    prev_sales_amount,
    CASE
        WHEN prev_sales_amount IS NULL THEN NULL  -- Handle the first month case
        ELSE (1.0 * (sales_amount - prev_sales_amount) / prev_sales_amount) * 100.0
    END AS sales_growth_percent
FROM
    sales_data
GROUP BY year,month
ORDER BY
    month;
    
WITH sales_data AS (
    SELECT
        year(o.order_date) as year,
        monthname(o.order_date) as month,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as sales_amount,
        LAG(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 1) OVER (ORDER BY monthname(o.order_date)) AS prev_sales_amount
    FROM
        orders o
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    WHERE year(o.order_date) = 2017
    
    GROUP BY
        year,month
)

SELECT
    month,
    year,
    sales_amount,
    prev_sales_amount,
    CASE
        WHEN prev_sales_amount IS NULL THEN NULL  -- Handle the first month case
        ELSE (1.0 * (sales_amount - prev_sales_amount) / prev_sales_amount) * 100.0
    END AS sales_growth_percent
FROM
    sales_data
GROUP BY year,month
ORDER BY
    month;
/*
We can see some similarities from the result:

April and July should be when downfall of sales happened
Around May and June AND August and September, the sales would rise again. This rise can either become the peak sales of the year.
*/

/*
Which products is the most profitable?
Which products should be kept available because they are profitable?
Which products should be kept available because they are popular?
To identify the most profitable products, first we need to investigate the mean, median, and the skewness of the price range among the products.
*/
    
SELECT 
        oi.product_id,
        product_name,
        oi.list_price
    FROM 
        order_items as oi
        JOIN products as p
            ON oi.product_id = p.product_id
    GROUP BY oi.product_id,product_name,oi.list_price
    ORDER BY oi.list_price DESC;

SELECT 
        oi.product_id,
        product_name,
        p.brand_id,
        SUM(quantity) as unit_sold,
        oi.list_price,
        discount,
        oi.list_price * (1 - discount) AS discounted_price,
        SUM(SUM((oi.list_price * (1 - discount))*quantity)) OVER (PARTITION BY oi.product_id)  AS total_sales_per_product
    FROM 
        order_items as oi
        JOIN products as p
            ON oi.product_id = p.product_id
    GROUP BY oi.product_id,oi.list_price,discount
    ORDER BY 8 DESC, 5 DESC
    LIMIT 15;

/*
Surprisingly, our biggest profits come from expensive (Q3) and luxury bikes (outliers).

Let's make these bikes our TOP PRIORITY and ensure we keep them well-stocked to maximize our profits!
*/

WITH most_profitable AS(
    SELECT 
        oi.product_id,
        product_name,
        p.brand_id,
        SUM(quantity) as unit_sold,
        oi.list_price,
        discount,
        oi.list_price * (1 - discount) AS discounted_price,
        SUM(SUM((oi.list_price * (1 - discount))*quantity)) OVER (PARTITION BY oi.product_id)  AS total_sales_per_product
    FROM 
        order_items as oi
        JOIN products as p
            ON oi.product_id = p.product_id
    GROUP BY oi.product_id,oi.list_price,discount
    ORDER BY 8 DESC, 5 DESC
    LIMIT 15)
    SELECT 
        product_name, 
        b.brand_name
    FROM most_profitable
    JOIN brands b
        ON b.brand_id = most_profitable.brand_id;

SELECT 
        oi.product_id,
        product_name,
        SUM(quantity) as unit_sold,
        oi.list_price,
        discount,
        oi.list_price * (1 - discount) AS discounted_price,
        SUM(SUM((oi.list_price * (1 - discount))*quantity)) OVER (PARTITION BY oi.product_id)  AS total_sales_per_product
    FROM 
        order_items as oi
        JOIN products as p
            ON oi.product_id = p.product_id
    GROUP BY oi.product_id,oi.list_price,discount
    HAVING SUM(quantity) > 50
    ORDER BY 3 DESC;
    /*
    Although most products sell under 30 units, some exceed 100 units. These higher-selling items are priced under $1,000. Despite their lower profitability, we should keep these popular items in stock to meet demand and drive sales!
    
    Conclusion
	TOP PRIORITY products should be the most profitable and popular ones, such as Trek Slash 8 27.5 - 2016
	SECOND PRIORITY products should be the most popular ones, such as Surly Ice Cream Truck Frameset - 2016
    */