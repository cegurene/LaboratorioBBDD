CREATE TABLE Peliculas (
	Titulo char(20) NOT NULL,
	Año date NOT NULL,
	Duracion integer NOT NULL,
	CalificacionMPA integer NOT NULL,
	Idioma char(4) NOT NULL,
	Generos char(40) NOT NULL,
	id_Directores integer,
	CONSTRAINT Peliculas_pk PRIMARY KEY (Titulo,Año),
	CONSTRAINT Directores_fk FOREIGN KEY (id_Directores) REFERENCES Directores (id) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Criticas (
	Critico char(20) NOT NULL,
	Puntuacion integer NOT NULL,
	Texto char(400) NOT NULL,
	Titulo_Peliculas char(20) NOT NULL,
	Año_Peliculas date NOT NULL,
	URL_PaginaWeb char(2083) NOT NULL,
	Fecha date NOT NULL,
	CONSTRAINT Criticas_pk PRIMARY KEY (Critico),
	CONSTRAINT Peliculas_fk FOREIGN KEY (Titulo_Peliculas, Año_Peliculas) REFERENCES Peliculas (Titulo, Año) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT PaginaWeb_fk FOREIGN KEY (URL_PaginaWeb) REFERENCES PaginaWeb (URL) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE PaginaWeb (
	URL char(2083) NOT NULL,
	Tipo char(20),
	CONSTRAINT PaginaWeb_pk PRIMARY KEY (URL)
);

CREATE TABLE Caratulas (
	Nombre char(20) NOT NULL,
	Tamaño integer NOT NULL,
	URL_PaginaWeb char(2083) NOT NULL,
	Fecha date NOT NULL,
	Titulo_Peliculas char(20) NOT NULL,
	Año_Peliculas date NOT NULL,
	CONSTRAINT Caratulas_pk PRIMARY KEY (Nombre),
	CONSTRAINT Peliculas_fk FOREIGN KEY (Titulo_Peliculas, Año_Peliculas) REFERENCES Peliculas (Titulo, Año) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT PaginaWeb_fk FOREIGN KEY (URL_PaginaWeb) REFERENCES PaginaWeb (URL) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Personal (
	Nombre char(20) NOT NULL,
	AñoNacimiento date NOT NULL,
	AñoMuerte integer NOT NULL,
	CONSTRAINT Personal_pk PRIMARY KEY (Nombre)
);

CREATE TABLE Directores (
  Nombre char(20),
  id integer NOT NULL,
  CONSTRAINT Directores_pk PRIMARY KEY (id),
  CONSTRAINT Personal_fk FOREIGN KEY (Nombre) REFERENCES Personal (Nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Guionistas (
  Nombre char(20),
  id integer NOT NULL,
  CONSTRAINT Guionistas_pk PRIMARY KEY (id),
  CONSTRAINT Personal_fk FOREIGN KEY (Nombre) REFERENCES Personal (Nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Actores (
  Nombre char(20),
  id integer NOT NULL,
  CONSTRAINT Actores_pk PRIMARY KEY (id),
  CONSTRAINT Personal_fk FOREIGN KEY (Nombre) REFERENCES Personal (Nombre) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Actua (
	Titulo_Peliculas char(20) NOT NULL,
	Año_Peliculas date NOT NULL,
	id_Actores integer NOT NULL,
	Personaje char(30),
	CONSTRAINT Actua_pk PRIMARY KEY (Titulo_Peliculas,Año_Peliculas,id_Actores),
	CONSTRAINT Actores_fk FOREIGN KEY (id_Actores) REFERENCES Actores (id) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT Peliculas_fk FOREIGN KEY (Titulo_Peliculas, Año_Peliculas) REFERENCES Peliculas (Titulo, Año) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Escribe (
	Titulo_Peliculas char(20) NOT NULL,
	Año_Peliculas date NOT NULL,
	id_Guionistas integer NOT NULL,
	CONSTRAINT Escribe_pk PRIMARY KEY (Titulo_Peliculas,Año_Peliculas,id_Guionistas),
	CONSTRAINT Guionistas_fk FOREIGN KEY (id_Guionistas) REFERENCES Guionistas (id) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT Peliculas_fk FOREIGN KEY (Titulo_Peliculas, Año_Peliculas) REFERENCES Peliculas (Titulo, Año) MATCH FULL ON DELETE RESTRICT ON UPDATE CASCADE
);