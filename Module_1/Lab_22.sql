USE publications;

# Challenge 1 - subquery

# find total_advance
select titles.title_id, advance*titleauthor.royaltyper/100 as total_advance, au_id
from titles
left join titleauthor
on titles.title_id = titleauthor.title_id
group by title_id;

# find sales_royalty
select sales.title_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from sales
left join titles
on titles.title_id = sales.title_id
left join titleauthor
on sales.title_id = titleauthor.title_id
group by title_id
order by sales_royalty desc;

# join the results from two previous queries
select A.au_id, A.title_id, (A.total_advance + B.sales_royalty) as total_profits
from (
select titles.title_id, advance*titleauthor.royaltyper/100 as total_advance, au_id
from titles
left join titleauthor
on titles.title_id = titleauthor.title_id
group by title_id
) as A
left join (
select sales.title_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from sales
left join titles
on titles.title_id = sales.title_id
left join titleauthor
on sales.title_id = titleauthor.title_id
group by title_id
order by sales_royalty desc
) as B
on A.title_id = B.title_id
where au_id is not null;

select authors.au_id, authors.au_lname, authors.au_fname, title_id, c.total_profits
from authors
left join c
on authors.au_id = c.au_id
group by au_id
order by total_profits desc
limit 3;



# Challenge 2 - Alternative

create table A (
select titles.title_id, advance*titleauthor.royaltyper/100 as total_advance, au_id
from titles
left join titleauthor
on titles.title_id = titleauthor.title_id
group by title_id);

create table B (
select sales.title_id, titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as sales_royalty
from sales
left join titles
on titles.title_id = sales.title_id
left join titleauthor
on sales.title_id = titleauthor.title_id
group by title_id
order by sales_royalty desc);

create table C (
select A.au_id, A.title_id, (A.total_advance + B.sales_royalty) as total_profits
from A
left join B
on A.title_id = B.title_id
where au_id is not null);

select authors.au_id, authors.au_lname, authors.au_fname, title_id, c.total_profits
from authors
left join c
on authors.au_id = c.au_id
group by au_id
order by total_profits desc
limit 3;



# Challenge 3

create table most_profiting_authors
(select authors.au_id, c.total_profits
from authors
left join c
on authors.au_id = c.au_id
group by au_id
order by total_profits desc);

select *
from most_profiting_authors;