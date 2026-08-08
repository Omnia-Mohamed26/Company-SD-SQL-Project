-- =============================================================================
--                           Company_SD SQL Project
-- =============================================================================
-- Author      : Omnia Mohamed
-- Database    : Company_SD
-- SQL Server  : Microsoft SQL Server
--
-- Skills Demonstrated:
-- • SELECT
-- • WHERE
-- • ORDER BY
-- • LIKE
-- • BETWEEN
-- • IN
-- • INNER JOIN
-- • SELF JOIN
-- • OUTER JOIN
-- • GROUP BY
-- • HAVING
-- • Aggregate Functions
-- • Subqueries
-- • UNION
-- • INTERSECT
-- • EXCEPT
-- • UPDATE
--
-- =============================================================================



-- =============================================================================
-- Basic SQL Queries
-- =============================================================================



-- Query 1
-- Display the Department Name, Department Number,
-- Manager SSN and Manager Start Date.

select Dname , Dnum , MGRSSN , "MGRStart Date"
from Departments



-- Query 2
-- Display all department information.

select *
from Departments



-- Query 3
-- Display Employee SSN, First Name and Department Number.

select SSN , Fname , Dno
from Employee



-- Query 4
-- Display the department managed by manager SSN = 223344.

select *
from Departments
where MGRSSN = 223344



-- Query 5
-- Display employees whose salary is greater than 1000.

select *
from Employee
where Salary > 1000



-- Query 6
-- Display employees whose salary is between 1000 and 1600.

select Fname
from Employee
where Salary between 1000 and 1600



-- Query 7
-- Display employees supervised by SSN 223344 or 512463.

select SSN , Fname
from Employee
where Superssn in ( 223344 , 512463 )



-- Query 8
-- Display employees whose first name starts with any character
-- followed by the letter 'a'.

select *
from Employee
where Fname like '_a%'



-- Query 9
-- Display all project names, locations,
-- and their corresponding department names.

select p.Pname , p.Plocation , d.Dname
from Project p inner join Departments d
on d.Dnum = p.Dnum



-- Query 10
-- Display each employee's full name and annual commission
-- (10% of annual salary).

select Fname + ' ' + Lname as [Full Name] , Salary * 12 * 0.1 "ANNUAL COMM"
from Employee



-- Query 11
-- Display employee SSN and full name
-- for employees whose monthly salary is greater than 1000.

select SSN , Fname + ' ' + Lname as [Full Name]
from Employee
where Salary > 1000



-- Query 12
-- Display employee SSN and full name
-- for employees whose annual salary exceeds 10000.

select SSN , Fname + ' ' + Lname as [Full Name]
from Employee
where Salary * 12 > 10000



-- Query 13
-- Display the full names and salaries
-- of all female employees.

select Fname + ' ' + Lname as [Full Name] , Salary
from Employee
where sex = 'F'



-- Query 14
-- Display department number and department name
-- managed by employee SSN = 968574.

select Dnum , Dname
from Departments
where MGRSSN = 968574



-- Query 15
-- Display the project number, project name,
-- and location for projects controlled by department 10.

select Pnumber , Pname , Plocation
from Project
where Dnum = 10


-- =============================================================================
-- Intermediate SQL Queries
-- =============================================================================



-- Query 16
-- Display each department number, department name,
-- and the full name of its manager.

select d.Dnum , d.Dname , e.Fname + ' ' + e.Lname " Dept Manager Name "
from Departments d inner join Employee e
on d.MGRSSN = e.SSN



-- Query 17
-- Display each department name along with its projects.

select d.Dname , p.Pname
from Departments d , Project p
where d.Dnum = p.Dnum



-- Query 18
-- Display dependent information along with
-- the corresponding employee name.

select d.* , e.Fname + ' ' + e.Lname as [Employee Name]
from Employee e , Dependent d
where e.SSN = d.ESSN



-- Query 19
-- Display project number, project name,
-- and location for projects located in Cairo or Alex.

select Pnumber , Pname , Plocation
from Project
where City in ( 'Cairo' , 'Alex' )



-- Query 20
-- Display all projects whose names start with 'A'.

select *
from Project
where Pname like 'a%'



-- Query 21
-- Display employees working in department 30
-- with salaries between 1000 and 2000.

select *
from Employee
where Dno = 30 and Salary between 1000 and 2000



-- Query 22
-- Display employees working on the project 'Al Rabwah'
-- for at least 10 hours and belonging to department 30.

