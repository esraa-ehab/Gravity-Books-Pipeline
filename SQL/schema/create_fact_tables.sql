use gravity_books_dwh;

drop table if exists Sales_fact;
create table Sales_fact (
    sales_id          INT IDENTITY(1,1) PRIMARY KEY,
    book_key          INT NOT NULL REFERENCES Book_dim(book_key),
    customer_key      INT NOT NULL REFERENCES Customer_dim(customer_key),
    shipping_method_key INT NOT NULL REFERENCES Shipping_method_dim(shipping_method_key),
    destination_key   INT NOT NULL REFERENCES Address_dim(address_key),
    order_status_key  INT NOT NULL REFERENCES Order_status_dim(order_status_key),
    date_key          INT NOT NULL REFERENCES Date_dim(date_key),
    order_id          INT,
    price             DECIMAL(5,2),
    shipping_cost     DECIMAL(5,2),
    total_sales       DECIMAL(10,2)
);