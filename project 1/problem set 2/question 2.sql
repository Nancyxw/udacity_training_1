'''question 2

We would like to know who were our top 10 paying customers, how many payments they made on a monthly basis during 2007,
and what was the amount of the monthly payments. Can you write a query to capture the customer name, month and year of payment,
and total payment amount for each month by these top 10 paying customers?
'''

WITH w1 AS
(SELECT CONCAT(c.first_name, ' ', c.last_name) as customer_name,
    c.customer_id as customer_id,
    DATE_TRUNC('month', p.payment_date) as payment_month_year,
    p.amount as amount
FROM customer c
JOIN payment p
ON p.customer_id = c.customer_id),

w2 AS
(
  SELECT w1.customer_id as customer_id, sum(w1.amount)
  FROM w1
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 10
)

SELECT w1.customer_name,
      w1.payment_month_year,
      count(*) as payment_count,
      sum(w1.amount) as payment_amount
FROM w1
JOIN w2
ON w1.customer_id = w2.customer_id
WHERE w1.payment_month_year BETWEEN '2006-12-31' AND '2008-01-01'
GROUP BY 1,2
