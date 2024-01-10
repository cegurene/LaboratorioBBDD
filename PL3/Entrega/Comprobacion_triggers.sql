-- Comprobacion trigger 1

INSERT INTO cine.peliculas_final (titulo, anno, duracion, calificacionMPA, idioma, nombre_personal_directores)
VALUES ('Titulo', 2023, '200 mins', 'PG-13', 'es', 'NombreDirector');

UPDATE cine.peliculas_final
SET duracion = '215 mins', idioma = 'en'
WHERE titulo = 'Titulo' AND anno = 2023;

DELETE FROM cine.peliculas_final
WHERE titulo = 'Titulo' AND anno = 2023;


-- Comprobacion trigger 2

INSERT INTO cine.caratulas_WEB_final (url_web, fecha, titulo_peliculas, anno_peliculas)
VALUES ('https.//forummovies.org/covers/brave-2012_Poster_Poster.jpg', current_date, 'Titulo', 2023);

INSERT INTO cine.caratulas_WEB_final (url_web, fecha, titulo_peliculas, anno_peliculas)
VALUES ('https://url_inventada.com', current_date, 'Titulo', 2023);

INSERT INTO cine.criticas_final (critico, puntuacion, texto, titulo_peliculas, anno_peliculas, url_web)
VALUES ('Nombre', 5, 'Texto de la Critica', 'Titulo', 2023, 'https://url_inventada2.com');

INSERT INTO cine.criticas_final (critico, puntuacion, texto, titulo_peliculas, anno_peliculas, url_web)
VALUES ('Nombre', 2, 'Texto de la Critica', 'Titulo', 2023, 'https://url_inventada2.com');

-- Comprobacion trigger 3

INSERT INTO cine.peliculas_final (titulo, anno, duracion, calificacionMPA, idioma, nombre_personal_directores)
VALUES ('Titulo', 2023, '200 mins', 'PG-13', 'es', 'NombreDirector');

INSERT INTO cine.criticas_final (critico, puntuacion, texto, titulo_peliculas, anno_peliculas, url_web)
VALUES ('Nombre del Critico', 4, 'Texto de la Critica', 'Titulo', 2023, 'URL de la Critica');

INSERT INTO cine.criticas_final (critico, puntuacion, texto, titulo_peliculas, anno_peliculas, url_web)
VALUES ('Nombre del Critico', 6, 'Texto de la Critica', 'Titulo', 2023, 'URL de la Critica');

SELECT * FROM cine.puntuacion_media
WHERE titulo_peliculas = 'Titulo';