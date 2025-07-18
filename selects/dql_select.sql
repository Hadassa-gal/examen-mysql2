--Encuentra el cliente que ha realizado la mayor cantidad de alquileres en los últimos 6 meses.
SELECT c.nombre AS cliente, COUNT(al.id_cliente) AS cantidad_alquileres
FROM cliente c
JOIN alquiler al ON c.id_cliente = al.id_cliente
ORDER BY cantidad_alquileres DESC
LIMIT 1;

--Lista las cinco películas más alquiladas durante el último año.
SELECT p.nombre AS película, COUNT(al.id_pelicula) AS cantidad_alquileres
FROM alquiler al
JOIN pelicula p ON al.id_pelicula = p.id_pelicula
WHERE al.fecha_alquiler >= NOW() - INTERVAL 1 YEAR
GROUP BY p.nombre
ORDER BY cantidad_alquileres DESC
LIMIT 5;