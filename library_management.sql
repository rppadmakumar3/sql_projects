create table books(id int primary key, book_name varchar(255), author varchar(255), current_status boolean, remaining int);

create table members(id int primary key, member_name varchar(255), current_status int);

create table transactions(id int primary key, cur_date date, member_id int, book_id int);

select * from books;
select * from members;
select * from transactions;

-- Insert the data into Books
INSERT INTO books (id, book_name, author, current_status, remaining) VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', true, 3),
(2, '1984', 'George Orwell', true, 5),
(3, 'Pride and Prejudice', 'Jane Austen', true, 2),
(4, 'The Great Gatsby', 'F. Scott Fitzgerald', true, 4),
(5, 'Moby Dick', 'Herman Melville', true, 1),
(6, 'War and Peace', 'Leo Tolstoy', true, 2),
(7, 'The Catcher in the Rye', 'J.D. Salinger', true, 6),
(8, 'The Hobbit', 'J.R.R. Tolkien', true, 3),
(9, 'Fahrenheit 451', 'Ray Bradbury', true, 4),
(10, 'Brave New World', 'Aldous Huxley', true, 2);

-- Insert the data into members
INSERT INTO members (id, member_name, current_status) VALUES
(1, 'Alice Johnson', 1),
(2, 'Bob Smith', 1),
(3, 'Charlie Brown', 1),
(4, 'Daisy Carter', 1),
(5, 'Ethan White', 1),
(6, 'Fiona Green', 1),
(7, 'George Martin', 1),
(8, 'Hannah Scott', 1),
(9, 'Isaac Lewis', 1),
(10, 'Julia Robinson', 1);

-- Insert data into Transactions
INSERT INTO transactions (id, cur_date, member_id, book_id) VALUES
(1, '2023-10-01', 1, 1),
(2, '2023-10-02', 2, 3),
(3, '2023-10-03', 3, 4),
(4, '2023-10-04', 4, 5),
(5, '2023-10-05', 5, 2),
(6, '2023-10-06', 6, 7),
(7, '2023-10-07', 7, 8),
(8, '2023-10-08', 8, 6),
(9, '2023-10-09', 9, 9),
(10, '2023-10-10', 10, 10);


-- Queries to Find Available Books
select id, book_name, author
from books
where current_status=true and remaining>0;

-- Check out a Book
UPDATE books
SET remaining = remaining - 1, current_status = CASE WHEN remaining - 1 > 0 THEN true ELSE false END
WHERE id = 7 AND current_status = true AND remaining > 0;

-- Insert Transactions record
insert into transactions(id,cur_date,member_id,book_id)
values(2,current_date(),1,5);

-- Return a Book
update books
set remaining=remaining+1, current_status=true
where id=5;

-- Update Members return Record
update transactions
set return_date=current_date()
where id=1 and book_id=5 and return_date is null;

-- View Member Activity
select t.cur_date as CheckoutDate, t.return_date, b.book_name, b.author
from transactions t
join books b on t.book_id=b.id
where t.member_id=1
order by t.cur_date desc;