-- Create Table title emp for Challenge_7 
CREATE TABLE titles_emp (
     emp_no INT NOT NULL,
     title VARCHAR(40) NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL
);

--Create table employees for challenge_7
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

-- Retrieve emp_no, first_name, last_name
SELECT emp_no, first_name, last_name
FROM employees

-- Retrieve title, from_date and to_date
SELECT emp_no, title, from_date, to_date
FROM titles_emp

-- Create new table using INTO clause and join tables
-- create a Retirement Titles table that holds all the titles of employees who were born between January 1, 1952 and December 31, 1955.
SELECT e.emp_no, first_name, last_name, birth_date, title, from_date, to_date
INTO master
FROM titles_emp
LEFT JOIN employees AS e
ON e.emp_no = titles_emp.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

SELECT emp_no, first_name, last_name, title, from_date, to_date FROM master

-- Use the Distinct on to create a table for the most recent title
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title, from_date, to_date
INTO unique_titles
FROM master
ORDER BY emp_no, from_date DESC;

-- Use the count method to to analyze the number of retiring title. 
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC;

-- check the retiring_title and make sure matches the challenge. 
SELECT * FROM retiring_titles

Select * FROM master

-- check if everything is ok and make sure matches the challenge. 
SELECT * FROM unique_titles

-- Deliverable 2, Create the Mentorship Eligibility Table

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, ttl.from_date, ttl.to_date, ttl.title
INTO mentorship_elegibility
FROM employees AS e
LEFT JOIN titles_emp as ttl
ON  e.emp_no = ttl.emp_no
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no

-- check if everything is ok and make sure matches the challenge.
SELECT * FROM mentorship_elegibility

