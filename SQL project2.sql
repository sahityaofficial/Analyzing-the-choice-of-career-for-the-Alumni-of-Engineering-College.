
-- Once a student is passed out from a Institute or College, he/she is known as Alumni of the Institute. Alumni’s career growth plays important role in Institute’s ranking and other networking activities. In this project, career choices of alumni of two Universities will be analyzed with respect to their passing year as well as the course they completed. 

-- Dataset: Six .csv file (Alumni record of College A and College B) Higher Studies, Self Employed and Service/Job record 

-- College_A_HS ~ Higher Studies Record of College A
-- College_A_SE ~ Self Employed Record of College A
-- College_A_SJ ~ Service/Job Record of College A
-- College_B_HS ~ Higher Studies Record of College B
-- College_B_SE ~ Higher Studies Record of College B
-- College_B_SJ ~ Higher Studies Record of College B
-- Tasks to be performed

-- 1.Create new schema as alumni
create database alumni;

-- 2.Import all.csv files into MySQL
-- all files imported into Mysql --

-- 3.Run SQL command to see the structure of six tables --
Use alumni;
desc College_A_HS;
desc College_A_SE;
desc College_A_SJ;
desc College_B_HS;
desc College_B_SE;
desc College_B_SJ;

-- 4.Display first 1000 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) with Python.
-- Please refer ipynb file --

-- 5.Import first 1500 rows of tables (College_A_HS, College_A_SE, College_A_SJ, College_B_HS, College_B_SE, College_B_SJ) into MS Excel.
-- files imported in ms-excel(kindly refer excel sheet)

-- 6.Perform data cleaning on table College_A_HS and store cleaned data in view College_A_HS_V, Remove null values. 

create view College_A_HS_V as 
select * from College_A_HS 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
HSDegree is not null and 
EntranceExam is not null and 
Institute is not null and 
Location is not null ;

-- 7.Perform data cleaning on table College_A_SE and store cleaned data in view College_A_SE_V, Remove null values.

create view College_A_SE_V as
select * from College_A_SE 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
Organization is not null and
Location is not null ;

-- 8.Perform data cleaning on table College_A_SJ and store cleaned data in view College_A_SJ_V, Remove null values.

create view College_A_SJ_V as
select * from College_A_SJ 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
Organization is not null and
Designation is not null and
Location is not null ;

-- 9.Perform data cleaning on table College_B_HS and store cleaned data in view College_B_HS_V, Remove null values.

create view College_B_HS_V as
select * from College_B_HS 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Branch is not null and
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
HSDegree is not null and 
EntranceExam is not null and 
Institute is not null and 
Location is not null ;

-- 10.Perform data cleaning on table College_B_SE and store cleaned data in view College_B_SE_V, Remove null values.

create view College_B_SE_V as 
select * from College_B_SE 
where  RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and 
Branch is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
Organization is not null and
Location is not null ;

-- 11.Perform data cleaning on table College_B_SJ and store cleaned data in view College_B_SJ_V, Remove null values.

create view College_B_SJ_V as 
select * from College_B_SJ 
where RollNo is not null and 
LastUpdate is not null and 
Name is not null and 
FatherName is not null and 
MotherName is not null and
Branch is not null and 
Batch is not null and 
Degree is not null and 
PresentStatus is not null and
Organization is not null and
Designation is not null and
Location is not null ;

-- 12.Make procedure to use string function/s for converting record of Name, FatherName, MotherName into lower case for views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) 

delimiter $
create procedure V1()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_A_HS_V;
end $
delimiter ;

call V1();

delimiter $
create procedure V2()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_A_SE_V;
end $
delimiter ;

call V2();

delimiter $
create procedure V3()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_A_SJ_V;
end $
delimiter ;

call V3();

delimiter $
create procedure V4()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_B_HS_V;
end $
delimiter ;

call V4();

delimiter $
create procedure V5()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_A_SE_V;
end $
delimiter ;

call V5();

delimiter $
create procedure V6()
begin
select lower(Name) Name,lower(FatherName) FatherName,lower(MotherName) MotherName
from College_B_SJ_V;
end $
delimiter ;

call V6();

-- 13.Import the created views (College_A_HS_V, College_A_SE_V, College_A_SJ_V, College_B_HS_V, College_B_SE_V, College_B_SJ_V) into MS Excel and make pivot chart for location of Alumni. 
-- pivotchart created--(refer exdcel sheet)

-- 14.Write a query to create procedure get_name_collegeA using the cursor to fetch names of all students from college A.

delimiter $$
create  procedure get_name_collegeA(inout n text(20000))
begin
	declare finished int default 0;
    declare namelist varchar(400) default '';
    
    declare namedetails cursor for
		select Name from College_A_HS
		union
		select Name from College_A_SE
		union
		select Name from College_A_SJ;
        
        
	declare continue handler for not found set finished =1;
    
    open namedetails;
    getname:
    loop
		fetch namedetails into namelist;
        if finished = 1 then 
			leave getname;
		end if;
        
        set n = concat(namelist,';',n);
	end loop getname;
    close namedetails;
end$$
delimiter ;

set @l=' ';
call get_name_collegeA(@l);
select @l student_names_get_name_collegeA;

-- 15.Write a query to create procedure get_name_collegeB using the cursor to fetch names of all students from college B.

delimiter $$
create  procedure get_name_collegeB(inout n text(20000))
begin
	declare finished int default 0;
    declare namelist varchar(400) default '';
    
    declare namedetails cursor for
		select Name from College_B_HS
		union
		select Name from College_B_SE
		union
		select Name from College_B_SJ;
        
        
	declare continue handler for not found set finished =1;
    
    open namedetails;
    getname:
    loop
		fetch namedetails into namelist;
        if finished = 1 then 
			leave getname;
		end if;
        
        set n = concat(namelist,';',n);
	end loop getname;
    close namedetails;
end$$
delimiter ;

set @l=' ';
call get_name_collegeB(@l);
select @l student_names_get_name_collegeB;


-- 16.Calculate the percentage of career choice of College A and College B Alumni
-- (w.r.t Higher Studies, Self Employed and Service/Job)
-- Note: Approximate percentages are considered for career choices.
select (1157+1016+5633) Total_No_of_alumni_College_A;

select 'Higher_studies' career_choice,count(*) No_of_students ,count(*)/7806*100 Percentage from College_A_HS
union
select 'Self Employed'  career_choice,count(*) No_of_students,count(*)/7806*100 Percentage from  College_A_SE
union
select 'Service/Job'  career_choice,count(*) No_of_students,count(*)/7806*100 Percentage from College_A_SJ;

select (199+201+1859) Total_no_of_alumni_College_B;

select 'Higher_studies' career_choice,count(*) No_of_students,count(*)/2259*100 Percentage  from College_B_HS
union
select 'Self Employed'  career_choice,count(*) No_of_students,count(*)/2259*100 Percentage from College_B_SE
union
select 'Service/Job'  career_choice,count(*) No_of_students,count(*)/2259*100 Percentage from College_B_SJ;
