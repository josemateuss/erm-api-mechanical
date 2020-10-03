CREATE TABLE "Customers" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(50) NOT NULL,
  "cpf" varchar(11) UNIQUE NOT NULL,
  "phone" varchar(11) NOT NULL,
  "email" varchar(50) UNIQUE NOT NULL,
  "password" varchar(50) NOT NULL,
  "address_id" int NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Addresses" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "street" varchar(50) NOT NULL,
  "number" varchar(10) NOT NULL,
  "neighborhood" varchar(50) NOT NULL,
  "complement" varchar(50),
  "city" varchar(50) NOT NULL,
  "state" varchar(50) NOT NULL,
  "zip_code" varchar(11) NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Vehicles" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "brand" varchar(50) NOT NULL,
  "model" varchar(50) NOT NULL,
  "plate" varchar(7) NOT NULL,
  "year" int NOT NULL,
  "color" varchar(50) NOT NULL,
  "customer_id" int NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Employees" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(50) NOT NULL,
  "cpf" varchar(11) UNIQUE NOT NULL,
  "phone" varchar(11) NOT NULL,
  "email" varchar(50) UNIQUE NOT NULL,
  "password" varchar(50) NOT NULL,
  "salary" decimal NOT NULL,
  "photo" bytea,
  "address_id" int NOT NULL,
  "autoshop_id" int NOT NULL,
  "employee_type_id" int NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Autoshops" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(50) NOT NULL,
  "cnpj" varchar(14) UNIQUE NOT NULL,
  "phone" varchar(11) NOT NULL,
  "landline" varchar(10),
  "email" varchar(50) UNIQUE NOT NULL,
  "address_id" int NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "EmployeeTypes" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(50) NOT NULL,
  "description" text,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Items" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(50) NOT NULL,
  "description" text NOT NULL,
  "price" decimal NOT NULL,
  "category_id" int NOT NULL,
  "order_item_id" int NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Categories" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(50) NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Orders" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "date" timestamp NOT NULL,
  "description" text NOT NULL,
  "value" decimal NOT NULL,
  "paid" boolean NOT NULL DEFAULT false,
  "customer_id" int NOT NULL,
  "employee_id" int NOT NULL,
  "order_item_id" int NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Payments" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "employee_id" int NOT NULL,
  "month_id" int NOT NULL,
  "value" decimal NOT NULL,
  "date" timestamp NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Months" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar(10) NOT NULL,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

CREATE TABLE "Order_items" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "order_id" int,
  "item_id" int,
  "quantity" int DEFAULT 1,
  "created_at" timestamp DEFAULT current_date,
  "updated_at" timestamp DEFAULT current_date
);

ALTER TABLE "Customers" ADD FOREIGN KEY ("address_id") REFERENCES "Addresses" ("id");

ALTER TABLE "Employees" ADD FOREIGN KEY ("autoshop_id") REFERENCES "Autoshops" ("id");

ALTER TABLE "Employees" ADD FOREIGN KEY ("address_id") REFERENCES "Addresses" ("id");

ALTER TABLE "Employees" ADD FOREIGN KEY ("autoshop_id") REFERENCES "Autoshops" ("id");

ALTER TABLE "Employees" ADD FOREIGN KEY ("employee_type_id") REFERENCES "EmployeeTypes" ("id");

ALTER TABLE "Payments" ADD FOREIGN KEY ("employee_id") REFERENCES "Employees" ("id");

ALTER TABLE "Payments" ADD FOREIGN KEY ("month_id") REFERENCES "Months" ("id");

ALTER TABLE "Vehicles" ADD FOREIGN KEY ("customer_id") REFERENCES "Customers" ("id");

ALTER TABLE "Items" ADD FOREIGN KEY ("category_id") REFERENCES "Categories" ("id");

ALTER TABLE "Orders" ADD FOREIGN KEY ("employee_id") REFERENCES "Employees" ("id");

ALTER TABLE "Orders" ADD FOREIGN KEY ("customer_id") REFERENCES "Customers" ("id");

ALTER TABLE "Order_items" ADD FOREIGN KEY ("order_id") REFERENCES "Orders" ("id");

ALTER TABLE "Order_items" ADD FOREIGN KEY ("item_id") REFERENCES "Items" ("id");
