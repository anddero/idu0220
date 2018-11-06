/**************************************************/
Järgnevaid lauseid on katsetatud PostgreSQL (10)
/**************************************************/

DROP FUNCTION IF EXISTS f_registreeri_tulemus(
p_projekti_punktid Punktid.projekti_punktid%TYPE,
p_projekti_esituste_arv Punktid.projekti_esituste_arv%TYPE,
p_aktiivsuspunktid Punktid.aktiivsuspunktid%TYPE,
p_teemade_1_2_vahepunktid Punktid.teemade_1_2_vahepunktid%TYPE,
p_teemade_1_2_vahetestide_arv Punktid.teemade_1_2_vahetestide_arv%TYPE,
p_teemade_3_4_vahepunktid Punktid.teemade_3_4_vahepunktid%TYPE,
p_teemade_3_4_vahetestide_arv Punktid.teemade_3_4_vahetestide_arv%TYPE,
p_teemade_5_7_vahepunktid Punktid.teemade_5_7_vahepunktid%TYPE,
p_teemade_5_7_vahetestide_arv Punktid.teemade_5_7_vahetestide_arv%TYPE,
p_lopptesti_punktid Punktid.lopptesti_punktid%TYPE,
p_lopptestide_arv Punktid.lopptestide_arv%TYPE,
p_on_projekt_rohkem_kui_kaks_nadalat_hilinenud Punktid.on_projekt_rohkem_kui_kaks_nadalat_hilinenud%TYPE
);
DROP TABLE IF EXISTS Punktid CASCADE;
DROP DOMAIN IF EXISTS d_vahetesti_punktid CASCADE;
DROP DOMAIN IF EXISTS d_eksami_vahetestide_arv CASCADE;

SET client_encoding=LATIN9;
/*psql’i läbi SSH Secure Shell Clienti kasutamise korral. Muidu
annavad õ, ä, ö, ü, Õ, Ä, Ö, Ü tähed veateateid.*/

CREATE DOMAIN d_vahetesti_punktid SMALLINT NOT NULL DEFAULT 0
CONSTRAINT chk_vahetesti_punktid CHECK (VALUE BETWEEN 0 AND 6);

COMMENT ON DOMAIN d_vahetesti_punktid
IS 'Eksamile saab punkte juurde vahetestidega. 
Igas testis on kuus küsimust. Iga õige vastus annab ühe punkti';

CREATE DOMAIN d_eksami_vahetestide_arv SMALLINT NOT NULL DEFAULT 0
CONSTRAINT chk_eksami_vahetestide_arv CHECK (VALUE BETWEEN 0 AND 1);

COMMENT ON DOMAIN d_eksami_vahetestide_arv
IS 'Iga eksami vahetesti saab teha kuni üks kord. 
Tagantjärgi teha ei saa. Kokkuleppel õppejõuga saab teha ette ära.';

/*Binaarset loogilist operatsiooni implikatsioon kasutava avaldise P=>Q 
võib teisendusreeglite alusel kirjutada ümber samaväärseks avaldiseks: (NOT(P) OR Q).*/

