<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://example.org/hobby">

    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <xsl:variable name="aktualnyRok" select="2025" />

    <xsl:decimal-format name="pl" grouping-separator=" " />

    <xsl:template match="/">
        <html>
            <head>
                <title>Moje Hobby Czytelnicze</title>
                <link rel="stylesheet" type="text/css" href="style.css" />
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
            <xsl:call-template name="StopkaStrony" />
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
                <xsl:apply-templates select="h:Opis/h:Opis_Rozwiniety/h:Korzysci/h:Punkt" />
            </ul>
            <xsl:apply-templates select="h:Statystyki" />

            <div class="xpath-box">
                <h4>📊 Analiza danych:</h4>
                <ul>
                    <li>
                        <strong>Autor pierwszej książki:</strong>
                        <xsl:value-of
                            select="/h:Hobby_Czytelnicze/h:Ksiazki/h:Ksiazka[1]/h:Autor/h:Nazwisko" />
                    </li>
                    <li>
                        <strong>Tytuł książki o ID 103:</strong>
                        <xsl:value-of
                            select="/h:Hobby_Czytelnicze/h:Ksiazki/h:Ksiazka[@id='103']/h:Tytul" />
                    </li>
                    <li>
                        <strong>Ile książek przeczytano:</strong>
                        <xsl:value-of
                            select="count(/h:Hobby_Czytelnicze/h:Ksiazki/h:Ksiazka[@status='przeczytana'])" />
                    </li>
                    <li>
                        <strong>Ostatnia pozycja na liście:</strong>
                        <xsl:value-of
                            select="/h:Hobby_Czytelnicze/h:Ksiazki/h:Ksiazka[last()]/h:Tytul" />
                    </li>
                    <li>
                        <strong>Długość tytułu pierwszej książki:</strong>
                        <xsl:value-of
                            select="string-length(/h:Hobby_Czytelnicze/h:Ksiazki/h:Ksiazka[1]/h:Tytul)" />
        znaków </li>
                </ul>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="h:Punkt">
        <li>
            <xsl:value-of select="." />
        </li>
    </xsl:template>

    <xsl:template match="h:Statystyki_Roczne">
        <h3>Statystyki za rok <xsl:value-of select="@rok" /></h3>
        <ul>
            <li>Przeczytano: <strong>
                    <xsl:value-of select="h:Liczba_Przeczytanych" />
                </strong> sztuk</li>
            <li> Strony: <xsl:value-of select="format-number(h:Liczba_Stron, '# ###', 'pl')" />
            </li>
            <li>Czas: <xsl:value-of select="h:Laczny_Czas_Czytania" /> godzin</li>
            <li> Średnio stron na książkę: <strong>
                    <xsl:value-of
                        select="format-number(h:Liczba_Stron div h:Liczba_Przeczytanych, '0.00')" />
                </strong>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="h:Statystyki_Format">
        <h3>Formaty:</h3>
        <xsl:apply-templates select="h:Format" />
    </xsl:template>

    <xsl:template match="h:Format">
        <div style="margin-bottom: 5px;">
            <span style="display:inline-block; width: 80px;"><xsl:value-of select="@nazwa" />:</span>
            <span
                style="background-color: #3498db; color: white; padding: 2px 5px; border-radius: 3px;">
                <xsl:value-of select="." />
                <xsl:value-of select="@jednostka" />
            </span>
        </div>
    </xsl:template>

    <xsl:template match="h:Ulubione_Gatunki">
        <h2>Ulubione Gatunki</h2>
        <xsl:apply-templates select="h:Gatunek">
            <xsl:sort select="@priorytet" data-type="number" order="ascending" />
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="h:Gatunek">
        <div class="card">
            <h3>
                <xsl:value-of select="@priorytet" />. <xsl:value-of select="h:Nazwa" />
                <xsl:if
                    test="@priorytet = 1">
                    <span class="top-pick">★ ULUBIONY ★</span>
                </xsl:if>
            </h3>
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
            <span class="monogram">
                <xsl:value-of select="substring(h:Imie, 1, 1)" />
                <xsl:value-of select="substring(h:Nazwisko, 1, 1)" />
            </span>
            <span class="autor-info">
                <xsl:value-of select="h:Imie" />&#160;<xsl:value-of select="h:Nazwisko" /> (<xsl:value-of
                    select="h:Narodowosc" />) <xsl:apply-templates select="@rola" />
            </span>
        </li>
    </xsl:template>

    <xsl:template match="h:Ksiazki">
        <h2>Biblioteczka</h2>
        <div class="indeks-box">
            <h3>Szybki indeks tytułów (A-Z)</h3>
            <ul>
                <xsl:for-each select="h:Ksiazka">
                    <xsl:sort select="h:Tytul" />
                    <li>
                        <xsl:number value="position()" format="1. " />
                        <xsl:value-of select="h:Tytul" />
        (ID: <xsl:value-of select="@id" />) </li>
                </xsl:for-each>
            </ul>
        </div>

        <table>
            <thead>
                <tr>
                    <th>Lp.</th>
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
        <xsl:variable name="sformatowana_ocena">
            <xsl:choose>
                <xsl:when test="@ocena = '5'">
                    <strong style="color: #e67e22;">⭐⭐⭐⭐⭐ (Wybitna)</strong>
                </xsl:when>
                <xsl:when test="@ocena = '4'">
                    <span style="color: #f1c40f;">⭐⭐⭐⭐ (Dobra)</span>
                </xsl:when>
                <xsl:when test="@ocena = 'brak'">
                    <em style="color:#aaa;">Jeszcze nie oceniono</em>
                </xsl:when>
                <xsl:otherwise> Ocena: <xsl:value-of select="@ocena" />/5 </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <tr>
            <td class="lp-col">
                <xsl:number count="h:Ksiazka" level="single" format="I." />
            </td>
            <td>
                <xsl:apply-templates select="h:Media" />
            </td>
            <td>
                <strong>
                    <xsl:value-of select="h:Tytul" />
                </strong>
            </td>
            <td>
                <xsl:apply-templates select="h:Autor" />
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
                <br />
                <xsl:copy-of select="$sformatowana_ocena" />
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="h:Dane_Wydawnicze">
        <xsl:value-of select="h:Wydawnictwo/@nazwa_pelna" />
        <br />
        <small>Miasto: <xsl:value-of
                select="h:Wydawnictwo/h:Siedziba_Glowna/h:Adres_Fizyczny/h:Miasto" />
            <xsl:if
                test="contains(h:Wydawnictwo/h:Siedziba_Glowna/h:Adres_Fizyczny/h:Miasto, 'Poznań')">
                <span style="color:green; font-weight:bold;"> (Lokalne!)</span>
            </xsl:if>
        </small>
        <br />
        <small>
        Rok: <xsl:value-of select="h:Rok_Wydania_Polskiego" /> (wiek: <xsl:value-of
                select="$aktualnyRok - h:Rok_Wydania_Polskiego" /> lat) </small>
        <xsl:if
            test="h:Rok_Wydania_Polskiego &lt; 2000">
            <span class="klasyk">KLASYK</span>
        </xsl:if>
        <br />
        <small>ISBN: <xsl:value-of
                select="h:ISBN" /></small>
    </xsl:template>

    <xsl:template match="h:Media">
        <img src="{h:Okladka/h:Zdjecie/@url}" alt="Okładka" />
        <br />
        
        <a
            href="{h:Recenzja/h:Link/@url}" target="_blank"> Zobacz recenzję (<xsl:value-of
                select="h:Recenzja/h:Link/@typ" />) </a>
    </xsl:template>

    <xsl:template match="@rola">
        <span class="rola-atrybut"> [<xsl:value-of select="." />] </span>
    </xsl:template>

    <xsl:template name="StopkaStrony">
        <div class="footer">
            <p>Dziękuję za przeglądanie mojego raportu czytelniczego!</p>
            <p>
                <xsl:value-of
                    select="concat('Prawa autorskie &#169; ', '2025 ', 'Hubert Strękowski')" />
            </p>
        </div>
    </xsl:template>

</xsl:stylesheet>