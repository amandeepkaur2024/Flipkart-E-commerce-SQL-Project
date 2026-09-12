
-- ============================================================================================================
--                                        Flipkart SQL PROJECT
-- ============================================================================================================

-- -------------------------------JOINS - SQL(INNER, LEFT, RIGHT, FULL)----------------------------------------
-- 1. Retrieve a list of all customers with their corresponding product names they ordered (use an INNER JOIN 
-- between customers and sales tables).
SELECT 
	c.customer_id, 
	c.customer_name,
	p.product_name
FROM 
	customers AS c
INNER JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
INNER JOIN
	products AS p
ON p.product_id = s.product_id;


-- 2. List all products and show the details of customers who have placed orders for them. Include products
-- that have no orders(use a LEFT JOIN between products and sales tables).
SELECT
	p.product_id,
	p.product_name,
	c.customer_id,
	c.customer_name,
	s.order_status,
	s.quantity
FROM
	products AS p
LEFT JOIN
	sales AS s
ON
	p.product_id = s.product_id
LEFT JOIN
	customers AS c
ON
	c.customer_id = s.customer_id;


-- 3. List all orders and their shipping status. Include orders that do not have any shipping records 
-- (use a LEFT JOIN between sales and shippings tables).
SELECT
	s.order_id,
	s.order_status,
	shp.delivery_status
FROM
	sales AS s
LEFT JOIN
	shippings AS shp
ON
	s.order_id = shp.order_id


-- 4. Retrieve all products, including those with no orders, along with their price.
SELECT
	p.product_id,
	p.product_name,
	p.price,
	s.quantity,
	s.order_status
FROM 
	products AS p
LEFT JOIN
	sales AS s
ON
	p.product_id = s.product_id;


-- 5. Get a list of all customers who have placed orders, including those with no 
-- payment records. Use a FULL OUTER JOIN between the customers and payments tables.
SELECT
	c.customer_id,
	c.customer_name,
	p.payment_status
FROM 
	customers AS c
LEFT JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
FULL OUTER JOIN
	payments AS p
ON
	p.order_id = s.order_id;


-- -------------------------------JOINS + WHERE CLAUSE----------------------------------------
-- 1. Find the total number of completed orders made by customers from the state 'Delhi' 
-- (use INNER JOIN between customers ans sales and apply a WHERE condition)
SELECT
	COUNT(s.customer_id) AS total_complete_orders
FROM
	customers AS c
JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
WHERE
	c.state = 'Delhi'
	AND
	s.order_status = 'Completed';


-- 2. Retrieve a list of products ordered by customers from the state 'Karnataka' with price
-- greater than 10,000 (use INNER JOIN between sales, customers and products)
SELECT
	DISTINCT p.product_id,
	p.product_name,
	p.price
FROM
	customers AS c
JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	c.state = 'Karnataka'
	AND
	p.price > 10000;


-- 3. List all customers who have placed orders where the product category is 'Accessories' 
-- and the order status is 'Completed' (use INNER JOIN with sales, customers, and products)
SELECT
	DISTINCT c.customer_id,
	c.customer_name
FROM
	customers AS c
INNER JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
INNER JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	p.category = 'Accessories'
	AND
	s.order_status = 'Completed';


-- 4. Show the order details of customers who have paid for their orders, excluding those 
-- who have cancelled their orders (use INNER JOIN between sales and payments and apply 
-- WHERE for order_status).
SELECT
	c.customer_id,
	c.customer_name,
	s.order_status,
	p.payment_status
FROM
	customers AS c
JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
JOIN
	payments AS p
ON 
	s.order_id = p.order_id
WHERE
	p.payment_status = 'Payment Successed'
	AND
	s.order_status <> 'Cancelled';


-- 5. Retrieve products ordered by customers who are in the 'Gujarat' state and whose total 
-- order price is greater than 15,000 (use INNER JOIN between sales, customers and products).
SELECT
	DISTINCT p.product_id,
	p.product_name,
	p.price,
	s.quantity,
	p.price * s.quantity AS total_price
FROM 
	customers AS c
JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	c.state = 'Gujarat'
	AND
	(p.price * s.quantity) > 15000;



