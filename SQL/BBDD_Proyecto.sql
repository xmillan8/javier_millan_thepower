--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.

SELECT title, rating 
FROM film f
WHERE rating = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

SELECT actor_id, first_name, last_name 
FROM actor a 
WHERE actor_id between 30 and 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT *
FROM film f
WHERE language_id = original_language_id;

--5. Ordena las películas por duración de forma ascendente.

SELECT title, length 
FROM film f
ORDER BY length ASC;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

SELECT first_name, last_name 
FROM actor a 
WHERE last_name = 'ALLEN';

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

SELECT rating, count(*)
FROM film f
GROUP BY rating;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

SELECT title, rating, length 
FROM film f
WHERE rating = 'PG-13' OR length > 180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT variance(replacement_cost) AS variabilidad 
FROM film f;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT min(length) AS menor_duracion, max(length) AS mayor_duracion 
FROM film f;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT *
FROM rental r 
ORDER BY rental_date DESC
LIMIT 1 OFFSET 2;

--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.

SELECT title, rating 
FROM film f
WHERE rating NOT IN ('NC-17','G');

--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT rating, avg(length) AS promedio_duracion 
FROM film f
GROUP BY rating;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT title, length 
FROM film f
WHERE length > 180;

--15. ¿Cuánto dinero ha generado en total la empresa?

SELECT sum(amount) AS dinero_generado 
FROM payment p;

--16. Muestra los 10 clientes con mayor valor de id.

SELECT customer_id, first_name, last_name 
FROM customer c 
ORDER BY customer_id DESC
LIMIT 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

SELECT first_name, last_name 
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id 
WHERE title = 'EGG IGBY';

--18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT title 
FROM film f;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

SELECT title, length, name
FROM film f
LEFT JOIN film_category fc ON fc.film_id = f.film_id 
LEFT JOIN category c ON fc.category_id = c.category_id 
WHERE name = 'Comedy' AND length > 180;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.

SELECT name, avg(length) AS promedio_duracion
FROM category c 
LEFT JOIN film_category fc ON fc.category_id = c.category_id 
LEFT JOIN film f on f.film_id = fc.film_id
GROUP BY "name" 
HAVING avg(length) > 110 ;

--21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT avg(rental_duration) 
FROM film f;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT concat(first_name,' ',last_name) AS nombre_completo
FROM actor a;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT DATE(rental_date) AS dia_alquiler, count(*) AS cantidad_alquileres
FROM rental r
GROUP BY DATE(rental_date) 
ORDER BY count(*) desc

--24. Encuentra las películas con una duración superior al promedio.

SELECT title, length 
FROM film f 
WHERE length > (SELECT AVG(length) FROM film);

--25. Averigua el número de alquileres registrados por mes.

SELECT DATE_TRUNC('month', rental_date) AS mes_alquiler, count(*) AS cantidad_alquileres
FROM rental r
GROUP BY mes_alquiler;

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT avg(amount) AS promedio, stddev(amount) AS desviacion_estandar, variance(amount) AS varianza 
FROM payment p;

--27. ¿Qué películas se alquilan por encima del precio medio?

SELECT DISTINCT title
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
LEFT JOIN payment p ON r.rental_id = p.rental_id
WHERE amount > (SELECT AVG(amount) FROM payment);


--28. Muestra el id de los actores que hayan participado en más de 40 películas.

SELECT actor_id, COUNT(film_id) AS peliculas
FROM film_actor fa
GROUP BY actor_id
HAVING COUNT(film_id) > 40;

--29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT f.title, count(i.film_id) AS cantidad
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.title;

--30. Obtener los actores y el número de películas en las que ha actuado.

SELECT first_name, last_name, COUNT(film_id) AS peliculas
FROM actor a
INNER JOIN film_actor fa ON fa.actor_id = a.actor_id 
GROUP BY first_name, last_name;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

SELECT title,first_name, last_name
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
LEFT JOIN actor a ON fa.actor_id = a.actor_id
ORDER BY title;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

SELECT first_name, last_name, title
FROM actor a
LEFT JOIN film_actor fa ON fa.actor_id = a.actor_id 
LEFT JOIN film f ON f.film_id = fa.film_id 
ORDER BY first_name, last_name;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT title, rental_id
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
FULL JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY title; 

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT first_name, last_name, SUM(amount) as dinero_gastado
FROM customer c 
INNER JOIN rental r ON c.customer_id = r.customer_id 
INNER JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY first_name, last_name
ORDER BY dinero_gastado DESC
LIMIT 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT first_name, last_name 
FROM actor a
WHERE first_name  = 'JOHNNY';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

SELECT first_name AS Nombre, last_name AS Apellido
FROM actor a;

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT min(actor_id) AS id_mas_bajo, max(actor_id) AS id_mas_alto 
FROM actor a;

--38. Cuenta cuántos actores hay en la tabla “actor”.

SELECT COUNT(actor_id) AS cantidad_actores
FROM actor a;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT first_name, last_name 
FROM actor a
ORDER BY last_name ASC;

