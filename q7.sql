-- -- For every customer that bought Photoshop, return a list of customers, and the total spent on all the products except for Photoshop products.

-- -- Link: https://datalemur.com/questions/photoshop-revenue-analysis

-- For every customer that bought Photoshop, return a list of customers, and the total spent on all the products except for Photoshop products.
--sol1
SELECT   customer_id, SUM(revenue) AS revenue
FROM     adobe_transactions
WHERE    customer_id IN (
              SELECT DISTINCT customer_id 
              FROM   adobe_transactions 
              WHERE  product = 'Photoshop'
          )
         AND product != 'Photoshop' 
GROUP BY 1

-- -sol2 cte yo

with cte as(
select customer_id,
sum(revenue) as rev
from adobe_transactions 
where customer_id in
(select distinct customer_id where product = "Photoshop")
group by 1
)
select a.customer_id, rev as revenue
from adobe_transactions a
inner join cte c
on a.customer_id = c.customer_id and product = "Photoshop"


---
-- Solution 3: using EXISTS (better practice to use instead of IN)

SELECT   customer_id, SUM(revenue) AS revenue
FROM     adobe_transactions a
WHERE    EXISTS (
              SELECT 1
              FROM   adobe_transactions b
              WHERE  product = 'Photoshop' and
                     a.customer_id = b.customer_id
          )
         AND product != 'Photoshop' 
GROUP BY 1