-- -------------------------------JOINS + GROUP BY + HAVING----------------------------------------
-- 1. Find the total quantity of each product ordered by customers from 'Delhi' and only include
-- products with a quantity greater than 5 (use INNER JOIN with sales, customers, and products 
-- and group by product)
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM sales;

SELECT p.product_id, SUM(s.quantity) AS total_quantity
FROM customers AS c
INNER JOIN sales AS s
ON c.customer_id = s.customer_id
INNER JOIN products AS p
ON s.product_id = p.product_id
WHERE c.state = 'Delhi'
GROUP BY p.product_id
HAVING SUM(s.quantity) > 5


-- 2. Get the average payment amount per customer who has placed more than 3 orders (use INNER 
-- JOIN between payments and sales, group by customer, and apply a HAVING clause)
SELECT * FROM payments;

SELECT c.customer_id, COUNT(*) AS total_orders, AVG(s.quantity * s.price_per_unit) AS avg_payment_amount
FROM customers AS c
INNER JOIN sales AS s
ON c.customer_id = s.customer_id
INNER JOIN payments AS p
ON s.order_id = p.order_id
GROUP BY 1
HAVING COUNT(*) > 3


-- 3. Retrieve the total sales for each product category and only include categories where the
-- total sales exceed 100000 (use INNER JOIN between sales and products, group by category)
SELECT
	p.category, SUM(s.quantity * s.price_per_unit) AS total_sales
FROM sales AS s
INNER JOIN products AS p
ON s.product_id = p.product_id
GROUP BY p.category
HAVING SUM(s.quantity * s.price_per_unit) > 100000



-- 4. Show the number of customers in each state who have made purchases with a total spend
-- greater than 50000 (use INNER JOIN between sales and customers)
SELECT c.state, COUNT(DISTINCT c.customer_id) AS total_customer, SUM(s.quantity * s.price_per_unit) AS total_spent
FROM customers AS c
INNER JOIN sales AS s
ON c.customer_id = s.customer_id
GROUP BY c.state
HAVING SUM(s.quantity * s.price_per_unit) > 50000;


-- 5. List the total sales by brand for products that have been ordered more than 10 times
-- (use INNER JOIN between sales and products, group by brand)
SELECT p.brand, SUM(s.quantity * s.price_per_unit) AS total_sales, COUNT(s.order_id) AS total_orders
FROM sales AS s
INNER JOIN products AS p
ON s.product_id = p.product_id
GROUP BY p.brand
HAVING COUNT(s.order_id) > 10;

SELECT * FROM products


-- -------------------------------JOINS + WHERE + GROUP BY + HAVING + ORDER BY----------------------------------------
-- 1. Retrieve the total sales per customer in 'Delhi' where the order status is 'Completed', only include those with 
-- total sales greater than 50000 and order the results by total sales (use INNER JOIN between sales and customers)
SELECT
	c.customer_id,
	c.customer_name,
	c.state,
	SUM(p.price * s.quantity) AS total_sales
FROM
	customers AS c
JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	c.state = 'Delhi'
	AND
	s.order_status = 'Completed'
GROUP BY
	c.customer_id,
	c.customer_name,
	c.state
HAVING
	SUM(p.price * s.quantity) > 50000
ORDER BY
	total_sales


-- 2. Show the total quantity sold per product in the 'Accessories' category where the total quantity sold is greater
-- than 50 and order the results by product name (use INNER JOIN between sales and products).
SELECT
	p.product_id,
	p.product_name,
	SUM(s.quantity) AS total_quantity
FROM
	products AS p
JOIN
	sales AS s
ON
	p.product_id = s.product_id
WHERE
	p.category = 'Accessories'
GROUP BY
	p.product_id,
	p.product_name
HAVING
	SUM(s.quantity) > 50
ORDER BY
	p.product_name;


-- 3. Find the total number of orders for customers from 'Maharashtra' who have spent more than 100000 and order 
-- the results by the total amount spent (use INNER JOIN between sales and customers).
SELECT
	c.customer_id,
	COUNT(c.customer_id) AS total_orders,
	SUM(p.price * s.quantity) AS total_amount_spent
FROM
	customers AS c
JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	state = 'Maharashtra'
GROUP BY
	c.customer_id
HAVING
	SUM(p.price * s.quantity) > 100000
ORDER BY
	total_amount_spent;


