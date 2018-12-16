DROP DOMAIN public.d_reg_kp;
CREATE DOMAIN d_reg_kp date NOT NULL DEFAULT CURRENT_DATE;
ALTER DOMAIN d_reg_kp ADD CONSTRAINT reg_kp_check_lubatud_vahemik CHECK (VALUE >= '01.01.2010' AND VALUE < '01.01.2101');
ALTER DOMAIN d_reg_kp ADD CONSTRAINT reg_kp_check_v2iksem_v6rdne_kui_hetke_kuupaev CHECK (VALUE <= CURRENT_DATE);
ALTER DOMAIN public.d_reg_kp OWNER to t164416;
