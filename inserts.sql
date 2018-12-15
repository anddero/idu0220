
delete from riik;
insert into riik (riik_kood, nimetus)values ('EST', 'Eesti');
insert into riik (riik_kood, nimetus)values ('AFG', 'Afganistaan');
insert into riik (riik_kood, nimetus)values ('RUS', 'Venemaa');
insert into riik (riik_kood, nimetus)values ('GBR', 'Suurbritannia');
insert into riik (riik_kood, nimetus)values ('ALB', 'Ahvenamaa');
insert into riik (riik_kood, nimetus)values ('LVA', 'Läti');
insert into riik (riik_kood, nimetus)values ('LTU', 'Leedu');
insert into riik (riik_kood, nimetus)values ('DEU', 'Saksamaa');
insert into riik (riik_kood, nimetus)values ('USA', 'Ameerika Ühendriigid');
select * from riik;

delete from amet;
insert into amet (amet_kood, nimetus, kirjeldus)values (1, 'Kokk', 'Söögi tegemine');
insert into amet (amet_kood, nimetus, kirjeldus)values (2, 'Kelner', 'Klientide teenindamine');
insert into amet (amet_kood, nimetus, kirjeldus)values (3, 'Müüja', 'Kassa teenindamine');
insert into amet (amet_kood, nimetus, kirjeldus)values (4, 'Koristaja', 'Tööpindade puhastuse operaator');
insert into amet (amet_kood, nimetus, kirjeldus)values (5, 'Juhataja', 'Vastutav isik töökoha eest');
select * from amet;

delete from isiku_seisundi_liik;
insert into isiku_seisundi_liik (isiku_seisundi_liik_kood, nimetus)values (1, 'Elus');
insert into isiku_seisundi_liik (isiku_seisundi_liik_kood, nimetus)values (2, 'Surnud');
select * from isiku_seisundi_liik;

delete from tootaja_seisundi_liik;
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)values (1, 'Katseajal');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)values (2, 'Tööl');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)values (3, 'Puhkusel');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)values (4, 'Haiguslehel');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)values (5, 'Töösuhe peatatud');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)values (6, 'Töösuhe lõpetatud oma soovil');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)values (7, 'Vallandatud');
select * from tootaja_seisundi_liik;

delete from laua_seisundi_liik;
insert into laua_seisundi_liik (laua_seisundi_liik_kood, nimetus)values (1, 'Ootel');
insert into laua_seisundi_liik (laua_seisundi_liik_kood, nimetus)values (2, 'Mitteaktiivne');
insert into laua_seisundi_liik (laua_seisundi_liik_kood, nimetus)values (3, 'Aktiivne');
insert into laua_seisundi_liik (laua_seisundi_liik_kood, nimetus)values (4, 'Lõpetatud');
select * from laua_seisundi_liik;


delete from kliendi_seisundi_liik;
insert into kliendi_seisundi_liik (kliendi_seisundi_liik_kood, nimetus)values (1, 'Aktiivne');
insert into kliendi_seisundi_liik (kliendi_seisundi_liik_kood, nimetus)values (2, 'Mustas nimekirjas');
select * from kliendi_seisundi_liik;

delete from laua_kategooria_tyyp;
insert into laua_kategooria_tyyp (laua_kategooria_tyyp_kood, nimetus)values (1, 'Omadussõnad');
insert into laua_kategooria_tyyp (laua_kategooria_tyyp_kood, nimetus)values (2, 'Liiklus laua ümber');
insert into laua_kategooria_tyyp (laua_kategooria_tyyp_kood, nimetus)values (3, 'Vaade');
select * from laua_kategooria_tyyp;


delete from laua_kategooria;
insert into laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood)values (1, 'Ilus', 1);
insert into laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood)values (2, 'Külmavõitu', 1);
insert into laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood)values (3, 'Hubane', 1);
insert into laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood)values (4, 'Palju', 2);
insert into laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood)values (5, 'Keskmiselt', 2);
insert into laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood)values (6, 'Vähe', 2);
insert into laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood)values (7, 'Ilus', 3);
insert into laua_kategooria (laua_kategooria_kood, nimetus, laua_kategooria_tyyp_kood)values (8, 'kole', 3);
select * from laua_kategooria;


delete from laua_materjal;
insert into laua_materjal (laua_materjal_kood, nimetus)values (1, 'Puit');
insert into laua_materjal (laua_materjal_kood, nimetus)values (2, 'Klaas');
insert into laua_materjal (laua_materjal_kood, nimetus)values (3, 'Metall');
insert into laua_materjal (laua_materjal_kood, nimetus)values (4, 'Plastik');
select * from laua_materjal;


