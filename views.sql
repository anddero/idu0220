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

select *
from aktiivsed_ja_mitteaktiivsed_lauad;
comment on view aktiivsed_ja_mitteaktiivsed_lauad is 'Andmed laudadest, kus seisundi liik on kas aktiivne või mitteaktiivne';

DROP VIEW IF EXISTS koik_lauad;

CREATE VIEW koik_lauad AS
  SELECT Laud.laua_kood,
         Laua_seisundi_liik.nimetus AS hetkeseisund,
         Laua_materjal.nimetus laua_materjal_nimetus,
         Laud.kohtade_arv,
         Laud.kommentaar,
         Laud.reg_kp,
         Isik.eesnimi registeerinud_tootaja_eesnimi,
         Isik.perenimi registreerinud_tootaja_perenimi,
         Isik.e_meil
  FROM Laua_materjal,
       Isik,
       Laua_seisundi_liik
         INNER JOIN Laud ON Laua_seisundi_liik.laua_seisundi_liik_kood = Laud.laua_seisundi_liik_kood
  WHERE (((Laud.laua_materjal_kood) = Laua_materjal.laua_materjal_kood) And ((Laud.tootaja_kood) = Isik.isik_kood));

ALTER VIEW koik_lauad OWNER TO t164416;

select *
from koik_lauad;
comment on view koik_lauad is 'Kõik lauad kus on iga laua kohta kohtade arv, kommentaar, registreerimise kuupäev, laua registreerinud töötaja eesnimi, perenimi, email ning laua hetkeseisund';


DROP VIEW IF EXISTS laudade_detailandmed;

CREATE VIEW laudade_detailandmed AS
  SELECT Laud.laud_kood,
         Laua_materjal.nimetus laua_materjal_nimetus,
         Laud.kohtade_arv,
         Laud.kommentaar,
         Laud.reg_kp,
         Isik.eesnimi tootaja_eesnimie,
         Isik.perenimi tootaja_perenimi,
         Isik.e_meil,
         Laua_seisundi_liik.nimetus AS hetkeseisund
  FROM (Isik INNER JOIN (Tootaja INNER JOIN (Laud INNER JOIN Laua_materjal ON Laud.laua_materjal_kood =
                                                                              Laua_materjal.laua_materjal_kood) ON
    Tootaja.isik_kood = Laud.tootaja_kood) ON Isik.isik_kood = Tootaja.isik_kood)
         INNER JOIN Laua_seisundi_liik ON Laud.laua_seisundi_liik_kood = Laua_seisundi_liik.laua_seisundi_liik_kood;

ALTER VIEW laudade_detailandmed OWNER TO t164416;

select *
from laudade_detailandmed;
comment on view laudade_detailandmed is 'Laudade detailandmed kus on iga laua kohta kohtade arv, kommentaar, registreerimise kuupäev, laua registreerinud töötaja eesnimi, perenimi, email ning laua hetkeseisund';

DROP VIEW IF EXISTS laudade_kategooria_omamine;
CREATE VIEW laudade_kategooria_omamine AS
  SELECT Laua_kategooria_omamine.laud_kood,
         Laua_kategooria.nimetus || ' (' || Laua_kategooria_tyyp.nimetus || ')' AS kategooria
  FROM Laua_kategooria_tyyp
         INNER JOIN (Laua_kategooria INNER JOIN Laua_kategooria_omamine ON Laua_kategooria.laua_kategooria_kood =
                                                                           Laua_kategooria_omamine.laua_kategooria_kood)
           ON Laua_kategooria_tyyp.laua_kategooria_tyyp_kood = Laua_kategooria.laua_kategooria_tyyp_kood;

ALTER VIEW laudade_kategooria_omamine OWNER TO t164416;
comment on view laudade_kategooria_omamine is 'Laudade kategooriate omamise aruanne, kus on näha mis laua kategooriat mis laud omab.';

select *
from laudade_kategooria_omamine;


DROP VIEW IF EXISTS laudade_koondaruanne;
CREATE VIEW laudade_koondaruanne AS
  SELECT Laua_seisundi_liik.laua_seisundi_liik_kood,
         UPPER(Laua_seisundi_liik.nimetus) AS seisundi_nimetus,
         Count(Laud.laua_kood)             AS laudade_arv
  FROM Laua_seisundi_liik
         LEFT JOIN Laud ON Laua_seisundi_liik.laua_seisundi_liik_kood = Laud.laua_seisundi_liik_kood
  GROUP BY Laua_seisundi_liik.laua_seisundi_liik_kood, UPPER(Laua_seisundi_liik.nimetus)
  ORDER BY Count(Laud.laua_kood) DESC, UPPER(Laua_seisundi_liik.nimetus);

select *
from laudade_koondaruanne;

comment on view laudade_koondaruanne is 'Laudade koond aruanne kus näed laudade arvu laua seisundi liikide järgi';