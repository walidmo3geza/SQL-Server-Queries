-- Day 6
-- 1
create function getday(@date date)
returns varchar(30)
	begin
		return format(@date,'MMMM')
	end

select dbo.getday(getdate())

-- 2
create function getvalues(@x int, @y int)
returns @t table(
val int
) 
as
begin
	if @x > @y
	begin
		declare @temp int = @x
		set @x = @y
		set @y = @temp
	end
	while @x <= @y
	begin
		insert into @t values(@x)
		set @x = @x + 1
	end
	return
end
select * from getvalues(10,5)

-- 3
create function getstudent(@st_num int)
returns table as return (
select d.Dept_Name, s.St_Fname + ' ' + s.St_Lname as 'Full Name'
from Student s, Department d
where s.Dept_Id = d.Dept_Id
and s.St_Id = @st_num
)

select * from getstudent(5)

-- 4
create function getnull(@st_num int)
returns varchar(50)
begin
	declare @m varchar(50)
	declare @fn varchar(20)= (select St_Fname from Student where St_Id = @st_num)
	declare @ln varchar(20)= (select St_Lname from Student where St_Id = @st_num)
	if @fn is null and @ln is null
		set @m = 'First name & last name are null'
	else if @fn is null
		set @m = 'First name is null'
	else if @ln is null
		set @m = 'last name is null'
	else 
		set @m = 'First name & last name are not null'
	return @m
end
select dbo.getnull(14)

-- 5
--department name, Manager Name and hiring date 
create function getmanger(@num int)
returns table as return(
	select d.Dept_Name, i.Ins_Name, d.Manager_hiredate
	from Department d, Instructor i
	where d.Dept_Manager = i.Ins_Id
	and d.Dept_Manager = @num
)

select * from getmanger(12)

-- 6
alter function getfirstlastfull(@s varchar(10))
returns @t table(
name varchar(50)
)
as
begin
if @s = 'first'
	insert into @t select isnull(St_Fname,'') from Student 
else if @s='last'
	insert into @t select isnull(st_Lname,'') from Student
else if @s='fullname'
	insert into @t select isnull(St_Fname,'')+' '+isnull(st_Lname,'')
	from Student
return 
end

select * from getfirstlastfull('fullname')

-- 7
select St_Id, substring(St_Fname,1,len(St_Fname) - 1)
from Student

-- 8 ****************
delete from Stud_Course 
where St_Id in(
select s.St_Id
from Student s, Department d
where s.Dept_Id = d.Dept_Id
and d.Dept_Name = 'SD'
)
-- 9
create table LastT
(
 id int,
 Value int
)

create table DailyT
(
 did int,
 Val int
)
Merge into LastT as T
using DailyT as S
on T.id=S.did
when matched then
	update 
		Set T.Value=S.Val
when not matched then
	insert 
	values(S.did,S.Val);
