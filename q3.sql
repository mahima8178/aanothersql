


-- 1-out , 2 in , 3--in ,, 4-in - 5 - out
-- 
-- In this video we are going to discuss a SQL interview problem where we need to find number of employees inside the hospital. I will solve this problem with 3 methods:

WITH CTE AS (
SELECT *, ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY time desc) as rn
	FROM   hospital)
SELECT * FROM CTE 
WHERE rn = 1 AND action='in'  
----
-- #2
WITH CTE as (	
	SELECT   emp_id, 
	         MAX(CASE WHEN action='in' THEN time END) AS intime,
	         MAX(CASE WHEN action='out' THEN time END) AS outtime
	FROM     hospital
	GROUP BY 1
)
SELECT COUNT(*) as people_inside
FROM   CTE
WHERE  intime > outtime OR outtime IS NULL