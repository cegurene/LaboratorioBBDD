CREATE TABLE Actores (
	nombre text NOT NULL,
	anno_nacimiento text NOT NULL,
	anno_muerte text,
	papel text,
	año_pelculas text,
	título_pelculas text,
	CONSTRAINT Actores_pk PRIMARY KEY (nombre,anno_nacimiento)

);

CREATE TABLE Directores (
	nombre text NOT NULL,
	anno_nacimiento text NOT NULL,
	anno_muerte text,
	anno_películas text,
	titulo_películas text,
	CONSTRAINT Directores_pk PRIMARY KEY (nombre,anno_nacimiento)

);

CREATE TABLE Guionistas (
	nombre text NOT NULL,
	anno_nacimiento text NOT NULL,
	anno_muerte text,
	anno_películas text,
	titulo_películas text,
	CONSTRAINT Guionistas_pk PRIMARY KEY (nombre,anno_nacimiento)

);

CREATE TABLE peliculas (
	anno text NOT NULL,
	titulo text NOT NULL,
	idioma text,
	duracion text,
	calificacion text,
	generos text,
	CONSTRAINT peliculas_pk PRIMARY KEY (anno,titulo)

);

CREATE TABLE criticas (
	nombre_critico text NOT NULL,
	puntuacion text,
	texto_critica text,
	url text,
	año_peliculas text,
	titulo_peliculas text,
	CONSTRAINT criticas_pk PRIMARY KEY (nombre_critico)

);

CREATE TABLE caratulas (
	nombre_caratula text NOT NULL,
	fecha text,
	url text,
	tamanno text,
	anno_peliculas text,
	titulo_peliculas text,
	CONSTRAINT caratulas_pk PRIMARY KEY (nombre_caratula)

);

ALTER TABLE criticas ADD CONSTRAINT peliculas_fk FOREIGN KEY (anno_peliculas,titulo_peliculas)
REFERENCES peliculas (anno,titulo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE carátulas ADD CONSTRAINT peliculas_fk FOREIGN KEY (anno_peliculas,titulo_peliculas)
REFERENCES peliculas (anno,titulo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Actores ADD CONSTRAINT peliculas_fk FOREIGN KEY (anno_peliculas,titulo_peliculas)
REFERENCES peliculas (anno,titulo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Directores ADD CONSTRAINT peliculas_fk FOREIGN KEY (anno_peliculas,titulo_peliculas)
REFERENCES peliculas (anno,titulo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE Guionistas ADD CONSTRAINT peliculas_fk FOREIGN KEY (anno_peliculas,titulo_peliculas)
REFERENCES peliculas (anno,titulo) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
