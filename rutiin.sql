CREATE OR REPLACE FUNCTION f_lisa_laud (p_laua_kood Laud.laua_kood%TYPE, p_isiku_id Laud.isiku_id%TYPE,
p_laua_materjal_kood Laud.laua_materjal_kood%TYPE,p_kohtade_arv Laud.kohtade_arv%type,
p_kommentaar Laud.kommentaar%TYPE)
RETURNS Laud.laua_kood%TYPE AS $$
INSERT INTO Laud(laua_kood, isiku_id, laua_materjal_kood, kohtade_arv, kommentaar) VALUES
(p_laua_kood,p_isiku_id, p_laua_materjal_kood, p_kohtade_arv, p_kommentaar) ON CONFLICT DO NOTHING
RETURNING laua_kood;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=public, pg_temp;

COMMENT ON FUNCTION f_lisa_laud(p_laua_kood integer, p_isiku_id integer, p_laua_materjal_kood integer, p_kohtade_arv integer, p_kommentaar varchar) IS 'Laua lisamine parameetrid on laua_kood, isiku_id, laua_materjal_kood, kohtade_arv ja kommmentaar';
COMMENT ON FUNCTION f_lisa_laud IS 'Laua lisamine parameetrid on laua_kood, isiku_id, laua_materjal_kood, kohtade_arv ja kommmentaar';

SELECT f_lisa_laud(p_laua_kood:=13, p_isiku_id:=3, p_laua_materjal_kood:=4, p_kohtade_arv:=3, p_kommentaar:='Kena laud!');

CREATE OR REPLACE FUNCTION f_laua_kustutamine(p_laua_kood
Laud.laua_kood%TYPE) RETURNS BOOLEAN
AS $$
BEGIN
DELETE FROM Laud WHERE laua_kood=p_laua_kood;
--Kui kustutati vahemalt 1 rida, siis FOUND=TRUE
COMMENT ON TABLE Laud.laua_kood IS 'Kustutatav laud';
RETURN FOUND;
END; $$
LANGUAGE plpgsql SECURITY DEFINER STRICT
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_laua_kustutamine IS 'Laua kood mida soovitakse kustutada parameetriks on laua_kood integer';

SELECT f_lisa_laud(p_laua_kood:=13);

CREATE OR REPLACE FUNCTION f_muuda_laud (p_laua_kood_vana
Laud.laua_kood%TYPE, p_laua_kood_uus Laud.laua_kood%TYPE,
p_isiku_id Laud.isiku_id%TYPE, p_kohtade_arv
Laud.kohtade_arv%type, p_kommentaar Laud.kommentaar%TYPE)
RETURNS VOID AS $$
UPDATE Laud SET laua_kood=p_laua_kood_uus,
isiku_id=p_isiku_id, kohtade_arv=p_kohtade_arv, kommentaar=p_kommentaar
WHERE laua_kood=p_laua_kood_vana;
$$ LANGUAGE SQL SECURITY DEFINER
SET search_path=private, pg_temp;

COMMENT ON FUNCTION f_muuda_laud IS 'Laua muutmine parameetrid on laua_kood_vana, laua_kood_uus, isiku_id, kohtade_arv ja kommmentaar';

SELECT f_muuda_laud(p_laua_kood_vana:=13,p_laua_kood_uus:=12,p_kohtade_arv:=5,p_kommentaar:='Uuem ja parem laud');

--Välja kutsumiseks SELECT f_laua_kustutamine(p_laua_id:=X); X=laua_id mida tahetakse kustutada