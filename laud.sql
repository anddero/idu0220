DROP TABLE IF EXISTS Amet CASCADE
;

DROP TABLE IF EXISTS Tootaja_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Isiku_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Riik CASCADE
;

DROP TABLE IF EXISTS Isik CASCADE
;

DROP TABLE IF EXISTS Tootaja CASCADE
;

DROP TABLE IF EXISTS Laua_materjal CASCADE
;

DROP TABLE IF EXISTS Laua_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Laud CASCADE
;

DROP TABLE IF EXISTS Laua_kategooria_tyyp CASCADE
;

DROP TABLE IF EXISTS Laua_kategooria CASCADE
;

DROP TABLE IF EXISTS Laua_kategooria_omamine CASCADE
;

DROP TABLE IF EXISTS Kliendi_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Klient CASCADE
;

CREATE TABLE Amet
(
  amet_kood integer NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  kirjeldus varchar(255)	,
  CONSTRAINT PK_Amet PRIMARY KEY (amet_kood),
  CONSTRAINT AK_Amet_Nimetus UNIQUE (nimetus),
  CONSTRAINT amet_kirjeldus_check_ei_ole_tyhi_string CHECK (kirjeldus!~'^[[:space:]]*$'),
  CONSTRAINT amet_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$')
)
;

ALTER TABLE Amet OWNER TO t164416;

CREATE TABLE Tootaja_seisundi_liik
(
  tootaja_seisundi_liik_kood integer NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  CONSTRAINT PK_Tootaja_seisundi_liik PRIMARY KEY (tootaja_seisundi_liik_kood),
  CONSTRAINT AK_Tootaja_Seisundi_Liik_Nimetus UNIQUE (nimetus),
  CONSTRAINT tootaja_seisundi_liik_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$')
)
;

ALTER TABLE Tootaja_seisundi_liik OWNER TO t164416;

CREATE TABLE Isiku_seisundi_liik
(
  isiku_seisundi_liik_kood integer NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  CONSTRAINT PK_Isiku_seisundi_liik PRIMARY KEY (isiku_seisundi_liik_kood),
  CONSTRAINT AK_Isiku_Seisundi_Liik_Nimetus UNIQUE (nimetus),
  CONSTRAINT isiku_seisundi_liik_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$')
)
;

ALTER TABLE Isiku_seisundi_liik OWNER TO t164416;

CREATE TABLE Riik
(
  riik_kood char(3)	 NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  CONSTRAINT PK_Riik PRIMARY KEY (riik_kood),
  CONSTRAINT AK_Riik_Nimetus UNIQUE (nimetus),
  CONSTRAINT riik_riik_kood_check_on_kolm_suurtahte CHECK (riik_kood~'^[A-Z]{3}$'),
  CONSTRAINT riik_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$')
)
;

ALTER TABLE Riik OWNER TO t164416;

