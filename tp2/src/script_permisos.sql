GRANT SELECT ON ALL TABLES IN SCHEMA public TO "userA";
GRANT INSERT ON TABLE audit TO "userA" WITH GRANT OPTION;

GRANT SELECT, INSERT, UPDATE ON TABLE avion, piloto, "pilotoAvion" TO "userB";
