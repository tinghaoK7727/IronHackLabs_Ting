# 1. From the order_items table, find the price of the highest priced order and lowest price order.
select max(price) from order_items;
select min(price) from order_items;

# 2. From the order_items table, what is range of the shipping_limit_date of the orders?
select datediff(max(shipping_limit_date), min(shipping_limit_date)) 
from order_items;

# 3. From the customers table, find the states with the greatest number of customers.
select customer_state, count(*) 
from customers 
group by customer_state 
order by count(*) desc;

# 4. From the customers table, within the state with the greatest number of customers, find the cities with the greatest number of customers.
select customer_city, count(*)
from customers
group by customer_city
order by count(*) desc;

# 5. From the closed_deals table, how many distinct business segments are there (not including null)?
select count(distinct business_segment)
from closed_deals
where business_segment is not null;

# 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue)
select business_segment, sum(declared_monthly_revenue)
from closed_deals
group by business_segment
order by sum(declared_monthly_revenue) desc
limit 3;

# 7. From the order_reviews table, find the total number of distinct review score values.
select distinct review_score
from order_reviews;

# 8. In the order_reviews table, create a new column with a description that corresponds to each number category for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.
alter table order_reviews
add column number_category int;
update order_reviews
set number_category = 1
where review_score = 1;
update order_reviews
set number_category = 2
where review_score = 2;
update order_reviews
set number_category = 3
where review_score = 3;
update order_reviews
set number_category = 4
where review_score = 4;
update order_reviews
set number_category = 5
where review_score = 5;
ALTER TABLE order_reviews
DROP COLUMN New_Col;
select review_score, number_category, count(*) 
from order_reviews
group by review_score, number_category
order by count(*) desc;

# 9. From the order_reviews table, find the review value occurring most frequently and how many times it occurs.
select review_score, count(*)
from order_reviews
group by review_score
order by review_score desc;

