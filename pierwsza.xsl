<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://example.org/hobby">

    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <xsl:template match="/">
        <html>
            <head>
                <title>Moje Hobby Czytelnicze</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f9;
                    }
                    h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
                    h2 { color: #2980b9; margin-top: 30px; }
                    .card { background: white; padding: 15px; margin-bottom: 10px; border-radius:
        5px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
                    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
                    th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                    th { background-color: #3498db; color: white; }
                    .status-przeczytana { color: green; font-weight: bold; }
                    .status-w_trakcie { color: orange; font-weight: bold; }
                    .autor-info { font-style: italic; color: #555; }
                    img { max-width: 100px; height: auto; border-radius: 4px; }
                </style>
            </head>
            <body>
                <xsl:apply-templates select="h:Hobby_Czytelnicze" />
            </body>
        </html>
    </xsl:template>

    <xsl:template match="h:Hobby_Czytelnicze">
        <div>
            <h1>Raport Czytelniczy</h1>
            <p><strong>Autor projektu: </strong> 
                <xsl:value-of select="@imie_autora" />&#160;<xsl:value-of
                    select="@nazwisko_autora" /> (Indeks: <xsl:value-of select="@indeks_autora" />) </p>
            <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="h:Podsumowanie">
        <div class="card">
            <h2>Podsumowanie Roku</h2>
            <p>
                <em>
                    <xsl:value-of select="h:Opis/h:Opis_Rozwiniety/h:Tekst" />
                </em>
            </p>
            <ul>
                <xsl:for-each select="h:Opis/h:Opis_Rozwiniety/h:Korzysci/h:Punkt">
                    <li>
                        <xsl:value-of select="." />
                    </li>
                </xsl:for-each>
            </ul>
            <xsl:apply-templates select="h:Statystyki" />
        </div>
    </xsl:template>

    <xsl:template match="h:Statystyki_Roczne">
        <h3>Statystyki za rok <xsl:value-of select="@rok" /></h3>
        <ul>
            <li>Przeczytano: <strong>
                    <xsl:value-of select="h:Liczba_Przeczytanych" />
                </strong> sztuk</li>
            <li>Strony: <xsl:value-of select="h:Liczba_Stron" /></li>
            <li>Czas: <xsl:value-of select="h:Laczny_Czas_Czytania" /> godzin</li>
        </ul>
    </xsl:template>

    <xsl:template match="h:Statystyki_Format">
        <h3>Formaty:</h3>
        <xsl:for-each select="h:Format">
            <div style="margin-bottom: 5px;">
                <span style="display:inline-block; width: 80px;"><xsl:value-of select="@nazwa" />:</span>
                <span
                    style="background-color: #3498db; color: white; padding: 2px 5px; border-radius: 3px;">
                    <xsl:value-of select="." />
                    <xsl:value-of select="@jednostka" />
                </span>
            </div>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="h:Ulubione_Gatunki">
        <h2>Ulubione Gatunki</h2>
        <xsl:apply-templates select="h:Gatunek">
            <xsl:sort select="@priorytet" data-type="number" order="ascending" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="h:Gatunek">
        <div class="card">
            <h3><xsl:value-of select="@priorytet" />. <xsl:value-of select="h:Nazwa" /></h3>
            <p>
                <xsl:value-of select="h:Opis" />
            </p>
            <p>
                <strong>Autorzy:</strong>
            </p>
            <ul>
                <xsl:apply-templates select="h:Przykladowi_Autorzy/h:Autor" />
            </ul>
        </div>
    </xsl:template>

    <xsl:template match="h:Autor">
        <li>
            <span class="autor-info">
                <xsl:value-of select="h:Imie" />&#160;<xsl:value-of select="h:Nazwisko" /> (<xsl:value-of
                    select="h:Narodowosc" />) - Rola: <xsl:value-of select="@rola" />
            </span>
        </li>
    </xsl:template>

    <xsl:template match="h:Ksiazki">
        <h2>Biblioteczka</h2>
        <table>
            <thead>
                <tr>
                    <th>Okładka</th>
                    <th>Tytuł</th>
                    <th>Autor</th>
                    <th>Wydawnictwo</th>
                    <th>Status / Ocena</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates select="h:Ksiazka" />
            </tbody>
        </table>
    </xsl:template>

    <xsl:template match="h:Ksiazka">
        <tr>
            <td>
                <xsl:apply-templates select="h:Media" />
            </td>
            <td>
                <strong>
                    <xsl:value-of select="h:Tytul" />
                </strong>
            </td>
            <td>
                <xsl:value-of select="h:Autor/h:Imie" />&#160;<xsl:value-of
                    select="h:Autor/h:Nazwisko" />
            </td>
            <td>
                <xsl:apply-templates select="h:Dane_Wydawnicze" />
            </td>
            <td>
                <span>
                    <xsl:attribute name="class"> status-<xsl:value-of select="@status" />
                    </xsl:attribute>
                    <xsl:value-of select="@status" />
                </span>
                <br /> Ocena: <xsl:value-of
                    select="@ocena" />
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="h:Dane_Wydawnicze">
        <xsl:value-of select="h:Wydawnictwo/@nazwa_pelna" />
        <br />
        <small>Rok: <xsl:value-of
                select="h:Rok_Wydania_Polskiego" /></small><br />
        <small>ISBN: <xsl:value-of
                select="h:ISBN" /></small>
    </xsl:template>

    <xsl:template match="h:Media">
        <img src="{h:Okladka/h:Zdjecie/@url}" alt="Okładka" />
        <br />
        <a
            href="{h:Recenzja/h:Link/@url}" target="_blank">Zobacz recenzję</a>
    </xsl:template>

</xsl:stylesheet>