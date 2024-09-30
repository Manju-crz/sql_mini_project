
use bikestore;

-- We get information about each tables in the database.
SELECT * FROM information_schema.tables WHERE table_schema = 'bikestore';

show tables; -- Lists out all the table names available in the database

-- Describe every table sequentially
describe brands;
describe categories;
describe customers;
describe order_items;
describe orders;
describe products;
describe staffs;
describe stocks;
describe stores;
