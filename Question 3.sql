/* Question 3: How did revenue change month-over-month in 2007 from February to May for all films? */

/* Extracting dateparts, CTEs, subqueries, window functions */

/* CTE created to grab the unique month, total revenue, and month-over-month revenue change from Febuary to May */
WITH rev_per_month AS (
	SELECT DISTINCT EXTRACT (Month FROM payment_date) AS Month,
	SUM(amount) AS total_revenue,
	SUM(amount) - LAG(SUM(amount), 1) OVER() AS change_over_prev_month
	FROM payment
	WHERE 
		(SELECT DISTINCT EXTRACT (Month FROM payment_date) IN (2, 3, 4, 5)) /* subquery filters result for only Feb through May */
	GROUP BY Month
	ORDER BY month ASC)

/* grabbing the data from the CTE above and adding month name into the result */
SELECT r.Month, 
	CASE 
		WHEN r.Month = 2 THEN 'February'
		WHEN r.Month = 3 THEN 'March'
		WHEN r.Month = 4 THEN 'April'
		WHEN r.Month = 5 THEN 'May' 
		END AS month_name,
	r.total_revenue,
	r.change_over_prev_month
FROM rev_per_month as r