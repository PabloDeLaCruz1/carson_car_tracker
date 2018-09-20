CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    gender varchar(10),
    phone_numer integer,
    date_created timestamp DEFAULT current_timestamp
);CREATE TABLE cars (
    id SERIAL PRIMARY KEY,
    model varchar(50),
    make varchar(50),
    cost_price integer,
    sale_markup integer,
    customer_id integer references customers(id),
    date_created timestamp DEFAULT current_timestamp
);CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  customer_id integer references customers(id),
  car_id integer references cars(id)
);

