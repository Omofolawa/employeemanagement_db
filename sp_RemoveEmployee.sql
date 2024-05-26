-- This store procedure is used to remove an employee and their associated salary records, 
-- The procedure takes @p_employee_id as an input parameter, deletes the corresponding records 
-- from the Salaries table, and then deletes the employee record from the Employees table.

CREATE PROCEDURE RemoveEmployee
    @p_employee_id INT
AS
BEGIN
    SET NOCOUNT ON; -- Suppress the "xx rows affected" message

    BEGIN TRY
        BEGIN TRANSACTION; -- Start a transaction

        -- Delete the salary records for the given employee
        DELETE FROM Salaries 
        WHERE EmployeeID = @p_employee_id;

        -- Delete the employee record
        DELETE FROM Employees 
        WHERE EmployeeID = @p_employee_id;

        COMMIT TRANSACTION; -- Commit the transaction if all statements succeed
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0        --
            ROLLBACK TRANSACTION; -- Rollback the transaction if any error occurs

        -- Handle the error (you can customize this part based on your requirements)
        THROW;
    END CATCH;
END;
GO
