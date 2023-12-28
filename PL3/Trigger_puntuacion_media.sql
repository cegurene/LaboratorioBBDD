CREATE OR REPLACE FUNCTION actualizar_puntuacion_media_trigger_function() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        UPDATE cine.peliculas_final
        SET puntuacion_media = (
            SELECT AVG(puntuacion)
            FROM cine.criticas_final
            WHERE titulo_peliculas = NEW.titulo_peliculas AND anno_peliculas = NEW.anno_peliculas
        )
        WHERE titulo = NEW.titulo_peliculas AND anno = NEW.anno_peliculas;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER actualizar_puntuacion_media_trigger
AFTER INSERT OR UPDATE
ON cine.criticas_final
FOR EACH ROW EXECUTE FUNCTION actualizar_puntuacion_media_trigger_function();


-- Estos scripts asumen que hay un campo llamado puntuacion_media en la tabla cine.peliculas_final para almacenar la puntuación media de cada película.
-- Asegúrate de ajustar los scripts según la estructura real de tu base de datos.