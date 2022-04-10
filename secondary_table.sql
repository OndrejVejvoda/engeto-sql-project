CREATE OR REPLACE TABLE t_ondrej_vejvoda_project_SQL_secondary_final
SELECT DISTINCT 
	c. country ,
	e.`year` , 
	ROUND(e.GDP) AS gdp,
	e.taxes,
	e.gini 
FROM countries c
LEFT JOIN economies e 
	ON c.country = e.country 
 	AND e.`year`  BETWEEN 2006 AND 2018
ORDER BY c.country ,e.`year` 
;