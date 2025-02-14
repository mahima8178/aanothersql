-- Find the room types that are searched most number of times.
-- Output the room type alongside the number of searches for it.
-- If the filter for room types has more than one room type, consider each unique room type as a separate row.
-- Sort the result based on the number of searches in descending order.

SELECT   value, COUNT(*) as count
FROM     airbnb_searches, UNNEST(STRING_TO_ARRAY(filter_room_types, ',')) AS value
GROUP BY 1
ORDER BY 2 DESC, 1

-- 2
WITH exploded AS (
    -- Split the comma-separated values into an array and expand them into rows
    SELECT unnest(string_to_array(filter_room_types, ',')) AS room_type
    FROM airbnb_searches
)
-- Count occurrences of each room_type
SELECT room_type, COUNT(*) AS no_of_searches
FROM exploded
GROUP BY room_type
ORDER BY no_of_searches DESC;


