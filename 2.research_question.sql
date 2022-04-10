
#Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

WITH t_prices AS (
	SELECT  
		*
	FROM t_ondrej_vejvoda_project_sql_primary_final t1
	WHERE 1=1
		AND (t1.date_year IN (SELECT MIN(date_year) FROM t_ondrej_vejvoda_project_sql_primary_final)
			OR t1.date_year IN (SELECT MAX(date_year) FROM t_ondrej_vejvoda_project_sql_primary_final))
		AND 
			(t1.name LIKE '%Mléko%' OR t1.name LIKE '%chléb%')
	ORDER BY t1.date_year
	), t_payroll AS (
	SELECT 
		t2.date_year ,
		t2.value_type,
		ROUND(AVG(t2.avg_value ),2) AS avg_payroll,
		t2.unit 
	FROM t_ondrej_vejvoda_project_sql_primary_final t2
	GROUP BY t2.date_year ,t2.value_type 
	HAVING (t2.date_year IN (SELECT MIN(date_year) FROM t_ondrej_vejvoda_project_sql_primary_final)
			OR t2.date_year IN (SELECT MAX(date_year) FROM t_ondrej_vejvoda_project_sql_primary_final))
			AND t2.value_type LIKE "%Mzda%"
	ORDER BY t2.date_year
	)
	SELECT 	
		t1.date_year ,
		t1.name AS food_item,
		CONCAT(t1.avg_value," Kč / ", t1.unit) AS average_price_per_unit,
		CONCAT(t2.avg_payroll, " ",t2.unit) AS average_payroll ,
		ROUND(t2.avg_payroll / avg_value,0 ) AS units_for_avg_payroll,
		t1.unit AS units
	FROM t_prices t1
	LEFT JOIN t_payroll t2	
		ON t1.date_year  = t2.date_year  ;
