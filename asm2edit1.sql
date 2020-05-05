SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Stock;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Replacement;
DROP TABLE IF EXISTS Log;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS PrivateCustomer;
DROP TABLE IF EXISTS BusinessCustomer;
DROP TABLE IF EXISTS Membership;

CREATE TABLE Equipment
(
    equip_code INTEGER(10) NOT NULL,
    equip_name VARCHAR(30) NOT NULL,
    brand      VARCHAR(20) NOT NULL,
    price      FLOAT,
    sup_name   VARCHAR(20) NOT NULL,
    cate_name  VARCHAR(20) NOT NULL,
    PRIMARY KEY (equip_code, equip_name)
);

CREATE TABLE Supplier
(
    sup_name        VARCHAR(20) NOT NULL,
    sup_contact     INTEGER(15) NOT NULL,
    sup_address     VARCHAR(50) NOT NULL,
    PRIMARY KEY (sup_name)
);

CREATE TABLE Category
(
    cate_name       VARCHAR(20) NOT NULL,
    PRIMARY KEY(cate_name)
);

CREATE TABLE Stock
(
    equip_code INTEGER(10) NOT NULL,
    equip_name VARCHAR(30) NOT NULL,
    cate_name  VARCHAR(20) NOT NULL,
    quantity   INTEGER(5)  NOT NULL,
    PRIMARY KEY (equip_code)
);

CREATE TABLE Transaction
(
    trans_code              INTEGER(10) NOT NULL,
    hiring_date             DATE        NOT NULL,
    quantity                INTEGER(5)  NOT NULL,
    delivery_time           FLOAT,
    cost                    FLOAT,
    expected_return_date    DATE        NOT NULL,
    equip_code              INTEGER     NOT NULL,
    cus_ID                  INTEGER     NOT NULL,
    PRIMARY KEY (trans_code, equip_code, cus_ID)
);

CREATE TABLE Replacement
(
    actual_date DATE        NOT NULL,
    equip_code  INTEGER(10) NOT NULL,
    cus_ID      INTEGER(10) NOT NULL,
    PRIMARY KEY (equip_code, cus_ID)
);

CREATE TABLE Log
(
    log_in     INTEGER     NOT NULL,
    result     VARCHAR(50),
    equip_code INTEGER(10) NOT NULL,
    cus_ID     INTEGER(10) NOT NULL,
    PRIMARY KEY (log_in, equip_code, cus_ID)
);

CREATE TABLE Customer
(
    cus_ID          INTEGER(10) NOT NULL,
    name            VARCHAR(30) NOT NULL,
    phone_number    INTEGER(15) NOT NULL,
    address         VARCHAR(50) NOT NULL,
    PRIMARY KEY (cus_ID)
);

CREATE TABLE PrivateCustomer
(
    cus_ID INTEGER(10) NOT NULL,
    radius FLOAT       NOT NULL,
    PRIMARY KEY (cus_ID)
);

CREATE TABLE BusinessCustomer
(
    code   INTEGER(10) NOT NULL,
    cus_ID INTEGER(10) NOT NULL,
    PRIMARY KEY (code, cus_ID)
);

CREATE TABLE Membership
(
    code        INTEGER(10) NOT NULL,
    title       VARCHAR(10) NOT NULL,
    discount    FLOAT NOT NULL,
    PRIMARY KEY (code)
);

-- Alter table
ALTER TABLE Equipment
ADD CONSTRAINT fk_e_sup
    FOREIGN KEY (sup_name)
    REFERENCES Supplier (sup_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Equipment
ADD CONSTRAINT fk_e_cate
    FOREIGN KEY (cate_name)
    REFERENCES Category (cate_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Stock
ADD CONSTRAINT fk_st_e
    FOREIGN KEY (equip_code, equip_name)
    REFERENCES Equipment(equip_code, equip_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Stock
ADD CONSTRAINT fk_st_cname
    FOREIGN KEY (cate_name)
    REFERENCES Category(cate_name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


ALTER TABLE Transaction
ADD CONSTRAINT fk_trans_equip
    FOREIGN KEY (equip_code)
    REFERENCES Equipment(equip_code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Transaction
ADD CONSTRAINT fk_trans_cus
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Replacement
ADD CONSTRAINT fk_replace_equip
    FOREIGN KEY (equip_code)
    REFERENCES Equipment(equip_code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Replacement
ADD CONSTRAINT fk_replace_cus
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE Log
ADD CONSTRAINT fk_log_equip
    FOREIGN KEY (equip_code)
    REFERENCES Equipment(equip_code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE Log
ADD CONSTRAINT fk_log_cus
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE PrivateCustomer
ADD CONSTRAINT fk_pc
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE BusinessCustomer
ADD CONSTRAINT fk_bc_mbs
    FOREIGN KEY (code)
    REFERENCES Membership(code)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
ALTER TABLE BusinessCustomer
ADD CONSTRAINT fk_bc_cus
    FOREIGN KEY (cus_ID)
    REFERENCES Customer(cus_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;