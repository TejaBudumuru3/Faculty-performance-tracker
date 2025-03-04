drop database TestDB;
create database TestDB;
use TestDB;

CREATE TABLE Role (
    RoleID int auto_increment PRIMARY KEY,
    FacultyRole VARCHAR(45) NOT NULL
);


CREATE TABLE Department (
    DepartmentID int auto_increment PRIMARY KEY,
    DepartmentName VARCHAR(45) NOT NULL
);


CREATE TABLE Faculty (
    FacultyID VARCHAR(15) PRIMARY KEY,
    FacultyName VARCHAR(100) NOT NULL,
    FacultyContact VARCHAR(15) NOT NULL,
    FacultyEmail VARCHAR(45) NOT NULL,
    FacultyExperience int NOT NULL,
    FacultyDesignation VARCHAR(45) NOT NULL,
    DepartmentID int NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) ON DELETE CASCADE ON UPDATE CASCADE
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

CREATE TABLE Report (
    ReportID int auto_increment PRIMARY KEY,
    FacultyID VARCHAR(15) NOT NULL,
    SemisterCredits INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
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
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Log Table
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




insert into role (FacultyRole) values ('Faculty'), ('Junio Assisstant'), ('Head of the Department'), ('Higher Authority');

insert into department (DepartmentName) values ('CSE'), ('ECE'), ('EEE'), ('MEC'), ('IT'), ('CHE'), ('CIV'), ('DE');

insert into faculty values ('1111111111', 'HA', '9999999999', 'mvgr@mvgrce.edu.in', 27, 'Higher Authority', 1);

insert into faculty values ('21331A0100', 'Nikhil', '7207300100', 'nikhil@gmail.com', 1, 'Junior Assisstant', 1);
insert into faculty values ('21331A0101', 'Sai', '7207300101', 'sai@gmail.com', 15, 'Senior Professor', 1);
insert into faculty values ('21331A0102', 'Teja', '7207300102', 'teja@gmail.com', 5, 'Associate Professor', 1);

insert into faculty values ('21331A0200', 'Mani', '7207300200', 'mani@gmail.com', 2, 'Junior Assisstant', 2);
insert into faculty values ('21331A0201', 'Hemanth', '7207300201', 'hemanth@gmail.com', 7, 'Associate Professor', 2);
insert into faculty values ('21331A0202', 'Kumar', '7207300202', 'kumar@gmail.com', 6, 'Associate Professor', 2);

insert into faculty values ('21331A0300', 'Devi', '7207300300', 'devi@gmail.com', 1, 'Junior Assisstant', 3);
insert into faculty values ('21331A0301', 'Siva', '7207300301', 'siva@gmail.com', 9, 'Associate Professor', 3);
insert into faculty values ('21331A0302', 'Vanitha', '7207300302', 'vanitha@gmail.com', 10, 'Professor', 3);

insert into faculty values ('21331A0400', 'Padma', '7207300400', 'padma@gmail.com', 1, 'Junior Assisstant', 4);
insert into faculty values ('21331A0401', 'Varshit', '7207300401', 'varshit@gmail.com', 12, 'Professor', 4);
insert into faculty values ('21331A0402', 'Sankar', '7207300402', 'sankar@gmail.com', 9, 'Associate Professor', 4);

insert into faculty values ('21331A0500', 'Kalyani', '7207300500', 'kalyani@gmail.com', 4, 'Junior Assisstant', 5);
insert into faculty values ('21331A0501', 'Yashwanth', '7207300501', 'yashwanth@gmail.com', 1, 'Assisstant Professort', 5);
insert into faculty values ('21331A0502', 'Nissi', '7207300502', 'nissi@gmail.com', 13, 'Senior Professor', 5);

insert into faculty values ('21331A0600', 'Kalyan', '7207300600', 'kalyan@gmail.com', 4, 'Junior Assisstant', 6);
insert into faculty values ('21331A0601', 'Amani', '7207300601', 'amani@gmail.com', 7, 'Associate Professor', 6);
insert into faculty values ('21331A0602', 'Krishna', '7207300602', 'krishna@gmail.com', 14, 'Senior Professor', 6);

insert into faculty values ('21331A0700', 'Karthik', '7207300700', 'karthik@gmail.com', 2, 'Junior Assisstant', 7);
insert into faculty values ('21331A0701', 'Balaji', '7207300701', 'balaji@gmail.com', 5, 'Associate Professor', 7);
insert into faculty values ('21331A0702', 'Sushmitha', '7207300702', 'sushmitha@gmail.com', 1, 'Assisstant Professor', 7);

insert into faculty values ('21331A0800', 'Nandan', '7207300800', 'nandan@gmail.com', 8, 'Junior Assisstant', 8);
insert into faculty values ('21331A0801', 'Dillep', '7207300801', 'dileep@gmail.com', 10, 'Associate Professor', 8);
insert into faculty values ('21331A0802', 'Triveni', '7207300802', 'triveni@gmail.com', 9, 'Associate Professor', 8);


insert into faculty_has_roles (RoleID, FacultyID) values (1, '21331A0101'), (1, '21331A0102'), (1, '21331A0201'), (1, '21331A0202'), (1, '21331A0301'), (1, '21331A0302'), (1, '21331A0401'), (1, '21331A0402'), (1, '21331A0501'), (1, '21331A0502'), (1, '21331A0601'), (1, '21331A0602'), (1, '21331A0701'), (1, '21331A0702'), (1, '21331A0801'), (1, '21331A0802'), (2, '21331A0100'), (2,'21331A0200'), (2,'21331A0300'), (2,'21331A0400'), (2,'21331A0500'), (2,'21331A0600'), (2,'21331A0700'), (2,'21331A0800'), (3, '21331A0101'), (3, '21331A0201'), (3, '21331A0301'), (3, '21331A0401'), (3, '21331A0501'), (3, '21331A0601'), (3, '21331A0701'), (3, '21331A0801'), (4, '21331A0102'), (4, '21331A0202'), (4, '21331A0302'), (4, '1111111111');

insert into Credentials (FacultyID, FacultyPassword, RoleID) values ('21331A0101', 'Password', 1), ('21331A0102', 'Password', 1), ('21331A0201', 'Password', 1), ('21331A0202', 'Password', 1), ('21331A0301', 'Password', 1), ('21331A0302', 'Password', 1), ('21331A0401', 'Password', 1), ('21331A0402', 'Password', 1), ('21331A0501', 'Password', 1), ('21331A0502', 'Password', 1), ('21331A0601', 'Password', 1), ('21331A0602', 'Password', 1), ('21331A0701', 'Password', 1), ('21331A0702', 'Password', 1), ('21331A0801', 'Password', 1), ('21331A0802', 'Password', 1), ('21331A0100', 'Password2', 2), ('21331A0200', 'Password2', 2), ('21331A0300', 'Password2', 2), ('21331A0400', 'Password2', 2), ('21331A0500', 'Password2', 2), ('21331A0600', 'Password2', 2), ('21331A0700', 'Password2', 2), ('21331A0800', 'Password2', 2), ('21331A0101', 'PWD', 3), ('21331A0201', 'PWD', 3), ('21331A0301', 'PWD', 3), ('21331A0401', 'PWD', 3), ('21331A0501', 'PWD', 3), ('21331A0601', 'PWD', 3), ('21331A0701', 'PWD', 3), ('21331A0801', 'PWD', 3), ('1111111111', 'MVGR@1111', 4), ('21331A0102', 'MVGR@1111', 4), ('21331A0202', 'MVGR@1111', 4), ('21331A0302', 'MVGR@1111', 4);

insert into category (CategoryName) values ('Academics'), ('Examination'), ('Placement'), ('Swecha'), ('NSS'), ('FYFP'), ('Dance'), ('Music'), ('Film');
insert into category (CategoryName) values ('Transportation');

insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0101', 1, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0102', 1, 'Incharge');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0201', 2, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0202', 2, 'Incharge');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0302', 3, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0402', 4, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0502', 5, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0601', 6, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0501', 6, 'Incharge');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0601', 7, 'Incharge');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0701', 7, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0801', 8, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0602', 8, 'Incharge');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0301', 9, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0302', 9, 'Incharge');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0702', 9, 'Incharge');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0401', 10, 'Head');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0402', 10, 'Incharge');
insert into Membership (FacultyID, CategoryID, MembershipName) values ('21331A0802', 10, 'Incharge');

