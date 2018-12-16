# idu0220
Andmebaasid II rühmatöö failid


## FEEDBACK:
* laua_kat_oma 
* kitsenduse nimes tabeli nimi
* liig indeks
* ixfk ei ole vaja 
* kompenseeriv tegevus puudub töötajate tabelis, 
klassifikat. kitsendused puudu
* topelt kitsendused
* eesnimi ja perenimi length
* tuleb muuta olemusdiagrammi kui tahad jätta perenime kohustulikuks
* now() ei ole ajavööndid
* fk stiil samaks teha
* laua_kood maha ja nimetada laua_id laua_kood, Integeriks jätta
* tootaja iseenese mentor
* (((kirjeldus)::text!~'^[[:space:]]+$'::text))
* kirjeldus<>'', ei ole tegu tyhja stringiga
* lower and upper
* reg_aeg <= CURRENT_DATE see ei ole konseptuaalne mudel
* 2101 jan 00:00:00
* riik kood suur t2hed 3
* registreerimis ajale vaikimisiv22rtus, laud tabel
## TEHA:
* Wordi dokumendis uuendada pildid
* Wordi dokumendis viia check nimed vastavusse EA faili check nimedega.
* tõstutundetu on Upper abil. Ül 10.
* Tootaja tabelis FK valesti: Mentor -> mentor. Peaks vist olema isik_id
## VIST TEHTUD:
* pealkirjade stiil peab olema ühtlaselt sama
* DEFAULT VALUED
* indeksid
* indexid välisvõtmeta põhjal kui need ei kattu PK-ga. IXFK
* now()  on, ja sellel puudub vaikimisi väärtus. ASENDUS CURRENT_TIMESTAMP()
## TEHTUD:
* veergude tüübid sobivaks
* kontrollida kitsendusi postgreSQL sees
* text asemele varcharid
* trigerid
* kui on mingi klassifikaator tabeli id, siis smallserial. Ja kõik viited sellele smallint
* smallintid üle vaadata
* eesnime ja perekonna nime kontroll ei ole tühi string vaid NULL. Accessist saab. perenimi IS NOT NULL OR eesnimi IS NOT NULL
* counter läheb serial ja kõik viited sellele integer -  (meil pold countereid)
* töötaja tabelis on puudu on delete tegevus. Kui töötaja kustutatakse ära ja see on kellegi mentor, siis kustutamine peab õnnestumine
* nimi peab olema pikema pikkusega.
* nime pikkus on yle 255
* reg aeg väiksem võrdne current date  on üleliigne. CHK.
* kuupäeva puhul peab olema 23.59.59 kah
* Tühja stringi ja tühikutest koosnemise CHK on samad, aga peavad olema erinevad. Lisaks peab need korda tegema.
* 3 tähemärgi kitsendus riigikoodi puhul on SUURED tähed, mitte väiketähed.
* SELECT regexp_matches('aiVar.loOpOpalu@gmail.com', '^[A-Za-z0-9.]+@[A-Za-z0-9.]+[A-Za-z]+$'); tõstutundetu
* perenimi!~'^[[:space:]]*$' OR eesnimi!~'^[[:space:]]*$'
* e_meil~'^[A-Za-z0-9.]+@[A-Za-z0-9.]+[A-Za-z]+$'
* stiil
* kitsendused korduvad erinevate nimedega
* ak laua kategooria laud  kitsendus ????
* kitsenduse nimes pole tabeli nime
* ixfk laua kategooria omamine laua kategooria indeksit pole vaja
* kitsenduste nimedes peavad olema tabeli nimed. FK omades kah ja indeksi omades kah
* töötaja ei tohi olla iseenda mentor
* tekstiveergudel peavad olema kitsendused. Ei tohi olla tühistring ja tühikutest koosnev string
* Kumbki peab olema kohustuslik, nimi või eesnimi.  Olemisuhte diagrammis ja atribuutide definitsioonis peab olema kah kirjas, et nimi on kohustuslik ja perekonna nimi ei ole kohustuslik
* now pole olemas    timestamp ja now ei sobi kokku

SUUR KONTROLL:
* 22-24 Sequence pole vaja. Need numbrid sisestab inimene käsitsi. Ei ole serial.
* Laua tabelis on töötaja_id   liiga üldise nimega. Töötaja võib olla lauaga seotudmitmel erineval viisil. Et peab täpsustama. Näiteks registreerija id. 
* Forein key kitsenduse nimed peavad olema sama stiiliga. Hetkel on FK-s 3 eri stiili. Peab olema 1. 
* Topelt indeksid tuleb eemaldada. 
* Laua tabelis pole vaja topelt  laua kood   ja   laud id  . 
* CHK kitsendused puudu osadel tabelitel.
* emaili CHK korda teha. Et oleks tõstutundetu. Ül 10. Peab olema kontroll, et ei ole 2 ätt märki. 
* current date tuleb eemaldada. Kui kitsendusi juurde lisatakse, siis tuleb täiendada konteptuaalset andmemudelit. Vähemaks ei või võtta.
* Klassifikaatorite koodid ei ole serial, vaid käsitsi. 
* emaili regex on text ätt text . 2-4 tähemärki