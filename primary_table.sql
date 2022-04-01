CREATE OR REPLACE TABLE t_ondrej_vejvoda_project_sql_primary_final AS	
	WITH payroll_temp AS (
		SELECT
			cp.payroll_year ,
			cpib.name AS name,
			cvt.name AS value_type,
			Avg(cp.value) AS avg_payroll_value,
			cpu.name AS unit
		FROM czechia_payroll cp
		LEFT JOIN czechia_payroll_industry_branch cpib 
			ON cp.industry_branch_code = cpib.code 
		LEFT JOIN czechia_payroll_unit cpu
			ON cp.unit_code = cpu.code 
		LEFT JOIN czechia_payroll_value_type cvt 
			ON cp.value_type_code = cvt.code
		WHERE 1=1
			AND cp.value_type_code = 5958 
			AND cp.calculation_code = 100
			AND cp.industry_branch_code IS NOT NULL 
		GROUP BY cp.payroll_year, cpib.name
		ORDER  BY cp.payroll_year , cpib.name 
		), 
		price_temp AS (
			SELECT
 			YEAR(cp.date_from) AS date_year, 
 			cpc.name AS name,
 			ROUND(AVG(cp.value),2) AS avg_price_value,
			CONCAT(cpc.price_value,cpc.price_unit) AS unit 
		FROM czechia_price cp 
		LEFT JOIN czechia_price_category cpc 
			ON cp.category_code = cpc.code 
		GROUP BY YEAR(cp.date_from), cpc.name
		)
	SELECT
		payroll_temp.payroll_year AS date_year,
		payroll_temp.name AS name,
		payroll_temp.value_type ,
		ROUND(AVG(payroll_temp.avg_payroll_value),2) AS avg_value,
		payroll_temp.unit
	FROM payroll_temp 
	GROUP BY payroll_temp.payroll_year,payroll_temp.name 
	HAVING payroll_temp.payroll_year BETWEEN 2006 AND 2018
	UNION 
	SELECT 
		price_temp.date_year  ,
		price_temp.name,
		"Průměrné spotřebitelské ceny" AS value_type,
		ROUND(price_temp.avg_price_value ,2) AS avg_value,
		price_temp.unit 
	FROM price_temp
	GROUP BY price_temp.date_year, price_temp.name;
