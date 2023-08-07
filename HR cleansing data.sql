use projects;

select * from hr;

-- change id name:
alter table hr
change column ๏ปฟid emp_id varchar(20)Null;

--Describe hr;
DESCRIBE hr;

SELECT birthdate
FROM hr;

-- convert date dd-mm-yyy (Y must be capital Y)
set sql_safe_updates = 0;

update hr
set birthdate = Case
	when birthdate Like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'), '%Y-%m-%d')
    when birthdate Like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'), '%Y-%m-%d')
    else null
end;

-- modify column - type to date
alter table hr
modify column birthdate date;


-- convert date dd-mm-yyy (Y must be capital Y)
set sql_safe_updates = 0;

update hr
set hire_date = Case
	when hire_date Like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
    when hire_date Like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'), '%Y-%m-%d')
    else null
end;


-- modify column - type to date
alter table hr
modify column hire_date date;

-- change date/time:
update hr
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate !='';

select termdate from hr;

-- convert date (not working as there is space)
alter table hr
modify column termdate date;

-- second solution termdate :
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != ''
	, date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr add COLUMN age INT;

select * from hr;

-- calculate age
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, Curdate());

select * from hr;


-- check wrong age

SELECT 
	Min(age) as youngest,
    Max(age) as oldest
from hr;

-- check age less than 18

select count(*) from hr
where age < 18;


