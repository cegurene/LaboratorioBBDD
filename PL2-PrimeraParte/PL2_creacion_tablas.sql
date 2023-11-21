BEGIN;

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
	puntuacion numeric(2,1),
	texto TEXT,
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	url_web TEXT NOT NULL,
	fecha date,

	CONSTRAINT criticas_final_pk1 PRIMARY KEY (critico)
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

	CONSTRAINT actua_final_pk PRIMARY KEY (titulo_peliculas,anno_peliculas,nombre_actor)
);

CREATE TABLE cine.escribe_final (
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	nombre_guionista TEXT NOT NULL,

	CONSTRAINT escribe_final_pk PRIMARY KEY (titulo_peliculas,anno_peliculas,nombre_guionista)
);


\echo 'Annadiendo claves ajenas'
ALTER TABLE cine.peliculas_final ADD CONSTRAINT directores_final_fk1 FOREIGN KEY (nombre_personal_Directores)
REFERENCES cine.directores_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE;

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

INSERT INTO cine.actores_final(nombre)
SELECT DISTINCT nombre
FROM intermedio.actores_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.guionistas_final(nombre)
SELECT DISTINCT nombre
FROM intermedio.guionistas_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.directores_final(nombre)
SELECT DISTINCT nombre
FROM intermedio.directores_intermedio ON CONFLICT DO NOTHING;

INSERT INTO cine.escribe_final(nombre)
SELECT DISTINCT nombre
FROM intermedio.directores_intermedio ON CONFLICT DO NOTHING;

ROLLBACK;
