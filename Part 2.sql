#Q1. What is the total amount each customer spent on zomato?
Select a.userid, sum(b.price) total_amt_spend from sales a inner join product b on a.product_id=b.product_id
group by a.userid;

#Q2. How many days has each customer visited zomato?
select userid,count(distinct created_date) distinct_days from sales group by userid;

#Q3. What was the first Product Ordered by each customer?
Select * from 
(select *,rank() over(partition by userid order by created_date) rnk from sales) a where rnk=1;

#Q4. What is the most purchased item on the menu and how many times was it  purchased by all?
Select userid,count(product_id) cnt from sales where product_id = 
(select  product_id from sales group by product_id order by count(product_id) desc)
group by userid;

#Q5. Which item was the most popular for each customer?
select * from 
(select *,rank() over (partition by userid order by cnt desc) rnk from 
(select userid,product_id,count(product_id) cnt from sales group by userid,product_id)a)b;
where rnk = 1;