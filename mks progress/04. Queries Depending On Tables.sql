use bikestore;

-- primary tables are:
-- stores, staffs, brands, categories, products, stocks
-- customers, orders, order_items

-- Good to know the number of stores we have
select count(*) from stores;

-- Also good to know the number of stores available in each state followed by city
SELECT state, city, COUNT(*) AS store_count
FROM stores
GROUP BY state, city
ORDER BY state, city;


-- Good to know the number of staffs we have
select count(*) from staffs;

-- Analysing the total staff available in each store
SELECT sf.store_id, COUNT(sf.store_id) AS staff_count,
st.store_name, st.city, st.state
FROM staffs as sf, stores as st
where sf.store_id = st.store_id
GROUP BY sf.store_id
ORDER BY sf.store_id;

-- Getting the total brands available in all stores together
select count(*) from brands;
select * from brands;

-- Check if there are any brand name existing two or more times in the records,
-- to further delete such records
SELECT brand_name, COUNT(*) AS name_count
FROM brands
GROUP BY brand_name
HAVING COUNT(*) >= 2;

-- Getting the total categories available in all stores together
select count(*) from categories;

-- Check if there are any category name existing two or more times in the records,
-- to further delete such records
SELECT category_name, COUNT(*) AS name_count
FROM categories
GROUP BY category_name
HAVING COUNT(*) >= 2;

-- Getting the total products irresoective of brands or categories
select count(*) from products;

-- Lets identify how many products are there in each category irrespective of brands
SELECT p.category_id, c.category_name, COUNT(p.product_id) AS product_count
FROM products as p, categories as c
where c.category_id = p.category_id
GROUP BY p.category_id
ORDER BY p.category_id;

-- Lets identify how many products are there in each category in different brands
SELECT c.category_name, b.brand_name, COUNT(p.product_id) AS product_count
FROM products as p, categories as c, brands as b
where p.category_id = c.category_id and p.brand_id = b.brand_id
GROUP BY p.category_id, p.brand_id
ORDER BY p.category_id, p.brand_id;

-- Check the quantity of each product available in different stores using stocks table
SELECT s.store_id, p.product_name, SUM(s.quantity) AS total_quantity
FROM stocks AS s
JOIN products AS p ON s.product_id = p.product_id
GROUP BY s.store_id, p.product_name
ORDER BY s.store_id, p.product_name;

-- Check the quantity stocks in different stores using stocks table
SELECT s.store_id, SUM(s.quantity) AS total_quantity
FROM stocks AS s
GROUP BY s.store_id
ORDER BY s.store_id;


-- Check the total number of customers we have across different stores/ cities/ states
select count(*) from customers;

SELECT c.state, c.city, COUNT(c.customer_id) AS customers_count
FROM customers as c
GROUP BY c.state, c.city
ORDER BY c.state, c.city;

-- Check the total number of customers available in each states
with Cust_Count as (
	SELECT c.state, c.city, COUNT(c.customer_id) AS customers_count
	FROM customers as c
	GROUP BY c.state, c.city
	ORDER BY c.state, c.city
)
select Cust_Count.state, sum(Cust_Count.customers_count) from Cust_Count
GROUP By Cust_Count.state;

-- Check the total number of customers available in each states, and also map the respective store name belonging to its state.
with Cust_Count as (
	SELECT c.state, c.city, COUNT(c.customer_id) AS customers_count
	FROM customers as c
	GROUP BY c.state, c.city
	ORDER BY c.state, c.city
)
select cc.state, st.store_name, sum(cc.customers_count)
from Cust_Count as cc, stores as st
where cc.state = st.state
GROUP By cc.state, st.store_name;


-- Know the total number of order
select count(*) from orders;

-- Know the unique status of order
SELECT DISTINCT order_status FROM orders;
-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed

-- Get the total orders which are in pending status
select order_status, count(*) from orders
group by order_status;

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


-- Check total orders executed from each stores, display with store name and state
select o.store_id, s.store_name, s.state, count(o.order_id) as Total_Orders
from orders as o, stores as s
where o.store_id = s.store_id
group by o.store_id;


-- Check the total orders executed by each staff and their belonging store name and state, and also their designation
select o.staff_id, CONCAT(sf.first_name, ' ', sf.last_name) AS staff_name,
		count(o.order_id) as Total_Orders, sr.city as Store_City, sr.state as Store_State
from orders as o, staffs as sf, stores as sr
where o.staff_id = sf.staff_id
and sf.store_id = sr.store_id
group by o.staff_id;

-- Check the total orders initiated by customers from different states
SELECT c.state, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY total_orders DESC;

select count(*) from orders where customer_id in (
select customer_id from customers
where state = 'NY');

select count(*) from orders where customer_id in (
select customer_id from customers
where state = 'CA');

select count(*) from orders where customer_id in (
select customer_id from customers
where state = 'TX');

-- Average orders done per customer
SELECT AVG(o.order_count) AS avg_orders_per_customer
FROM (SELECT customer_id, COUNT(order_id) AS order_count
     FROM orders
     GROUP BY customer_id) o;





-- Average number of products, quantity and price ordered, considering all orders
with all_orders as (
		select order_id, count(item_id) as items_count, count(product_id) as products_count,
		count(quantity) as quantities, sum(list_price) as total_price
		from order_items group by order_id
    )
select avg(all_orders.items_count), avg(all_orders.products_count), 
	 avg(all_orders.quantities), avg(all_orders.total_price)
from all_orders;

-- Average number of products, quantity and price ordered, considering all customers
select o.customer_id, oi.order_id, count(oi.item_id) as items_count, count(oi.product_id) as products_count,
		count(oi.quantity) as quantities, sum(oi.list_price) as total_price
from orders as o, order_items as oi
-- left join orders as o on oi.order_id = o.order_id
group by o.customer_id, oi.order_id;



-- Total products, quantity sold and its amount (including all order status)

-- Total products, quantity sold and its amount (completed orders only)

-- Total products and qunatity sold from a store with their sold amount

-- Check the total products sold from each brand, and sum of sold price, total quantity

-- Check the total products sold from each product's category, and sum of sold price, total quantity

-- 
