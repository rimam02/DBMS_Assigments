Last login: Fri Sep 25 13:27:45 on ttys005
rimamaji@Rimas-MacBook-Air ~ % psql postgres
psql (18.4 (Homebrew))
Type "help" for help.

postgres=# \c orderdb
You are now connected to database "orderdb" as user "rimamaji".
orderdb=# \c orderdb
You are now connected to database "orderdb" as user "rimamaji".
orderdb=# \d orders
                 Table "public.orders"
   Column    |  Type   | Collation | Nullable | Default 
-------------+---------+-----------+----------+---------
 order_id    | integer |           | not null | 
 customer_id | integer |           |          | 
 product_id  | integer |           |          | 
 order_date  | date    |           |          | 
 quantity    | integer |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "orders_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    "orders_product_id_fkey" FOREIGN KEY (product_id) REFERENCES products(product_id)
Triggers:
    trg_check_quantity BEFORE INSERT OR UPDATE ON orders FOR EACH ROW EXECUTE FUNCTION fn_check_quantity()
    trg_new_order_notice AFTER INSERT ON orders FOR EACH ROW EXECUTE FUNCTION fn_new_order_notice()

orderdb=# \d products
                        Table "public.products"
    Column    |         Type          | Collation | Nullable | Default 
--------------+-----------------------+-----------+----------+---------
 product_id   | integer               |           | not null | 
 product_name | character varying(50) |           |          | 
 category     | character varying(50) |           |          | 
 price        | numeric(10,2)         |           |          | 
Indexes:
    "products_pkey" PRIMARY KEY, btree (product_id)
Referenced by:
    TABLE "orders" CONSTRAINT "orders_product_id_fkey" FOREIGN KEY (product_id) REFERENCES products(product_id)
Triggers:
    trg_show_old_new_price AFTER UPDATE ON products FOR EACH ROW EXECUTE FUNCTION show_old_new_price()

orderdb=# select * products;
ERROR:  syntax error at or near "products"
LINE 1: select * products;
                 ^
orderdb=# select * from products;
 product_id | product_name |  category   |  price   
------------+--------------+-------------+----------
        102 | Smartphone   | Electronics | 25000.00
        103 | Headphones   | Electronics |  2000.00
        104 | Office Chair | Furniture   |  5000.00
        105 | Desk         | Furniture   |  8000.00
        106 | Notebook     | Stationery  |    50.00
        107 | Pen          | Stationery  |    10.00
        108 | Water Bottle | Accessories |   300.00
        109 | Backpack     | Accessories |  1500.00
        110 | Monitor      | Electronics | 12000.00
        101 | Laptop       | Electronics | 60000.00
(10 rows)

orderdb=# select * from customers;
 customer_id | customer_name |   city   |  country  
-------------+---------------+----------+-----------
           1 | Rahul Sharma  | Mumbai   | India
           2 | Priya Singh   | Delhi    | India
           3 | John Smith    | New York | USA
           4 | Emma Watson   | London   | UK
           5 | Wei Chen      | Beijing  | China
           6 | Sara Khan     | Karachi  | Pakistan
           7 | David Miller  | Toronto  | Canada
           8 | Anjali Verma  | Pune     | India
           9 | Tom Brown     | Sydney   | Australia
          10 | Lisa Ray      | Chicago  | USA
(10 rows)

orderdb=# select * from orders;
 order_id | customer_id | product_id | order_date | quantity 
----------+-------------+------------+------------+----------
        1 |           1 |        101 | 2024-01-05 |        1
        2 |           1 |        103 | 2024-01-06 |        2
        3 |           2 |        102 | 2024-01-10 |        1
        4 |           3 |        104 | 2024-01-12 |        2
        5 |           3 |        105 | 2024-01-15 |        1
        6 |           4 |        106 | 2024-02-01 |        5
        7 |           5 |        107 | 2024-02-03 |       10
        8 |           6 |        101 | 2024-02-10 |        1
        9 |           7 |        102 | 2024-02-15 |        1
       10 |           2 |        103 | 2024-02-20 |        1
       11 |           8 |        109 | 2024-03-01 |        2
