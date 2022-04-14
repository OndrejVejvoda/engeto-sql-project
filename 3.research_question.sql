
#Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

WITH temp AS (
	SELECT 
		t.date_year ,
		t.name ,
		t.avg_value AS avg_price,
		LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year) AS avg_price_previus_year,
		t.avg_value / LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year) AS growth_rate
	FROM t_ondrej_vejvoda_project_sql_primary_final t 
 	WHERE t.value_type = "Průměrné spotřebitelské ceny"
	)
	SELECT
		temp.name ,
 		ROUND(EXP( AVG( LOG( temp.growth_rate ) ) )*100 -100,3) AS average_growth_rate
	FROM temp
	WHERE temp.avg_price_previus_year IS NOT NULL 
 	GROUP BY temp.name
 	ORDER BY average_growth_rate
 	;