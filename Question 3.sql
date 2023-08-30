/* Question 3: How did revenue change month-over-month in 2007 from February to May for all films? */

/* Extracting dateparts, CTEs, subqueries, window functions */

/* CTE created to grab the unique month values from Febuary to May */

SELECT DISTINCT EXTRACT (Month FROM payment_date) AS Month,
	SUM(amount) AS total_revenue,
	SUM(amount) - LAG(SUM(amount), 1) OVER() AS change_over_prev_month
FROM payment
WHERE 
	(SELECT DISTINCT EXTRACT (Month FROM payment_date) IN (2, 3, 4, 5)) /* subquery filters result for only Feb through May */
GROUP BY Month
ORDER BY month ASC;