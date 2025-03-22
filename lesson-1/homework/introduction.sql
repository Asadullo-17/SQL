--Easy

--Definitions

- **Data**: Raw facts or figures that can be processed to generate meaningful information.  
- **Database**: An organized collection of structured data stored electronically for easy access, retrieval, and management.  
- **Relational Database**: A type of database that stores data in structured tables with predefined relationships between them using keys.  
- **Table**: A structured format in a relational database consisting of rows (records) and columns (fields) to store data.  

-- Five Key Features of SQL Server

1. **High Availability & Disaster Recovery (HADR)** – Ensures data availability through failover clustering and Always On availability groups.  
2. **Security** – Supports encryption, role-based access control, and authentication mechanisms.  
3. **Scalability & Performance** – Optimized indexing, in-memory processing, and query optimization.  
4. **Business Intelligence (BI) Integration** – Includes tools like SQL Server Reporting Services (SSRS) and SQL Server Analysis Services (SSAS).  
5. **Advanced Data Types & JSON Support** – Handles XML, JSON, and spatial data efficiently.  

--SQL Server Authentication Modes

1. **Windows Authentication** – Uses Active Directory credentials for secure access.  
2. **SQL Server Authentication** – Requires a separate username and password managed by SQL Server.

  --Medium
# Create a New Database in SSMS

To create a database named `SchoolDB` in SQL Server Management Studio (SSMS), use the following query:

```sql
CREATE DATABASE SchoolDB;

USE SchoolDB;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

SQL Server: A relational database management system (RDBMS) developed by Microsoft to store, retrieve, and manage data.

SSMS (SQL Server Management Studio): A graphical user interface (GUI) tool used to interact with SQL Server, manage databases, and execute queries.

SQL (Structured Query Language): A standard programming language used to interact with relational databases, including SQL Server.
SQL Server: A relational database management system (RDBMS) developed by Microsoft to store, retrieve, and manage data.

SSMS (SQL Server Management Studio): A graphical user interface (GUI) tool used to interact with SQL Server, manage databases, and execute queries.

SQL (Structured Query Language): A standard programming language used to interact with relational databases, including SQL Server.
