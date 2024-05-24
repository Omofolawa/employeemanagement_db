--This view joins the Employees, Departments, and Salaries tables. 
--It retrieves the employee's first name, last name, email, department name, and salary. 
--The WHERE clause ensures that only the most recent salary for each employee is included in the view.

CREATE VIEW EmployeeView AS
SELECT 
    e.EmployeeID AS employee_id, 
    e.FirstName AS first_name, 
    e.LastName AS last_name, 
    e.Email AS email, 
    d.DepartmentName AS department_name, 
    s.SalaryAmount AS salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Salaries s ON e.EmployeeID = s.EmployeeID
WHERE s.SalaryDate = (
    SELECT MAX(SalaryDate)
    FROM Salaries
    WHERE EmployeeID = e.EmployeeID
);
