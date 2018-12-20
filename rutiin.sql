CREATE OR REPLACE FUNCTION f_lisa_laud(p_laua_kood Laud.laua_kood%TYPE, p_isiku_id Laud.isiku_id%TYPE,
p_laua_materjal_kood Laud.laua_materjal_kood%TYPE,p_kohtade_arv Laud.kohtade_arv%type,
p_kommentaar Laud.kommentaar%TYPE)
RETURNS Laud.laua_kood%TYPE AS $$
INSERT INTO Laud(laua_kood, isiku_id, laua_materjal_kood, kohtade_arv, kommentaar) VALUES
(p_laua_kood,p_isiku_id, p_laua_materjal_kood, p_kohtade_arv, p_kommentaar) ON CONFLICT DO NOTHING
RETURNING laua_kood;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=public, pg_temp;

COMMENT ON FUNCTION f_lisa_laud(p_laua_kood Laud.laua_kood%TYPE, p_isiku_id Laud.isiku_id%TYPE,
p_laua_materjal_kood Laud.laua_materjal_kood%TYPE,p_kohtade_arv Laud.kohtade_arv%type,
p_kommentaar Laud.kommentaar%TYPE) IS
'OP1 Protseduuri oodatavad
sisendid on laua identifikaator (parameeter p_laua_kood),
isiku identifikaator (parameeter p_isiku_id),
laua materjali identifikaator (parameeter p_laua_materjal_kood),
kohtade arv (parameeter p_kohtade_arv) ja
kommentaar (parameeter p_kommentaar).
Protseduur lisab laua.';
--SELECT f_lisa_laud(p_laua_kood:=13, p_isiku_id:=3, p_laua_materjal_kood:=4, p_kohtade_arv:=3, p_kommentaar:='Kena laud!');

ALTER FUNCTION f_lisa_laud OWNER TO t164416;
GRANT ALL PRIVILEGES ON FUNCTION f_lisa_laud TO t164416_juhataja;
GRANT EXECUTE ON FUNCTION f_lisa_laud TO t164416;

CREATE OR REPLACE FUNCTION f_laua_unustamine(p_laua_kood
Laud.laua_kood%TYPE) RETURNS
Laud.laua_kood%TYPE
AS $$
DELETE FROM Laud WHERE laua_kood=p_laua_kood
RETURNING laua_kood;
$$ LANGUAGE sql SECURITY DEFINER STRICT
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_laua_unustamine(p_laua_kood
Laud.laua_kood%TYPE) IS ' OP2 Protseduuri oodatavad
sisendid on laua identifikaator (parameeter p_laua_kood).
Protseduur kustutab etteantud laua.';

--SELECT f_lisa_laud(p_laua_kood:=13);

ALTER FUNCTION f_laua_unustamine OWNER TO t164416;
GRANT ALL PRIVILEGES ON FUNCTION f_laua_unustamine TO t164416_juhataja;
GRANT EXECUTE ON FUNCTION f_laua_unustamine TO t164416;

CREATE OR REPLACE FUNCTION f_muuda_laud (p_laua_kood_vana
Laud.laua_kood%TYPE, p_laua_kood_uus Laud.laua_kood%TYPE,
p_kohtade_arv Laud.kohtade_arv%type, p_kommentaar Laud.kommentaar%TYPE)
RETURNS VOID AS $$
UPDATE Laud SET laua_kood=p_laua_kood_uus,
kohtade_arv=p_kohtade_arv, kommentaar=p_kommentaar
WHERE laua_kood=p_laua_kood_vana;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=public, pg_temp;

COMMENT ON FUNCTION f_muuda_laud (p_laua_kood_vana
Laud.laua_kood%TYPE, p_laua_kood_uus Laud.laua_kood%TYPE, p_kohtade_arv
Laud.kohtade_arv%type, p_kommentaar Laud.kommentaar%TYPE) IS
'OP3 Protseduuri oodatavad
sisendid on laua vana identifikaator (parameeter p_laua_kood_vana),
laua uus identifikaator (parameeter p_laua_kood_uus),
laua vana identifikaator (parameeter p_laua_kood_vana),
isiku identifikaator (parameeter p_isiku_id),
kohtade arv (parameeter p_kohtade_arv) ja
kommentaar (parameeter p_kommentaar).
Protseduur muudab etteantud laua.';
--SELECT f_muuda_laud(p_laua_kood_vana:=13,p_laua_kood_uus:=12,p_kohtade_arv:=5,p_kommentaar:='Uuem ja parem laud');

--Välja kutsumiseks SELECT f_laua_kustutamine(p_laua_id:=X); X=laua_id mida tahetakse kustutada

ALTER FUNCTION f_muuda_laud OWNER TO t164416;
GRANT ALL PRIVILEGES ON FUNCTION f_muuda_laud TO t164416_juhataja;
GRANT EXECUTE ON FUNCTION f_muuda_laud TO t164416;


ALTER FUNCTION postgres_fdw_handler OWNER TO t164416;
GRANT ALL PRIVILEGES ON FUNCTION postgres_fdw_handler TO t164416_juhataja;
GRANT EXECUTE ON FUNCTION postgres_fdw_handler TO t164416;

ALTER FUNCTION postgres_fdw_validator OWNER TO t164416;
GRANT ALL PRIVILEGES ON FUNCTION postgres_fdw_validator TO t164416_juhataja;
GRANT EXECUTE ON FUNCTION postgres_fdw_validator TO t164416;

--Public to Private
REVOKE ALL
  ON FUNCTION f_laua_unustamine, f_lisa_laud, f_muuda_laud
  FROM PUBLIC ;

--Delete Functions

--DROP FUNCTION  f_lisa_laud(p_laua_kood Laud.laua_kood%TYPE, p_isiku_id Laud.isiku_id%TYPE,
--p_laua_materjal_kood Laud.laua_materjal_kood%TYPE,p_kohtade_arv Laud.kohtade_arv%type,
--p_kommentaar Laud.kommentaar%TYPE) CASCADE;

--DROP FUNCTION f_laua_unustamine(p_laua_kood
--Laud.laua_kood%TYPE) CASCADE;

--DROP FUNCTION f_muuda_laud (p_laua_kood_vana
--Laud.laua_kood%TYPE, p_laua_kood_uus Laud.laua_kood%TYPE,
--p_kohtade_arv Laud.kohtade_arv%type, p_kommentaar Laud.kommentaar%TYPE) CASCADE;
