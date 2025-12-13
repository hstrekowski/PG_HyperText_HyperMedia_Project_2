<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:h="http://example.org/hobby">

    <xsl:output method="xml" indent="yes" encoding="UTF-8" />

    <xsl:template match="/">

        <Raport_Kulturalny>

            <Info_Student>
                <Imie>
                    <xsl:value-of select="h:Hobby_Czytelnicze/@imie_autora" />
                </Imie>
                <Nazwisko>
                    <xsl:value-of select="h:Hobby_Czytelnicze/@nazwisko_autora" />
                </Nazwisko>
                <Numer_Indeksu>
                    <xsl:value-of select="h:Hobby_Czytelnicze/@indeks_autora" />
                </Numer_Indeksu>
            </Info_Student>

            <Inwentarz_Ksiazek>
                <xsl:apply-templates select="//h:Ksiazka" />
            </Inwentarz_Ksiazek>

        </Raport_Kulturalny>
    </xsl:template>

    <xsl:template match="h:Ksiazka">

        <Pozycja>
            <xsl:attribute name="nr_katalogowy">
                <xsl:value-of select="@id" />
            </xsl:attribute>

            <Dane_Podstawowe>
                <Tytul_Glowny>
                    <xsl:value-of select="h:Tytul" />
                </Tytul_Glowny>

                <Autor_Dziela>
                    <xsl:value-of select="h:Autor/h:Imie" />
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="h:Autor/h:Nazwisko" />
                </Autor_Dziela>
            </Dane_Podstawowe>

            <Status_Czytelnictwa>
                <Aktualny_Stan>
                    <xsl:value-of select="@status" />
                </Aktualny_Stan>
                <Ocena_Uzytkownika>
                    <xsl:value-of select="@ocena" />
                </Ocena_Uzytkownika>
            </Status_Czytelnictwa>

        </Pozycja>
    </xsl:template>

</xsl:stylesheet>