use gravity_books_dwh;

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
)

insert into Date_dim(full_date)
select distinct order_date
from gravity_books.dbo.cust_order