CREATE TABLE Punktid (
punktid_id SMALLINT NOT NULL DEFAULT 0,
projekti_punktid SMALLINT NOT NULL DEFAULT 0,
projekti_esituste_arv SMALLINT NOT NULL DEFAULT 0,
aktiivsuspunktid SMALLINT NOT NULL DEFAULT 0,
teemade_1_2_vahepunktid d_vahetesti_punktid,
teemade_1_2_vahetestide_arv d_eksami_vahetestide_arv,
teemade_3_4_vahepunktid d_vahetesti_punktid,
teemade_3_4_vahetestide_arv d_eksami_vahetestide_arv,
teemade_5_7_vahepunktid d_vahetesti_punktid,
teemade_5_7_vahetestide_arv d_eksami_vahetestide_arv,
lopptesti_punktid SMALLINT NOT NULL DEFAULT 0,
lopptestide_arv SMALLINT NOT NULL DEFAULT 0,
on_projekt_rohkem_kui_kaks_nadalat_hilinenud BOOLEAN NOT NULL DEFAULT FALSE,
CONSTRAINT pk_punktid PRIMARY KEY (punktid_id),
CONSTRAINT chk_maksimaalselt_yks_rida CHECK (punktid_id=0),
CONSTRAINT chk_projekti_punktid CHECK(projekti_punktid BETWEEN -320 AND 84),
CONSTRAINT chk_projekti_esituste_arv CHECK(projekti_esituste_arv BETWEEN 0 AND 2),
CONSTRAINT chk_aktiivsuspunktid CHECK (aktiivsuspunktid>=0),
CONSTRAINT chk_lopptesti_punktid CHECK (lopptesti_punktid BETWEEN 0 AND 30),
CONSTRAINT chk_lopptestide_arv CHECK (lopptestide_arv BETWEEN 0 AND 3),
CONSTRAINT chk_on_projekt CHECK (NOT(projekti_punktid<>0) OR (projekti_esituste_arv>=1)),
CONSTRAINT chk_on_eksamieeldus CHECK (NOT(lopptestide_arv>0) OR (projekti_punktid>=31)),
CONSTRAINT chk_on_teemade_1_2_vahepunktid CHECK (NOT(teemade_1_2_vahepunktid>0) OR (teemade_1_2_vahetestide_arv=1)),
CONSTRAINT chk_on_teemade_3_4_vahepunktid CHECK (NOT(teemade_3_4_vahepunktid>0) OR (teemade_3_4_vahetestide_arv=1)),
CONSTRAINT chk_on_teemade_5_7_vahepunktid CHECK (NOT(teemade_5_7_vahepunktid>0) OR (teemade_5_7_vahetestide_arv=1)),
CONSTRAINT chk_on_lopptesti_punktid CHECK (NOT(lopptesti_punktid>0) OR (lopptestide_arv>0)),
CONSTRAINT chk_projekti_hilinenud_esitamine CHECK (NOT(on_projekt_rohkem_kui_kaks_nadalat_hilinenud=TRUE) OR (projekti_esituste_arv>0)));

COMMENT ON TABLE Punktid 
IS 'Lõpphinde kujunemist mõjutavad komponendid - punktid ja nende saamiseks tehtavate katsete arv';
COMMENT ON CONSTRAINT chk_maksimaalselt_yks_rida ON Punktid 
IS 'Tagab, et tabelis saab olla maksimaalselt üks rida';
COMMENT ON CONSTRAINT chk_on_projekt ON Punktid 
IS 'Kui on täidetud tingimus "projekti_punktid<>0", siis peab ka olema täidetud tingimus "projekti_esituste_arv>=1"';
COMMENT ON CONSTRAINT chk_on_eksamieeldus ON Punktid 
IS 'Kui on täidetud tingimus "lopptestide_arv>0", siis peab ka olema täidetud tingimus "projekti_punktid>=31"';
COMMENT ON CONSTRAINT chk_on_teemade_1_2_vahepunktid ON Punktid 
IS 'Kui on täidetud tingimus "teemade_1_2_vahepunktid>0", siis peab ka olema täidetud tingimus "teemade_1_2_vahetestide_arv=1"';
COMMENT ON CONSTRAINT chk_on_teemade_3_4_vahepunktid ON Punktid 
IS 'Kui on täidetud tingimus "teemade_3_4_vahepunktid>0", siis peab ka olema täidetud tingimus "teemade_3_4_vahetestide_arv=1"';
COMMENT ON CONSTRAINT chk_on_teemade_5_7_vahepunktid ON Punktid 
IS 'Kui on täidetud tingimus "teemade_5_7_vahepunktid>0", siis peab ka olema täidetud tingimus "teemade_5_7_vahetestide_arv=1"';
COMMENT ON CONSTRAINT chk_on_lopptesti_punktid ON Punktid 
IS 'Kui on täidetud tingimus "lopptesti_punktid>0", siis peab ka olema täidetud tingimus "lopptestide_arv>0"';
COMMENT ON CONSTRAINT chk_projekti_hilinenud_esitamine ON Punktid 
IS 'Kui on täidetud tingimus "on_projekt_rohkem_kui_kaks_nadalat_hilinenud=TRUE", siis peab ka olema täidetud tingimus "projekti_esituste_arv>0"';

