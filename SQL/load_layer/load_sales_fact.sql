use gravity_books_dwh;

insert into dbo.sales_fact (
    book_key, customer_key, shipping_method_key,
    destination_key, order_status_key, date_key,
    order_id, price, shipping_cost, total_sales
)
select distinct
    bd.book_key,
    cd.customer_key,
    smd.shipping_method_key,
    ad.address_key,
    osd.order_status_key,
    dd.date_key,
    s.order_id,
    s.price,
    s.shipping_cost,
    s.total_sales
from staging.stg_sales s
join dbo.book_dim bd on s.book_id = bd.book_id
join dbo.customer_dim cd on s.customer_id = cd.customer_id
join dbo.shipping_method_dim smd on s.shipping_method_id = smd.shipping_method_id
join dbo.address_dim ad on s.dest_address_id = ad.address_id
join dbo.date_dim dd on s.order_date = dd.full_date
join dbo.order_status_dim osd on s.status_id = osd.order_status_id
where not exists (
    select 1
    from dbo.sales_fact f
    where f.order_id = s.order_id
);