CREATE TABLE Isik
(
  isiku_id integer NOT NULL,
  isikukoodi_riik char(3)	 NOT NULL,
  isiku_seisundi_liik_kood integer NOT NULL DEFAULT 1,
  e_meil varchar(254)	 NOT NULL,
  isikukood varchar(20)	 NOT NULL,
  synni_kp date NOT NULL,
  parool varchar(100)	 NOT NULL,
  reg_kp date NOT NULL DEFAULT CURRENT_DATE,
  eesnimi varchar(700)	,
  perenimi varchar(700)	,
  elukoht varchar(20)	,
  CONSTRAINT PK_Isik PRIMARY KEY (isiku_id),
  CONSTRAINT AK_Isik_e_meil UNIQUE (e_meil),
  CONSTRAINT AK_Isikukood_riik UNIQUE (isikukood,isikukoodi_riik),
  CONSTRAINT isik_e_meil_check_oige_vorm CHECK (e_meil~'^[a-z0-9.]+@[a-z0-9.]+[a-z]+$'),
  CONSTRAINT isik_synni_kp_check_lubatud_vahemik CHECK (synni_kp >= '01.01.1900' AND synni_kp <= '12.31.2100'),
  CONSTRAINT isik_synni_kp_check_v2iksem_v6rdne_isiku_registreerimise_ajast CHECK (synni_kp <= reg_kp),
  CONSTRAINT isik_reg_kp_check_lubatud_vahemik CHECK (reg_kp >= '01.01.2010' AND reg_kp < '01.01.2101'),
  CONSTRAINT isik_eesnimi_check_eesnimi_voi_perenimi_registreeritud CHECK (perenimi IS NOT NULL OR eesnimi IS NOT NULL),
  CONSTRAINT isik_eesnimi_check_ei_ole_tyhi_string CHECK (eesnimi<>''),
  CONSTRAINT isik_perenimi_check_ei_ole_tyhi_string CHECK (perenimi<>''),
  CONSTRAINT isik_elukoht_check_ei_ole_tyhi_string CHECK (elukoht!~'^[[:space:]]*$'),
  CONSTRAINT isik_synni_kp_check_v2iksem_v6rdne_kui_hetke_kuupaev CHECK (synni_kp <= current_date),
  CONSTRAINT isik_reg_kp_check_v2iksem_v6rdne_kui_hetke_kuupaev CHECK (reg_kp <= CURRENT_DATE),
  CONSTRAINT isik_parool_check_ei_ole_tyhi_string CHECK (parool!~'^[[:space:]]*$'),
  CONSTRAINT isik_e_meil_check_tostutundetu CHECK (e_meil = LOWER(e_meil)),
  CONSTRAINT FK_Isik_Isiku_seisundi_liik FOREIGN KEY (isiku_seisundi_liik_kood) REFERENCES Isiku_seisundi_liik (isiku_seisundi_liik_kood) ON DELETE No Action ON UPDATE No Action,
  CONSTRAINT FK_Isikukoodi_riik FOREIGN KEY (isikukoodi_riik) REFERENCES Riik (riik_kood) ON DELETE No Action ON UPDATE Cascade
)
;

ALTER TABLE Isik OWNER TO t164416;

