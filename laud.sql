START TRANSACTION;

DROP SEQUENCE IF EXISTS tootaja_isik_id_seq
;

DROP SEQUENCE IF EXISTS laua_kategooria_omamine_laua_kategooria_omamine_id_seq
;

DROP SEQUENCE IF EXISTS laud_laud_id_seq
;

DROP SEQUENCE IF EXISTS laud_laua_seisundi_liik_kood_seq
;

DROP SEQUENCE IF EXISTS laud_laua_materjal_kood_seq
;

DROP SEQUENCE IF EXISTS klient_isik_id_seq
;

DROP SEQUENCE IF EXISTS amet_amet_kood_seq
;

DROP SEQUENCE IF EXISTS isiku_seisundi_liik_isiku_seisundi_liik_kood_seq
;

DROP SEQUENCE IF EXISTS kliendi_seisundi_liik_kliendi_seisundi_liik_kood_seq
;

DROP SEQUENCE IF EXISTS laua_kategooria_laua_kategooria_kood_seq
;

DROP SEQUENCE IF EXISTS laua_kategooria_laua_kategooria_tyyp_kood_seq
;

DROP SEQUENCE IF EXISTS laua_kategooria_tyyp_laua_kategooria_tyyp_kood_seq
;

DROP SEQUENCE IF EXISTS laua_materjal_laua_materjal_kood_seq
;

DROP SEQUENCE IF EXISTS laua_seisundi_liik_laua_seisundi_liik_kood_seq
;

DROP SEQUENCE IF EXISTS tootaja_seisundi_liik_tootaja_seisundi_liik_kood_seq
;

DROP SEQUENCE IF EXISTS isik_isik_id_seq
;

DROP TABLE IF EXISTS Tootaja CASCADE
;

DROP TABLE IF EXISTS laua_kategooria_omamine CASCADE
;

DROP TABLE IF EXISTS Laud CASCADE
;

DROP TABLE IF EXISTS Klient CASCADE
;

DROP TABLE IF EXISTS Amet CASCADE
;

DROP TABLE IF EXISTS Isiku_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Kliendi_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Laua_kategooria CASCADE
;

DROP TABLE IF EXISTS Laua_kategooria_tyyp CASCADE
;

DROP TABLE IF EXISTS Laua_materjal CASCADE
;

DROP TABLE IF EXISTS Laua_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Riik CASCADE
;

DROP TABLE IF EXISTS Tootaja_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Isik CASCADE
;

CREATE TABLE Tootaja
(
	isik_id serial NOT NULL DEFAULT nextval(('tootaja_isik_id_seq'::text)::regclass),
	amet_kood smallint NOT NULL,
	tootaja_seisundi_liik_kood smallint NOT NULL DEFAULT 1,
	mentor smallint,
	CREATE INDEX IXFK_Mentor (mentor ASC),
	CREATE INDEX IXFK_Tootaja_Amet (amet_kood ASC),
	CREATE INDEX IXFK_Tootaja_Isik (isik_id ASC),
	CREATE INDEX IXFK_Tootaja_Tootaja_seisundi_liik (tootaja_seisundi_liik_kood ASC),
	CONSTRAINT PK_Tootaja PRIMARY KEY (isik_id),
	CONSTRAINT FK_Tootaja_Amet FOREIGN KEY (amet_kood) REFERENCES Amet (amet_kood) ON DELETE No Action ON UPDATE No Action,
	CONSTRAINT FK_Tootaja_Tootaja_seisundi_liik FOREIGN KEY (tootaja_seisundi_liik_kood) REFERENCES Tootaja_seisundi_liik (tootaja_seisundi_liik_kood) ON DELETE No Action ON UPDATE No Action,
	CONSTRAINT FK_Tootaja_Isik FOREIGN KEY (isik_id) REFERENCES Isik (isik_id) ON DELETE No Action ON UPDATE No Action,
	CONSTRAINT FK_Mentor FOREIGN KEY (mentor) REFERENCES Tootaja (isik_id) ON DELETE No Action ON UPDATE No Action
)
;

CREATE TABLE laua_kategooria_omamine
(
	laua_kategooria_omamine_id serial NOT NULL DEFAULT nextval(('laua_kategooria_omamine_laua_kategooria_omamine_id_seq'::text)::regclass),
	laud_id smallint NOT NULL,
	laua_kategooria_kood smallint NOT NULL,
	CREATE INDEX IXFK_laua_kategooria_omamine_Laua_kategooria (laua_kategooria_kood ASC),
	CONSTRAINT PK_laua_kategooria_omamine PRIMARY KEY (laua_kategooria_omamine_id),
	CONSTRAINT AK_laua_katogooria_Laud UNIQUE (laud_id,laua_kategooria_kood),
	CREATE INDEX IXFK_laua_kategooria_omamine_Laud (laud_id ASC),
	CONSTRAINT FK_laua_kategooria_omamine_Laud FOREIGN KEY (laud_id) REFERENCES Laud (laud_id) ON DELETE Cascade ON UPDATE Cascade,
	CONSTRAINT FK_laua_kategooria_omamine_Laua_kategooria FOREIGN KEY (laua_kategooria_kood) REFERENCES Laua_kategooria (laua_kategooria_kood) ON DELETE No Action ON UPDATE No Action
)
;

