--Creamos una tabla de auditoría para almacenar los eventos de inserción, modificación y borrado:

CREATE TABLE cine.auditoria (
    evento_id SERIAL PRIMARY KEY,
    tabla_afectada TEXT NOT NULL,
    tipo_evento TEXT NOT NULL,
    usuario TEXT NOT NULL,
    fecha_hora timestamp DEFAULT current_timestamp
);


--Creamos el trigger

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

CREATE TRIGGER auditoria_trigger
AFTER INSERT OR UPDATE OR DELETE
ON cine.peliculas_final, cine.criticas_final, cine.caratulas_final, cine.caratulas_WEB_final,
   cine.personal_final, cine.directores_final, cine.guionistas_final, cine.actores_final,
   cine.actua_final, cine.escribe_final, cine.generos_peliculas_final
FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function();
