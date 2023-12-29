--Creamos una tabla de auditoría para almacenar los eventos de inserción, modificación y borrado:

CREATE TABLE cine.auditoria (
    evento_id SERIAL PRIMARY KEY,
    tabla_afectada TEXT NOT NULL,
    tipo_evento TEXT NOT NULL,
    usuario TEXT NOT NULL,
    fecha_hora timestamp DEFAULT current_timestamp
);


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

-- Crear el trigger de auditoría para cada tabla en el esquema
DO $$ 
DECLARE
    tabla_name TEXT;
BEGIN
    FOR tabla_name IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'cine') 
    LOOP
        EXECUTE format('
            CREATE TRIGGER auditoria_trigger_%s
            AFTER INSERT OR UPDATE OR DELETE ON %s
            FOR EACH ROW EXECUTE FUNCTION auditoria_trigger_function()',
            tabla_name, tabla_name);
    END LOOP;
END $$;