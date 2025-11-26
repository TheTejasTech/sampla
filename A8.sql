-- Create database and select it
CREATE DATABASE IF NOT EXISTS Student_Cursors;
USE Student_Cursors;

-- Recreate student table so script is safe to re-run
DROP TABLE IF EXISTS student;

CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
);

-- Insert data
INSERT INTO student (roll_no, name, marks) VALUES
(1, 'Manish', 85),
(2, 'Meet', 92),
(3, 'Amit', 76),
(4, 'Stimit', 89),
(5, 'Pranay', 67);

SELECT * FROM student;

-- Drop procedure if it already exists
DROP PROCEDURE IF EXISTS demo_cursors;

DELIMITER $$

CREATE PROCEDURE demo_cursors()
BEGIN
    DECLARE v_roll INT;
    DECLARE v_name VARCHAR(50);
    DECLARE v_marks INT;
    DECLARE done INT DEFAULT FALSE;

    -- Cursor for all students
    DECLARE student_cur CURSOR FOR
        SELECT roll_no, name, marks FROM student;

    -- Handler for end of result set
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Implicit cursor example (MySQL handles it)
    UPDATE student
    SET marks = marks + 1
    WHERE roll_no = 2;

    SELECT ROW_COUNT() AS Rows_Updated;

    -- Explicit cursor example with LOOP
    SET done = FALSE;
    OPEN student_cur;

    read_loop: LOOP
        FETCH student_cur INTO v_roll, v_name, v_marks;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT CONCAT('Student: ', v_roll, ' - ', v_name, ' - ', v_marks)
               AS Student_Details;
    END LOOP;

    CLOSE student_cur;

    -- Inner block: cursor with filter (high scorers)
    BEGIN
        DECLARE done2 INT DEFAULT FALSE;
        DECLARE v_name2 VARCHAR(50);
        DECLARE v_marks2 INT;

        DECLARE high_scorers CURSOR FOR
            SELECT name, marks
            FROM student
            WHERE marks > 80;

        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = TRUE;

        OPEN high_scorers;

        high_loop: LOOP
            FETCH high_scorers INTO v_name2, v_marks2;
            IF done2 THEN
                LEAVE high_loop;
            END IF;

            SELECT CONCAT(v_name2, ' scored ', v_marks2) AS High_Scorer;
        END LOOP;

        CLOSE high_scorers;
    END;
END $$
DELIMITER ;

-- Execute procedure
CALL demo_cursors();