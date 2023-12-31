/* Question 1: write a query that shows the list of actors and movies where movie length was greater than 60 minutes */
/* How many rows are there? */
/* answer: 4900 */

SELECT CONCAT(actor.first_name, ' ', actor.last_name) AS full_name, 
	film.title, film.description, film.length
FROM actor
JOIN film_actor AS fa ON fa.actor_id = actor.actor_id
JOIN film ON film.film_id = fa.film_id
WHERE film.length > 60 