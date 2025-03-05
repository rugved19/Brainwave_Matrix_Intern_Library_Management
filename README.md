This SQL script creates and manages a Library Management System database named library_mgmt. It includes multiple tables to handle readers, books, librarians, borrowings, fines, and reader statuses. Below is a breakdown of each section:

1. Creating the Database
A new database library_mgmt is created and used.

2. Reader Table
Stores information about library readers.
Columns: Reader_ID, Name, Email, Phone, JoinDate.
Inserts sample readers.

3. Book Table
Stores details of books available in the library.
Columns: Book_ID, Book_Name, Author, Publish_Year, Avail_Copies.
Inserts sample book records.

4. Librarian Table
Stores librarian details who manage the library.
Columns: Librarian_ID, Name, Email, Phone, HireDate.
Inserts sample librarian data.

5. Borrowing/Loan Table
Tracks books borrowed by readers.
Columns: Loan_ID, Reader_ID, Book_ID, Librarian_ID, Borrow_Date, Return_Date, Status.
Establishes foreign key relationships to Reader, Book, and Librarian tables.
Inserts sample borrowing records.

6. Fine Table
Stores fines for overdue book returns.
Columns: Fine_ID, Loan_ID, Fine_Amount, Paid.
References Loan_ID from Borrowing_Loan.
Inserts sample fine records.

7. Status Reader Table (Optional)
Tracks reader account type and status.
Columns: Account_ID, Reader_ID, Account_Type, Account_Status.
Inserts sample reader account statuses.

8. Queries for Analysis
Retrieve active and inactive readers.
Count premium accounts.
Track borrowed and returned books.
Update return date and status for borrowed books.
View fines applied to readers.
