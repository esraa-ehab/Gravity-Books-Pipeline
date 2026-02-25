use gravity_books_dwh;

drop table if exists Shipping_method_dim;
create table Shipping_method_dim(
	shipping_method_key int identity(1,1) primary key,
	shipping_method_id int not null,
	shipping_method_name varchar(100),
)


insert into	Shipping_method_dim(
	shipping_method_id,
	shipping_method_name,
)
select * from gravity_books.dbo.shipping_method 