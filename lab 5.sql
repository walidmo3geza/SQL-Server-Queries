-- ITI DB

-- 1
select count(St_Age)
from Student

-- 2
select distinct Ins_Name
from Instructor

-- 3
select St_Id as 'Student ID', 
ISNULL(St_Fname + ' ' + St_Lname, 'Name not Selected') as 'Student Full Name', 
ISNULL(Dept_Id, '-1') as 'Department name'
from Student

-- 4
select i.Ins_Name, d.Dept_Name
from Instructor i left outer join Department d
on i.Dept_Id = d.Dept_Id

-- 5
select s.St_Fname + ' ' + s.St_Lname as 'Student Full Name', c.Crs_Name
from Student s, Course c, Stud_Course sc
where s.St_Id = sc.St_Id
and c.Crs_Id = sc.Crs_Id
and sc.Grade is not null

-- 6 
select Top_Name, COUNT(c.Crs_Id)
from Topic t,Course c
where t.Top_Id = c.Top_Id
group by t.Top_Name

-- 7
select max(Salary), min(Salary)
from Instructor

-- 8
select *
from Instructor
where Salary < (select avg(Salary) from Instructor)

-- 9

select d.Dept_Name
from Department d, (select * from Instructor
					where Salary = (select min(Salary) from Instructor)) inst
where d.Dept_Id = inst.Dept_Id

-- 10
select Salary
from (select *,ROW_NUMBER() over(order by salary desc) as rn
	  from Instructor) as newTable
where rn in (1,2)

-- 11
select Ins_Name , coalesce(convert(varchar(20),salary),'bonus')
from Instructor

-- 12
select avg(Salary) from Instructor

-- 13
select s.St_Fname , super.*
from Student s, Student super
where s.St_super = super.St_Id

-- 14
select *
from (select *, DENSE_RANK() over(partition by dept_id order by salary desc) as dr
	  from Instructor) as newTable
where dr in(1,2)

-- 15
select Ins_Id,Ins_Name,Ins_Degree,Salary,Dept_Id
from (select *, DENSE_RANK() over(partition by dept_id order by NEWID() desc) as dr
	  from Instructor) as newTable
where dr = 1
