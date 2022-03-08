USE publications;

# Challenge 1: Step 1
SELECT titleauthor.title_id, au_id, 
titles.advance * titleauthor.royaltyper / 100 as advance,
titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as royalty
FROM titleauthor
JOIN titles
ON titleauthor.title_id = titles.title_id
JOIN sales
ON titleauthor.title_id = sales.title_id
group by title_id;

# Challenge 1: Step 2
SELECT title_id, sum(royalty)
FROM (SELECT titleauthor.title_id, au_id, 
titles.advance * titleauthor.royaltyper / 100 as advance,
titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100 as royalty
FROM titleauthor
JOIN titles
ON titleauthor.title_id = titles.title_id
JOIN sales
ON titleauthor.title_id = sales.title_id) AS temp
GROUP BY title_id;

