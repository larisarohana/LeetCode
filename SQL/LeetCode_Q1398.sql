/*1398. Customers Who Bought Products A and B but Not C
Description - 
Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them buy this product.

Return the result table ordered by customer_id.

The query result format is in the following example.


Customers table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 1           | Daniel        |
| 2           | Diana         |
| 3           | Elizabeth     |
| 4           | Jhon          |
+-------------+---------------+

Orders table:
+------------+--------------+---------------+
| order_id   | customer_id  | product_name  |
+------------+--------------+---------------+
| 10         |     1        |     A         |
| 20         |     1        |     B         |
| 30         |     1        |     D         |
| 40         |     1        |     C         |
| 50         |     2        |     A         |
| 60         |     3        |     A         |
| 70         |     3        |     B         |
| 80         |     3        |     D         |
| 90         |     4        |     C         |
+------------+--------------+---------------+

Result table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 3           | Elizabeth     |
+-------------+---------------+
Only the customer_id with id 3 bought the product A and B but not the product C.*/

CREATE TABLE Customers_1398 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE Orders_1398 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(50)
);


INSERT INTO Customers_1398 (customer_id, customer_name) VALUES
(1, 'Daniel'),
(2, 'Diana'),
(3, 'Elizabeth'),
(4, 'Jhon');


INSERT INTO Orders_1398 (order_id, customer_id, product_name) VALUES
(10, 1, 'A'),
(20, 1, 'B'),
(30, 1, 'D'),
(40, 1, 'C'),
(50, 2, 'A'),
(60, 3, 'A'),
(70, 3, 'B'),
(80, 3, 'D'),
(90, 4, 'C');


Select * from Customers_1398;

Select * from Orders_1398;


SELECT customer_id
FROM Orders_1398
WHERE product_name = 'B'
 AND customer_id IN (SELECT customer_id
FROM Orders_1398
WHERE product_name = 'A');

SELECT customer_id
FROM Orders_1398
WHERE product_name = 'C';

SELECT customer_id
FROM( SELECT customer_id
FROM Orders_1398
WHERE product_name = 'B'
 AND customer_id IN (SELECT customer_id
FROM Orders_1398
WHERE product_name = 'A')) t1
WHERE t1.customer_id NOT IN (SELECT customer_id
FROM Orders_1398
WHERE product_name = 'C');

SELECT
* FROM
Customers_1398
WHERE customer_id IN (SELECT customer_id
FROM( SELECT customer_id
FROM Orders_1398
WHERE product_name = 'B'
 AND customer_id IN (SELECT customer_id
FROM Orders_1398
WHERE product_name = 'A')) t1
WHERE t1.customer_id NOT IN (SELECT customer_id
FROM Orders_1398
WHERE product_name = 'C')
)