select *
from Works_for w inner join Employee e
on e.SSN = w.ESSn inner join Project p
on w.Pno = p.Pnumber
where dno = 30 and w.Hours >= 10 and p.Pname = 'Al Rabwah'



-- Query 23
-- Display employees supervised by Omar Wael.

select e.Fname + ' ' + e.Lname as [Employee Name]
from Employee e , Employee s
where e.Superssn = s.SSN and s.Fname + s.Lname = 'OmarWael'



-- Query 24
-- Display department number, total salaries,
-- average salary and employee count
-- for departments having more than two male employees.

select d.Dnum , SUM(salary) [Total Payout] ,
AVG(salary) [Average Salary] ,
COUNT(e.SSN) [No. Employees]
from Employee e left outer join departments d
on e.Dno = d.Dnum
where sex = 'M'
group by d.Dnum
having COUNT(e.SSN) > 2



-- Query 25
-- Display the project with the highest total working hours,
-- number of male employees and average salary.

select top 1 p.Pname , COUNT(e.ssn) as [No. Employees]
		, AVG(e.salary) [Average Salary]
		, SUM(w.hours) [Total Working Hours]
from Employee e right outer join Works_for w
on e.ssn = w.ESSn inner join Project p
on w.Pno = p.Pnumber
where e.Sex = 'M'
group by p.Pname
having SUM(w.hours) > 25
order by [Total Working Hours] desc



-- Query 26
-- Display all employees and departments
-- using a Full Outer Join.

select *
from Employee full outer join Departments
on Dno = Dnum



-- Query 27
-- Display each employee along with
-- the name of their supervisor.

select e.Fname + ' ' + e.Lname as 'Employee Name'
	, s.Fname + ' ' + s.Lname as 'Supervisor Name'
from Employee e , Employee s
where e.Superssn = s.SSN



-- Query 28
-- Display employees whose salary is greater
-- than Ahmed Ali's salary.

select *
from Employee
where Salary > (
				select Salary
				from Employee
				where Fname + Lname = 'AhmedAli'
				)



-- Query 29
-- Display employees whose salary is greater than
-- every employee in department 30.

select *
from Employee
where Salary > all (
				select Salary
				from Employee
				where Dno = 30
				)



-- Query 30
-- Display the maximum and minimum salary.

select max(salary) as Max , min(salary) as Min
from employee



-- Query 31
-- Display the average salary for each department
-- where the maximum salary is greater than 1800.

select dname , avg(salary)
from employee , departments
where dno = dnum
group by dname
having max(salary) > 1800


-- =============================================================================
-- Advanced SQL Queries
-- =============================================================================



-- Query 32
-- Display each employee along with the projects
-- they are assigned to.

select e.Fname + ' ' + e.Lname as "Employee Name"
	, p.Pname as "Project Name"
from Employee e inner join Works_for w
on e.SSN = w.ESSn inner join Project p
on w.Pno = p.Pnumber
order by p.Pname



-- Query 33
-- Display project number, department name,
-- manager last name, address and birth date
-- for projects located in Cairo.

select Pnumber , d.Dname , e.Lname , e.Address , e.Bdate
from Project p inner join Departments d
on p.Dnum = d.Dnum inner join Employee e
on d.MGRSSN = e.SSN
where p.City = 'Cairo'



-- Query 34
-- Display employees who are both department managers
-- and supervisors.

select distinct e.*
from Employee e inner join Departments d
on e.SSN = d.MGRSSN

intersect

select distinct s.*
from Employee e inner join Employee s
on e.Superssn = s.SSN



-- Query 35
-- Display employees who are either department managers
-- or supervisors.

select e.* , 'Department Manager' as "Role"
from Employee e inner join Departments d
on e.SSN = d.MGRSSN

union

select s.* , 'Supervisor' as "Role"
from Employee e inner join Employee s
on e.Superssn = s.SSN



-- Query 36
-- Display supervisors who are not department managers.

select s.*
from Employee e inner join Employee s
on e.Superssn = s.SSN

except

select e.*
from Employee e inner join Departments d
on e.SSN = d.MGRSSN



-- Query 37
-- Display employees who do not have dependents.

select *
from Employee e left outer join Dependent d
on e.SSN = d.ESSN
where d.ESSN is null



-- Query 38
-- Display the department that contains
-- the employee with the minimum SSN.

select d.*
from Departments d inner join Employee e
on d.Dnum = e.Dno
where e.ssn = (
			  select min(ssn)
			  from Employee
			  )



-- Query 39
-- Demonstrate an INNER JOIN between
-- Employee and Departments.

select *
from Employee inner join Departments
on dno = Dnum



