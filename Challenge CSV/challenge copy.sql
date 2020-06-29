-- CHallenge pt 1- find all employees eligible to retire sorted by titles  
--used our retirement_info table containing retirees and created a table of retirees by title

SELECT ri.emp_no, 
	ri.first_name, 
	ri.last_name,
	ti.title,
	ti.from_date,
	ti.to_date,
	s.salary
INTO silver_fox
FROM retirement_info as ri
INNER JOIN titles as ti
ON (ri.emp_no = ti.emp_no)
INNER JOIN salaries as s
ON (ri.emp_no = s.emp_no);

Select count(*) from silver_fox;

--Partitioning the dating to show only most recent title per employee
--getting rid of duplicates
SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	salary
INTO new_retirees
FROM
 (SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	salary, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM silver_fox) 
tmp WHERE rn = 1
ORDER BY emp_no;
select count (*) from new_retirees;

--Challenge pt 2 finding employees eligible to be mentors
-- first find employees born in 1965 then partition to get rid of duplicate results.
	  
SELECT e.emp_no, 
		e.first_name, 
		e.last_name, 
		e.birth_date, 
		ti.title, 
		d.from_date, 
		d.to_date
INTO mentors
from employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
INNER JOIN dept_emp as d
ON (e.emp_no = d.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31';
SELECT * from mentors;

--parition out the duplicates 
SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
	to_date
INTO mentors_2
FROM
 (SELECT emp_no,
	first_name,
	last_name,
	title,
	from_date,
  to_date,
	ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY from_date DESC) rn
 FROM mentors
 ) 
tmp WHERE rn = 1
ORDER BY emp_no;
SELECT * FROM mentors_2;