# SQL Project

-- Questions
-- 1. List of emp by dept (employee number, first name, last name, department number, departname name)

select E.emp_no, E.first_name, E.last_name, D.dept_no, D.dept_name
from employees as E
join dept_emp as DE
on E.emp_no = DE.emp_no
join departments as D
on DE.dept_no = D.dept_no ; 

-- 2. Retrieve all the salary records of a given employee (by employee number). Include employee number, salary, from_date, and to_date.

# in the given data the emp_no is repeated, additionally salary of the same emp_no is different
select *
from salaries
where emp_no = '10001'
order by salary desc
limit 1;  # reflects max salary

-- 3. find all employees who have held a specific title (e.g., 'Engineer'). Include employee number, first name, last name, and title.
select E.emp_no, E.first_name, E.last_name, T.title 
from employees as E
join titles as T
on E.emp_no = T.emp_no
where T.title = "Engineer"
order by 1;

-- 4. list all departments along with their current managers. Include department number, department name, manager's employee number, first name, and last name.

select DM.dept_no as department_number, D.dept_name as department_name, E.emp_no as managers_employee_number, E.first_name, E.last_name
from dept_manager as DM
join departments as D
on DM.dept_no = D.dept_no
join employees as E
on DM.emp_no = E.emp_no;

-- 5. Count the number of employees in each department. Include department number,  department name and employee count
select D.dept_no as department_number, D.dept_name as  department_name, count(DE.emp_no) as employee_count
from dept_emp as DE
join departments as D
on DE.dept_no = D.dept_no
group by department_number; 

-- 6.find all employees born in a specific year (e.g., 1953). Include employee number, first name, last name, and birth date.
select emp_no as employee_number, first_name, last_name, birth_date
from employees
where year (birth_date) = 1954;

-- 7. find all employees hired in the last 50 years. Include employee number, first name, last name, and hire date.
select emp_no as employee_number, first_name, last_name, hire_date
from employees
where hire_date >= date_sub(curdate(), interval 50 year);

-- 8. calculate the average salary for each department. 
		-- Include department number, department name, and average salary
select D.dept_no as department_number, D.dept_name as department_name, avg(S.salary) as average_salary
from dept_emp as DE
join departments as D
on DE.dept_no = D.dept_no
join salaries as S
on DE.emp_no = S.emp_no
group by department_name
order by department_number;

-- 9. find the gender distribution (number of males and females) in each department. 
	-- Include department number, department name, count of males, and count of females.

select 
D.dept_no as department_number, 
D.dept_name as department_name, 
sum(E.gender = 'M') as count_of_males, 
sum(E.gender = 'F') as count_of_females
from departments as D
join dept_emp as DE
on D.dept_no = DE.dept_no
join employees as E
on DE.emp_no = E.emp_no
group by department_name
order by department_number;

-- 10. find the employees who have served the longest in the company. 
	-- Include employee number, first name, last name, and number of years served.
select emp_no as employee_number, first_name, last_name, 
timestampdiff(YEAR, hire_date, CUrdate()) as number_of_years_served
from employees 
order by number_of_years_served desc
limit 5;
