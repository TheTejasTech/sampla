-- Step 1: Create base table

CREATE TABLE Employees (
emp id NUMBER PRIMARY KEY,

emp name VARCHAR2(50),

salary NUMBER(10.2).

dept id NUMBER
);



-- Insert sample data

INSERT INTO Employees VALUES (1, 'Amit', 50000, 10);

INSERT INTO Employees VALUES (2, 'Priya', 60000, 20);

INSERT INTO Employees VALUES (3, 'Rahul', 45000, 10);

INSERT INTO Employees VALUES (4, 'Neha', 70000, 30);

INSERT INTO Employees VALUES (5,'Vikram', 55000, 20);
-- COMMIT:

-- A) IMPLICIT CURSOR
SET SERVEROUTPUT ON;
DECLARE
v_name Employees.emp_name%TYPE;
salary Employees.salary%TYPE;

BEGIN
SELECT emp_name, salary

INTO v name, v salary

FROM Employees

WHERE emp_id=1;

DBMS_OUTPUT.PUT_LINE('Implicit Cursor->'||v_name || 'earns' || v_salary);
END;//

-- B) EXPLICIT CURSOR

DECLARE
CURSOR emp cursor IS
SELECT emp id, emp name, salary FROM Employees;
vid Employees.emp_id%TYPE;
v_name Employees.emp_name%TYPE;
v_salary Employees salary TYPE;

BEGIN
OPEN emp cursor,
LOOP
FETCH emp cursor INTO vid, v name, v salary,
EXIT WHEN emp_cursor NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Explicit Cursor ID: v_id', Name:" || v_name ]", Salary;
v_salary);
END LOOP;
CLOSE emp cursor;
END;

-- C) PARAMETERIZED CURSOR

DECLARE
CURSOR emp_by_dept(p_dept NUMBER) IS
SELECT emp_name, salary
FROM Employees
WHERE dept_id=p_dept;
v_name Employees.emp_name%TYPE;
v_salary Employees.salary%TYPE;

BEGIN
open emp_by_dept(20);
loop 
fetch emp_by_dept into v_name, v_salary;
exit when emp_by_dept%NOTFOUND;
DBMS_OUTPUT.PUT_LINE('Parameterised cursor (dept = 20)->'|| v_name || 'salary'|| v_salary);
end loop;
close emp_by_dept;
end;
/

-- d : cursor fro loop 
begin
for rec in (select emp_id,emp_name, salary from employees) loop
DBMS_OUTPUT.PUT_LINE('for loop cursor ID: '|| rec.emp_id||', '|| rec.emp_name|| ', salary:' || rec.salary);
end loop; 
end;
/

