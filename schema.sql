-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) Not NULL, 
	dept_name varchar(40) Not Null, 
	Primary Key (dept_no), 
	Unique (dept_name)
);

Create table employees (
	emp_no int not null, 
	birth_date DATE not null, 
	first_name VARCHAR not null, 
	last_name VARCHAR not null, 
	gender VARCHAR not null, 
	hire_date DATE not null, 
	primary key (emp_no)
	);
	
Create table dept_manager (
dept_no varchar(4) not null, 
	emp_no int not null, 
	from_date date not null, 
	to_date date not null, 
Foreign key (emp_no) references employees (emp_no),
foreign key (dept_no) references departments (dept_no),
	primary key (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

create table titles (
	emp_no int not null, 
	title varchar not null, 
	from_date date not null, 
	to_date date not null, 
	foreign key (emp_no) references employees (emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);
	
create table dept_emp (
	emp_no int not null, 
	dept_no varchar (4) not null, 
	from_date date not null, 
	to_date date not null, 
	foreign key (dept_no) references departments (dept_no), 
	primary key (emp_no, dept_no)
);

SELECT * From departments;