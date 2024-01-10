CREATE OR REPLACE FUNCTION insertar_pagina_web_trigger_function() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.url_web NOT IN (SELECT url_web FROM cine.pagina_web_final) THEN
        INSERT INTO cine.pagina_web_final (url_web) VALUES (NEW.url_web);

    END IF;
    RETURN NEW;
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
ON cine.caratulas_WEB_final
FOR EACH ROW EXECUTE FUNCTION insertar_pagina_web_trigger_function();
