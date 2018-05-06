INSERT INTO aeropuerto_hangares VALUES (
    'coso', 
    ROW('coso', 'coso', 'coso'),
    ROW(100, 100, 'coso'),
    ARRAY['coso'],
    100,
    ARRAY[CAST(ROW(15, false, 20556) AS t_espacio)]
);

(SELECT oid FROM AVION ORDER BY oid ASC LIMIT 1)
UNION ALL 
(SELECT oid FROM AVION ORDER BY oid DESC LIMIT 1);
