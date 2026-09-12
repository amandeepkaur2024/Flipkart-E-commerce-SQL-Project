CREATE TABLE products
(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(45),
	price FLOAT,
	cogs FLOAT,
	category VARCHAR(25),
	brand VARCHAR(25)
);

CREATE TABLE customers
(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(35),
	state VARCHAR(35)
);

CREATE TABLE sales
(
	order_id INT PRIMARY KEY,
	order_date DATE,
	customer_id INT REFERENCES customers(customer_id), -- fk
	order_status VARCHAR(15),
	product_id INT REFERENCES products(product_id), -- fk
	quantity INT,
	price_per_unit FLOAT
);

CREATE TABLE payments
(
	payment_id INT PRIMARY KEY,
	order_id INT,
	payment_date DATE,
	payment_status VARCHAR(25),
	CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES sales(order_id)
);

CREATE TABLE shipping
(
	shipping_id INT PRIMARY KEY,
	order_id INT REFERENCES sales(order_id), 
	shipping_date DATE,
	return_date DATE,
	shipping_providers VARCHAR(25),
	delivery_status VARCHAR(25)
);