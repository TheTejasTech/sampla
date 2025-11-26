Create database Department;
use Department;
drop table department;
create table department(
   deptId int primary key,
   deptName varchar(50)
);
drop database Department;
create table employee(
   empId int primary key,
   empName varchar(20),
   salary decimal(10,2),
   deptId int,
   foreign key(deptId) references department(deptId)
);

insert into department values
( 1 , 'CS') , 
( 2 , 'IT' ) ,
( 3 , 'Mech' ),
( 4 , 'Entc' ),
( 5 , 'Civil' );
drop table employee;
insert into employee values
(101 , 'alex' , 59000.00, 1),
(102 , 'john' , 86000.00, 2),
(103 , 'polito' , 72000.00, 3),
(104 , 'lucrecia' , 95000.00, 4),
(105 , 'guzman' , 65000.00, 5),
(106 , 'stephen' , 45000.00, 1),
(107 , 'antony' , 53000.00, 2),
(108 , 'ava' , 61000.00, 3),
(109 , 'amee' , 98000.00, 4),
(110 , 'samuel' , 67000.00, 5);

create view view_empl_basic as select empId, empName , salary from employee;

UPDATE view_empl_basic
SET salary = 90000.00 
WHERE empId = 102;

create view view_empl_with_dept as 
select e.empId, empName , e.salary, d.deptName
from employee e 
join  department d on e.deptId = d.deptId;

UPDATE view_empl_with_dept
SET salary = 90000.00 
WHERE empId = 102;

CREATE VIEW view_cs_employees AS
SELECT * FROM employee
WHERE deptId = 1
WITH CHECK OPTION;

UPDATE view_cs_employees
SET deptId = 2
WHERE empId = 101;

CREATE VIEW view_high_paid_employees AS
SELECT empId, empName, salary
FROM employee
WHERE salary > 80000;

select * from employee;
select * from department;
