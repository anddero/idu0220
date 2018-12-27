CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
CREATE OR REPLACE FUNCTION f_on_juhataja(p_kasutajanimi text, p_parool text)
  RETURNS boolean AS $$ DECLARE rslt boolean;
BEGIN
  SELECT INTO rslt (parool = public.crypt(p_parool, parool))
  from isik
         INNER JOIN tootaja ON isik.isik_id = tootaja.tootaja_id
  WHERE Upper(e_meil) = Upper(p_kasutajanimi)
    AND Tootaja.amet_kood = 1
    AND Isiku_seisundi_liik_kood = 1
    AND Tootaja.tootaja_seisundi_liik_kood IN (1, 2, 3, 4);
  RETURN coalesce(rslt, FALSE);
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp;
COMMENT ON FUNCTION f_on_juhataja(p_kasutajanimi text, p_parool text)
IS 'Selle funktsiooni abil autenditakse juhatajat. Parameetri p_kasutajanimi oodatav väärtus on tõstutundetu kasutajanimi ehk e-meil ja parool oodatav väärtus on tõstutundlik avatekstiline parool. Juhatahal on õigus süsteemi siseneda, vaid siis kui tema seisundiks on tööl, haiguslehel, puhkusel või katseajal.';

-- kasutajanimi: t164416_juhataja@gmail.com
-- parool: 164416

ALTER FUNCTION f_on_juhataja OWNER TO t164416;
GRANT ALL PRIVILEGES ON FUNCTION f_on_juhataja TO t164416_juhataja;
GRANT EXECUTE ON FUNCTION f_on_juhataja TO t164416;

REVOKE ALL
  ON FUNCTION f_on_juhataja
  FROM PUBLIC ;
