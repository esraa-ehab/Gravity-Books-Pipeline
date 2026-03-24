use gravity_books_dwh;

if not exists (select * from sys.schemas where name = 'staging')
    exec('create schema staging');

drop table if exists staging.stg_sales;
create table staging.stg_sales (
    order_id int,
    book_id int,
    customer_id int,
    shipping_method_id int,
    dest_address_id int,
    order_date datetime,
    status_id int,
    price decimal(10,2),
    shipping_cost decimal(10,2),
    total_sales decimal(12,2)
);

insert into staging.stg_sales (
    order_id, book_id, customer_id, shipping_method_id,
    dest_address_id, order_date, status_id,
    price, shipping_cost, total_sales
)
select
    ol.order_id,
    ol.book_id,
    co.customer_id,
    co.shipping_method_id,
    co.dest_address_id,
    co.order_date,
    latest_oh.status_id,
    ol.price,
    sm.cost,
    ol.price + sm.cost as total_sales
from gravity_books.dbo.order_line ol
join gravity_books.dbo.cust_order co on ol.order_id = co.order_id
join gravity_books.dbo.shipping_method sm on co.shipping_method_id = sm.method_id
join (
    select oh1.order_id, oh1.status_id
    from gravity_books.dbo.order_history oh1
    where oh1.status_date = (
        select max(oh2.status_date)
        from gravity_books.dbo.order_history oh2
        where oh2.order_id = oh1.order_id
    )
) latest_oh on co.order_id = latest_oh.order_id;