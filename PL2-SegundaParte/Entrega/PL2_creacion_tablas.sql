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

CREATE SCHEMA IF NOT EXISTS cine;

CREATE TABLE cine.peliculas_final (
	titulo TEXT NOT NULL,
	anno integer NOT NULL,
	duracion TEXT,
	calificacionMPA TEXT,
	idioma char(2),
	nombre_personal_Directores TEXT,

	CONSTRAINT peliculas_final_pk PRIMARY KEY (titulo,anno)
);

CREATE TABLE cine.criticas_final (
	critico TEXT NOT NULL,
	puntuacion numeric(2,1) NOT NULL,
	texto TEXT NOT NULL,
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	url_web TEXT NOT NULL,

	CONSTRAINT criticas_final_pk1 PRIMARY KEY (critico, puntuacion, texto, titulo_peliculas, anno_peliculas)
);

CREATE TABLE cine.pagina_web_final (
	url_web TEXT NOT NULL,
	CONSTRAINT pagina_web_final_pk PRIMARY KEY (url_web)
);

CREATE TABLE cine.caratulas_final (
	nombre TEXT NOT NULL,
	tamanno TEXT,
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,

	CONSTRAINT caratulas_final_pk PRIMARY KEY (nombre,titulo_peliculas, anno_peliculas)
	
);

CREATE TABLE cine.caratulas_WEB_final (
    url_web TEXT NOT NULL,
	fecha date,
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,

    CONSTRAINT caratulas_WEB_final_pk PRIMARY KEY (url_web,titulo_peliculas, anno_peliculas)
);


CREATE TABLE cine.personal_final (
	nombre TEXT NOT NULL,
	anno_nacimiento integer,
	anno_muerte integer,

	CONSTRAINT personal_final_pk PRIMARY KEY (nombre)
);

CREATE TABLE cine.directores_final (
	nombre TEXT NOT NULL,

	CONSTRAINT directores_final_pk PRIMARY KEY (nombre)
);

CREATE TABLE cine.guionistas_final (
	nombre TEXT NOT NULL,

	CONSTRAINT guionistas_final_pk PRIMARY KEY (nombre)
);

CREATE TABLE cine.actores_final (
	nombre TEXT NOT NULL,

	CONSTRAINT actores_final_pk PRIMARY KEY (nombre)
);

CREATE TABLE cine.actua_final (
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	nombre_actor TEXT NOT NULL,
	personaje TEXT,

	CONSTRAINT actua_final_pk PRIMARY KEY (titulo_peliculas, anno_peliculas, nombre_actor)
);

CREATE TABLE cine.escribe_final (
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	nombre_guionista TEXT NOT NULL,

	CONSTRAINT escribe_final_pk PRIMARY KEY (titulo_peliculas, anno_peliculas, nombre_guionista)
);

CREATE TABLE cine.generos_peliculas_final(
	genero TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	titulo_peliculas TEXT NOT NULL,

	CONSTRAINT generos_peliculas_final_pk PRIMARY KEY (genero, anno_peliculas, titulo_peliculas)
);

\echo 'Annadiendo claves ajenas'
--ALTER TABLE cine.peliculas_final ADD CONSTRAINT directores_final_fk1 FOREIGN KEY (regexp_split_to_table(nombre_personal_Directores, ', '))
--REFERENCES cine.directores_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.criticas_final ADD CONSTRAINT peliculas_final_fk1 FOREIGN KEY (titulo_peliculas, anno_peliculas)
REFERENCES cine.peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.criticas_final ADD CONSTRAINT pagina_web_final_fk1 FOREIGN KEY (url_web) 
REFERENCES cine.pagina_web_final (url_web) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.caratulas_final ADD CONSTRAINT peliculas_final_fk2 FOREIGN KEY (titulo_peliculas, anno_peliculas) 
REFERENCES cine.peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.caratulas_WEB_final ADD CONSTRAINT pagina_web_final_fk2 FOREIGN KEY (url_web) 
REFERENCES cine.pagina_web_final (url_web) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.directores_final ADD CONSTRAINT personal_final_fk1 FOREIGN KEY (nombre) 
REFERENCES cine.personal_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.guionistas_final ADD CONSTRAINT personal_final_fk2 FOREIGN KEY (nombre) 
REFERENCES cine.personal_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.actores_final ADD CONSTRAINT personal_final_fk3 FOREIGN KEY (nombre) 
REFERENCES cine.personal_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.actua_final ADD CONSTRAINT actores_final_fk FOREIGN KEY (nombre_actor) 
REFERENCES cine.actores_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.actua_final ADD CONSTRAINT peliculas_final_fk3 FOREIGN KEY (titulo_peliculas, anno_peliculas) 
REFERENCES cine.peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.escribe_final ADD CONSTRAINT guionistas_final_fk FOREIGN KEY (nombre_guionista) 
REFERENCES cine.guionistas_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.escribe_final ADD CONSTRAINT peliculas_final_fk4 FOREIGN KEY (titulo_peliculas, anno_peliculas) 
REFERENCES cine.peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE cine.generos_peliculas_final ADD CONSTRAINT generos_peliculas_final_fk FOREIGN KEY (titulo_peliculas, anno_peliculas)
REFERENCES cine.peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

