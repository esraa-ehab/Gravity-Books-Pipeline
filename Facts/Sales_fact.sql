use gravity_books_dwh;

drop table if exists Sales_fact;
create table Sales_fact (
    sales_id          INT IDENTITY(1,1) PRIMARY KEY,
    book_key          INT NOT NULL REFERENCES Book_dim(book_key),
    customer_key      INT NOT NULL REFERENCES Custome_dim(cutomer_key),
    shipping_method_key INT NOT NULL REFERENCES Shipping_method_dim(shipping_method_key),
    destination_key   INT NOT NULL REFERENCES Address_dim(address_key),
    order_status_key  INT NOT NULL REFERENCES Order_status_dim(order_status_key),
    date_key          INT NOT NULL REFERENCES Date_dim(date_key),
    order_id          INT,
    price             DECIMAL(5,2),
    shipping_cost     DECIMAL(5,2),
    quantity          INT,
    total_sales       DECIMAL(10,2)
);

insert into Sales_fact (
    book_key, customer_key, shipping_method_key,
    destination_key, order_status_key, date_key,
    order_id, price, shipping_cost
)
select
    bd.book_key,
    cd.cutomer_key,
    smd.shipping_method_key,
    ad.address_key,
    osd.order_status_key,
    dd.date_key,
    ol.order_id,
    ol.price,
    sm.cost
from gravity_books.dbo.order_line ol
join gravity_books.dbo.cust_order co on ol.order_id = co.order_id
join Book_dim bd on ol.book_id = bd.book_id
join Customer_dim cd on co.customer_id = cd.customer_id
join Shipping_method_dim smd on co.shipping_method_id = smd.shipping_method_id
join Address_dim ad on co.dest_address_id = ad.address_id
join Date_dim dd on co.order_date = dd.full_date
join gravity_books.dbo.shipping_method sm on co.shipping_method_id = sm.method_id
join (
    select oh1.order_id, oh1.status_id
    from gravity_books.dbo.order_history oh1
    where oh1.status_date = (
        select MAX(oh2.status_date)
        from gravity_books.dbo.order_history oh2
        where oh2.order_id = oh1.order_id
    )
) latest_oh on co.order_id = latest_oh.order_id
join Order_status_dim osd on latest_oh.status_id = osd.order_status_id;