delete from laud;
insert into laud (laud_kood, tootaja_kood, laua_materjal_kood, laua_kood, kohtade_arv, kommentaar)values (2,11,'05.02.2018 13:58',2,'Laud nagu laud ikka',1);
insert into laud (laud_kood, tootaja_kood, laua_materjal_kood, laua_kood, kohtade_arv, kommentaar)values (3,12,'05.02.2018 13:59',3,'Laud nagu laud ikka',2);
insert into laud (laud_kood, tootaja_kood, laua_materjal_kood, laua_kood, kohtade_arv, kommentaar)values (4,13,'05.02.2018 13:59',4,'Laud nagu laud ikka',3);
insert into laud (laud_kood, tootaja_kood, laua_materjal_kood, laua_kood, kohtade_arv, kommentaar)values (5,14,'05.02.2018 14:00',5,'Laud nagu laud ikka',3);
insert into laud (laud_kood, tootaja_kood, laua_materjal_kood, laua_kood, kohtade_arv, kommentaar)values (6,15,'05.02.2018 14:00',5,'Laud nagu laud ikka',3);
insert into laud (laud_kood, tootaja_kood, laua_materjal_kood, laua_kood, kohtade_arv, kommentaar)values (7,324,'05.03.2018 12:47','Eriline,habras.',?,2);
insert into laud (laud_kood, tootaja_kood, laua_materjal_kood, laua_kood, kohtade_arv, kommentaar)values (8,400,'05.03.2018 12:50',3,'Ruumi on ka rohkemate jaoks',1);
select * from laud;


delete from isik;
insert into isik (isik_kood, isikukoodi_riik, e_meil, isikukood, synni_kp, parool, eesnimi, perenimi, elukoht)values (1,'nilsemil.lille@gmail.com',3554151,'03.20.2018','parool','05.02.2018 13:45','Nils','','Rakvere');
insert into isik (isik_kood, isikukoodi_riik, e_meil, isikukood, synni_kp, parool, eesnimi, perenimi, elukoht)values (2,'Kaspar@gmail.com',5152151,'05.01.2018','parool','05.02.2018 13:45','Kaspar','','Tallinn');
insert into isik (isik_kood, isikukoodi_riik, e_meil, isikukood, synni_kp, parool, eesnimi, perenimi, elukoht)values (3,'Merje@mail.ee',5125125,'05.01.2018','parool','05.02.2018 13:49','','Pajula','Keila');
insert into isik (isik_kood, isikukoodi_riik, e_meil, isikukood, synni_kp, parool, eesnimi, perenimi, elukoht)values (4,'Maxim@max.ee',5512422,'04.01.2018','paroo','05.02.2018 13:50','Maxim','','Tallinn');
insert into isik (isik_kood, isikukoodi_riik, e_meil, isikukood, synni_kp, parool, eesnimi, perenimi, elukoht)values (5,'Markus@ttu.ee',565122,'05.01.2018','PASSWORD','05.02.2018 13:51','Mihkel','Muhkel','Mägilinna');
insert into isik (isik_kood, isikukoodi_riik, e_meil, isikukood, synni_kp, parool, eesnimi, perenimi, elukoht)values (6,'hans@restoran.com',55555555,'11.28.2017','','05.03.2018 13:06','Hans','','Ei tea');
select * from isik;


delete from klient;
insert into klient (isik_kood, on_nous_tylitamisega, kliendi_seisundi_liik_kood) values (3,-1,1);
insert into klient (isik_kood, on_nous_tylitamisega, kliendi_seisundi_liik_kood) values (4,0,1);
insert into klient (isik_kood, on_nous_tylitamisega, kliendi_seisundi_liik_kood) values (5,-1,1);
select * from klient;


delete from tootaja;
insert into tootaja (isik_kood, amet_kood, mentor) values (1,1,2);
insert into tootaja (isik_kood, amet_kood, mentor) values (3,3,3);
insert into tootaja (isik_kood, amet_kood, mentor) values (4,4,4);
insert into tootaja (isik_kood, amet_kood, mentor) values (5,2,2);
insert into tootaja (isik_kood, amet_kood, mentor) values (6,2,3);
select * from tootaja;

delete from laua_kategooria_omamine;
insert into laua_kategooria_omamine (laua_kategooria_omamine_kood, laud_kood, laua_kategooria_kood) value (6,2,1);
insert into laua_kategooria_omamine (laua_kategooria_omamine_kood, laud_kood, laua_kategooria_kood) value (7,3,3);
insert into laua_kategooria_omamine (laua_kategooria_omamine_kood, laud_kood, laua_kategooria_kood) value (8,4,5);
insert into laua_kategooria_omamine (laua_kategooria_omamine_kood, laud_kood, laua_kategooria_kood) value (9,5,6);
insert into laua_kategooria_omamine (laua_kategooria_omamine_kood, laud_kood, laua_kategooria_kood) value (10,2,4);
insert into laua_kategooria_omamine (laua_kategooria_omamine_kood, laud_kood, laua_kategooria_kood) value (11,6,2);
insert into laua_kategooria_omamine (laua_kategooria_omamine_kood, laud_kood, laua_kategooria_kood) value (12,5,2);
insert into laua_kategooria_omamine (laua_kategooria_omamine_kood, laud_kood, laua_kategooria_kood) value (13,3,1);
select *from laua_kategooria_omamine;

