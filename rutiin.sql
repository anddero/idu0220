DROP FUNCTION IF EXISTS f_lisa_laud(p_laud_kood Laud.laud_kood%TYPE, p_registreerija_id Laud.registreerija_id%TYPE,
p_laua_materjal_kood Laud.laua_materjal_kood%TYPE,p_kohtade_arv Laud.kohtade_arv%type,
p_kommentaar Laud.kommentaar%TYPE) CASCADE;

DROP FUNCTION IF EXISTS f_laua_unustamine(p_laud_kood
Laud.laud_kood%TYPE) CASCADE;

DROP FUNCTION IF EXISTS f_muuda_laud (p_laud_kood_vana
Laud.laud_kood%TYPE, p_laud_kood_uus Laud.laud_kood%TYPE,
p_kohtade_arv Laud.kohtade_arv%type, p_kommentaar Laud.kommentaar%TYPE) CASCADE;




CREATE OR REPLACE FUNCTION f_lisa_laud(p_laud_kood Laud.laud_kood%TYPE, p_registreerija_id Laud.registreerija_id%TYPE,
p_laua_materjal_kood Laud.laua_materjal_kood%TYPE,p_kohtade_arv Laud.kohtade_arv%type,
p_kommentaar Laud.kommentaar%TYPE)
RETURNS Laud.laud_kood%TYPE AS $$
INSERT INTO Laud(laud_kood, registreerija_id, laua_materjal_kood, kohtade_arv, kommentaar) VALUES
(p_laud_kood,p_registreerija_id, p_laua_materjal_kood, p_kohtade_arv, p_kommentaar) ON CONFLICT DO NOTHING
RETURNING laud_kood;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=public, pg_temp;

COMMENT ON FUNCTION f_lisa_laud(p_laud_kood Laud.laud_kood%TYPE, p_registreerija_id Laud.registreerija_id%TYPE,
p_laua_materjal_kood Laud.laua_materjal_kood%TYPE,p_kohtade_arv Laud.kohtade_arv%type,
p_kommentaar Laud.kommentaar%TYPE) IS
'OP1 Protseduuri oodatavad
sisendid on laua identifikaator (parameeter p_laud_kood),
laua registreeija identifikaator (parameeter p_registreerija_id),
laua materjali identifikaator (parameeter p_laua_materjal_kood),
kohtade arv (parameeter p_kohtade_arv) ja
kommentaar (parameeter p_kommentaar).
Protseduur lisab laua.';
--SELECT f_lisa_laud(p_laud_kood:=13, p_registreerija_id:=3, p_laua_materjal_kood:=4, p_kohtade_arv:=3, p_kommentaar:='Kena laud!');




CREATE OR REPLACE FUNCTION f_laua_unustamine(p_laud_kood
Laud.laud_kood%TYPE) RETURNS
Laud.laud_kood%TYPE
AS $$
DELETE FROM Laud WHERE laud_kood=p_laud_kood
RETURNING laud_kood;
$$ LANGUAGE sql SECURITY DEFINER STRICT
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_laua_unustamine(p_laud_kood
Laud.laud_kood%TYPE) IS ' OP2 Protseduuri oodatavad
sisendid on laua identifikaator (parameeter p_laud_kood).
Protseduur kustutab etteantud laua.';

--SELECT f_lisa_laud(p_laud_kood:=13);




CREATE OR REPLACE FUNCTION f_muuda_laud (p_laud_kood_vana
Laud.laud_kood%TYPE, p_laud_kood_uus Laud.laud_kood%TYPE,
p_kohtade_arv Laud.kohtade_arv%type, p_kommentaar Laud.kommentaar%TYPE)
RETURNS VOID AS $$
UPDATE Laud SET laud_kood=p_laud_kood_uus,
kohtade_arv=p_kohtade_arv, kommentaar=p_kommentaar
WHERE laud_kood=p_laud_kood_vana;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=public, pg_temp;

COMMENT ON FUNCTION f_muuda_laud (p_laud_kood_vana
Laud.laud_kood%TYPE, p_laud_kood_uus Laud.laud_kood%TYPE, p_kohtade_arv
Laud.kohtade_arv%type, p_kommentaar Laud.kommentaar%TYPE) IS
'OP3 Protseduuri oodatavad
sisendid on laua vana identifikaator (parameeter p_laud_kood_vana),
laua uus identifikaator (parameeter p_laud_kood_uus),
kohtade arv (parameeter p_kohtade_arv) ja
kommentaar (parameeter p_kommentaar).
Protseduur muudab etteantud laua.';
--SELECT f_muuda_laud(p_laud_kood_vana:=13,p_laud_kood_uus:=12,p_kohtade_arv:=5,p_kommentaar:='Uuem ja parem laud');

CREATE OR REPLACE FUNCTION f_lopeta_laud(p_laud_kood Laud.laud_kood%TYPE)
RETURNS Laud.laud_kood%TYPE
AS $$
UPDATE Laud SET laua_seisundi_liik_kood=4
WHERE laud_kood=p_laud_kood
RETURNING laud_kood;
$$ LANGUAGE sql SECURITY DEFINER STRICT
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lopeta_laud(p_laud_kood Laud.laud_kood%TYPE) IS
'OP4 Protsess, millega lõpetatakse laud. Sisendid on laua identifikaator (parameeter p_laud_kood).';

--Välja kutsumiseks SELECT f_laua_unustamine(p_laua_id:=X); X=laua_id mida tahetakse kustutada

--Public to Private
REVOKE ALL
  ON FUNCTION f_laua_unustamine, f_lisa_laud, f_muuda_laud, f_lopeta_laud
  FROM PUBLIC ;