(11 rows)

orderdb=# SELECT order_id, order_meta
FROM orders;
ERROR:  column "order_meta" does not exist
LINE 1: SELECT order_id, order_meta
                         ^
HINT:  Perhaps you meant to reference the column "orders.order_date".
orderdb=# SELECT product_id, product_name, tags, monthly_sales
FROM products;
ERROR:  column "tags" does not exist
LINE 1: SELECT product_id, product_name, tags, monthly_sales
                                         ^
orderdb=# -- Assignment 11, Q1
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       order_meta ->> 'payment_method' AS payment_method
FROM orders;
ERROR:  column "order_meta" does not exist
LINE 2:        order_meta ->> 'payment_method' AS payment_method
               ^
HINT:  Perhaps you meant to reference the column "orders.order_date".
orderdb=# ALTER TABLE orders
ADD COLUMN order_meta JSONB;
ALTER TABLE
orderdb=# ALTER TABLE products
ADD COLUMN tags TEXT[];
ALTER TABLE
orderdb=# ALTER TABLE products
ADD COLUMN monthly_sales INT[];
ALTER TABLE
orderdb=# SELECT product_id, product_name, tags, monthly_sales
FROM products;
 product_id | product_name | tags | monthly_sales 
------------+--------------+------+---------------
        102 | Smartphone   |      | 
        103 | Headphones   |      | 
        104 | Office Chair |      | 
        105 | Desk         |      | 
        106 | Notebook     |      | 
        107 | Pen          |      | 
        108 | Water Bottle |      | 
        109 | Backpack     |      | 
        110 | Monitor      |      | 
        101 | Laptop       |      | 
(10 rows)

orderdb=# SELECT order_id, order_meta
FROM orders;
 order_id | order_meta 
----------+------------
        1 | 
        2 | 
        3 | 
        4 | 
        5 | 
        6 | 
        7 | 
        8 | 
        9 | 
       10 | 
       11 | 
(11 rows)

orderdb=# UPDATE orders
SET order_meta = CASE order_id

    WHEN 1 THEN
        '{"payment_method":"UPI","shipping":{"city":"Mumbai","express":true},"status":"delivered"}'::jsonb

    WHEN 2 THEN
        '{"payment_method":"Card","shipping":{"city":"Mumbai","express":false},"status":"shipped"}'::jsonb

    WHEN 3 THEN
        '{"payment_method":"COD","shipping":{"city":"Pune","express":true},"status":"pending"}'::jsonb

    WHEN 4 THEN
        '{"payment_method":"UPI","shipping":{"city":"Pune","express":false},"status":"shipped"}'::jsonb

    WHEN 5 THEN
        '{"payment_method":"Card","shipping":{"city":"Pune","express":true},"status":"delivered"}'::jsonb

    WHEN 6 THEN
        '{"payment_method":"COD","shipping":{"city":"Delhi","express":false},"status":"pending"}'::jsonb

    WHEN 7 THEN
        '{"payment_method":"UPI","shipping":{"city":"Chennai","express":true},"status":"shipped"}'::jsonb

    WHEN 8 THEN
        '{"payment_method":"Card","shipping":{"city":"Kolkata","express":false},"status":"delivered"}'::jsonb

    WHEN 9 THEN
        '{"payment_method":"UPI","shipping":{"city":"Hyderabad","express":true},"status":"pending"}'::jsonb

    WHEN 10 THEN
        '{"payment_method":"COD","shipping":{"city":"Mumbai","express":false},"status":"shipped"}'::jsonb

    WHEN 11 THEN
        '{"payment_method":"Card","shipping":{"city":"Pune","express":true},"status":"delivered"}'::jsonb

