/* Question 5: can we show the average rental cost, rating, and category for each movie 
				and compare that to the average cost for movies with the same rating and category? */
				
/* CTE, Window Function with PARTITION BY, multiple joins */

/* The CTE below grabs all the info we need and gets the overall average rental cost for movies with the same rating and category */
WITH rental_cost_by_category_and_rating AS 
	(SELECT f.film_id,
		f.title,
		f.rating,
		c.name AS film_category,
		f.rental_rate AS rental_cost,
		ROUND(AVG(f.rental_rate) OVER(PARTITION BY f.rating, c.name ORDER BY f.rating, c.name), 2) AS avg_rental_cost_by_rating_and_category
	FROM film AS f
	JOIN film_category AS fc ON fc.film_id = f.film_id
	JOIN category AS c ON c.category_id = fc.category_id)
	

/* Using the CTE above, we can subtract the rental cost per movie from the average rental cost for movies with the same rating and category */
SELECT r.*, 
	r.rental_cost - r.avg_rental_cost_by_rating_and_category AS rental_cost_compared_to_avg
FROM rental_cost_by_category_and_rating AS r