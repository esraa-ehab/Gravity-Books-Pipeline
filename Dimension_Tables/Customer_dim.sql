use gravity_books_dwh;

drop table if exists Customer_dim;
create table Customer_dim(
	cutomer_key int identity(1,1) primary key,
	customer_id int not null,
	fname varchar(50),
	lname varchar(50),
	email varchar(200)	
)

insert into Customer_dim(
	customer_id,
	fname,
	lname,
	email
)
select * from gravity_books.dbo.customer 