# Pewlett-Hackard-Analysis

## Challenge: 

  Our company, Pewlett-Hackard is preparing for a "silver tsunami" of employees who are reaching the retirement age at close to the same time. This has the potential to affect our workflow if we are not prepared to hire the correct amount of people in the correct departments. To help combat this issue, we are helping our manager find total number of employees per title who will be retiring and identify employees who are eligibile to participate in a mentorship program.  This mentorship program will enable our new hires to seamlessly transition into their roles and ensure that institutional knowledge is maintained as much as possible. 
 
 To solve our issues, we began by using data given to us by our company. First we took a look at our data sets and made a ERD to see how our sets had overlay and could be joined to create new tables and filters to fit our needs. 
 
 ![EmployeeDB](https://github.com/SladeMahoney/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png)
 
 We performed an INNER JOIN to create a new table which included our employees id, first and last names, titles, when they worked at their titles, and their salaries. We filtered our results using a WHERE statement to find employees who were born between 1952 and 1955- making them eligible to retire in 2020.  Unfortunately, our new table had a number of duplicates since we did not account for the fact that some employees got promoted, or changed their titles over their duration at the company. To filter our data a bit further to remove any duplicates we performed a partition using the code below:
 
" --Partitioning the dating to show only most recent title per employee

--getting rid of duplicates

SELECT emp_no, first_name, last_name, title, from_date, salary

INTO new_retirees

FROM
(SELECT emp_no, first_name, last_name, title, from_date,
salary, ROW_NUMBER() OVER

(PARTITION BY (emp_no)

ORDER BY from_date DESC) rn

FROM silver_fox) 

tmp WHERE rn = 1

ORDER BY emp_no; "

This helped us determine that there are a total of 41,380 individuals who are at the retirement age and may be leaving the company soon.  It is important to us for our new hires to hit the ground running when they start at our company and with over 40,000 people about to retire, management fears we may lose a lot of the institutional knowledge these employees have. To solve this problem, we want to create a mentorship program where employees close to retirement age can mentor new employees about our company and pass along their knowledge before they retire. To find the employees elibigle for this program, we performed another INNER JOIN to create a new table that includes an employess number, first and last name, date of birth, title, and when they held their position. To find people close to retirement age, we used a WHERE statement to search for people who were born in 1965. This would give us employees who would reach elibigle retirment age in the next 10 years. Again, we found duplicates in our data so we performed another Parition using the code below: 

"--parition out the duplicates 

SELECT emp_no, first_name,	last_name,	title,	from_date,	to_date

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
ORDER BY emp_no;"

We found that there were 1,940 employees eligible for the mentorship program. 

  In our analysis, we have determined that there are a whopping 41,380 employees eligible for retirement. In addition, there are 1,940 employees eligible to be a part of the mentorship program. In our analysis, we only searched for employees who were born in 1965 to be a part of the mentorship program, but I think we should have included anyone from 1960-1965. This would include anyone 5-10 years away from retirement. This would give us more employees and more insitutional knowledge to pass along to future generations at our company. In addition, the company will need some people to receive this knowledge. It would be helpful to pair people close to retirement with employees who were recently hired. Pairing people who are in their first 5 years at the company with people 5 -10 years away from retirement would ensure that there is a connection between the old and new guards at our company. It would also be beneficial to pair people together in the same deparmtents. I would suggest a filter by department in order to pair employees or group employees on both the young and old side of the mentorship program together to have the maximum effect of knowledge retention. 
  
