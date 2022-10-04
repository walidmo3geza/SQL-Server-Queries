-- Day 7 assignment
-- 1
create view ins_co
as
select concat(s.st_fname,' ',s.st_lname) as 'full name', c.Crs_Name
from student s, Course c, Stud_Course sc
where s.st_id = sc.St_Id
and c.Crs_Id = sc.Crs_Id
and sc.Grade > 50

select * from ins_co

-- 2
create view ins_topic
with encryption
as
select i.Ins_Name, t.Top_Name
from Instructor i, Department d, Ins_Course ic, Course c, Topic t
where i.Ins_Id = d.Dept_Manager
and i.Ins_Id = ic.Ins_Id
and c.Crs_Id = ic.Crs_Id
and t.Top_Id = c.Top_Id

select * from ins_topic

-- 3
create view ins_dept
as 
select i.Ins_Name, d.Dept_Name
from Department d, Instructor i
where d.Dept_Id = i.Dept_Id
and d.Dept_Name in('SD' , 'Java')

select * from ins_dept

-- 4 
alter view v1
as
select *
from student
where st_address in('alex','cairo')
with check option
select * from v1
update v1
set st_address = 'tanta'
where st_address = 'alex'


-- 5
create view v2
as
select p.Pname, COUNT(w.ESSn) as numofemployee
from Company_SD.dbo.Project p, Company_SD.dbo.Works_for w
where p.Pnumber = w.Pno
group by p.Pname

select * from v2

-- 6
use Company_SD
create schema Company 

alter schema Company transfer Departments
 
create schema HumanResource 

alter schema HumanResource transfer employee

-- 7
use ITI
create clustered index c2
on department(manager_hiredate)
/*Cannot create more than one clustered index on table 'department'*/

create nonclustered index c1
on department(manager_hiredate)

-- 8
create unique index c3
on student(st_age)
/*terminated because a duplicate key was found for the object*/

-- 9
use Company_SD
declare c1 cursor
for select salary
	from humanresource.employee
for update

declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS = 0
begin
	if @sal >= 3000
		update humanresource.employee
		set salary = @sal * 1.2
		where current of c1
	else if @sal < 3000
		update humanresource.employee
		set salary = @sal * 1.1
		where current of c1
	fetch c1 into @sal
end
close c1
deallocate c1

-- 10
use ITI
declare c2 cursor
for select d.Dept_Name, i.Ins_Name
	from Department d, Instructor i
	where d.Dept_Manager = i.Ins_Id
for read only
declare @dname varchar(20), @iname varchar(20)
open c2
fetch c2 into @dname, @iname
while @@FETCH_STATUS = 0
begin
	select @dname, @iname
	fetch c2 into @dname, @iname
end
close c2
deallocate c2

-- 11
declare c2 cursor
for select Ins_Name
	from Instructor
for read only
declare @names varchar(200) = '', @iname varchar(20)
open c2
fetch c2 into @iname
while @@FETCH_STATUS = 0
begin
	set @names = concat(@names,',',@iname)
	fetch c2 into @iname
end
select @names
close c2
deallocate c2

-- 12
-- can't generate script becouse view ins_topic created with encryption
