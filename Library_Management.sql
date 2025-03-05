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

-- Insert sample data into Reader
INSERT INTO Reader (Name, Email, Phone, JoinDate)
VALUES
('Rugved Bhavsar', 'rugved9@gmail.com', '7721947688', '2025-02-25'),
('Kalpesh Patil', 'kalpesh@gmail.com', '8576859594', '2024-11-12'),
('Sharankumar Patil', 'sharan@gmail.com', '7392840989', '2024-09-05'),
('Pratik Bahre', 'pratik@gmail.com', '8938429385', '2025-01-03'),
('Shubham Sawai', 'shubham@gmail.com', '8767173877', '2025-01-15');

-- BOOK TABLE
CREATE TABLE Book (
    Book_ID INT PRIMARY KEY AUTO_INCREMENT,
    Book_Name VARCHAR(200) NOT NULL,
    Author VARCHAR(200) NOT NULL,
    Publish_Year INT,
    Avail_Copies INT DEFAULT 1
);

-- Insert sample data into Book
INSERT INTO Book (Book_Name, Author, Publish_Year, Avail_Copies)
VALUES
('A House for Mr. Biswas', 'V.S. Naipaul', 1961, 3),
('Where the Wild Things Are', 'Sendak', 1963, 5),
('The Wealth of Nations', 'Adam Smith', 1776, 4),
('A Death in Shonagachhi', 'Rijula Das', 2021, 8);

SELECT * FROM Book;

-- LIBRARIAN TABLE
CREATE TABLE Librarian (
    Librarian_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(10) UNIQUE NOT NULL,
    HireDate DATE NOT NULL
);

-- Insert sample data into Librarian
INSERT INTO Librarian (Name, Email, Phone, HireDate)
VALUES
('Dinesh Kamble', 'kdinesh@library.com', '1234567890', '2020-01-01'),
('Rampal Sharma', 'rampalsharma@library.com', '0987654321', '2021-05-15');

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

-- Insert sample data into Borrowing_Loan
INSERT INTO Borrowing_Loan (Reader_ID, Book_ID, Librarian_ID, Borrow_Date)
VALUES
(1, 2, 1, '2025-02-12'),
(2, 3, 2, '2025-03-01');

-- FINE TABLE
CREATE TABLE Fine (
    Fine_ID INT PRIMARY KEY AUTO_INCREMENT,
    Loan_ID INT NOT NULL,
    Fine_Amount DECIMAL(5,2) NOT NULL,
    Paid ENUM('Yes', 'No') DEFAULT 'No',
    FOREIGN KEY (Loan_ID) REFERENCES Borrowing_Loan(Loan_ID)
);

-- Insert sample data into Fine
INSERT INTO Fine (Loan_ID, Fine_Amount, Paid)
VALUES
('1', '10.00', 'No');

-- STATUS READER TABLE (Optional, if needed for account tracking)
CREATE TABLE Status_Reader (
    Account_ID INT PRIMARY KEY AUTO_INCREMENT,
    Reader_ID INT NOT NULL,
    Account_Type ENUM('Premium', 'Regular') NOT NULL,
    Account_Status ENUM('Active', 'InActive') NOT NULL,
    FOREIGN KEY (Reader_ID) REFERENCES Reader(Reader_ID)
);

-- Insert sample data into Status_Reader
INSERT INTO Status_Reader (Reader_ID, Account_Type, Account_Status)
VALUES
(1, 'Premium', 'InActive'),
(2, 'Premium', 'Active'),
(3, 'Regular', 'Active'),
(4, 'Premium', 'InActive');


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