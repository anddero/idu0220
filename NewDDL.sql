
CREATE TABLE [Tootaja]
(
	[tootaja_id] AUTOINCREMENT,
	[amet_kood] Short NOT NULL,
	[tootaja_seisundi_liik_kood] Short NOT NULL,
	[mentor] Long
)
;

CREATE TABLE [Amet]
(
	[amet_kood] Short NOT NULL,
	[nimetus] Text(50) NOT NULL,
	[kirjeldus] Text(255)
)
;

CREATE TABLE [Isiku_seisundi_liik]
(
	[isiku_seisundi_liik_kood] Short NOT NULL,
	[nimetus] Text(50) NOT NULL
)
;

CREATE TABLE [Kliendi_seisundi_liik]
(
	[kliendi_seisundi_liik_kood] Short NOT NULL,
	[nimetus] Text(50) NOT NULL
)
;

CREATE TABLE [Laua_kategooria]
(
	[laua_kategooria_kood] Short NOT NULL,
	[nimetus] Text(50) NOT NULL,
	[laua_kategooria_tyyp_kood] Short NOT NULL
)
;

CREATE TABLE [Laua_kategooria_tyyp]
(
	[laua_kategooria_tyyp_kood] Short NOT NULL,
	[nimetus] Text(50) NOT NULL
)
;

CREATE TABLE [Laua_materjal]
(
	[laua_materjal_kood] Short NOT NULL,
	[nimetus] Text(50) NOT NULL
)
;

CREATE TABLE [Laua_seisundi_liik]
(
	[laua_seisundi_liik_kood] Short NOT NULL,
	[nimetus] Text(50) NOT NULL
)
;

CREATE TABLE [Riik]
(
	[riik_kood] Text(3) NOT NULL,
	[nimetus] Text(50) NOT NULL
)
;

CREATE TABLE [Tootaja_seisundi_liik]
(
	[tootaja_seisundi_liik_kood] Short NOT NULL,
	[nimetus] Text(50) NOT NULL
)
;

CREATE TABLE [laua_kategooria_omamine]
(
	[laua_kategooria_omamine_id] AUTOINCREMENT,
	[laud_id] Long NOT NULL,
	[laua_kategooria_kood] Short NOT NULL
)
;

CREATE TABLE [Laud]
(
	[laud_id] AUTOINCREMENT,
	[laua_kood] Long NOT NULL,
	[reg_aeg] DateTime DEFAULT Now() NOT NULL,
	[kohtade_arv] Short NOT NULL,
	[kommentaar] Text(255),
	[laua_materjal_kood] Short NOT NULL,
	[laua_seisundi_liik_kood] Short NOT NULL,
	[tootaja_id] Long NOT NULL
)
;

CREATE TABLE [Klient]
(
	[on_nous_tylitamisega] YesNo NOT NULL,
	[klient_id] AUTOINCREMENT,
	[kliendi_seisundi_liik_kood] Short NOT NULL
)
;

CREATE TABLE [Isik]
(
	[isik_id] AUTOINCREMENT,
	[e_meil] Text(254) NOT NULL,
	[isikukood] Text(50) NOT NULL,
	[synni_kp] DateTime NOT NULL,
	[parool] Text(255) NOT NULL,
	[reg_aeg] DateTime NOT NULL,
	[eesnimi] Text(255),
	[perenimi] Text(255),
	[elukoht] Text(255),
	[isiku_seisundi_liik_kood] Short NOT NULL,
	[isikukoodi_riik] Text(3) NOT NULL
)
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [PK_Tootaja]
	PRIMARY KEY ([tootaja_id])
;

ALTER TABLE [Amet] ADD CONSTRAINT [PK_Amet]
	PRIMARY KEY ([amet_kood])
;

ALTER TABLE [Amet] ADD CONSTRAINT [AK_Nimetus] UNIQUE ([nimetus])
;

ALTER TABLE [Isiku_seisundi_liik] ADD CONSTRAINT [PK_Isiku_seisundi_liik]
	PRIMARY KEY ([isiku_seisundi_liik_kood])
;

ALTER TABLE [Isiku_seisundi_liik] ADD CONSTRAINT [AK_Nimetus] UNIQUE ([nimetus])
;

ALTER TABLE [Kliendi_seisundi_liik] ADD CONSTRAINT [PK_Kliendi_seisundi_liik]
	PRIMARY KEY ([kliendi_seisundi_liik_kood])
;

ALTER TABLE [Kliendi_seisundi_liik] ADD CONSTRAINT [AK_Nimetus] UNIQUE ([nimetus])
;

ALTER TABLE [Laua_kategooria] ADD CONSTRAINT [PK_Laua_kategooria]
	PRIMARY KEY ([laua_kategooria_kood])
;

CREATE INDEX [IXFK_Laua_kategooria_Laua_kategooria_tyyp] ON [Laua_kategooria] ([laua_kategooria_tyyp_kood] ASC)
;

ALTER TABLE [Laua_kategooria] ADD CONSTRAINT [AK_Nimetus_Laua_kategooria_tyyp] UNIQUE ([laua_kategooria_tyyp_kood],[nimetus])
;

ALTER TABLE [Laua_kategooria_tyyp] ADD CONSTRAINT [PK_Laua_kategooria_tyyp]
	PRIMARY KEY ([laua_kategooria_tyyp_kood])
