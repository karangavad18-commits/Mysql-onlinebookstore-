
CREATE DATABASE onlinebookstore;
USE onlinebookstore;

use onlinebookstore;
DROP TABLE IF EXISTS book;
CREATE TABLE book (
book_id INT PRIMARY KEY,
title VARCHAR (100),
author VARCHAR (100),
genre VARCHAR(100),
publish_year INT,
price DECIMAL (10,2),
stock int
);
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
customer_id int primary key,
name varchar(100),
email varchar(100),
phone varchar(15),
city varchar (29),
country varchar(150)
);
DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk foreign key (customer_id) references customer(customer_id),
    CONSTRAINT fk1 foreign key (book_id) references book(book_id)
);
select * from book;
select * from customer;
select * from orders;
#CONSTRAINT fk foreign key (customer_id) references customer(customer_id),
#CONSTRAINT fk1 foreign key (book_id) references book(book_id)






#Basic level 

 -- 1) retrieve all books in the "ficiton" genere
 
 select * from book 
 where genre ="Fiction";
 
 select count(*) from book 
 where genre ="fiction";
 
-- 2) find the books published after the year 1950:
 
 select * from book
 where publish_year >1950
 order by publish_year;
 
-- 3) list all the customer from the canada

select * from customer 
where country="canada";  


-- 4) show orders placed in november 2023:

select * from orders
where order_date between '2023-11-01' and '2023-11-30';


-- 5) retrive the total stock of the book available

select sum(stock) as total_stock
from book;


-- 6) find the deatils of the most expensive book

select * from book 
order by price DESC
limit 1;

-- 7) show all  customers who oreded more then 1 quantity a book

select * from orders
where quantity >1;


-- 8) retrive the all orders whrer the total amount exceeds $20:

select * from orders
where total_amount >20;
 

-- 9) listall the genre available in the nooks table

select distinct genre from book;

-- 10) finsd the lowest stock in the book

select * from book
order by stock
limit 1;

-- 11) calculate the total revenue genretd from all orders

select sum(total_amount) as revnue 
from orders;


# intermedite level

-- 1) find the avg price of books in the "fantascy" genre
 select avg(price) as avg_price
 from book
 where genre ="fantasy";
 
 
-- 2) show the top 3 most expensive books of "fantasy" genere :

select * from book
where genre ="fantasy"
order by price desc
limit 4;


-- 3) retrive the total number of the book sold for each genre 

select b.genre ,sum(o.quantity) as total_books_sold from orders as o
join book b
on o.book_id=b.book_id
group by b.genre;



-- 4) retrive the total quantiy of books sold for each author

select b.author,sum(o.quantity) as total_sold from orders as o
join book as b
on o.book_id=b.book_id
group by b.author;



# advaced level

-- 1)list cutomers who have placed at least 2 orders 


select o.customer_id,c.name,count(o.order_id) as order_cont
from orders as o
join customer as c
on o.customer_id=c.customer_id
group by o.customer_id ,c.name
HAVING COUNT(order_id)>=2; 



-- 2) find the most frequently ordered book 


select o.book_id,b.title,count(o.order_id) as order_count
from orders as o
join book as b
on o.book_id=b.book_id
group by o.book_id,b.title
order by order_count DESC 
limit 1;


-- 3) list the cities where customers who spent over 30$ are loacted


select distinct c.city , total_amount
from orders as o
join customer as c 
on o.customer_id=c.customer_id
where o.total_amount>30;



-- 4) find the customer who spent the most on  orders

select c.customer_id,c.name,sum(total_amount) as total_spent
from orders as o
join customer as c
on o.customer_id=c.customer_id
group by c.customer_id,c.name
order by total_spent desc
limit 1;



-- 5) calculate the stock remianing after fulfilling all oredrs 
 select b.book_id,b.title,b.stock ,coalesce(SUM(o.quantity),0) as order_quantity,
  b.stock - COALESCE(SUM(o.quantity),0) as  remaining_quantity
from book as b 
left join orders as o
on b.book_id=o.book_id
group by b.book_id
order by b.book_id;   

