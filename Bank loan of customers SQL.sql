SELECT * FROM bank_portfolio.finance_1;
SELECT * FROM bank_portfolio.finance_2csv;

--- 1st KPI: Year wise Loan amount stats

SELECT 
	year(str_to_date(issue_d, '%d-%m-%Y')) AS year, 
    sum(loan_amnt) as Loan_Amount
FROM 
	bank_portfolio.finance_1
GROUP BY
	year;

--- 2nd KPI: Grade and sub grade wise revol_bal

SELECT 
	t1.grade, 
	t1.sub_grade,
	sum(t2.revol_bal) as Total_Revol_Bal
FROM
	bank_portfolio.finance_1 as t1
JOIN
	bank_portfolio.finance_2csv as t2
ON
	t1.id = t2.id 
GROUP BY
    t1.grade,
    t1.sub_grade;
	

--- 3r KPI: Total Payment for Verified Status Vs Total Payment for Non Verified Status

SELECT
	t1.verification_status,
	SUM(t2.total_pymnt) as Total_Pymnt_amnt
FROM 
	bank_portfolio.finance_1 as t1
JOIN
	bank_portfolio.finance_2csv as t2
ON 
	t1.id = t2.id
GROUP BY
	t1.verification_status;
    
--- 4th KPI: State wise and Month wise Loan Status

SELECT
	monthname(str_to_date(issue_d,'%d-%m-%Y')) as Month,
    addr_state,
    count(loan_status) as No_of_loans_status
FROM
	bank_portfolio.finance_1
GROUP BY
	addr_state,
    Month;
    
--- 5th KPI: Home ownership Vs last payment date stats

SELECT
	t1.home_ownership,
    count(t2.last_pymnt_d) as No_of_Last_Pymnt_d
FROM 
	bank_portfolio.finance_1 as t1
JOIN 
	bank_portfolio.finance_2csv as t2
ON 
	t1.id = t2.id
GROUP BY
	t1.home_ownership;

