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
FOR EACH ROW
BEGIN
EXECUTE FUNCTION insertar_pagina_web_trigger_function()
INSERT INTO cine.criticas_final VALUES(NEW.critico, NEW.puntuacion, NEW.texto, NEW. titulo_peliculas, NEW.anno_peliculas, NEW.url_web);

-- Crear el trigger para cine.caratulas_final
CREATE TRIGGER insertar_pagina_web_trigger_caratulas
AFTER INSERT
ON cine.caratulas_final
FOR EACH ROW EXECUTE FUNCTION insertar_pagina_web_trigger_function();
