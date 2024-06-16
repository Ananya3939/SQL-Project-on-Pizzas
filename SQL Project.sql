create database project;
use  project;

create table orders(order_id int not null,order_date date not null,order_time time not null, primary key(order_id));

create table order_details(order_details_id int not null,order_id int not null,pizza_id text not null,quantity int  not null, primary key(order_id));


select * from pizza_types;

select * from pizzas;


select * from order_details;

-- Retrieve the total number of orders placed.

select count(order_details_id) from order_details;

-- Calculate the total revenue generated from pizza sales.

select round(sum(pizzas.price*order_details.quantity)) as Revenue 
from pizzas inner join order_details 
on pizzas.pizza_id=order_details.pizza_id;

-- Identify the highest-priced pizza.


select pizza_types.name,max(pizzas.price) as Highest_Price from pizza_types inner join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id
group by 1
order by 2 desc
limit 1;


-- Identify the most common pizza size ordered.

select pizzas.size,count(order_details.order_details_id) from pizzas  join order_details 
on pizzas.pizza_id=order_details.pizza_id
group by 1
order by 2 desc
limit 1;

-- List the top 5 most ordered pizza types along with their quantities 

select pizza_types.name,sum(order_details.quantity) as Top_5 from pizzas 
join pizza_types on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by 1
order by 2 desc
limit 5;


-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category,sum(order_details.quantity) as Quantity from pizzas 
join pizza_types on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by 1
order by 2 desc;

-- Determine the distribution of orders by hour of the day.

select hour(order_time) as Hours,count(order_id) as Count  from orders
group by 1;

-- Join relevant tables to find the category-wise distribution of pizzas.

select category,count(name) from pizza_types
group by 1
order by 2 desc;

--  Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity),0) as Average from 
(select orders.order_date,sum(order_details.quantity)  as Quantity
from orders join order_details 
on orders.order_id=order_details.order_id
group by 1) as Order_Quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

 select pizza_types.name,round(sum(pizzas.price*order_details.quantity)) as Revenue 
from pizzas inner join order_details 
on pizzas.pizza_id=order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id=pizzas.pizza_type_id
group by 1
order by 2 desc
limit 3;





