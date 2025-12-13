<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://example.org/hobby">

    <xsl:output method="xml" indent="yes" encoding="UTF-8" />

    <xsl:template match="/">

        <Raport_Biblioteczny data_raportu="2025-06-20">

            <Metryka_Studenta>

                <xsl:element name="{h:Hobby_Czytelnicze/@imie_autora}">
                    <xsl:value-of select="h:Hobby_Czytelnicze/@nazwisko_autora" />
                </xsl:element>

                <Indeks>
                    <xsl:value-of select="h:Hobby_Czytelnicze/@indeks_autora" />
                </Indeks>

                <Podsumowanie_Ilościowe>
                    <xsl:attribute name="{//h:Liczba_Przeczytanych/@jednostka}">
                        <xsl:value-of select="//h:Liczba_Przeczytanych" />
                    </xsl:attribute>
                </Podsumowanie_Ilościowe>

            </Metryka_Studenta>

            <Katalog_Zbiorow>
                <xsl:apply-templates select="//h:Ksiazka" />
            </Katalog_Zbiorow>

        </Raport_Biblioteczny>
    </xsl:template>

    <xsl:template match="h:Ksiazka">
        <Wolumin>
            <xsl:attribute name="nr_inwentarzowy">
                <xsl:value-of select="@id" />
            </xsl:attribute>

            <Detale_Publikacji>
                <Tytul_Dziela>
                    <xsl:attribute name="wersja_jezykowa">
                        <xsl:value-of select="h:Tytul/@h:jezyk" />
                    </xsl:attribute>
                    <xsl:value-of select="h:Tytul" />
                </Tytul_Dziela>

                <Autor_Calosc>
                    <xsl:value-of select="h:Autor/h:Imie" />
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="h:Autor/h:Nazwisko" />

                    <xsl:for-each select="h:Autor/h:Narodowosc">
                        <xsl:copy>
                            <xsl:value-of select="." />
                        </xsl:copy>
                    </xsl:for-each>
                </Autor_Calosc>

                <Dane_Techniczne>
                    <xsl:copy-of select="h:Dane_Wydawnicze/h:ISBN" />
                </Dane_Techniczne>

            </Detale_Publikacji>

            <Status>
                <xsl:value-of select="@status" />
            </Status>
            <Ocena>
                <xsl:value-of select="@ocena" />
            </Ocena>

        </Wolumin>
    </xsl:template>

</xsl:stylesheet>