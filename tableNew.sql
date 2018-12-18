ALTER FUNCTION public.f_lisa_laud OWNER TO t164416admin;
GRANT ALL PRIVILEGES ON FUNCTION public.f_lisa_laud TO t164416admin;
ALTER FUNCTION public.f_laua_kustutamine OWNER TO t164416admin;
GRANT ALL PRIVILEGES ON FUNCTION public.f_laua_kustutamine TO t164416admin;
ALTER FUNCTION public.f_muuda_laud OWNER TO t164416admin;
GRANT ALL PRIVILEGES ON FUNCTION public.f_muuda_laud TO t164416admin;

ALTER TABLE public.aktiivsed_ja_mitteaktiivsed_lauad OWNER TO t164416admin;
GRANT ALL PRIVILEGES ON TABLE public.aktiivsed_ja_mitteaktiivsed_lauad TO t164416admin;
ALTER TABLE public.koik_lauad OWNER TO t164416admin;
GRANT ALL PRIVILEGES ON TABLE public.koik_lauad TO t164416admin;
ALTER TABLE public.laudade_koondaruanne OWNER TO t164416admin;
GRANT ALL PRIVILEGES ON TABLE public.laudade_koondaruanne TO t164416admin;

GRANT ALL PRIVILEGES ON VIEW aktiivsed_ja_mitteaktiivsed_lauad TO t164416admin;
GRANT ALL PRIVILEGES ON VIEW koik_lauad TO t164416admin;
GRANT ALL PRIVILEGES ON VIEW laudade_koondaruanne TO t164416admin;
