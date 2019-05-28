--BEGIN
--   FOR cur_rec IN (SELECT object_name, object_type
--                     FROM user_objects
--                    WHERE object_type IN
--                             ('TABLE',
--                              'VIEW',
--                              'PACKAGE',
--                              'PROCEDURE',
--                              'FUNCTION',
--                              'SEQUENCE',
--                              'SYNONYM',
--                              'PACKAGE BODY'
--                             ))
--   LOOP
--      BEGIN
--         IF cur_rec.object_type = 'TABLE'
--         THEN
--            EXECUTE IMMEDIATE    'DROP '
--                              || cur_rec.object_type
--                              || ' "'
--                              || cur_rec.object_name
--                              || '" CASCADE CONSTRAINTS';
--         ELSE
--            EXECUTE IMMEDIATE    'DROP '
--                              || cur_rec.object_type
--                              || ' "'
--                              || cur_rec.object_name
--                              || '"';
--         END IF;
--      EXCEPTION
--         WHEN OTHERS
--         THEN
--            DBMS_OUTPUT.put_line (   'FAILED: DROP '
--                                  || cur_rec.object_type
--                                  || ' "'
--                                  || cur_rec.object_name
--                                  || '"'
--                                 );
--      END;
--   END LOOP;
--END;
CREATE TABLE Users (
  userID varchar2(10) PRIMARY KEY,
  userName varchar2(32),
  userPassword varchar2(64),
  fullName varchar2(128),
  gender varchar2(6),
  userRole varchar2(10),
  phoneNumber varchar2(10),
  dateOfBirth date,
  email varchar2(128),
  address varchar2(256)
);
COMMIT;
/
CREATE TABLE Student (
  studentID varchar2(10) PRIMARY KEY,
  classID varchar2(10)
);
COMMIT;
/    
CREATE TABLE Class (
  classId varchar2(10) PRIMARY KEY,
  className varchar2(32),
  classPresident varchar2(10),
  facultyID varchar2(10),
  classSizes number
);
COMMIT;
/    
CREATE TABLE Lecture (
  lectureID varchar2(10) PRIMARY KEY,
  facultyID varchar2(10),
  academicRank varchar2(32)
);
COMMIT;
/
CREATE TABLE Faculty (
  facultyID varchar2(10) PRIMARY KEY,
  facultyName varchar2(32),
  dean varchar2(10),
  openedDate date
);
COMMIT;
/
    
CREATE TABLE PhongDaoTao (
  PDT_id varchar2(10) PRIMARY KEY
);
COMMIT;
/    
CREATE TABLE subject (
  subjectID varchar2(10) PRIMARY KEY,
  subjectName varchar2(64),
  numberOfCredits number,
  facultyID varchar2(10),
  previousSubject varchar2(10),-- mon hoc tien quyet
  createdBy varchar2(10),
  updatedBy varchar2(10),
  heSoDiemQT number,
  heSoDiemGK number,
  heSoDiemTH number,
  heSoDiemCK number,
  createdDate date,
  updatedDate date
);
COMMIT;
/
CREATE TABLE Offering (
    offeringID varchar2(10) PRIMARY KEY,
    subjectID varchar2(10),
    semester varchar(32),
    lectureID varchar2(10),
    slot number
);
COMMIT;
/
CREATE TABLE Semester(
    SemesterID varchar2(32) PRIMARY KEY
);
COMMIT;
/
CREATE TABLE Subject_Registration (
  registrationID number PRIMARY KEY,
  registeredBy varchar2(10),
  approvedBy varchar2(10),
  offeringID varchar2(10),
  semester varchar2(32)
);
COMMIT;
/


CREATE TABLE BangDiem (
  ID_bangdiem varchar2(10) PRIMARY KEY,
  studentID varchar2(10),
  semester varchar2(32)
);
COMMIT;
/

CREATE TABLE DiemMonHoc (
  ID_DiemMonHoc number PRIMARY KEY,
  diemQT number,
  diemGK number,
  diemTH number,
  diemCK number,
  score number,
  createdBy varchar2(10),
  createdDate date,
  ID_bangdiem varchar2(10),
  ID_monHoc varchar2(10)
);
COMMIT;
/
CREATE TABLE IT_department (
  ITdep_ID varchar2(10) PRIMARY KEY
);
COMMIT;
/
CREATE TABLE user_management (
  UM_ID varchar2(10) PRIMARY KEY,
  createdBy varchar2(10),
  updatedBy varchar2(10),
  createdDate date,
  updatedDate date,
  userID varchar2(10)
);
COMMIT;
/
    
