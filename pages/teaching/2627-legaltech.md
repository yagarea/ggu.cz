---
title: "Legal Tech I: Automatizace právní práce"
subtitle: "HDPV0226 - 2026/2027"
layout: display-page
permalink: /legaltech2627/
lang: cs
---

## Úvod

{% splitter %}
### Informace
- Kdy: _Úterý, 10:00_
- Kde: _PF, místnost 120_
- Kód předmětu: _`HDPV0226` [[SIS](https://is.cuni.cz/studium/predmety/index.php?do=predmet&kod=HDPV0226)]_
- Konzultační hodiny: _Čtvrtek dopoledne, po domluvě_
- Kredity: _4_

### Užitečné odkazy
- [Konvence psaní Python kódu](/python-conventions/)
- [Jak používat debugger ve VS Codium](https://www.youtube.com/watch?v=iHVpl9sZKGw)
- [Hezké vysvětlení složitosti na KSP encyklopedii](https://ksp.mff.cuni.cz/encyklopedie/slozitost/)

---

### Vyučující
- [**Honza Černý**](https://blackblog.cz/)
  - E-mail: [cerny@matfyz.cz](mailto:cerny@matfyz.cz)
  - Discord: [@honzacerny](https://discordapp.com/users/755526719867453521)
  - *Pokud máte rádi nějakého méně známého hudebního interpreta, budu moc rád, když mi pošlete tip. Nezáleží na žánru.*
- [**Tom Knap**](https://prf.cuni.cz/detail-cloveka/100033429190)
  - E-mail: [tomas.knap@prf.cuni.cz](mailto:tomas.knap@prf.cuni.cz)
  - Discord: [@tomjk](https://discordapp.com/users/440846866825871361)
{% endsplitter %}

## Probraná látka
Zde bude postupně přibývat probraná látka.

| Datum   | Obsah                                                             | Slidy |
|---------|-------------------------------------------------------------------|-------|
| 29. 09. | Úvod, organizace předmětu, motivace, teoretický úvod do výpočetní technologie, filosofie programovacích jazyků, setup potřebného softwaru | [PDF](https://jc.ggu.cz/lt/1.pdf) |
| 06. 10. | Základní python syntaxe, komentáře, proměnné, základní datové typy, podmínky, while cyklus, typové anotace, obecné konvence | [PDF](https://jc.ggu.cz/lt/2.pdf) |
| 13. 10. | Postupy při řešení úkolů, datové struktury: list, tuple, set, frozenset, dict, for cyklus, continue, break | [PDF](https://jc.ggu.cz/lt/3.pdf) |
| 20. 10. | Funkce, lifetime, syntax pro práci s knihovnami, připomenutí matematiky, koncept časové složitosti, vnitřní pricipy fungování pole, spojového seznamu, množiny a slovníku, P vs PN | [PDF](https://jc.ggu.cz/lt/4.pdf) |
| 27. 10. | Datové formáty a práce se soubory | [PDF](https://jc.ggu.cz/lt/5.pdf) |
| 03. 11. | **Test** ([vzorové otázky](https://jc.ggu.cz/lt/vzorak1.pdf), [vzorové otázky s řešením](https://jc.ggu.cz/lt/vzorak1-reseni.pdf)) | - |
| 10. 11. | *Týden fakulty* | - |
| 17. 11. | *Státní svátek* | - |
| 24. 11. | | |
| 01. 12. | | |
| 08. 12. | | |
| 15. 12. | **Test** | |


## Pravidla
1. **"Don't be a dick"**
    - Jednej podle svého nejlepšího vědomí a svědomí
    - Vlastním citem odhadni, jestli to, co děláš, je OK, a případně se zeptej
2. **Můžeš používat AI nástroje na vše kromě přímého řešení úloh**
    - Nikdy do AI nástroje nekopíruj zadání úlohy
    - Nikdy nenech AI nástroj řešit úlohu přímo
    - Používej ho na vysvětlení problému, doptání se na nejasnosti atd.
    - Cílem je naučit se něco sám a úkoly jsou k tomu prostředek
    - Odevzdaný kód bude kontrolován nástroji na detekci plagiátorství a AI generovaného kódu
3. **Úkoly se řeší samostatně**
    - Můžete se ptát vyučujících na sově
    - Nesdílejte řešení, ale můžete se o něm bavit, aniž byste ho přímo prozradili
4. **Technikálie**
    - Textové soubory odevzdávejte v [UTF-8](https://en.wikipedia.org/wiki/UTF-8)
    - Pythonní skripty odevzdávejte jako `.py` soubory
    - Dodržujte všechny konvence, které jsou na přednáškách představeny

## Úspěšné zakončení předmětu
Pro úspěšné dokončení předmětu student musí:
- Získat alespoň 90 bodů z domácích úkolů (celkem jich lze získat 100)
- Úspěšně projít všemi zápočtovými testy
- Složit písemnou zkoušku
    - Známkování:
        - **1** - 100-90 %
        - **2** - 89-75 %
        - **3** - 74-60 %
        - **4** - 59-0 %

## Materiály
- Návody
  - [Parsování vstupu v Pythonu 3](https://ksp.mff.cuni.cz/encyklopedie/parsovani-vstupu-python/)
  - [Jak psát dokumentaci](https://ksvi.mff.cuni.cz/%7Ekryl/dokumentace.htm)
- Učebnice programování
  - [Průvodce labyrintem algoritmů](https://pruvodce.ucw.cz/) - velmi doporučeno
  - [KSP Encyklopedie](https://ksp.mff.cuni.cz/encyklopedie/)
  - [Ponořme se do Python(u) 3](https://knihy.nic.cz/cs/detail/3/)
- Zdroje softwaru
  - [VSCodium](https://vscodium.com)
  - [Python official website](https://www.python.org/)
  - [uv](https://docs.astral.sh/uv/)
  - [IDE pro demonstrace na přednáškách](https://www.onlineide.pro/playground/python)
- Dokumentace knihoven
  - [NumPy](https://numpy.org/doc/stable/)
  - [Pandas](https://pandas.pydata.org/docs/)
  - [Matplotlib](https://matplotlib.org/stable/index.html)
- Záznamy jiných přednášek
  - [Programátoři versus realita (Martin "Medvěd" Mareš, Smršť 2024)](https://youtu.be/c4OuPMK_5n0)
  - [WAT](https://www.destroyallsoftware.com/talks/wat) - video primárně o dynamickém typování, po kterém budete vděční za python

