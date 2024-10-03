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

-- Calculate total sales revenue across all orders
SELECT 
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales_revenue
FROM 
    order_items oi;

-- insight: total sales is 7.68 million across all products 


-- Calculate average order value
SELECT 
    AVG(order_total) AS average_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS order_total
    FROM 
        orders o
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        o.order_id
) sub;
-- customers on average spend ~4761 dollars

-- Count total number of transactions
SELECT 
    COUNT(*) AS total_transactions
FROM 
    orders;

-- overall sales activity across all orders is 1615

-- Calculate average discount offered
SELECT
    AVG(oi.discount) AS average_discount
FROM
    order_items oi;

-- on average a high discount of 10% is given to orders implying high discounts offered to promote sales

-- Count total number of unique customers
SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM
    customers;

-- only 1445 unique customers, implying a tiny fraction of potential bicycle buyers purchasing at the store

-- Find minimum and maximum order values
SELECT
    MIN(order_total) AS minimum_order_value,
    MAX(order_total) AS maximum_order_value
FROM (
    SELECT 
        o.order_id,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS order_total
    FROM 
        orders o
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        o.order_id
) sub;

-- customers buy items value anywhere from 105 dollars to 29150 dollars

-- Calculate total sales by staff member
SELECT
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS staff_total_sales
FROM
    orders o
JOIN
    order_items oi ON o.order_id = oi.order_id
JOIN
    staffs s ON o.staff_id = s.staff_id
GROUP BY
    s.staff_id, staff_name
ORDER BY
    staff_total_sales DESC;

-- Staff can be incentivized or evaluated for performance based on the total sales numbers

-- Find phone numbers that do not match the standard format
SELECT
    staff_id,
    first_name,
    last_name,
    phone
FROM
    staffs
WHERE
    phone IS NOT NULL
    AND phone NOT REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$';
-- phone number data for staff is consistent in US format

-- Identify potential duplicate customers based on name and email
SELECT
    first_name,
    last_name,
    email,
    COUNT(*) AS occurrence
FROM
    customers
GROUP BY
    first_name,
    last_name,
    email
HAVING
    COUNT(*) > 1;

-- there are no duplicate customers

-- Update 'first_name' and 'last_name' fields to remove extra spaces
UPDATE
    customers
SET
    first_name = TRIM(first_name),
    last_name = TRIM(last_name);
-- updated 1445 rows with trims

UPDATE 
    customers
SET
    phone='N/A'
WHERE
    TRIM(phone)='NULL' OR ISNULL(phone);

-- insight: cleaning null values for customers
-- updated 1267 rows

-- Find products with zero or negative stock quantities
SELECT
    store_id,
    product_id,
    quantity
FROM
    stocks
WHERE
    quantity <= 0;
-- If inventory is low, restock else if data entry error, identify and correct stock numbers
-- there are no negative numbers in stock

-- List all products: Write a query to retrieve all product names and their corresponding brand names.
SELECT p.product_name, b.brand_name
FROM products as p
join brands as b
on p.brand_id = b.brand_id;

SELECT
    b.brand_name,
    COUNT(p.product_id) AS product_count
FROM
    brands AS b
JOIN
    products AS p ON b.brand_id = p.brand_id
GROUP BY
    b.brand_id, b.brand_name
ORDER BY
    product_count DESC;

-- Insight: 'Trek' and 'Electra' brands have the highest number of products 
-- while Ritchey and Strider brands got least number of products, so may need to increase their offerings


-- Find active staff: Write a query to find all active staff members and their store names.
SELECT sta.first_name, sta.last_name, sta.active as staff_status, sto.store_name
FROM staffs as sta
JOIN stores as sto
    ON sta.store_id = sto.store_id 
WHERE sta.active = 1;

-- Insight: 

SELECT
    s.store_id,
    s.store_name,
    SUM(oi.quantity) AS total_units_sold,
    COUNT(DISTINCT(st.staff_id)) AS staff_count
FROM
    stores AS s
JOIN
    orders AS o ON s.store_id = o.store_id
JOIN
    order_items AS oi ON o.order_id = oi.order_id
JOIN staffs st on s.store_id = st.store_id
GROUP BY
    s.store_id,
    s.store_name
ORDER BY
    total_units_sold DESC;

    -- Baldwin Bikes has only 3 staff despite more units sold than 
    -- other stores, so they appear understaffed. For better resource
    -- allocation, we can increase staff count at baldwin

SELECT 
   count(*)
FROM 
    customers
WHERE 
  phone = 'null';

-- Insight so many null values for phone so use coalesce for phone wherever used.


