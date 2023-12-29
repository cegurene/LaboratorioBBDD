-- Creacion de tablas

-- Tabla auditoria

CREATE TABLE cine.auditoria (
    evento_id SERIAL PRIMARY KEY,
    tabla_afectada TEXT NOT NULL,
    tipo_evento TEXT NOT NULL,
    usuario TEXT NOT NULL,
    fecha_hora timestamp DEFAULT current_timestamp
);

-- Tabla puntuacion_media

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

-- Importar datos actuales a la tabla puntuacion_media

INSERT INTO cine.puntuacion_media (titulo_peliculas, anno_peliculas, puntuacion_media)
SELECT
    c.titulo_peliculas,
    c.anno_peliculas,
    AVG(c.puntuacion) AS puntuacion_media
FROM
    cine.criticas_final c
GROUP BY
    c.titulo_peliculas, c.anno_peliculas;


-- Creacion de triggers

-- Trigger auditoria

CREATE OR REPLACE FUNCTION auditoria_trigger_function() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO cine.auditoria (tabla_afectada, tipo_evento, usuario)
        VALUES (TG_TABLE_NAME, 'INSERT', current_user);
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO cine.auditoria (tabla_afectada, tipo_evento, usuario)
        VALUES (TG_TABLE_NAME, 'UPDATE', current_user);
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO cine.auditoria (tabla_afectada, tipo_evento, usuario)
        VALUES (TG_TABLE_NAME, 'DELETE', current_user);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER auditoria_trigger1
AFTER INSERT OR UPDATE OR DELETE ON cine.criticas_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger2
AFTER INSERT OR UPDATE OR DELETE ON cine.peliculas_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger3
AFTER INSERT OR UPDATE OR DELETE ON cine.caratulas_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger4
AFTER INSERT OR UPDATE OR DELETE ON cine.pagina_web_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger5
AFTER INSERT OR UPDATE OR DELETE ON cine.caratulas_WEB_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger6
AFTER INSERT OR UPDATE OR DELETE ON cine.personal_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger7
AFTER INSERT OR UPDATE OR DELETE ON cine.directores_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger8
AFTER INSERT OR UPDATE OR DELETE ON cine.guionistas_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger9
AFTER INSERT OR UPDATE OR DELETE ON cine.actores_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger10
AFTER INSERT OR UPDATE OR DELETE ON cine.actua_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger11
AFTER INSERT OR UPDATE OR DELETE ON cine.escribe_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();

CREATE TRIGGER auditoria_trigger12
AFTER INSERT OR UPDATE OR DELETE ON cine.generos_peliculas_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();


-- Trigger pagina web

CREATE OR REPLACE FUNCTION insertar_pagina_web_trigger_function() RETURNS TRIGGER AS $$
BEGIN
    IF TG_TABLE_NAME = 'criticas_final' AND NEW.url_web NOT IN (SELECT url_web FROM cine.pagina_web_final) THEN
        INSERT INTO cine.pagina_web_final (url_web) VALUES (NEW.url_web);
    ELSIF TG_TABLE_NAME = 'caratulas_final' AND NEW.url_web NOT IN (SELECT url_web FROM cine.pagina_web_final) THEN
        INSERT INTO cine.pagina_web_final (url_web) VALUES (NEW.url_web);
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger para cine.criticas_final
CREATE TRIGGER insertar_pagina_web_trigger_criticas
BEFORE INSERT
ON cine.criticas_final
FOR EACH ROW EXECUTE FUNCTION insertar_pagina_web_trigger_function();

-- Crear el trigger para cine.caratulas_final
CREATE TRIGGER insertar_pagina_web_trigger_caratulas
BEFORE INSERT
ON cine.caratulas_final
FOR EACH ROW EXECUTE FUNCTION insertar_pagina_web_trigger_function();


-- Trigger puntuacion media

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