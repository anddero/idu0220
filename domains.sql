DROP DOMAIN public.d_reg_aeg;
CREATE DOMAIN d_reg_aeg date NOT NULL DEFAULT CURRENT_DATE;
ALTER DOMAIN d_reg_aeg ADD CONSTRAINT reg_aeg_check_lubatud_vahemik CHECK (VALUE >= '01.01.2010 00:00:00' AND VALUE < '01.01.2101 00:00:00');
ALTER DOMAIN d_reg_aeg ADD CONSTRAINT reg_aeg_check_v2iksem_v6rdne_kui_hetke_aeg CHECK (VALUE <=  LOCALTIMESTAMP(0));
ALTER DOMAIN public.d_reg_aeg OWNER to t164416;