CREATE TABLE Tootaja
(
  isiku_id integer NOT NULL,
  amet_kood integer NOT NULL,
  tootaja_seisundi_liik_kood integer NOT NULL DEFAULT 1,
  mentor smallint,
  CONSTRAINT PK_Tootaja PRIMARY KEY (isiku_id),
  CONSTRAINT FK_Tootaja_Amet FOREIGN KEY (amet_kood) REFERENCES Amet (amet_kood) ON DELETE No Action ON UPDATE Cascade,
  CONSTRAINT FK_Tootaja_Tootaja_seisundi_liik FOREIGN KEY (tootaja_seisundi_liik_kood) REFERENCES Tootaja_seisundi_liik (tootaja_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
  CONSTRAINT FK_Tootaja_Isik FOREIGN KEY (isiku_id) REFERENCES Isik (isiku_id) ON DELETE Cascade ON UPDATE No Action,
  CONSTRAINT FK_Mentor FOREIGN KEY (mentor) REFERENCES Tootaja (isiku_id) ON DELETE Set Null ON UPDATE Cascade
)
;

ALTER TABLE Tootaja OWNER TO t164416;

CREATE TABLE Laua_materjal
(
  laua_materjal_kood integer NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  CONSTRAINT PK_Laua_materjal PRIMARY KEY (laua_materjal_kood),
  CONSTRAINT AK_Laua_Materjal_Nimetus UNIQUE (nimetus),
  CONSTRAINT laua_materjal_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$')
)
;

ALTER TABLE Laua_materjal OWNER TO t164416;

CREATE TABLE Laua_seisundi_liik
(
  laua_seisundi_liik_kood integer NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  CONSTRAINT PK_Laua_seisundi_liik PRIMARY KEY (laua_seisundi_liik_kood),
  CONSTRAINT AK_Laua_Seisundi_Liik_Nimetus UNIQUE (nimetus),
  CONSTRAINT laua_seisundi_liik_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$')
)
;

ALTER TABLE Laua_seisundi_liik OWNER TO t164416;

CREATE TABLE Laud
(
  laua_kood integer NOT NULL,
  tootaja_id smallint NOT NULL,
  laua_seisundi_liik_kood integer NOT NULL DEFAULT 1,
  laua_materjal_kood integer,
  reg_kp date NOT NULL DEFAULT CURRENT_DATE,
  kohtade_arv Integer NOT NULL,
  kommentaar varchar(255)	,
  CONSTRAINT PK_laua_kood PRIMARY KEY (laua_kood),
  CONSTRAINT laud_kohtade_arv_check_suurem_yhest CHECK (kohtade_arv > 1),
  CONSTRAINT laud_reg_kp_check_lubatud_vahemik CHECK (reg_kp >= '01.01.2010' AND reg_kp < '01.01.2101'),
  CONSTRAINT laud_kommentaar_check_ei_ole_tyhi_string CHECK (kommentaar!~'^[[:space:]]*$'),
  CONSTRAINT laud_reg_kp_check_v2iksem_v6rdne_kui_hetke_kuupaev CHECK (reg_kp <= CURRENT_DATE),
  CONSTRAINT FK_Laud_Laua_materjal FOREIGN KEY (laua_materjal_kood) REFERENCES Laua_materjal (laua_materjal_kood) ON DELETE No Action ON UPDATE Cascade,
  CONSTRAINT FK_Laud_Laua_seisundi_liik FOREIGN KEY (laua_seisundi_liik_kood) REFERENCES Laua_seisundi_liik (laua_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
  CONSTRAINT FK_Laud_Tootaja_Id_registreerib FOREIGN KEY (tootaja_id) REFERENCES Tootaja (isiku_id) ON DELETE No Action ON UPDATE Cascade
)
;

ALTER TABLE Laud OWNER TO t164416;

CREATE TABLE Laua_kategooria_tyyp
(
  laua_kategooria_tyyp_kood integer NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  CONSTRAINT PK_Laua_kategooria_tyyp PRIMARY KEY (laua_kategooria_tyyp_kood),
  CONSTRAINT AK_Laua_Kategooria_Tyyp_Nimetus UNIQUE (nimetus),
  CONSTRAINT laua_kategooria_tyyp_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$')
)
;

ALTER TABLE Laua_kategooria_tyyp OWNER TO t164416;

CREATE TABLE Laua_kategooria
(
  laua_kategooria_kood integer NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  laua_kategooria_tyyp_kood integer NOT NULL,
  CONSTRAINT PK_Laua_kategooria PRIMARY KEY (laua_kategooria_kood),
  CONSTRAINT AK_Nimetus_Laua_kategooria_tyyp UNIQUE (laua_kategooria_tyyp_kood,nimetus),
  CONSTRAINT laua_kategooria_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$'),
  CONSTRAINT FK_Laua_kategooria_Laua_kategooria_tyyp FOREIGN KEY (laua_kategooria_tyyp_kood) REFERENCES Laua_kategooria_tyyp (laua_kategooria_tyyp_kood) ON DELETE No Action ON UPDATE Cascade
)
;

ALTER TABLE Laua_kategooria OWNER TO t164416;

CREATE TABLE Laua_kategooria_omamine
(
  laua_kategooria_omamine_id integer NOT NULL,
  laua_kood integer NOT NULL,
  laua_kategooria_kood integer NOT NULL,
  CONSTRAINT PK_laua_kategooria_omamine PRIMARY KEY (laua_kategooria_omamine_id),
  CONSTRAINT AK_laua_kategooria_omamine_Laua_katogooria_Laud UNIQUE (laua_kood,laua_kategooria_kood),
  CONSTRAINT FK_laua_kategooria_omamine_Laud FOREIGN KEY (laua_kood) REFERENCES Laud (laua_kood) ON DELETE Cascade ON UPDATE Cascade,
  CONSTRAINT FK_laua_kategooria_omamine_Laua_kategooria FOREIGN KEY (laua_kategooria_kood) REFERENCES Laua_kategooria (laua_kategooria_kood) ON DELETE No Action ON UPDATE No Action
)
;

ALTER TABLE Laua_kategooria_omamine OWNER TO t164416;

CREATE TABLE Kliendi_seisundi_liik
(
  kliendi_seisundi_liik_kood integer NOT NULL,
  nimetus varchar(50)	 NOT NULL,
  CONSTRAINT PK_Kliendi_seisundi_liik PRIMARY KEY (kliendi_seisundi_liik_kood),
  CONSTRAINT AK_Kliendi_Seisundi_Liik_Nimetus UNIQUE (nimetus),
  CONSTRAINT kliendi_seisundi_liik_nimetus_check_ei_ole_tyhi_string CHECK (nimetus!~'^[[:space:]]*$')
)
;

ALTER TABLE Kliendi_seisundi_liik OWNER TO t164416;

CREATE TABLE Klient
(
  isiku_id integer NOT NULL,
  on_nous_tylitamisega boolean NOT NULL DEFAULT false,
  kliendi_seisundi_liik_kood integer NOT NULL DEFAULT 1,
  CONSTRAINT PK_Klient PRIMARY KEY (isiku_id),
  CONSTRAINT FK_Klient_Kliendi_seisundi_liik FOREIGN KEY (kliendi_seisundi_liik_kood) REFERENCES Kliendi_seisundi_liik (kliendi_seisundi_liik_kood) ON DELETE No Action ON UPDATE No Action,
  CONSTRAINT FK_Klient_Isik FOREIGN KEY (isiku_id) REFERENCES Isik (isiku_id) ON DELETE Cascade ON UPDATE No Action
)
;

ALTER TABLE Klient OWNER TO t164416;

DROP INDEX IF EXISTS IXFK_Isik_Isiku_seisundi_liik;
DROP INDEX IF EXISTS IXFK_Isikukoodi_riik;
DROP INDEX IF EXISTS IXFK_Tootaja_Amet;
DROP INDEX IF EXISTS IXFK_Tootaja_Mentor_Isik;
DROP INDEX IF EXISTS IXFK_Tootaja_Tootaja_Isik;
DROP INDEX IF EXISTS IXFK_Tootaja_Tootaja_seisundi_liik;
DROP INDEX IF EXISTS IXFK_Laud_Laua_materjal;
DROP INDEX IF EXISTS IXFK_Laud_Laua_seisundi_liik;
DROP INDEX IF EXISTS IXFK_Laua_kategooria_Laua_kategooria_tyyp;
DROP INDEX IF EXISTS IXFK_laua_kategooria_omamine_Laua_kategooria;
DROP INDEX IF EXISTS IXFK_laua_kategooria_omamine_Laud;
DROP INDEX IF EXISTS IXFK_Klient_Kliendi_seisundi_liik;
DROP INDEX IF EXISTS IXFK_Klient_Isik;

CREATE INDEX IXFK_Isik_Isiku_seisundi_liik ON Isik(isiku_seisundi_liik_kood ASC);
CREATE INDEX IXFK_Isikukoodi_riik ON Isik(isikukoodi_riik ASC);
CREATE INDEX IXFK_Tootaja_Amet ON Tootaja (amet_kood ASC);
CREATE INDEX IXFK_Tootaja_Mentor_Isik ON Tootaja (mentor ASC);
CREATE INDEX IXFK_Tootaja_Tootaja_Isik ON Tootaja (isiku_id ASC);
CREATE INDEX IXFK_Tootaja_Tootaja_seisundi_liik ON Tootaja (tootaja_seisundi_liik_kood ASC);
CREATE INDEX IXFK_Laud_Laua_materjal ON Laud (laua_materjal_kood ASC);
CREATE INDEX IXFK_Laud_Laua_seisundi_liik ON Laud (laua_seisundi_liik_kood ASC);
CREATE INDEX IXFK_Laua_kategooria_Laua_kategooria_tyyp ON Laua_kategooria (laua_kategooria_tyyp_kood ASC);
CREATE INDEX IXFK_laua_kategooria_omamine_Laua_kategooria ON Laua_kategooria_omamine (laua_kategooria_kood ASC);
CREATE INDEX IXFK_laua_kategooria_omamine_Laud ON Laua_kategooria_omamine (laua_kood ASC);
CREATE INDEX IXFK_Klient_Kliendi_seisundi_liik ON Klient (kliendi_seisundi_liik_kood ASC);
CREATE INDEX IXFK_Klient_Isik ON Klient (isiku_id ASC);
