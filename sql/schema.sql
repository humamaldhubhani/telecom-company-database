
create table Vendor(
vendor_id number(30) not null,
Name varchar2(100) not null,
num_vender number(30) not null,
Email varchar2(100) not null,
address varchar2(100),
constraint pk_vendor primary key (vendor_id)
);


create table Purchase_order(
Order_ID number(30) not null,
vendor_id number(30) not null,
Total_Amount number(30) not null,
purchase_date date not null,
constraint pk_order primary key (Order_ID),
constraint fk_vendor Foreign Key(vendor_id) References vendor(vendor_id)
);

CREATE TABLE Services(
   Service_ID NUMBER(20) ,
    Validity_days number(4) NOT NULL,
    Price number(30)not null,
    Description VARCHAR(255) NOT NULL,
    Service_Name VARCHAR(255) NOT NULL,
    CONSTRAINT PR_services primary key (Service_ID)
    );



CREATE TABLE Customers(
customer_id number(20),
cus_email VARCHAR2(50),
phone_number number(10) unique,
cus_address VARCHAR(20),
full_name VARCHAR2(50) not null,
CONSTRAINT pk_customers primary key (customer_id)
);

 

CREATE TABLE Subscription(
Subscription_id number(20),
Subscription_name varchar2(100),
CONSTRAINT pk_sub primary key (Subscription_id)
);


CREATE TABLE Invoices(
Invoice_ID number(20),
release_Date date  not NULL,
Amount number (30) not null,
customer_id number(20),
Subscription_id number(20),
CONSTRAINT pk_Invoices primary key (Invoice_ID),
CONSTRAINT fk_customer_invoice foreign Key(customer_id) References Customers(customer_id)
); 

CREATE TABLE Payments(
Payment_ID number(20),
Method VARCHAR2(30) NOT NULL,
Amount number (30) not null,
Invoice_ID number(20),
Service_ID number(20),
customer_id number(20),
CONSTRAINT pk_Payments primary key (Payment_ID),
CONSTRAINT fk_invoice_payments Foreign Key(Invoice_ID) References Invoices(Invoice_ID),
CONSTRAINT fk_service_payments Foreign key(Service_ID) References  Services(service_id),
CONSTRAINT fk_customer_payments Foreign key(customer_id) References Customers(customer_id)
);

CREATE TABLE Network_Node(
Node_ID number(20) ,
Type VARCHAR2(30) NOT NULL,
Location VARCHAR2(20) not null,
CONSTRAINT pk_Node primary key (Node_ID)
);

CREATE TABLE Network_Equipments(
Equipment_ID number(20),
Manufacturer VARCHAR2(20),
Type VARCHAR2(30) NOT NULL,
Node_ID number(20),
CONSTRAINT pk_Equipments primary key (Equipment_ID),
CONSTRAINT fk_equipments_node Foreign Key(Node_ID) References Network_Node(Node_ID));

CREATE TABLE Branch(
 Branch_ID number(20),
 Leader_Name VARCHAR2(30),
 Founded_Date date (30),
branch_Address VARCHAR2(30) not null,
CONSTRAINT pk_Branch_ID primary key (Branch_ID)
);

CREATE TABLE Department (
  Department_ID number PRIMARY KEY,
  Department_Name VARCHAR(50)
);
CREATE TABLE Employees(
Employee_ID number(10) PRIMARY KEY,
first_name varchar2(100) not null,
last_name varchar2(100) not null,
salary number(10) not null,
Department_ID INT,
Branch_ID number(20),
FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID)
);

CREATE TABLE Trainings (
Training_id varchar2(100)  PRIMARY KEY,
duration_by_days  number(20) not null,
Course_name  varchar2(100) not null,
);



CREATE TABLE Trouble_ticket (
  Ticket_ID number(20) PRIMARY KEY,
  Statues VARCHAR(100),
  customer_id number(20) not null,
  Ticket_description VARCHAR(100),
  Foreign Key(customer_id) References Customers(customer_id)
);                    
CREATE TABLE Sales_lead(
Lead_ID number(10) PRIMARY KEY,
customer_id number(20),
Foreign Key(customer_id) References Customers(customer_id)
);

create table vip_customers(
com_gur_num number(20) unique,
customer_id NUMBER(20),
constraint fk_vip_cust foreign key(customer_id) References Customers(customer_id)
);






