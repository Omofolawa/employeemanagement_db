CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

[Department] 1 --- ∞ [Employee]
-------------------------------------
| DepartmentID (PK) |  | EmployeeID (PK)  |
| DepartmentName    |  | FirstName         |
                        | LastName          |
                        | DepartmentID (FK) |
                        | DateOfBirth       |
                        | DateOfJoining     |
                        | Email             |
                        | PhoneNumber       |
--------------------------------------------

[Employee] 1 --- ∞ [Salary]
-----------------------------------------
| EmployeeID (PK) |  | SalaryID (PK)    |
|                 |  | EmployeeID (FK)  |
|                 |  | SalaryAmount     |
|                 |  | SalaryDate       |
-----------------------------------------

[Employee] 1 --- ∞ [Attendance]
--------------------------------------------
| EmployeeID (PK) |  | AttendanceID (PK)   |
|                 |  | EmployeeID (FK)     |
|                 |  | Date                |
|                 |  | Status              |
--------------------------------------------

[Project] 1 --- ∞ [EmployeeProject]
------------------------------------------
| ProjectID (PK)  |  | EmployeeProjectID (PK) |
| ProjectName     |  | EmployeeID (FK)        |
| StartDate       |  | ProjectID (FK)         |
| EndDate         |  | Role                   |
----------------------------------------------

[Employee] 1 --- ∞ [EmployeeProject]
------------------------------------------
| EmployeeID (PK) |  | EmployeeProjectID (PK) |
|                 |  | EmployeeID (FK)        |
|                 |  | ProjectID (FK)         |
|                 |  | Role                   |
----------------------------------------------

CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
--validation data
INSERT INTO Departments (DepartmentName) VALUES 
('Human Resources'), 
('Finance'), 
('Engineering'), 
('Marketing');



CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    DateOfBirth DATE,
    DateOfJoining DATE,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
--validation data
INSERT INTO Employees (FirstName, LastName, DepartmentID, DateOfBirth, DateOfJoining, Email, PhoneNumber) VALUES 
('John', 'Doe', 1, '1980-01-01', '2020-01-15', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', 2, '1985-02-02', '2019-03-10', 'jane.smith@example.com', '0987654321'),
('Michael', 'Brown', 3, '1990-03-03', '2018-05-20', 'michael.brown@example.com', '1122334455'),
('Emily', 'Davis', 4, '1995-04-04', '2021-07-25', 'emily.davis@example.com', '2233445566');


CREATE TABLE Salaries (
    SalaryID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    SalaryAmount DECIMAL(10, 2) NOT NULL,
    SalaryDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
--validation data
INSERT INTO Salaries (EmployeeID, SalaryAmount, SalaryDate) VALUES 
(1, 5000.00, '2023-01-31'),
(2, 4500.00, '2023-01-31'),
(3, 6000.00, '2023-01-31'),
(4, 4000.00, '2023-01-31');


CREATE TABLE Attendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    Status ENUM('Present', 'Absent', 'Leave') NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
--validation data
INSERT INTO Attendance (EmployeeID, Date, Status) VALUES 
(1, '2023-05-01', 'Present'),
(2, '2023-05-01', 'Absent'),
(3, '2023-05-01', 'Present'),
(4, '2023-05-01', 'Leave');


CREATE TABLE Projects (
    ProjectID INT AUTO_INCREMENT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE
);
--validation data
INSERT INTO Projects (ProjectName, StartDate, EndDate) VALUES 
('Project Alpha', '2023-01-01', '2023-06-30'),
('Project Beta', '2023-02-01', '2023-08-31');


CREATE TABLE EmployeeProjects (
    EmployeeProjectID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    ProjectID INT,
    Role VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
--validation data
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role) VALUES 
(1, 1, 'Manager'),
(2, 1, 'Developer'),
(3, 2, 'Tester'),
(4, 2, 'Developer');

--VIEWS & STORED PROCEDURES--
CREATE VIEW EmployeeView AS
SELECT 
    e.employee_id, 
    e.first_name, 
    e.last_name, 
    e.email, 
    d.department_name, 
    s.salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
JOIN Salaries s ON e.employee_id = s.employee_id
WHERE s.to_date IS NULL;

CREATE VIEW DepartmentEmployeeCountView AS
SELECT 
    d.department_name, 
    COUNT(e.employee_id) AS employee_count
FROM Departments d
LEFT JOIN Employees e ON d.department_id = e.department_id
GROUP BY d.department_name;
--USE CASE--
SELECT * FROM DepartmentEmployeeCountView;


CREATE PROCEDURE AddEmployee (
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_phone_number VARCHAR(20),
    IN p_hire_date DATE,
    IN p_job_id VARCHAR(10),
    IN p_salary DECIMAL(10, 2),
    IN p_department_id INT
)
BEGIN
    DECLARE emp_id INT;
    INSERT INTO Employees (first_name, last_name, email, phone_number, hire_date, job_id, salary, department_id)
    VALUES (p_first_name, p_last_name, p_email, p_phone_number, p_hire_date, p_job_id, p_salary, p_department_id);
    SET emp_id = LAST_INSERT_ID();
    INSERT INTO Salaries (employee_id, salary, from_date, to_date)
    VALUES (emp_id, p_salary, p_hire_date, NULL);
END;
--USE Case--
CALL AddEmployee('John', 'Doe', 'john.doe@example.com', '555-1234', '2024-05-24', 'DEV', 60000, 1);

CREATE PROCEDURE UpdateEmployeeSalary (
    IN p_employee_id INT,
    IN p_new_salary DECIMAL(10, 2),
    IN p_effective_date DATE
)
BEGIN
    UPDATE Salaries 
    SET to_date = p_effective_date
    WHERE employee_id = p_employee_id AND to_date IS NULL;
    
    INSERT INTO Salaries (employee_id, salary, from_date, to_date)
    VALUES (p_employee_id, p_new_salary, p_effective_date, NULL);
    
    UPDATE Employees 
    SET salary = p_new_salary
    WHERE employee_id = p_employee_id;
END;
--USE CASE--
CALL UpdateEmployeeSalary(1, 65000, '2024-06-01');


CREATE PROCEDURE GetEmployeeDetails (
    IN p_employee_id INT
)
BEGIN
    SELECT 
        e.employee_id, 
        e.first_name, 
        e.last_name, 
        e.email, 
        e.phone_number, 
        e.hire_date, 
        e.job_id, 
        e.salary, 
        d.department_name
    FROM Employees e
    JOIN Departments d ON e.department_id = d.department_id
    WHERE e.employee_id = p_employee_id;
END;
--USE CASE--
CALL GetEmployeeDetails(1);


CREATE PROCEDURE RemoveEmployee (
    IN p_employee_id INT
)
BEGIN
    DELETE FROM Salaries WHERE employee_id = p_employee_id;
    DELETE FROM Employees WHERE employee_id = p_employee_id;
END;
--USE CASE--
CALL RemoveEmployee(1);