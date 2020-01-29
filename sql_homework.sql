-- 1a Display actor First and Last Name 
SELECT first_name, last_name 
FROM actor;

-- 1b  Create Actor Name 
SELECT Upper(CONCAT(first_name, ' ', last_name)) AS 'Actor Name'
FROM actor;

-- 2a Find ID number with name "Joe" 
SELECT first_name, last_name, actor_id
FROM actor
WHERE first_name = "Joe";

-- 2b Find all actors whose last name contain the letters `GEN` 
SELECT first_name, last_name, actor_id
FROM actor
WHERE last_name = '%GEN%';

-- 2c Find all actors whose last names contain the letters `LI`. In order 
SELECT first_name, last_name, actor_id
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- 2d Using `IN`, display the `country_id` and `country` columns for Afghanistan, Bangladesh, and China 
SELECT country_id, country 
FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. Keep description of every actor, create 
ALTER TABLE actor
ADD COLUMN description blob AFTER last_name;

-- 3b. Delete description column 
alter table actor
Drop COLUMN description;

-- 4a. List last names of actors, how many actors have that last name 
SELECT last_name, count(last_name) AS 'last_name_freq'
FROM actor 
GROUP BY last_name
HAVING 'last_name_freq' >=1;

-- 4b Actors and number of actors with that last name shared, x2
SELECT last_name, count(last_name) AS 'last_name_freq'
FROM actor 
GROUP BY last_name
HAVING 'last_name_freq' >=2;

-- 4c. Fix to "Harpo Williams" 
Update actor
SET first_name = 'Harpo'
where first_name = 'Groucho'
and last_name = 'Williams';

-- 4d. Update the field 
Update actor
SET first_name = 
Case 
When first_name = 'Harpo'
 then 'Groucho'
Else 'Groucho'
End 

-- 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- * 6a Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address'
SELECT s.first_name, s.last_name, a.address
FROM staff s 
JOIN address a 
ON (s.address_id = a.address_id);

-- 6b Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
SELECT s.first_name, s.last_name, SUM(p.amount)
FROM staff as s
INNER JOIN payment as p 
ON p.staff_id - s.staff_id
WHERE month(p.payment_date) = 8 AND YEAR(p.payment_date) = 2005
GROUP BY s.staff_id;

-- 6c List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
SELECT f.title, COUNT(fa.actor_id) AS 'Actors'
FROM film_actor AS fa
INNER JOIN film as f
ON f.film_id = fa.film_id
GROUP BY film.title
ORDER BY actors desc;

-- 6d How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT title, COUNT(inventory_id) AS '# of copies'
FROM film 
INNER JOIN inventory
USING (film_id) 
WHERE title = 'Hunchback Impossible' 
GROUP BY title; 

-- 6e Using the tables 'payment' and 'customer' and the JOIN command 
SELECT c.first_name, c.last_name, SUM(p.amount) AS 'Total Amount Paid' 
FROM payment as p 
INNER JOIN customer as c 
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name; 

-- 7a Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
SELECT title 
FROM film 
WHERE title LIKE 'K%'
OR title LIKE 'O%'
AND language_id IN 
(
SELECT language_id 
FROM language 
WHERE name = 'English'
);

-- 7b. Use subqueries to display all actors who appear in the film `Alone Trip' 
SELECT first_name, last_name 
FROM actor 
WHERE actor_id IN
(
SELECT actor_id 
FROM film_actor 
WHERE film_id = 
)
SELECT film_id
FROM film
WHERE title = 'Alone Trip'
);

-- 7c Retrieve Canadian customers email addresses 
SELECT first_name, last_name, email, country
FROM customer cus 
INNER JOIN address a 
ON (cus.address_id = a.address_id) 
INNER JOIN city as cit
ON (a.city_id = cit.city_id) 
INNER JOIN country as ctr
ON (cit.country_id = ctr.country_id)
WHERE ctr.country = 'canada';

-- 7d. Identify all movies categorized as _family_ films.
SELECT title, c.name
FROM film f 
INNER JOIN film_category fc 
ON (f.film_id = fc.film_id
INNER JOIN category c 
ON (c.category_id = fc.category_id) 
WHERE name = 'family';

-- 7e Freq rented movies in decending order 
SELECT title, COUNT(title) AS 'Rentals'
from film 
INNER JOIN inventory 
ON (film.film_id = inventory.film_id)
INNER JOIN rental 
ON (inventory.inventory_id = rental.inventory_id)
GROUP by title
ORDER BY rentals desc;

-- 7f. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(amount) AS Gross
FROM payment p
INNER JOIN rental as r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory as i
ON (i.inventory_id = r.inventory_id)
INNER JOIN store as s
ON (s.store_id = i.store_id)
GROUP BY s.store_id;

-- 7g Write a query to display for each store its store ID, city, and country
SELECT store_id, city, country
FROM store s
INNER JOIN address as a
ON (s.address_id = a.address_id)
INNER JOIN city as cit
ON (cit.city_id = a.city_id)
INNER JOIN country as ctr
ON(cit.country_id = ctr.country_id);

-- 7h. List the top five genres in gross revenue in descending order
SELECT SUM(amount) AS 'Total Sales', c.name AS 'Genre'
FROM payment p
INNER JOIN rental as  r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory as i
ON (r.inventory_id = i.inventory_id)
INNER JOIN film_category as fc
ON (i.film_id = fc.film_id)
INNER JOIN category as  c
ON (fc.category_id = c.category_id)
GROUP BY c.name
ORDER BY SUM(amount) DESC;
































