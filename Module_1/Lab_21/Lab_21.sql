use publications;
select * from authors;

#1 join the tables and create a new one called xyz
create table xyz (
select authors.au_id as Author_ID, authors.au_fname as First_Name, authors.au_lname as Last_Name, publishers.pub_name as Pub_Name, titles.title as Title
from authors 
right join titleauthor
on authors.au_id = titleauthor.au_id
left join titles 
on titleauthor.title_id = titles.title_id
left join publishers
on publishers.pub_id = titles.pub_id);

#2 
create table C_Title (
select Title, count(*) as C_Title
from xyz
group by Title );

select * from C_Title;
select sum(Title_count) from C_Title;

#3 first solution
select *
from xyz;

create table Author_Total (
select Author_ID, count(*) as Total
from xyz
group by Author_ID );

create table clean (
select distinct author_id, first_name, last_name
from xyz) ;

select *
from clean
full join author_total
on clean.author_id = author_total.author_id;

select *
from clean;

select * 
from author_total;

select * 
from clean
inner join author_total
on clean.Author_ID = author_total.Author_ID
order by total desc
limit 3;

#3 alternative
select authors.au_id,authors.au_lname, authors.au_fname, count(titles.title_id) as Number
from authors
inner join titleauthor
on authors.au_id=titleauthor.au_id
inner join titles 
on titles.title_id=titleauthor.title_id
group by authors.au_id
order by Number Desc
limit 3;

#4
select authors.au_id,authors.au_lname, authors.au_fname, count(titles.title_id) as Number
from authors
left join titleauthor
on authors.au_id=titleauthor.au_id
left join titles 
on titles.title_id=titleauthor.title_id
group by authors.au_id
order by Number Desc;
