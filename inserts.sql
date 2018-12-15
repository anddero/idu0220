
delete
from riik;
insert into riik (riik_kood, nimetus)
values ('EST', 'Eesti');
insert into riik (riik_kood, nimetus)
values ('AFG', 'Afganistaan');
insert into riik (riik_kood, nimetus)
values ('RUS', 'Venemaa');
insert into riik (riik_kood, nimetus)
values ('GBR', 'Suurbritannia');
insert into riik (riik_kood, nimetus)
values ('ALB', 'Ahvenamaa');
insert into riik (riik_kood, nimetus)
values ('LVA', 'Läti');
insert into riik (riik_kood, nimetus)
values ('LTU', 'Leedu');
insert into riik (riik_kood, nimetus)
values ('DEU', 'Saksamaa');
insert into riik (riik_kood, nimetus)
values ('USA', 'Ameerika Ühendriigid');
select *
from riik;

delete
from amet;
insert into amet (amet_kood, nimetus, kirjeldus)
values (1, 'Kokk', 'Söögi tegemine');
insert into amet (amet_kood, nimetus, kirjeldus)
values (2, 'Kelner', 'Klientide teenindamine');
insert into amet (amet_kood, nimetus, kirjeldus)
values (3, 'Müüja', 'Kassa teenindamine');
insert into amet (amet_kood, nimetus, kirjeldus)
values (4, 'Koristaja', 'Tööpindade puhastuse operaator');
insert into amet (amet_kood, nimetu2s, kirjeldus)
values (5, 'Juhataja', 'Vastutav isik töökoha eest');
select *
from amet;

delete
from isiku_seisundi_liik;
insert into isiku_seisundi_liik (isiku_seisundi_liik_kood, nimetus)
values (1, 'Elus');
insert into isiku_seisundi_liik (isiku_seisundi_liik_kood, nimetus)
values (2, 'Surnud');
select *
from isiku_seisundi_liik;

delete
from tootaja_seisundi_liik;
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)
values (1, 'Katseajal');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)
values (2, 'Tööl');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)
values (3, 'Puhkusel');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)
values (4, 'Haiguslehel');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)
values (5, 'Töösuhe peatatud');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)
values (6, 'Töösuhe lõpetatud oma soovil');
insert into tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus)
values (7, 'Vallandatud');
select *
from tootaja_seisundi_liik;

delete
from isik;
select *
from isik;

delete
from tootaja;
select *
from tootaja;

delete
from laua_seisundi_liik;
select *
from laua_seisundi_liik;

delete
from laud;
select *
from laud;

delete
from laua_materjal;
select *
from laua_materjal;