-- Customer details: Write a query to list all customers with their full names, email, and phone number.
SELECT concat_ws(' ',first_name, last_name) as full_name, email, phone
FROM customers;
-- Insight: Only means of contacting customers for any offers/marketing purpose is through 
-- email considering the null data (1267 of 1445 records) in phone. Recommendation is to capture phone details from customers.

-- Product categories: Write a query to count the number of products in each category.
SELECT c.category_name as category_name, COUNT(1) as num_product
FROM categories as c
JOIN products as p
    ON p.category_id = c.category_id 
GROUP BY category_name;
-- Insight : Cruisers Bicycles and Mountain Bikes to be added more into stock considering more sales in these categories 

SELECT
    c.category_name,
    coalesce(SUM(oi.quantity),0) AS total_quantity_sold
FROM
    categories AS c
JOIN products AS p ON p.category_id = c.category_id
JOIN order_items AS oi ON oi.product_id = p.product_id
GROUP BY
    c.category_name;

-- Orders by customer: Write a query to list the total number of orders placed by each customer in descending order.
SELECT  c.customer_id, concat_ws(' ',c.first_name,c.last_name) AS customer_name, COUNT(1) as num_orders
FROM customers as c
INNER JOIN orders as o
    ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY 3 DESC;


-- Customer orders: Write a query to list all customers who have placed at least one order, including their full name and total number of orders.
SELECT c.customer_id, concat_ws(' ',c.first_name,c.last_name) as full_name, COUNT(1) as num_order 
FROM customers as c
JOIN orders as o
    ON c.customer_id = o.customer_id 
GROUP BY c.customer_id
ORDER BY num_order DESC, c.customer_id;


-- Top customers: Write a query to find the top 5 customers who have spent the most money.
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
-- insight: these are the biggest spenders who can be rewarded

-- Total sales per product: Write a query to calculate the total sales amount for each product (considering quantity, list price, and discount).

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
               SUM(unit_sold) AS total_sales_volume,
               ROUND(SUM(total_sale_product) / SUM(unit_sold), 2) AS revenue_per_item_sold,
               ROUND((SUM(total_sale_product) / ((SELECT SUM(total_sale_product) FROM total_revenue))*100),2) as percentage
        FROM total_revenue
        GROUP BY product_id
        ORDER BY total_sales_volume DESC;

-- Insight: Trek Slash 8 27.5 = 2016 has been the highest revenue generating model amongst others.
-- Insight: revenue is a factor of total_sales_volume as well as revenue_per_item


-- Check the total count of orders associated to each order status
SELECT order_status,
    CASE 
        WHEN order_status = 1 THEN 'Pending'
        WHEN order_status = 2 THEN 'Processing'
        WHEN order_status = 3 THEN 'Rejected'
        WHEN order_status = 4 THEN 'Completed'
        ELSE 'No_Track'
    END AS OrderStatus_Description,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status;
-- Insight: 3% rejections is area to improve for better customer experience.

WITH customer_stats AS (
    SELECT
        c.customer_id,
        concat_ws(" ",c.first_name,c.last_name) as customer_name,
        SUM(quantity * list_price * (1 - discount)) AS total_spending,
        COUNT(DISTINCT o.order_id) AS total_orders,
        to_days('2018-12-31') - to_days(MAX(order_date)) AS days_since_last_purchase
    FROM
        orders o
    INNER JOIN
        order_items oi
    ON
        o.order_id = oi.order_id
    JOIN 
        customers as c
    ON 
        c.customer_id = o.customer_id
    GROUP BY
        1
),
buying_analysis AS (
SELECT
    customer_id,
    customer_name,
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
    customer_stats
)

SELECT buying_power, COUNT(*) as no_of_customers
FROM
    buying_analysis
GROUP BY
    buying_power;

--Insight: Any customer who has spent more than 65% of top spending customers are grouped as big spenders. 
-- There are 17 customers grouped as big spenders considering the purchase pattern 
-- so need all the required contact details for any new release of premium products

WITH customer_stats AS (
    SELECT
        c.customer_id,
        c.phone,
        concat_ws(" ",c.first_name,c.last_name) as customer_name,
        SUM(quantity * list_price * (1 - discount)) AS total_spending,
        COUNT(DISTINCT o.order_id) AS total_orders,
        to_days('2018-12-31') - to_days(MAX(order_date)) AS days_since_last_purchase
    FROM
        orders o
    INNER JOIN
        order_items oi
    ON
        o.order_id = oi.order_id
    JOIN 
        customers as c
    ON 
        c.customer_id = o.customer_id
    GROUP BY
        1
),
buying_analysis AS (
SELECT
    customer_id,
    customer_name,
    phone,
    total_spending,
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
    customer_stats
)
SELECT * 
FROM buying_analysis
WHERE buying_power IN ("big spender","average spender")
ORDER BY
    total_spending DESC;
