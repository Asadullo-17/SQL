CREATE DATABASE Company_DB;
USE Company_DB;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20) UNIQUE,
    HireDate DATE NOT NULL,
    DepartmentID INT,
    PositionID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (PositionID) REFERENCES Positions(PositionID)
);


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL,
    ManagerID INT,
    Location VARCHAR(100),
    Budget DECIMAL(10,2),
    Status ENUM('Active', 'Inactive') NOT NULL,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Positions (
    PositionID INT PRIMARY KEY AUTO_INCREMENT,
    PositionName VARCHAR(100) NOT NULL,
    MinimumSalary DECIMAL(10,2),
    MaximumSalary DECIMAL(10,2),
    DepartmentID INT,
    RequiredExperience INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    SalaryAmount DECIMAL(10,2) NOT NULL,
    Bonus DECIMAL(10,2),
    Deductions DECIMAL(10,2),
    PaymentDate DATE NOT NULL,
    TaxAmount DECIMAL(10,2),
    NetSalary DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    Date DATE NOT NULL,
    CheckInTime TIME NOT NULL,
    CheckOutTime TIME,
    TotalHoursWorked DECIMAL(5,2),
    OvertimeHours DECIMAL(5,2),
    Status ENUM('Present', 'Absent', 'Leave') NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE WorkShifts (
    ShiftID INT PRIMARY KEY AUTO_INCREMENT,
    ShiftName VARCHAR(50) NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    ShiftType ENUM('Day', 'Night') NOT NULL,
    Status ENUM('Active', 'Inactive') NOT NULL
);

CREATE TABLE EmployeeShifts (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    ShiftID INT,
    AssignedDate DATE NOT NULL,
    Status ENUM('Active', 'Inactive') NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ShiftID) REFERENCES WorkShifts(ShiftID)
);

CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    ReviewDate DATE NOT NULL,
    ReviewerID INT,
    PerformanceScore INT CHECK (PerformanceScore BETWEEN 1 AND 10),
    Comments TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ReviewerID) REFERENCES Employees(EmployeeID)
);
