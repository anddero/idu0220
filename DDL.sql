ALTER TABLE [Isik] DROP CONSTRAINT [FK_Isik_Isiku_seisundi_liik]
;

ALTER TABLE [Isik] DROP CONSTRAINT [FK_isikukoodi_riik]
;

ALTER TABLE [Klient] DROP CONSTRAINT [FK_Klient_Kliendi_seisundi_liik]
;

ALTER TABLE [Klient] DROP CONSTRAINT [FK_Klient_Isik]
;

ALTER TABLE [Laua_kategooria] DROP CONSTRAINT [FK_Laua_kategooria_Laua_kategooria_tyyp]
;

ALTER TABLE [laua_kategooria_omamine] DROP CONSTRAINT [FK_laua_kategooria_omamine_Laud]
;

ALTER TABLE [laua_kategooria_omamine] DROP CONSTRAINT [FK_laua_kategooria_omamine_Laua_kategooria]
;

ALTER TABLE [Laud] DROP CONSTRAINT [FK_Laud_Laua_materjal]
;

ALTER TABLE [Laud] DROP CONSTRAINT [FK_Laud_Laua_seisundi_liik]
;

ALTER TABLE [Laud] DROP CONSTRAINT [broneerib]
;

ALTER TABLE [Laud] DROP CONSTRAINT [registreerib]
;

ALTER TABLE [Muutumine] DROP CONSTRAINT [FK_Muutumine_Tooraine]
;

ALTER TABLE [Tootaja] DROP CONSTRAINT [FK_Tootaja_Amet]
;

ALTER TABLE [Tootaja] DROP CONSTRAINT [FK_Tootaja_Tootaja_seisundi_liik]
;

ALTER TABLE [Tootaja] DROP CONSTRAINT [FK_Tootaja_Isik]
;

ALTER TABLE [Tootaja] DROP CONSTRAINT [FK_mentor]
;

DROP TABLE [Amet]
;

DROP TABLE [Isik]
;

DROP TABLE [Isiku_seisundi_liik]
;

DROP TABLE [Kliendi_seisundi_liik]
;

DROP TABLE [Klient]
;

DROP TABLE [Laua_kategooria]
;

DROP TABLE [laua_kategooria_omamine]
;

DROP TABLE [Laua_kategooria_tyyp]
;

DROP TABLE [Laua_materjal]
;

DROP TABLE [Laua_seisundi_liik]
;

DROP TABLE [Laud]
;

DROP TABLE [Muutumine]
;

DROP TABLE [Riik]
;

DROP TABLE [Tooraine]
;

DROP TABLE [Tootaja]
;

DROP TABLE [Tootaja_seisundi_liik]
;

CREATE TABLE [Amet]
(
	[kirjeldus] Text(50),
	[amet_kood] Short NOT NULL
)
;

CREATE TABLE [Isik]
(
	[isikukood] Text(50),
	[e_meil] Text(50),
	[synni_kp] date,
	[parool] Text(50),
	[reg_aeg] date,
	[eesnimi] Text(50),
	[perenimi] Text(50),
	[elukoht] Text(50),
	[isik_kood]  Short NOT NULL,
	[isiku_seisundi_liik_kood] Short,
	[isikukoodi_riik] Short
)
;

CREATE TABLE [Isiku_seisundi_liik]
(
	[isiku_seisundi_liik_kood] Short NOT NULL,
	[nimi] Text(50),
	[kirjeldus] Text(255)
)
;

CREATE TABLE [Kliendi_seisundi_liik]
(
	[kliendi_seisundi_liik_kood] Short NOT NULL,
	[nimi] Text(50),
	[kirjeldus] Text(255)
)
;

CREATE TABLE [Klient]
(
	[kliendi_kood] int,
	[on_nous_tylitamisega] YesNo,
	[klient_kood] Short NOT NULL,
	[kliendi_seisundi_liik_kood] Short
)
;

CREATE TABLE [Laua_kategooria]
(
	[laua_kategooria_kood] Short NOT NULL,
	[laua_kategooria_tyyp_kood] Short
)
;

