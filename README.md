# **Stored Procedure** 

## What is a Stored Procedure?
A stored procedure is a precompiled collection of one or more SQL statements stored 
in the database. It can be executed multiple times with different parameters, 
allowing for efficient reuse of logic, reduced duplication, and better performance.
Stored procedures support input parameters, allow encapsulation of logic, and can perform a wide range of operations like data manipulation, validation, transactions, and reporting.

![Stored Procedure](./images/StoredProcedures.png)

## Benefits of Stored Procedures?

**1. Performance Optimization:**

- Stored procedures are compiled once and stored as executable plans.
- On subsequent calls, the database reuses the compiled plan, speeding up execution.
- 
**2. Reduced Network Traffic:**

- Since stored procedures encapsulate multiple SQL statements, only the procedure call is sent over the network, not each individual SQL statement.

**3. Improved Security:**

- Users can be granted permission to execute a stored procedure without having direct access to underlying tables.
- Using EXECUTE AS can impersonate specific users and protect sensitive data.

**4. Code Reusability & Maintainability:**

- Avoids repeating code for repetitive tasks.
- If changes are needed, only the stored procedure needs to be updated—not every application or client that uses it.

**5. Error Handling:**

- SQL Server supports error handling with TRY...CATCH blocks inside procedures.

**6. Modularity & Abstraction:**

- Procedures let you abstract complex SQL logic away from client applications.
- Parameters can be used for dynamic input.

## Disadvantages of using stored procedures?
**1. Increased Overhead:**

Stored procedures can consume more server resources than simple SQL statements, 
particularly when they are used frequently or for complex operations.

**2. Limited Portability:**

Stored procedures are often specific to a particular database management system (DBMS), 
which means they may not be easily portable to other DBMSs.

**3. Debugging Challenges:**

Debugging stored procedures can be more challenging than debugging simple SQL statements, 
due to the complexity of their execution environment and the potential for interactions 
with other stored procedures or database objects.

**4. Security Risks:**

If stored procedures are not written correctly, they can pose a security risk, 
particularly if they are used to access sensitive data or to perform actions 
that could compromise the integrity of the database.

## Types of stored procedures?
**1. User-defined:**

A user-defined procedure can be created in a user-defined database or in all system 
databases except the Resource database. The procedure can be developed in either 
Transact-SQL, or as a reference to a Microsoft .NET Framework common runtime 
language (CLR) method.

**2. Temporary:**

Temporary procedures are a form of user-defined procedures. Temporary procedures are 
like a permanent procedure, except that they're stored in tempdb. There are two types 
of temporary procedures: local and global. They differ from each other in their names, 
their visibility, and their availability. Local temporary procedures have a single 
number sign (#) as the first character of their names; they're visible only to the 
current user connection, and they're deleted when the connection is closed. 
Global temporary procedures have two number signs (##) as the first two 
characters of their names; they're visible to any user after they are created, 
and they're deleted at the end of the last session using the procedure.

**3. System:**

System procedures are included with the Database Engine. They are physically 
stored in the internal, hidden Resource database and logically appear in the 
sys schema of every system-defined and user-defined database. In addition, 
the msdb database also contains system stored procedures in the dbo schema 
that are used for scheduling alerts and jobs. Because system procedures 
start with the prefix sp_, we recommend that you don't use this prefix 
when naming user-defined procedures. For a complete list of system procedures, 
see System stored procedures (Transact-SQL).SQL Server supports the system 
procedures that provide an interface from SQL Server to external programs 
for various maintenance activities. These extended procedures use the xp_ prefix. 
For a complete list of extended procedures, see General 
extended stored procedures (Transact-SQL).

**4. Extended user-defined:**

Extended procedures enable creating external routines in a programming language such as C. 
These procedures are DLLs that an instance of SQL Server can dynamically load and run.

**~~NOTE:~~ Extended stored procedures will be removed in a future version of SQL Server. 
Don't use this feature in new development work.**