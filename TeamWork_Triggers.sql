-- Here's the SQL Server syntax for creating:
-- DDL Triggers (for CREATE TABLE, ALTER TABLE, DROP TABLE)
-- DML Triggers (for INSERT, UPDATE, DELETE)
-- Logon Trigger
---
-- Create database
Create database TriggerDB
-- USE Database
USE TriggerDB

-- 1. DDL Trigger: CREATE, ALTER, DROP TABLE
-- Step 1: Create a log table

CREATE TABLE ddl_log (
    EventType      NVARCHAR(100),
    ObjectName     NVARCHAR(256),
    ObjectType     NVARCHAR(100),
    EventTime      DATETIME DEFAULT GETDATE(),
    LoginName      NVARCHAR(100)
);

-- Step 2: Create the DDL trigger

CREATE TRIGGER trg_ddl_table_events
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @EventData XML = EVENTDATA();
    INSERT INTO ddl_log (EventType, ObjectName, ObjectType, LoginName)
    VALUES (
        @EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
        @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)'),
        @EventData.value('(/EVENT_INSTANCE/ObjectType)[1]', 'NVARCHAR(100)'),
        @EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'NVARCHAR(100)')
    );
END;

-- Step 3: Check Execution of DDL Trigger

select * from ddl_log;

-- 2. DML Trigger: INSERT, UPDATE, DELETE
-- Step 1: Create a table to track employee activity

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name NVARCHAR(100),
    position NVARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employees VALUES (1, 'Alice', 'Manager', 7000.00);


-- Step 2: Create DML log table

CREATE TABLE dml_log (
    ActionType   NVARCHAR(10),
    EmpID        INT,
    ActionTime   DATETIME DEFAULT GETDATE(),
    PerformedBy  NVARCHAR(100)
);

-- Step 3: Create the triggers
-- Insert Trigger

CREATE TRIGGER trg_employees_insert
ON employees
AFTER INSERT
AS
BEGIN
    INSERT INTO dml_log (ActionType, EmpID, PerformedBy)
    SELECT 'INSERT', emp_id, SYSTEM_USER
    FROM inserted;
END;

-- Update Trigger

CREATE TRIGGER trg_employees_update
ON employees
AFTER UPDATE
AS
BEGIN
    INSERT INTO dml_log (ActionType, EmpID, PerformedBy)
    SELECT 'UPDATE', emp_id, SYSTEM_USER
    FROM inserted;
END;

-- Delete Trigger

CREATE TRIGGER trg_employees_delete
ON employees
AFTER DELETE
AS
BEGIN
    INSERT INTO dml_log (ActionType, EmpID, PerformedBy)
    SELECT 'DELETE', emp_id, SYSTEM_USER
    FROM deleted;
END;
-- Step 3: Modifying the employee table to run the terigger MDL 
INSERT INTO employees VALUES (2, 'Ali', 'Manager', 9000.00);
INSERT INTO employees VALUES (3, 'Mathla', 'Manager', 10000.00);
Update employees set name = 'Rahma' where emp_id =2
Update employees set name = 'Amani' where emp_id =1
delete from employees where emp_id =3
-- Step 4: Check Execution of DML Trigger

select * from dml_log;

-- 3. Logon Trigger (on SQL Server Instance)
-- Requires server-level permissions
-- Step 1: Create a server-level log table

USE master;
GO
CREATE TABLE login_log (
    LoginTime   DATETIME DEFAULT GETDATE(),
    LoginName   NVARCHAR(100),
    HostName    NVARCHAR(100),
    AppName     NVARCHAR(100)
);

-- Step 2: Create the logon trigger

CREATE TRIGGER trg_logon
ON ALL SERVER
FOR LOGON
AS
BEGIN
    INSERT INTO master.dbo.login_log (LoginName, HostName, AppName)
    VALUES (
        ORIGINAL_LOGIN(),
        HOST_NAME(),
        APP_NAME()
    );
END;

-- Step 3: Check Execution of LOGON Trigger
-- to check if the trigger enable or not
SELECT name, is_disabled
FROM sys.server_triggers
WHERE name = 'trg_logon';

-- makeing the trigger enable
ENABLE TRIGGER trg_logon ON ALL SERVER;

-- to display trg_logon
USE master;
GO
SELECT * FROM login_log ORDER BY LoginTime DESC;