# **Stored Procedure** 

## What is a Stored Procedure?
A stored procedure is a group of prepared SQL code that you can save, 
so the code can be reused over and over again by simply calling it whenever needed.

It can be used to perform a wide range of database operations 
such as inserting, updating, or deleting data, generating reports, 
and performing complex calculations. Stored procedures are very useful 
because they allow you to encapsulate (bundle) a set of SQL statements as 
a single unit and execute them repeatedly with different parameters, 
making it easy to manage and reuse the code.

![Stored Procedure](./images/StoredProcedures.png)

## Advantage of using stored procedures?
**1. Reduced server/client network traffic:** 

The commands in a procedure are executed as a single batch of code. 
This can significantly reduce network traffic between the server 
and client because only the call to execute the procedure is sent 
across the network. Without the code encapsulation provided by a procedure, 
every individual line of code would have to cross the network.

**2. Stronger security:**

Multiple users and client programs can perform operations on underlying database 
objects through a procedure, even if the users and programs don't have direct 
permissions on those underlying objects. The procedure controls what processes and 
activities are performed and protects the underlying database objects. 
This eliminates the requirement to grant permissions at the individual 
object level and simplifies the security layers.The EXECUTE AS clause can 
be specified in the CREATE PROCEDURE statement to enable impersonating 
another user, or enable users or applications to perform certain database 
activities without needing direct permissions on the underlying objects and 
commands.When an application calls a procedure over the network, only the call 
to execute the procedure is visible. Therefore, malicious users can't see table 
and database object names, embed Transact-SQL statements of their own, or search 
for critical data.

**3. Reuse of code:**

The code for any repetitious database operation is the perfect candidate for 
encapsulation in procedures. This eliminates needless rewrites of the same code, 
decreases code inconsistency, and allows the access and execution of code by any 
user or application possessing the necessary permissions.

**4. Easier maintenance:**

When client applications call procedures and keep database operations in the 
data tier, only the procedures must be updated for any changes in the underlying 
database. The application tier remains separate and doesn't have to know how 
about any changes to database layouts, relationships, or processes.

**5. Improved performance:**

By default, a procedure compiles the first time it's executed, and creates an 
execution plan that is reused for subsequent executions. Since the query 
processor doesn't have to create a new plan, it typically takes less time to 
process the procedure.If there are significant changes to the tables or data 
referenced by the procedure, the precompiled plan might actually cause the 
procedure to perform slower. In this case, recompiling the procedure and forcing 
a new execution plan can improve performance.

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