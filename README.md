# idu020
Andmebaasid II rühmatöö failid

## DONE
- [x] Teha cool TODO list
- [x] Non-foreign key columns that   ... check    Seal on checkid puudu.
- [X] Isik.parool=parool    Tabelis peavad olema hashid, mitte paroolid
- [x] Kirjeldus peab olema 1000 ja kommentaar kah 1000, mitte 255
- [X] Tõstutundetu email peab olema.  Upper või lower peab olema. 
- [X] Seda reeglit ei old, et emailis on väiketähed.
- [X] Emaili õrge vormi  check  peab olema  tilde tärn         ~ asemel mingi *
- [X] Isiku seisundi liik kood ei tohi olla integer vaid small int. käik klassifikaatorid peaks olema small int
- [X] Laua_materjal_kood ei ole õige. 
- [X] Registreerimise aeg peab olema kellaajaga
- [X] f_on_juhataja funktsioonis INNER JOIN amet ON tootaja.amet_kood=amet.amet_kood on üleliigne, kuna välisvõti juba kontrollib.
## KOOD:


- [ ] 3 vaate puhul peab tähelepanu päärama sellele, et kasutus käib läbi virtuaalse andmete kihi. Vaata käiki laudu view puhul ei tohiks näha laua detaili. Peab olema eraldi view selle jaoks.
- [ ]  Boonuspunkti asju lisada (3 erinevat).
- [ ] 4000 rea lisamisel "Kasutatud laused/käsud tuleb dokumenteerida töö alajaotuses "Täiendavate testandmete lisamine"." 
- [ ] f_kõik_lauad tuleb ära kustutada. See ei kõlba. Ja ei tohi olla Public õiguseid.
- [ ] isikukoodi märkide check puudub
- [ ] elukoha check puudub, et ei tohi olla ainult numbrid
- [ ] JSONi boonusül peab olema 2-tasemeline
- [ ] f_kustuta_laud peab tegema nii nagu ülesanne 11 näitab. See ül on triggerite kohta. Viitab Mustripõhisele juhendile lk 43. Selecti on vaja triggeris ainult siis, kui on 
seotud ka teiste tabelitega. Mitte ei ole oma tabeli piires muudatused.
- [ ] juhatajal on liiga palju õiguseid. Juhataja rakendus ei vaja laua vaatamist või laua unustamist. On vaja on_juhataja ja lopeta_laud funktsionaalsust.
- [ ] kõik funktsioonid ja trigerid peab tegema, mis puudutavad juhataja funktsionaalsust. 4 kasutusjuhtu on juhatajal. Ei piisa paarist funktsioonist. lopeta_laud on puudu.
- [ ] Boonusülesandes jälgida Exeli tabelit. string agg korda teha, sest see ei ole seotud tabelis määratud ülesandega.
- [ ] Javat ei tohi kasutada 1000 ja 4000 genereerimiseks. Võib kasutada AINULT generate series  funktsiooni.

## ACCESS 
- [X] View-des minna soovitud ajaformaatide peale ümber
- [ ] Kasutajaliides korda teha

## ENTEPRISE ARHITECT:
- [ ] Enterprise Archidektis on võimalik SQL faile ODCB abil EA-sse sisse lugeda. Enterprise Architect Reverse Engineering. Et ei pea käsitsi EA-d korda tegema.
- [ ] EA korda teha

## WORD:
- [ ] Wordis on mingi ül, et peab tegema pgadminis ühe pildi ja selle lahti seletama. Explain on vaja klikkida. See on Data Output kõrval. ildil mööda nooli minnakse. räsitabelit võrreldakse. Mida kasutatakse, kas hashjoin või muu join. Iga rea kohta kvaliteet vaadatakse läbi. Kahe hashjoini resultaat on see, et 2 tabelit ühendatakse kokku. Tulemuseks on tabel. Ja see ühendatakse teise tabeliga kokku, kasutades hashjoini.
- [ ] osad kitsendused on rohkem kui vaja. Ülesanne ei näe neid ette. Näiteks kood >= 1  või et  registreerimiskuupäev on väiksem kui praegune kuupäev. Need tuleb Wordi kah siis sisse kirjutada.
- [ ] Word korda teha
  * Wordi korda tegemiseks peavad EA, kood, Access valmis olema.
  
 

** LAUD
** VIEW
** INSERT 
** RUTIIN
** TRIGGER
** AUTH


