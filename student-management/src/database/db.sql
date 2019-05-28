--drop database

BEGIN

   FOR cur_rec IN (SELECT object_name, object_type
                     FROM user_objects
                    WHERE object_type IN
                             ('TABLE',
                              'VIEW',
                              'PACKAGE',
                              'PROCEDURE',
                              'FUNCTION',
                              'SEQUENCE',
                              'SYNONYM',
                              'PACKAGE BODY'
                             ))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE'
         THEN
            EXECUTE IMMEDIATE    'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE    'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line (   'FAILED: DROP '
                                  || cur_rec.object_type
                                  || ' "'
                                  || cur_rec.object_name
                                  || '"'
                                 );
      END;
   END LOOP;
END;

commit;
/
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
CREATE TABLE Role(
  roleID varchar2(10) PRIMARY KEY,
    roleName varchar2(30)
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
ALTER TABLE Users
    ADD CONSTRAINT FK_userRole_user FOREIGN KEY (userRole)
    REFERENCES Role (roleID);
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
/
--Alter table DiemRenLuyen
ALTER TABLE DiemRenLuyen 
ADD (CONSTRAINT FK_studentID_DiemRenLuyen FOREIGN KEY (studentID)
    REFERENCES Student(studentID),
    
    CONSTRAINT FK_semester_DiemRenLuyen FOREIGN KEY (semester)
    REFERENCES Semester(SemesterID));
COMMIT;
/
--trigger cap nhat sỉ số lớp
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
--trigger cap nhat sỉ số lớp
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
--Trgier Cập nhật điểm môn học
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
ALTER SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY';
/
--insert Role
insert into role values('it','it_department');
insert into role values('st','student');
insert into role values('ctsv','ctsv');
insert into role values('khtc','khtc');
insert into role values('pdt','phongdaotao');
insert into role values('lec','lecture');
COMMIT;
/
--insert Users Student
INSERT INTO Users VALUES('SV001','Student User Name 1',NULL, 'Student Name 1', 'Male', 'st', NULL, '31/12/1999', 'Student Email 1', 'Student address 1');
COMMIT;
/
--insert Users Lecture
INSERT INTO Users VALUES('LE001','Lecture User Name 1',NULL, 'Lecture Name 1', 'Male', 'lec', NULL, '01/01/1985', 'Lecture Email 1', 'Lecture address 1');
COMMIT;
/
--insert Users Phong Dao Tao
INSERT INTO Users VALUES('PDT01','PDT User Name 1',NULL, 'PDT Name 1', 'Male', 'pdt', NULL, '01/01/1985', 'PDT Email 1', 'PDT address 1');
COMMIT;
/
--insert Users IT department 
INSERT INTO Users VALUES('ITD01','IT department User Name 1',NULL, 'IT department Name 1', 'Male', 'it', NULL, '01/01/1985', 'IT department Email 1', 'IT department address 1');
COMMIT;
/
--insert Users CTSV
INSERT INTO Users VALUES('CTS01','CTSV User Name 1',NULL, 'CTSV Name 1', 'Male', 'ctsv', NULL, '01/01/1985', 'CTSV Email 1', 'CTSV address 1');
COMMIT;
/
--insert Users KHTC
INSERT INTO Users VALUES('KHT01','KHTC User Name 1',NULL, 'KHTC Name 1', 'Male', 'khtc', NULL, '01/01/1985', 'KHTC Email 1', 'KHTC address 1');
COMMIT;
/
--thủ tục thêm vào bảng SUBJECT_REGISTRATION làm đăng ký học phần.
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

-- thủ tục in ra số học phí
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
--thủ tục in ra điểm rèn luyện
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
/
--thủ tục lấy ra thông tin của user
create or replace procedure getUserInfo(query_userID users.userID%type)
as
  user_role users.userrole%type;
  temp_classname CLASS.CLASSNAME%type;
  temp_facultyname faculty.facultyname%type;
  temp_academicrank lecture.academicrank%type;
  temp_fullname users.fullname%type;
  temp_gender users.gender%type;
  temp_userrole users.userrole%type;
  temp_phone users.phonenumber%type;
  temp_dob users.dateofbirth%type;
  temp_email users.email%type;
  temp_address users.address%type;
  temp_classid class.classid%type;
  temp_facultyid faculty.facultyid%type;
begin
  select userrole into user_role from users where userID=query_userID;
  select fullname,gender,userrole,PHONENUMBER,DATEOFBIRTH,email,address
        into temp_fullname,temp_gender,temp_userrole,temp_phone,temp_dob,temp_email,temp_address
        from users
        where userid=query_userID;
  if(user_role='st') then
    begin
      select classid into temp_classid from student where STUDENTID=query_userID;
      if(temp_classid is not null) then
        select fullname,gender,userrole,PHONENUMBER,DATEOFBIRTH,email,address,classname,facultyname
        into temp_fullname,temp_gender,temp_userrole,temp_phone,temp_dob,temp_email,temp_address,temp_classname,temp_facultyname
        from users,student,class,FACULTY
        where users.userId=student.STUDENTID and student.CLASSID=class.CLASSID and class.FACULTYID=FACULTY.FACULTYID;
      end if;
    end;
  elsif(user_role='lec') then
    begin
      select facultyid into temp_facultyid from lecture where lectureid=query_userID;
      if(temp_facultyid is not null) then
        select fullname,gender,userrole,users.PHONENUMBER,users.DATEOFBIRTH,email,address,facultyname,academicrank
        into temp_fullname,temp_gender,temp_userrole,temp_phone,temp_dob,temp_email,temp_address,temp_facultyname,temp_academicrank
        from users,lecture,faculty 
        where users.userid=lecture.lectureid and lecture.facultyid=faculty.facultyid;
      end if;
    end;
  end if;
  
  DBMS_OUTPUT.PUT_LINE('full name: ' ||temp_fullname);
  DBMS_OUTPUT.PUT_LINE('gender: ' ||temp_gender);
  DBMS_OUTPUT.PUT_LINE('role: ' ||temp_userrole);
  DBMS_OUTPUT.PUT_LINE('phone number: ' ||temp_phone);
  DBMS_OUTPUT.PUT_LINE('date of birth: ' ||temp_dob);
  DBMS_OUTPUT.PUT_LINE('email: ' ||temp_email);
  DBMS_OUTPUT.PUT_LINE('address: ' ||temp_address);
  if(user_role='st') then
    DBMS_OUTPUT.PUT_LINE('class: ' ||temp_classname);
  elsif(user_role='lec') then
    DBMS_OUTPUT.PUT_LINE('faculty: ' ||temp_facultyname);
  end if;
end;
/