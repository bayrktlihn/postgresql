# postgresql
## Trigger nerelerde kullanılıyor
SELECT tgname AS trigger_name,
       relname AS table_name,
       nspname AS schema_name
FROM pg_trigger t
JOIN pg_class c ON t.tgrelid = c.oid
JOIN pg_namespace n ON c.relnamespace = n.oid
WHERE tgfoid = 'e_belediye.pi_rapor_tr_sp()'::regprocedure;
