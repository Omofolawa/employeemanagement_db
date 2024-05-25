CREATE DATABASE EmployeeManagement;
USE EmployeeManagement;

CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);
-- Insert validation data into Departments
INSERT INTO Departments (DepartmentName) VALUES 
('Human Resources'), 
('Finance'), 
('Engineering'), 
('Marketing');

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    DateOfBirth DATE,
    DateOfJoining DATE,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
-- Insert validation data into Employees
INSERT INTO Employees (FirstName, LastName, DepartmentID, DateOfBirth, DateOfJoining, Email, PhoneNumber) VALUES 
('Owen', 'Dylan', 1, '1980-01-01', '2020-01-15', 'owen.dylan@example.com', '1234567890'),
('Jane', 'Smith', 2, '1985-02-02', '2019-03-10', 'jane.smith@example.com', '0987654321'),
('Yomola', 'Brown', 3, '1990-03-03', '2018-05-20', 'yomola.brown@example.com', '1122334455'),
('Emily', 'Bob', 4, '1995-04-04', '2021-07-25', 'emily.bob@example.com', '2233445566');

CREATE TABLE Salaries (
    SalaryID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    SalaryAmount DECIMAL(10, 2) NOT NULL,
    FromDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

--  Syntax to alter Salaries Table to include a ToDate
ALTER TABLE Salaries
ADD ToDate DATE NOT NULL DEFAULT '2027-12-31'; -- Setting a future date for periodic Salary review

-- Insert validation data into Salaries
INSERT INTO Salaries (EmployeeID, SalaryAmount, SalaryDate) VALUES 
(1, 50000.00, '2020-01-15'),
(2, 45000.00, '2019-03-10'),
(3, 80000.00, '2018-05-20'),
(4, 40000.00, '2021-07-25');

CREATE TABLE Attendance (
    AttendanceID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Date DATE,
    Status VARCHAR(10) NOT NULL CHECK (Status IN ('Present', 'Absent', 'Leave')),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
-- Insert validation data into Attendance
INSERT INTO Attendance (EmployeeID, Date, Status) VALUES 
(1, '2023-05-01', 'Present'),
(2, '2023-05-01', 'Absent'),
(3, '2023-05-01', 'Present'),
(4, '2023-05-01', 'Leave');

CREATE TABLE Projects (
    ProjectID INT IDENTITY(1,1) PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE
);
-- Insert validation data into Projects
INSERT INTO Projects (ProjectName, StartDate, EndDate) VALUES 
('Project Boron', '2023-01-01', '2023-06-30'),
('Project Helium', '2023-02-01', '2023-08-31');

CREATE TABLE EmployeeProjects (
    EmployeeProjectID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    ProjectID INT,
    Role VARCHAR(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
-- Insert validation data into EmployeeProjects
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role) VALUES 
(1, 1, 'Manager'),
(2, 1, 'Developer'),
(3, 2, 'Cloud Architect'),
(4, 2, 'Tester');
