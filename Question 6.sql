/* Question 6: Write a query that ranks the day of the month with the highest total revenue in March, April, and May combined. 
				Then, split the revenue amount into 4 quartiles and show which revenue quartile each day falls into.
				(note: there are a few days missing data, so they won't show up) */
			
/* CTEs, extracting dateparts, subqueries, DENSE_RANK() window function */
			
/* The CTE below grabs the day and total revenue by day in March, April, and May combined */
WITH rev_per_day AS	
	(SELECT
		DISTINCT EXTRACT(DAY from payment_date) AS day_of_month,
		SUM(p.amount) AS revenue
	FROM payment AS p
	JOIN rental AS r ON r.rental_id = p.rental_id
	JOIN inventory AS i ON i.inventory_id = r.inventory_id
	JOIN film AS f ON f.film_id = i.film_id
	WHERE 
	 	(SELECT EXTRACT (MONTH from p.payment_date) IN (3, 4, 5))
	GROUP BY day_of_month)
	
/* This query takes all the data from the CTE and uses DENSE_RANK() to rank the days with the highest total revenue
	It also splits the revenue values into 4 quartiles */
SELECT rpd.*,
	DENSE_RANK() OVER(ORDER BY rpd.revenue DESC),
	NTILE(4) OVER()
FROM rev_per_day AS rpd
ORDER BY day_of_month

/* I used DENSE_RANK() instead of RANK() because when there is a tie, the rank after the tie follows a sequential order. I prefer this method in most cases */
/* The result shows that day 30 was the day with the highest total revenue in March, April, and May combined */