--40. Selecciona las primeras 5 películas de la tabla “film”.

SELECT title 
FROM film f
LIMIT 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT first_name, COUNT(first_name) AS numero_actores
FROM actor a
GROUP BY first_name
ORDER BY numero_actores DESC
LIMIT 1; 

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT rental_id, first_name, last_name 
FROM customer c 
INNER JOIN rental r ON c.customer_id = r.customer_id; 

--43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT first_name, last_name, rental_id
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id; 

--44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT *
FROM film f 
CROSS JOIN category c;
		--No aporta valor ya que esta dando todos los generos existentes para cada película, en vez de dar el género correcto.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

SELECT DISTINCT first_name, last_name, name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON c.category_id = fc.category_id
WHERE name = 'Action'

--46. Encuentra todos los actores que no han participado en películas.

SELECT first_name, last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE film_id is null;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT first_name, last_name, count(film_id) AS peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY first_name, last_name
ORDER BY peliculas DESC;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS
SELECT first_name, last_name, count(film_id) AS peliculas
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY first_name, last_name;
	--CHECK 
	SELECT * FROM actor_num_peliculas;

--49. Calcula el número total de alquileres realizados por cada cliente.

SELECT first_name, last_name, count(rental_id) AS cantidad_alquileres
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY first_name, last_name
ORDER BY cantidad_alquileres DESC; 

--50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT sum(length) as duracion
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id 
LEFT JOIN film f ON f.film_id = fc.film_id 
WHERE name = 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

CREATE TEMPORARY TABLE cliente_rentas_temporal AS
SELECT first_name, last_name, count(rental_id) AS cantidad_alquileres
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY first_name, last_name;
	--CHECK 
	SELECT * FROM cliente_rentas_temporal;

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT title, count(rental_id) AS numero_alquileres
FROM film c 
LEFT JOIN inventory i ON c.film_id = i.film_id 
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY title 
HAVING COUNT(r.rental_id) >= 10;
	--CHECK 
	SELECT * FROM peliculas_alquiladas;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.

SELECT distinct title, return_date
FROM film f 
LEFT JOIN inventory i ON f.film_id = i.film_id 
LEFT JOIN rental r ON i.inventory_id = r.inventory_id 
LEFT JOIN customer c ON r.customer_id = c.customer_id
WHERE first_name = 'TAMMY' AND last_name = 'SANDERS' AND return_date is null;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.

SELECT DISTINCT first_name, last_name, name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON c.category_id = fc.category_id
WHERE name = 'Sci-Fi'
ORDER BY last_name ASC;

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

SELECT first_name, last_name 
FROM (
	SELECT f.film_id,title, min(rental_date) as primer_alquiler
	FROM rental r
	LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
	LEFT JOIN film f ON f.film_id = i.film_id
	GROUP BY f.film_id, title
	) fecha_primer_alquiler
LEFT JOIN film_actor fa ON fa.film_id = fecha_primer_alquiler.film_id
LEFT JOIN actor a ON a.actor_id = fa.actor_id
WHERE fecha_primer_alquiler.primer_alquiler > (
    SELECT MIN(r.rental_date)
    FROM rental r
    LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
    LEFT JOIN film f ON i.film_id = f.film_id
    WHERE f.title = 'SPARTACUS CHEAPER')
ORDER BY last_name;

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

SELECT DISTINCT first_name, last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
LEFT JOIN film f ON f.film_id = fa.film_id 
LEFT JOIN film_category fc ON f.film_id = fc.film_id
LEFT JOIN category c ON c.category_id = fc.category_id
WHERE name != 'Music';

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT title, rental_duration 
FROM film f 
WHERE rental_duration > 8;

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

SELECT title, name
FROM film f
LEFT JOIN film_category fc ON fc.film_id = f.film_id 
LEFT JOIN category c ON fc.category_id = c.category_id 
WHERE name = 'Animation';

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.

SELECT *
FROM film f 
WHERE length = (
	SELECT length
    FROM film
    WHERE title = 'DANCING FEVER');
    

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

SELECT first_name, last_name, COUNT(DISTINCT film_id)
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
LEFT JOIN inventory i ON i.inventory_id = r.inventory_id 
GROUP BY first_name, last_name
ORDER BY last_name ASC;
   
--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT name, count(rental_id) AS cantidad_alquileres
FROM category c 
LEFT JOIN film_category fc ON fc.category_id = c.category_id 
LEFT JOIN film f ON f.film_id = fc.film_id
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id 
GROUP BY name;

--62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT name, count(f.film_id) AS cantidad_peliculas
FROM category c 
LEFT JOIN film_category fc ON fc.category_id = c.category_id 
LEFT JOIN film f ON f.film_id = fc.film_id
WHERE release_year = 2006
GROUP BY name;

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT first_name, last_name, s2.store_id
FROM staff s
CROSS JOIN store s2 

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

SELECT c.customer_id ,first_name, last_name, count(rental_id) AS cantidad_alquileres
FROM customer c 
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id ,first_name, last_name






