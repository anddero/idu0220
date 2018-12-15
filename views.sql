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

ALTER VIEW aktiivsed_ja_mitteaktiivsed_lauad OWNER TO t164416;

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

ALTER VIEW koik_lauad OWNER TO t164416;

DROP VIEW IF EXISTS laudade_detailandmed;

CREATE VIEW laudade_detailandmed AS
SELECT Laud.laua_kood,
       Laua_materjal.nimetus,
       Laud.kohtade_arv,
       Laud.kommentaar,
       Laud.reg_kp,
       Isik.eesnimi,
       Isik.perenimi,
       Isik.e_meil,
       Laua_seisundi_liik.nimetus AS hetkeseisund
FROM (Isik INNER JOIN (Tootaja INNER JOIN (Laud INNER JOIN Laua_materjal ON Laud.laua_materjal_kood =
                                                                            Laua_materjal.laua_materjal_kood) ON
    Tootaja.isiku_id = Laud.tootaja_id) ON Isik.isiku_id = Tootaja.isiku_id)
       INNER JOIN Laua_seisundi_liik ON Laud.laua_seisundi_liik_kood = Laua_seisundi_liik.laua_seisundi_liik_kood;

ALTER VIEW laudade_detailandmed OWNER TO t164416;

select *
from laudade_detailandmed;

DROP VIEW IF EXISTS laudade_koondaruanne;
CREATE VIEW laudade_koondaruanne AS
SELECT Laua_seisundi_liik.laua_seisundi_liik_kood,
       UPPER(Laua_seisundi_liik.nimetus) AS seisundi_nimetus,
       Count(Laud.laua_kood)             AS laudade_arv
FROM Laua_seisundi_liik
       LEFT JOIN Laud ON Laua_seisundi_liik.laua_seisundi_liik_kood = Laud.laua_seisundi_liik_kood
GROUP BY Laua_seisundi_liik.laua_seisundi_liik_kood, UPPER(Laua_seisundi_liik.nimetus)
ORDER BY Count(Laud.laua_kood) DESC, UPPER(Laua_seisundi_liik.nimetus);

ALTER VIEW laudade_koondaruanne OWNER TO t164416;
