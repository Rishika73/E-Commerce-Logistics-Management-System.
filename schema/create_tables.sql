create table category (
    category_id int primary key,
    category_name varchar(255) not null unique
);

create table distribution_center (
    distribution_center_id int primary key,
    distribution_center_name varchar(255) not null unique
);

create table product (
    product_id int primary key,
    product_name varchar(255) not null,
    product_brand varchar(255) not null,
    retail_price decimal(10, 2) check (retail_price >= 0),
    cost decimal(10, 2) check (cost >= 0),
    category_id int,
    distribution_center_id int,
    foreign key (category_id) references category(category_id) on delete set null on update cascade,
    foreign key (distribution_center_id) references distribution_center(distribution_center_id) on delete set null on update cascade
);

create table inventory (
    inventory_id int primary key,
    product_id int not null,
    created_at timestamp without time zone not null,
    sold_at timestamp without time zone,
    foreign key (product_id) references product(product_id) on delete cascade on update cascade
);

create table users (
    user_id int primary key,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    email varchar(255) not null ,
    age int not null,
    gender varchar(50) check (gender in ('M', 'F', 'O')),
    mobile varchar(50) not null 

);

create table address (
    user_id int,
    street_address varchar(255) not null,
    city varchar(255) not null,
    state varchar(255) not null,
    country varchar(255) not null,
    zipcode varchar(20) not null,
    primary key (user_id),
    foreign key (user_id) references users(user_id) on delete cascade on update cascade
);

create table orders (
    order_id int primary key,
    user_id int not null,
    status varchar(50) not null,
    created_at timestamp without time zone not null,
    shipped_at timestamp without time zone,
    delivered_at timestamp without time zone,
    returned_at timestamp without time zone,
    total_items int check (total_items >= 0),
    foreign key (user_id) references users(user_id) on delete cascade on update cascade
);

create table order_items (
    order_items_id int primary key,
    order_id int not null,
    inventory_id int not null,
    status varchar(50) not null ,
    created_at timestamp without time zone not null,
    shipped_at timestamp without time zone,
    delivered_at timestamp without time zone,
    returned_at timestamp without time zone,
    sale_price decimal(10, 2) check (sale_price >= 0),
    foreign key (order_id) references orders(order_id) on delete cascade on update cascade,
    foreign key (inventory_id) references inventory(inventory_id) on delete cascade on update cascade
);
