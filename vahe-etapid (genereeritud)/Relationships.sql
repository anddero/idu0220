ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Isik]
	FOREIGN KEY ([isik_id]) REFERENCES [Isik] ([isik_id])
;

ALTER TABLE [Laud] ADD CONSTRAINT [registreerib]
	FOREIGN KEY ([tootaja_id]) REFERENCES [Tootaja] ([tootaja_id])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Amet]
	FOREIGN KEY ([amet_kood]) REFERENCES [Amet] ([amet_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_Tootaja_Tootaja_seisundi_liik]
	FOREIGN KEY ([tootaja_seisundi_liik_kood]) REFERENCES [Tootaja_seisundi_liik] ([tootaja_seisundi_liik_kood])
;

ALTER TABLE [Tootaja] ADD CONSTRAINT [FK_mentor]
	FOREIGN KEY ([mentor]) REFERENCES [Tootaja] ([isik_id])
;

ALTER TABLE [Klient] ADD CONSTRAINT [FK_Klient_Kliendi_seisundi_liik]
	FOREIGN KEY ([kliendi_seisundi_liik_kood]) REFERENCES [Kliendi_seisundi_liik] ([kliendi_seisundi_liik_kood])
;

ALTER TABLE [Klient] ADD CONSTRAINT [FK_Klient_Isik]
	FOREIGN KEY ([isik_id]) REFERENCES [Isik] ([isik_id])
;
