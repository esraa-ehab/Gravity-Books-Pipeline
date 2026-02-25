use gravity_books_dwh;

drop table if exists Address_dim;
create table Address_dim (
    address_key int identity(1,1) primary key,
	address_id int not null,
	city varchar(100),
	country varchar(100),
	street_number varchar(100),
	street_name varchar(100),
	address_status varchar(50)
);

insert into Address_dim(
	address_id,
	city,
	country,
	street_number,
	street_name,
	address_status
)

select 
	a.address_id,
	a.city,
	c.country_name,
	a.street_number,
	a.street_name,
	at.address_status 
	
from gravity_books.dbo.country c
join gravity_books.dbo.address a on c.country_id = a.country_id 
join gravity_books.dbo.customer_address ca on a.address_id = ca.address_id 
join gravity_books.dbo.address_status at on ca.status_id = at.status_id 