CREATE OR REPLACE VIEW Lavend AS 
SELECT CASE 
WHEN (projekti_esituste_arv=0) 
THEN 'Projekt esitamata'
WHEN (projekti_punktid<31 AND projekti_esituste_arv=1) 
THEN 'Projekti saab korra parandada'
WHEN (projekti_punktid<31 AND projekti_esituste_arv=2) 
THEN 'Tuleb teha uus projekt uuel teemal'
ELSE 'Projekti lävend ületatud' END AS projekt,
CASE 
WHEN ((teemade_1_2_vahepunktid+teemade_3_4_vahepunktid+
teemade_5_7_vahepunktid+lopptesti_punktid)<20 )
THEN 'Eksami lävend ületamata'
ELSE 'Eksami lävend ületatud' END AS eksam
FROM Punktid;

COMMENT ON VIEW Lavend IS 'Kas positiivse lõpphinde saamiseks 
vajalik lävend on ületatud?';

CREATE OR REPLACE VIEW Hinne AS
WITH punktisumma AS (
SELECT 
projekti_punktid,
projekti_esituste_arv,
teemade_1_2_vahepunktid +
teemade_3_4_vahepunktid +
teemade_5_7_vahepunktid +
lopptesti_punktid AS eksami_punktid,
lopptestide_arv,
projekti_punktid +
CASE WHEN (projekti_esituste_arv=2 OR on_projekt_rohkem_kui_kaks_nadalat_hilinenud=TRUE) THEN 0
ELSE aktiivsuspunktid END +
teemade_1_2_vahepunktid +
teemade_3_4_vahepunktid +
teemade_5_7_vahepunktid +
lopptesti_punktid AS kokku_punktid
FROM Punktid)
SELECT
kokku_punktid,
CASE
WHEN ((projekti_esituste_arv=0) OR (projekti_punktid<31 AND projekti_esituste_arv>0) 
OR (lopptestide_arv=0)) THEN 'Mitteilmunud'
WHEN (eksami_punktid<20 AND lopptestide_arv>0) THEN '0'
WHEN kokku_punktid BETWEEN 51 AND 60 THEN '1'
WHEN kokku_punktid BETWEEN 61 AND 70 THEN '2'
WHEN kokku_punktid BETWEEN 71 AND 80 THEN '3'
WHEN kokku_punktid BETWEEN 81 AND 90 THEN '4'
ELSE '5' END AS lopphinne
FROM punktisumma;

COMMENT ON VIEW Hinne IS 'Aine lõpphinne';