END
WHERE order_id BETWEEN 1 AND 11;
UPDATE 11
orderdb=# UPDATE products
SET
    tags = CASE product_id

        WHEN 101 THEN ARRAY['electronics','new']
        WHEN 102 THEN ARRAY['electronics','sale','new']
        WHEN 103 THEN ARRAY['electronics','new']
        WHEN 104 THEN ARRAY['furniture','office','new']
        WHEN 105 THEN ARRAY['furniture','office','sale']
        WHEN 106 THEN ARRAY['stationery','office','new']
        WHEN 107 THEN ARRAY['stationery','sale']
        WHEN 108 THEN ARRAY['home','new']
        WHEN 109 THEN ARRAY['travel','sale']
        WHEN 110 THEN ARRAY['electronics','office','new']

    END,

    monthly_sales = CASE product_id

        WHEN 101 THEN ARRAY[20,25,30,28,35,40]
        WHEN 102 THEN ARRAY[30,35,40,45,50,55]
        WHEN 103 THEN ARRAY[25,28,32,35,40,45]
        WHEN 104 THEN ARRAY[15,18,20,22,25,30]
        WHEN 105 THEN ARRAY[10,15,18,20,25,28]
        WHEN 106 THEN ARRAY[40,45,50,55,60,65]
        WHEN 107 THEN ARRAY[35,40,45,50,55,60]
        WHEN 108 THEN ARRAY[20,22,25,28,30,35]
        WHEN 109 THEN ARRAY[18,20,23,25,28,32]
        WHEN 110 THEN ARRAY[12,18,24,30,36,42]

    END
WHERE product_id BETWEEN 101 AND 110;
NOTICE:  Product :Laptop
NOTICE:  OLD Price:60000.00
NOTICE:  New Price:60000.00
NOTICE:  Product :Smartphone
NOTICE:  OLD Price:25000.00
NOTICE:  New Price:25000.00
NOTICE:  Product :Headphones
NOTICE:  OLD Price:2000.00
NOTICE:  New Price:2000.00
NOTICE:  Product :Office Chair
NOTICE:  OLD Price:5000.00
NOTICE:  New Price:5000.00
NOTICE:  Product :Desk
NOTICE:  OLD Price:8000.00
NOTICE:  New Price:8000.00
NOTICE:  Product :Notebook
NOTICE:  OLD Price:50.00
NOTICE:  New Price:50.00
NOTICE:  Product :Pen
NOTICE:  OLD Price:10.00
NOTICE:  New Price:10.00
NOTICE:  Product :Water Bottle
NOTICE:  OLD Price:300.00
NOTICE:  New Price:300.00
NOTICE:  Product :Backpack
NOTICE:  OLD Price:1500.00
NOTICE:  New Price:1500.00
NOTICE:  Product :Monitor
NOTICE:  OLD Price:12000.00
NOTICE:  New Price:12000.00
UPDATE 10
orderdb=# SELECT order_id, order_meta
FROM orders
ORDER BY order_id;
 order_id |                                              order_meta                                              
----------+------------------------------------------------------------------------------------------------------
        1 | {"status": "delivered", "shipping": {"city": "Mumbai", "express": true}, "payment_method": "UPI"}
        2 | {"status": "shipped", "shipping": {"city": "Mumbai", "express": false}, "payment_method": "Card"}
        3 | {"status": "pending", "shipping": {"city": "Pune", "express": true}, "payment_method": "COD"}
        4 | {"status": "shipped", "shipping": {"city": "Pune", "express": false}, "payment_method": "UPI"}
        5 | {"status": "delivered", "shipping": {"city": "Pune", "express": true}, "payment_method": "Card"}
        6 | {"status": "pending", "shipping": {"city": "Delhi", "express": false}, "payment_method": "COD"}
        7 | {"status": "shipped", "shipping": {"city": "Chennai", "express": true}, "payment_method": "UPI"}
        8 | {"status": "delivered", "shipping": {"city": "Kolkata", "express": false}, "payment_method": "Card"}
        9 | {"status": "pending", "shipping": {"city": "Hyderabad", "express": true}, "payment_method": "UPI"}
       10 | {"status": "shipped", "shipping": {"city": "Mumbai", "express": false}, "payment_method": "COD"}
       11 | {"status": "delivered", "shipping": {"city": "Pune", "express": true}, "payment_method": "Card"}
