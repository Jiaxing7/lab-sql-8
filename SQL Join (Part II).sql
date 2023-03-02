USE sakila;
-- 1.
SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a 
USING (address_id)
JOIN city c
USING (city_id)
JOIN country co 
USING (country_id);

-- 2.
SELECT s.store_id, CONCAT('$', SUM(p.amount)) AS business
FROM payment p
JOIN store s
ON p.staff_id = s.manager_staff_id
GROUP BY s.store_id;

-- 3.
SELECT  c.name, SUM(length) AS time
FROM film f
JOIN film_category fc
USING (film_id)
JOIN category c
USING (category_id)
GROUP BY c.name
ORDER BY time DESC
LIMIT 1;

-- 4
SELECT f.title, COUNT(r.rental_id) AS rent_frequency
FROM rental r
JOIN inventory i
USING (inventory_id)
JOIN film f
USING(film_id)
GROUP BY f.film_id
ORDER BY rent_frequency DESC;

-- 5
SELECT c.name AS genre, SUM(p.amount) AS revenue
FROM payment p
JOIN rental r
USING(customer_id)
JOIN inventory i
USING (inventory_id)
JOIN film_category fc
USING(film_id)
JOIN category c 
USING(category_id)
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5;

-- 6
SELECT 
CASE
WHEN COUNT(i.inventory_id) > 0 then 'yes'
ELSE 'no'
END AS available_for_rent
FROM film f
JOIN inventory i
USING(film_id)
JOIN rental r
USING (inventory_id)
WHERE i.store_id = 1 AND f.title = 'Academy Dinosaur';

-- 7
SELECT DISTINCT a.first_name, a.last_name, fa1.film_id
FROM film_actor fa1
JOIN film_actor fa2
ON (fa1.film_id = fa2.film_id) AND (fa1.actor_id <> fa2.actor_id)
JOIN actor a
ON a.actor_id = fa1.actor_id
ORDER BY fa1.film_id;

-- 8  WRONG!!
SELECT r1.customer_id, COUNT(i1.film_id) AS film_rent_time
FROM inventory i1
JOIN inventory i2
ON i1.film_id = i2.film_id
JOIN rental r1
ON i1.inventory_id = r1.inventory_id
JOIN rental r2
ON r1.customer_id <> r2.customer_id AND i1.film_id = i2.film_id
GROUP BY r1.customer_id
HAVING film_rent_time >3;