CREATE TABLE Ctsv (
  ID_ctsv varchar2(10) PRIMARY KEY
);
COMMIT;
/
CREATE TABLE Scholarship (
  ID_scholarship varchar2(10) PRIMARY KEY,
  money number,
  approvedBy varchar2(10),
  studentID varchar2(10),
  semester varchar2(32)
);
COMMIT;
/
CREATE TABLE Fee (
  feeID varchar2(10) PRIMARY KEY,
  money number,
  semester varchar2(32),
  studentID varchar2(32),
  status number,
  collectedBy varchar2(10)
);
COMMIT;
/
CREATE TABLE KHTC (
  KHTC_id varchar2(10) PRIMARY KEY
);
COMMIT;
/  
CREATE TABLE DiemRenLuyen (
    id_drl number,
    studentID varchar2(10),
    score number,
    semester varchar2(32)
);
COMMIT;
/
--Alter table User
ALTER TABLE Users
     ADD CONSTRAINT check_gender_Users CHECK (gender IN ('Male','Female'));
COMMIT;
/
--Alter table Student
ALTER TABLE Student
ADD (CONSTRAINT FK_studentID_Student FOREIGN KEY (studentID)
    REFERENCES Users(userID),
    CONSTRAINT FK_classID_Student FOREIGN KEY (classID)
    REFERENCES Class(classID));
COMMIT;
/
--Alter table Class
ALTER TABLE Class
ADD (CONSTRAINT FK_classPresident_class FOREIGN KEY (classPresident)
    REFERENCES Student(studentID),
    CONSTRAINT FK_facultyID_class FOREIGN KEY (facultyID)
    REFERENCES Faculty(facultyID));
COMMIT;
/
--Alter table Lecture
ALTER TABLE Lecture
ADD CONSTRAINT FK_facultyID_Lecture FOREIGN KEY (facultyID)
    REFERENCES Faculty(facultyID);
    
ALTER TABLE Lecture
ADD CONSTRAINT FK_lectureID_Lecture FOREIGN KEY (lectureID)
    REFERENCES Users(userID);
COMMIT;
/
--Alter table Faculty
ALTER TABLE Faculty
ADD CONSTRAINT FK_dean_Faculty FOREIGN KEY (dean)
    REFERENCES Lecture(lectureID);
COMMIT;
--Alter table PhongDaoTao
ALTER TABLE PhongDaoTao
ADD CONSTRAINT FK_PDT_id_PhongDaoTao FOREIGN KEY (PDT_id)
    REFERENCES Users(userID);
COMMIT;
/
--Alter table Subject
ALTER TABLE subject
ADD (CONSTRAINT FK_facultyID_subject FOREIGN KEY (facultyID)
    REFERENCES faculty(facultyID),
    
    CONSTRAINT FK_previousSubject_subject FOREIGN KEY (previousSubject)
    REFERENCES subject(subjectID),
    
    CONSTRAINT FK_createdBy_subject FOREIGN KEY (createdBy)
    REFERENCES PhongDaoTao(PDT_id),
    
    CONSTRAINT FK_updatedBy_subject FOREIGN KEY (updatedBy)
    REFERENCES PhongDaoTao(PDT_id));
COMMIT;
/
--Alter table Offering
ALTER TABLE Offering
ADD (CONSTRAINT FK_subjectID_Offering FOREIGN KEY (subjectID)
    REFERENCES SUBJECT(subjectID),
    
    CONSTRAINT FK_lectureID_Offering FOREIGN KEY (lectureID)
    REFERENCES LECTURE(lectureID),
    
    CONSTRAINT FK_semester_Offering FOREIGN KEY (semester)
    REFERENCES Semester(SemesterID));
COMMIT;
/
--Alter table Subject_Registration
ALTER TABLE Subject_Registration
ADD (CONSTRAINT FK_registeredBy_Subject_Registration FOREIGN KEY (registeredBy)
    REFERENCES student(studentID),
    
    CONSTRAINT FK_approvedBy_Subject_Registration FOREIGN KEY (approvedBy)
    REFERENCES PhongDaoTao(PDT_id),
    
    CONSTRAINT FK_subjectID_Subject_Registration FOREIGN KEY (offeringID)
    REFERENCES OFFERING(offeringID),
    
    CONSTRAINT FK_semester_Subject_Registration FOREIGN KEY (semester)
    REFERENCES Semester(SemesterID));