CREATE TABLE [laua_kategooria_omamine]
(
	[laua_kategooria_omamine_kood] Short NOT NULL,
	[laud_kood] Short,
	[laua_kategooria_kood] Short
)
;

CREATE TABLE [Laua_kategooria_tyyp]
(
	[laua_kategooria_tyyp_kood] Short NOT NULL,
	[nimi] Text(50),
	[kirjeldus] Text(255)
)
;

CREATE TABLE [Laua_materjal]
(
	[laua_materjal_kood] Short NOT NULL,
	[nimi] Text(50),
	[kirjeldus] Text(255)
)
;

CREATE TABLE [Laua_seisundi_liik]
(
	[laua_seisundi_liik_kood] Short NOT NULL,
	[nimi] Text(50),
	[kirjeldus] Text(255)
)
;

CREATE TABLE [Laud]
(
	[reg_aeg] timestamp,
	[kohtade_arv] int,
	[kommentaar] Text(50),
	[laua_materjal_kood] Short,
	[laua_seisundi_liik_kood] Short,
	[laud_kood] Short NOT NULL,
	[klient_kood] Short,
	[tootaja_kood] Short
)
;

CREATE TABLE [Muutumine]
(
	[hulga_muutus] Double,
	[aeg] Text(50),
	[kommentaar] Text(50),
	[muutuse_kood] int,
	[muutumine_kood] Short NOT NULL,
	[tooraine_kood] Short
)
;

CREATE TABLE [Riik]
(
	[riik_kood] Short NOT NULL
)
;

CREATE TABLE [Tooraine]
(
	[nimetus] Text(50),
	[hulk_kg] Double,
	[kommentaar] Text(50),
	[tooraine_kood]  Short NOT NULL
)
;

CREATE TABLE [Tootaja]
(
	[tootaja_kood]  AUTOINCREMENT(1,1),
	[amet_kood] Short,
	[tootaja_seisundi_liik_kood] Short NOT NULL,
	[mentor] Short
)
;

CREATE TABLE [Tootaja_seisundi_liik]
(
	[nimi] Text(50),
	[tootaja_seisundi_liik_kood] Short NOT NULL,
	[kirjeldus] Text(255)
)
;

ALTER TABLE [Amet] ADD CONSTRAINT [PK_Amet]
	PRIMARY KEY ([amet_kood]) 
;

ALTER TABLE [Isik] ADD CONSTRAINT [PK_Isik]
	PRIMARY KEY ([isik_kood])
;

ALTER TABLE [Isiku_seisundi_liik] ADD CONSTRAINT [PK_Isiku_seisundi_liik]
	PRIMARY KEY ([isiku_seisundi_liik_kood])
;

ALTER TABLE [Kliendi_seisundi_liik] ADD CONSTRAINT [PK_Kliendi_seisundi_liik]
	PRIMARY KEY ([kliendi_seisundi_liik_kood])
;

ALTER TABLE [Klient] ADD CONSTRAINT [PK_Klient]
	PRIMARY KEY ([klient_kood])
;

ALTER TABLE [Laua_kategooria] ADD CONSTRAINT [PK_Laua_kategooria]
	PRIMARY KEY ([laua_kategooria_kood])
;

ALTER TABLE [laua_kategooria_omamine] ADD CONSTRAINT [PK_laua_kategooria_omamine]
	PRIMARY KEY ([laua_kategooria_omamine_kood])
;

ALTER TABLE [Laua_kategooria_tyyp] ADD CONSTRAINT [PK_Laua_kategooria_tyyp]
	PRIMARY KEY ([laua_kategooria_tyyp_kood])
;

ALTER TABLE [Laua_materjal] ADD CONSTRAINT [PK_Laua_materjal]
	PRIMARY KEY ([laua_materjal_kood])
;

ALTER TABLE [Laua_seisundi_liik] ADD CONSTRAINT [PK_Laua_seisundi_liik]
	PRIMARY KEY ([laua_seisundi_liik_kood])
;

ALTER TABLE [Laud] ADD CONSTRAINT [PK_Laud]
	PRIMARY KEY ([laud_kood])
;

ALTER TABLE [Muutumine] ADD CONSTRAINT [PK_Muutumine]
	PRIMARY KEY ([muutumine_kood])
