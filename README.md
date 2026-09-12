# Flipkart-E-commerce-SQL-Project

![Project Image Placeholder](3Flipkart.avif)

Welcome to my SQL project, where I analyze real-time data from **Flipkart**! This project uses a dataset of **20,000+ sales records** and additional tables for payments, products, and shipping data to explore and analyze e-commerce transactions, product sales, and customer interactions. The project aims to solve business problems through SQL queries, helping Flipkart make informed decisions.

## Table of Contents

* [Introduction](#introduction)
* [Project Structure](#project-structure)
* [Database Schema](#database-schema)
* [Business Problems](#business-problems)
* [SQL Queries & Analysis](#sql-queries--analysis)
* [Getting Started](#getting-started)
* [Questions & Feedback](#questions--feedback)
* [Contact Me](#contact-me)

---

## Introduction

This project demonstrates essential SQL skills by analyzing e-commerce data from **Flipkart**, focusing on sales, payments, products, and customer data. Through SQL, we answer critical business questions, uncover trends, and derive actionable insights that help improve business strategies and customer experiences. The project covers different SQL techniques including **Joins**, **Group By**, **Aggregations**, and **Date Functions**.

## Project Structure

1. **SQL Scripts**: Contains code to create the database schema and write queries for analysis.
2. **Dataset**: Real-time data representing e-commerce transactions, product details, customer information, and shipping status.
3. **Analysis**: SQL queries crafted to solve business problems, each focusing on understanding e-commerce sales and performance.

---

## Database Schema

Here's an overview of the database structure:

### 1. **Customers Table**

* **customer_id**: Unique identifier for each customer
* **customer_name**: Name of the customer
* **state**: Location (state) of the customer

### 2. **Products Table**

* **product_id**: Unique identifier for each product
* **product_name**: Name of the product
* **price**: Price of the product
* **cogs**: Cost of goods sold
* **category**: Category of the product
* **brand**: Brand name of the product

### 3. **Sales Table**

* **order_id**: Unique order identifier
* **order_date**: Date the order was placed
* **customer_id**: Linked to the `customers` table
* **order_status**: Status of the order (e.g., Completed, Cancelled)
* **product_id**: Linked to the `products` table
* **quantity**: Quantity of products sold
* **price_per_unit**: Price per unit of the product

### 4. **Payments Table**

* **payment_id**: Unique payment identifier
* **order_id**: Linked to the `sales` table
* **payment_date**: Date the payment was made
* **payment_status**: Status of the payment (e.g., Payment Successed, Payment Failed)

### 5. **Shippings Table**

* **shipping_id**: Unique shipping identifier
* **order_id**: Linked to the `sales` table
* **shipping_date**: Date the order was shipped
* **return_date**: Date the order was returned (if applicable)
* **shipping_providers**: Shipping provider (e.g., Ekart, Bluedart)
* **delivery_status**: Status of delivery (e.g., Delivered, Returned)

## Business Problems

The following queries were created to solve specific business questions. Each query is designed to provide insights based on sales, payments, products, and customer data.

### Easy

1. Retrieve a list of all customers with their corresponding product names they ordered.
2. Retrieve all products, including those with no orders, along with their price.
3. Find the total number of completed orders made by customers from the state 'Delhi'.
4. List all orders that were placed within the year 2023.
5. Retrieve the list of all orders that have not yet been shipped.

### Medium to Hard

1. Retrieve the total sales for each product category and only include categories where the total sales exceed 100,000.
2. Retrieve the total sales per customer in 'Delhi' where the order status is 'Completed', only including customers with total sales greater than 50,000, ordered by total sales.
3. Get the top 5 customers by total spending on 'Accessories'.
4. Show the total revenue generated per month for the year 2023.
5. Find the customers who have made the most purchases in a single month.

---

## SQL Queries & Analysis

The Flipkart_Sql_Queries.sql file contains 40 SQL queries developed for this project, organized into six sections by technique:

* **Joins** — INNER, LEFT, and FULL OUTER JOINs across the five tables
* **Joins + Where** — filtered joins on customer state, product category, and pricing conditions
* **Joins + Group By + Having** — aggregated metrics (totals, averages) filtered by threshold conditions
* **Joins + Where + Group By + Having + Order By** — combined filtering, aggregation, and ranking
* **Date Functions** — EXTRACT, TO_CHAR, and AGE for year/month breakdowns and date comparisons
* **Assignments** — 15 applied business questions combining the techniques above to answer real e-commerce questions (top spenders, unshipped orders, most popular products, monthly revenue trends, and more)

Each query includes a comment describing the business question it answers. A curated sample of 10 questions is highlighted above in Business Problems; the full set is available in the file itself.

---

## Getting Started

### Prerequisites

* PostgreSQL (or any SQL-compatible database)
* Basic understanding of SQL

### Steps

1. **Clone the Repository**:

```bash
git clone https://github.com/amandeepkaur2024/Flipkart-E-commerce-SQL-Project.git
```

2. **Set Up the Database**:

   * Run the `Schema.sql` script to set up tables and insert sample data.
3. **Run Queries**:

   * Execute each query in `Flipkart_sql_queries.sql` to explore and analyze the data.

---


## ERD (Entity-Relationship Diagram)

![ERD Placeholder](Flipkart_Project_Schemas.png)

## Notice

All customer names and data used in this project are computer-generated using AI and random functions. They do not represent real data associated with Flipkart or any other entity. This project is solely for learning and educational purposes, and any resemblance to actual persons, businesses, or events is purely coincidental.