CREATE SEQUENCE registrationID_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 1
 NOCYCLE
 NOCACHE;
COMMIT;
/
--Alter table BangDiem
ALTER TABLE BangDiem
ADD (CONSTRAINT FK_studentID_BangDiem FOREIGN KEY (studentID)
    REFERENCES student(studentID),
    
    CONSTRAINT FK_semester_BangDiem FOREIGN KEY (semester)
    REFERENCES Semester(SemesterID));
COMMIT;
--Alter table DiemMonHoc
ALTER TABLE DiemMonHoc
ADD (CONSTRAINT FK_createdBy_DiemMonHoc FOREIGN KEY (createdBy)
    REFERENCES Lecture(lectureID),
    
    CONSTRAINT FK_ID_bangdiem_DiemMonHoc FOREIGN KEY (ID_bangdiem)
    REFERENCES BangDiem(ID_bangdiem),
    
    CONSTRAINT FK_ID_monHoc_DiemMonHoc FOREIGN KEY (ID_monHoc)
    REFERENCES subject(subjectID));

CREATE SEQUENCE DiemMonHoc_ID_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 1
 NOCYCLE
 NOCACHE;
COMMIT;
/
--Alter table IT_department
ALTER TABLE IT_department
ADD CONSTRAINT FK_ITdep_ID_IT_department FOREIGN KEY (ITdep_ID)
    REFERENCES Users(userID);
COMMIT;
/
--Alter table User_department
ALTER TABLE user_management
ADD (CONSTRAINT FK_createdBy_user_management FOREIGN KEY (createdBy)
    REFERENCES IT_department(ITdep_ID),
    
    CONSTRAINT FK_updatedBy_user_management FOREIGN KEY (updatedBy)
    REFERENCES IT_department(ITdep_ID),
    
    CONSTRAINT FK_userID_user_management FOREIGN KEY (userID)
    REFERENCES Users(userID));
COMMIT;
/
--Alter table Ctsv
ALTER TABLE Ctsv
ADD CONSTRAINT FK_ID_ctsv_Ctsv FOREIGN KEY (ID_ctsv)
    REFERENCES Users(userID);
COMMIT;
/
--Alter table Scholarship
ALTER TABLE Scholarship
ADD (CONSTRAINT FK_approvedBy_Scholarship FOREIGN KEY (approvedBy)
    REFERENCES Ctsv(ID_ctsv),
    
    CONSTRAINT FK_studentID_Scholarship FOREIGN KEY (studentID)
    REFERENCES Student(studentID),
    
    CONSTRAINT FK_semester_Scholarship FOREIGN KEY (semester)
    REFERENCES Semester(SemesterID));
COMMIT;
/
--Alter table Fee
ALTER TABLE Fee
    ADD CONSTRAINT Check_status_Fee CHECK (status IN (0,1));
ALTER TABLE Fee
ADD (CONSTRAINT FK_collectedBy_Fee FOREIGN KEY (collectedBy)
    REFERENCES KHTC(KHTC_id),
    
    CONSTRAINT FK_studentID_Fee FOREIGN KEY (studentID)
    REFERENCES Student(studentID),
    
    CONSTRAINT FK_semester_Fee FOREIGN KEY (semester)
    REFERENCES Semester(SemesterID));

CREATE SEQUENCE Fee_ID_SEQ
 INCREMENT BY 1
 START WITH 1
 NOMAXVALUE
 MINVALUE 1
 NOCYCLE
 NOCACHE;
 COMMIT;
 /
 --Alter table KHTC
 ALTER TABLE KHTC
ADD CONSTRAINT FK_KHTC_id_KHTC FOREIGN KEY (KHTC_id)
    REFERENCES Users(userID);
COMMIT;
--Alter table DiemRenLuyen
ALTER TABLE DiemRenLuyen 
ADD (CONSTRAINT FK_studentID_DiemRenLuyen FOREIGN KEY (studentID)
    REFERENCES Student(studentID),
    
    CONSTRAINT FK_semester_DiemRenLuyen FOREIGN KEY (semester)
    REFERENCES Semester(SemesterID));
COMMIT;
/





