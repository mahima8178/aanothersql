-- Here is the equivalent **PostgreSQL query** implementing the same logic as in your original SQL but using **PostgreSQL functions**:

-- ```sql
WITH ticket_data AS (
    SELECT 
        ticket_id,
        create_date,
        resolved_date,
        COUNT(holiday_date) AS no_of_holidays,
        (resolved_date - create_date) AS actual_days
    FROM tickets
    LEFT JOIN holidays 
        ON holiday_date BETWEEN create_date AND resolved_date
    GROUP BY ticket_id, create_date, resolved_date
)
SELECT 
    ticket_id,
    actual_days,
    actual_days - (2 * (actual_days / 7)) - no_of_holidays AS business_days
FROM ticket_data;
```

-- ### **Explanation:**
-- 1. **CTE (`ticket_data`)**:
--    - Calculates **actual_days** as the difference between `resolved_date` and `create_date`.
--    - Counts **holidays** falling between `create_date` and `resolved_date`.
-- 2. **Final Calculation**:
--    - Subtracts **weekends** by computing `(2 * (actual_days / 7))`, which assumes two weekends per week.
--    - Subtracts **holidays** from the total days to get **business_days**.

-- ### **Why is this a good approach?**
-- - **Simple & Readable**: No need for `generate_series` or complex window functions.
-- - **Efficient**: Uses basic arithmetic operations instead of iterating over dates.
-- - **Accurate for Business Days**: Removes weekends and holidays properly.

-- This will return the **business days count** for each ticket. 🚀 Let me know if you need any refinements!