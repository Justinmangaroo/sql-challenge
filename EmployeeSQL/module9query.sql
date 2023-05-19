-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/h2SrJz
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).





CREATE TABLE "titles" (
    "title_id" varchar   NOT NULL,
    "title" varchar   NOT NULL,
    PRIMARY KEY (
        "title_id"
     )
 
);
CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar  NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
	Foreign key (emp_title_id) references titles (title_id),
    PRIMARY KEY (
        "emp_no"
     )
);
CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
     PRIMARY KEY (
        "dept_no"
     )
);
CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
	Foreign key (emp_no) references employees (emp_no),
	Foreign key (dept_no) references departments (dept_no),
    PRIMARY KEY (
        "dept_no","emp_no" 
     )
);
CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
	Foreign key (emp_no) references employees (emp_no),
	Foreign key (dept_no) references departments (dept_no),
    PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
	Foreign key (emp_no) references employees (emp_no),
    PRIMARY KEY (
        "emp_no"
     )
);


select * from salaries;


--List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;


--List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;

--List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no; 


--List the department number for each employee along with that employee’s employee number, 
--last name, first name, and department name.



Select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
From dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;




--List first name, last name, and sex of each employee whose first name is Hercules
--and whose last name begins with the letter B.

select employees.first_name, employees.last_name, employees.sex
From employees
Where first_name = 'Hercules'
and last_name like 'B%';


--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT departments.dept_name, employees.last_name, employees.first_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';



--List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT departments.dept_name, employees.last_name, employees.first_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';


--List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name).


SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;









