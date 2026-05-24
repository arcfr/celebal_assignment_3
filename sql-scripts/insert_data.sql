USE shopease_db1;

-- Populating tables using Select Distinct keyword

--customer table
INSERT INTO customers (
    customer_id,
    first_name,
    last_name,
    city,
    state
)

SELECT
    customer_id,

    SUBSTRING_INDEX(
        MIN(customer_name),
        ' ',
        1
    ) AS first_name,

    CASE
        WHEN MIN(customer_name)
             LIKE '% %'
        THEN SUBSTRING_INDEX(
            MIN(customer_name),
            ' ',
            -1
        )
        ELSE 'Unknown'
    END AS last_name,

    MIN(city) AS city,
    MIN(state) AS state

FROM (
    SELECT DISTINCT
        customer_id,
        customer_name,
        city,
        state
    FROM superstore_raw
) AS unique_customers

GROUP BY customer_id;


INSERT INTO products (
    product_id,
    product_name,
    category,
    sub_category,
    unit_price
)


--product table
SELECT
    product_id,

    MIN(product_name) AS product_name,
    MIN(category) AS category,
    MIN(sub_category) AS sub_category,

    ROUND(
        AVG(
            sales / NULLIF(quantity, 0)
        ),
        2
    ) AS unit_price

FROM (
    SELECT DISTINCT
        product_id,
        product_name,
        category,
        sub_category,
        sales,
        quantity
    FROM superstore_raw
) AS unique_products

WHERE quantity > 0

GROUP BY product_id;

--orders table
INSERT INTO orders (
    order_id,
    customer_id,
    order_date,
    ship_mode,
    price
)

SELECT
    order_id,
    customer_id,

    MIN(order_date) AS order_date,
    MIN(ship_mode) AS ship_mode,

    ROUND(
        SUM(sales),
        2
    ) AS price

FROM (
    SELECT DISTINCT
        order_id,
        customer_id,
        order_date,
        ship_mode,
        sales
    FROM superstore_raw
) AS unique_orders

GROUP BY
    order_id,
    customer_id;



-- ==========================================
-- VERIFY TABLE COUNTS
-- ==========================================

SELECT
    'customers' AS table_name,
    COUNT(*) AS total_rows
FROM customers

UNION ALL

SELECT
    'products',
    COUNT(*)
FROM products

UNION ALL

SELECT
    'orders',
    COUNT(*)
FROM orders

UNION ALL

SELECT
    'superstore_raw',
    COUNT(*)
FROM superstore_raw;