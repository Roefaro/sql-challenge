                  --------------------- DATA MODELING ---------------------			  
-- QuickDBD: ENTITY RELATIONSHIP DIAGRAM 
-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/fNbDQW
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Department_Employees" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

CREATE TABLE "Department_Manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "Titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" TEXT   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title"
     )
);

ALTER TABLE "Departments" ADD CONSTRAINT "fk_Departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Department_Manager" ("dept_no");

ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Department_Employees" ("emp_no");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Titles" ("title_id");




				  --------------------- DATA ENGINEERING ---------------------	

CREATE TABLE departments (
	dept_id (30) VARCHAR not null,
	dept_name (30) VARCHAR not null
);
	
CREATE TABLE dept_employees (
	emp_no INT not null,
	dept_no VARCHAR (30) not null
);

CREATE TABLE dept_manager (
dept_no VARCHAR (100) not null,
emp_no INT not null
);

CREATE TABLE employees (
emp_no INT not null,
emp_title_id VARCHAR (30) not null,
birth_date VARCHAR (30) not null,
first_name VARCHAR (100) not null,
last_name VARCHAR (100) not null,
sex VARCHAR (10) not null,
hire_date VARCHAR (30) not null
);

CREATE TABLE salaries (
emp_no INT not null,
salary INT not null
);

CREATE TABLE titles (
title_id VARCHAR (30) not null,
title TEXT not null
);

select * from departments;
select * from dept_employees;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

Create table titles(title_id VARCHAR, title text);
select * from titles;

ALTER TABLE department RENAME TO departments; 
select * from departments;




                  --------------------- DATA ANALYSIS ---------------------
-- 1.List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;


-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date 
FROM employees 
WHERE hire_date >= '1/1/1986' AND hire_date < '1/1/1987';


-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_employees
JOIN employees
ON dept_employees.emp_no = employees.emp_no
JOIN departments
ON dept_employees.dept_no = departments.dept_no;


-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name Like 'B%';


-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT departments.dept_name, employees.last_name, employees.first_name
FROM dept_employees
JOIN employees
ON dept_employees.emp_no = employees.emp_no
JOIN departments
ON dept_employees.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';


-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_employees
JOIN employees
ON dept_employees.emp_no = employees.emp_no
JOIN departments
ON dept_employees.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;
