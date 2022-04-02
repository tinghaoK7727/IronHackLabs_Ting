# Breakdown between Male and Female employees from1900

SELECT count(tde.emp_no) as N_employees,
tes.gender, year(tde.from_date) as year_
FROM t_employees tes
JOIN t_dept_emp tde
ON tde.emp_no = tes.emp_no
WHERE year(tde.from_date) >= "1990"
GROUP BY year_, tes.gender
ORDER BY year_;

# Male and Female managers from each department each year, from 1990

SELECT t_dept_manager.emp_no, t_dept_manager.dept_no, 
t_dept_manager.from_date, t_employees.gender, t_departments.dept_name
FROM t_employees
JOIN t_dept_manager
ON t_employees.emp_no = t_dept_manager.emp_no
JOIN t_departments
ON t_dept_manager.dept_no = t_departments.dept_no
WHERE year(t_dept_manager.from_date) >= "1990";

# Compare average salary F vs M until 2002

SELECT t_salaries.salary, t_salaries.emp_no, t_employees.gender, 
year(t_salaries.from_date)
FROM t_salaries
JOIN t_employees
ON t_salaries.emp_no = t_employees.emp_no;

# Procedure creation

DROP PROCEDURE IF EXISTS avg_salary;
DELIMITER $$
CREATE PROCEDURE avg_salary (IN min_salary FLOAT, IN max_salary FLOAT)
BEGIN
SELECT t_departments.dept_name, t_employees.gender, AVG(t_salaries.salary) AS average_salary
FROM t_salaries
JOIN t_employees ON t_salaries.emp_no = t_employees.emp_no
JOIN t_dept_emp ON t_employees.emp_no = t_dept_emp.emp_no
JOIN t_departments ON t_dept_emp.dept_no = t_departments.dept_no
WHERE t_salaries.salary BETWEEN min_salary AND max_salary
GROUP BY t_departments.dept_name, t_employees.gender;
END $$
DELIMITER ;

CALL avg_salary(50000, 70000);
