DROP FUNCTION IF EXISTS f_lisa_laud(p_laud_kood Laud.laud_kood%TYPE, p_registreerija_id Laud.registreerija_id%TYPE,
p_laua_materjal_kood Laud.laua_materjal_kood%TYPE,p_kohtade_arv Laud.kohtade_arv%type,
p_kommentaar Laud.kommentaar%TYPE) CASCADE;

DROP FUNCTION IF EXISTS f_unusta_laud(p_laud_kood
Laud.laud_kood%TYPE) CASCADE;

DROP FUNCTION IF EXISTS f_muuda_laud (p_laud_kood_vana
Laud.laud_kood%TYPE, p_laud_kood_uus Laud.laud_kood%TYPE,
p_kohtade_arv Laud.kohtade_arv%type, p_kommentaar Laud.kommentaar%TYPE) CASCADE;

DROP FUNCTION IF EXISTS f_lopeta_laud(p_laud_kood Laud.laud_kood%TYPE) CASCADE;

DROP FUNCTION IF EXISTS f_aktiveeri_laud(p_laud_kood Laud.laud_kood%TYPE) CASCADE;

DROP FUNCTION IF EXISTS f_muuda_laud_mitteaktiivseks(p_laud_kood Laud.laud_kood%TYPE) CASCADE;


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
'OP1 Protsess, mis lisab laua. Protseduuri oodatavad
sisendid on laua identifikaator (parameeter p_laud_kood),
laua registreeija identifikaator (parameeter p_registreerija_id),
laua materjali identifikaator (parameeter p_laua_materjal_kood),
kohtade arv (parameeter p_kohtade_arv) ja
kommentaar (parameeter p_kommentaar).
Protseduur lisab laua.';


CREATE OR REPLACE FUNCTION f_unusta_laud(p_laud_kood
Laud.laud_kood%TYPE) RETURNS
Laud.laud_kood%TYPE
AS $$
DELETE FROM Laud WHERE laud_kood=p_laud_kood
RETURNING laud_kood;
$$ LANGUAGE sql SECURITY DEFINER STRICT
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_unusta_laud(p_laud_kood
Laud.laud_kood%TYPE) IS ' OP2 Protsess, mis unustab laua. Protseduuri 
sisend on laua identifikaator (parameeter p_laud_kood).
Protseduur kustutab etteantud laua.';


CREATE OR REPLACE FUNCTION f_muuda_laud(p_laud_kood_vana
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
'OP6 Protsess, mis muudab laua andmeid. Protseduuri oodatavad
sisendid on laua vana identifikaator (parameeter p_laud_kood_vana),
laua uus identifikaator (parameeter p_laud_kood_uus),
kohtade arv (parameeter p_kohtade_arv) ja
kommentaar (parameeter p_kommentaar).
Protseduur muudab etteantud laua.';



CREATE OR REPLACE FUNCTION f_lopeta_laud(p_laud_kood Laud.laud_kood%TYPE)
RETURNS Laud.laud_kood%TYPE
AS $$
UPDATE Laud SET laua_seisundi_liik_kood=4
WHERE laud_kood=p_laud_kood
RETURNING laud_kood;
$$ LANGUAGE sql SECURITY DEFINER STRICT
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lopeta_laud(p_laud_kood Laud.laud_kood%TYPE) IS
'OP5 Protsess, millega lõpetatakse laud. Protseduuri sisend on laua identifikaator (parameeter p_laud_kood).';

ALTER FUNCTION f_lopeta_laud OWNER TO t164416;
GRANT ALL PRIVILEGES ON FUNCTION f_lopeta_laud TO t164416_juhataja;
GRANT EXECUTE ON FUNCTION f_lopeta_laud TO t164416;



CREATE OR REPLACE FUNCTION public.f_aktiveeri_laud(p_laud_kood Laud.laud_kood%TYPE)
    RETURNS void
    LANGUAGE sql
    COST 100
    VOLATILE SECURITY DEFINER 
    SET search_path= public, pg_temp
AS $BODY$
 UPDATE Laud SET laua_seisundi_liik_kood = 2 WHERE ((laua_seisundi_liik_kood = 1) OR (laua_seisundi_liik_kood = 3)) AND (laud_kood = p_laud_kood); 
$BODY$;

COMMENT ON FUNCTION public.f_aktiveeri_laud
    IS 'OP3 Protsess, millega aktiveeritakse laud. Protseduuri sisend on laua identifikaator (parameeter p_laud_kood). Eelduseks on see, et laud on seisundis "Ootel" või "Mitteaktiivne".';



CREATE OR REPLACE FUNCTION public.f_muuda_laud_mitteaktiivseks(p_laud_kood Laud.laud_kood%TYPE)
    RETURNS void
    LANGUAGE sql
    COST 100
    VOLATILE SECURITY DEFINER 
    SET search_path= public, pg_temp
AS $BODY$
 UPDATE Laud SET laua_seisundi_liik_kood = 3 
 WHERE laud_kood = p_laud_kood AND laua_seisundi_liik_kood = 2;
$BODY$;


COMMENT ON FUNCTION public.f_muuda_laud_mitteaktiivseks
    IS 'OP4 Protsess, millega muudetakse laud mitteaktiivseks. Sisend on laua identifikaator (parameeter p_laud_kood). Eelduseks on see, et laud on seisundis "Aktiivne".';


REVOKE ALL
  ON FUNCTION f_unusta_laud, f_lisa_laud, f_muuda_laud, f_lopeta_laud, f_muuda_laud_mitteaktiivseks, f_aktiveeri_laud
  FROM PUBLIC ;



