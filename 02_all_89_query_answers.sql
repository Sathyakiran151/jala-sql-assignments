-- JALA SQL Assignment - All 89 Query Answers
-- MySQL compatible queries
USE jala_sql;

-- 1. Display snum, sname, city and comm of all salespeople.
SELECT snum, sname, city, comm FROM salespeople;

-- 2. Display all snum without duplicates from all orders.
SELECT DISTINCT snum FROM orders;

-- 3. Display names and commissions of all salespeople in London.
SELECT sname, comm FROM salespeople WHERE city = 'London';

-- 4. All customers with rating of 100.
SELECT * FROM cust WHERE rating = 100;

-- 5. Produce order number, amount and date from all rows in the order table.
SELECT onum, amt, odate FROM orders;

-- 6. All customers in San Jose who have rating more than 200.
SELECT * FROM cust WHERE city = 'San Jose' AND rating > 200;

-- 7. All customers who were either located in San Jose or had a rating above 200.
SELECT * FROM cust WHERE city = 'San Jose' OR rating > 200;

-- 8. All orders for more than $1000.
SELECT * FROM orders WHERE amt > 1000;

-- 9. Names and cities of all salespeople in London with commission above 0.10.
SELECT sname, city FROM salespeople WHERE city = 'London' AND comm > 0.10;

-- 10. All customers excluding rating <= 100 unless they are located in Rome.
SELECT * FROM cust WHERE rating > 100 OR city = 'Rome';

-- 11. All salespeople either in Barcelona or in London.
SELECT * FROM salespeople WHERE city IN ('Barcelona', 'London');

-- 12. Salespeople with commission between 0.10 and 0.12 excluding boundaries.
SELECT * FROM salespeople WHERE comm > 0.10 AND comm < 0.12;

-- 13. All customers with NULL values in city column.
SELECT * FROM cust WHERE city IS NULL;

-- 14. All orders taken on Oct 3rd and Oct 4th 1994.
SELECT * FROM orders WHERE odate IN ('1994-10-03', '1994-10-04');

-- 15. All customers serviced by Peel or Motika.
SELECT c.* FROM cust c JOIN salespeople s ON c.snum = s.snum WHERE s.sname IN ('Peel', 'Motika');

-- 16. All customers whose names begin with a letter from A to B.
SELECT * FROM cust WHERE cname LIKE 'A%' OR cname LIKE 'B%';

-- 17. All orders except those with 0 or NULL value in amt field.
SELECT * FROM orders WHERE amt IS NOT NULL AND amt <> 0;

-- 18. Count salespeople currently listing orders.
SELECT COUNT(DISTINCT snum) AS salesperson_count FROM orders;

-- 19. Largest order taken by each salesperson, datewise.
SELECT snum, odate, MAX(amt) AS largest_order FROM orders GROUP BY snum, odate ORDER BY snum, odate;

-- 20. Largest order taken by each salesperson with order value more than $3000.
SELECT snum, MAX(amt) AS largest_order FROM orders GROUP BY snum HAVING MAX(amt) > 3000;

-- 21. Which day had the highest total amount ordered.
SELECT odate, SUM(amt) AS total_amount FROM orders GROUP BY odate ORDER BY total_amount DESC LIMIT 1;

-- 22. Count all orders for Oct 3rd.
SELECT COUNT(*) AS order_count FROM orders WHERE odate = '1994-10-03';

-- 23. Count different non-NULL city values in customers table.
SELECT COUNT(DISTINCT city) AS city_count FROM cust WHERE city IS NOT NULL;

-- 24. Select each customer's smallest order.
SELECT cnum, MIN(amt) AS smallest_order FROM orders GROUP BY cnum;

-- 25. First customer alphabetically whose name begins with G.
SELECT cname FROM cust WHERE cname LIKE 'G%' ORDER BY cname LIMIT 1;

-- 26. Output: For dd/mm/yy there are ___ orders.
SELECT CONCAT('For ', DATE_FORMAT(odate, '%d/%m/%y'), ' there are ', COUNT(*), ' orders.') AS result
FROM orders GROUP BY odate ORDER BY odate;

