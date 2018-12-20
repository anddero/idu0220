--CREATE ROLE t164416_juhataja WITH LOGIN PASSWORD '164416';

DROP VIEW IF EXISTS aktiivsed_ja_mitteaktiivsed_lauad;

CREATE VIEW public.aktiivsed_ja_mitteaktiivsed_lauad WITH (security_barrier) AS
SELECT laud.laud_kood,
       laua_seisundi_liik.nimetus as laua_seisundi_liik_nimetus,
       laua_materjal.nimetus      as materjal_nimetus,
       laud.kohtade_arv,
       laud.kommentaar
FROM Laud,
     Laua_seisundi_liik,
     Laua_materjal
WHERE Laud.laua_seisundi_liik_kood = Laua_seisundi_liik.laua_seisundi_liik_kood
  And Laud.laua_materjal_kood = Laua_materjal.laua_materjal_kood
  And Laua_seisundi_liik.laua_seisundi_liik_kood In (2, 3);

COMMENT ON VIEW aktiivsed_ja_mitteaktiivsed_lauad IS 'See vaade näitab kõiki aktiivseid ja mitteaktiivseid laudu, mida on võimalik hetkel kasutada.';

ALTER TABLE public.aktiivsed_ja_mitteaktiivsed_lauad OWNER TO t164416;
GRANT ALL ON TABLE public.aktiivsed_ja_mitteaktiivsed_lauad TO t164416;
GRANT SELECT ON TABLE public.aktiivsed_ja_mitteaktiivsed_lauad TO t164416_juhataja;


DROP VIEW IF EXISTS koik_lauad;

CREATE VIEW public.koik_lauad WITH (security_barrier) AS
SELECT Laud.laud_kood,
       Laua_seisundi_liik.nimetus AS hetkeseisund,
       Laua_materjal.nimetus AS laua_materjali_nimetus,
       Laud.kohtade_arv,
       Laud.kommentaar,
       Laud.reg_aeg,
	   string_agg(Isik.eesnimi, ' ', Isik.perenimi) AS tootaja_nimi,
       Isik.e_meil
FROM Laua_materjal,
     Isik,
     Laua_seisundi_liik
       INNER JOIN Laud ON Laua_seisundi_liik.laua_seisundi_liik_kood = Laud.laua_seisundi_liik_kood
WHERE (((Laud.laua_materjal_kood) = Laua_materjal.laua_materjal_kood) And ((Laud.registreerija_id) = Isik.isik_id));

COMMENT ON VIEW koik_lauad IS 'See vaade näitab kõigi laudade nimekirja, kus on välja toodud laua kood, hetkeseisund, laua materjali nimetus, kohtade arv, kommentaar, registreerimise kuupäev, töötaja nimi ja tema e-meil.';

ALTER TABLE public.koik_lauad OWNER TO t164416;
GRANT ALL ON TABLE public.koik_lauad TO t164416;
GRANT SELECT ON TABLE public.koik_lauad TO t164416_juhataja;


DROP VIEW IF EXISTS laudade_koondaruanne;

CREATE VIEW public.laudade_koondaruanne WITH (security_barrier) AS
SELECT Laua_seisundi_liik.laua_seisundi_liik_kood,
       UPPER(Laua_seisundi_liik.nimetus) AS seisundi_nimetus,
       Count(Laud.laud_kood)             AS laudade_arv
FROM Laua_seisundi_liik
       LEFT JOIN Laud ON Laua_seisundi_liik.laua_seisundi_liik_kood = Laud.laua_seisundi_liik_kood
GROUP BY Laua_seisundi_liik.laua_seisundi_liik_kood, UPPER(Laua_seisundi_liik.nimetus)
ORDER BY Count(Laud.laud_kood) DESC, UPPER(Laua_seisundi_liik.nimetus);

COMMENT ON VIEW laudade_koondaruanne IS 'See vaade näitab koondaruannet laua seisundi põhiselt.';

ALTER TABLE public.laudade_koondaruanne OWNER TO t164416;
GRANT ALL ON TABLE public.laudade_koondaruanne TO t164416;
GRANT SELECT ON TABLE public.laudade_koondaruanne TO t164416_juhataja;
