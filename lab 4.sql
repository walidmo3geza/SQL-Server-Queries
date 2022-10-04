--Day 4 assignment

-- 1
select d.Dependent_name ,d.Sex
from Employee e,Dependent d
where e.SSN = d.ESSN
and e.Sex = 'M'
and d.Sex = 'M'
union
select d.Dependent_name ,d.Sex
from Employee e,Dependent d
where e.SSN = d.ESSN
and e.Sex = 'M'
and d.Sex = 'M'

-- 2
select p.Pname , sum(ISNULL(w.Hours,0))
from Project p ,Works_for w
where p.Pnumber = w.Pno
group by p.Pname

-- 3
select * 
from Departments
where Dnum = (select Dno
				from Employee
				where SSN = (select min(SSN) from Employee))

-- 4
select d.Dname , max(Salary) as Max, MIN(Salary) as Min, avg(Salary) as Avg
from Employee e ,Departments d
where e.Dno = d.Dnum
group by d.Dname

-- 5
select e.Fname + ' ' + e.Lname as 'Full Name'
from Employee e ,Departments d
where e.SSN = d.MGRSSN
and e.SSN not in (select ESSN from Dependent)

-- 6
select d.Dnum, d.Dname , count(e.SSN)
from Employee e ,Departments d
where e.Dno = d.Dnum
group by d.Dname,d.Dnum
having avg(e.Salary) < (select avg(Salary) from Employee)

-- 7
select e.Fname ,e.Lname ,p.Pname ,p.Dnum
from Employee e ,Project p ,Works_for w
where e.SSN = w.ESSn
and p.Pnumber = w.Pno
order by p.Dnum,e.Lname,e.Fname

-- 8
select top 2 Salary from Employee order by Salary desc

/* other solotion */
select max(Salary) from Employee
union
select max(salary) 
from (select Salary
		from Employee
		where Salary != (select max(Salary) from Employee)) as newTable

-- 9
select Fname + ' ' + Lname as fullName
from Employee
where Fname + ' ' + Lname in (select Dependent_name from Dependent)

-- 10
select SSN ,Fname + ' ' + Lname as 'Full Name'
from Employee
where exists (select ESSN from Dependent)

-- 11
insert into Departments
values('DEPT IT',100,112233,2006-11-1)

-- 12
	-- a
	update Departments
	set MGRSSN = 968574
	where Dnum = 100

	-- b 
	update Departments
	set MGRSSN = 102672
	where Dnum = 20

	-- c  
	update Employee
	set Superssn = 102672
	where SSN = 102660

-- 13
update Employee
set Superssn = 102672
where Superssn = 223344

update Departments
set MGRSSN = 102672
where MGRSSN = 223344

update Works_for
set ESSn = 102672
where ESSn = 223344

delete from Employee
where SSN = 223344

-- 14
update e
set e.Salary = e.Salary * 1.3
from Employee e, Project p, Works_for w
where e.SSN = w.ESSn
and p.Pnumber = w.Pno
and p.Pname = 'Al Rabwah'