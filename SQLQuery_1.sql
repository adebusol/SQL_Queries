---drop database employees_db 
--schema: table and its columns(attributes)
CREATE DATABASE employees_db
CREATE DATABASE busola
CREATE DATABASE library
drop database busola
drop database library

SELECT * FROM employees 

--1.) Display the minimum salary.
SELECT MIN(salary)  FROM employees
--2.) Display the highest salary.
SELECT MAX(salary)  FROM employees
--3.) Display the total salary of all employees.
SELECT SUM(salary) FROM employees
 --4.) Display the average salary of all employees.
 SELECT AVG(salary) FROM employees
--5.) Issue a query to count the number of row in the employee table. The result should be just one row.
SELECT COUNT (*) FROM employees
--6.) Issue a query to count the number of employees that make commission. The result should be just one row.
SELECT count (commission_pct) FROM employees

--7.) Issue a query to count the number of employees’ first name column. The result should be just one row.
SELECT COUNT(first_name) FROM employees
--8.) Display all employees that make less than Peter Hall.
SELECT first_name, last_name, salary FROM employees
WHERE salary < 
(SELECT salary FROM employees WHERE first_name = 'Peter' and last_name = 'Hall')
--9.) Display all the employees in the same department as Lisa Ozer
SELECT first_name, last_name, department_id FROM employees WHERE department_id =
(SELECT department_id FROM employees WHERE first_name = 'Lisa' and last_name= 'Ozer')

--10.) Display all the employees in the same department as Martha Sullivan and that make more than TJ Olson.
SELECT first_name, last_name, salary, department_id FROM employees WHERE department_id =
(SELECT department_id FROM employees WHERE first_name = 'Martha' and last_name = 'Sullivan') and salary >
(SELECT salary FROM employees WHERE first_name = 'TJ' and last_name = 'Olson')

--11.) Display all the departments that exist in the departments table that are not in the employees table. Do not use a where clause


SELECT department_id FROM departments
EXCEPT 
SELECT DISTINCT(department_id) FROM employees 

--WHERE department_id NOT IN
--(SELECT department_id FROM employees WHERE department_id = department_id)

--12.) Display all the departments that exist in department tables that are also in the employees table. Do not use a where clause.
SELECT department_id FROM departments
INTERSECT
SELECT DISTINCT(department_id) FROM employees 
--13.) Display all the departments name, street address, postal code, city and state of each department. Use the departments and locations table for this query.
SELECT * FROM departments
SELECT * FROM locations

SELECT departments.department_name, locations.street_address, locations.postal_code, locations.city, 
locations.state_province FROM departments JOIN locations ON departments.location_id = locations.location_id

--14.) Display the first name and salary of all the employees in the Accounting departments. 
SELECT * from departments
SELECT first_name from employees where department_id = 110

SELECT employees.department_id, employees.first_name, departments.department_name, departments.department_id FROM employees 
JOIN departments  ON employees.department_id = departments.department_id
WHERE departments.department_name = 'accounting'

--15.) Display all the last name of all the employees whose department location id are 1700 and 1800.
SELECT employees.department_id, employees.last_name, departments.department_id, departments.location_id FROM employees 
JOIN departments  ON employees.department_id = departments.department_id
WHERE departments.location_id = 1700 or departments.location_id = 1800

AND departments.location_id = 1700 or departments.location_id = 1800

--why couldn't i use this?
--WHERE B.location_id = 1700 and 1800 or B.location_id = 1700 or B.location_id = 1800

--16.) Display the phone number of all the employees in the Marketing department.
SELECT * FROM employees

SELECT employees.department_id, employees.first_name, employees.last_name, employees.phone_number, departments.department_name, departments.department_id 
FROM employees 
JOIN departments ON employees.department_id = departments.department_id
WHERE departments.department_name = 'marketing'

--17.) Display all the employees in the Shipping and Marketing departments who make more than 3100.
SELECT employees.department_id, employees.first_name, employees.last_name,employees.salary, departments.department_name, departments.department_id 
FROM employees 
JOIN departments  ON employees.department_id = departments.department_id
WHERE departments.department_name = 'marketing' or departments.department_name = 'shipping'
and salary >3100
ORDER BY salary

--18.) Display the last name and salary of the employees that makes the least in each department. 

SELECT MIN(employees.salary), departments.department_name, MIN(last_name)
FROM employees 
JOIN departments  ON employees.department_id = departments.department_id
GROUP BY  department_name

