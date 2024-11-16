create database music;


-- 1.Who is the senior most employee based on the job title?
select * from employee order by levels desc limit 1;


-- 2.Which country has the most invoices?
select billing_country,count(*) from invoice group by billing_country order by 2 desc;


-- 3.What are top 3 values of total invoice?
select total from invoice order by total desc limit 3;


-- 4.Which city has the best customers?We would like to throw a promotional Music festival in the city we made the most money.Write a query that returns one city that has
--  the highest sum of invoice tools.Return both the city name & sum of all invoice totals
select billing_city,round(sum(total),2) from invoice group by 1 order by 2 desc limit 1;


-- 5.Who is the best customer?The customer who has spent the most money will be declared the best customer.
-- Write a query that returns the person who has spent the most money
select customer.first_name,customer.last_name,round(sum(invoice.total),2)
from customer join invoice
on customer.customer_id=invoice.customer_id group by 1,2 order by 3 desc limit 1;


-- 6.Write a query to return the email,first name,last name & Genre of all rock music listeners.
-- Return your list ordered alphabetically by email starting with A.
select distinct first_name,customer.last_name,customer.email
from customer join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
join track on invoice_line.track_id=track.track_id
join genre on track.genre_id=genre.genre_id
where genre.name='Rock' order by 3; 


-- 7.Let's invite the artists who have written the most rock music in our dataset.Write a query that returns the Artist name 
-- & total track count of the top 10 rock bands.
select artist.artist_id,artist.name,count(artist.artist_id) as number_of_songs
from artist join album1 on artist.artist_id=album1.artist_id
join track on album1.album_id=track.album_id
join genre on track.genre_id=genre.genre_id
group by 1,2 order by 3 desc limit 10;


-- 8.Return all the track names that have a song length longer than the average song length.Return the name & Miliseconds for
-- each track.Order by the song length with the longest songs listed first.
select name,milliseconds from track
where milliseconds> (select avg(milliseconds) from track)
order by milliseconds desc;


-- 9.Find how much amount spent by each customer on artists?
-- Write a query to return customer name,artist name & total spent.
with CTE as
(select artist.artist_id as artist_id,artist.name as artist_name,
sum(invoice_line.quantity*invoice_line.unit_price) as sales
from artist join album1 on artist.artist_id=album1.artist_id
join track on album1.album_id=track.album_id
join invoice_line on track.track_id=invoice_line.track_id
group by 1,2 order by 3 desc limit 1
) 
select customer.customer_id,customer.first_name,customer.last_name,CTE.artist_name,
sum(invoice_line.quantity*invoice_line.unit_price) as amount_spent
from customer join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
join track on invoice_line.track_id=track.track_id
join album1 on track.album_id=album1.album_id
join CTE on album1.artist_id=CTE.artist_id
group by 1,2,3,4 order by 5 desc;


 






