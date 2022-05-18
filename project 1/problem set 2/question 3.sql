'''
question 3

Finally, for each of these top 10 paying customers, I would like to find out the difference across their monthly payments during 2007.
Please go ahead and write a query to compare the payment amounts in each successive month. Repeat this for each of these 10 paying customers.
Also, it will be tremendously helpful if you can identify the customer name who paid the most difference in terms of payments.
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
),

w3 AS
(
SELECT w1.customer_name as customer_name,
      w1.payment_month_year as payment_date,
      count(*) as payment_count,
      sum(w1.amount) as payment_amount,
      CASE WHEN LAG(sum(w1.amount)) OVER (PARTITION BY customer_name ORDER BY w1.payment_month_year) IS NULL THEN 0
      ELSE sum(w1.amount) - LAG(sum(w1.amount)) OVER (PARTITION BY customer_name ORDER BY w1.payment_month_year) END AS diff_to_prev_month

FROM w1
JOIN w2
ON w1.customer_id = w2.customer_id
WHERE w1.payment_month_year BETWEEN '2006-12-31' AND '2008-01-01'
GROUP BY 1,2
)

SELECT *
FROM w3
ORDER BY diff_to_prev_month DESC
