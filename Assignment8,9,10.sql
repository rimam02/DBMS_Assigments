Last login: Tue Sep 22 13:39:41 on ttys018
rimamaji@Rimas-MacBook-Air-2 ~ % psql postgres
psql (18.4 (Homebrew))
Type "help" for help.

postgres=# \c orderdb
You are now connected to database "orderdb" as user "rimamaji".
orderdb=# \dt
            List of tables
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | customers | table | rimamaji
 public | orders    | table | rimamaji
 public | products  | table | rimamaji
(3 rows)

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
(10 rows)

orderdb=# select * from products;
 product_id | product_name |  category   |  price   
------------+--------------+-------------+----------
        101 | Laptop       | Electronics | 55000.00
        102 | Smartphone   | Electronics | 25000.00
        103 | Headphones   | Electronics |  2000.00
        104 | Office Chair | Furniture   |  5000.00
        105 | Desk         | Furniture   |  8000.00
        106 | Notebook     | Stationery  |    50.00
        107 | Pen          | Stationery  |    10.00
        108 | Water Bottle | Accessories |   300.00
        109 | Backpack     | Accessories |  1500.00
        110 | Monitor      | Electronics | 12000.00
(10 rows)

orderdb=# -- Assignment 8, Q1
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT customer_name, city
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);
 customer_name |   city   
---------------+----------
 Rahul Sharma  | Mumbai
 Priya Singh   | Delhi
 John Smith    | New York
 Emma Watson   | London
 Wei Chen      | Beijing
 Sara Khan     | Karachi
 David Miller  | Toronto
(7 rows)

orderdb=# -- Assignment 8, Q2
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
 product_name |  price   
--------------+----------
 Laptop       | 55000.00
 Smartphone   | 25000.00
 Monitor      | 12000.00
(3 rows)

orderdb=# -- Assignment 8, Q3
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);
 customer_name 
---------------
 Anjali Verma
 Tom Brown
 Lisa Ray
(3 rows)

orderdb=# -- Assignment 8, Q4
-- Name: Rima Maji
-- Roll No: 150096725215
SELECT c.customer_name,
       (
           SELECT COUNT(*)
           FROM orders o
           WHERE o.customer_id = c.customer_id
       ) AS order_count
FROM customers c;
 customer_name | order_count 
---------------+-------------
 Rahul Sharma  |           2
 Priya Singh   |           2
 John Smith    |           2
 Emma Watson   |           1
 Wei Chen      |           1
 Sara Khan     |           1
 David Miller  |           1
 Anjali Verma  |           0
 Tom Brown     |           0
 Lisa Ray      |           0
(10 rows)

orderdb=# -- Assignment 8, Q5
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.product_id = p.product_id
);
 product_name 
--------------
 Backpack
 Water Bottle
 Monitor
(3 rows)

orderdb=# -- Assignment 9, Q1
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       order_date,
       quantity,
       SUM(quantity) OVER (
           ORDER BY order_date, order_id
       ) AS running_total_quantity
FROM orders;
 order_id | order_date | quantity | running_total_quantity 
----------+------------+----------+------------------------
        1 | 2024-01-05 |        1 |                      1
        2 | 2024-01-06 |        2 |                      3
        3 | 2024-01-10 |        1 |                      4
        4 | 2024-01-12 |        2 |                      6
        5 | 2024-01-15 |        1 |                      7
        6 | 2024-02-01 |        5 |                     12
        7 | 2024-02-03 |       10 |                     22
        8 | 2024-02-10 |        1 |                     23
        9 | 2024-02-15 |        1 |                     24
       10 | 2024-02-20 |        1 |                     25
(10 rows)

orderdb=# -- Assignment 9, Q2
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT order_id,
       quantity,
       AVG(quantity) OVER () AS average_quantity
FROM orders;
 order_id | quantity |  average_quantity  
----------+----------+--------------------
        1 |        1 | 2.5000000000000000
        2 |        2 | 2.5000000000000000
        3 |        1 | 2.5000000000000000
        4 |        2 | 2.5000000000000000
        5 |        1 | 2.5000000000000000
        6 |        5 | 2.5000000000000000
        7 |       10 | 2.5000000000000000
        8 |        1 | 2.5000000000000000
        9 |        1 | 2.5000000000000000
       10 |        1 | 2.5000000000000000
(10 rows)

orderdb=# -- Assignment 9, Q3
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT customer_id,
       order_id,
       order_date,
       quantity,
       SUM(quantity) OVER (
           PARTITION BY customer_id
           ORDER BY order_date, order_id
       ) AS customer_running_total
FROM orders;
 customer_id | order_id | order_date | quantity | customer_running_total 
-------------+----------+------------+----------+------------------------
           1 |        1 | 2024-01-05 |        1 |                      1
           1 |        2 | 2024-01-06 |        2 |                      3
           2 |        3 | 2024-01-10 |        1 |                      1
           2 |       10 | 2024-02-20 |        1 |                      2
           3 |        4 | 2024-01-12 |        2 |                      2
           3 |        5 | 2024-01-15 |        1 |                      3
           4 |        6 | 2024-02-01 |        5 |                      5
           5 |        7 | 2024-02-03 |       10 |                     10
           6 |        8 | 2024-02-10 |        1 |                      1
           7 |        9 | 2024-02-15 |        1 |                      1
(10 rows)

orderdb=# -- Assignment 9, Q4
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT category,
       product_name,
       price,
       AVG(price) OVER (
           PARTITION BY category
       ) AS category_average_price
