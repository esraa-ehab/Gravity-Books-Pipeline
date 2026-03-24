use gravity_books_dwh;

drop table if exists Book_dim;
create table Book_dim (
	book_key int identity(1,1) primary key,
	book_id int not null,
	title varchar(1000),
	isbn13 varchar(100),
	pages_num int,
	language_name varchar(100),
	author_name varchar(100),
	publisher_name varchar(100),
	publish_date datetime
);

insert into Book_dim(
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