SELECT MIN(employees.salary), departments.department_name, MIN(last_name)
FROM employees 
LEFT JOIN departments  ON employees.department_id = departments.department_id
GROUP BY  department_name

--19.) Display all the employees who were hired before Tayler Fox
SELECT first_name, last_name, hire_date FROM employees WHERE first_name = 'Tayler'

SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date <
(SELECT hire_date FROM employees WHERE first_name = 'Tayler' and last_name = 'Fox')
ORDER BY hire_date desc

--20.) Display names and salary of the employees in executive department. 
SELECT first_name, last_name, salary FROM employees 

SELECT * FROM departments

SELECT employees.department_id, employees.first_name, employees.last_name,employees.salary, departments.department_name, departments.department_id 
FROM employees 
JOIN departments ON employees.department_id = departments.department_id
WHERE departments.department_name = 'executive' 

--21.) Display the employees whose job ID is the same as that of employee 141
SELECT first_name, last_name, Job_id FROM employees
WHERE job_id =
(SELECT job_id FROM employees WHERE employee_id = 141)

--22.) For each employee, display the employee number, last name, 
--salary, and salary increased by 15% and expressed as a whole number. Label the column New Salary.
SELECT employee_id, last_name, salary, (salary*1.15) as new_salary FROM employees

--23.) Find the employees who earn the same salary as the minimum salary for each department 
select * from employees

SELECT first_name, last_name, department_id, salary FROM employees WHERE salary IN
(SELECT min(salary) FROM employees  GROUP BY department_id)



--24.) Display all the employees and their salaries that make more than Abel.
SELECT first_name, last_name, salary FROM employees WHERE salary >
(SELECT salary FROM employees WHERE last_name = 'Abel')

--25.) Create a query that displays the employees’ last names and commission amounts.
-- If an employee does not earn commission, put “no commission”. Lable the column COMM. 
SELECT last_name, commission_pct, 
CASE   
      when commission_pct is null THEN 'no commission'
      else convert(char,commission_pct)
    END as COMM
FROM employees

SELECT last_name, commission_pct, isnull(CONVERT(char, commission_pct), 'no commission') as COMM
FROM employees

--26.) Create a unique listing of all jobs that are in department 80. Include the location of department in the output.
select * from employees
select * from departments
select * from locations
select * from job_history

SELECT distinct(employees.department_id),employees.job_id, locations.location_id, locations.city, locations.state_province,departments.department_id, departments.department_name,departments.location_id 
FROM employees
JOIN departments  ON employees.department_id = departments.department_id
JOIN locations ON locations.location_id = departments.location_id
WHERE departments.department_id = 80

--27.) Write a query to display the employee last name, department name, location ID, and city of all employees who earn a commission
SELECT employees.last_name,employees.department_id, employees.commission_pct,locations.location_id, locations.city,departments.department_id, departments.department_name,departments.location_id 
FROM employees
JOIN departments  ON employees.department_id = departments.department_id
JOIN locations ON locations.location_id = departments.location_id
WHERE employees.commission_pct IS NOT NULL

--28.) Create a query to display the name and hire date of any employee hired after employee Davies.
SELECT last_name, hire_date FROM employees WHERE hire_date >
(SELECT hire_date FROM employees WHERE last_name = 'Davies')

--29.) Determine the validity of the following three statements. Circle either True or False. 
--Group functions work across many rows to produce one result per group.True/--False 
--Group functions include nulls in calculations. True/--False
--WHERE clause restricts rows prior to inclusion in a group calculation . True/False
--30.) Display the highest, lowest, sum, and average salary of all employees. 
--Label the columns Maximum, Minimum, Sum, and Average, respectively. 
--Round your results to the nearest whole number.
SELECT round(max(salary),0) as Maximum, round(min(salary),0) as Minimum, round(sum(salary),0) as Sum, round(AVG(salary),0) as Average
FROM employees

--31.) Display the highest, lowest, sum, and average salary of all employees. 
--Label the columns MAXIMUM, MINIMUM, SUM and AVERAGE, respectively. Round up the result to the nearest whole number.

--32.) Display the MINIMUM, MAXIMUM, SUM AND AVERAGE salary of each job type. 

SELECT MIN(salary) as MINIMUM, MAX(salary) as MAXIMUM, SUM(salary) as SUM, AVG(salary) as AVERAGE, job_id
FROM employees
GROUP BY job_id
--33.) Display all the employees and their managers from the employees table.
SELECT distinct(manager_id) FROM employees
SELECT * FROM employees

SELECT mgr.manager_id, mgr.last_name as Manager_name,emp.last_name as employee_name, emp.employee_id
FROM employees emp JOIN employees mgr ON emp.employee_id = mgr.manager_id

