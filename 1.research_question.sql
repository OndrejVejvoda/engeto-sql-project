
#Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH temp AS (
	SELECT 
		t.date_year ,
		t.name ,
		t.avg_value ,
		LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year) AS avg_previous_year ,
		avg_value/LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year) AS growth_rate
	FROM t_ondrej_vejvoda_project_sql_primary_final as t
	WHERE t.value_type = "Průměrná hrubá mzda na zaměstnance" 
	)
	SELECT 
		temp.date_year,
		temp.name AS branch,
		ROUND((temp.growth_rate - 1) * 100,2) AS relative_growth_rate
	FROM temp
 	WHERE temp.growth_rate IS NOT NULL 
  		AND temp.growth_rate <= 1
    ORDER BY relative_growth_rate, temp.date_year, temp.name  ;
   
WITH temp AS (
	SELECT 
		t.date_year ,
		t.name ,
		t.avg_value ,
		LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year) AS avg_previous_year ,
		avg_value/LAG(t.avg_value) OVER (PARTITION BY t.name ORDER BY t.date_year) AS growth_rate,
		t.unit 
	FROM t_ondrej_vejvoda_project_sql_primary_final as t
	WHERE t.value_type = "Průměrná hrubá mzda na zaměstnance" 
	)
	SELECT 
		temp.name AS branch,
		ROUND(EXP( AVG( LOG( temp.growth_rate ) ) )*100 - 100,2) AS average_growth_rate
	FROM temp
 	WHERE temp.growth_rate IS NOT NULL
 	GROUP BY temp.name
	ORDER BY average_growth_rate ;