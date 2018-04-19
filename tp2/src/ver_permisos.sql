SELECT grantee, table_name, privilege_type, is_grantable 
FROM information_schema.role_table_grants 
WHERE table_schema='public'
AND grantee != 'postgres'
ORDER BY grantee, table_name;
