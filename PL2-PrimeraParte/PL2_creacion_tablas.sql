BEGIN;

CREATE SCHEMA IF NOT EXISTS cine;

CREATE TABLE peliculas_final (
	titulo TEXT NOT NULL,
	anno date NOT NULL,
	duracion integer NOT NULL,
	calificacionMPA TEXT,
	idioma char(2) NOT NULL,
	nombre_personal_Directores TEXT NOT NULL,

	CONSTRAINT peliculas_final_pk PRIMARY KEY (titulo,anno),
	CONSTRAINT directores_final_fk1 FOREIGN KEY (nombre_personal_Directores) 
     REFERENCES directores_final (id) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE criticas_final (
	critico TEXT NOT NULL,
	puntuacion numeric(2,1) NOT NULL,
	texto TEXT NOT NULL,
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	url_web TEXT NOT NULL,
	fecha date NOT NULL,

	CONSTRAINT criticas_final_pk1 PRIMARY KEY (critico),
	CONSTRAINT peliculas_final_fk1 FOREIGN KEY (titulo_peliculas, anno_peliculas) 
     REFERENCES peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT pagina_web_final_fk1 FOREIGN KEY (url_web) 
     REFERENCES pagina_web_final (url_web) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE pagina_web_final (
	url_web TEXT NOT NULL,
	CONSTRAINT pagina_web_final_pk PRIMARY KEY (url_web)
);

CREATE TABLE caratulas_final (
	nombre TEXT NOT NULL,
	tamanno TEXT NOT NULL,
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,

	CONSTRAINT caratulas_final_pk PRIMARY KEY (nombre,titulo_peliculas, anno_peliculas),
	CONSTRAINT peliculas_final_fk2 FOREIGN KEY (titulo_peliculas, anno_peliculas) 
     REFERENCES peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	
);

CREATE TABLE caratulas_WEB_final (
    url_web TEXT NOT NULL,
	fecha date NOT NULL,
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,

     CONSTRAINT caratulas_WEB_final_pk PRIMARY KEY (url_web,titulo_peliculas, anno_peliculas),
     CONSTRAINT pagina_web_final_fk2 FOREIGN KEY (url_web) 
     REFERENCES pagina_web_final (url_web) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE personal_final (
	nombre TEXT NOT NULL,
	anno_nacimiento integer NOT NULL,
	anno_muerte integer NOT NULL,

	CONSTRAINT personal_final_pk PRIMARY KEY (nombre)
);

CREATE TABLE directores_final (
  nombre TEXT NOT NULL,

  CONSTRAINT directores_final_pk PRIMARY KEY (nombre),
  CONSTRAINT personal_final_fk1 FOREIGN KEY (nombre) 
  REFERENCES personal_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE guionistas_final (
  nombre TEXT NOT NULL,
  
  CONSTRAINT guionistas_final_pk PRIMARY KEY (nombre),
  CONSTRAINT personal_final_fk2 FOREIGN KEY (nombre) 
  REFERENCES personal_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE actores_final (
  nombre TEXT NOT NULL,
  
  CONSTRAINT actores_final_pk PRIMARY KEY (nombre),
  CONSTRAINT personal_final_fk3 FOREIGN KEY (nombre) 
  REFERENCES personal_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE actua_final (
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	nombre_actor TEXT NOT NULL,
	personaje TEXT,

	CONSTRAINT actua_final_pk PRIMARY KEY (titulo_peliculas,anno_peliculas,nombre_actor),
	CONSTRAINT actores_final_fk FOREIGN KEY (nombre_actor) 
     REFERENCES actores_final (nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT peliculas_final_fk3 FOREIGN KEY (titulo_peliculas, anno_peliculas) 
     REFERENCES peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE escribe_final (
	titulo_peliculas TEXT NOT NULL,
	anno_peliculas integer NOT NULL,
	nombre_guionista TEXT NOT NULL,

	CONSTRAINT escribe_final_pk PRIMARY KEY (titulo_peliculas,anno_peliculas,nombre_guionista),
	CONSTRAINT guionistas_final_fk FOREIGN KEY (nombre_guionista) 
     REFERENCES guionistas_final (id) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT peliculas_final_fk4 FOREIGN KEY (titulo_peliculas, anno_peliculas) 
     REFERENCES peliculas_final (titulo, anno) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

ROLLBACK;