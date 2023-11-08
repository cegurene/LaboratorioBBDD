CREATE TABLE Peliculas (
	Titulo TEXT NOT NULL,
	Año date NOT NULL,
	Duracion integer NOT NULL,
	CalificacionMPA TEXT,
	Idioma char(2) NOT NULL,
	nombre_Personal_Directores TEXT NOT NULL,

	CONSTRAINT Peliculas_pk PRIMARY KEY (Titulo,Año),
	CONSTRAINT Directores_fk FOREIGN KEY (nombre_Personal_Directores) 
     REFERENCES Directores (id) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Criticas (
	Critico TEXT NOT NULL,
	Puntuacion numeric(2,1) NOT NULL,
	Texto TEXT NOT NULL,
	Titulo_Peliculas TEXT NOT NULL,
	Año_Peliculas integer NOT NULL,
	URL_PaginaWeb TEXT NOT NULL,
	Fecha date NOT NULL,

	CONSTRAINT Criticas_pk PRIMARY KEY (Critico),
	CONSTRAINT Peliculas_fk FOREIGN KEY (Titulo_Peliculas, Año_Peliculas) 
     REFERENCES Peliculas (Titulo, Año) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT PaginaWeb_fk FOREIGN KEY (URL_PaginaWeb) 
     REFERENCES PaginaWeb (url_web) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE PaginaWeb (
	url_web TEXT NOT NULL,
	Tipo char(20),
	CONSTRAINT PaginaWeb_pk PRIMARY KEY (url_web)
);

CREATE TABLE Caratulas (
	Nombre TEXT NOT NULL,
	Tamaño TEXT NOT NULL,
	Titulo_Peliculas TEXT NOT NULL,
	Año_Peliculas integer NOT NULL,

	CONSTRAINT Caratulas_pk PRIMARY KEY (Nombre,Titulo_Peliculas, Año_Peliculas),
	CONSTRAINT Peliculas_fk FOREIGN KEY (Titulo_Peliculas, Año_Peliculas) 
     REFERENCES Peliculas (Titulo, Año) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	
);

CREATE TABLE Caratulas_WEB (
     URL_PaginaWeb TEXT NOT NULL,
	Fecha date NOT NULL,
	Titulo_Peliculas TEXT NOT NULL,
	Año_Peliculas integer NOT NULL,

     CONSTRAINT Caratulas_WEB_pk PRIMARY KEY (URL_PaginaWeb,Titulo_Peliculas, Año_Peliculas),
     CONSTRAINT PaginaWeb_fk FOREIGN KEY (URL_PaginaWeb) 
     REFERENCES PaginaWeb (url_web) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE Personal (
	Nombre TEXT NOT NULL,
	AñoNacimiento integer NOT NULL,
	AñoMuerte integer NOT NULL,

	CONSTRAINT Personal_pk PRIMARY KEY (Nombre)
);

CREATE TABLE Directores (
  Nombre TEXT NOT NULL,

  CONSTRAINT Directores_pk PRIMARY KEY (Nombre),
  CONSTRAINT Personal_fk FOREIGN KEY (Nombre) 
  REFERENCES Personal (Nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Guionistas (
  Nombre TEXT NOT NULL,
  
  CONSTRAINT Guionistas_pk PRIMARY KEY (Nombre),
  CONSTRAINT Personal_fk FOREIGN KEY (Nombre) 
  REFERENCES Personal (Nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Actores (
  Nombre TEXT NOT NULL,
  
  CONSTRAINT Actores_pk PRIMARY KEY (Nombre),
  CONSTRAINT Personal_fk FOREIGN KEY (Nombre) 
  REFERENCES Personal (Nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Actua (
	Titulo_Peliculas TEXT NOT NULL,
	Año_Peliculas integer NOT NULL,
	Nombre_actor TEXT NOT NULL,
	Personaje TEXT,

	CONSTRAINT Actua_pk PRIMARY KEY (Titulo_Peliculas,Año_Peliculas,Nombre_actor),
	CONSTRAINT Actores_fk FOREIGN KEY (Nombre_actor) 
     REFERENCES Actores (Nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT Peliculas_fk FOREIGN KEY (Titulo_Peliculas, Año_Peliculas) 
     REFERENCES Peliculas (Titulo, Año) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Escribe (
	Titulo_Peliculas TEXT NOT NULL,
	Año_Peliculas integer NOT NULL,
	Nombre_guionista TEXT NOT NULL,

	CONSTRAINT Escribe_pk PRIMARY KEY (Titulo_Peliculas,Año_Peliculas,Nombre_guionista),
	CONSTRAINT Guionistas_fk FOREIGN KEY (Nombre_guionista) 
     REFERENCES Guionistas (id) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT Peliculas_fk FOREIGN KEY (Titulo_Peliculas, Año_Peliculas) 
     REFERENCES Peliculas (Titulo, Año) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);