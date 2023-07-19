CREATE TABLE Departments (
Code INTEGER PRIMARY KEY NOT NULL ,
Name VARCHAR (25) NOT NULL ,
Budget REAL NOT NULL
);

CREATE TABLE Employees (
SSN INTEGER PRIMARY KEY NOT NULL ,
Name TEXT NOT NULL ,
LastName VARCHAR (25) NOT NULL ,
Department INTEGER NOT NULL ,
CONSTRAINT fk_Departments_Code FOREIGN KEY (Department)
REFERENCES Departments(Code)
);

INSERT INTO Departments(Code,Name,Budget) VALUES(14,"IT",65000);
INSERT INTO Departments(Code,Name,Budget) VALUES(37,"Accounting",15000);
INSERT INTO Departments(Code,Name,Budget) VALUES(59,"Human Resources",240000);
INSERT INTO Departments(Code,Name,Budget) VALUES(77,"Research",55000);

INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(123234877,"Michael","Rogers",14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(152934485,"Anand","Manikutty",14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(222364883,"Carol","Smith",37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(26587417,"Joe","Stevens",37);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(332154719,"Mary-Anne","Foster",14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(332569843,"George","O‘Donnell",77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(546523478,"John","Doe",59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(631231482,"David","Smit",77);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(654873219,"Zacary","Efron",59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(745685214,"Eric","Goldsmith",59);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(845657245,"Elizabeth","Doe",14);
INSERT INTO Employees(SSN,Name,LastName,Department) VALUES(845657246,"Kumar","Swamy",14);

# 1. Select the last name of all employees.
SELECT LastName
FROM Employees;

# 2. Select the last name of all employees, without duplicates.
SELECT DISTINCT LastName
FROM Employees;

# 3. Select all the data of employees whose last name is “Smith”.
SELECT *
FROM Employees
WHERE LastName = 'Smith';

# 4. Select all the data of employees whose last name is “Smith” or “Doe”.
SELECT *
FROM Employees
WHERE LastName = 'Smith' OR LastName = 'Doe';

# 5. Select all the data of employees that work in department 14.
SELECT *
FROM Employees
WHERE Department = 14;

# 6. Select all the data of employees that work in department 37 or department 77.
SELECT *
FROM Employees
WHERE Department IN (37, 77);

# 7. Select all the data of employees whose last name begins with an “S”.
SELECT *
FROM Employees
WHERE LastName LIKE 'S%';

# 8. Select the sum of all the departments’ budgets.
SELECT SUM(Budget) AS total_budget
FROM Departments;

# 9. Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT Department, COUNT(*) AS num_employees
FROM Employees
GROUP BY Department;

# 10. Select all the data of employees, including each employee’s department’s data.
SELECT *
FROM Employees
JOIN Departments ON Employees.Department = Departments.Code;

# 11. Select the name and last name of each employee, along with the name and budget of the employee’s department.
SELECT Employees.Name, Employees.LastName, Departments.Name AS dept_name, Departments.Budget
FROM Employees
JOIN Departments ON Employees.Department = Departments.Code;

# 12. Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT Employees.Name, Employees.LastName
FROM Employees
JOIN Departments ON Employees.Department = Departments.Code
WHERE Departments.Budget > 60000;

# 13. Select the departments with a budget larger than the average budget of all the departments.
SELECT Name, Budget
FROM Departments
HAVING Budget > (SELECT AVG(Budget) FROM Departments);

# 14. Select the names of departments with more than two employees.
SELECT Departments.Name
FROM Departments
JOIN Employees ON Departments.Code = Employees.Department
GROUP BY Departments.Name
HAVING COUNT(*) > 2;

# 15. Select the name and last name of employees working for departments with second lowest budget.
SELECT e.Name, e.LastName
FROM Employees e
JOIN Departments d ON e.Department = d.Code
WHERE d.Budget = (
    SELECT MIN(Budget)
    FROM Departments
    WHERE Budget > (
        SELECT MIN(Budget)
        FROM Departments
    )
);

# 16. Add a new department called “Quality Assurance”, with a budget of $40,000 and departmental code 11. 
# Add an employee called “Mary Moore” in that department, with SSN 847-21-9811.
INSERT INTO Departments (Code, Name, Budget)
VALUES (11, 'Quality Assurance', 40000);

INSERT INTO Employees (SSN, Name, LastName, Department)
VALUES (847-21-9811, "Mary", "Moore", 11);

# 17. Reduce the budget of all departments by 10%.
UPDATE Departments
SET Budget = 0.9 * Budget;

# 18. Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE Employees
SET Department = 14
WHERE Department = 77;

# 19. Delete from the table all employees in the IT department (code 14).
DELETE FROM Employees
WHERE Department = 14;

# 20. Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM Employees
WHERE Department IN (
    SELECT Code
    FROM Departments
    WHERE Budget >= 60000
);

# 21. Delete from the table all employees.
DELETE FROM Employees;