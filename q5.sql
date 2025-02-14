-- Solution 1: using INNER JOIN
---- write a query to return all employee whose salary is same in same department
WITH cte AS (
	SELECT   dept_id, salary
	FROM     emp_salary
	GROUP BY 1, 2
	HAVING   COUNT(*) > 1
)
SELECT es.emp_id, es.name, c.salary, c.dept_id
FROM cte as c INNER JOIN emp_salary es 
ON es.dept_id=c.dept_id and es.salary=c.salary


-- sol2
WITH CTE AS (
	SELECT   dept_id, salary
	FROM     emp_salary
	GROUP BY 1, 2
	HAVING   COUNT(*) = 1
)
SELECT emp_id, name, salary, dept_id
FROM   emp_salary es  
LEFT JOIN CTE c
USING(dept_id, salary)
WHERE  c.dept_id IS NULL


--sol3 window fn
WITH cte AS (
  SELECT *,
    COUNT(*) OVER (PARTITION BY dept_id, salary) num_same_sal
  FROM emp_salary
)

SELECT *
FROM cte
WHERE num_same_sal > 1