(11 rows)

orderdb=# SELECT product_id, product_name, tags, monthly_sales
FROM products
ORDER BY product_id;
 product_id | product_name |           tags           |    monthly_sales    
------------+--------------+--------------------------+---------------------
        101 | Laptop       | {electronics,new}        | {20,25,30,28,35,40}
        102 | Smartphone   | {electronics,sale,new}   | {30,35,40,45,50,55}
        103 | Headphones   | {electronics,new}        | {25,28,32,35,40,45}
        104 | Office Chair | {furniture,office,new}   | {15,18,20,22,25,30}
        105 | Desk         | {furniture,office,sale}  | {10,15,18,20,25,28}
        106 | Notebook     | {stationery,office,new}  | {40,45,50,55,60,65}
        107 | Pen          | {stationery,sale}        | {35,40,45,50,55,60}
        108 | Water Bottle | {home,new}               | {20,22,25,28,30,35}
        109 | Backpack     | {travel,sale}            | {18,20,23,25,28,32}
        110 | Monitor      | {electronics,office,new} | {12,18,24,30,36,42}
(10 rows)

orderdb=# -- Assignment 11, Q1
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       order_meta ->> 'payment_method' AS payment_method
FROM orders;
 order_id | payment_method 
----------+----------------
        1 | UPI
        2 | Card
        3 | COD
        4 | UPI
        5 | Card
        6 | COD
        7 | UPI
        8 | Card
        9 | UPI
       10 | COD
       11 | Card
(11 rows)

orderdb=# -- Assignment 11, Q2
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       order_meta -> 'shipping' ->> 'city' AS shipping_city
FROM orders;
 order_id | shipping_city 
----------+---------------
        1 | Mumbai
        2 | Mumbai
        3 | Pune
        4 | Pune
        5 | Pune
        6 | Delhi
        7 | Chennai
        8 | Kolkata
        9 | Hyderabad
       10 | Mumbai
       11 | Pune
(11 rows)

orderdb=# -- Assignment 11, Q3
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       order_meta ->> 'payment_method' AS payment_method
FROM orders
WHERE order_meta ->> 'status' IN ('pending', 'shipped');
 order_id | payment_method 
----------+----------------
        2 | Card
        3 | COD
        4 | UPI
        6 | COD
        7 | UPI
        9 | UPI
       10 | COD
(7 rows)

orderdb=# -- Assignment 11, Q4
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_meta ->> 'payment_method' AS payment_method,
       COUNT(*) AS order_count
FROM orders
GROUP BY order_meta ->> 'payment_method';
 payment_method | order_count 
----------------+-------------
 UPI            |           4
 COD            |           3
 Card           |           4
(3 rows)

orderdb=# -- Assignment 11, Q5
-- Name: Rima Maji
-- Roll No: 150096725215

UPDATE orders
SET order_meta = jsonb_set(
    order_meta,
    '{status}',
    '"delivered"'
)
WHERE order_id = 3;
UPDATE 1
orderdb=# -- Assignment 12, Q1
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT product_name,
       tags
FROM products
WHERE 'new' = ANY(tags);
 product_name |           tags           
--------------+--------------------------
 Laptop       | {electronics,new}
 Smartphone   | {electronics,sale,new}
 Headphones   | {electronics,new}
 Office Chair | {furniture,office,new}
 Notebook     | {stationery,office,new}
 Water Bottle | {home,new}
 Monitor      | {electronics,office,new}
(7 rows)

orderdb=# -- Assignment 12, Q2
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT product_name
FROM products
WHERE tags @> ARRAY['furniture', 'office'];
 product_name 
--------------
 Office Chair
 Desk
(2 rows)

orderdb=# -- Assignment 12, Q3
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT product_name,
       array_length(tags, 1) AS tag_count
