-- Create the database
CREATE DATABASE library_mgmt;
USE library_mgmt;

-- READER TABLE
CREATE TABLE Reader (
    Reader_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(10) UNIQUE NOT NULL,
    JoinDate DATE NOT NULL
);

-- BOOK TABLE
CREATE TABLE Book (
    Book_ID INT PRIMARY KEY AUTO_INCREMENT,
    Book_Name VARCHAR(200) NOT NULL,
    Author VARCHAR(200) NOT NULL,
    Publish_Year INT,
    Avail_Copies INT DEFAULT 1
);

-- LIBRARIAN TABLE
CREATE TABLE Librarian (
    Librarian_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(10) UNIQUE NOT NULL,
    HireDate DATE NOT NULL
);

-- BORROWING/LOAN TABLE
CREATE TABLE Borrowing_Loan (
    Loan_ID INT PRIMARY KEY AUTO_INCREMENT,
    Reader_ID INT NOT NULL,
    Book_ID INT NOT NULL,
    Librarian_ID INT NOT NULL,
    Borrow_Date DATE NOT NULL,
    Return_Date DATE,
    Status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
    FOREIGN KEY (Reader_ID) REFERENCES Reader(Reader_ID),
    FOREIGN KEY (Book_ID) REFERENCES Book(Book_ID),
    FOREIGN KEY (Librarian_ID) REFERENCES Librarian(Librarian_ID)
);

CREATE TABLE Fine (
    Fine_ID INT PRIMARY KEY AUTO_INCREMENT,
    Loan_ID INT NOT NULL,
    Fine_Amount DECIMAL(5,2) NOT NULL,
    Paid ENUM('Yes', 'No') DEFAULT 'No',
    FOREIGN KEY (Loan_ID) REFERENCES Borrowing_Loan(Loan_ID)
);
CREATE TABLE Status_Reader (
    Account_ID INT PRIMARY KEY AUTO_INCREMENT,
    Reader_ID INT NOT NULL,
    Account_Type ENUM('Premium', 'Regular') NOT NULL,
    Account_Status ENUM('Active', 'InActive') NOT NULL,
    FOREIGN KEY (Reader_ID) REFERENCES Reader(Reader_ID)
);

-- Queries for Active and InActive Readers
SELECT * FROM Status_Reader WHERE Account_Status = 'Active';
SELECT * FROM Status_Reader WHERE Account_Status = 'InActive';

-- Query for Premium Account Count
SELECT COUNT(Account_ID) AS Premium_Count FROM Status_Reader WHERE Account_Type = 'Premium';

-- Query to Track Books Taken and Returned
SELECT * FROM Borrowing_Loan WHERE Status = 'Borrowed';
SELECT * FROM Borrowing_Loan WHERE Status = 'Returned';

-- Query to Update Return Date and Status
UPDATE Borrowing_Loan
SET Return_Date = CURDATE(), Status = 'Returned'
WHERE Loan_ID = 1;

-- Query to View Fines
SELECT * FROM Fine;
