-- Day 8 assignment
-- Waleed Sayed Abd-ElFattah
-- .Net Full-Stack --Alex

-- 1
alter proc GetStudentsCount
as
select d.Dept_Name, count(s.st_id) as 'nom of students'
from student s, Department d
where s.Dept_Id = d.Dept_Id
group by d.Dept_Name

GetStudentsCount

-- 2
use Company_SD
create proc ChechP1ProjectEmps
as
	declare @Count int = ( 
		select count(e.SSN)
		from project p, Employee e, Works_for w
		where p.Pname = w.Pno
		and e.SSN = w.ESSn
		and p.Pname = 'p1')
		if @Count >= 3
			select 'The number of employees in the project p1 is 3 or more'
		else
		begin
			select 'The following employees work for the project p1'
			union
			select concat(e.Fname , ' ' , e.Lname)
			from project p, Employee e, Works_for w
			where p.Pname = w.Pno
			and e.SSN = w.ESSn
			and p.Pname = 'p1'
		end

ChechP1ProjectEmps

-- 3
create proc updateWork_for @old_id int, @new_id int, @pnomper int
as
	update Works_for
	set ESSn = @new_id
	where ESSn = @old_id
	and Pno = @pnomper

updateWork_for 112233, 512463, 100

-- 4
alter table project
add budget_ int not null constraint c1 default 0

create table BudgetUpdates(
Id int identity(1, 1) primary key,
ProjectNo int,
UserName varchar(100),
ModifiedDate date,
Budget_Old int,
Budget_New int
)

alter trigger updateBudget
on project
after update
as
	if update(budget_)
	begin
		declare @ProjectNo int = (select pnumber from inserted)
		declare @Budget_Old int = (select budget_ from deleted)
		declare @Budget_New int = (select budget_ from inserted)
		insert into BudgetUpdates
		values(@ProjectNo,suser_name(),getdate(),@Budget_Old,@Budget_New)
	end
update project 
set budget_ = 5000
where Pnumber = 100

select *
from BudgetUpdates

-- 5
use ITI
create trigger t2
on department
instead of insert 
as 
	select 'You can’t insert a new record in that table'

insert into Department(Dept_Id,Dept_Name)
values(1000,'any')

-- 6
use Company_SD
create trigger t3
on employee
instead of insert 
as 
	select 'You can’t insert a new record in that table'

insert into Employee(SSN,Fname)
values(1,'ali')

-- 7
use ITI
create table StudentInsertion(
id int identity(1, 1) primary key,
ServerUserName varchar(100),
Date date,
Note varchar(100)
)

create trigger t4
on student
after insert
as
	declare @id int = (select st_id from inserted)
	insert into StudentInsertion
	values(@@SERVERNAME,getdate(),CONCAT(SUSER_NAME(),' Insert New Row with Key '
	,@id,' in table Student'))

insert into student(St_Id,St_Fname)
values(111,'ss')

select * 
from StudentInsertion

-- 8
alter trigger t5
on student
instead of delete
as
	declare @id int = (select st_id from deleted)
	insert into StudentInsertion
	values(@@SERVERNAME,getdate(),CONCAT(SUSER_NAME(),' try to delete Row with Key '
	,@id,' in table Student'))

delete from student
where St_Id = 111

select *
from StudentInsertion