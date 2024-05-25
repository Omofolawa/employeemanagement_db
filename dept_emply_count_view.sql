--This view joins the Departments table with the Employees table on the DepartmentID field. 
--It groups the results by DepartmentName and counts the number of EmployeeIDs in each department. 
--The LEFT JOIN ensures that departments with no employees still appear in the result set with an 
--employee_count of 0.

CREATE VIEW DepartmentEmployeeCount AS
SELECT 
    d.DepartmentName AS department_name, 
    COUNT(e.EmployeeID) AS employee_count
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;
