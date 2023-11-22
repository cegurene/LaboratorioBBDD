--Consulta 1--
SELECT DISTINCT directores_final.nombre
FROM cine.directores_final, cine.personal_final
WHERE cine.directores_final.nombre = cine.personal_final.nombre AND cine.personal_final.anno_nacimiento = 1970;


--Consulta 2--
SELECT peliculas_final.idioma, COUNT(*) AS num_peliculas
FROM cine.peliculas_final
WHERE idioma IS NOT NULL
GROUP BY idioma
ORDER BY num_peliculas DESC;


--Consulta 3--
SELECT personal_final.anno_nacimiento, actores_final.nombre
FROM cine.actores_final, cine.personal_final
WHERE cine.personal_final.nombre = cine.actores_final.nombre AND (cine.personal_final.anno_nacimiento = (SELECT MAX(cine.personal_final.anno_nacimiento) FROM cine.personal_final));


--Consulta 4--
SELECT (actores_final.nombre), COUNT(*) AS num_peliculas_actor
FROM cine.actores_final, cine.actua_final
WHERE cine.actores_final.nombre = cine.actua_final.nombre_actor
GROUP BY cine.actores_final.nombre
HAVING COUNT(*) > 1;


--Consulta 5--
SELECT genero, COUNT(*) AS cantidad_peliculas
FROM (
    SELECT unnest(string_to_array(generos_peliculas_final.genero, ',')) AS genero
    FROM cine.generos_peliculas_final
) AS generos_divididos
GROUP BY genero
ORDER BY cantidad_peliculas DESC;


--Consulta 6--






--Consulta 7--






--Consulta 8--






--Consulta 9--

SELECT p.anno, p.titulo, AVG(CAST(c.puntuacion AS numeric(2,1))) AS puntuacion_media
FROM cine.peliculas_final p
JOIN cine.criticas_final c ON p.titulo = c.titulo_peliculas AND p.anno = c.anno_peliculas
GROUP BY p.titulo, p.anno
ORDER BY puntuacion_media DESC
LIMIT 3;


--Consulta 10--






