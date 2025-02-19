-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from sales
where sale_date = "2022-11-05"

-- Q2 Write a SQL query to calculate the total sales (total_sale) for each category.

select category ,
sum(total_sale) as total_sales from sales
group by category order by total_sales desc


-- Q3 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
avg(age)
from sales
where category="beauty"


-- Q4 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from sales
where total_sale>1000


-- Q5 Write a SQL query to find the total number of transactions 
-- (transaction_id) made by each gender in each category.

select category,
         gender,
         count(distinct transactions_id) from sales
		 group by category, gender order by category


-- Q6 Write a SQL query to calculate the average sale for each month. 
-- Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
FROM sales
GROUP BY 1, 2
) as t1

-- Q7 Write a SQL query to find the top 5 customers based on the highest total sales 
 
 select customer_id,
  sum(total_sale) as total_Sales  from sales
  group by customer_id order by total_sales desc limit 5 



    -- Q8 Write a SQL query to 
-- find the number of unique customers who purchased items from each category.

select category,
count(distinct customer_id) from sales
group by category



-- Q9 Write a SQL query to create each shift --
-- and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sales
as
(
select *,
case
when extract(hour from sale_time) <12 then 'morning'
when extract(hour from sale_time) between 12 and 17  then 'afternoon'
else 'evening'
end as shift
from sales)

select shift,
count(transactions_id) from hourly_sales
group by shift

-- END OF PROJECT
