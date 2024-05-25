--Parameter Definitions:
--@p_first_name, @p_last_name, @p_email, @p_phone_number, @p_hire_date, @p_job_id, @p_salary, 
--@p_department_id: Parameters for the procedure, matching the respective column data types.
--BEGIN TRY...END TRY and BEGIN CATCH...END CATCH are used to handle transactions and exceptions. 
--If an error occurs, the transaction is rolled back.
--The INSERT INTO Employees statement adds a new employee.
--SCOPE_IDENTITY() Function is used to retrieve the last inserted identity value and ensures the...
--The INSERT INTO Salaries statement adds a corresponding salary record for the new employee.
--The transaction is committed if both inserts succeed.
--The transaction is rolled back if any error occurs, ensuring data integrity.

CREATE PROCEDURE AddEmployee
    @p_first_name NVARCHAR(100),
    @p_last_name NVARCHAR(100),
    @p_email NVARCHAR(100),
    @p_phone_number NVARCHAR(15),
    @p_date_of_birth DATE,
    @p_date_of_joining DATE,
    @p_salary DECIMAL(10, 2),
    @p_department_id INT
AS
BEGIN
    SET NOCOUNT ON;

	--Declaring a local variable named @emp_id of data type INT to store the newly inserted employee's ID.
    DECLARE @emp_id INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Employees (FirstName, LastName, Email, PhoneNumber, DateOfBirth, DateOfJoining, DepartmentID)
        VALUES (@p_first_name, @p_last_name, @p_email, @p_phone_number, @p_date_of_birth, @p_date_of_joining, @p_department_id);

		--Retrieves the last identity value generated in the current scope 
		--(in this case, the newly inserted employee's ID) and assigns it to @emp_id.
        SET @emp_id = SCOPE_IDENTITY();

        INSERT INTO Salaries (EmployeeID, SalaryAmount, SalaryDate)
        VALUES (@emp_id, @p_salary, @p_date_of_joining);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
