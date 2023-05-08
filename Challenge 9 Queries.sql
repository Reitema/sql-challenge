DROP TABLE salaries;
DROP TABLE employees;
DROP TABLE titles;
DROP TABLE dept_manager;
DROP TABLE dept_emp;
DROP TABLE departments;


/*Create the tables*/
/*Departments table*/
CREATE TABLE departments(
dept_no VARCHAR PRIMARY KEY NOT NULL,
dept_name VARCHAR
);

CREATE TABLE dept_emp(
	id SERIAL PRIMARY KEY,
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);
	
SELECT *
FROM dept_emp;

CREATE TABLE dept_manager(
	id_man SERIAL PRIMARY KEY,
	dept_no VARCHAR,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	emp_no INTEGER NOT NULL
	/*FOREIGN KEY (emp_no) REFERENCES dept_emp(emp_no)*/
);

SELECT *
FROM dept_manager;

/*Create titles table*/
CREATE TABLE titles (
title_id VARCHAR PRIMARY KEY NOT NULL,
title VARCHAR
);

SELECT *
FROM titles;


CREATE TABLE employees(
	emp_no INTEGER NOT NULL,
	/*FOREIGN KEY (emp_no) REFERENCES dept_emp(emp_no),*/
	emp_title_id VARCHAR NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id),
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex	VARCHAR(1) NOT NULL,
	hire_date DATE
);

SELECT *
FROM dept_emp;

CREATE TABLE salaries(
	emp_no INTEGER NOT NULL,
	/*FOREIGN KEY (emp_no) REFERENCES dept_emp(emp_no),*/
	salary INTEGER NOT NULL
);



--DATA ANALYSIS
--1) List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;

--2) List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

--3) List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no,employees.last_name, employees.first_name
FROM dept_manager
JOIN departments
ON dept_manager.dept_no = departments.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;



--4) List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT departments.dept_no, dept_manager.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_manager
JOIN departments
ON dept_manager.dept_no = departments.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

--5) List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
Select first_name, last_name, sex
FROM employees
Where first_name = 'Hercules'
AND last_name Like 'B%';

--6) List each employee in the Sales department, including their employee number, last name, and first name.
SELECT departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales';

--7) List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--8) List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;