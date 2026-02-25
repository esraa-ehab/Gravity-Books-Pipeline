use gravity_books_dwh;

drop table if exists Order_status_dim;
create table Order_status_dim(
	order_status_key int identity(1,1) primary key,
	order_status_id int not null,
	order_status varchar(100),
	status_date datetime
)


insert into Order_status_dim(
	order_status_id,
	order_status,
	status_date
)
select 
	oh.status_id,
	os.status_value,
	oh.status_date
	
from gravity_books.dbo.order_history oh 
join gravity_books.dbo.order_status os on oh.status_id = os.status_id
