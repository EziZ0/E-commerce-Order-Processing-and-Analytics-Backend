
-- ========== ETL ===================

-- 1. Total Revenue from All Orders
SELECT SUM(price * quantity) AS total_revenue
FROM order_items;

-- 2. Revenue by Item
SELECT i.item_name, SUM(oi.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN items i ON oi.item_id = i.item_id
GROUP BY i.item_name
ORDER BY total_revenue DESC;

-- 3. Revenue by Payment Method
SELECT p.payment_method, SUM(p.amount) AS total_revenue
FROM payments p
GROUP BY p.payment_method;

-- 4. Total Revenue by Date
SELECT DATE(SUBSTRING(p.paid_at, 1, 10)) AS order_date,
       SUM(oi.price * oi.quantity) AS total_revenue
FROM payments p
JOIN order_items oi ON p.order_id = oi.order_id
GROUP BY order_date
ORDER BY order_date;

-- 5. Total Orders and Revenue by User
SELECT
    u.first_name,
    u.last_name,
    u.phone_number,
    u.email,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id
ORDER BY total_revenue DESC;

-- 6. Items Ordered by Category
SELECT
    c.category_name,
    i.item_name,
    SUM(oi.quantity) AS total_quantity_ordered
FROM order_items oi
JOIN items i ON oi.item_id = i.item_id
JOIN categories c ON i.category_id = c.category_id
GROUP BY c.category_name, i.item_name
ORDER BY total_quantity_ordered DESC;

-- 7. Orders by Payment Status
SELECT
    p.payment_status,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM payments p
JOIN orders o ON p.order_id = o.order_id
GROUP BY p.payment_status;

-- 8. Users with Most Orders
SELECT
    u.first_name,
    u.last_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY total_orders DESC;

-- 9. Revenue by Category
SELECT
    c.category_name,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN items i ON oi.item_id = i.item_id
JOIN categories c ON i.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;

-- 11. Customer Details with Orders
SELECT
    u.first_name,
    u.last_name,
    u.phone_number,
    u.email,
    o.order_id,
    o.delivery_address,
    oi.item_id,
    oi.quantity
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN users u ON o.user_id = u.user_id;

-- 12. Revenue by Customer
SELECT
    u.first_name,
    u.last_name,
    u.phone_number,
    u.email,
    SUM(oi.price * oi.quantity) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN users u ON o.user_id = u.user_id
GROUP BY u.user_id
ORDER BY total_revenue DESC;
