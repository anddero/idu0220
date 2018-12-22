CREATE OR REPLACE FUNCTION public.f_kustuta_laud()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$

BEGIN
	RAISE EXCEPTION 'Ainult ootel olevaid laudu on võimalik kustutada!';
	RETURN OLD;
END;

$BODY$;
ALTER FUNCTION public.f_kustuta_laud()
    OWNER TO t164416;
GRANT EXECUTE ON FUNCTION public.f_kustuta_laud() TO t164416;
REVOKE ALL ON FUNCTION public.f_kustuta_laud() FROM PUBLIC;
COMMENT ON FUNCTION public.f_kustuta_laud()
    IS 'See trigger määrab ära selle, et kustutada saab ainult ootel olevaid laudu ning olemas peab vähemalt üks laua kategooria.';



CREATE OR REPLACE FUNCTION public.f_muuda_laua_seisundi_liik()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF 
AS $BODY$
BEGIN
	RAISE EXCEPTION 'Nii pole võimalik muuta laua seisundit!';
	RETURN NULL;
END;
$BODY$;
ALTER FUNCTION public.f_muuda_laua_seisundi_liik()
    OWNER TO t164416;
GRANT EXECUTE ON FUNCTION public.f_muuda_laua_seisundi_liik() TO t164416;
REVOKE ALL ON FUNCTION public.f_muuda_laua_seisundi_liik() FROM PUBLIC;
COMMENT ON FUNCTION public.f_muuda_laua_seisundi_liik()
    IS 'See trigger kontrollib, et toimub korrektne laua seisundi liigi muudatus. 
	Kui old.laua_seisundi_liik_kood=new.laua_seisundi_liik_kood, siis laua seisundi kood jääb samaks.';

	
DROP TRIGGER IF EXISTS trig_laud_kustuta_laud ON public.Laud;
CREATE TRIGGER trig_laud_kustuta_laud
    BEFORE DELETE
    ON public.Laud
    FOR EACH ROW
    WHEN ((old.laua_seisundi_liik_kood <> 1))
    EXECUTE PROCEDURE public.f_kustuta_laud();


DROP TRIGGER IF EXISTS trig_laud_muuda_laua_seisundi_liik ON public.Laud;
CREATE TRIGGER trig_laud_muuda_laua_seisundi_liik
    BEFORE UPDATE OF laua_seisundi_liik_kood
    ON public.Laud
    FOR EACH ROW
    WHEN ((NOT ((old.laua_seisundi_liik_kood = new.laua_seisundi_liik_kood) OR ((old.laua_seisundi_liik_kood = 1) AND (new.laua_seisundi_liik_kood = 3)) OR ((old.laua_seisundi_liik_kood = 3) AND (new.laua_seisundi_liik_kood = ANY (ARRAY[2, 4]))) OR ((old.laua_seisundi_liik_kood = 2) AND (new.laua_seisundi_liik_kood = ANY (ARRAY[3, 4]))))))
    EXECUTE PROCEDURE public.f_muuda_laua_seisundi_liik();