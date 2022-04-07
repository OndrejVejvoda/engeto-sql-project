# Analýza vývoje mezd a cen potravin v ČR

## Cíl Analýzy
Cílem analýzy je připravit datové podklady k porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období

## Vstupní data
Jako vstupní data k vytvoření primární tabulky byly použity datové sady přístupné skrze [otevřená data](https://data.gov.cz/). Konkrétně se jedná o časovou řadu počtu zaměstnanců a průměrných měsíčních mezd (fyzické i přepočtené osoby) podle odvětví od roku 2000 do roku 2021. Dále o časovou řadu statistických údajů o průměrných spotřebitelských cenách vybraného potravinářského zboží za Českou republiku a kraje zjišťované od roku 2006 do roku 2018.

Doplňkové data o countries a economies, které byly použity při tvorbě sekundární tabulky jsou z různých zdrojů. 


## Výstupní data
Data o mzdách a cenách jsou zpracovány v [primární tabulce](https://github.com/OndrejVejvoda/engeto-sql-project/blob/main/primary_table.sql) a sjednocená na totožné porovnatelné období. Doplňující data s ekonomickými ukazately o ČR i ostatních státech jsou zpracované v [sekundární tabulce]().

###  1. Výzkumná otázka
_Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?_

Z porovnání meziročních průměrných mezd za každý rok, zjistíme, že v 24 případech se průměrná roční mzda snížila nebo zůstala stejná. Nejvyšší pokled byl v odvětví Peněžnictví a pojišťovnictví v roce 2013. Níže můžeme vidět prvních pět nevětších meziročních poklesů.
| year | branch |percentage_growth_rate 
| ------------- |:-------------:|:-------------:|
2013 |	Peněžnictví a pojišťovnictví |	91.0
2009 |	Těžba a dobývání |	95.6
2013 |	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu |	95.7
2013 |	Profesní, vědecké a technické činnosti	| 97.2
2013	| Těžba a dobývání	| 97.5

Presto však po výpočtu průměrného tempa růstu mezd za celé období (2006 - 2018), je možné vidět, že ve všech odvětví došlo k růstu průměrných mezd
| branch | average_growth_rate |
| ------------- |:-------------:|
Peněžnictví a pojišťovnictví | 2.57
Ostatní činnosti |	2.98
Těžba a dobývání |	3.4
... | ...
Zpracovatelský průmysl |	4.67
Zemědělství, lesnictví, rybářství |	4.71
Zdravotní a sociální péče |	4.82
