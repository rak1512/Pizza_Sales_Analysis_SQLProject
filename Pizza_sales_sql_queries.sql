
CREATE TABLE Pizza_Sales (
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price NUMERIC(10,2),
    total_price NUMERIC(10,2),
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);


SELECT * 
FROM Pizza_Sales;

-- Total Revenue
SELECT 
    SUM(total_price) AS total_revenue
FROM pizza_sales;

-- Average Order Value
SELECT 
    ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS average_order_price
FROM pizza_sales;

-- Total Pizzas Sold
SELECT 
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;

-- Total Orders
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

-- Average Pizzas per Order
SELECT 
    ROUND(SUM(quantity)::DECIMAL / COUNT(DISTINCT order_id), 2) AS avg_pizzas_per_order
FROM pizza_sales;

-- Daily Trend (Orders by Day)
SELECT 
    TO_CHAR(order_date, 'Day') AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_day
ORDER BY total_orders DESC;

-- Hourly Trend (Orders by Hour)
SELECT 
    EXTRACT(HOUR FROM order_time) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_hour
ORDER BY total_orders DESC;

-- Sales by Category (January)
SELECT 
    pizza_category,
    SUM(total_price) AS total_sales_category,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) 
         FROM pizza_sales 
         WHERE EXTRACT(MONTH FROM order_date) = 1),
    2) AS percentage_of_sales
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 1
GROUP BY pizza_category;

-- Sales by Pizza Size
SELECT 
    pizza_size,
    SUM(total_price) AS total_sales_category,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
    2) AS percentage_of_sales
FROM pizza_sales
GROUP BY pizza_size;

-- Total Pizzas Sold by Category
SELECT 
    pizza_category,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category;

-- Top 5 Best-Selling Pizzas
SELECT 
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC
LIMIT 5;

-- Bottom 5 Worst-Selling Pizzas
SELECT 
    pizza_name,
    SUM(quantity) AS total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold ASC
LIMIT 5;