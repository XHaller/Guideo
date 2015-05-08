# hostname: e6998.c9qyq3xutthv.us-west-2.rds.amazonaws.com
# port: 3306
# username: xy2251
# password: 19921110

USE e6998;

DROP TABLE Sites;
CREATE TABLE Sites(
	sid SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    city NVARCHAR(20) NOT NULL,
	name NVARCHAR(50) NOT NULL,
    zipcode INTEGER NOT NULL,
	address NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    website NVARCHAR(50),
    email NVARCHAR(50),
    open_time NVARCHAR(50) NOT NULL,
    visit_length NVARCHAR(50),
    has_fee NVARCHAR(4),
    activity NVARCHAR(1000),
    description NVARCHAR(1000),
	UNIQUE (name)
) ENGINE = InnoDB  DEFAULT CHARSET = UTF8;

# Leagues without the foreign key constraint for last_champion
# This constraint will be added after the creation of the table of clubs.
DROP TABLE Events;
CREATE TABLE Events(
	eid SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    city NVARCHAR(20) NOT NULL,
	name NVARCHAR(50) NOT NULL,
    location NVARCHAR(50) NOT NULL,
    zipcode INTEGER NOT NULL,
	address NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    website NVARCHAR(50),
    email NVARCHAR(50),
    start_date NVARCHAR(20) NOT NULL,
    end_date NVARCHAR(20) NOT NULL,
    open_time NVARCHAR(50) NOT NULL,
    has_fee NVARCHAR(4),
    description NVARCHAR(1000),
	UNIQUE (name)
) ENGINE = InnoDB  DEFAULT CHARSET = UTF8;

DROP TABLE Notes;
DROP TABLE Users;

CREATE TABLE Users(
	uid SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    password NVARCHAR(50) NOT NULL,
	email NVARCHAR(50) NOT NULL,
    description VARCHAR(100),
    preference VARCHAR(100),
    UNIQUE (name),
    UNIQUE (email)
) ENGINE = InnoDB  DEFAULT CHARSET = UTF8;

CREATE TABLE Notes(
	nid SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	title NVARCHAR(50) NOT NULL,
    content NVARCHAR(1000) NOT NULL,
	time NVARCHAR(20) NOT NULL,
    clicked INTEGER NOT NULL,
    uid SMALLINT NOT NULL,
    sid SMALLINT NOT NULL,
	FOREIGN KEY (uid) REFERENCES Users (uid) ON DELETE NO ACTION
) ENGINE = InnoDB  DEFAULT CHARSET = UTF8;