;

ALTER TABLE [Riik] ADD CONSTRAINT [PK_Riik]
	PRIMARY KEY ([riik_kood])
;

ALTER TABLE [Tooraine] ADD CONSTRAINT [PK_Tooraine]
	PRIMARY KEY ([tooraine_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [PK_Tootaja]
	PRIMARY KEY ([tootaja_kood])
;

ALTER TABLE [Tootaja_seisundi_liik] ADD CONSTRAINT [PK_Tootaja_seisundi_liik]
	PRIMARY KEY ([tootaja_seisundi_liik_kood])
;

ALTER TABLE [Isik] ADD CONSTRAINT [FK_Isik_Isiku_seisundi_liik]
	FOREIGN KEY ([isiku_seisundi_liik_kood]) REFERENCES [Isiku_seisundi_liik] ([isiku_seisundi_liik_kood])
;

ALTER TABLE [Isik] ADD CONSTRAINT [FK_isikukoodi_riik]
	FOREIGN KEY ([isikukoodi_riik]) REFERENCES [Riik] ([riik_kood])
;

ALTER TABLE [Klient] ADD CONSTRAINT [FK_Klient_Kliendi_seisundi_liik]
	FOREIGN KEY ([kliendi_seisundi_liik_kood]) REFERENCES [Kliendi_seisundi_liik] ([kliendi_seisundi_liik_kood])
;

ALTER TABLE [Klient] ADD CONSTRAINT [FK_Klient_Isik]
	FOREIGN KEY ([klient_kood]) REFERENCES [Isik] ([isik_kood])
;

ALTER TABLE [Laua_kategooria] ADD CONSTRAINT [FK_Laua_kategooria_Laua_kategooria_tyyp]
	FOREIGN KEY ([laua_kategooria_tyyp_kood]) REFERENCES [Laua_kategooria_tyyp] ([laua_kategooria_tyyp_kood])
;

ALTER TABLE [laua_kategooria_omamine] ADD CONSTRAINT [FK_laua_kategooria_omamine_Laud]
	FOREIGN KEY ([laud_kood]) REFERENCES [Laud] ([laud_kood])
;

ALTER TABLE [laua_kategooria_omamine] ADD CONSTRAINT [FK_laua_kategooria_omamine_Laua_kategooria]
	FOREIGN KEY ([laua_kategooria_kood]) REFERENCES [Laua_kategooria] ([laua_kategooria_kood])
;

ALTER TABLE [Laud] ADD CONSTRAINT [FK_Laud_Laua_materjal]
	FOREIGN KEY ([laua_materjal_kood]) REFERENCES [Laua_materjal] ([laua_materjal_kood])
;

ALTER TABLE [Laud] ADD CONSTRAINT [FK_Laud_Laua_seisundi_liik]
	FOREIGN KEY ([laua_seisundi_liik_kood]) REFERENCES [Laua_seisundi_liik] ([laua_seisundi_liik_kood])
;

ALTER TABLE [Laud] ADD CONSTRAINT [broneerib]
	FOREIGN KEY ([klient_kood]) REFERENCES [Klient] ([klient_kood])
;

ALTER TABLE [Laud] ADD CONSTRAINT [registreerib]
	FOREIGN KEY ([tootaja_kood]) REFERENCES [Tootaja] ([tootaja_kood])
;

ALTER TABLE [Muutumine] ADD CONSTRAINT [FK_Muutumine_Tooraine]
	FOREIGN KEY ([tooraine_kood]) REFERENCES [Tooraine] ([tooraine_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Amet]
	FOREIGN KEY ([amet_kood]) REFERENCES [Amet] ([amet_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Tootaja_seisundi_liik]
	FOREIGN KEY ([tootaja_seisundi_liik_kood]) REFERENCES [Tootaja_seisundi_liik] ([tootaja_seisundi_liik_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Isik]
	FOREIGN KEY ([tootaja_kood]) REFERENCES [Isik] ([isik_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_mentor]
	FOREIGN KEY ([mentor]) REFERENCES [Tootaja] ([tootaja_kood])
;
