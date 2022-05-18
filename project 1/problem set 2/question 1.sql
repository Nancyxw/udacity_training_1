''' question 1

We want to find out how the two stores compare in their count of rental orders during every month for all the years we have data for.
Write a query that returns the store ID for the store, the year and month and the number of rental orders each store has fulfilled for that month.
Your table should include a column for each of the following: year, month, store ID and count of rental orders fulfilled during that month.
'''

SELECT DATE_part('month', r.rental_date) as month,
    DATE_PART('year', r.rental_date) as year,
    s.store_id,
    count(*) as count_rental
FROM rental r
JOIN staff s
ON r.staff_id = s.staff_id
GROUP BY 1,2,3
ORDER BY 4
