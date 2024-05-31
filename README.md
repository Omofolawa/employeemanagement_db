# employeemanagement_db
The Employee Database schema is designed to efficiently manage and track comprehensive information about departments, employees, salaries, attendance, and projects within an organization.

The schema defines several entities and their relationships as follows:

-Departments and Employees: Implemented with a one-to-many relationship, where each department can have multiple employees, but each employee is assigned to only one department. This relationship is crucial for organizational hierarchy and reporting.

-Employees and Salaries: Utilizing a temporal table structure, each employee can have multiple salary records over time. This setup allows for tracking changes in compensation, providing a historical view of salary adjustments and trends.

-Employees and Attendance: Attendance records are maintained to track each employee's presence or absence on specific dates. This entity is essential for analyzing attendance patterns, managing leave policies, and ensuring compliance with labor regulations.

-Projects and Employees: Reflecting a many-to-many relationship, projects can have multiple employees assigned, and employees can work on multiple projects. The role of each employee within a project is specified, enabling detailed project management and resource allocation.

-EmployeeProject: This junction table captures the many-to-many relationship between employees and projects. It stores additional details like the role of the employee in the project, start and end dates, and project-specific contributions, facilitating comprehensive project tracking and reporting.

Additionally, an audit log is maintained for all operations performed on the database. This critical function is powered by triggers associated with all the tables and an audit log table. The triggers capture and record changes, providing a backup of all data and ensuring transaction traceability. This feature enhances data integrity and security, allowing for a detailed audit trail of all database activities.

This schema provides a robust and scalable structure to manage employee-related data. It ensures data integrity and supports complex queries and analytics, enabling the organization to gain insights into workforce distribution, financial trends, attendance records, and project involvement. As a Data Engineer, this schema is designed to facilitate efficient data management, enhance data-driven decision-making, and support organizational growth while maintaining stringent audit and traceability standards.
