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

drop table if exists dbo.Book_dim;
create table Book_dim (
	book_key int identity(1,1) primary key,
	book_id int not null,
	title varchar(1000),
	isbn13 varchar(100),
	pages_num int,
	language_name varchar(100),
	author_name varchar(1000),
	publisher_name varchar(100),
	publish_date datetime
);

drop table if exists Customer_dim;
create table Customer_dim(
	customer_key int identity(1,1) primary key,
	customer_id int not null,
	fname varchar(50),
	lname varchar(50),
	email varchar(200)	
);

drop table if exists Date_dim;
create table Date_dim(
	date_key int identity(1,1) primary key,
	full_date datetime,
	day as day(full_date),
	month as month(full_date),
	year as year(full_date),
	weekday as DATENAME(WEEKDAY, full_date),
	is_weekday as 
        case 
            when DATENAME(WEEKDAY, full_date) IN ('Saturday', 'Sunday') 
            then 0 
            else 1 
        end
);

drop table if exists Order_status_dim;
create table Order_status_dim(
	order_status_key int identity(1,1) primary key,
	order_status_id int not null,
	order_status varchar(100),
	status_date datetime
);

drop table if exists Shipping_method_dim;
create table Shipping_method_dim(
	shipping_method_key int identity(1,1) primary key,
	shipping_method_id int not null,
	shipping_method_name varchar(100)
);