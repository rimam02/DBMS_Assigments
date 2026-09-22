Last login: Tue Sep 22 13:16:29 on ttys018
rimamaji@Rimas-MacBook-Air ~ % psql postgres
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

orderdb=# SELECT * FROM customers;
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

orderdb=# SELECT * FROM products;
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

orderdb=# SELECT * FROM orders;
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

orderdb=# --Assignment 5
orderdb=# --PART A
orderdb=# --Q1
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT customer_name, city, country
orderdb-# FROM customers
orderdb-# WHERE country = 'India'
orderdb-# ORDER BY customer_name ASC;
 customer_name |  city  | country 
---------------+--------+---------
 Anjali Verma  | Pune   | India
 Priya Singh   | Delhi  | India
 Rahul Sharma  | Mumbai | India
(3 rows)

orderdb=# --Q2
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT * FROM products
orderdb-# WHERE category = 'Electronics'
orderdb-# AND price > 10000
orderdb-# ORDER BY price DESC;
 product_id | product_name |  category   |  price   
------------+--------------+-------------+----------
        101 | Laptop       | Electronics | 55000.00
        102 | Smartphone   | Electronics | 25000.00
        110 | Monitor      | Electronics | 12000.00
(3 rows)

orderdb=# --Q3
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT order_id, customer_id, product_id, order_date
orderdb-# FROM orders
orderdb-# WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31';
 order_id | customer_id | product_id | order_date 
----------+-------------+------------+------------
        1 |           1 |        101 | 2024-01-05
        2 |           1 |        103 | 2024-01-06
        3 |           2 |        102 | 2024-01-10
        4 |           3 |        104 | 2024-01-12
        5 |           3 |        105 | 2024-01-15
(5 rows)

orderdb=# --Q4
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT customer_name, country
orderdb-# FROM customers
orderdb-# WHERE country <> 'India';
 customer_name |  country  
---------------+-----------
 John Smith    | USA
 Emma Watson   | UK
 Wei Chen      | China
 Sara Khan     | Pakistan
 David Miller  | Canada
 Tom Brown     | Australia
 Lisa Ray      | USA
(7 rows)

orderdb=# --Q5
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT * FROM products
orderdb-# WHERE product_name LIKE 'L%'
orderdb-# OR category = 'Stationery';
 product_id | product_name |  category   |  price   
------------+--------------+-------------+----------
        101 | Laptop       | Electronics | 55000.00
        106 | Notebook     | Stationery  |    50.00
        107 | Pen          | Stationery  |    10.00
(3 rows)

orderdb=# --Q6
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT * FROM orders
orderdb-# WHERE quantity > 1
orderdb-# ORDER BY order_date ASC;
 order_id | customer_id | product_id | order_date | quantity 
----------+-------------+------------+------------+----------
        2 |           1 |        103 | 2024-01-06 |        2
        4 |           3 |        104 | 2024-01-12 |        2
        6 |           4 |        106 | 2024-02-01 |        5
        7 |           5 |        107 | 2024-02-03 |       10
(4 rows)

orderdb=#  --Assignment 6
orderdb=# --PART B
orderdb=# --Q1
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT product_id, SUM(quantity) AS total_quantity
orderdb-# FROM orders
orderdb-# GROUP BY product_id;
 product_id | total_quantity 
------------+----------------
        101 |              2
        103 |              3
        104 |              2
        105 |              1
        107 |             10
        102 |              2
        106 |              5
(7 rows)

orderdb=# --Q2
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT customer_id, COUNT(*) AS order_count
orderdb-# FROM orders
orderdb-# GROUP BY customer_id
orderdb-# HAVING COUNT(*) > 1;
 customer_id | order_count 
-------------+-------------
           3 |           2
           2 |           2
           1 |           2
(3 rows)

orderdb=# --Q3
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT p.category,
orderdb-# SUM(p.price * o.quantity) AS total_revenue
orderdb-# FROM orders o
orderdb-# JOIN products p
orderdb-# ON o.product_id = p.product_id
orderdb-# GROUP BY p.category;
  category   | total_revenue 
-------------+---------------
 Furniture   |      18000.00
 Electronics |     166000.00
 Stationery  |        350.00
(3 rows)

orderdb=# --Q4
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT category,
orderdb-# AVG(price) AS average_price
orderdb-# FROM products
orderdb-# GROUP BY category
orderdb-# ORDER BY average_price DESC;
  category   |     average_price     
-------------+-----------------------
 Electronics |    23500.000000000000
 Furniture   | 6500.0000000000000000
 Accessories |  900.0000000000000000
 Stationery  |   30.0000000000000000
(4 rows)

