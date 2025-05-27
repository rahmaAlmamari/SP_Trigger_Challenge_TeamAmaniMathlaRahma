# **Error Log:**

## 1. Case one:
We are trying to run the execution for the stored procedure with multiple parameters as the following:
```sql
-- How to Execute It
-- Declare a variable to hold the output
DECLARE @Result DECIMAL(10, 2);
-- Call the procedure
EXEC CalculateTotalSalaryByDepartment
    @DepartmentID = 101,
    @TotalSalary = @Result OUTPUT;
-- Display the result
SELECT @Result AS TotalSalary;
```
what we did is that we run each line saperately, first we run:
```sql
DECLARE @Result DECIMAL(10, 2);
```
and it was succefully run but when we try to run the next line:
```sql
EXEC CalculateTotalSalaryByDepartment
    @DepartmentID = 101,
    @TotalSalary = @Result OUTPUT;
```
we got the following error:
```sql
Must declare the scalar variable "@Result".
```
This error occurs because the variable `@Result` is not declared 
in the context where it is being used. In SQL Server, 
variables must be declared before they can be used, 
but we already declared it in the previous line. 
at the end we understand that the issue is that 
we are trying to run each line separately, we should run all the lines together.