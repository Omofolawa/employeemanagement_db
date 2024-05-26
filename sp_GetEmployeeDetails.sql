--  This procedure is is designed to retrieve comprehensive information about a specific 
--  employee based on their employee ID.

CREATE PROCEDURE GetEmployeeDetails 
    @p_employee_id INT
AS
BEGIN
    SET NOCOUNT ON; -- Suppress the "xx rows affected" message

    SELECT 
        e.EmployeeID AS employee_id, 
        e.FirstName AS first_name, 
        e.LastName AS last_name, 
        e.Email AS email, 
        e.PhoneNumber AS phone_number, 
        e.DateOfJoining AS hire_date, 
        d.DepartmentName AS department_name,
        s.SalaryAmount AS current_salary,
        s.FromDate AS pay_start_date
    FROM Employees e
    INNER JOIN Departments d ON e.DepartmentID = e.DepartmentID
    INNER JOIN Salaries s ON s.EmployeeID = e.EmployeeID
    WHERE e.EmployeeID = @p_employee_id
      AND s.ToDate = '9999-12-31'; -- This syntax Ensures it gets the current salary record
END;
GO