-- Insight: Identifed Abram Copeland, who has not visited store/s last 1 year 
-- but is a big spender so can be reached out for new sale opportunities.

-- For the null values with respect to Phone number details, 
-- Bike store can launch an email campaign to capture the corresponding phone numbers

-- Stock availability: Write a query to find the total quantity of each product available in all stores.
SELECT 
    s.product_id, 
    p.product_name, 
    SUM(s.quantity) as total_q_in_all_stores
FROM stocks as s
    INNER JOIN products as p
    ON p.product_id = s.product_id
GROUP BY s.product_id order by total_q_in_all_stores asc;

-- Insight : Stocks which are lesser than 10 to be replenished for quicker fulfilment. 
-- In this case Trek Domane SLR Frameset - 2018 and Electra Cruiser 1 Ladies - 2018 products to be reviewed on sales pattern. 

WITH max_order_date AS (
    SELECT MAX(order_date) AS max_date FROM orders
),

total_stock AS (
    SELECT
        s.product_id,
        p.product_name,
        SUM(s.quantity) AS total_stock
    FROM stocks AS s
    INNER JOIN products AS p ON s.product_id = p.product_id
    GROUP BY s.product_id
),

sales_trend AS (
    SELECT
        oi.product_id,
        SUM(oi.quantity) AS units_sold_recently
    FROM order_items AS oi
    INNER JOIN orders AS o ON oi.order_id = o.order_id
    CROSS JOIN max_order_date AS m
    WHERE o.order_date >= DATE_SUB('2018-12-01', INTERVAL 3 MONTH)
    GROUP BY oi.product_id
)

SELECT
    ts.product_id,
    ts.product_name,
    ts.total_stock,
    COALESCE(st.units_sold_recently, 0) AS units_sold_recently
FROM total_stock AS ts
LEFT JOIN sales_trend AS st ON ts.product_id = st.product_id
WHERE ts.total_stock < 20 AND st.units_sold_recently > 0
ORDER BY ts.total_stock ASC;
-- Insight : "Electra Superbolt 1 20"" - 2018" and Electra Townie Commute 8D Ladies' - 2018 stocks to be replenished 
-- considering the reduction in available items

-- Revenue by store: Write a query to calculate the total revenue generated by each store.
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

-- Insight: Baldwin Bikes of Newyork has been the highest revenue generator amongst all the stores. 
-- Need to review why the sale in Rowlett bikes way too low compared to other stores. Can review the staff marketting skills.


-- Monthly sales analysis: Write a query to calculate the total sales amount for each month.
SELECT
    YEAR(o.order_date)as year_value,
    MONTHNAME(o.order_date) as month_name,
    SUM(oi.quantity) as unit_sold,
    SUM(quantity * list_price * (1 - discount)) AS total_spending
FROM orders o
    INNER JOIN
    order_items oi
        ON o.order_id = oi.order_id
GROUP BY year_value,month_name;



