# Projekt z przedmiotu Hipertekst i Hipermedia (HiH)

## Temat: Moje Hobby - Czytanie Książek

Projekt ten stanowi realizację wymagań kursu "Hipertekst i Hipermedia" (HiH), skupiając się na zaawansowanym przetwarzaniu i transformacji danych w oparciu o język XML oraz XSLT.

---

### 💾 Etap I: Modelowanie Danych i Walidacja

W ramach I etapu przygotowano plik XML opisujący wybrane hobby (`hobby.xml`), wraz z kompletną walidacją struktury:

- **DTD (Document Type Definition)**
- **XML Schema (XSD)**

🔗 **Repozytorium z rozwiązaniem Etapu I znajduje się tutaj:**

> https://github.com/hstrekowski/PG_HyperText_HyperMedia_Project_1

---

### 🛠️ Etap II: Transformacje XSLT

Zaimplementowano **dwie oddzielne, złożone transformacje XSLT** (pliki `.xsl`).

#### **1. Transformacja Prezentacyjna (XML $\rightarrow$ HTML + CSS)**

_Plik wyjściowy: `*.html`_

Transformacja ta ma na celu wyświetlenie danych w przeglądarce i wykorzystuje zewnętrzny arkusz stylów CSS. Zaimplementowane funkcjonalności obejmują:

| Wymaganie                  | Szczegóły Implementacji                                                                                     |
| :------------------------- | :---------------------------------------------------------------------------------------------------------- |
| **Szablony**               | Min. 8 nietrywialnych szablonów dopasowujących elementy, 1 szablon dopasowujący atrybut, 1 szablon nazwany. |
| **Warunki i Wybór**        | Zastosowanie `<xsl:if>` i `<xsl:choose>` (łącznie min. 3 razy).                                             |
| **Pętla i Sortowanie**     | Wykorzystanie `<xsl:for-each>` w połączeniu z instrukcją **`<xsl:sort>`**.                                  |
| **Numerowanie**            | Min. dwukrotne użycie `<xsl:number>` z różnymi parametrami, w tym dla posortowanej listy.                   |
| **XPath**                  | Wykorzystanie ścieżek do wybranych węzłów oraz min. trzykrotne użycie **predykatów** w celu filtrowania.    |
| **Funkcje**                | Zastosowanie min. 5 różnych funkcji XPath i/lub XSLT.                                                       |
| **Zmienne**                | Wykorzystanie zmiennych (`<xsl:variable>`), zarówno prostej, jak i złożonej (przechowującej zestaw węzłów). |
| **Elementy Hipertekstowe** | Dynamiczne generowanie **aktywnych linków** i osadzanie **zdjęć** (parametry pobrane z XML).                |
| **Formatowanie**           | Dwukrotne, różne formatowanie liczb za pomocą `<xsl:format-number>`.                                        |

---

#### **2. Transformacja Zmieniająca Strukturę (XML $\rightarrow$ Nowy XML)**

_Plik wyjściowy: `*.xml`_

Transformacja ta skupia się na restrukturyzacji danych i zmianie słownictwa XML.

| Wymaganie                   | Szczegóły Implementacji                                                                                           |
| :-------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| **Nowa Struktura**          | Plik wynikowy posiada inną hierarchię (min. 3 poziomy zagłębienia, nie licząc korzenia).                          |
| **Nowe Znaczniki/Atrybuty** | Min. 4 nowe nazwy znaczników i min. 3 nowe nazwy atrybutów.                                                       |
| **Dynamiczne Nazewnictwo**  | Nazwa jednego znacznika i nazwa jednego atrybutu są dynamicznie pobierane jako **wartość** z pliku wejściowego.   |
| **Instrukcje Kontroli**     | Wykorzystanie instrukcji: **`<xsl:copy>`**, **`<xsl:copy-of>`**, **`<xsl:element>`**, oraz **`<xsl:attribute>`**. |

---