--34.) Determine the number of manager without listing them. Label the column NUMBER of manager.
-- Hint: use manger_id column to determine the number of managers.
SELECT COUNT(DISTINCT(manager_id)) as NUMBER_of_Managers FROM employees 

--35.) Write a query that displays the difference between the HIGHEST AND LOWEST salaries. Label the column DIFFERENCE.
SELECT MAX(salary) - MIN(salary) as Difference FROM employees 

--36.) Display the sum salary of all employees in each department.
SELECT SUM(salary) as SUM, department_id
FROM employees
GROUP BY department_id
--37.) Write a query to display each department's name, location, number of employees, and the average salary of employees in the department.
-- Label the column NAME, LOCATION, NUMBER OF PEOPLE, respectively.
SELECT departments.department_name,departments.location_id, COUNT(employees.employee_id) as Number_of_People, AVG(employees.salary) as AVERAGE
FROM employees
JOIN departments ON employees.department_id = departments.department_id
GROUP BY departments.department_name,departments.location_id

--38.) Write a query to display the last name and hire date of employee in the same department as Zlotkey. Exclude Zlotkey.
SELECT last_name, hire_date, department_id FROM employees WHERE last_name IN
(SELECT last_name FROM employees WHERE last_name NOT IN ('Zlotkey') and department_id = 80)

--39.) Create a query to display the employee number and last name of all employees who earns more than the average salary. 
--Sort the result in ascending order of salary.
SELECT employee_id, last_name, salary FROM employees WHERE salary >
(SELECT AVG(SALARY) FROM EMPlOYEES)
ORDER BY salary
--40.) Write a query that displays the employee number and last names of all employees who work in
-- a department with any employees whose last name contains a letter U.
SELECT employee_id, last_name, department_id FROM employees WHERE last_name LIKE '%u%'

--41.) Display the last name, department number and job id of all employees whose department location ID is 1700
SELECT * FROM employees

SELECT employees.last_name,employees.department_id, employees.job_id,locations.location_id,
departments.department_id, departments.department_name,departments.location_id 
FROM employees
JOIN departments  ON employees.department_id = departments.department_id
JOIN locations ON locations.location_id = departments.location_id
WHERE locations.location_id = 1700
--42.) Display the last name and salary of every employee who reports to king.

--43.) Display the department number, last name, job ID of every employee in Executive department.
SELECT employees.department_id, employees.first_name, employees.job_id, employees.last_name,employees.salary, departments.department_name, departments.department_id 
FROM employees 
JOIN departments ON employees.department_id = departments.department_id
WHERE departments.department_name = 'executive' 
--44.) Display all last name, their department name and id from employees and department tables.
SELECT employees.department_id, employees.last_name, departments.department_name, departments.department_id 
FROM employees 
JOIN departments ON employees.department_id = departments.department_id
--45.) Display all the last name department name, id and location from employees, department and locations tables.
SELECT employees.last_name,employees.department_id, employees.job_id,locations.location_id,
departments.department_id, departments.department_name,departments.location_id 
FROM employees
JOIN departments  ON employees.department_id = departments.department_id
JOIN locations ON locations.location_id = departments.location_id
--46.) Display the names and hire dates for all employees who were hired before their managers,
--along with their manager’s names and hire dates. Label the columns Employee, Emp Hired, Manager, and Mgr Hired, respectively.
SELECT mgr.manager_id, mgr.last_name as Manager, mgr.hire_date as mgr_hired,emp.hire_date as emp_hired, emp.last_name as employee, emp.employee_id
FROM employees emp JOIN employees mgr ON emp.employee_id = mgr.manager_id
WHERE emp.hire_date < mgr.hire_date 

--47.) Write a query to determine who earns more than Mr. Tobias:
SELECT last_name, salary FROM employees WHERE salary >
(SELECT salary FROM employees WHERE last_name = 'Tobias')
--48.) Write a query to determine who earns more than Mr. Taylor:
SELECT last_name, salary FROM employees WHERE salary >
(SELECT salary FROM employees WHERE last_name = 'Taylor')
--49.) Find the job with the highest average salary.
SELECT  AVG(salary),job_id FROM employees
GROUP BY job_id
ORDER BY AVG(salary) desc
--50.) Find the employees that make more than Taylor and are in department 80. 
SELECT last_name, salary, department_id FROM employees WHERE salary >
(SELECT salary FROM employees WHERE last_name = 'Taylor' and department_id = 80)