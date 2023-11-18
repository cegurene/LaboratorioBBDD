BEGIN;

CREATE SCHEMA IF NOT EXISTS intermedio;

CREATE TABLE actores_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre text NOT NULL,
	anno_nacimiento text,
	anno_muerte text,
	papel text

);

CREATE TABLE directores_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre text NOT NULL,
	anno_nacimiento text,
	anno_muerte text

);

CREATE TABLE guionistas_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre text NOT NULL,
	anno_nacimiento text,
	anno_muerte text

);

CREATE TABLE peliculas_intermedio (
	anno text NOT NULL,
	titulo text NOT NULL,
	generos text,
	idioma text,
	duracion text,
	calificacion text

);

CREATE TABLE criticas_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre_critico text NOT NULL,
	puntuacion text,
	texto_critica text,
	url_web text

);

CREATE TABLE caratulas_intermedio (
	anno_peliculas text,
	titulo_peliculas text,
	nombre_caratula text NOT NULL,
	fecha text,
	url_web text,
	tamanno text

);

\echo 'Cargando los datos'
\COPY peliculas_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\peliculas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY guionistas_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\guionistas_peliculas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY directores_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\directores_peliculas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY criticas_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\criticas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY caratulas_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\caratulas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');
\COPY actores_intermedio FROM 'G:\Mi unidad\Universidad\2\1er Cuatrimestre\Bases de Datos\Laboratorio\LaboratorioBBDD\LaboratorioBBDD\PL2-SegundaParte\Archivos\Datos\actores_peliculas.csv' WITH (FORMAT csv, DELIMITER E'\t', NULL 'NULL', ENCODING 'UTF-8');

ROLLBACK;