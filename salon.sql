--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

-- Setting session parameters
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Dropping existing database
DROP DATABASE salon;

-- Creating new database
CREATE DATABASE salon WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';

-- Setting ownership of the database
ALTER DATABASE salon OWNER TO freecodecamp;

-- Connecting to the new database
\connect salon

-- Setting session parameters for the new database
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Creating appointments table
CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    customer_id integer,
    service_id integer,
    "time" character varying(10)
);

-- Setting ownership of the appointments table
ALTER TABLE public.appointments OWNER TO freecodecamp;

-- Creating sequence for appointment_id
CREATE SEQUENCE public.appointments_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Setting ownership of the appointment_id sequence
ALTER TABLE public.appointments_appointment_id_seq OWNER TO freecodecamp;

-- Associating appointment_id sequence with appointment_id column
ALTER SEQUENCE public.appointments_appointment_id_seq OWNED BY public.appointments.appointment_id;

-- Creating customers table
CREATE TABLE public.customers (
    customer_id integer NOT NULL,
    phone character varying(20),
    name character varying(20) NOT NULL
);

-- Setting ownership of the customers table
ALTER TABLE public.customers OWNER TO freecodecamp;

-- Creating sequence for customer_id
CREATE SEQUENCE public.customers_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Setting ownership of the customer_id sequence
ALTER TABLE public.customers_customer_id_seq OWNER TO freecodecamp;

-- Associating customer_id sequence with customer_id column
ALTER SEQUENCE public.customers_customer_id_seq OWNED BY public.customers.customer_id;

-- Creating services table
CREATE TABLE public.services (
    service_id integer NOT NULL,
    name character varying(20) NOT NULL
);

-- Setting ownership of the services table
ALTER TABLE public.services OWNER TO freecodecamp;

-- Creating sequence for service_id
CREATE SEQUENCE public.services_service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

-- Setting ownership of the service_id sequence
ALTER TABLE public.services_service_id_seq OWNER TO freecodecamp;

-- Associating service_id sequence with service_id column
ALTER SEQUENCE public.services_service_id_seq OWNED BY public.services.service_id;

-- Setting default value for appointment_id column
ALTER TABLE ONLY public.appointments ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointments_appointment_id_seq'::regclass);

-- Setting default value for customer_id column
ALTER TABLE ONLY public.customers ALTER COLUMN customer_id SET DEFAULT nextval('public.customers_customer_id_seq'::regclass);

-- Setting default value for service_id column
ALTER TABLE ONLY public.services ALTER COLUMN service_id SET DEFAULT nextval('public.services_service_id_seq'::regclass);

-- Inserting data into appointments table
INSERT INTO public.appointments VALUES (48, 57, 1, '10:30');
INSERT INTO public.appointments VALUES (55, 57, 2, '11am');

-- Inserting data into customers table
INSERT INTO public.customers VALUES (57, '555-555-5555', 'Fabio');

-- Inserting data into services table
INSERT INTO public.services VALUES (1, 'nails');
INSERT INTO public.services VALUES (2, 'hair');
INSERT INTO public.services VALUES (3, 'waxing');

-- Setting sequence values
SELECT pg_catalog.setval('public.appointments_appointment_id_seq', 61, true);
SELECT pg_catalog.setval('public.customers_customer_id_seq', 67, true);
SELECT pg_catalog.setval('public.services_service_id_seq', 3, true);

-- Adding primary key constraint for appointments table
ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id);

-- Adding unique constraint for phone in customers table
ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_phone_key UNIQUE (phone);

-- Adding primary key constraint for customers table
ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);

-- Adding primary key constraint for services table
ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (service_id);

-- Adding foreign key constraint for customer_id in appointments table
ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);

-- Adding foreign key constraint for service_id in appointments table
ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.services(service_id);

-- PostgreSQL database dump complete