-- 27. 12% commission for each order.
SELECT onum, snum, amt * 0.12 AS commission_amount FROM orders;

-- 28. Highest rating in each city.
SELECT CONCAT('For the city ', city, ', the highest rating is: ', MAX(rating)) AS result FROM cust GROUP BY city;

-- 29. Totals of orders for each day in descending order.
SELECT odate, SUM(amt) AS total_amount FROM orders GROUP BY odate ORDER BY total_amount DESC;

-- 30. Salespeople and customers sharing same city.
SELECT s.sname, c.cname, s.city FROM salespeople s JOIN cust c ON s.city = c.city;

-- 31. Customers matched with salespeople serving them.
SELECT c.cname, s.sname FROM cust c JOIN salespeople s ON c.snum = s.snum;

-- 32. Order number and customer name.
SELECT o.onum, c.cname FROM orders o JOIN cust c ON o.cnum = c.cnum;

-- 33. Order number, salesperson name and customer name.
SELECT o.onum, s.sname, c.cname FROM orders o JOIN salespeople s ON o.snum = s.snum JOIN cust c ON o.cnum = c.cnum;

-- 34. Customers serviced by salespeople with commission above 12%.
SELECT c.* FROM cust c JOIN salespeople s ON c.snum = s.snum WHERE s.comm > 0.12;

-- 35. Salesperson commission on each order with rating above 100.
SELECT o.onum, s.sname, c.cname, o.amt, s.comm, o.amt * s.comm AS commission_amount
FROM orders o JOIN cust c ON o.cnum = c.cnum JOIN salespeople s ON o.snum = s.snum
WHERE c.rating > 100;

-- 36. All pairs of customers having same rating.
SELECT c1.cname AS customer1, c2.cname AS customer2, c1.rating FROM cust c1 JOIN cust c2 ON c1.rating = c2.rating WHERE c1.cnum <> c2.cnum;

-- 37. Same rating pairs once only.
SELECT c1.cname AS customer1, c2.cname AS customer2, c1.rating FROM cust c1 JOIN cust c2 ON c1.rating = c2.rating WHERE c1.cnum < c2.cnum;

-- 38. Assign three salespeople to each customer.
SELECT c.cname, s.sname FROM cust c CROSS JOIN (SELECT * FROM salespeople ORDER BY snum LIMIT 3) s ORDER BY c.cname, s.sname;

-- 39. Customers located in cities where Serres has customers.
SELECT * FROM cust WHERE city IN (
    SELECT c.city FROM cust c JOIN salespeople s ON c.snum = s.snum WHERE s.sname = 'Serres'
);

-- 40. Pairs of customers served by same salesperson.
SELECT c1.cname AS customer1, c2.cname AS customer2, c1.snum FROM cust c1 JOIN cust c2 ON c1.snum = c2.snum WHERE c1.cnum < c2.cnum;

-- 41. Pairs of salespeople living in same city.
SELECT s1.sname AS salesperson1, s2.sname AS salesperson2, s1.city FROM salespeople s1 JOIN salespeople s2 ON s1.city = s2.city WHERE s1.snum < s2.snum;

-- 42. Pairs of orders by same customer.
SELECT c.cname, o1.onum AS order1, o2.onum AS order2 FROM orders o1 JOIN orders o2 ON o1.cnum = o2.cnum JOIN cust c ON o1.cnum = c.cnum WHERE o1.onum < o2.onum;

-- 43. Customers with same rating as Hoffman.
SELECT cname, city FROM cust WHERE rating = (SELECT rating FROM cust WHERE cname = 'Hoffman') AND cname <> 'Hoffman';

-- 44. All orders of Motika.
SELECT o.* FROM orders o JOIN salespeople s ON o.snum = s.snum WHERE s.sname = 'Motika';

-- 45. Orders credited to salesperson who services Hoffman.
SELECT * FROM orders WHERE snum = (SELECT snum FROM cust WHERE cname = 'Hoffman');

