'''
question 3

Finally, provide a table with the family-friendly film category, each of the quartiles,
and the corresponding count of movies within each combination of film category for each corresponding rental duration category.
The resulting table should have three columns:
- Category
- Rental length category
- Count
'''

WITH w1 AS
(SELECT f.title as film_title,
      c.name as category_name,
      f.rental_duration as rental_duration,
      NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
FROM film f
JOIN film_category fc
ON fc.film_id = f.film_id
JOIN category c
ON c.category_id = fc.category_id
AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music'))

SELECT w1.category_name, w1.standard_quartile, count(*)
FROM w1
GROUP BY 1,2
ORDER BY 1,2
