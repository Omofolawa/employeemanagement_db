# employeemanagement_db
The Employee Database is designed to manage and track information about departments, employees, salaries, attendance, and projects within an organization.

The schema defines several entities and their relationships as follows:

Departments and Employees: Each department can have many employees, but each employee belongs to only one department.
Employees and Salaries: Each employee can have multiple salary records over time, tracking changes in compensation.
Employees and Attendance: Attendance records track each employee's presence or absence on specific dates.
Projects and Employees: Projects can have multiple employees assigned, and employees can work on multiple projects, with roles specified for each project assignment.
EmployeeProject: This table serves as a junction table to handle the many-to-many relationship between employees and projects, capturing details like the role of the employee in the project.

This schema provides a comprehensive structure to manage employee-related data, including their association with departments, financial records, attendance tracking, and project involvement.
