-- Comprobacion trigger 1

INSERT INTO peliculas_final (titulo, anno, duracion, calificacionMPA, idioma, nombre_personal_directores)
VALUES ('Titulo', 2023, '200 mins', 'PG-13', 'es', 'NombreDirector');

UPDATE peliculas_final
SET duracion = '215 mins', idioma = 'en'
WHERE titulo = 'Titulo de la Pelicula' AND anno = 2023;

DELETE FROM peliculas_final
WHERE titulo = 'Titulo de la Pelicula' AND anno = 2023;


-- Comprobacion trigger 2

INSERT INTO caratulas_final (nombre, titulo_peliculas, anno_peliculas, tamanno)
VALUES ('Nombre de la Caratula', 'Titulo', 2023, 'Tamanno de la Caratula');

INSERT INTO criticas_final (critico, puntuacion, texto, titulo_peliculas, anno_peliculas, url_web)
VALUES ('Nombre del Critico', 4.5, 'Texto de la Critica', 'Titulo de la Pelicula', 2023, 'URL de la Critica');


-- Comprobacion trigger 3

