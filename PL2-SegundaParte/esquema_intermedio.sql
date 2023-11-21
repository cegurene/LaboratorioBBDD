BEGIN;

CREATE SCHEMA IF NOT EXISTS intermedio;

CREATE TABLE intermedio.actores_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre text,
	anno_nacimiento text,
	anno_muerte text,
	papel text

);

CREATE TABLE intermedio.directores_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre text,
	anno_nacimiento text,
	anno_muerte text

);

CREATE TABLE intermedio.guionistas_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre text,
	anno_nacimiento text,
	anno_muerte text

);

CREATE TABLE intermedio.peliculas_intermedio (
	anno text,
	titulo text,
	generos text,
	idioma text,
	duracion text,
	calificacion text

);

CREATE TABLE intermedio.criticas_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre_critico text,
	puntuacion text,
	texto_critica text,
	url_web text

);

CREATE TABLE intermedio.caratulas_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre_caratula text,
	fecha text,
	url_web text,
	tamanno text

);

\echo 'Cargando los datos'
\COPY intermedio.peliculas_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\peliculas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY intermedio.guionistas_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\guionistas_peliculas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY intermedio.directores_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\directores_peliculas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY intermedio.criticas_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\criticas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY intermedio.caratulas_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\caratulas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY intermedio.actores_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\actores_peliculas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');

END;