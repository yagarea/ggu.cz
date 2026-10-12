---
title: Konvence psaní Pythonu
subtitle: "Stručný přehled toho, jak psát čitelný kód"
layout: display-page
permalink: /python-conventions/
lang: cs
---

Konvence nejsou pravidla jazyka. Kód poběží, i když je porušíte. Dodržují se proto,
aby ho dokázal přečíst i někdo jiný (a vy za měsíc). Oficiální doporučení se jmenuje
[PEP 8](https://peps.python.org/pep-0008/), tohle je jeho zkrácená verze.

## Pojmenování
- **Proměnné a funkce:** malá písmena, slova oddělená podtržítkem: `pocet_smluv`, `nacti_soubor()`. Tomuto stylu se říká **snake_case**.
- **Konstanty** (hodnoty, které se nemění): velká písmena s podtržítky: `MAX_DELKA = 100`. Říká se mu **UPPER_SNAKE_CASE** nebo **SCREAMING_SNAKE_CASE**.
- **Třídy:** každé slovo začíná velkým písmenem, bez podtržítek: `SmluvniStrana`. Říká se mu **PascalCase**.
- Styl **camelCase** (`pocetSmluv`, první slovo malé, další velkým) Python nepoužívá. Potkáte ho v JavaScriptu nebo Javě.
- Názvy mají říkat, co věc obsahuje nebo dělá. `x` a `data` jsou skoro vždy špatně, `cena_bez_dph` je dobře.
- Pište anglicky, nebo česky bez diakritiky. Hlavně to nemíchejte.

```python
# špatně
X = 21
def Vypocet(d, s):
    return d * (1 + s / 100)
class smluvni_strana:
    pass

# dobře
SAZBA_DPH = 21


def pridej_dph(cena, sazba):
    return cena * (1 + sazba / 100)


class SmluvniStrana:
    pass
```

## Mezery
- Odsazuje se **4 mezerami**, nikdy tabulátorem. Editor to za vás většinou nastaví sám.
- Kolem `=` a operátorů (např: `+`, `-`, `==`, `<`) je mezera z obou stran: `a = b + 1`.
- Výjimka: u pojmenovaných argumentů a výchozích hodnot mezery nejsou: `funkce(a, b=1)`.
- Za čárkou mezera, před ní ne: `funkce(a, b)`, `[1, 2, 3]`.
- Za dvojtečkou ve slovníku mezera, před ní ne: `{"jmeno": "Jan"}`.
- Hned za otevírací a před zavírací závorkou mezera není: `seznam[0]`, `funkce(x)`, ne `funkce( x )`.
- Mezi názvem funkce a závorkou mezera není: `print("ahoj")`, ne `print ("ahoj")`.
- Před dvojtečkou na konci `if`, `elif`, `else`, `for`, `while` a `def` mezera není: `else:`, ne `else :`.
- `and`, `or` a `not` jsou operátory, ne funkce. Kolem nich je mezera: `if not hotovo:`, ne `if not(hotovo):`.
- Na konci řádku nemají být žádné mezery navíc.

```python
# špatně
cena=nacti_cenu( soubor,sazba = 21 )
slovnik = { "a":1 , "b":2 }

# dobře
cena = nacti_cenu(soubor, sazba=21)
slovnik = {"a": 1, "b": 2}
```

## Nové řádky
- **Jeden příkaz na řádek.** Nikdy `a = 1; b = 2`.
- Tělo podmínky nebo cyklu je **vždy na novém řádku**, i když je jednořádkové. Ne `if x: return`.
- `else:` a `elif:` jsou na **vlastním řádku**, zarovnané pod `if`, ke kterému patří.
- Řádek by neměl být delší než zhruba **80–100 znaků**. Dlouhý řádek rozdělte uvnitř závorky a pokračování odsaďte.
- Funkce a třídy oddělujte **dvěma prázdnými řádky**, logické kroky uvnitř funkce jedním.
- Víc než dva prázdné řádky za sebou nikdy, uvnitř funkce nejvýš jeden.
- Za posledním řádkem kódu je jeden konec řádku (Enter), ale žádné prázdné řádky navíc.

```python
# špatně
if cena > 1000: sleva = 0.1
else: sleva = 0
vysledek = spocitej(cena, sleva, zakaznik, datum, mena, zaokrouhlit=True, dph=21, poznamka="")

# dobře
if cena > 1000:
    sleva = 0.1
else:
    sleva = 0

vysledek = spocitej(
    cena,
    sleva,
    zakaznik,
    datum,
    mena,
    zaokrouhlit=True,
    dph=21,
    poznamka="",
)
```

## Komentáře
- Komentář vysvětluje **proč**, ne **co**. Co dělá řádek `cena = cena * 1.21`, je vidět; že jde o DPH, už ne.
- Pište je tak, aby platily i po změně kódu. Zastaralý komentář je horší než žádný.
- Každá funkce má na začátku krátký popis v trojitých uvozovkách (tzv. docstring): co dělá, co bere a co vrací.
- Komentář za kódem oddělte aspoň dvěma mezerami, za `#` patří jedna mezera. Komentář na samostatném řádku také začíná `# ` s mezerou.

```python
# špatně
#načtení vstupu
sazba = 21 #základní sazba DPH

# dobře
# sazbu mění zákon, proto je v proměnné
sazba = 21  # základní sazba DPH v ČR
```

```python
# špatně: komentář jen opakuje kód
cena = cena * 1.21  # vynásobí cenu 1.21

# dobře: komentář říká, co kód neříká
cena = cena * 1.21  # základní sazba DPH v ČR je 21 %
```

```python
# špatně
def f(c):
    return c * 1.21

# dobře
def pridej_dph(cena: float) -> float:
    """Vrátí cenu navýšenou o základní sazbu DPH."""
    return cena * 1.21
```

## Struktura souboru
- Všechny `import` řádky patří na úplný začátek souboru, každý na vlastní řádek.
- Nejdřív standardní knihovna, pak nainstalované balíky, pak vlastní soubory. Skupiny oddělte prázdným řádkem.
- Jedna funkce dělá jednu věc. Když se nedá popsat jednou větou, je moc velká.

```python
# špatně
import os, json
def nacti(cesta):
    import csv
    ...

# dobře
import csv
import json
import os

import pandas

from moje_pomucky import vycisti_text


def nacti(cesta):
    ...
```

```python
# špatně: jedna funkce dělá všechno
def zpracuj(cesta):
    text = open(cesta).read()
    text = text.lower().strip()
    pocet = text.count("smlouva")
    print(f"Nalezeno: {pocet}")

# dobře: každá funkce jednu věc
def nacti_text(cesta: str) -> str:
    return open(cesta).read()


def vycisti(text: str) -> str:
    return text.lower().strip()


def spocitej_vyskyty(text: str, slovo: str) -> int:
    return text.count(slovo)
```

## Dobré zvyky
- Používejte **typové anotace**: `def secti(a: int, b: int) -> int:`. Nic nekontrolují, ale čtenáři i editoru hodně pomůžou.
- Pro skládání textu používejte f-stringy: `f"Celkem: {cena} Kč"`.
- Porovnání s `None` pište jako `is None`, ne `== None`.
- Nenechávejte v kódu zakomentované zbytky. Co nepotřebujete, smažte.

```python
# špatně
def secti(a, b):
    return a + b
zprava = "Celkem: " + str(cena) + " Kč"
if zakaznik == None:
    ...
# stara_cena = cena * 1.2
# print(stara_cena)

# dobře
def secti(a: int, b: int) -> int:
    return a + b


zprava = f"Celkem: {cena} Kč"
if zakaznik is None:
    ...
```

## Nástroje
Nemusíte si to všechno pamatovat. Nástroj [Ruff](https://docs.astral.sh/ruff/) kód zkontroluje a naformátuje za vás, stačí ho spustit:

```
ruff format soubor.py
ruff check soubor.py
```
