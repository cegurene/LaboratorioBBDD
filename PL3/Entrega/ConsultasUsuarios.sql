-- Consulta para ver los permisos del usuario activo
-- Muestra el nombre de la tabla y los permisos que tiene en esa tabla

SELECT 
    table_schema, 
    table_name, 
    STRING_AGG(privilege_type, ', ') AS concatenated_privileges
FROM 
    information_schema.table_privileges
WHERE 
    grantee = current_user
GROUP BY 
    table_schema, table_name;