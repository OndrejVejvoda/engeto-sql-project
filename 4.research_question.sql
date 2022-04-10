
# Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH temp_payroll AS (
	SELECT 
		t.date_year ,
		AVG(t.avg_value) AS avg_payroll_by_year  ,
		LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year) AS avg_prev_year,
		((AVG(t.avg_value)-LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year))/LAG(AVG(t.avg_value)) OVER (PARTITION BY t.name ORDER BY t.date_year))* 100 AS payroll_pct_change
	FROM t_ondrej_vejvoda_project_sql_primary_final as t
	WHERE t.value_type = "Průměrná hrubá mzda na zaměstnance" 
	GROUP BY t.date_year 
	ORDER  BY t.date_year 
	), temp_price AS (
	SELECT 
		t.date_year ,
		t.name ,
		t.avg_value AS avg_price,
		LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year) AS avg_price_prev_year,
		((t.avg_value-LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year))/LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year))*100 AS price_pct_change
	FROM t_ondrej_vejvoda_project_sql_primary_final t 
 	WHERE t.value_type = "Průměrné spotřebitelské ceny"
	)
	SELECT 
 		t1.date_year,
 		t1.name,
 		ROUND(t1.price_pct_change,2) AS price_pct_change,
 		ROUND(t2.payroll_pct_change,2) AS payroll_pct_change,
 		ROUND(t1.price_pct_change - t2.payroll_pct_change,2) AS diff
	FROM temp_price AS t1
	LEFT JOIN temp_payroll AS t2
		ON t1.date_year = t2.date_year
 	WHERE t1.avg_price_prev_year IS NOT NULL
 		AND ROUND(t1.price_pct_change - t2.payroll_pct_change,2) > 10
 	ORDER BY t1.name, t1.date_year;