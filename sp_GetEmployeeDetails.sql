--  This procedure is is designed to retrieve comprehensive information about a specific 
--  employee based on their employee ID.

CREATE PROCEDURE GetEmployeeDetails 
    @p_employee_id INT
AS
BEGIN
    SET NOCOUNT ON; -- Suppress the "xx rows affected" message

SELECT  
    e.EmployeeID AS Person_ID, 
    e.FirstName AS F_Name, 
    e.LastName AS L_Name,  
    e.DateOfBirth AS DOB, 
    e.DateOfJoining AS DOJ, 
    e.Email AS Email, 
    e.PhoneNumber AS Mobile,
    e.DepartmentID AS Dept_ID,
    d.DepartmentName AS Dept_Name,
    s.SalaryAmount AS Take_Home_Pay,
	s. FromDate AS Pay_Start
FROM Employees e
    INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
    INNER JOIN Salaries s ON s.EmployeeID = e.EmployeeID
WHERE e.EmployeeID = @p_employee_id
    AND s.ToDate = '9999-12-31'; -- This syntax Ensures it gets the current salary record
END;
GO

-- USE CASE --
-- Retrieve details for the employee with ID 3
EXEC GetEmployeeDetails @p_employee_id = 3;

