-- Consulta para ver los permisos del usuario activo
-- Muestra el nombre de la tabla y los permisos que tiene en esa tabla

SELECT table_schema, table_name, privilege_type
FROM information_schema.table_privileges
WHERE grantee = current_user;