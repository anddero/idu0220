DROP DOMAIN public.d_reg_kp;
CREATE DOMAIN d_reg_kp date NOT NULL DEFAULT CURRENT_DATE;
ALTER DOMAIN public.d_reg_kp OWNER to t164416;
