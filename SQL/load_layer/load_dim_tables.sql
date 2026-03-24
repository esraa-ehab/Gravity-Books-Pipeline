
use gravity_books_dwh;

-- Insert into the DWH from staging layer

-- address dimension
insert into dbo.address_dim (
    address_id,
    city,
    country,
    street_number,
    street_name,
    address_status
)
select distinct
    s.address_id,
    s.city,
    s.country,
    s.street_number,
    s.street_name,
    s.address_status
from staging.stg_address s
where not exists (
    select 1
    from dbo.Address_dim d
    where d.address_id = s.address_id
);


-- book dimension
insert into dbo.Book_dim (
    book_id,
    title,
    isbn13,
    pages_num,
    language_name,
    author_name,
    publisher_name,
    publish_date
)
select distinct
    book_id,
    title,
    isbn13,
    pages_num,
    language_name,
    author_name,
    publisher_name,
    publish_date
from staging.stg_book s
where not exists (
    select 1
    from dbo.Book_dim d
    where d.book_id = s.book_id
);


-- customer dimension
insert into dbo.Customer_dim (customer_id, fname, lname, email)
select distinct
    customer_id,
    fname,
    lname,
    email
from staging.stg_customer s
where not exists (
    select 1
    from dbo.Customer_dim d
    where d.customer_id = s.customer_id
);

-- date dim
insert into dbo.date_dim(full_date)
select 
	distinct full_date
from staging.stg_date s  
where not exists (
    select 1
    from dbo.date_dim d
    where d.full_date = s.full_date
);

-- order status dim
insert into dbo.order_status_dim(order_status_id, order_status, status_date)
select distinct
    order_status_id,
    order_status,
    status_date
from staging.stg_order_status s
where not exists (
    select 1
    from dbo.order_status_dim d
    where d.order_status_id = s.order_status_id
);

-- shipping method dim 
insert into dbo.shipping_method_dim(shipping_method_id, shipping_method_name)
select distinct
    shipping_method_id,
    shipping_method_name
from staging.stg_shipping_method s
where not exists (
    select 1
    from dbo.shipping_method_dim d
    where d.shipping_method_id = s.shipping_method_id
);