CREATE OR REPLACE FUNCTION f_registreeri_tulemus(
p_projekti_punktid Punktid.projekti_punktid%TYPE,
p_projekti_esituste_arv Punktid.projekti_esituste_arv%TYPE,
p_aktiivsuspunktid Punktid.aktiivsuspunktid%TYPE,
p_teemade_1_2_vahepunktid Punktid.teemade_1_2_vahepunktid%TYPE,
p_teemade_1_2_vahetestide_arv Punktid.teemade_1_2_vahetestide_arv%TYPE,
p_teemade_3_4_vahepunktid Punktid.teemade_3_4_vahepunktid%TYPE,
p_teemade_3_4_vahetestide_arv Punktid.teemade_3_4_vahetestide_arv%TYPE,
p_teemade_5_7_vahepunktid Punktid.teemade_5_7_vahepunktid%TYPE,
p_teemade_5_7_vahetestide_arv Punktid.teemade_5_7_vahetestide_arv%TYPE,
p_lopptesti_punktid Punktid.lopptesti_punktid%TYPE,
p_lopptestide_arv Punktid.lopptestide_arv%TYPE,
p_on_projekt_rohkem_kui_kaks_nadalat_hilinenud Punktid.on_projekt_rohkem_kui_kaks_nadalat_hilinenud%TYPE
) RETURNS VOID AS 
$$ 
/*UPSERT operatsioon, mis kombineerib INSERT ja UPDATE lisandus PostgreSQL 9.5*/
INSERT INTO Punktid AS p (
projekti_punktid,
projekti_esituste_arv,
aktiivsuspunktid,
teemade_1_2_vahepunktid,
teemade_1_2_vahetestide_arv,
teemade_3_4_vahepunktid,
teemade_3_4_vahetestide_arv,
teemade_5_7_vahepunktid,
teemade_5_7_vahetestide_arv,
lopptesti_punktid,
lopptestide_arv,
on_projekt_rohkem_kui_kaks_nadalat_hilinenud) VALUES 
(p_projekti_punktid,
p_projekti_esituste_arv,
p_aktiivsuspunktid,
p_teemade_1_2_vahepunktid,
p_teemade_1_2_vahetestide_arv,
p_teemade_3_4_vahepunktid,
p_teemade_3_4_vahetestide_arv,
p_teemade_5_7_vahepunktid,
p_teemade_5_7_vahetestide_arv,
p_lopptesti_punktid,
p_lopptestide_arv,
p_on_projekt_rohkem_kui_kaks_nadalat_hilinenud)
ON CONFLICT (punktid_id) DO UPDATE
SET 
projekti_punktid=EXCLUDED.projekti_punktid,
projekti_esituste_arv=EXCLUDED.projekti_esituste_arv,
aktiivsuspunktid=EXCLUDED.aktiivsuspunktid,
teemade_1_2_vahepunktid=EXCLUDED.teemade_1_2_vahepunktid,
teemade_1_2_vahetestide_arv=EXCLUDED.teemade_1_2_vahetestide_arv,
teemade_3_4_vahepunktid=EXCLUDED.teemade_3_4_vahepunktid,
teemade_3_4_vahetestide_arv=EXCLUDED.teemade_3_4_vahetestide_arv,
teemade_5_7_vahepunktid=EXCLUDED.teemade_5_7_vahepunktid,
teemade_5_7_vahetestide_arv=EXCLUDED.teemade_5_7_vahetestide_arv,
lopptesti_punktid=EXCLUDED.lopptesti_punktid,
lopptestide_arv=EXCLUDED.lopptestide_arv,
on_projekt_rohkem_kui_kaks_nadalat_hilinenud=EXCLUDED.on_projekt_rohkem_kui_kaks_nadalat_hilinenud
WHERE P.punktid_id = 0; 
$$ LANGUAGE sql SECURITY DEFINER 
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_registreeri_tulemus(
p_projekti_punktid Punktid.projekti_punktid%TYPE,
p_projekti_esituste_arv Punktid.projekti_esituste_arv%TYPE,
p_aktiivsuspunktid Punktid.aktiivsuspunktid%TYPE,
p_teemade_1_2_vahepunktid Punktid.teemade_1_2_vahepunktid%TYPE,
p_teemade_1_2_vahetestide_arv Punktid.teemade_1_2_vahetestide_arv%TYPE,
p_teemade_3_4_vahepunktid Punktid.teemade_3_4_vahepunktid%TYPE,
p_teemade_3_4_vahetestide_arv Punktid.teemade_3_4_vahetestide_arv%TYPE,
p_teemade_5_7_vahepunktid Punktid.teemade_5_7_vahepunktid%TYPE,
p_teemade_5_7_vahetestide_arv Punktid.teemade_5_7_vahetestide_arv%TYPE,
p_lopptesti_punktid Punktid.lopptesti_punktid%TYPE,
p_lopptestide_arv Punktid.lopptestide_arv%TYPE,
p_on_projekt_rohkem_kui_kaks_nadalat_hilinenud Punktid.on_projekt_rohkem_kui_kaks_nadalat_hilinenud%TYPE
) IS 'Tabelis saab tänu kitsendusele olla maksimaalselt üks rida. Kui tabelis pole ühtegi rida, siis
lisatakse tabelisse rida, vastasel juhul muudetakse olemasolevat rida.';

/*Kui soovite katsetada ilma andmebaasiobjekte ise loomata, siis käivitage
seda funktsiooni ning järgnevaid päringuid apex.ttu.ee serveris andmebaasis: hinne.*/
SELECT f_registreeri_tulemus (
p_projekti_punktid:=38::SMALLINT,
p_projekti_esituste_arv:=1::SMALLINT,
p_aktiivsuspunktid:=10::SMALLINT,
p_teemade_1_2_vahepunktid:=0::SMALLINT,
p_teemade_1_2_vahetestide_arv:=1::SMALLINT,
p_teemade_3_4_vahepunktid:=0::SMALLINT,
p_teemade_3_4_vahetestide_arv:=1::SMALLINT,
p_teemade_5_7_vahepunktid:=2::SMALLINT,
p_teemade_5_7_vahetestide_arv:=1::SMALLINT,
p_lopptesti_punktid:=18::SMALLINT,
p_lopptestide_arv:=1::SMALLINT,
p_on_projekt_rohkem_kui_kaks_nadalat_hilinenud:=FALSE
);

SELECT projekt, eksam FROM Lavend;
SELECT kokku_punktid, lopphinne FROM Hinne;