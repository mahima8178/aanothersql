-- -- The LinkedIn Creator team is looking for power creators who use their personal profile as a company or influencer page. If someone's LinkedIn page has more followers than the company they work for, we can safely assume that person is a power creator.

-- Write a query to return the IDs of these LinkedIn power creators.
-- Solution 1: using MAX() aggregate function w/ window function.

WITH CTE as (
    SELECT pp.profile_id, 
           pp.name as creator_name, 
           pp.followers as personal_followers, 
           MAX(cp.followers) OVER(PARTITION BY pp.profile_id, pp.name) as max_company_followers
    FROM   personal_profiles pp JOIN employee_company ec ON pp.profile_id=ec.personal_profile_id 
                                JOIN company_pages cp USING(company_id)
)
SELECT   profile_id, creator_name
FROM     CTE
WHERE    personal_followers > max_company_followers
GROUP BY 1, 2


---sol2
with cte as (
select profile_id, a.name as profile_name, a.followers as profile_followers,
c.name as company_name, c.followers as company_followers
 from personal_profiles a
 inner join employee_company b 
 on (a.profile_id = b.personal_profile_id)
 inner join company_pages c
 on (c.company_id = b.company_id)
 where a.followers > c.followers
 )
 select distinct profile_name from cte
 order by profile_id;