-- 46. Orders greater than average for Oct 4.
SELECT * FROM orders WHERE amt > (SELECT AVG(amt) FROM orders WHERE odate = '1994-10-04');

-- 47. Average commission of salespeople in London.
SELECT AVG(comm) AS average_commission FROM salespeople WHERE city = 'London';

-- 48. Orders attributed to salespeople servicing customers in London.
SELECT * FROM orders WHERE snum IN (SELECT snum FROM cust WHERE city = 'London');

-- 49. Commissions of salespeople servicing customers in London.
SELECT DISTINCT s.comm FROM salespeople s JOIN cust c ON s.snum = c.snum WHERE c.city = 'London';

-- 50. Customers whose cnum is 1000 above the snum of Serres.
SELECT * FROM cust WHERE cnum = (SELECT snum + 1000 FROM salespeople WHERE sname = 'Serres');

-- 51. Count customers with rating above San Jose average.
SELECT COUNT(*) AS customer_count FROM cust WHERE rating > (SELECT AVG(rating) FROM cust WHERE city = 'San Jose');

-- 52. Orders for customer named Cisnerous.
SELECT o.* FROM orders o JOIN cust c ON o.cnum = c.cnum WHERE c.cname = 'Cisnerous';

-- 53. Names and ratings of customers who have above average orders.
SELECT DISTINCT c.cname, c.rating FROM cust c JOIN orders o ON c.cnum = o.cnum WHERE o.amt > (SELECT AVG(amt) FROM orders);

-- 54. Total order amount for each salesperson greater than largest order in table.
SELECT snum, SUM(amt) AS total_amount FROM orders GROUP BY snum HAVING SUM(amt) > (SELECT MAX(amt) FROM orders);

-- 55. Customers with order on Oct 3.
SELECT DISTINCT c.* FROM cust c JOIN orders o ON c.cnum = o.cnum WHERE o.odate = '1994-10-03';

-- 56. Salespeople having more than one customer.
SELECT s.snum, s.sname FROM salespeople s JOIN cust c ON s.snum = c.snum GROUP BY s.snum, s.sname HAVING COUNT(c.cnum) > 1;

-- 57. Check if correct salesperson was credited with each sale.
SELECT o.onum, o.cnum, o.snum AS order_snum, c.snum AS customer_snum,
CASE WHEN o.snum = c.snum THEN 'Correct' ELSE 'Incorrect' END AS status
FROM orders o JOIN cust c ON o.cnum = c.cnum;

-- 58. Orders above average amount for their customers.
SELECT o.* FROM orders o WHERE o.amt > (SELECT AVG(o2.amt) FROM orders o2 WHERE o2.cnum = o.cnum);

-- 59. Sum amounts by date where sum is at least 2000 above max amount.
SELECT odate, SUM(amt) AS total_amount FROM orders GROUP BY odate HAVING SUM(amt) >= (SELECT MAX(amt) + 2000 FROM orders);

-- 60. Customers with ratings equal to maximum for their city.
SELECT cnum, cname, city, rating FROM cust c1 WHERE rating = (SELECT MAX(rating) FROM cust c2 WHERE c2.city = c1.city);

-- 61A. Salespeople who have customers in their cities whom they do not service. Using JOIN.
SELECT DISTINCT s.* FROM salespeople s JOIN cust c ON s.city = c.city WHERE s.snum <> c.snum;

-- 61B. Same using correlated subquery.
SELECT * FROM salespeople s WHERE EXISTS (SELECT 1 FROM cust c WHERE c.city = s.city AND c.snum <> s.snum);

-- 62. Extract customers if one or more customers are in San Jose.
SELECT cnum, cname, city FROM cust WHERE EXISTS (SELECT 1 FROM cust WHERE city = 'San Jose');

-- 63. Salesperson numbers with multiple customers.
SELECT snum FROM cust GROUP BY snum HAVING COUNT(*) > 1;

-- 64. Salesperson number, name, city with multiple customers.
SELECT s.snum, s.sname, s.city FROM salespeople s JOIN cust c ON s.snum = c.snum GROUP BY s.snum, s.sname, s.city HAVING COUNT(c.cnum) > 1;