\echo 'Migrando datos'

INSERT INTO cine.personal_final(nombre, anno_nacimiento, anno_muerte)
SELECT DISTINCT nombre, CAST(NULLIF(anno_nacimiento, '\N') AS integer), CAST(NULLIF(anno_muerte, '\N') AS integer)
FROM intermedio.actores_intermedio
UNION
SELECT DISTINCT nombre, CAST(NULLIF(anno_nacimiento, '\N') AS integer), CAST(NULLIF(anno_muerte, '\N') AS integer)
FROM intermedio.directores_intermedio
UNION
SELECT DISTINCT nombre, CAST(NULLIF(anno_nacimiento, '\N') AS integer), CAST(NULLIF(anno_muerte, '\N') AS integer)
FROM intermedio.guionistas_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.peliculas_final(anno,titulo, duracion, calificacionMPA, idioma)
SELECT DISTINCT CAST(anno AS integer), titulo, NULLIF(duracion, 'NULL'), NULLIF(calificacion, 'NULL'), NULLIF(idioma, 'NULL')
FROM intermedio.peliculas_intermedio ON CONFLICT DO NOTHING;

--INSERT INTO cine.peliculas_final(anno,titulo, duracion, calificacionMPA, idioma, nombre_personal_Directores)
--SELECT DISTINCT CAST(anno AS integer), titulo, NULLIF(duracion, 'NULL'), NULLIF(calificacion, 'NULL'), NULLIF(idioma, 'NULL'), STRING_AGG(nombre, ', ')
--FROM intermedio.peliculas_intermedio JOIN intermedio.directores_intermedio ON intermedio.directores_intermedio.titulo_peliculas = intermedio.peliculas_intermedio.titulo
--GROUP BY anno, titulo, duracion, calificacion, idioma;

INSERT INTO cine.actores_final(nombre)
SELECT DISTINCT nombre
FROM intermedio.actores_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.guionistas_final(nombre)
SELECT DISTINCT nombre
FROM intermedio.guionistas_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.directores_final(nombre)
SELECT DISTINCT nombre
FROM intermedio.directores_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.escribe_final(titulo_peliculas, nombre_guionista, anno_peliculas)
SELECT DISTINCT titulo_peliculas, nombre, CAST(anno_peliculas AS integer)
FROM intermedio.guionistas_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.actua_final(titulo_peliculas, nombre_actor, anno_peliculas)
SELECT DISTINCT titulo_peliculas, nombre, CAST(anno_peliculas AS integer)
FROM intermedio.actores_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.pagina_web_final(url_web)
SELECT DISTINCT url_web
FROM intermedio.caratulas_intermedio
UNION
SELECT DISTINCT url_web
FROM intermedio.criticas_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.criticas_final(anno_peliculas, titulo_peliculas, critico, puntuacion, texto, url_web)
SELECT CAST(anno_peliculas AS integer), titulo_peliculas, nombre_critico, CAST(puntuacion AS numeric(2,1)), texto_critica, url_web
FROM intermedio.criticas_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.caratulas_final(anno_peliculas, titulo_peliculas, nombre, tamanno)
SELECT CAST(anno_peliculas AS integer), titulo_peliculas, nombre_caratula, tamanno
FROM intermedio.caratulas_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.caratulas_WEB_final(anno_peliculas, titulo_peliculas, url_web, fecha)
SELECT CAST(anno_peliculas AS integer), titulo_peliculas, url_web, CAST(NULLIF(fecha, '\N') AS date)
FROM intermedio.caratulas_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.generos_peliculas_final(genero, anno_peliculas, titulo_peliculas)
SELECT DISTINCT regexp_split_to_table(generos, '\s+'), CAST(anno AS integer), titulo
FROM intermedio.peliculas_intermedio ON CONFLICT DO NOTHING;

--UPDATE cine.peliculas_final
--SET nombre_personal_Directores = STRING_AGG(intermedio.directores_intermedio.nombre, ', ')
--FROM intermedio.directores_intermedio
--WHERE intermedio.directores_intermedio.titulo_peliculas = cine.peliculas_final.titulo;

ROLLBACK;