use hr;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    hire_date DATE
);

INSERT INTO employees (employee_id, first_name, last_name, department_id, hire_date) VALUES
(1, 'John', 'Doe', 1, '2021-01-15'),
(2, 'Jane', 'Smith', 2, '2020-03-22'),
(3, 'Michael', 'Johnson', 1, '2019-11-30'),
(4, 'Patricia', 'Williams', 3, '2021-06-25'),
(5, 'Linda', 'Brown', 2, '2018-09-05');


CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);


INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'IT');


CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10, 2),
    PRIMARY KEY (employee_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO salaries (employee_id, salary) VALUES
(1, 60000.00),
(2, 75000.00),
(3, 50000.00),
(4, 68000.00),
(5, 72000.00);

-- List all employees and their department names.

select employees.first_name, employees.last_name,departments.department_name
from employees join departments on
employees.department_id = departments.department_id;


-- Find the total number of employees in each department.

select departments.department_name , count(employees.employee_id) as total_employee
from departments join employees 
on departments.department_id = employees.department_id
group by departments.department_name;


-- List all employees who were hired after January 1, 2020.

select employees.first_name , employees.last_name , employees.hire_date
from employees where hire_date > '2020-01-01';

-- Find the employee with the highest salary.

select employees.first_name , employees.last_name , salaries.salary
from employees join salaries on employees.employee_id = salaries.employee_id
order by salaries.salary desc 
limit 1;

-- Calculate the average salary for each department.

select departments.department_name , round( avg(salaries.salary),0) as avg_salary 
from departments join employees on departments.department_id = employees.department_id 
join salaries on salaries.employee_id = employees.employee_id
group by departments.department_name;


-- Find all employees who work in the IT department.

select employees.first_name  , employees.last_name from employees 
join departments on employees.department_id = departments.department_id
where departments.department_name = "IT";


-- List the names of employees along with their hire dates, ordered by hire date.

select employees.first_name , employees.last_name , employees.hire_date
from employees 
order by hire_date;

-- Find the total salary expenditure for each department.

select departments.department_name , round(sum(salaries.salary),0) as total_expenditure
from departments join employees 
on departments.department_id = employees.department_id
join salaries on salaries.employee_id = employees.employee_id
group by departments.department_name;


-- List employees who earn more than $65,000.

select  employees.first_name , employees.last_name , salaries.salary from 
employees join salaries on employees.employee_id = salaries.employee_id
where salaries.salary > 65000
;
-- Find the department with the most employees.

select departments.department_name , count(employees.employee_id) from departments join employees
on departments.department_id = employees.department_id
group by departments.department_name ;