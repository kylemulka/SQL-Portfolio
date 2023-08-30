/* Question 4: What are the movies that the person with the most rentals rented? 
				Which store ID was each of those movies rented from? */

/* This CTE finds the customer with the most rentals, which is Eleanor Hunt with 46 */
WITH most_rentals AS (
	SELECT c.customer_id AS cust_id,
		c.first_name AS first_name,
		c.last_name AS last_name,
		COUNT(r.rental_id) AS total_rentals
	FROM customer AS c
	JOIN rental AS r ON c.customer_id = r.customer_id
	GROUP BY cust_id, first_name, last_name
	ORDER BY total_rentals DESC
	LIMIT 1)
	

/* Now, we can find the titles of the movies Eleanor Hunt rented by joining our query with the CTE above */
SELECT c.customer_id, 
	c.first_name,
	c.last_name,
	r.rental_id,
	film.title AS movie_title,
	inventory.store_id
FROM customer AS c
JOIN rental AS r ON r.customer_id = c.customer_id
JOIN inventory ON inventory.inventory_id = r.inventory_id
JOIN most_rentals ON most_rentals.cust_id = c.customer_id
JOIN film ON film.film_id = inventory.film_id