FROM products;
  category   | product_name |  price   | category_average_price 
-------------+--------------+----------+------------------------
 Accessories | Backpack     |  1500.00 |   900.0000000000000000
 Accessories | Water Bottle |   300.00 |   900.0000000000000000
 Electronics | Headphones   |  2000.00 |     23500.000000000000
 Electronics | Laptop       | 55000.00 |     23500.000000000000
 Electronics | Smartphone   | 25000.00 |     23500.000000000000
 Electronics | Monitor      | 12000.00 |     23500.000000000000
 Furniture   | Desk         |  8000.00 |  6500.0000000000000000
 Furniture   | Office Chair |  5000.00 |  6500.0000000000000000
 Stationery  | Pen          |    10.00 |    30.0000000000000000
 Stationery  | Notebook     |    50.00 |    30.0000000000000000
(10 rows)

orderdb=# -- Assignment 9, Q5
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT category,
       product_name,
       price,
       price - AVG(price) OVER (
           PARTITION BY category
       ) AS difference_from_average
FROM products;
  category   | product_name |  price   | difference_from_average 
-------------+--------------+----------+-------------------------
 Accessories | Backpack     |  1500.00 |    600.0000000000000000
 Accessories | Water Bottle |   300.00 |   -600.0000000000000000
 Electronics | Headphones   |  2000.00 |     -21500.000000000000
 Electronics | Laptop       | 55000.00 |      31500.000000000000
 Electronics | Smartphone   | 25000.00 |       1500.000000000000
 Electronics | Monitor      | 12000.00 |     -11500.000000000000
 Furniture   | Desk         |  8000.00 |   1500.0000000000000000
 Furniture   | Office Chair |  5000.00 |  -1500.0000000000000000
 Stationery  | Pen          |    10.00 |    -20.0000000000000000
 Stationery  | Notebook     |    50.00 |     20.0000000000000000
(10 rows)

orderdb=# -- Assignment 10, Q1
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT customer_id,
       order_id,
       order_date,
       quantity,
       ROW_NUMBER() OVER (
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS row_number
FROM orders;
 customer_id | order_id | order_date | quantity | row_number 
-------------+----------+------------+----------+------------
           1 |        1 | 2024-01-05 |        1 |          1
           1 |        2 | 2024-01-06 |        2 |          2
           2 |        3 | 2024-01-10 |        1 |          1
           2 |       10 | 2024-02-20 |        1 |          2
           3 |        4 | 2024-01-12 |        2 |          1
           3 |        5 | 2024-01-15 |        1 |          2
           4 |        6 | 2024-02-01 |        5 |          1
           5 |        7 | 2024-02-03 |       10 |          1
           6 |        8 | 2024-02-10 |        1 |          1
           7 |        9 | 2024-02-15 |        1 |          1
(10 rows)

orderdb=# -- Assignment 10, Q2
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT category,
       product_name,
       price
FROM (
    SELECT category,
           product_name,
           price,
           ROW_NUMBER() OVER (
               PARTITION BY category
               ORDER BY price DESC
           ) AS rn
    FROM products
) AS ranked_products
WHERE rn = 1;
  category   | product_name |  price   
-------------+--------------+----------
 Accessories | Backpack     |  1500.00
 Electronics | Laptop       | 55000.00
 Furniture   | Desk         |  8000.00
 Stationery  | Notebook     |    50.00
(4 rows)

orderdb=# -- Assignment 10, Q3
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT category,
       product_name,
       price,
       RANK() OVER (
           PARTITION BY category
           ORDER BY price DESC
       ) AS price_rank
FROM products;
  category   | product_name |  price   | price_rank 
-------------+--------------+----------+------------
 Accessories | Backpack     |  1500.00 |          1
 Accessories | Water Bottle |   300.00 |          2
 Electronics | Laptop       | 55000.00 |          1
 Electronics | Smartphone   | 25000.00 |          2
 Electronics | Monitor      | 12000.00 |          3
 Electronics | Headphones   |  2000.00 |          4
 Furniture   | Desk         |  8000.00 |          1
 Furniture   | Office Chair |  5000.00 |          2
 Stationery  | Notebook     |    50.00 |          1
 Stationery  | Pen          |    10.00 |          2
(10 rows)

orderdb=# -- Assignment 10, Q4
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT customer_id,
       total_quantity,
       RANK() OVER (
           ORDER BY total_quantity DESC
       ) AS customer_rank
FROM (
    SELECT customer_id,
           SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY customer_id
) AS customer_totals
WHERE total_quantity IS NOT NULL
ORDER BY customer_rank
LIMIT 3;
 customer_id | total_quantity | customer_rank 
-------------+----------------+---------------
           5 |             10 |             1
           4 |              5 |             2
           1 |              3 |             3
(3 rows)

orderdb=# -- Assignment 10, Q5
-- Name: Rima Maji
-- Roll No: 150096725215

SELECT product_name,
       price,
       DENSE_RANK() OVER (
           ORDER BY price DESC
       ) AS price_rank
FROM products
ORDER BY price_rank
LIMIT 5;
 product_name |  price   | price_rank 
--------------+----------+------------
 Laptop       | 55000.00 |          1
 Smartphone   | 25000.00 |          2
 Monitor      | 12000.00 |          3
 Desk         |  8000.00 |          4
 Office Chair |  5000.00 |          5
(5 rows)


orderdb=# 
