-- PART 1
CREATE TABLE Authors (
    AuthorID INTEGER PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(80) NOT NULL,
    BirthCountry VARCHAR(50) NOT NULL
);

INSERT INTO Authors (FullName, BirthCountry)
values 
("Jane Austen", "England"),
("Charles Dickens", "England"),
("Mark Twain", "United States");

SELECT * FROM Authors;

-- PART 2
DROP TABLE Books;

CREATE TABLE Books (
    BookID INTEGER PRIMARY KEY AUTO_INCREMENT,
    BookName VARCHAR(200) NOT NULL,
    AuthorID INTEGER NOT NULL,
    FOREIGN KEY(AuthorID) REFERENCES Authors(AuthorID)
);

INSERT INTO Books (BookName, AuthorID)
values 
("Pride and Prejudice", 1),
("Sense and Sensibility", 1),
("The Pickwick Papers", 2);

SELECT * FROM Books;


-- PART 3
SELECT * FROM Authors
JOIN Books USING (AuthorID);

DROP VIEW AuthorBooks;

CREATE VIEW AuthorBooks as
SELECT FullName as AuthorName, BookName
FROM Authors
JOIN Books
ON authors.AuthorID = books.AuthorID
ORDER BY FullName ASC;



SELECT * FROM AuthorBooks;