WITH sales_data AS (
    SELECT
        year(o.order_date) as year,
        month(o.order_date) as month,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as sales_amount,
        LAG(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 1) OVER (ORDER BY month(o.order_date)) AS prev_sales_amount
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
        WHEN prev_sales_amount IS NULL THEN 0  -- Handle the first month case
        ELSE (1.0 * (sales_amount - prev_sales_amount) / prev_sales_amount) * 100.0
    END AS sales_growth_percent
FROM
    sales_data
GROUP BY year,month
ORDER BY
    month;

/*
Insight: 
We can see some similarities from the result:

April and July should be when downfall of sales happened
Around May and June AND August and September, the sales would rise again. This rise can either become the peak sales of the year.
*/

WITH sales_data AS (
    SELECT
        year(o.order_date) as year,
        month(o.order_date) as month,
        SUM(oi.quantity * oi.list_price * (1 - oi.discount)) as sales_amount,
        LAG(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 1) OVER (ORDER BY month(o.order_date)) AS prev_sales_amount
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
        WHEN prev_sales_amount IS NULL THEN 0  -- Handle the first month case
        ELSE (1.0 * (sales_amount - prev_sales_amount) / prev_sales_amount) * 100.0
    END AS sales_growth_percent
FROM
    sales_data
GROUP BY year,month
ORDER BY
    month;

/*
Insight: 
We can see some similarities from the result:

April and July should be when downfall of sales happened
Around May and June AND August and September, the sales would rise again. This rise can either become the peak sales of the year.
*/

-- Employee hierarchy: Write a query to list all staff members along with their managers' names.
SELECT
    m.staff_id AS manager_id,
    CONCAT_WS(' ', m.first_name, m.last_name) AS manager_name,
    COUNT(s.staff_id) AS num_staff_managed
FROM
    staffs AS m
LEFT JOIN
    staffs AS s ON s.manager_id = m.staff_id AND s.staff_id != m.staff_id
GROUP BY
    m.staff_id, m.first_name, m.last_name
ORDER BY
    num_staff_managed DESC;
-- Insight : May not need so many managers considering just 2 to 3 staff averaging under each manager.
-- Fabiola is self managed - doesnt have a manager

-- Product performance: Write a query to determine which products have the highest sales volume in the year 2018.
SELECT
    oi.product_id,
    product_name,
    year(o.order_date) AS order_year,
    sum(oi.quantity) AS total_unit_sold
FROM
    order_items AS oi
INNER JOIN products AS p
    ON oi.product_id = p.product_id
INNER JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE year(o.order_date) = 2018
GROUP BY oi.product_id, p.product_name, order_year
order by total_unit_sold desc;

-- Insight: Older models like Trek Girl's Kickster - 2017 continue to be in demand in following/newer year, 
-- so can be restocked.

-- Customer location analysis: Write a query to aggregate the total sales, average order value, and maximum order value for customers in each city and state.
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

-- Insight : Noticed Mount Vernon of NY has larger customer based and higher sales compared to other cities. 
-- May be the city can be assessed to open a store or service centre there.

-- Order fulfillment: Write a query to find the average number of days taken to ship orders after the required date.
SELECT 
    avg(datediff(shipped_date,required_date)) avg_delay
FROM orders;

-- Insight : Delay seem to be in control but still can be review the action required to completely avoid delays.

WITH delayed_order as(
SELECT order_id,st.store_name, DATEDIFF(shipped_date, required_date) AS avg_delay
FROM bikestore.orders as o
JOIN bikestore.stores as st
ON st.store_id = o.store_id
WHERE DATEDIFF(shipped_date, required_date) > 0
ORDER BY avg_delay DESC
)
SELECT store_name , 
avg_delay,
COUNT(*) as no_of_orders
FROM delayed_order
GROUP BY store_name, avg_delay
ORDER BY avg_delay DESC, no_of_orders DESC;
-- Insight: Baldwin Bikes store seem to have 112 orders delayed by 2 days and 205 orders by a day ,
-- So need to optimize the supply chain process for better customer experience.

-- Customer order patterns: Write a query to identify customers who placed orders in each month for the last six months of 2018.
/* Insight: 
If we look at the previous monthly sales analysis , we may identify a problem of customer order patterns after June 2018. Therefore, we need to investigate this issue.

First, we want to write a query to identify customers who placed orders in each month for the last six months of 2018.
*/
SELECT
    year(o.order_date) as year,
    month(o.order_date) as month,
    c.first_name, c.last_name
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
WHERE 
    year(o.order_date) = 2018 AND
    month(o.order_date) >= 6
ORDER BY 2 ASC, 3 ASC;

-- Insight: The number of orders have drastically declined, so need to reach out to older customers for marketting purpose.

/*
Insight:
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

/*
Questions:
Which products is the most profitable?
Which products should be kept available because they are profitable?
Which products should be kept available because they are popular?
*/

SELECT
    oi.product_id,
    product_name,
    oi.list_price,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM
    bikestore.order_items AS oi
INNER JOIN bikestore.products AS p
    ON oi.product_id = p.product_id
GROUP BY oi.product_id, product_name, oi.list_price
ORDER BY total_quantity DESC, total_sales DESC;

-- insight: need to balance inventory of high volume selling items like
-- Surly Ice Cream Truck Frameset - 2016 and Electra Cruiser 1 (24-Inch) - 2016
-- and high profit (revenue) items like Trek Slash 8 27.5 - 2016 and Trek Conduit+ - 2016

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
    -- Insight: We observe same products have been sold with different discounted prices across the time frame. 
    -- Trek Slash 8 27.5 - 2016,Trek Conduit+ - 2016, Trek Fuel EX 8 29 - 2016 and Surly Straggler 650b - 2016 
    -- are all 2016 models which are more populater.


/*
Insight: 
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

-- Insight: There are 771 products which have been sold less than 30 units.
with units_sold_less_30 as (
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
    HAVING SUM(quantity) < 30
    ORDER BY 3 DESC
)
SELECT COUNT(*) as no_of_products_sold_less_30 FROM units_sold_less_30;

-- Insight: Clearly Electra Townie Original 7D EQ - 2016 is sold the highest with 54 units being sold!
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
    Although most products sell under 30 units, some exceed 50 units. These higher-selling items are priced under $1,000. Despite their lower profitability, we should keep these popular items in stock to meet demand and drive sales!
    */