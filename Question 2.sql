/* Question 2: What is the average replacement cost by film category? 
Also, what is the difference in replacement cost by category compared to the overall average? 

(Window Function, Joins, Temporary Table, Group by) */

/* The CTE below is used to get the overall average of the replacement cost column */
with overall_avg AS (
	SELECT film.film_id,
	AVG(film.replacement_cost) OVER() AS total_avg_replacement_cost
	FROM film)
	

SELECT film_cat.category_id, 
	category.name AS category_name, 
	AVG(film.replacement_cost) AS avg_replacement_cost,
	overall_avg.total_avg_replacement_cost,
	AVG(film.replacement_cost) - overall_avg.total_avg_replacement_cost AS replacement_cost_diff
FROM film_category AS film_cat
JOIN film ON film.film_id = film_cat.film_id
JOIN category ON category.category_id = film_cat.category_id
JOIN overall_avg ON overall_avg.film_id = film_cat.film_id
GROUP BY film_cat.category_id, category.name, overall_avg.total_avg_replacement_cost
ORDER BY replacement_cost_diff DESC

/* The results of this query tell us that Sci-Fi is the most expensive category for replacement cost,
and that the average replacement cost for Sci-FI is $1.17 more expensive than the overall average replacement cost */
