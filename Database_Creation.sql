create database Faculty_Performance_Tracker;
use Faculty_Performance_Tracker;

CREATE TABLE Role (
    RoleID int auto_increment PRIMARY KEY,
    FacultyRole VARCHAR(45) NOT NULL
);

CREATE TABLE Department (
    DepartmentID int auto_increment PRIMARY KEY,
    DepartmentName VARCHAR(45) NOT NULL
);

CREATE TABLE Staff (
	StaffID int Primary key auto_increment,
    StaffType VARCHAR(12) not null
);
 
CREATE TABLE Faculty (
    FacultyID VARCHAR(15) PRIMARY KEY,
    FacultyName VARCHAR(300) NOT NULL,
    FacultyContact VARCHAR(15) NOT NULL,
    FacultyEmail VARCHAR(45) NOT NULL,
    FacultyExperience int NOT NULL,
    FacultyDesignation VARCHAR(45) NOT NULL,
    DepartmentID int NOT NULL,
    StaffID int not null,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID) ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE Faculty_Has_Roles (
    RoleID int,
    FacultyID VARCHAR(15),
    PRIMARY KEY (RoleID, FacultyID),
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID) ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE Credentials (
    CredentialsID int auto_increment PRIMARY KEY,
    FacultyID VARCHAR(15) not null,
    FacultyPassword VARCHAR(45) NOT NULL,
    RoleID int not null,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID) ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE Category (
    CategoryID int auto_increment PRIMARY KEY,
    CategoryName VARCHAR(45) NOT NULL
);
 
CREATE TABLE Membership (
    MembershipID int auto_increment PRIMARY KEY,
    FacultyID VARCHAR(15) NOT NULL,
    CategoryID int NOT NULL,
    MembershipName VARCHAR(45) NOT NULL,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Token (
    TokenID int auto_increment PRIMARY KEY,
    FacultyID varchar(15) NOT NULL,
    Date DATE NOT NULL,
    Task VARCHAR(100) NOT NULL,
    Status int NOT NULL,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Log (
    LogID int auto_increment PRIMARY KEY,
    FacultyID VARCHAR(15) NOT NULL,
    Date DATE NOT NULL,
    ClassHours INT NOT NULL,
    PreparationTime INT NOT NULL,
    ProjectReview INT NOT NULL,
    CounsellingHours INT NOT NULL,
    InvigilationHours INT NOT NULL,
    ExamEvaluations INT NOT NULL,
    Viva INT NOT NULL,
    Externals INT NOT NULL,
    Meetings INT NOT NULL,
    Seminars INT NOT NULL,
    Workshops INT NOT NULL,
    EventHours INT NOT NULL,
    PublicationResearchWork INT NOT NULL,
    PublicationsPublished INT NOT NULL,
    PatentResearchWork INT NOT NULL,
    PatentsGained INT NOT NULL,
    LogCredit INT NOT NULL,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID) ON DELETE CASCADE ON UPDATE CASCADE
);

insert into role (FacultyRole) values ('Faculty'), ('Junior Assisstant'), ('Head of the Department'), ('Higher Authority');

insert into department (DepartmentName) values ('CSE'), ('ECE'), ('EEE'), ('MEC'), ('IT'), ('CHE'), ('CIV'), ('DE');

INSERT INTO Staff values (1, 'Teaching'), (2, 'Non Teaching');

insert into category (CategoryName) values ('Academics'), ('Examination'), ('Placement'), ('Swecha'), ('NSS'), ('FYFP'), ('Dance'), ('Music'), ('Film'), ('Transportation');

insert into faculty values ('Jr.AssistCSE', 'Jr.AssistCSE', '1111111111', '1111111111@gmail.com', 1, 'Junior Assisstant', 1, 2);
insert into faculty values ('Jr.AssistECE', 'Jr.AssistECE', '2222222222', '1111111111@gmail.com', 1, 'Junior Assisstant', 2, 2);
insert into faculty values ('Jr.AssistEEE', 'Jr.AssistEEE', '3333333333', '1111111111@gmail.com', 1, 'Junior Assisstant', 3, 2);
insert into faculty values ('Jr.AssistMEC', 'Jr.AssistMEC', '4444444444', '1111111111@gmail.com', 1, 'Junior Assisstant', 4, 2);
insert into faculty values ('Jr.AssistIT', 'Jr.AssistIT', '5555555555', '1111111111@gmail.com', 1, 'Junior Assisstant', 5, 2);
insert into faculty values ('Jr.AssistCHE', 'Jr.AssistCHE', '6666666666', '1111111111@gmail.com', 1, 'Junior Assisstant', 6, 2);
insert into faculty values ('Jr.AssistCIV', 'Jr.AssistCIV', '7777777777', '1111111111@gmail.com', 1, 'Junior Assisstant', 7, 2);
insert into faculty values ('Jr.AssistDE', 'Jr.AssistDE', '8888888888', '1111111111@gmail.com', 1, 'Junior Assisstant', 8, 2);
insert into faculty values ('HA', 'HA', '8888888888', '1111111111@gmail.com', 1, 'HA', 1, 2);

insert into faculty_has_roles (RoleID, FacultyID) values (2, 'Jr.AssistCSE'), (2, 'Jr.AssistECE'), (2, 'Jr.AssistEEE'), (2, 'Jr.AssistMEC'), (2, 'Jr.AssistIT'), (2, 'Jr.AssistCHE'), (2, 'Jr.AssistCIV'), (2, 'Jr.AssistDE');


insert into Credentials (FacultyID, FacultyPassword, RoleID) values ('Jr.AssistCSE', 'pwd', 2), ('Jr.AssistECE', 'pwd', 2), ('Jr.AssistEEE', 'pwd', 2), ('Jr.AssistMEC', 'pwd', 2), ('Jr.AssistIT', 'pwd', 2), ('Jr.AssistCHE', 'pwd', 2), ('Jr.AssistCIV', 'pwd', 2), ('Jr.AssistDE', 'pwd', 2),("1111111111", "pwd", 4);

