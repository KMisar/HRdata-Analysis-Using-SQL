CREATE DATABASE hrdata;
USE Hrdata;
SELECT*FROM EMPLOYEES;
SELECT COUNT(*) AS TOTAL_Employees
FROM employees;
SELECT COUNT(*) AS TOTAL_Old_Employees
FROM employees
WHERE DateofTermination!='';

-- Total Current Employees

SELECT COUNT(*) AS TOTAL_Current_Employees
FROM employees
WHERE DateofTermination='';

-- Average Salary

SELECT AVG(Salary) AS Avg_Salary
FROM employees;

-- Avergae Age

SELECT AVG (TIMESTAMPDIFF(YEAR,STR_TO_DATE(DOB,'%d-%m-%Y'),CURDATE()))
AS Avg_Age
FROM Employees;

--  Average Years in Company

SELECT AVG (TIMESTAMPDIFF(YEAR,STR_TO_DATE(DateofHire,'%d-%m-%Y'),CURDATE()))
AS Avg_Years_in_Company
FROM Employees;

--  Adding new Column for Employee Current Status
ALTER TABLE employees
ADD EmployeeCurrentStatus INT;

-- updatting values for NEW Column

SET SQL_SAFE_UPDATES=0;
UPDATE employees
SET EmployeeCurrentStatus=CASE
  WHEN DateofTermination=''THEN 1
  ELSE 0
  END;
  
  --  Calculate Attrition Rate based on custom EmpStatusID values
  
  SELECT
  (CAST(COUNT(CASE WHEN EmployeeCurrentStatus=0 THEN 1 END) AS FLOAT)/COUNT(*))*100 AS Attrition_Rate
  FROM employees;
  
  -- get Column Names and Data Types
  DESCRIBE Employees;
  
  -- print 1sr 5 rows
  
  SELECT * FROM Employees
LIMIT 5;

-- Print last 5 rows
SELECT * FROM Employees
ORDER BY EmpID DESC
LIMIT 5;

--  Changing data types of salary
ALTER TABLE Employees
MODIFY COLUMN salary DECIMAL (10,2);

--  Convert all data columns in proper dates

UPDATE Employees
SET DOB=STR_TO_DATE(DOB,'%d-%m-%Y');
UPDATE employees
SET DateOFHire=STR_TO_DATE(DateOFHire,'%d-%m-%Y');
UPDATE employees
SET LastperformanceReview_Date=STR_TO_DATE(LastperformanceReview_Date,'%d-%m-%Y');


ALTER TABLE Employees
MODIFY COLUMN DOB DATE,
MODIFY COLUMN DateofHire DATE,
MODIFY COLUMN Lastperformancereview_date DATE;

Describe employees;

UPDATE employees
SET DateofTermination='CurrentlyWorking'
WHERE DateofTermination IS NULL OR DateofTermination='';

-- count of each unique value in the MartialDesc

SELECT MaritalDesc, COUNT(*) AS Count
FROM Employees
GROUP BY MaritalDesc
ORDER BY Count DESC;

SELECT Department, COUNT(*) AS Count
FROM Employees
GROUP BY Department
ORDER BY Count DESC;
SELECT Position, COUNT(*) AS Count
FROM Employees
GROUP BY Position
ORDER BY Count DESC;

SELECT Managername, COUNT(*) AS Count
FROM Employees
GROUP BY Managername
ORDER BY Count DESC;

SELECT
CASE
WHEN Salary<30000 THEN '<30K'
WHEN Salary<30000 AND 49999 THEN'30K-49K'
WHEN Salary<50000 AND 69999 THEN'50K-69K'
WHEN Salary<70000 AND 89999 THEN'70K-48K'
WHEN Salary>=90000 THEN '90K and above'
END AS Salary_Range,
COUNT(*) AS Frequency
FROM Employees GROUP BY Salary_Range ORDER BY Salary_Range;

SELECT 
  PerformanceScore,
  COUNT(*) AS Count
  FROM Employees
  GROUP BY PerformanceScore
  ORDER BY PerformanceScore;
  
SELECT
Department,
AVG(Salary) AS AverageSalary
FROM employees
GROUP BY Department
ORDER BY Department;

SELECT 
TermReason,
COUNT(*) AS Count
FROM employees
WHERE TermReason IS NOT NULL
GROUP BY TermReason
ORDER BY Count DESC;

SELECT
State,
COUNT(*) AS Count
FROM employees
GROUP BY State
ORDER BY Count DESC;

SELECT
Sex,
COUNT(*) AS Count
FROM employees
GROUP BY Sex
ORDER BY Count DESC;

-- Add a new column AGE


ALTER TABLE employees
ADD COlUMN Age INT;

-- UPDATE  the age column with calculated age
UPDATE employees
SET Age=TIMESTAMPDIFF(YEAR,DOB,CURDATE());


-- Age distribution
SELECT
	CASE
	WHEN AGE < 20 THEN '<30K'
	WHEN AGE BETWEEN 20 AND 29 THEN '20-29'
	WHEN AGE BETWEEN 30 AND 39 THEN '30-39'
	WHEN AGE BETWEEN 40 AND 49 THEN '40-49'
	WHEN AGE BETWEEN 50 AND 59 THEN '50-59'
	WHEN AGE >= 60 THEN '60 and above'
   END AS AGE_range,
   COUNT(*) AS COUNT
   FROM employees GROUP BY AGE_range;

SELECT
Department,
SUM(Absences) AS TotalAbsences
FROM employees
GROUP BY Department
ORDER BY TotalAbsences DESC;

SELECT 
Sex,
SUM(Salary) AS TotalSalary
FROM employees
GROUP BY sex
ORDER BY TotalSalary DESC;

SELECT
MaritalDesc,
COUNT(*) AS TerminatedCount
FROM Employees
WHERE Termd=1
GROUP BY Maritaldesc
ORDER BY TerminatedCount DESC;

SELECT
PerformanceScore,
AVG(absences) AS AverageAbsences
FROM Employees
GROUP BY PerformanceScore
ORDER BY PerformanceScore;

SELECT
RecruitmentSource,
COUNT(*) AS EmployeeCount
FROM employees
GROUP BY RecruitmentSource
ORDER BY EmployeeCount DESC;





















