
# Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

WITH t_gdp AS (
	SELECT 
		gdp.country ,
		gdp.`year` AS date_year,
		gdp.gdp ,
		LAG(gdp.gdp) OVER (ORDER BY gdp.year) AS gdp_prev_year,
		(gdp.gdp - LAG(gdp.gdp) OVER (ORDER BY gdp.year)) / LAG(gdp.gdp) OVER (ORDER BY gdp.year) * 100 AS pct_gdp_change
	FROM t_ondrej_vejvoda_project_sql_secondary_final gdp
	WHERE gdp.country = 'Czech Republic'
	),temp_payroll AS (
	SELECT 
		t.date_year ,
		AVG(t.avg_value) AS avg_payroll_by_year  ,
		LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year) AS avg_prev_year,
		((AVG(t.avg_value)-LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year))/LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year))* 100 AS pct_payroll_change
	FROM t_ondrej_vejvoda_project_sql_primary_final as t
	WHERE t.value_type = "Průměrná hrubá mzda na zaměstnance" 
	GROUP BY t.date_year 
	ORDER  BY t.date_year 
	), temp_price AS (
	SELECT 
		t.date_year ,
		AVG(t.avg_value) AS avg_price,
		LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year) AS avg_price_prev_year,
		((AVG(t.avg_value)-LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year))/LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year))*100 AS pct_price_change
	FROM t_ondrej_vejvoda_project_sql_primary_final t 
 	WHERE t.value_type = "Průměrné spotřebitelské ceny"
 	GROUP BY t.date_year
 	)
	SELECT
		t_gdp.date_year, ROUND(t_gdp.pct_gdp_change,2) AS pct_gdp_change,
		ROUND(t_payroll.pct_payroll_change,2) AS pct_payroll_change,
		ROUND(t_price.pct_price_change,2) AS pct_price_change
	FROM t_gdp
	LEFT JOIN temp_payroll AS t_payroll 
		ON t_gdp.date_year = t_payroll.date_year
	LEFT JOIN temp_price AS t_price 
		ON t_gdp.date_year = t_price.date_year
	;

