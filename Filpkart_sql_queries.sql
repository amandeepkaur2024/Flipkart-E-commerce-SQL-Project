
-- ============================================================================================================
--                                        Flipkart SQL PROJECT
-- ============================================================================================================

-- EASY

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

-- 2. Retrieve all products, including those with no orders, along with their price.
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

-- 3. Find the total number of completed orders made by customers from the state 'Delhi'.
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

-- 4. List all orders that were placed within the year 2023.
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

-- 5. Retrieve the list of all orders that have not yet been shipped.
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


-- MEDIUM TO HARD

-- 1. Retrieve the total sales for each product category and only include categories where the
-- total sales exceed 100000 (use INNER JOIN between sales and products, group by category)
SELECT
	p.category, SUM(s.quantity * s.price_per_unit) AS total_sales
FROM sales AS s
INNER JOIN products AS p
ON s.product_id = p.product_id
GROUP BY p.category
HAVING SUM(s.quantity * s.price_per_unit) > 100000

-- 2. Retrieve the total sales per customer in 'Delhi' where the order status is 'Completed', only include those with 
-- total sales greater than 50000 and order the results by total sales.
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

-- 3. Get the top 5 customers by total spending on 'Accessories'.
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

-- 4. Show the total revenue generated per month for the year 2023.
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

-- 5. Find the customers who have made the most purchases in a single month.
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