-- Query 40
-- Demonstrate a LEFT OUTER JOIN between
-- Employee and Departments.

select *
from Employee Left Outer join Departments
on dno = Dnum



-- Query 41
-- Demonstrate a RIGHT OUTER JOIN between
-- Employee and Departments.

select *
from Employee Right Outer join Departments
on dno = Dnum



-- Query 42
-- Demonstrate a FULL OUTER JOIN between
-- Employee and Departments.

select *
from Employee Full Outer join Departments
on dno = Dnum



-- Query 43
-- Demonstrate a SELF JOIN
-- to display employees and their supervisors.

select *
from Employee e , Employee s
where e.Superssn = s.SSN



-- Query 44
-- Demonstrate a CROSS JOIN between
-- Employee and Departments.

select *
from Employee cross join Departments



-- Query 45
-- Display employees who have
-- three or more dependents.

select ssn ,
e.Fname + ' ' + e.Lname as "Employee Name" ,
COUNT(d.essn) as [No. Dependents]
from Employee e inner join Dependent d
on e.SSN = d.ESSN
group by SSN , e.Fname + ' ' + e.Lname
having COUNT(d.essn) >= 3


-- =============================================================================
-- Advanced SQL Challenges
-- =============================================================================



-- Query 46
-- Display employees and dependents
-- where both have the same gender.

select e.Fname , e.Lname , e.Salary
from Employee e inner join Dependent d
on SSN = ESSN
where e.Sex = 'F' and D.Sex = 'F'

union

select e.Fname , e.Salary , e.Lname
from Employee e inner join Dependent d
on SSN = ESSN
where e.Sex = 'M' and D.Sex = 'M'



-- Query 47
-- Display each project with the total working hours spent on it.

select p.Pname as [Project Name] , SUM(w.hours) as [Total Spent Hours]
from Project p inner join Works_for w
on p.Pnumber = w.Pno
group by p.Pname



-- Query 48
-- Display the department of the employee
-- having the minimum SSN.

select d.*
from Departments d inner join Employee e
on d.Dnum = e.Dno
where e.ssn = (
			  select min(ssn)
			  from Employee
			  )



-- Query 49
-- Display the maximum, minimum and average salary
-- for each department.

select dname ,
max(salary) as [Maximum Salary] ,
min(salary) [Minimum Salary] ,
AVG(salary) [Average Salary]
from Employee e inner join Departments d
on e.Dno = d.Dnum
group by d.Dname



-- Query 50
-- Display department managers and supervisors
-- who do not have dependents.

select e.* , dd.*
from Employee e inner join Departments d
on e.SSN = d.MGRSSN left outer join Dependent dd
on dd.ESSN = e.SSN
where dd.ESSN is null

union

select s.* , dd.*
from Employee e inner join Employee s
on e.Superssn = s.SSN left outer join Dependent dd
on dd.ESSN = e.SSN
where dd.ESSN is null



-- Query 51
-- Display departments whose average salary
-- is less than the overall company average salary.

select d.Dnum , d.Dname ,
COUNT(e.SSN) as [No. Employees] ,
AVG(salary)
from Employee e inner join Departments d
on e.Dno = d.Dnum
group by d.Dnum , d.Dname
having AVG(e.salary) < (
						select AVG(salary)
						from Employee
						)



-- Query 52
-- Display employees with the projects
-- they are assigned to.

select e.* , p.*
from Employee e inner join Works_for w
on e.SSN = w.ESSn inner join Project p
on w.Pno = p.Pnumber
order by e.Dno , e.Lname , e.Fname



-- Query 53
-- Display employees having the third highest salary.

select *
from Employee
where Salary >= (
				select MAX(salary)
				from Employee
				where Salary < (
								select MAX(Salary)
								from Employee
								where Salary < (
												select MAX(salary)
												from Employee
												)
								)
				)



-- Query 54
-- Display employees whose first name
-- appears in one of their dependent names.

select distinct fname + ' ' + Lname , Dependent_name
from Employee , Dependent
where Dependent_name like '%' + Fname + '%'




-- Query 55
-- Increase salary by 30%
-- for employees working on 'Al Rabwah' project.

update Employee
set Salary = Salary + Salary * 0.3
from Works_for inner join Project
on Pno = Pnumber inner join Employee
on SSN = ESSn
where Pname = 'Al Rabwah'



-- Query 56
-- Display employees who have at least one dependent.

select ssn ,
Fname + ' ' + Lname as "Employee Name"
from Employee
where exists (
			  select *
			  from Dependent
			  where ESSN = SSN
			  )