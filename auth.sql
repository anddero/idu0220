CREATE OR REPLACE FUNCTION f_on_juhataja(p_kasutajanimi text, p_parool text)
  RETURNS boolean AS $$ DECLARE rslt boolean;
BEGIN
  SELECT INTO rslt (parool = public.crypt(p_parool, parool))
  from isik
         INNER JOIN tootaja ON isik.isiku_id = tootaja.isiku_id
  WHERE Upper(e_meil) = Upper(p_kasutajanimi)
    AND amet_kood = 1
    AND tootaja_seisundi_liik_kood IN (1, 2, 3, 4);
  RETURN coalesce(rslt, FALSE);
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER
STABLE
SET search_path = public, pg_temp;
COMMENT ON FUNCTION f_on_juhataja(p_kasutajanimi text, p_parool text)
IS 'Selle funktsiooni abil autenditakse juhatajat. Parameetri p_kasutajanimi oodatav väärtus on tõstutundetu kasutajanimi ehk e-meil ja parool oodatav väärtus on tõstutundlik avatekstiline parool. Juhatahal on õigus süsteemi siseneda, vaid siis kui tema seisundiks on tööl, haiguslehel, puhkusel või katseajal.';