CREATE TABLE Laud
(
	laud_id serial NOT NULL DEFAULT nextval(('laud_laud_id_seq'::text)::regclass),
	tootaja_id smallint NOT NULL,
	laua_seisundi_liik_kood serial NOT NULL DEFAULT 1,
	laua_materjal_kood serial DEFAULT nextval(('laud_laua_materjal_kood_seq'::text)::regclass),
	laua_kood NOT NULL,
	reg_aeg timestamp(6)	 NOT NULL,
	kohtade_arv Integer NOT NULL,
	kommentaar varchar(255)	,
	CREATE INDEX IXFK_Laud_Laua_materjal_02 (laua_materjal_kood ASC),
	CREATE INDEX IXFK_Laud_Laua_seisundi_liik_02 (laua_seisundi_liik_kood ASC),
	CONSTRAINT PK_Laud PRIMARY KEY (laud_id),
	CREATE INDEX IXFK_Laud_Laua_materjal (laua_materjal_kood ASC),
	CREATE INDEX IXFK_Laud_Laua_seisundi_liik (laua_seisundi_liik_kood ASC),
	CONSTRAINT laud_kohtade_arv_check_suurem_yhest CHECK (kohtade_arv > 1),
	CONSTRAINT laud_reg_aeg_check_lubatud_vahemik CHECK (reg_aeg >= '01.01.2010' AND reg_aeg <= '31.12.2100'),
	CONSTRAINT laud_kommentaar_check_ei_ole_tyhi_string CHECK (kommentaar!~'^[[:space:]]*$'),
	CONSTRAINT laud_kommentaar_check_ei_koosne_tyhikutest CHECK (kommentaar!~'^[[:space:]]*$'),
	CONSTRAINT AK_Laud_kood UNIQUE (laua_kood),
	CONSTRAINT laud_reg_aeg_check_v2iksem_v6rdne_hetkeajast CHECK (reg_aeg <= DATE()),
	CONSTRAINT FK_Laud_Laua_materjal FOREIGN KEY (laua_materjal_kood) REFERENCES Laua_materjal (laua_materjal_kood) ON DELETE No Action ON UPDATE No Action,
	CONSTRAINT FK_Laud_Laua_seisundi_liik FOREIGN KEY (laua_seisundi_liik_kood) REFERENCES Laua_seisundi_liik (laua_seisundi_liik_kood) ON DELETE No Action ON UPDATE No Action,
	CONSTRAINT FK_Tootaja_Id_registreerib FOREIGN KEY (tootaja_id) REFERENCES Tootaja (isik_id) ON DELETE No Action ON UPDATE Cascade
)
;