-- 65. Salespeople who serve only one customer.
SELECT s.snum, s.sname FROM salespeople s JOIN cust c ON s.snum = c.snum GROUP BY s.snum, s.sname HAVING COUNT(c.cnum) = 1;

-- 66. Salespeople with more than one current order.
SELECT s.* FROM salespeople s JOIN orders o ON s.snum = o.snum GROUP BY s.snum, s.sname, s.city, s.comm HAVING COUNT(o.onum) > 1;

-- 67. Salespeople who have customers with rating 300 using EXISTS.
SELECT * FROM salespeople s WHERE EXISTS (SELECT 1 FROM cust c WHERE c.snum = s.snum AND c.rating = 300);

-- 68. Salespeople who have customers with rating 300 using JOIN.
SELECT DISTINCT s.* FROM salespeople s JOIN cust c ON s.snum = c.snum WHERE c.rating = 300;

-- 69. Salespeople with customers located in their cities but not assigned to them.
SELECT * FROM salespeople s WHERE EXISTS (SELECT 1 FROM cust c WHERE c.city = s.city AND c.snum <> s.snum);

-- 70. Customers assigned to salesperson with at least one other customer having orders.
SELECT * FROM cust c WHERE EXISTS (
    SELECT 1 FROM cust c2 JOIN orders o ON c2.cnum = o.cnum WHERE c2.snum = c.snum AND c2.cnum <> c.cnum
);

-- 71A. Salespeople with customers located in their cities using IN.
SELECT * FROM salespeople s WHERE s.city IN (SELECT city FROM cust WHERE snum = s.snum);

-- 71B. Salespeople with customers located in their cities using ANY.
SELECT * FROM salespeople s WHERE s.city = ANY (SELECT city FROM cust WHERE snum = s.snum);

-- 72A. Salespeople for whom customers follow them alphabetically using ANY.
SELECT * FROM salespeople s WHERE s.sname < ANY (SELECT cname FROM cust);

-- 72B. Same using EXISTS.
SELECT * FROM salespeople s WHERE EXISTS (SELECT 1 FROM cust c WHERE c.cname > s.sname);

-- 73. Customers with greater rating than any customer in Rome.
SELECT * FROM cust WHERE rating > ANY (SELECT rating FROM cust WHERE city = 'Rome');

-- 74. Orders with amounts greater than at least one order from Oct 6.
SELECT * FROM orders WHERE amt > ANY (SELECT amt FROM orders WHERE odate = '1994-10-06');

-- 75A. Orders with amounts smaller than any amount for a San Jose customer.
SELECT * FROM orders WHERE amt < ANY (
    SELECT o.amt FROM orders o JOIN cust c ON o.cnum = c.cnum WHERE c.city = 'San Jose'
);

-- 75B. Same without ANY.
SELECT * FROM orders WHERE amt < (
    SELECT MAX(o.amt) FROM orders o JOIN cust c ON o.cnum = c.cnum WHERE c.city = 'San Jose'
);

-- 76A. Customers whose ratings are higher than every customer in Paris using ALL.
SELECT * FROM cust WHERE rating > ALL (SELECT rating FROM cust WHERE city = 'Paris');

-- 76B. Same using NOT EXISTS.
SELECT * FROM cust c WHERE NOT EXISTS (
    SELECT 1 FROM cust p WHERE p.city = 'Paris' AND c.rating <= p.rating
);

-- 77. Customers whose ratings are equal to or greater than ANY of Serres' customers.
SELECT * FROM cust WHERE rating >= ANY (
    SELECT c.rating FROM cust c JOIN salespeople s ON c.snum = s.snum WHERE s.sname = 'Serres'
);

-- 78A. Salespeople who have no customers located in their city using NOT EXISTS.
SELECT * FROM salespeople s WHERE NOT EXISTS (
    SELECT 1 FROM cust c WHERE c.snum = s.snum AND c.city = s.city
);