ALTER SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY';
/
INSERT INTO Semester VALUES ('2018-2019');
INSERT INTO Semester VALUES ('2017-2018');
INSERT INTO Semester VALUES ('2019-2020');
COMMIT;
/
--insert Users Student
INSERT INTO Users VALUES('SV001','Student User Name 1',NULL, 'Student Name 1', 'Male', NULL, NULL, '31/12/1999', 'Student Email 1', 'Student address 1');
INSERT INTO Users VALUES('SV002','Student User Name 2',NULL, 'Student Name 2', 'Female', NULL, NULL, '31/12/1999', 'Student Email 2', 'Student address 2');
INSERT INTO Users VALUES('SV003','Student User Name 3',NULL, 'Student Name 3', 'Male', NULL, NULL, '31/12/1999', 'Student Email 3', 'Student address 3');
INSERT INTO Users VALUES('SV004','Student User Name 4',NULL, 'Student Name 4', 'Male', NULL, NULL, '31/12/1999', 'Student Email 4', 'Student address 4');
INSERT INTO Users VALUES('SV005','Student User Name 5',NULL, 'Student Name 5', 'Female', NULL, NULL, '31/12/1999', 'Student Email 5', 'Student address 5');
INSERT INTO Users VALUES('SV006','Student User Name 6',NULL, 'Student Name 6', 'Male', NULL, NULL, '31/12/1999', 'Student Email 6', 'Student address 6');
INSERT INTO Users VALUES('SV007','Student User Name 7',NULL, 'Student Name 7', 'Male', NULL, NULL, '31/12/1999', 'Student Email 7', 'Student address 7');
INSERT INTO Users VALUES('SV008','Student User Name 8',NULL, 'Student Name 8', 'Male', NULL, NULL, '31/12/1999', 'Student Email 8', 'Student address 8');
INSERT INTO Users VALUES('SV009','Student User Name 9',NULL, 'Student Name 9', 'Female', NULL, NULL, '31/12/1999', 'Student Email 9', 'Student address 9');
INSERT INTO Users VALUES('SV010','Student User Name 10',NULL, 'Student Name 10', 'Male', NULL, NULL, '31/12/1999', 'Student Email 10', 'Student address 10');
INSERT INTO Users VALUES('SV011','Student User Name 11',NULL, 'Student Name 11', 'Male', NULL, NULL, '31/12/1999', 'Student Email 11', 'Student address 11');
INSERT INTO Users VALUES('SV012','Student User Name 12',NULL, 'Student Name 12', 'Male', NULL, NULL, '31/12/1999', 'Student Email 12', 'Student address 12');
INSERT INTO Users VALUES('SV013','Student User Name 13',NULL, 'Student Name 13', 'Female', NULL, NULL, '31/12/1999', 'Student Email 13', 'Student address 13');
INSERT INTO Users VALUES('SV014','Student User Name 14',NULL, 'Student Name 14', 'Male', NULL, NULL, '31/12/1999', 'Student Email 14', 'Student address 14');
INSERT INTO Users VALUES('SV015','Student User Name 15',NULL, 'Student Name 15', 'Male', NULL, NULL, '31/12/1999', 'Student Email 15', 'Student address 15');
INSERT INTO Users VALUES('SV016','Student User Name 16',NULL, 'Student Name 16', 'Male', NULL, NULL, '31/12/1999', 'Student Email 16', 'Student address 16');
COMMIT;
/
--insert Users Lecture
INSERT INTO Users VALUES('LE001','Lecture User Name 1',NULL, 'Lecture Name 1', 'Male', NULL, NULL, '01/01/1985', 'Lecture Email 1', 'Lecture address 1');
INSERT INTO Users VALUES('LE002','Lecture User Name 2',NULL, 'Lecture Name 2', 'Female', NULL, NULL, '01/01/1985', 'Lecture Email 2', 'Lecture address 2');
INSERT INTO Users VALUES('LE003','Lecture User Name 3',NULL, 'Lecture Name 3', 'Male', NULL, NULL, '01/01/1985', 'Lecture Email 3', 'Lecture address 3');
INSERT INTO Users VALUES('LE004','Lecture User Name 4',NULL, 'Lecture Name 4', 'Male', NULL, NULL, '01/01/1985', 'Lecture Email 4', 'Lecture address 4');
INSERT INTO Users VALUES('LE005','Lecture User Name 5',NULL, 'Lecture Name 5', 'Female', NULL, NULL, '01/01/1985', 'Lecture Email 5', 'Lecture address 5');
INSERT INTO Users VALUES('LE006','Lecture User Name 6',NULL, 'Lecture Name 6', 'Male', NULL, NULL, '01/01/1985', 'Lecture Email 6', 'Lecture address 6');
COMMIT;
/
--insert Users Phong Dao Tao
INSERT INTO Users VALUES('PDT01','PDT User Name 1',NULL, 'PDT Name 1', 'Male', NULL, NULL, '01/01/1985', 'PDT Email 1', 'PDT address 1');
COMMIT;
--insert Users IT department 
INSERT INTO Users VALUES('ITD01','IT department User Name 1',NULL, 'IT department Name 1', 'Male', NULL, NULL, '01/01/1985', 'IT department Email 1', 'IT department address 1');
COMMIT;
--insert Users CTSV
INSERT INTO Users VALUES('CTS01','CTSV User Name 1',NULL, 'CTSV Name 1', 'Male', NULL, NULL, '01/01/1985', 'CTSV Email 1', 'CTSV address 1');
COMMIT;
--insert Users KHTC
INSERT INTO Users VALUES('KHT01','KHTC User Name 1',NULL, 'KHTC Name 1', 'Male', NULL, NULL, '01/01/1985', 'KHTC Email 1', 'KHTC address 1');
COMMIT;
--insert table Faculty
INSERT INTO Faculty VALUES('FAC01','He Thong Thong Tin',NULL,'01/01/2010');
INSERT INTO Faculty VALUES('FAC02','Mang May Tinh and Truyen Thong',NULL,'01/01/2010');
INSERT INTO Faculty VALUES('FAC03','Cong Nghe Phan Mem',NULL,'01/01/2010');
COMMIT;
--insert table Lecture
INSERT INTO Lecture VALUES('LE001','FAC01',NULL);
INSERT INTO Lecture VALUES('LE002','FAC01',NULL);
INSERT INTO Lecture VALUES('LE003','FAC02',NULL);
INSERT INTO Lecture VALUES('LE004','FAC02',NULL);
INSERT INTO Lecture VALUES('LE005','FAC03',NULL);
INSERT INTO Lecture VALUES('LE006','FAC03',NULL);
COMMIT;
--insert table Class
INSERT INTO Class VALUES('CLA01','HTCL 2018',NULL,'FAC01',0);
INSERT INTO Class VALUES('CLA02','ATCL 2018',NULL,'FAC02',0);
INSERT INTO Class VALUES('CLA03','PMCL 2018',NULL,'FAC03',0);
COMMIT;
--trigger cap nhat classSizes
CREATE OR REPLACE TRIGGER increase_classSize AFTER INSERT OR UPDATE ON Student
FOR EACH ROW
BEGIN
  IF(:NEW.classID IS NOT NULL)
      
  THEN
      UPDATE Class 
      set Classsizes = Classsizes + 1
      WHERE classID = :NEW.classID;
  END IF;
  IF(:OLD.classID IS NOT NULL)
  THEN
      UPDATE Class
      set Classsizes = Classsizes - 1
      WHERE classID = :OLD.classID;
  END IF;
