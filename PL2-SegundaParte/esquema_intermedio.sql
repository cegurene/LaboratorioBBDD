CREATE TABLE Actores (
	nombre text NOT NULL,
	anno_nacimiento text NOT NULL,
	anno_muerte text,
	papel text,
	año_películas text,
	título_películas text,
	CONSTRAINT Actores_pk PRIMARY KEY (nombre,anno_nacimiento)

);

CREATE TABLE Directores (
	nombre text NOT NULL,
	anno_nacimiento text NOT NULL,
	anno_muerte text,
	año_películas text,
	título_películas text,
	CONSTRAINT Directores_pk PRIMARY KEY (nombre,anno_nacimiento)

);

CREATE TABLE Guionistas (
	nombre text NOT NULL,
	anno_nacimiento text NOT NULL,
	anno_muerte text,
	año_películas text,
	título_películas text,
	CONSTRAINT Guionistas_pk PRIMARY KEY (nombre,anno_nacimiento)

);

CREATE TABLE películas (
	año text NOT NULL,
	título text NOT NULL,
	idioma text,
	duración text,
	calificación text,
	generos text,
	CONSTRAINT películas_pk PRIMARY KEY (año,título)

);

CREATE TABLE críticas (
	nombre_crítico text NOT NULL,
	puntuación text,
	texto_crítica text,
	url text,
	año_películas text,
	título_películas text,
	CONSTRAINT críticas_pk PRIMARY KEY (nombre_crítico)

);

CREATE TABLE carátulas (
	nombre_carátula text NOT NULL,
	fecha text,
	url text,
	tamaño text,
	año_películas text,
	título_películas text,
	CONSTRAINT carátulas_pk PRIMARY KEY (nombre_carátula)

);

ALTER TABLE críticas ADD CONSTRAINT películas_fk FOREIGN KEY (año_películas,título_películas)
REFERENCES películas (año,título) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE carátulas ADD CONSTRAINT películas_fk FOREIGN KEY (año_películas,título_películas)
REFERENCES películas (año,título) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Actores ADD CONSTRAINT películas_fk FOREIGN KEY (año_películas,título_películas)
REFERENCES películas (año,título) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Directores ADD CONSTRAINT películas_fk FOREIGN KEY (año_películas,título_películas)
REFERENCES películas (año,título) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Guionistas ADD CONSTRAINT películas_fk FOREIGN KEY (año_películas,título_películas)
REFERENCES películas (año,título) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
