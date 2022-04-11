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

Z [porovnání meziročních průměrných mezd](https://github.com/OndrejVejvoda/engeto-sql-project/blob/main/1.research_question.sql) za každý rok, zjistíme, že v 24 případech se průměrná roční mzda snížila nebo zůstala stejná. Nejvyšší pokles byl v odvětví Peněžnictví a pojišťovnictví v roce 2013. Níže můžeme vidět prvních pět nevětších meziročních poklesů.
| year | branch |relative_growth_rate 
| ------------- |:-------------:|:-------------:|
2013 |	Peněžnictví a pojišťovnictví |	-9
2009 |	Těžba a dobývání |	-4.36
2013 |	Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu |	-4.29
2013 |	Profesní, vědecké a technické činnosti	| -2.78
2013	| Těžba a dobývání	| -2.47

Přesto však po výpočtu průměrného tempa růstu mezd za celé období (2006 - 2018), je možné vidět, že průměrné mzdy ve všech odvětvích rostly průměrným meziročním tempem mezi 2 a 5 %. Níže jsou zobrazeny tři odvětví s nejnižším tempem růstu a tři odvětví s největším tempem růstu.
| branch | average_growth_rate |
| ------------- |:-------------:|
Peněžnictví a pojišťovnictví | 2.57
Ostatní činnosti |	2.98
Těžba a dobývání |	3.42
... | ...
Zpracovatelský průmysl |	4.67
Zemědělství, lesnictví, rybářství |	4.71
Zdravotní a sociální péče |	4.82

###  2. Výzkumná otázka
_Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?_

Níže zobrazeny výsledky [výpočtů](https://github.com/OndrejVejvoda/engeto-sql-project/blob/main/2.research_question.sql), podle kterých vidíme, že za průměrnou mzdu bylo možné koupit 1262 kg chleba v roce 2006 a v roce 2018 to činilo 1319 kg chleba.
Mléka bylo za průměrnou mzdu v daném roce možné koupt 1409 l v roce 2006 a 1614 l v roce 2018.

| year | food_item | average_price_per_unit | average_payroll | units_for_avg_payroll | unit
| ------------- |:-------------:|:-------------:| :-------------:| :-------------:| :-------------:|
2006 |	Chléb konzumní kmínový |	16.12 Kč / 1kg |	20 342.38 Kč	| 1262.0 |	1kg
2006 |	Mléko polotučné pasterované |	14.44 Kč / 1l |	20 342.38 Kč |	1409.0 |	1l
2018 |	Chléb konzumní kmínový |	24.24 Kč / 1kg	| 31 980.26 Kč	| 1319.0 |	1kg
2018 |	Mléko polotučné pasterované |	19.82 Kč / 1l |	31 980.26 Kč |	1614.0 |	1l

###  3. Výzkumná otázka

_Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?_

Po výpočtu [průměrného růstu cen jednotlivých kategorií potravin](https://github.com/OndrejVejvoda/engeto-sql-project/blob/main/3.research_question.sql), je zřejmé, že nejpomalejší růst cen byl ve sledovaném období (2006 - 2018) u cukru krystalového. Cena cukru dokonce za sledované období klesala v průměru o 2,65 %.

###  4. Výzkumná otázka

_Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?_

Po [porovnání meziročních změn cen potravin a průměrných mezd](https://github.com/OndrejVejvoda/engeto-sql-project/blob/main/4.research_question.sql) zjistíme, že meziroční nárůst cen potravin vyšší než 10 % oproti růstu mezd bylo možné sledovat v 37 případech. 

###  5. Výzkumná otázka

_Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?_
