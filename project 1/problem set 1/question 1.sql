"""
Question 1
We want to understand more about the movies that families are watching.
The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.

Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.
"""

SELECT f.title as film_title,
      c.name as category_name,
      count(*) as rental_count
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY 1,2
ORDER BY 2,1

### another version ###
WITH all_info AS
(SELECT *
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id)

SELECT all_info.title as film_title,
      all_info.name as category_name,
      count(*) as rental_count
FROM all_info
GROUP BY 1,2
ORDER BY 2,1
