USE master;
GO
DROP DATABASE IF EXISTS disk_inventoryJC;
Go
CREATE DATABASE disk_inventoryJC;
Go
use disk_inventoryJC;
Go

IF SUSER_ID('diskUserJC') IS NULL CREATE LOGIN diskUserJC WITH PASSWORD = 'Pa$$w0rd', DEFAULT_DATABASE = disk_inventoryJC;

CREATE USER diskUserJC;
ALTER ROLE db_datareader ADD MEMBER diskUserJC;
Go

CREATE TABLE ArtistType (
	artist_type_id INT NOT NULL IDENTITY PRIMARY KEY,
	description VARCHAR(10));

CREATE TABLE Status (
	status_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(60) NOT NULL);

CREATE TABLE Genre (
	genre_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(60) NOT NULL);

CREATE TABLE DiskType (
	disk_type_id INT NOT NULL IDENTITY PRIMARY KEY,
	description NVARCHAR(60) NOT NULL);

CREATE TABLE Artist (
	artist_id INT NOT NULL IDENTITY PRIMARY KEY,
	first_name VARCHAR(60) NOT NULL,
	last_name VARCHAR(60) NULL,
	artist_type CHAR(10),
	artist_type_id INT REFERENCES ArtistType(artist_type_id));

CREATE TABLE Disk (disk_id INT NOT NULL IDENTITY PRIMARY KEY,
	disk_type NVARCHAR(60) NOT NULL,
	disk_name NVARCHAR(60) NOT NULL,
	release_date DATE NOT NULL,
	status_id INT REFERENCES Status(status_id),
	genre_id INT REFERENCES Genre(genre_id),
	disk_type_id INT REFERENCES DiskType(disk_type_id));

CREATE TABLE Borrower (
	borrower_id INT NOT NULL IDENTITY PRIMARY KEY,
	first_name NVARCHAR(60) NOT NULL,
	last_name NVARCHAR(60) NOT NULL,
	phone BIGINT NOT NULL);

CREATE TABLE DiskRental (
	rental_id INT NOT NULL IDENTITY PRIMARY KEY,
	borrowed_date DATETIME NOT NULL,
	return_date DATETIME NOT NULL,
	borrower_id INT NOT NULL REFERENCES Borrower(borrower_id),
	disk_id INT NOT NULL REFERENCES Disk(disk_id));