CREATE TABLE Klient
(
	isik_id serial NOT NULL DEFAULT nextval(('klient_isik_id_seq'::text)::regclass),
	on_nous_tylitamisega NOT NULL DEFAULT false,
	kliendi_seisundi_liik_kood smallint NOT NULL DEFAULT 1,
	CREATE INDEX IXFK_Klient_Kliendi_seisundi_liik (kliendi_seisundi_liik_kood ASC),
	CONSTRAINT PK_Klient PRIMARY KEY (isik_id),
	CREATE INDEX IXFK_Klient_Isik (isik_id ASC),
	CONSTRAINT FK_Klient_Kliendi_seisundi_liik FOREIGN KEY (kliendi_seisundi_liik_kood) REFERENCES Kliendi_seisundi_liik (kliendi_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Klient_Isik FOREIGN KEY (isik_id) REFERENCES Isik (isik_id) ON DELETE No Action ON UPDATE No Action
)
;

CREATE TABLE Amet
(
	amet_kood serial NOT NULL DEFAULT nextval(('amet_amet_kood_seq'::text)::regclass),
	nimetus varchar(50)	 NOT NULL,
	kirjeldus varchar(50)	,
	CONSTRAINT PK_Amet PRIMARY KEY (amet_kood),
	CONSTRAINT AK_Amet_Nimetus UNIQUE (nimetus),
	CONSTRAINT amet_kirjeldus_check_ei_ole_tyhi_string CHECK (kirjeldus!~'^[[:space:]]*$'),
	CONSTRAINT amet_kirjeldus_check_ei_koosne_tyhikutest CHECK (kirjeldus!~'^[[:space:]]*$')
)
;

CREATE TABLE Isiku_seisundi_liik
(
	isiku_seisundi_liik_kood serial NOT NULL DEFAULT nextval(('isiku_seisundi_liik_isiku_seisundi_liik_kood_seq'::text)::regclass),
	nimetus varchar(50)	 NOT NULL,
	CONSTRAINT PK_Isiku_seisundi_liik PRIMARY KEY (isiku_seisundi_liik_kood),
	CONSTRAINT AK_Isiku_Seisundi_Liik_Nimetus UNIQUE (nimetus)
)
;

CREATE TABLE Kliendi_seisundi_liik
(
	kliendi_seisundi_liik_kood serial NOT NULL DEFAULT nextval(('kliendi_seisundi_liik_kliendi_seisundi_liik_kood_seq'::text)::regclass),
	nimetus varchar(50)	 NOT NULL,
	CONSTRAINT PK_Kliendi_seisundi_liik PRIMARY KEY (kliendi_seisundi_liik_kood),
	CONSTRAINT AK_Kliendi_Seisundi_Liik_Nimetus UNIQUE (nimetus)
)
;

CREATE TABLE Laua_kategooria
(
	laua_kategooria_kood serial NOT NULL DEFAULT nextval(('laua_kategooria_laua_kategooria_kood_seq'::text)::regclass),
	nimetus varchar(50)	 NOT NULL,
	laua_kategooria_tyyp_kood serial NOT NULL DEFAULT nextval(('laua_kategooria_laua_kategooria_tyyp_kood_seq'::text)::regclass),
	CREATE INDEX IXFK_Laua_kategooria_Laua_kategooria_tyyp_02 (laua_kategooria_tyyp_kood ASC),
	CONSTRAINT PK_Laua_kategooria PRIMARY KEY (laua_kategooria_kood),
	CREATE INDEX IXFK_Laua_kategooria_Laua_kategooria_tyyp (laua_kategooria_tyyp_kood ASC),
	CONSTRAINT AK_Nimetus_Laua_kategooria_tyyp UNIQUE (laua_kategooria_tyyp_kood,nimetus),
	CONSTRAINT FK_Laua_kategooria_Laua_kategooria_tyyp FOREIGN KEY (laua_kategooria_tyyp_kood) REFERENCES Laua_kategooria_tyyp (laua_kategooria_tyyp_kood) ON DELETE No Action ON UPDATE Cascade
)
;

CREATE TABLE Laua_kategooria_tyyp
(
	laua_kategooria_tyyp_kood serial NOT NULL DEFAULT nextval(('laua_kategooria_tyyp_laua_kategooria_tyyp_kood_seq'::text)::regclass),
	nimetus varchar(50)	 NOT NULL,
	CONSTRAINT PK_Laua_kategooria_tyyp PRIMARY KEY (laua_kategooria_tyyp_kood),
	CONSTRAINT AK_Laua_Kategooria_Tyyp_Nimetus UNIQUE (nimetus)
)
;

CREATE TABLE Laua_materjal
(
	laua_materjal_kood serial NOT NULL DEFAULT nextval(('laua_materjal_laua_materjal_kood_seq'::text)::regclass),
	nimetus varchar(50)	 NOT NULL,
	CONSTRAINT PK_Laua_materjal PRIMARY KEY (laua_materjal_kood),
	CONSTRAINT AK_Laua_Materjal_Nimetus UNIQUE (nimetus)
)
;

CREATE TABLE Laua_seisundi_liik
(
	laua_seisundi_liik_kood serial NOT NULL DEFAULT nextval(('laua_seisundi_liik_laua_seisundi_liik_kood_seq'::text)::regclass),
	nimetus varchar(50)	 NOT NULL,
	CONSTRAINT PK_Laua_seisundi_liik PRIMARY KEY (laua_seisundi_liik_kood),
	CONSTRAINT AK_Laua_Seisundi_Liik_Nimetus UNIQUE (nimetus)
)
;

CREATE TABLE Riik
(
	riik_kood char(3)	 NOT NULL,
	nimetus varchar(50)	 NOT NULL,
	CONSTRAINT PK_Riik PRIMARY KEY (riik_kood),
	CONSTRAINT AK_Riik_Nimetus UNIQUE (nimetus),
	CONSTRAINT riik_riik_kood_check_on_kolm_tahemarki CHECK (riik_kood~'^[a-zA-Z]{3}$')
)
;

CREATE TABLE Tootaja_seisundi_liik
(
	tootaja_seisundi_liik_kood serial NOT NULL DEFAULT nextval(('tootaja_seisundi_liik_tootaja_seisundi_liik_kood_seq'::text)::regclass),
	nimetus varchar(50)	 NOT NULL,
	CONSTRAINT PK_Tootaja_seisundi_liik PRIMARY KEY (tootaja_seisundi_liik_kood),
	CONSTRAINT AK_Tootaja_Seisundi_Liik_Nimetus UNIQUE (nimetus)
)
;

CREATE TABLE Isik
(
	isik_id serial NOT NULL DEFAULT nextval(('isik_isik_id_seq'::text)::regclass),
	isikukoodi_riik char(3)	 NOT NULL,
	isiku_seisundi_liik_kood smallint NOT NULL DEFAULT 1,
	e_meil varchar(255)	 NOT NULL,
	isikukood varchar(20)	 NOT NULL,
	synni_kp date NOT NULL,
	parool varchar(100)	 NOT NULL,
	reg_aeg timestamp NOT NULL DEFAULT Now(),
	eesnimi varchar(50)	 NOT NULL,
	perenimi varchar(50)	,
	elukoht varchar(20)	,
	CONSTRAINT PK_Isik PRIMARY KEY (isik_id),
	CONSTRAINT AK_Isik_e_meil UNIQUE (e_meil),
	CONSTRAINT AK_Isikukood_riik UNIQUE (isikukood,isikukoodi_riik),
	CONSTRAINT isik_e_meil_check_on_tostutundetu CHECK (e_meil~'^[A-Za-z0-9.]+@[A-Za-z0-9.]+[A-Za-z]+$'),
	CONSTRAINT isik_isikukood_check_lubatud_symbolid CHECK (isikukood~'[A-Za-z0-9[:space:]/\//ig;-]+'),
	CONSTRAINT isik_isikukood_check_ei_koosne_tyhikutest_ei_ole_tyhi_string CHECK (isikukood!~'^[[:space:]]*$'),
	CONSTRAINT isik_synni_kp_check_lubatud_vahemik CHECK (synni_kp >= '01.01.1900' AND synni_kp <= '31.12.2100'),
	CONSTRAINT isik_synni_kp_check_v2iksem_v6rdne_isiku_registreerimise_ajast CHECK (synni_kp <= reg_aeg),
	CONSTRAINT isik_reg_aeg_check_lubatud_vahemik CHECK (reg_aeg >= '01.01.2010' AND reg_aeg <= '31.12.2100'),
	CONSTRAINT isik_eesnimi_check_eesnimi_voi_perenimi_registreeritud CHECK (perenimi IS NOT NULL OR eesnimi IS NOT NULL),
	CONSTRAINT isik_eesnimi_check_ei_ole_tyhi_string CHECK (eesnimi<>''),
	CONSTRAINT isik_perenimi_check_ei_ole_tyhi_string CHECK (perenimi<>''),
	CONSTRAINT isik_elukoht_check_ei_koosne_tyhikutest_ei_ole_tyhi_string CHECK (elukoht!~'^[[:space:]]*$'),
	CONSTRAINT isik_synni_kp_check_v2iksem_v6rdne_kui_hetke_kuupaev CHECK (synni_kp <= Date()),
	CONSTRAINT isik_reg_aeg_check_v2iksem_v6rdne_kui_hetkeaeg CHECK (reg_aeg <= DATE()),
	CREATE INDEX IXFK_Isik_Isiku_seisundi_liik (isiku_seisundi_liik_kood ASC),
	CREATE INDEX IXFX_Isikukoodi_riik (isikukoodi_riik ASC),
	CONSTRAINT FK_Isik_Isiku_seisundi_liik FOREIGN KEY (isiku_seisundi_liik_kood) REFERENCES Isiku_seisundi_liik (isiku_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Isikukoodi_riik FOREIGN KEY (isikukoodi_riik) REFERENCES Riik (riik_kood) ON DELETE No Action ON UPDATE Cascade
)
;

CREATE SEQUENCE tootaja_isik_id_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laua_kategooria_omamine_laua_kategooria_omamine_id_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laud_laud_id_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laud_laua_seisundi_liik_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laud_laua_materjal_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE klient_isik_id_seq INCREMENT 1 START 1
;

CREATE SEQUENCE amet_amet_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE isiku_seisundi_liik_isiku_seisundi_liik_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE kliendi_seisundi_liik_kliendi_seisundi_liik_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laua_kategooria_laua_kategooria_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laua_kategooria_laua_kategooria_tyyp_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laua_kategooria_tyyp_laua_kategooria_tyyp_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laua_materjal_laua_materjal_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE laua_seisundi_liik_laua_seisundi_liik_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE tootaja_seisundi_liik_tootaja_seisundi_liik_kood_seq INCREMENT 1 START 1
;

CREATE SEQUENCE isik_isik_id_seq INCREMENT 1 START 1
;

COMMIT;