-- 4. Get the number of orders per product and filter to include only products that have been ordered more than 
-- 10 times, then order the results by the highest number of orders (use INNER JOIN between sales and products).
SELECT
	p.product_id,
	p.product_name,
	COUNT(s.order_id) AS total_orders
FROM
	products AS p
INNER JOIN
	sales AS s
ON
	p.product_id = s.product_id
GROUP BY
	p.product_id,
	p.product_name
HAVING
	COUNT(s.order_id) > 10
ORDER BY
	COUNT(s.order_id) DESC;


-- 5. Retrieve the number of payments made per customer where the payment status is 'Payment Successed' 
-- and group by customer, ordering by payment count (use INNER JOIN between payments and customers).
SELECT
	c.customer_id,
	c.customer_name,
	COUNT(p.order_id) AS total_payments
FROM
	customers AS c
JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
JOIN
	payments AS p
ON
	s.order_id = p.order_id
WHERE
	p.payment_status = 'Payment Successed'
GROUP BY
	c.customer_id,
	c.customer_name
ORDER BY
	total_payments desc;

-- ------------------------------------------DATE FUNCTIONS--------------------------------------------
-- 1. List all orders that were placed within the year 2023 (use order_date with the EXTRACT function).
SELECT 
	order_id, 
	EXTRACT(YEAR FROM order_date) AS year, 
	customer_id, 
	order_status, 
	product_id, 
	quantity, 
	price_per_unit
FROM sales
WHERE EXTRACT(YEAR FROM order_date) = 2023;


-- 2. Retrieve customers who have make purchases in the month of January (use order_date and TO_CHAR to extract the month).
SELECT customer_id, TO_CHAR(order_date, 'Month') AS month_name
FROM sales
WHERE EXTRACT(MONTH FROM order_date) = 01;















-- 3. Calculate the number of days between the payment_date and order_date for each order (use the AGE function).
SELECT
	s.order_date,
	p.payment_date,
	AGE(p.payment_date, s.order_date) AS total_days
FROM
	sales AS s
INNER JOIN
	payments AS p
ON
	s.order_id = p.order_id


-- 4. Find the total sales for each year (use EXTRACT with order_date to group by year).
SELECT
	EXTRACT(YEAR FROM s.order_date) AS year,
	SUM(p.price * s.quantity) AS total_sales
FROM
	sales AS s
INNER JOIN
	products AS p
ON
	s.product_id = p.product_id
GROUP BY
	year;


-- 5. Show all orders where the shipping date is after the payment date (use date comaprison).
SELECT
	p.order_id,
	p.payment_date,
	s.shipping_date
FROM
	payments AS p
INNER JOIN
	shippings AS s
ON
	p.order_id = s.order_id
WHERE
	s.shipping_date > p.payment_date;



-- ------------------------------------------Assignments--------------------------------------------
-- 1. Retrieve all products along with their total sales revenue from completed orders.
SELECT
	p.product_id,
	p.product_name,
	SUM(p.price * s.quantity) AS total_sales
FROM
	sales AS s
JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	s.order_status = 'Completed'
GROUP BY
	p.product_id,
	p.product_name;


-- 2. List all customers and the products they have purchased, showing only those who have ordered more than two products.
SELECT
	c.customer_id,
	c.customer_name,
	COUNT(DISTINCT p.product_id) AS total_orders
FROM
	customers AS c
INNER JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
INNER JOIN
	products AS p
ON
	s.product_id = p.product_id
GROUP BY
	c.customer_id,
	c.customer_name
HAVING
	COUNT(DISTINCT p.product_id) > 2;


-- 3. Find the total amount spent by customers in 'Gujarat' who have ordered products priced greater than 10000.
SELECT
	c.customer_id,
	c.customer_name,
	SUM(p.price * s.quantity) AS total_amount
FROM 
	customers AS c
INNER JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
INNER JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	c.state = 'Gujarat'
	AND
	p.price > 10000
GROUP BY
	c.customer_id,
	c.customer_name;

-- 4. Retrieve the list of all orders that have not yet been shipped.
SELECT
	s.order_id,
	s.product_id
FROM
	sales AS s
LEFT JOIN
	shippings AS shp
ON
	s.order_id = shp.order_id
WHERE 
	shp.delivery_status <> 'Shipped'
	OR
	shp.delivery_status IS NULL;


