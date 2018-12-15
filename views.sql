DROP VIEW IF EXISTS aktiivsed_ja_mitteaktiivsed_lauad;

CREATE VIEW aktiivsed_ja_mitteaktiivsed_lauad AS
SELECT laud.laua_kood,
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

COMMENT ON VIEW aktiivsed_ja_mitteaktiivsed_lauad IS 'See vaade näitab kõiki aktiivseid ja mitteaktiivseid laudu.';

DROP VIEW IF EXISTS koik_lauad;

CREATE VIEW koik_lauad AS
SELECT Laud.laua_kood,
       Laua_seisundi_liik.nimetus AS hetkeseisund,
       Laua_materjal.nimetus,
       Laud.kohtade_arv,
       Laud.kommentaar,
       Laud.reg_kp,
       Isik.eesnimi,
       Isik.perenimi,
       Isik.e_meil
FROM Laua_materjal,
     Isik,
     Laua_seisundi_liik
       INNER JOIN Laud ON Laua_seisundi_liik.laua_seisundi_liik_kood = Laud.laua_seisundi_liik_kood
WHERE (((Laud.laua_materjal_kood) = Laua_materjal.laua_materjal_kood) And ((Laud.tootaja_id) = Isik.isiku_id));

COMMENT ON VIEW koik_lauad IS 'See vaade näitab infot kõigi laudade kohta.';

DROP VIEW IF EXISTS laudade_koondaruanne;

CREATE VIEW laudade_koondaruanne AS
SELECT Laua_seisundi_liik.laua_seisundi_liik_kood,
       UPPER(Laua_seisundi_liik.nimetus) AS seisundi_nimetus,
       Count(Laud.laua_kood)             AS laudade_arv
FROM Laua_seisundi_liik
       LEFT JOIN Laud ON Laua_seisundi_liik.laua_seisundi_liik_kood = Laud.laua_seisundi_liik_kood
GROUP BY Laua_seisundi_liik.laua_seisundi_liik_kood, UPPER(Laua_seisundi_liik.nimetus)
ORDER BY Count(Laud.laua_kood) DESC, UPPER(Laua_seisundi_liik.nimetus);

COMMENT ON VIEW laudade_koondaruanne IS 'See vaade näitab koondaruannet laua seisundi põhiselt.';
