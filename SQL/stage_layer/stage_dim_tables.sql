use gravity_books_dwh;

create schema staging;

-- address staging table
drop table if exists staging.stg_address;
create table staging.stg_address (
	address_id INT,
    city VARCHAR(100),
    country VARCHAR(100),
    street_number VARCHAR(100),
    street_name VARCHAR(100),
    address_status VARCHAR(50)
);

insert into staging.stg_address (address_id, city, country, street_number, street_name, address_status)
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
join gravity_books.dbo.address_status at on ca.status_id = at.status_id;


-- book staging table
drop table if exists staging.stg_book;
create table staging.stg_book (
    book_id INT,
    title VARCHAR(1000),
    isbn13 VARCHAR(100),
    pages_num INT,
    language_name VARCHAR(100),
    author_name VARCHAR(1000),
    publisher_name VARCHAR(100),
    publish_date DATETIME
);

insert into staging.stg_book(
	book_id,
	title,
	isbn13,
	pages_num,
	language_name,
	author_name,
	publisher_name,
	publish_date
)

select 
    b.book_id,
    b.title,
    b.isbn13,
    b.num_pages as pages_num,
    bl.language_name,
	STRING_AGG(a.author_name, ', ') as author_name,
    p.publisher_name,
    b.publication_date as publish_date
from gravity_books.dbo.book b
left join gravity_books.dbo.book_language bl 
    on b.language_id = bl.language_id
left join gravity_books.dbo.publisher p 
    on b.publisher_id = p.publisher_id
left join gravity_books.dbo.book_author ba 
    on b.book_id = ba.book_id
left join gravity_books.dbo.author a 
	on ba.author_id = a.author_id
group by
	b.book_id,
	b.title,
	b.isbn13,
	b.num_pages,
	bl.language_name,
	p.publisher_name,
	b.publication_date;


-- customer staging table
drop table if exists staging.stg_customer;
create table staging.stg_customer(
    customer_id INT,
    fname VARCHAR(50),
    lname VARCHAR(50),
    email VARCHAR(200)
);

insert into staging.stg_customer (customer_id, fname, lname, email)
select 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
from gravity_books.dbo.customer c;

-- date staging table
drop table if exists staging.stg_date;
create table staging.stg_date(
    full_date datetime
);

insert into staging.stg_date(full_date)
select distinct order_date
from gravity_books.dbo.cust_order;


-- order status staging table
drop table if exists staging.stg_order_status;
create table staging.stg_order_status(
    order_status_id int,
    order_status varchar(100),
    status_date datetime
);

insert into staging.stg_order_status(order_status_id, order_status, status_date)
select 
    oh.status_id,
    os.status_value,
    oh.status_date
from gravity_books.dbo.order_history oh
join gravity_books.dbo.order_status os
    on oh.status_id = os.status_id;


-- shipping method staging table
drop table if exists staging.stg_shipping_method;
create table staging.stg_shipping_method(
    shipping_method_id int,
    shipping_method_name varchar(100)
);

insert into staging.stg_shipping_method(shipping_method_id, shipping_method_name)
select 
    sm.method_id,
    sm.method_name
from gravity_books.dbo.shipping_method sm;