-- 5. Find the average order value per customer for orders with a quantity of more than 5.
SELECT
	c.customer_id,
	c.customer_name,
	ROUND(AVG(s.quantity * s.price_per_unit)) AS avg_order
FROM 
	customers AS c
INNER JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
WHERE
	s.quantity > 5
GROUP BY
	c.customer_id,
	c.customer_name;

	
-- 6. Get the top 5 customers by total spending on 'Accessories'.
SELECT
	c.customer_id,
	c.customer_name,
	SUM(p.price * s.quantity) AS total_spending
FROM
	customers AS c
INNER JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
INNER JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	p.category = 'Accessories'
GROUP BY
	c.customer_id,
	c.customer_name
ORDER BY
	SUM(p.price * s.quantity) DESC
LIMIT 5;

-- 7. Retrieve a list of customers who have not made any payment for their orders.
SELECT
	c.customer_id,
	c.customer_name
FROM
	customers AS c
LEFT JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
LEFT JOIN
	payments AS p
ON
	s.order_id = p.order_id
WHERE
	p.order_id IS NULL;
	

-- 8. Find the most popular product based on total quantity sold in 2023.
SELECT
	p.product_id,
	p.product_name,
	SUM(s.quantity) AS total_quantity
FROM
	sales AS s
LEFT JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	EXTRACT(YEAR FROM s.order_date) = 2023
GROUP BY
	p.product_id,
	p.product_name
ORDER BY
	SUM(s.quantity) DESC
LIMIT 1;



-- 9. List all orders that were cancelled and the reason for cancellation (if available).
SELECT
	s.order_id,
	p.product_id,
	p.product_name,
	s.order_status
FROM
	sales AS s
JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	s.order_status = 'Cancelled'

-- 10. Retrieve the total quantity of products sold by category in 2023.
SELECT
	p.category,
	SUM(s.quantity) AS total_quantity
FROM
	sales AS s
JOIN 
	products AS p
ON
	s.product_id = p.product_id
WHERE
	EXTRACT(YEAR FROM s.order_date) = 2023
GROUP BY
	p.category;















-- 11. Get the count of returned orders by shipping providers in 2023.
SELECT
	ss.shipping_providers,
	COUNT(*) AS returned_order
FROM
	shippings AS ss
INNER JOIN
	sales AS s
ON
	ss.order_id = s.order_id
WHERE
	ss.delivery_status like 'R%'
	AND
	EXTRACT(YEAR FROM s.order_date) = 2023
GROUP BY
	shipping_providers;





-- 12. Show the total revenue generated per month for the year 2023.
SELECT
	TO_CHAR(s.order_date, 'FMMonth') AS Month,
	SUM(p.price * s.quantity) AS total_revenue
FROM
	sales AS s
INNER JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	EXTRACT(YEAR FROM s.order_date) = 2023
GROUP BY
	EXTRACT(MONTH FROM s.order_date),
	Month
ORDER BY
	EXTRACT(MONTH FROM s.order_date);

-- 13. Find the customers who have made the most purchases in a single month.
SELECT
	c.customer_id,
	c.customer_name,
	EXTRACT(YEAR FROM s.order_date) AS order_year,
	EXTRACT(MONTH FROM s.order_date) AS order_month,
	COUNT(DISTINCT s.order_id) AS total_orders
FROM
	customers AS c
JOIN
	sales AS s
ON
	c.customer_id = s.customer_id
GROUP BY
	c.customer_id,
	c.customer_name,
	EXTRACT(YEAR FROM s.order_date),
	EXTRACT(MONTH FROM s.order_date)
ORDER BY
	total_orders DESC
LIMIT 1;















-- 14. Retrieve the number of orders made per product category in 2023 and order by total quantity sold.
SELECT
	p.category,
	COUNT(s.order_id) AS total_orders,
	SUM(s.quantity) AS total_quantity
FROM
	sales AS s
JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	EXTRACT(YEAR FROM s.order_date) = 2023
GROUP BY
	p.category
ORDER BY
	total_quantity DESC;

-- 15. List the products that have been ordered (use LEFT JOIN between products and sales).
SELECT
	p.product_id,
	p.product_name
FROM
	sales AS s
LEFT JOIN
	products AS p
ON
	s.product_id = p.product_id
WHERE
	s.order_id IS NOT NULL;