-- 78B. Using ALL.
SELECT * FROM salespeople s WHERE s.city <> ALL (SELECT c.city FROM cust c WHERE c.snum = s.snum);

-- 79. Orders for amounts greater than any for customers in London.
SELECT * FROM orders WHERE amt > ANY (
    SELECT o.amt FROM orders o JOIN cust c ON o.cnum = c.cnum WHERE c.city = 'London'
);

-- 80. Salespeople and customers located in London.
SELECT sname AS name, city, 'Salesperson' AS type FROM salespeople WHERE city = 'London'
UNION
SELECT cname AS name, city, 'Customer' AS type FROM cust WHERE city = 'London';

-- 81. For every salesperson, dates on which highest and lowest orders were brought.
SELECT snum, odate, amt,
CASE
    WHEN amt = (SELECT MAX(o2.amt) FROM orders o2 WHERE o2.snum = orders.snum) THEN 'Highest'
    WHEN amt = (SELECT MIN(o2.amt) FROM orders o2 WHERE o2.snum = orders.snum) THEN 'Lowest'
END AS order_type
FROM orders
WHERE amt = (SELECT MAX(o2.amt) FROM orders o2 WHERE o2.snum = orders.snum)
   OR amt = (SELECT MIN(o2.amt) FROM orders o2 WHERE o2.snum = orders.snum)
ORDER BY snum;

-- 82. List all salespeople and indicate if they have customers in their cities.
SELECT s.snum, s.sname, s.city,
CASE WHEN EXISTS (SELECT 1 FROM cust c WHERE c.city = s.city)
     THEN 'Has customer in same city'
     ELSE 'No customer in same city'
END AS status
FROM salespeople s;

-- 83. Append strings indicating whether salesperson matched a customer in his city.
SELECT s.sname,
CONCAT(s.city, ' - ',
CASE WHEN EXISTS (SELECT 1 FROM cust c WHERE c.city = s.city AND c.snum = s.snum)
     THEN 'Matched to customer in same city'
     ELSE 'Not matched to customer in same city'
END) AS city_status
FROM salespeople s;

-- 84. Union showing names, cities, ratings with High/Low Rating.
SELECT cname, city, rating, 'High Rating' AS rating_status FROM cust WHERE rating >= 200
UNION
SELECT cname, city, rating, 'Low Rating' AS rating_status FROM cust WHERE rating < 200;

-- 85. Salespeople and customers with more than one current order, alphabetical order.
SELECT s.sname AS name, s.snum AS number, 'Salesperson' AS type
FROM salespeople s JOIN orders o ON s.snum = o.snum
GROUP BY s.snum, s.sname HAVING COUNT(o.onum) > 1
UNION
SELECT c.cname AS name, c.cnum AS number, 'Customer' AS type
FROM cust c JOIN orders o ON c.cnum = o.cnum
GROUP BY c.cnum, c.cname HAVING COUNT(o.onum) > 1
ORDER BY name;

-- 86. Union of salespeople in San Jose, customers in San Jose, and orders on Oct 3.
SELECT snum AS number, 'Salesperson' AS type FROM salespeople WHERE city = 'San Jose'
UNION
SELECT cnum AS number, 'Customer' AS type FROM cust WHERE city = 'San Jose'
UNION ALL
SELECT onum AS number, 'Order' AS type FROM orders WHERE odate = '1994-10-03';

-- 87. Salespeople in London who had at least one customer there.
SELECT DISTINCT s.* FROM salespeople s JOIN cust c ON s.snum = c.snum WHERE s.city = 'London' AND c.city = 'London';

-- 88. Salespeople in London who did not have customers there.
SELECT * FROM salespeople s WHERE s.city = 'London'
AND NOT EXISTS (SELECT 1 FROM cust c WHERE c.snum = s.snum AND c.city = 'London');

-- 89. Salespeople matched to customers without excluding salespeople without customers.
SELECT s.snum, s.sname, s.city AS salesperson_city, c.cnum, c.cname, c.city AS customer_city
FROM salespeople s LEFT JOIN cust c ON s.snum = c.snum
ORDER BY s.snum, c.cnum;
