use sakila;
-- 1a. Display the first and last names of all actors from the table actor
SELECT first_name,last_name FROM actor ;
-- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
SELECT CONCAT(first_name, ' ', last_name) AS Actor_Name FROM actor; 
-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id,first_name,last_name from actor where first_name ="JOE";
-- 2b.Find all actors whose last name contain the letters GEN
SELECT * FROM actor where last_name like '%GEN%';
-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT * FROM actor where last_name like '%LI%' order by last_name ,first_name;
-- 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id,country from country where country in ('Afghanistan', 'Bangladesh', 'China');
-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type
alter table actor
add middle_name varchar(30) after first_name;
-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
ALTER TABLE actor MODIFY middle_name blob;
-- 3c. Now delete the middle_name column.
ALTER TABLE actor drop middle_name;
-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name,count(last_name) from actor group by last_name;
-- 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
select last_name,count(last_name)as numbers_actor from actor group by last_name having numbers_actor >= 2;
-- 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher.
update actor set first_name = ' HARPO' and last_name = 'WILLIAMS' where first_name ='GROUCHO' AND last_name ='WILLIAMS';
-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)
update actor set first_name = ' GROUCHO' and last_name = 'WILLIAMS' where first_name ='HARPO' AND last_name ='WILLIAMS';
-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;
-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
SELECT staff.first_name,staff.last_name,address.address from staff inner join address on staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
select staff.first_name,staff.last_name,sum(payment.amount) as total_amount from staff inner join payment on staff.staff_id = payment.staff_id where payment.payment_date LIKE '2005-08%'group by payment.staff_id; 
-- 6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
select title,count(actor_id) as numbers_actors from film_actor inner join film on film_actor.film_id = film.film_id group by title;
-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select title,count(inventory_id) as numbers_HI from film inner join inventory on film.film_id = inventory.film_id where title='Hunchback Impossible ';
-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
select customer.first_name,customer.last_name,sum(payment.amount) as total_paid from payment inner join customer on customer.customer_id = payment.customer_id GROUP BY payment.customer_id order by customer.last_name;
-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
select title from film where language_id IN (SELECT language_id FROM language WHERE name = "English" ) 
AND (title like '%K') or (title like '%Q%') ;
-- 7b. Use subqueries to display all actors who appear in the film Alone Trip
select first_name,last_name from actor 
where actor_id in(select actor_id from film_actor 
where film_id in (select film_id from film where title ='Alone Trip'));
-- 7c for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT customer.last_name, customer.first_name, customer.email FROM customer 
INNER JOIN customer_list ON customer.customer_id = customer_list.ID WHERE customer_list.country = 'Canada';
-- 7d Identify all movies categorized as family films.
select title from film where film_id 
in(select film_id from film_category WHERE category_id 
IN (SELECT category_id FROM category WHERE name = 'Family'));

-- 7e. Display the most frequently rented movies in descending order
use sakila;
SELECT film.title, COUNT(inventory.film_id) as'rent_Numbers' FROM film, inventory, rental WHERE 
film.film_id = inventory.film_id AND rental.inventory_id = inventory.inventory_id 
GROUP BY inventory.film_id ORDER BY COUNT(inventory.film_id) DESC, film.title ASC;
-- 7f. Write a query to display how much business, in dollars, each store brought in.
select store.store_id,sum(payment.amount)as'Total amount per store' from store,payment,staff where
store.store_id =staff.store_id and staff.staff_id = payment.staff_id group by store.store_id;
-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT sto.store_id, city, country FROM store sto 
INNER JOIN customer cu ON st.store_id = cu.store_id
INNER JOIN staff st ON sto.store_id = st.store_id
INNER JOIN address ad ON cu.address_id = ad.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country coun ON ci.country_id = coun.country_id;
-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT name, SUM(py.amount) FROM category c 
INNER JOIN film_category fc on c.category_id = fc.category_id 
INNER JOIN inventory i ON i.film_id = fc.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN payment py GROUP BY name LIMIT 5;
-- 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

CREATE VIEW top_five_grossing_genres AS
SELECT name, SUM(py.amount) FROM category c 
INNER JOIN film_category fc on c.category_id = fc.category_id 
INNER JOIN inventory i ON i.film_id = fc.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN payment py GROUP BY name LIMIT 5;
-- 8b. How would you display the view that you created in 8a?
SELECT * FROM top_five_grossing_genres;
-- 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW top_five_grossing_genres;
