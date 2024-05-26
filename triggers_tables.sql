-- Triggers to record CRUD operations and activities in the tables

CREATE TABLE AuditTable (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    AuditDateTime DATETIME DEFAULT GETDATE(),
    Operation NVARCHAR(10),
    TableName NVARCHAR(100),
    UserName NVARCHAR(100),
    InsertedData NVARCHAR(MAX)
);

--INSERT
CREATE TRIGGER trg_Audit_Insert_Employees
ON dbo.Employees
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'INSERT', 
        'Employees', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--UPDATE
CREATE TRIGGER trg_Audit_Update_Employees
ON dbo.Employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'UPDATE', 
        'Employees', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO
-- DELETE
CREATE TRIGGER trg_Audit_Delete_Employees
ON dbo.Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'DELETE', 
        'Employees', 
        SYSTEM_USER, 
        (SELECT * FROM deleted FOR JSON PATH);
END;
GO

-- SALARIES TABLE
--INSERT
CREATE TRIGGER trg_Audit_Insert_Salaries
ON dbo.Salaries
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'INSERT', 
        'Salaries', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--UPDATE
CREATE TRIGGER trg_Audit_Update_Salaries
ON dbo.Salaries
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'UPDATE', 
        'Salaries', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--DELETE
CREATE TRIGGER trg_Audit_Delete_Salaries
ON dbo.Salaries
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'DELETE', 
        'Salaries', 
        SYSTEM_USER, 
        (SELECT * FROM deleted FOR JSON PATH);
END;
GO

--ATTENDANCE
--INSERT
CREATE TRIGGER trg_Audit_Insert_Attendance
ON dbo.Attendance
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'INSERT', 
        'Attendance', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--UPDATE
CREATE TRIGGER trg_Audit_Update_Attendance
ON dbo.Attendance
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'UPDATE', 
        'Attendance', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--DELETE
CREATE TRIGGER trg_Audit_Delete_Attendance
ON dbo.Attendance
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'DELETE', 
        'Attendance', 
        SYSTEM_USER, 
        (SELECT * FROM deleted FOR JSON PATH);
END;
GO

--DEPARTMENT
--INSERT
CREATE TRIGGER trg_Audit_Insert_Departments
ON dbo.Departments
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'INSERT', 
        'Departments', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--UPDATE
CREATE TRIGGER trg_Audit_Update_Departments
ON dbo.Departments
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'UPDATE', 
        'Departments', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--DELETE
CREATE TRIGGER trg_Audit_Delete_Departments
ON dbo.Departments
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'DELETE', 
        'Departments', 
        SYSTEM_USER, 
        (SELECT * FROM deleted FOR JSON PATH);
END;
GO

--PROJECTS
--INSERT
CREATE TRIGGER trg_Audit_Insert_Projects
ON dbo.Projects
AFTER INSERT
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'INSERT', 
        'Projects', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--UPDATE
CREATE TRIGGER trg_Audit_Update_Projects
ON dbo.Projects
AFTER UPDATE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'UPDATE', 
        'Projects', 
        SYSTEM_USER, 
        (SELECT * FROM inserted FOR JSON PATH);
END;
GO

--DELETE
CREATE TRIGGER trg_Audit_Delete_Projects
ON dbo.Projects
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditTable (Operation, TableName, UserName, InsertedData)
    SELECT 
        'DELETE', 
        'Projects', 
        SYSTEM_USER, 
        (SELECT * FROM deleted FOR JSON PATH);
END;
GO
