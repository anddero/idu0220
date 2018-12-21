package ee.ttu.algoritmid.approxtsp;

import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

public class Main {


    public static void main(String[] args) {
        int max = 5;
        int min = 1;

        int[] regs = {1, 2, 3, 4, 5,6,7,8};
        String[] omadused = {"Tuleks minema visata", "Hetkel veel kõlbab", "Enamus kliente ei taha sinna istuda", "Tanel Padar istus seal lauas", "See oli mingi hetk tagasi katki", "Jõulupeol tehti see laud katki",
                "Kole peletis laud", "Naelutatud", "Kommentaar", "Üks kõige esimestest laudadest mis osteti", "Täitsa maasikas laud", "Läheb kergesti mustaks", "Mingi asjaga ära plökerdatud", "Tuleb remondimees remontima kutsuda",
                "Mari ütles, et see laud on sigakole", "Lihtsalt jõle, aga jätame alles kuna jüri arvas et see OK", "Tuleks minema visata kuigi jüri arvab et see laud ka veel OK", "Üks kleintide lemmikutest laudadest", "Massivne remondiraha kulutaja"};
        for (int i = 1; i < 1152; i++) {
            int randomNum = ThreadLocalRandom.current().nextInt(min, max + 1);
            int year = ThreadLocalRandom.current().nextInt(2011, 2018);
            int month = ThreadLocalRandom.current().nextInt(10, 13);
            int day = ThreadLocalRandom.current().nextInt(11, 27);
            int hour = ThreadLocalRandom.current().nextInt(11, 24);
            int minutes = ThreadLocalRandom.current().nextInt(11, 60);
            int secundes = ThreadLocalRandom.current().nextInt(11, 60);
            int laua_seisund_liik_indeks = ThreadLocalRandom.current().nextInt(1, 5);
            int materjal = ThreadLocalRandom.current().nextInt(1, 5);
            int omadused_index = ThreadLocalRandom.current().nextInt(1, 19);
            int kohtadeArv = ThreadLocalRandom.current().nextInt(2, 20);
            int registreerijaId = regs[randomNum];
            String kommentaar = omadused[omadused_index];
            String time = "'"+ month + "." + day + "." + year + " " + hour + ":" + minutes + ":" + secundes + "'";
            System.out.println("insert into laud (laud_kood, registreerija_id, reg_aeg, laua_seisundi_liik_kood, laua_materjal_kood, kohtade_arv, kommentaar) values " +
                    "(" + i + ", "+registreerijaId + "," + time + "," + laua_seisund_liik_indeks + "," + materjal + "," +kohtadeArv + ",'"  +kommentaar + "');");

        }


        for (int i = 1; i <= 1151; i++) {
            if (ThreadLocalRandom.current().nextInt(2, 20) % 2 == 0)
                System.out.println("insert into laua_kategooria_omamine (laud_kood, laua_kategooria_kood) values (" + i + "," +  1 + ");");

            if (ThreadLocalRandom.current().nextInt(2, 20) % 2 == 0)
                System.out.println("insert into laua_kategooria_omamine (laud_kood, laua_kategooria_kood) values (" + i + "," +  2 + ");");

            if (ThreadLocalRandom.current().nextInt(2, 20) % 2 == 0)
                System.out.println("insert into laua_kategooria_omamine (laud_kood, laua_kategooria_kood) values (" + i + "," +  3 + ");");


            if (ThreadLocalRandom.current().nextInt(2, 20) % 2 == 0)
                System.out.println("insert into laua_kategooria_omamine (laud_kood, laua_kategooria_kood) values (" + i + "," +  4 + ");");


            if (ThreadLocalRandom.current().nextInt(2, 20) % 2 == 0) {
                System.out.println("insert into laua_kategooria_omamine (laud_kood, laua_kategooria_kood) values (" + i + "," +  5 + ");");
            } else {
                System.out.println("insert into laua_kategooria_omamine (laud_kood, laua_kategooria_kood) values (" + i + "," +  6 + ");");
            }

            if (ThreadLocalRandom.current().nextInt(2, 20) % 2 == 0) {
                System.out.println("insert into laua_kategooria_omamine (laud_kood, laua_kategooria_kood) values (" + i + "," +  7 + ");");
            } else {
                System.out.println("insert into laua_kategooria_omamine (laud_kood, laua_kategooria_kood) values (" + i + "," +  8 + ");");
            }


        }
    }
}
