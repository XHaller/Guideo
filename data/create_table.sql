USE e6998;
SET foreign_key_checks = 0;
DROP TABLE Sites;
SET foreign_key_checks = 1;
CREATE TABLE Sites(
    sid SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    city NVARCHAR(20) NOT NULL,
    name NVARCHAR(50) NOT NULL,
    zipcode INTEGER NOT NULL,
    address NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    website NVARCHAR(50),
    email NVARCHAR(50),
    open_time NVARCHAR(50),
    visit_length NVARCHAR(50),
    has_fee NVARCHAR(4),
    activity NVARCHAR(1000),
    history NVARCHAR(500),
    culture NVARCHAR(500),
    architact NVARCHAR(500),
    description NVARCHAR(1000),
    photourl NVARCHAR(500),
    latitude NVARCHAR(20),
    longtitude NVARCHAR(20),
    UNIQUE (name)
) ENGINE = InnoDB  DEFAULT CHARSET = UTF8;

DROP TABLE Events;
CREATE TABLE Events(
    eid SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    city NVARCHAR(20) NOT NULL,
    name NVARCHAR(50) NOT NULL,
    location NVARCHAR(50),
    zipcode INTEGER NOT NULL,
    address NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    website NVARCHAR(50),
    email NVARCHAR(50),
    start_date NVARCHAR(20) NOT NULL,
    end_date NVARCHAR(20) NOT NULL,
    open_time NVARCHAR(50),
    has_fee NVARCHAR(4),
    brief_info NVARCHAR(200),
    description NVARCHAR(1000),
    photourl NVARCHAR(500),
    latitude NVARCHAR(20),
    longtitude NVARCHAR(20),
    UNIQUE (name)
) ENGINE = InnoDB  DEFAULT CHARSET = UTF8;

DROP TABLE Contents;
DROP TABLE Notes;
DROP TABLE Users;

CREATE TABLE Users(
    uid SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name NVARCHAR(20) NOT NULL,
    password NVARCHAR(50) NOT NULL,
    email NVARCHAR(50) NOT NULL,
    description NVARCHAR(100),
    preference NVARCHAR(100),
    photourl NVARCHAR(500),
    UNIQUE (name),
    UNIQUE (email)
) ENGINE = InnoDB  DEFAULT CHARSET = UTF8;


CREATE TABLE Notes(
    nid SMALLINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title NVARCHAR(50) NOT NULL,
    time NVARCHAR(20) NOT NULL,
    clicked INTEGER NOT NULL,
    uid SMALLINT NOT NULL,
    public SMALLINT NOT NULL, # 1 for public, 0 for private
    FOREIGN KEY (uid) REFERENCES Users (uid) ON DELETE NO ACTION
) ENGINE = InnoDB  DEFAULT CHARSET = UTF8;

CREATE TABLE Contents(
    cid SMALLINT NOT NULL,
    nid SMALLINT NOT NULL,
    sid SMALLINT NOT NULL,
    content NVARCHAR(1000) NOT NULL,
    photourl NVARCHAR(500) NOT NULL,
    latitude NVARCHAR(20),
    longtitude NVARCHAR(20),
    PRIMARY KEY (cid, nid),
    FOREIGN KEY (nid) REFERENCES Notes (nid) ON DELETE CASCADE
)