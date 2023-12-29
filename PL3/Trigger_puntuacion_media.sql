CREATE TABLE cine.puntuacion_media (
    titulo_peliculas TEXT NOT NULL,
    anno_peliculas INTEGER NOT NULL,
    puntuacion_media NUMERIC(2,1) NOT NULL,
    
    CONSTRAINT puntuacion_media_pk PRIMARY KEY (titulo_peliculas, anno_peliculas),
    
    -- Clave foránea a la tabla peliculas_final
    CONSTRAINT puntuacion_media_fk1 FOREIGN KEY (titulo_peliculas, anno_peliculas)
    REFERENCES cine.peliculas_final (titulo, anno) MATCH FULL
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO cine.puntuacion_media (titulo_peliculas, anno_peliculas, puntuacion_media)
SELECT
    c.titulo_peliculas,
    c.anno_peliculas,
    AVG(c.puntuacion) AS puntuacion_media
FROM
    cine.criticas_final c
GROUP BY
    c.titulo_peliculas, c.anno_peliculas;


-- Crear una función para calcular la puntuación media
CREATE OR REPLACE FUNCTION calcular_puntuacion_media()
RETURNS TRIGGER AS $$
BEGIN
    -- Eliminar las filas existentes para la película y año en la tabla puntuacion_media
    DELETE FROM cine.puntuacion_media
    WHERE titulo_peliculas = NEW.titulo_peliculas AND anno_peliculas = NEW.anno_peliculas;
    
    -- Insertar la nueva puntuación media para la película y año
    INSERT INTO cine.puntuacion_media (titulo_peliculas, anno_peliculas, puntuacion_media)
    SELECT NEW.titulo_peliculas, NEW.anno_peliculas, AVG(puntuacion)
    FROM cine.criticas_final
    WHERE titulo_peliculas = NEW.titulo_peliculas AND anno_peliculas = NEW.anno_peliculas
    GROUP BY titulo_peliculas, anno_peliculas;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger
CREATE TRIGGER actualiza_puntuacion_media
AFTER INSERT OR UPDATE ON cine.criticas_final
FOR EACH ROW
EXECUTE FUNCTION calcular_puntuacion_media();