insert into token (facultyID, Date, Task, Status) values ('21331A0102', '2025-01-28', 'Syllabus Modification', 0);
insert into token (facultyID, Date, Task, Status) values ('21331A0202', '2025-01-28', 'Exam Evaluation Schema', 0);
insert into token (facultyID, Date, Task, Status) values ('21331A0302', '2025-01-30', 'Moc Test Results', 0);

insert into report (FacultyID, SemisterCredits, StartDate, EndDate, ClassHours, PreparationTime, ProjectReview, CounsellingHours, InvigilationHours, ExamEvaluations, Viva, Externals, Meetings, Seminars, Workshops, EventHours, PublicationResearchWork, PublicationsPublished, PatentResearchWork, PatentsGained) values 
('21331A0101', 99, '2023-01-01', '2024-12-31', 40, 30, 20, 20, 15, 15, 6, 6, 8, 5, 5, 7, 9, 5, 6, 12), 
('21331A0102', 100, '2023-01-01', '2024-12-31', 41, 30, 20, 20, 15, 15, 6, 6, 8, 5, 5, 7, 9, 5, 6, 12), 
('21331A0201', 98, '2023-01-01', '2024-12-31', 39, 30, 20, 20, 15, 15, 6, 6, 8, 5, 5, 7, 9, 5, 6, 12);

