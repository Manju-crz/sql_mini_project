/*
--------------------------------------------------------------------
Name   : BikeStores
Link   : https://www.kaggle.com/datasets/dillonmyrick/bike-store-sample-database/data
Version: 1.0
--------------------------------------------------------------------
*/

-- drop tables
DROP TABLE IF EXISTS bikestore.order_items;
DROP TABLE IF EXISTS bikestore.orders;
DROP TABLE IF EXISTS bikestore.stocks;
DROP TABLE IF EXISTS bikestore.products;
DROP TABLE IF EXISTS bikestore.categories;
DROP TABLE IF EXISTS bikestore.brands;
DROP TABLE IF EXISTS bikestore.customers;
DROP TABLE IF EXISTS bikestore.staffs;
DROP TABLE IF EXISTS bikestore.stores;

-- drop the schemas

DROP SCHEMA IF EXISTS bikestore;