END;
/
CREATE OR REPLACE TRIGGER decrease_classSize AFTER DELETE ON Student
FOR EACH ROW
BEGIN
  IF(:OLD.classID IS NOT NULL)
  THEN
      UPDATE Class
      set Classsizes = Classsizes - 1
      WHERE classID = :OLD.classID;
  END IF;
END;
/
--insert table Student 
INSERT INTO Student VALUES('SV001','CLA01');
INSERT INTO Student VALUES('SV002','CLA02');
INSERT INTO Student VALUES('SV003','CLA01');
INSERT INTO Student VALUES('SV004','CLA02');
INSERT INTO Student VALUES('SV005','CLA01');
INSERT INTO Student VALUES('SV006','CLA02');
INSERT INTO Student VALUES('SV007','CLA01');
INSERT INTO Student VALUES('SV008','CLA02');
INSERT INTO Student VALUES('SV009','CLA01');
INSERT INTO Student VALUES('SV010','CLA02');
INSERT INTO Student VALUES('SV011','CLA01');
INSERT INTO Student VALUES('SV012','CLA02');
INSERT INTO Student VALUES('SV013','CLA01');
INSERT INTO Student VALUES('SV014','CLA02');
COMMIT;
--insert table PhongDaoTao
INSERT INTO PhongDaoTao VALUES('PDT01');
COMMIT;