insert into Log (FacultyID, Date, ClassHours, PreparationTime, ProjectReview, CounsellingHours, InvigilationHours, ExamEvaluations, Viva, Externals, Meetings, Seminars, Workshops, EventHours, PublicationResearchWork, PublicationsPublished, PatentResearchWork, PatentsGained, LogCredit) values 
('21331A0101', '2025-01-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-3', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-4', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-5', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-7', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-9', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-10', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-19', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-20', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-21', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-22', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-23', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-26', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-01-30', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-02-3', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0101', '2025-02-4', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),

('21331A0102', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0201', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0202', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0301', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0302', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0401', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0402', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0501', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0502', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0601', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0602', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0701', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0702', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0801', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0802', '2025-01-27', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),

('21331A0102', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0201', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0202', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0301', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0302', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0401', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0402', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0501', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0502', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0601', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0602', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0701', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0702', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0801', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0802', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),

('21331A0102', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0201', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0202', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0301', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0302', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0401', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0402', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0501', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0502', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0601', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0602', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0701', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0702', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0801', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0802', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),

('21331A0102', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0201', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0202', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0301', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0302', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0401', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0402', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0501', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0502', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0601', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0602', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0701', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0702', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0801', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0802', '2025-01-28', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),

('21331A0102', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0201', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0202', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0301', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0302', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0401', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0402', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0501', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0502', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0601', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0602', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0701', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0702', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0801', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0802', '2025-01-29', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),

('21331A0102', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0201', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0202', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0301', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0302', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0401', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0402', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0501', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0502', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0601', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0602', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0701', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0702', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0801', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0802', '2025-02-1', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),

('21331A0102', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0201', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0202', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0301', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0302', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0401', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0402', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0501', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0502', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0601', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0602', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0701', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0702', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0801', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0),
('21331A0802', '2025-02-2', 3, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0);


UPDATE log
SET LogCredit = (
    ClassHours + PreparationTime + ProjectReview + CounsellingHours + 
    InvigilationHours + ExamEvaluations + Viva + Externals + Meetings + 
    Seminars + Workshops + EventHours + PublicationResearchWork + PatentResearchWork
);