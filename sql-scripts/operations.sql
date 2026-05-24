-- Apply subqueries to filter data (above average sales, highest order per customer)
SELECT *
FROM orders
WHERE price > (
        SELECT AVG(price) as Avg_price
        FROM orders
    )
LIMIT 200;
SELECT o.customer_id,
    o.order_id,
    o.price
FROM orders o
WHERE o.price = (
        SELECT MAX(price)
        FROM orders oc
        WHERE oc.customer_id = o.customer_id
    )
ORDER BY o.customer_id;
--Use CTEs to compute aggregations (total sales per customer) and perfomr row number and rank window functions
WITH customer_sales AS (
    SELECT customer_id,
        ROUND(SUM(price), 2) AS total_sales
    FROM orders
    GROUP BY customer_id
)

SELECT *
FROM customer_sales
ORDER BY total_sales DESC;
SELECT customer_id,
    total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS customer_rank
FROM (
        SELECT customer_id,
            SUM(price) AS total_sales
        FROM orders
        GROUP BY customer_id
    ) ranked_customers;
SELECT customer_id,
    price,
    ROW_NUMBER() OVER (
        ORDER BY price DESC
    ) AS row_num
FROM orders;

-- 
WITH customer_sales AS (
    SELECT customer_id,
        ROUND(SUM(price), 4) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id,
    c.state,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    cs.total_sales,
    RANK() OVER (
        ORDER BY cs.total_sales DESC
    ) AS customer_rank
FROM customers c
    JOIN customer_sales cs ON c.customer_id = cs.customer_id
ORDER BY customer_rank;

CREATE VIEW IF NOT EXISTS customer_sales_summary AS
SELECT c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    ROUND(SUM(o.price), 2) AS total_sales,
    COUNT(o.order_id) AS total_orders
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;
SELECT *
FROM customer_sales_summary
ORDER BY total_sales DESC
LIMIT 10;
SELECT *
FROM customer_sales_summary
ORDER BY total_sales ASC
LIMIT 10;
SELECT *
FROM customer_sales_summary
WHERE total_orders = 1;
SELECT *
FROM customer_sales_summary
WHERE total_sales > (
        SELECT AVG(total_sales)
        FROM customer_sales_summary
    )
ORDER BY total_sales DESC;