--insert table Subject;
INSERT INTO Subject VALUES('MH001','Subject Name 1',3,'FAC01',NULL,'PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
INSERT INTO Subject VALUES('MH002','Subject Name 2',4,'FAC02',NULL,'PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
INSERT INTO Subject VALUES('MH003','Subject Name 3',3,'FAC03',NULL,'PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
INSERT INTO Subject VALUES('MH004','Subject Name 4',4,'FAC01','MH001','PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
INSERT INTO Subject VALUES('MH005','Subject Name 5',3,'FAC02','MH002','PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
INSERT INTO Subject VALUES('MH006','Subject Name 6',4,'FAC03',NULL,'PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
INSERT INTO Subject VALUES('MH007','Subject Name 7',3,'FAC01','MH004','PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
INSERT INTO Subject VALUES('MH008','Subject Name 8',4,'FAC02',NULL,'PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
INSERT INTO Subject VALUES('MH009','Subject Name 9',3,'FAC03','MH003','PDT01','PDT01',0.2,0.2,0,0.6,NULL,NULL);
COMMIT;
--insert table BangDiem
INSERT INTO BANGDIEM VALUES ('BD001','SV001','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD002','SV002','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD003','SV003','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD004','SV004','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD005','SV005','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD006','SV006','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD007','SV007','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD008','SV008','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD009','SV009','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD010','SV010','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD011','SV011','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD012','SV012','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD013','SV013','2018-2019');
INSERT INTO BANGDIEM VALUES ('BD014','SV014','2018-2019');
COMMIT;

--insert table IT_DEPARTMENT
INSERT INTO IT_DEPARTMENT VALUES ('ITD01');
COMMIT;
--insert table USER_MANAGEMENT
INSERT INTO USER_MANAGEMENT VALUES('UM001','ITD01','ITD01',NULL,NULL,'SV001');
INSERT INTO USER_MANAGEMENT VALUES('UM002','ITD01','ITD01',NULL,NULL,'SV002');
INSERT INTO USER_MANAGEMENT VALUES('UM003','ITD01','ITD01',NULL,NULL,'SV003');
INSERT INTO USER_MANAGEMENT VALUES('UM004','ITD01','ITD01',NULL,NULL,'SV004');
INSERT INTO USER_MANAGEMENT VALUES('UM005','ITD01','ITD01',NULL,NULL,'SV005');
INSERT INTO USER_MANAGEMENT VALUES('UM006','ITD01','ITD01',NULL,NULL,'SV006');
INSERT INTO USER_MANAGEMENT VALUES('UM007','ITD01','ITD01',NULL,NULL,'SV007');
INSERT INTO USER_MANAGEMENT VALUES('UM008','ITD01','ITD01',NULL,NULL,'SV008');
INSERT INTO USER_MANAGEMENT VALUES('UM009','ITD01','ITD01',NULL,NULL,'SV009');
INSERT INTO USER_MANAGEMENT VALUES('UM010','ITD01','ITD01',NULL,NULL,'SV010');
INSERT INTO USER_MANAGEMENT VALUES('UM011','ITD01','ITD01',NULL,NULL,'SV011');
INSERT INTO USER_MANAGEMENT VALUES('UM012','ITD01','ITD01',NULL,NULL,'SV012');
INSERT INTO USER_MANAGEMENT VALUES('UM013','ITD01','ITD01',NULL,NULL,'SV013');
INSERT INTO USER_MANAGEMENT VALUES('UM014','ITD01','ITD01',NULL,NULL,'SV014');
COMMIT;
--insert table CTSV
INSERT INTO CTSV VALUES('CTS01');
COMMIT;
--insert table DIEMMONHOC
INSERT INTO DIEMMONHOC VALUES(DiemMonHoc_ID_SEQ.NEXTVAL,0,0,0,0,0,'LE001',NULL,'BD001','MH001');
INSERT INTO DIEMMONHOC VALUES(DiemMonHoc_ID_SEQ.NEXTVAL,0,0,0,0,0,'LE001',NULL,'BD001','MH002');
INSERT INTO DIEMMONHOC VALUES(DiemMonHoc_ID_SEQ.NEXTVAL,0,0,0,0,0,'LE001',NULL,'BD001','MH003');
INSERT INTO DIEMMONHOC VALUES(DiemMonHoc_ID_SEQ.NEXTVAL,0,0,0,0,0,'LE001',NULL,'BD001','MH004');
COMMIT;
--insert table KHTC
INSERT INTO KHTC VALUES ('KHT01');
COMMIT;
--ínert table FEE
INSERT INTO FEE VALUES ('HP001',14000000,'2018-2019','SV001',1,'KHT01');
INSERT INTO FEE VALUES ('HP002',14000000,'2018-2019','SV002',0,NULL);
INSERT INTO FEE VALUES ('HP003',14000000,'2018-2019','SV003',1,'KHT01');
INSERT INTO FEE VALUES ('HP004',14000000,'2018-2019','SV004',0,NULL);
INSERT INTO FEE VALUES ('HP005',14000000,'2018-2019','SV005',1,'KHT01');
INSERT INTO FEE VALUES ('HP006',14000000,'2018-2019','SV006',0,NULL);
INSERT INTO FEE VALUES ('HP007',14000000,'2018-2019','SV007',1,'KHT01');
INSERT INTO FEE VALUES ('HP008',14000000,'2018-2019','SV008',0,NULL);
INSERT INTO FEE VALUES ('HP009',14000000,'2018-2019','SV009',1,'KHT01');
INSERT INTO FEE VALUES ('HP010',14000000,'2018-2019','SV010',0,NULL);
INSERT INTO FEE VALUES ('HP011',14000000,'2018-2019','SV011',1,'KHT01');
INSERT INTO FEE VALUES ('HP012',14000000,'2018-2019','SV012',0,NULL);
INSERT INTO FEE VALUES ('HP013',14000000,'2018-2019','SV013',1,'KHT01');
INSERT INTO FEE VALUES ('HP014',14000000,'2018-2019','SV014',0,NULL);
INSERT INTO FEE VALUES ('HP015',7000000,'2019-2020','SV001',0,NULL);
COMMIT;
--insert table DiemRenLuyen
INSERT INTO DiemRenLuyen VALUES(1,'SV001',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(2,'SV002',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(3,'SV003',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(4,'SV004',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(5,'SV005',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(6,'SV006',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(7,'SV007',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(8,'SV008',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(9,'SV009',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(10,'SV010',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(11,'SV011',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(12,'SV012',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(13,'SV013',80,'2018-2019');
INSERT INTO DiemRenLuyen VALUES(14,'SV014',80,'2018-2019');
COMMIT;
--insert Offering
INSERT INTO OFFERING VALUES('MH001.201','MH001','2018-2019',NULL,50);
INSERT INTO OFFERING VALUES('MH001.101','MH001','2018-2019',NULL,100);
INSERT INTO OFFERING VALUES('MH002.201','MH002','2018-2019',NULL,50);
INSERT INTO OFFERING VALUES('MH004.201','MH004','2018-2019',NULL,50);
INSERT INTO OFFERING VALUES('MH005.201','MH005','2018-2019',NULL,50);
INSERT INTO OFFERING VALUES('MH006.201','MH006','2018-2019',NULL,50);
COMMIT;
--Trgier Cap nhat diem mon hoc
/
CREATE OR REPLACE TRIGGER update_score_DiemMonHoc BEFORE UPDATE ON DIEMMONHOC
FOR EACH ROW
DECLARE
    v_HeSoGK number;
    v_HeSoQT number;
    v_HeSoTH number;
    v_HeSoCK number;
BEGIN
    SELECT s.HESODIEMQT,s.HESODIEMGK,s.HESODIEMTH,s.HESODIEMCK
    INTO v_HeSoQT,v_HeSoGK,v_HeSoTH,v_HeSoCK
    FROM SUBJECT s
    WHERE s.SUBJECTID = :NEW.ID_monHoc;
    IF(v_HeSoQT = 0)
    THEN
        :NEW.diemQT := 0;
    END IF;
    IF(v_HeSoGK = 0)
    THEN
        :NEW.diemGK := 0;
    END IF;
    IF(v_HeSoTH = 0)
    THEN
        :NEW.diemTH := 0;
    END IF;
    IF(v_HeSoCK = 0)
    THEN
        :NEW.diemCK := 0;
    END IF;
    :NEW.score := :NEW.diemQT * v_HeSoQT + :NEW.diemGK * v_HeSoGK + :NEW.diemTH * v_HeSoTH + :NEW.diemCK * v_HeSoCK;
END;
/
CREATE OR REPLACE PROCEDURE INSERT_SUBJECT_REGISTRATION (in_studentID STUDENT.STUDENTID%TYPE,in_PDT_ID PHONGDAOTAO.PDT_ID%TYPE, 
in_offeringID OFFERING.OFFERINGID%TYPE, in_semester OFFERING.SEMESTER%TYPE)
AS
    v_Score DIEMMONHOC.SCORE%TYPE;
    v_preSubject SUBJECT.PREVIOUSSUBJECT%TYPE;
    v_countSubject number;
    v_SubjectID SUBJECT.SUBJECTID%TYPE;
    cur_BangDiemID BANGDIEM.ID_BANGDIEM%TYPE;
    v_status number := 0;
    CURSOR cur IS SELECT ID_BANGDIEM
                  FROM BANGDIEM
                  WHERE BANGDIEM.STUDENTID = in_studentID;
BEGIN
       SELECT PREVIOUSSUBJECT
       INTO v_preSubject
       FROM SUBJECT S, OFFERING O
       WHERE S.SUBJECTID = O.SUBJECTID AND O.OFFERINGID = in_offeringID;
    
       IF(v_preSubject IS NOT NULL)
       THEN
            OPEN cur;
            LOOP
                FETCH cur INTO cur_BangDiemID;
                EXIT WHEN cur%NOTFOUND;
                BEGIN
                    SELECT score
                    INTO v_Score
                    FROM BANGDIEM,DIEMMONHOC
                    WHERE BANGDIEM.ID_BANGDIEM = DIEMMONHOC.ID_BANGDIEM AND BANGDIEM.ID_BANGDIEM = cur_BangDiemID AND BANGDIEM.STUDENTID = in_studentID AND DIEMMONHOC.ID_MONHOC = v_preSubject;
                EXCEPTION
                    WHEN NO_DATA_FOUND
                    THEN
                        v_Score:= NULL;
                END;
                IF(v_Score > 5)
                THEN
                    v_status := 1;
                    --RAISE_APPLICATION_ERROR(-20000, 'Dieu Kien Tien Quyet Khong Duoc');
                END IF;
            END LOOP;
            IF(v_status = 0)
            THEN
            RAISE_APPLICATION_ERROR(-20000, 'Dieu Kien Tien Quyet Khong Duoc');
            END IF;
       END IF;
       
       SELECT subjectID
       INTO v_SubjectID
       FROM OFFERING
       WHERE OFFERING.OFFERINGID = in_offeringID;
       
       SELECT COUNT(*)
       INTO v_countSubject
       FROM SUBJECT_REGISTRATION sr, OFFERING o, SUBJECT s
       WHERE sr.REGISTEREDBY= 'SV001' AND sr.OFFERINGID = o.OFFERINGID AND o.SUBJECTID = s.SUBJECTID AND o.SUBJECTID = v_SubjectID ;

       IF(v_countSubject > 0)
       THEN
            RAISE_APPLICATION_ERROR(-20001, 'Mon nay da duoc dang ky');
       END IF;
       SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
       INSERT INTO SUBJECT_REGISTRATION VALUES (registrationID_SEQ.NEXTVAL,in_studentID,in_PDT_ID,in_offeringID,in_semester);
       COMMIT;
END;
/


CREATE OR REPLACE PROCEDURE print_Fee (in_StudentID IN STUDENT.STUDENTID%TYPE)
AS
    cur_FeeID FEE.FEEID%TYPE;
    v_Fee FEE%ROWTYPE;
    v_status varchar2(50);
    CURSOR cur IS SELECT FEE.FEEID
                FROM FEE
                WHERE FEE.STUDENTID = in_StudentID;
BEGIN
    OPEN cur;
    LOOP
        FETCH cur INTO cur_FeeID;
        EXIT WHEN cur%NOTFOUND;
        SELECT * 
        INTO v_Fee
        FROM FEE
        WHERE FEE.FEEID = cur_FeeID;
        IF(v_Fee.status = 1)
        THEN
            v_status:= 'Completed';
        ELSIF(v_Fee.status = 0)
        THEN
            v_status:= 'Pending';
        END IF;
        dbms_output.put_line('feeID: '||v_Fee.FeeID||', money: '||v_Fee.money||', semester: '||v_Fee.semester||', studentID: '||
        v_Fee.studentID||', status: '||v_status||', collectedBy: '||v_Fee.collectedBy); 
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE print_drl (in_studentID IN DIEMRENLUYEN.STUDENTID%TYPE, in_semester IN DIEMRENLUYEN.SEMESTER%TYPE)
AS
    v_drl DIEMRENLUYEN.SCORE%TYPE;
BEGIN
    SELECT score
    INTO v_drl
    FROM DIEMRENLUYEN D
    WHERE d.STUDENTID = in_studentID AND d.SEMESTER = in_semester;
    dbms_output.put_line('Diem Ren Luyen Cua Sinh Vien '||in_studentID||' la: '||v_drl); 
END;
/
CREATE OR REPLACE PROCEDURE sleep (in_time number)
AS
    v_now date;
BEGIN
    SELECT SYSDATE 
    INTO v_now
    FROM DUAL;
    
    LOOP
        EXIT WHEN v_now + (in_time * (1/86400)) <= SYSDATE;
    END LOOP;
END;
