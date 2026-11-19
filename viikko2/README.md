# Week 2 on linux couse.
# LEMP stack.
This project is built using a LEMP stack (Linux, Nginx, MySQL, and Python). The web application is developed with Flask, served by Gunicorn, and exposed to users through Nginx, which acts as a reverse proxy. The application also includes a visitor counter whose value is stored in a MySQL database. Every time the page is visited or refreshed, the counter is updated in the database and the current visitor count is displayed on the webpage.

## Task requirements:
    Toteutus

    1. Säilytä viikon 1 sivu toiminnassa alkuperäisessä osoitteessaan vielä vähintään viikon ajan.

    2. Julkaise tämän viikon sovellus omassa osoitteessaan, esimerkiksi:

    http://PUBLIC_IP/viikko2/

     Voit käyttää samaa virtuaalikonetta ja Nginxiä kuin viikolla 1. Määritä Nginx välittämään tämän polun pyynnöt Python-sovellukselle. Erillistä virtuaalikonetta tai julkista porttia ei tarvita.

    3. Varmista sivun saavutettavuus. HTTP-portin 80 tulee olla avoinna julkisesta internetistä, jotta vertaisarvioija pääsee sivulle. Python-sovellus voi kuunnella paikallisesti osoitteessa 127.0.0.1, eikä sen omaa porttia tarvitse avata internetiin. Varmista, että Nginx, Python-sovellus ja tietokanta käynnistyvät automaattisesti myös virtuaalikoneen uudelleenkäynnistyksen jälkeen.

    4. Käytä GitHubia versionhallintaan. Tallenna sovelluksen lähdekoodi repositorioon ja tee työn edetessä muutoksia kuvaavia committeja. Lisää verkkosivulle linkki repositorioon ja varmista vertaisarvioijan pääsy siihen. Älä tallenna salasanoja, yksityisiä avaimia tai muita salaisuuksia GitHubiin.

    5. Personoi sivu. Muokkaa sisältöä tai ulkoasua oletus- tai esimerkkisivusta. Omaa nimeä ei tarvitse julkaista.

    6. Toteuta tietokantaan tallentava kävijälaskuri.

        * Näytä sivulla käyntimäärä, joka kasvaa jokaisella sivun latauksella. Yksittäisiä kävijöitä ei tarvitse tunnistaa.

        * Tallenna käyntimäärä tietokantaan, jotta se säilyy sovelluksen ja palvelimen uudelleenkäynnistyksen jälkeen.

        * Testaa pysyvyys käynnistämällä virtuaalikone uudelleen. Varmista, että sivu avautuu ja laskuri jatkaa aiemmasta arvosta.

        * Kuvaa sivulla lyhyesti käytetty tietokanta, laskurin tallennustapa ja uudelleenkäynnistystestin tulos.


