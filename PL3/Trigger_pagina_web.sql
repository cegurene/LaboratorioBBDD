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

CREATE TRIGGER insertar_pagina_web_trigger
AFTER INSERT
ON cine.criticas_final, cine.caratulas_final
FOR EACH ROW EXECUTE FUNCTION insertar_pagina_web_trigger_function();
