USE employees_mod;

# procedure: average salary
DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
SELECT AVG(salary) FROM t_salaries
GROUP BY emp_no;
END $$
DELIMITER ;

CALL avg_salary();

# emp_info
DELIMITER $$
CREATE PROCEDURE emp_info(IN first_name VARCHAR(30), IN last_name VARCHAR(30))
BEGIN
SELECT emp_no
FROM t_employees emp
WHERE emp.first_name = first_name AND emp.last_name = last_name;
END $$
DELIMITER ;

CALL emp_info('Mary', 'Sluis');

# Create function emp_info
DELIMITER $$
CREATE FUNCTION emp_info (first_name VARCHAR (30), last_name VARCHAR (30))
RETURNS DECIMAL (10,2) DETERMINISTIC

BEGIN
DECLARE v_max_from_date DATE;
DECLARE v_salary DECIMAL(10,2);

SELECT max(from_date) INTO v_max_from_date 
FROM t_employees emp 
JOIN t_salaries sal
ON sal.emp_no=emp.emp_no

WHERE emp.first_name = first_name and emp.last_name = last_name;
SELECT sal.salary INTO v_salary
FROM t_employees emp
JOIN t_salaries sal
ON sal.emp_no=emp.emp_no
WHERE emp.first_name=first_name AND emp.last_name=last_name AND sal.from_date = v_max_from_date;
RETURN v_salary; 
END$$ 
DELIMITER ;

SELECT emp_info('Mary', 'Sluis');

# Trigger checking hire date
DROP TRIGGER if exists hire_date_check;
DELIMITER $$
CREATE TRIGGER hire_date_check
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN 
IF NEW.hire_date > DATE_FORMAT(SYSDATE(), '%Y-%m-%d') THEN
SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%Y-%m-%d');
END IF;
END $$
DELIMITER ;

INSERT INTO t_employees 
VALUES ('999999', '1988-07-07', 'Ting', 'K', 'M', '2077-07-07');
select * from t_employees
where emp_no='999999';

# Create abd drop index
SELECT * FROM t_employees WHERE hire_date > '2000-01-01';
CREATE INDEX i_hire_date ON t_employees(hire_date);
SELECT * FROM t_employees;
# Drop i_hire_date index
ALTER TABLE t_employees
DROP INDEX i_hire_date;

# Question8
SELECT * FROM t_salaries
WHERE salary > '89000';
CREATE INDEX i_salary ON t_salaries(salary);
SELECT * FROM t_salaries
WHERE salary > '89000';
ALTER TABLE t_salaries
DROP INDEX i_salary;

# Question9
SELECT *,
CASE 
WHEN emp_no IS NOT NULL THEN 'Employee'
END AS Poste
FROM t_dept_emp
WHERE emp_no > 109990
UNION
SELECT *,
CASE 
WHEN emp_no IS NOT NULL THEN 'Manager'
END AS Poste
FROM t_dept_manager
WHERE emp_no > 109990;

# Question 10
SELECT 
dm.emp_no, e.first_name, e.last_name, max(s.salary) - min(s.salary) as salary_diff,
IF(max(s.salary) - min(s.salary) > 30000, 'Salary raise higher than $30,000', 'Salary raise not higher than $30,000')
AS salary_increase
FROM t_dept_manager dm
JOIN t_employees e ON  e.emp_no=dm.emp_no
JOIN t_salaries s ON dm.emp_no=s.emp_no
GROUP BY s.emp_no;

# Question 11
SELECT es.emp_no, es.first_name, es.last_name,
CASE 
WHEN max(em.to_date) > DATE_FORMAT(SYSDATE(), '%Y-%m-%d') THEN 'Is still employed'
ELSE 'Not an employee anymore'
END AS current_employee
FROM t_dept_emp em
JOIN t_employees es
ON es.emp_no = em.emp_no
GROUP BY em.emp_no
LIMIT 100;