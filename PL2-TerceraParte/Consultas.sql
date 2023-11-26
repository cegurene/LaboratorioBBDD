\echo 'Realizando Consultas'
\echo '\n'
\echo '\n'

\echo 'Consulta 1'
--Consulta 1--
SELECT DISTINCT directores_final.nombre
FROM cine.directores_final, cine.personal_final
WHERE cine.directores_final.nombre = cine.personal_final.nombre AND cine.personal_final.anno_nacimiento = 1970;

\echo 'Consulta 2'
--Consulta 2--
SELECT peliculas_final.idioma, COUNT(*) AS num_peliculas
FROM cine.peliculas_final
WHERE idioma IS NOT NULL
GROUP BY idioma
ORDER BY num_peliculas DESC;

\echo 'Consulta 3'
--Consulta 3--
SELECT personal_final.anno_nacimiento, actores_final.nombre
FROM cine.actores_final, cine.personal_final
WHERE cine.personal_final.nombre = cine.actores_final.nombre AND (cine.personal_final.anno_nacimiento = (SELECT MAX(cine.personal_final.anno_nacimiento) FROM cine.personal_final));

\echo 'Consulta 4'
--Consulta 4--
SELECT (actores_final.nombre), COUNT(*) AS num_peliculas_actor
FROM cine.actores_final, cine.actua_final
WHERE cine.actores_final.nombre = cine.actua_final.nombre_actor
GROUP BY cine.actores_final.nombre
HAVING COUNT(*) > 1;

\echo 'Consulta 5'
--Consulta 5--
SELECT genero, COUNT(*) AS cantidad_peliculas
FROM cine.generos_peliculas_final
GROUP BY genero
ORDER BY cantidad_peliculas DESC;

\echo 'Consulta 6'
--Consulta 6--
SELECT DISTINCT nombre_guionista
FROM cine.generos_peliculas_final gp
JOIN cine.escribe_final e ON gp.titulo_peliculas = e.titulo_peliculas AND gp.anno_peliculas = e.anno_peliculas
WHERE gp.genero = 'Sport' OR gp.genero = 'Film-Noir';

\echo 'Consulta 7'
--Consulta 7--
SELECT a.nombre AS actor, act.personaje, p.titulo, p.anno, p.idioma, p.duracion
FROM cine.actores_final a
JOIN cine.actua_final act ON a.nombre = act.nombre_actor
JOIN cine.peliculas_final p ON act.titulo_peliculas = p.titulo AND act.anno_peliculas = p.anno
JOIN cine.personal_final ON personal_final.nombre = act.nombre_actor
WHERE p.idioma = 'ja'
    AND CAST(SUBSTRING(p.duracion, 1, POSITION(' ' IN p.duracion) - 1) AS integer) < 100
    AND personal_final.anno_nacimiento < 1960;

\echo 'Consulta 8'
--Consulta 8--
SELECT p.titulo, p.anno, p.idioma, p.duracion, p.calificacionMPA, COUNT(*) AS numero_caratulas
FROM cine.peliculas_final p
JOIN cine.caratulas_final c ON p.titulo = c.titulo_peliculas AND p.anno = c.anno_peliculas
GROUP BY p.titulo, p.anno, p.idioma, p.duracion, p.calificacionMPA
HAVING COUNT(*) >= 2;

\echo 'Consulta 9'
--Consulta 9--
SELECT p.anno, p.titulo, AVG(CAST(c.puntuacion AS numeric(2,1))) AS puntuacion_media
FROM cine.peliculas_final p
JOIN cine.criticas_final c ON p.titulo = c.titulo_peliculas AND p.anno = c.anno_peliculas
GROUP BY p.titulo, p.anno
ORDER BY puntuacion_media DESC
LIMIT 3;

\echo 'Consulta 10'
--Consulta 10--
SELECT genero, AVG(CAST(c.puntuacion AS numeric(2,1))) AS puntuacion_media
FROM cine.generos_peliculas_final gp
JOIN cine.criticas_final c ON gp.titulo_peliculas = c.titulo_peliculas AND gp.anno_peliculas = c.anno_peliculas
GROUP BY genero
ORDER BY puntuacion_media
LIMIT 1;