;

ALTER TABLE [Laua_kategooria_tyyp] ADD CONSTRAINT [AK_Nimetus] UNIQUE ([nimetus])
;

ALTER TABLE [Laua_materjal] ADD CONSTRAINT [PK_Laua_materjal]
	PRIMARY KEY ([laua_materjal_kood])
;

ALTER TABLE [Laua_materjal] ADD CONSTRAINT [AK_Nimetus] UNIQUE ([nimetus])
;

ALTER TABLE [Laua_seisundi_liik] ADD CONSTRAINT [PK_Laua_seisundi_liik]
	PRIMARY KEY ([laua_seisundi_liik_kood])
;

ALTER TABLE [Laua_seisundi_liik] ADD CONSTRAINT [AK_Nimetus] UNIQUE ([nimetus])
;

ALTER TABLE [Riik] ADD CONSTRAINT [PK_Riik]
	PRIMARY KEY ([riik_kood])
;

ALTER TABLE [Riik] ADD CONSTRAINT [AK_Nimetus] UNIQUE ([nimetus])
;

ALTER TABLE [Tootaja_seisundi_liik] ADD CONSTRAINT [PK_Tootaja_seisundi_liik]
	PRIMARY KEY ([tootaja_seisundi_liik_kood])
;

ALTER TABLE [Tootaja_seisundi_liik] ADD CONSTRAINT [AK_Nimetus] UNIQUE ([nimetus])
;

ALTER TABLE [laua_kategooria_omamine] ADD CONSTRAINT [PK_laua_kategooria_omamine]
	PRIMARY KEY ([laua_kategooria_omamine_id])
;

ALTER TABLE [laua_kategooria_omamine] ADD CONSTRAINT [AK_laua_katogooria_Laud] UNIQUE ([laud_id],[laua_kategooria_kood])
;

ALTER TABLE [Laud] ADD CONSTRAINT [PK_Laud]
	PRIMARY KEY ([laud_id])
;

CREATE INDEX [IXFK_Laud_Laua_materjal] ON [Laud] ([laua_materjal_kood] ASC)
;

CREATE INDEX [IXFK_Laud_Laua_seisundi_liik] ON [Laud] ([laua_seisundi_liik_kood] ASC)
;

ALTER TABLE [Laud] ADD CONSTRAINT [AK_Laud_kood] UNIQUE ([laua_kood])
;

CREATE INDEX [IXFK_Klient_Kliendi_seisundi_liik] ON [Klient] ([kliendi_seisundi_liik_kood] ASC)
;

ALTER TABLE [Klient] ADD CONSTRAINT [PK_Klient]
	PRIMARY KEY ([klient_id])
;

ALTER TABLE [Isik] ADD CONSTRAINT [PK_Isik]
	PRIMARY KEY ([isik_id])
;

ALTER TABLE [Isik] ADD CONSTRAINT [AK_Isik_e_meil] UNIQUE ([e_meil])
;

ALTER TABLE [Isik] ADD CONSTRAINT [AK_Isikukood_riik] UNIQUE ([isikukood],[isikukoodi_riik])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Amet]
	FOREIGN KEY ([amet_kood]) REFERENCES [Amet] ([amet_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Tootaja_seisundi_liik]
	FOREIGN KEY ([tootaja_seisundi_liik_kood]) REFERENCES [Tootaja_seisundi_liik] ([tootaja_seisundi_liik_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Isik]
	FOREIGN KEY ([tootaja_id]) REFERENCES [Isik] ([isik_id])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_mentor]
	FOREIGN KEY ([mentor]) REFERENCES [Tootaja] ([tootaja_id])
;

ALTER TABLE [laua_kategooria_omamine] ADD CONSTRAINT [FK_laua_kategooria_omamine_Laud]
	FOREIGN KEY ([laud_id]) REFERENCES [Laud] ([laud_id])
;

ALTER TABLE [laua_kategooria_omamine] ADD CONSTRAINT [FK_laua_kategooria_omamine_Laua_kategooria]
	FOREIGN KEY ([laua_kategooria_kood]) REFERENCES [Laua_kategooria] ([laua_kategooria_kood])
;

ALTER TABLE [Laud] ADD CONSTRAINT [registreerib]
	FOREIGN KEY ([tootaja_id]) REFERENCES [Tootaja] ([tootaja_id])
;

ALTER TABLE [Klient] ADD CONSTRAINT [FK_Klient_Kliendi_seisundi_liik]
	FOREIGN KEY ([kliendi_seisundi_liik_kood]) REFERENCES [Kliendi_seisundi_liik] ([kliendi_seisundi_liik_kood])
;

ALTER TABLE [Klient] ADD CONSTRAINT [FK_Klient_Isik]
	FOREIGN KEY ([klient_id]) REFERENCES [Isik] ([isik_id])
;

ALTER TABLE [Isik] ADD CONSTRAINT [FK_Isik_Isiku_seisundi_liik]
	FOREIGN KEY ([isiku_seisundi_liik_kood]) REFERENCES [Isiku_seisundi_liik] ([isiku_seisundi_liik_kood])
;

ALTER TABLE [Isik] ADD CONSTRAINT [FK_isikukoodi_riik]
	FOREIGN KEY ([isikukoodi_riik]) REFERENCES [Riik] ([riik_kood])
;
