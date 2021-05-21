use University;

select student.ID,name,dept_name
from student
ORDER BY name;


select instructor.name,salary
from instructor
where dept_name in ('Comp. Sci.','Elec. Eng.')
ORDER by salary desc;

select course_id, title
from course
where course_id like 'CS-1%';

select sec_id, count(sec_id) as Count
from takes
GROUP by sec_id;

create view faculty as
select ID, name, dept_name
from instructor;


create view CSinstructors as
select ID, instructor.name, dept_name, salary
from instructor
where dept_name ='Comp. Sci.';