FROM products;
 product_name | tag_count 
--------------+-----------
 Laptop       |         2
 Smartphone   |         3
 Headphones   |         2
 Office Chair |         3
 Desk         |         3
 Notebook     |         3
 Pen          |         2
 Water Bottle |         2
 Backpack     |         2
 Monitor      |         3
(10 rows)

orderdb=# -- Assignment 12, Q4
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT product_name,
       monthly_sales[6] AS june_sales
FROM products
ORDER BY june_sales DESC;
 product_name | june_sales 
--------------+------------
 Notebook     |         65
 Pen          |         60
 Smartphone   |         55
 Headphones   |         45
 Monitor      |         42
 Laptop       |         40
 Water Bottle |         35
 Backpack     |         32
 Office Chair |         30
 Desk         |         28
(10 rows)

orderdb=# -- Assignment 12, Q5
-- Name: Rima Maji
-- Roll No: 150096725215

UPDATE products
SET tags = array_append(tags, 'clearance')
WHERE product_id = 105;
NOTICE:  Product :Desk
NOTICE:  OLD Price:8000.00
NOTICE:  New Price:8000.00
UPDATE 1
orderdb=# -- Assignment 13, Q1
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       order_date,
       TO_CHAR(order_date, 'Month') AS month_name
FROM orders;
 order_id | order_date | month_name 
----------+------------+------------
        1 | 2024-01-05 | January  
        2 | 2024-01-06 | January  
        4 | 2024-01-12 | January  
        5 | 2024-01-15 | January  
        6 | 2024-02-01 | February 
        7 | 2024-02-03 | February 
        8 | 2024-02-10 | February 
        9 | 2024-02-15 | February 
       10 | 2024-02-20 | February 
       11 | 2024-03-01 | March    
        3 | 2024-01-10 | January  
(11 rows)

orderdb=# -- Assignment 13, Q2
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT EXTRACT(YEAR FROM order_date) AS year,
       COUNT(*) AS order_count
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;
 year | order_count 
------+-------------
 2024 |          11
(1 row)

orderdb=# -- Assignment 13, Q3
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       order_date
FROM orders
WHERE order_date >= (
    SELECT MAX(order_date) - INTERVAL '30 days'
    FROM orders
)
AND order_date <= (
    SELECT MAX(order_date)
    FROM orders
);
 order_id | order_date 
----------+------------
        6 | 2024-02-01
        7 | 2024-02-03
        8 | 2024-02-10
        9 | 2024-02-15
       10 | 2024-02-20
       11 | 2024-03-01
(6 rows)

orderdb=# -- Assignment 13, Q4
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT c.customer_name,
       CURRENT_DATE - MAX(o.order_date) AS days_since_last_order
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY c.customer_id;
 customer_name | days_since_last_order 
---------------+-----------------------
 Rahul Sharma  |                   993
 Priya Singh   |                   948
 John Smith    |                   984
 Emma Watson   |                   967
 Wei Chen      |                   965
 Sara Khan     |                   958
 David Miller  |                   953
 Anjali Verma  |                   938
 Tom Brown     |                      
 Lisa Ray      |                      
(10 rows)

orderdb=# -- Assignment 13, Q5
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       order_date,
       TO_CHAR(order_date, 'Day') AS day_of_week
FROM orders;
 order_id | order_date | day_of_week 
----------+------------+-------------
        1 | 2024-01-05 | Friday   
        2 | 2024-01-06 | Saturday 
        4 | 2024-01-12 | Friday   
        5 | 2024-01-15 | Monday   
        6 | 2024-02-01 | Thursday 
        7 | 2024-02-03 | Saturday 
        8 | 2024-02-10 | Saturday 
        9 | 2024-02-15 | Thursday 
       10 | 2024-02-20 | Tuesday  
       11 | 2024-03-01 | Friday   
        3 | 2024-01-10 | Wednesday
(11 rows)

orderdb=# 
