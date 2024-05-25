-- Creates a procedure where an Employee Salary is modified using the emplyeeID as a Where Clause
-- It begins by updating the current salary record to indicate its end date
-- it then inserts a new salary record with the updated amount. 
-- Finally, it updates the employee's salary field in the Salary table. 
-- This ensures accurate historical salary data and reflects the new salary for the employee.

CREATE PROCEDURE UpdateEmployeeSalary 
    @p_employee_id INT,
    @p_new_salary DECIMAL(10, 2),
    @p_effective_date DATE = NULL
AS
BEGIN
    SET NOCOUNT ON; -- Suppress the "xx rows affected" message

    -- If @p_effective_date is NULL, set it to the current date
    IF @p_effective_date IS NULL
    BEGIN
        SET @p_effective_date = GETDATE();
    END

    BEGIN TRY
        BEGIN TRANSACTION; -- Starts a transaction

        -- Updates the Todate of the current salary record to mark its end
        UPDATE Salaries 
        SET ToDate = @p_effective_date
        WHERE EmployeeID = @p_employee_id AND ToDate = '9999-12-31';

        -- Insert a new salary record with the new salary
        INSERT INTO Salaries (EmployeeID, SalaryAmount, FromDate, ToDate)
        VALUES (@p_employee_id, @p_new_salary, @p_effective_date, '9999-12-31'); -- Set Todate to the future date representing "TBD"

        COMMIT TRANSACTION; -- Commits the transaction if all statements succeed
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION; -- Rollback the transaction if any error occurs

        -- Handle the error
        THROW;
    END CATCH;
END;


-- USE case
EXEC UpdateEmployeeSalary 
    @p_employee_id = 3,
    @p_new_salary = 9000;