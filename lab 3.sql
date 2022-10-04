-- Day 3 assignment

-- 1
select Dnum,Dname,SSN, Fname + ' ' + Lname as name
from Departments ,Employee
where MGRSSN = SSN

-- 2 
select d.Dname ,p.Pname
from Departments d,Project p
where d.Dnum = p.Dnum

-- 3
select e.Fname + ' ' + e.Lname as empName ,d.*
from Employee e ,Dependent d
where e.SSN = d.ESSN

-- 4
select Pnumber,Pname,Plocation
from Project
where City = 'alex' or City = 'cairo'

-- 5
select *
from Project
where Pname like 'a%'

-- 6
select *
from Employee
where Dno = 30 and Salary between 1000 and 2000

-- 7
select e.Fname + ' ' + e.Lname as 'Full Name'
from Employee e ,Project p ,Works_for w
where e.SSN = w.ESSn 
and p.Pnumber = w.Pno 
and Pname = 'AL Rabwah' 
and w.Hours >= 10 
and e.Dno = 10

-- 8
select e.Fname + ' ' + e.Lname as 'Full Name'
from Employee e ,Employee s
where e.Superssn = s.SSN 
and s.Fname = 'Kamel' 
and s.Lname = 'Mohamed'

-- 9
select e.Fname + ' ' + e.Lname as 'Full Name' ,p.Pname
from Employee e ,Project p ,Works_for w
where e.SSN = w.ESSn 
and p.Pnumber = w.Pno 
order by p.Pname

-- 10
select p.Pnumber,d.Dname,e.Lname,e.Address,e.Bdate
from Employee e ,Departments d ,Project p
where e.SSN = d.MGRSSN
and p.Dnum = d.Dnum
and p.City = 'cairo'

-- 11
select distinct e.* 
from Employee e,Departments d
where e.SSN = d.MGRSSN

-- 12
select e.*,d.*
from Employee e left outer join Dependent d
on e.SSN = d.ESSN

-- 13
insert 
into Employee
values('walid','sayed',102672,25-11-1997,'Qina','M',3000,112233,30)

-- 14 
insert into Employee
values('ahmed','hussin',102660,20-11-1997,'Sohage','M',2000,112233,30)

-- 15
update Employee
set Salary -= Salary * 0.2
where SSN = 102672