orderdb=# --Q5
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT customer_id, COUNT(*) AS order_count
orderdb-# FROM orders
orderdb-# GROUP BY customer_id
orderdb-# HAVING COUNT(*) = (
orderdb(# SELECT MAX(order_count)
orderdb(#  FROM (
orderdb(# SELECT customer_id, COUNT(*) AS order_count
orderdb(# FROM orders
orderdb(# GROUP BY customer_id
orderdb(#  ) AS customer_orders
orderdb(# );
 customer_id | order_count 
-------------+-------------
           3 |           2
           2 |           2
           1 |           2
(3 rows)

orderdb=# --Q6
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT EXTRACT(MONTH FROM order_date) AS month,
orderdb-# SUM(quantity) AS total_quantity
orderdb-# FROM orders
orderdb-# GROUP BY EXTRACT(MONTH FROM order_date)
orderdb-# ORDER BY month;
 month | total_quantity 
-------+----------------
     1 |              7
     2 |             18
(2 rows)

orderdb=# --Assignment 7
orderdb=# --PART C
orderdb=# --Q1
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT o.order_id,
orderdb-# c.customer_name,p.product_name,o.quantity,o.order_date
orderdb-# FROM orders o
orderdb-# INNER JOIN customers c
orderdb-# ON o.customer_id = c.customer_id
orderdb-# INNER JOIN products p
orderdb-# ON o.product_id = p.product_id;
 order_id | customer_name | product_name | quantity | order_date 
----------+---------------+--------------+----------+------------
        1 | Rahul Sharma  | Laptop       |        1 | 2024-01-05
        2 | Rahul Sharma  | Headphones   |        2 | 2024-01-06
        3 | Priya Singh   | Smartphone   |        1 | 2024-01-10
        4 | John Smith    | Office Chair |        2 | 2024-01-12
        5 | John Smith    | Desk         |        1 | 2024-01-15
        6 | Emma Watson   | Notebook     |        5 | 2024-02-01
        7 | Wei Chen      | Pen          |       10 | 2024-02-03
        8 | Sara Khan     | Laptop       |        1 | 2024-02-10
        9 | David Miller  | Smartphone   |        1 | 2024-02-15
       10 | Priya Singh   | Headphones   |        1 | 2024-02-20
(10 rows)

orderdb=# --Q2
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT c.customer_id,
orderdb-# c.customer_name, o.order_id,o.product_id, o.order_date,o.quantity
orderdb-# FROM customers c
orderdb-# LEFT JOIN orders o
orderdb-# ON c.customer_id = o.customer_id;
 customer_id | customer_name | order_id | product_id | order_date | quantity 
-------------+---------------+----------+------------+------------+----------
           1 | Rahul Sharma  |        1 |        101 | 2024-01-05 |        1
           1 | Rahul Sharma  |        2 |        103 | 2024-01-06 |        2
           2 | Priya Singh   |        3 |        102 | 2024-01-10 |        1
           3 | John Smith    |        4 |        104 | 2024-01-12 |        2
           3 | John Smith    |        5 |        105 | 2024-01-15 |        1
           4 | Emma Watson   |        6 |        106 | 2024-02-01 |        5
           5 | Wei Chen      |        7 |        107 | 2024-02-03 |       10
           6 | Sara Khan     |        8 |        101 | 2024-02-10 |        1
           7 | David Miller  |        9 |        102 | 2024-02-15 |        1
           2 | Priya Singh   |       10 |        103 | 2024-02-20 |        1
          10 | Lisa Ray      |          |            |            |         
           8 | Anjali Verma  |          |            |            |         
           9 | Tom Brown     |          |            |            |         
(13 rows)

orderdb=# --Q3
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT p.product_id,p.product_name,o.order_id,o.customer_id,o.order_date,o.quantity
orderdb-# FROM products p
orderdb-# LEFT JOIN orders o
orderdb-# ON p.product_id = o.product_id;
 product_id | product_name | order_id | customer_id | order_date | quantity 
------------+--------------+----------+-------------+------------+----------
        101 | Laptop       |        1 |           1 | 2024-01-05 |        1
        103 | Headphones   |        2 |           1 | 2024-01-06 |        2
        102 | Smartphone   |        3 |           2 | 2024-01-10 |        1
        104 | Office Chair |        4 |           3 | 2024-01-12 |        2
        105 | Desk         |        5 |           3 | 2024-01-15 |        1
        106 | Notebook     |        6 |           4 | 2024-02-01 |        5
        107 | Pen          |        7 |           5 | 2024-02-03 |       10
        101 | Laptop       |        8 |           6 | 2024-02-10 |        1
        102 | Smartphone   |        9 |           7 | 2024-02-15 |        1
        103 | Headphones   |       10 |           2 | 2024-02-20 |        1
        109 | Backpack     |          |             |            |         
        108 | Water Bottle |          |             |            |         
        110 | Monitor      |          |             |            |         
(13 rows)

orderdb=# --Q4
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT c.customer_name,
orderdb-# p.product_name
orderdb-# FROM customers c
orderdb-# CROSS JOIN products p;
 customer_name | product_name 
---------------+--------------
 Rahul Sharma  | Laptop
 Priya Singh   | Laptop
 John Smith    | Laptop
 Emma Watson   | Laptop
 Wei Chen      | Laptop
 Sara Khan     | Laptop
 David Miller  | Laptop
 Anjali Verma  | Laptop
 Tom Brown     | Laptop
 Lisa Ray      | Laptop
 Rahul Sharma  | Smartphone
 Priya Singh   | Smartphone
 John Smith    | Smartphone
 Emma Watson   | Smartphone
 Wei Chen      | Smartphone
 Sara Khan     | Smartphone
 David Miller  | Smartphone
 Anjali Verma  | Smartphone
 Tom Brown     | Smartphone
 Lisa Ray      | Smartphone
 Rahul Sharma  | Headphones
 Priya Singh   | Headphones
 John Smith    | Headphones
 Emma Watson   | Headphones
 Wei Chen      | Headphones
 Sara Khan     | Headphones
 David Miller  | Headphones
 Anjali Verma  | Headphones
 Tom Brown     | Headphones
 Lisa Ray      | Headphones
 Rahul Sharma  | Office Chair
 Priya Singh   | Office Chair
 John Smith    | Office Chair
 Emma Watson   | Office Chair
 Wei Chen      | Office Chair
 Sara Khan     | Office Chair
 David Miller  | Office Chair
 Anjali Verma  | Office Chair
 Tom Brown     | Office Chair
 Lisa Ray      | Office Chair
 Rahul Sharma  | Desk
 Priya Singh   | Desk
 John Smith    | Desk
 Emma Watson   | Desk
 Wei Chen      | Desk
 Sara Khan     | Desk
 David Miller  | Desk
 Anjali Verma  | Desk
 Tom Brown     | Desk
 Lisa Ray      | Desk
 Rahul Sharma  | Notebook
 Priya Singh   | Notebook
 John Smith    | Notebook
 Emma Watson   | Notebook
 Wei Chen      | Notebook
 Sara Khan     | Notebook
 David Miller  | Notebook
 Anjali Verma  | Notebook
 Tom Brown     | Notebook
 Lisa Ray      | Notebook
 Rahul Sharma  | Pen
 Priya Singh   | Pen
 John Smith    | Pen
 Emma Watson   | Pen
 Wei Chen      | Pen
 Sara Khan     | Pen
 David Miller  | Pen
 Anjali Verma  | Pen
 Tom Brown     | Pen
 Lisa Ray      | Pen
 Rahul Sharma  | Water Bottle
 Priya Singh   | Water Bottle
 John Smith    | Water Bottle
 Emma Watson   | Water Bottle
 Wei Chen      | Water Bottle
 Sara Khan     | Water Bottle
 David Miller  | Water Bottle
 Anjali Verma  | Water Bottle
 Tom Brown     | Water Bottle
 Lisa Ray      | Water Bottle
 Rahul Sharma  | Backpack
 Priya Singh   | Backpack
 John Smith    | Backpack
 Emma Watson   | Backpack
 Wei Chen      | Backpack
 Sara Khan     | Backpack
 David Miller  | Backpack
 Anjali Verma  | Backpack
 Tom Brown     | Backpack
 Lisa Ray      | Backpack
 Rahul Sharma  | Monitor
 Priya Singh   | Monitor
 John Smith    | Monitor
 Emma Watson   | Monitor
 Wei Chen      | Monitor
 Sara Khan     | Monitor
 David Miller  | Monitor
 Anjali Verma  | Monitor
 Tom Brown     | Monitor
 Lisa Ray      | Monitor
(100 rows)

orderdb=# --Q5
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT c.customer_id,c.customer_name,
orderdb-# SUM(p.price * o.quantity) AS total_revenue
orderdb-# FROM customers c
orderdb-# INNER JOIN orders o
orderdb-# ON c.customer_id = o.customer_id
orderdb-# INNER JOIN products p
orderdb-# ON o.product_id = p.product_id
orderdb-# GROUP BY c.customer_id, c.customer_name
orderdb-# ORDER BY total_revenue DESC;
 customer_id | customer_name | total_revenue 
-------------+---------------+---------------
           1 | Rahul Sharma  |      59000.00
           6 | Sara Khan     |      55000.00
           2 | Priya Singh   |      27000.00
           7 | David Miller  |      25000.00
           3 | John Smith    |      18000.00
           4 | Emma Watson   |        250.00
           5 | Wei Chen      |        100.00
(7 rows)

orderdb=# --Q6
orderdb=# --Name: Rima Maji
orderdb=# --Rollno:150096725215
orderdb=# SELECT c.customer_id,
orderdb-#  c.customer_name,c.city,c.country
orderdb-# FROM customers c
orderdb-# LEFT JOIN orders o
orderdb-# ON c.customer_id = o.customer_id
orderdb-# WHERE o.order_id IS NULL;
 customer_id | customer_name |  city   |  country  
-------------+---------------+---------+-----------
          10 | Lisa Ray      | Chicago | USA
           8 | Anjali Verma  | Pune    | India
           9 | Tom Brown     | Sydney  | Australia
(3 rows)

orderdb=# 
