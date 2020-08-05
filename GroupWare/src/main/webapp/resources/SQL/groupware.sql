-- sys°èÁ¤ ³»¿ë --
show user; -- USERÀÌ(°¡) "SYS"ÀÔ´Ï´Ù.
create user finalorauser3 identified by eclass
default tablespace users;
 
grant connect, resource, unlimited tablespace to finalorauser3;
grant create view to finalorauser3;
--------------------------------------------------------------------
-- finalorauser3°èÁ¤ ³»¿ë --
show user; -- USERÀÌ(°¡) "FINALORAUSER3"ÀÔ´Ï´Ù.

select * from tab;
select * from seq;

-- Å×ÀÌºí »èÁ¦ -- 
drop table comment_table purge;
drop sequence comment_table_seq;
drop table attachFile_table purge;
drop SEQUENCE attachFile_table_seq;
drop table board_table purge;
drop sequence board_table_seq;
drop table board_category purge;
drop table attendance_table purge;
drop table reservation_table purge;
drop sequence reservation_table_seq;
drop table reservationRoom_table purge;
drop table mailReceive_table purge;
drop table mail_table purge;
drop sequence mail_table_seq;
drop table messengerLog_table purge;
drop table messenger_table purge;
drop sequence messenger_table_seq;
drop table messengerRoom_table purge;
drop sequence messengerRoom_table_seq;
drop table companyCalendar_table purge;
drop sequence companyCalendar_table_seq;
drop table personalCalendar_table purge;
drop sequence personalCalendar_table_seq;
drop table projectMember_table purge;
drop sequence projectMember_table_seq;
drop table project_table purge;
drop sequence project_table_seq;
drop table document_table purge;
drop sequence document_table_seq;
drop table trip_table purge;
drop sequence trip_table_seq;
drop table trip_category purge;
drop table grade_table purge;
drop table TA_table purge;
drop sequence ta_table_seq;
drop table clubMember_table purge;
drop sequence clubMember_table_seq;
drop table club_table purge;
drop sequence club_table_seq;
drop table sales_table purge;
drop sequence sales_table_seq;
drop table fire_table purge;
drop table album_table purge;
drop sequence album_table_seq;
drop table album_category purge;
drop table employees_table purge;
drop sequence employees_table_seq;
drop table department_table purge;
drop sequence department_table_seq;
drop table employeeStatus_table purge;
drop table position_table purge;

 -- Á÷±Ş Å×ÀÌºí(position_table) --
create table position_table
(position_seq   number not null -- Á÷Ã¥¹øÈ£
,position_name  varchar2(50) not null -- Á÷Ã¥¸í
,position_salary    number not null -- Á÷Ã¥ ±Ş¿©
,constraint pk_position_seq primary key(position_seq)
); 


 -- »ç¿ø»óÅÂ Å×ÀÌºí(employeeStatus_table) --
create table employeeStatus_table
(status_seq     number not null -- »ç¿ø »óÅÂ¹øÈ£
,status_name    varchar2(50) not null -- »ç¿ø »óÅÂ¸í
,constraint pk_employeeStatus primary key(status_seq)
);


 -- ºÎ¼­Å×ÀÌºí(department_table) --
create table department_table
(department_seq number not null
,department_name    varchar2(100) not null
,constraint pk_department_table primary key(department_seq)
);

create SEQUENCE department_table_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

 
 -- »ç¿øÅ×ÀÌºí(employees_table)--
 create table employees_table
(employee_seq   number -- »ç¿ø¹øÈ£
,employee_name  varchar2(10) not null -- »ç¿ø¸í
,employee_id    varchar2(100) not null -- »ç¿øID
,employee_pw    varchar2(500) not null -- »ç¿øPW
,email          varchar2(500) not null -- »ç³» ÀÌ¸ŞÀÏ
,phone          varchar2(500) not null -- ÇÚµåÆù¹øÈ£
,fk_status      number default 1 not null -- »ç¿ø»óÅÂ
,hire_date      date default sysdate not null -- ÀÔ»ç³¯Â¥
,fire_date      date -- Åğ»ç³¯Â¥
,fk_position    number default 1 -- »ç¿øÁ÷Ã¥
,fk_department  number -- ºÎ¼­
,grade          number default 1 not null -- ±ÇÇÑ
,gender         number(1) not null -- ¼ºº°(1:³² , 2:¿©)
,birthday       varchar2(8) not null -- »ı³â¿ùÀÏ
,address        varchar2(300) not null -- ÁÖ¼Ò
,postcode       varchar2(300) not null -- ¿ìÆí¹øÈ£
,detailaddress  varchar2(500)-- »ó¼¼ÁÖ¼Ò
,extraaddress  varchar2(500)-- Âü°íÇ×¸ñ
,constraint pk_employees_table primary key(employee_seq)
,constraint fk_employees_status foreign key (fk_status) REFERENCES employeeStatus_table(status_seq)
,constraint fk_employees_position foreign key(fk_position) references position_table(position_seq) on DELETE SET null
,constraint fk_employees_department foreign key(fk_department) references department_table(department_seq) on delete set null
);

 create SEQUENCE employees_table_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


 -- album Ä«Å×°í¸® Å×ÀÌºí(album_category) --
 create table album_category
(category_num   number not null -- ¿¤¹ü °Ô½Ã±ÛÀÇ Ç×¸ñ¹øÈ£(È¸»çÇà»ç, µ¿È£È¸, ºÀ»ç)
,category_name  varchar2(50) not null -- Ç×¸ñÀÌ¸§
,constraint pk_album_category primary key (category_num)
);



 -- album Å×ÀÌºí(album_table) --
create table album_table
(album_seq  number not null -- album°Ô½Ã±Û ¹øÈ£
,album_category number -- album°Ô½Ã±Û Ç×¸ñ
,fk_employee_seq    number  -- °Ô½Ã±Û ÀÛ¼ºÀÚ ¹øÈ£
,subject    varchar2(500) not null -- °Ô½Ã±Û Á¦¸ñ
,content    varchar2(4000) not null -- °Ô½Ã±Û ³»¿ë
,constraint pk_album_table primary key (album_seq)
,constraint fk_album_category foreign key (album_category) REFERENCES album_category(category_num)on delete set null
,constraint fk_album_employee foreign key (fk_employee_seq) references  employees_table(employee_seq) on delete set null
);

create sequence album_table_seq
start with 1 
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- Åğ»ç»çÀ¯ Å×ÀÌºí(fire_date) --
create table fire_table
(fk_employee_seq    number
,groupno    varchar2(50) not null -- ¹®¼­°áÀç Å×ÀÌºí°ú ¿¬µ¿ÇÏµµ·Ï ÇÏ´Â ÄÃ·³
,reason varchar2(4000) -- Åğ»ç »çÀ¯
,interviewer_seq    number not null -- ¸é´ãÀÚ »ç¿ø¹øÈ£
,interview_content  varchar2(4000) not null -- ¸é´ã³»¿ë
,documentStatus     number default 0 not null -- ¿¬°áµÇ¾îÀÖ´Â °áÀç¹®¼­ÀÇ ½ÂÀÎ»óÅÂ °ª°ú ¿¬µ¿??
,constraint fk_fire_employees foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);

-- ¸ÅÃâ Å×ÀÌºí(sales_table) --
create table sales_table
(sales_seq  number not null -- ¸ÅÃâ¹øÈ£
,groupno    varchar2(50) not null -- ¹®¼­°áÀç Å×ÀÌºí°ú ¿¬µ¿ÇÏµµ·Ï ÇÏ´Â ÄÃ·³
,sales_title    varchar2(500) not null -- ¸ÅÃâÁ¦¸ñ
,sales_price    number  not null -- ¸ÅÃâ °¡°İ
,sales_count    number not null -- ¸ÅÃâ °³¼ö
,reason     varchar2(4000) not null -- ¸ÅÃâ »çÀ¯
,fk_department_seq  number -- ¸ÅÃâ ºÎ¼­
,regDate    date default sysdate not null -- ¸ÅÃâ ±â·Ï ³¯Â¥
,documentStatus     number default 1 not null -- ¿¬°áµÇ¾îÀÖ´Â °áÀç¹®¼­ÀÇ ½ÂÀÎ»óÅÂ °ª°ú ¿¬µ¿??
,constraint pk_sales_approval primary key(sales_seq)
,constraint fk_sales_department foreign key(fk_department_seq) REFERENCES department_table(department_seq) on delete set null
);

create SEQUENCE sales_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

 -- µ¿È£È¸ Å×ÀÌºí(club_table) --
create table club_table
(club_seq   number not null -- µ¿È£È¸ ¹øÈ£
,groupno    varchar2(50) not null -- ¹®¼­°áÀç Å×ÀÌºí°ú ¿¬µ¿ÇÏµµ·Ï ÇÏ´Â ÄÃ·³
,club_name  varchar2(100) not null -- µ¿È£È¸ ÀÌ¸§
,club_info  varchar2(2000) -- µ¿È£È¸ ¼Ò°³
,regDate    date default sysdate not null -- µ¿È£È¸ »ı¼º³¯Â¥
,documentStatus     number default 1 not null -- ¿¬°áµÇ¾îÀÖ´Â °áÀç¹®¼­ÀÇ ½ÂÀÎ»óÅÂ °ª°ú ¿¬µ¿??
,representative_img  varchar2(500) not null -- µ¿È£È¸ ´ëÇ¥ ÀÌ¹ÌÁö
,constraint pk_club_table primary key(club_seq)
);

create SEQUENCE club_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;
 
 
-- µ¿È£È¸¸í´Ü Å×ÀÌºí(clubMember_table)
create table clubMember_table
(member_seq number not null -- ¸í´Ü¹øÈ£
,groupno    varchar2(50) not null -- ¹®¼­°áÀç Å×ÀÌºí°ú ¿¬µ¿ÇÏµµ·Ï ÇÏ´Â ÄÃ·³
,fk_club    number not null -- °¡ÀÔÇÑ µ¿È£È¸
,status     number  default 0 not null -- »óÅÂ(0:ÀÏ¹İ, 1:È¸Àå)
,regDate    date default sysdate not null -- °¡ÀÔ³¯Â¥
,fk_employee_seq    number  -- °¡ÀÔÇÑ »ç¿ø¹øÈ£
,documentStatus     number default 1 -- ¿¬°áµÇ¾îÀÖ´Â °áÀç¹®¼­ÀÇ ½ÂÀÎ»óÅÂ °ª°ú ¿¬µ¿??
,constraint pk_clubMember_table primary key(member_seq)
,constraint fk_clubMember_club foreign key (fk_club) references club_table(club_seq) on delete cascade
,constraint fk_clubMember_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
);

create SEQUENCE clubMember_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- ±ÙÅÂ°ü¸® Å×ÀÌºí(TA_table) --
create table TA_table
(ta_seq     number not null -- ±ÙÅÂ°ü¸® Çà ¹øÈ£
,groupno    varchar2(50) not null -- ¹®¼­°áÀç Å×ÀÌºí°ú ¿¬µ¿ÇÏµµ·Ï ÇÏ´Â ÄÃ·³
,fk_employee_seq    number -- ´ë»ó »ç¿ø ¹øÈ£
,attendance     varchar2(50) not null -- Ãâ°áÁ¡¼ö
,attitude       varchar2(50) not null -- ÅÂµµÁ¡¼ö
,performance    varchar2(50) not null -- ¾÷¹«¼º°ú Á¡¼ö
,manager    varchar2(100) not null -- ±â¾ÈÀÚ(ÀÌ¸§)
,reason     varchar2(4000) not null -- Á¡¼ö¸¦ ÁØ »çÀ¯(ÀüÃ¼)
,regDate    date default sysdate not null -- ±ÙÅÂ°ü¸® µî·Ï ³¯Â¥
,documentStatus     number default 1 -- ¿¬°áµÇ¾îÀÖ´Â °áÀç¹®¼­ÀÇ ½ÂÀÎ»óÅÂ °ª°ú ¿¬µ¿??
,constraint pk_ta_table primary key(ta_seq)
,constraint fk_ta_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
);

create SEQUENCE ta_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- ±ÇÇÑ Ç×¸ñ Å×ÀÌºí(grade_table) --
create table grade_table
(grade_level    number not null
,grade_name     varchar2(50)
,constraint pk_grade_table primary key(grade_level)
);

-- ÈŞ°¡/ÃâÀå Ç×¸ñ Å×ÀÌºí(trip_category)--
create table trip_category
(category_num   number not null -- ÈŞ°¡/ÃâÀå Ç×¸ñ ¹øÈ£
,category_name  varchar2(50) not null -- Ç×¸ñ ÀÌ¸§
,constraint pk_trip_category primary key(category_num)
);

-- ÈŞ°¡/ÃâÀå Å×ÀÌºí(trip_table) --
create table trip_table
(trip_seq   number not null -- ¹øÈ£
,groupno    varchar2(50) not null -- ¹®¼­°áÀç Å×ÀÌºí°ú ¿¬µ¿ÇÏµµ·Ï ÇÏ´Â ÄÃ·³
,trip_category  number -- ÈŞ°¡/ÃâÀå Ç×¸ñ¹øÈ£
,reason     varchar2(4000) not null -- »çÀ¯
,trip_start date not null -- ÈŞ°¡/ÃâÀå ½ÃÀÛ ³¯Â¥
,trip_end   date not null -- ÈŞ°¡/ÃâÀå º¹±Í ³¯Â¥
,triplocatioin      varchar2(1000) -- ÃâÀåÁö
,fk_employee_seq    number  -- ½ÅÃ»ÀÚ
,documentStatus     number default 1 not null -- ¿¬°áµÇ¾îÀÖ´Â °áÀç¹®¼­ÀÇ ½ÂÀÎ»óÅÂ °ª°ú ¿¬µ¿??
,constraint pk_trip_table primary key (trip_seq)
,constraint fk_trip_employee foreign key (fk_employee_seq) REFERENCES employees_table(employee_seq)on delete set null
,constraint fk_trip_category foreign key (trip_category) references trip_category(category_num) on delete set null
);

create SEQUENCE trip_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- ¹®¼­°áÀç Ç×¸ñÅ×ÀÌºí(document_category) --
create table document_category
(document_category_seq  number not null -- ¹®¼­°áÀç Ç×¸ñ¹øÈ£
,category_name  varchar2(100) not null -- Ç×¸ñÀÌ¸§
,constraint pk_document_category primary key(document_category_seq)
);

-- ¹®¼­°áÀç Å×ÀÌºí(document_table) --
create table document_table
(document_seq   number not null -- ¹®¼­°áÀç °íÀ¯ ¹øÈ£
,groupno        varchar2(50) not null -- ¹®¼­ ÀÏ·Ã¹øÈ£(°¢°¢ÀÇ °á°ú Å×ÀÌºí¿¡ »ç¿ëÇÒ ¹øÈ£)
,fk_employee_seq    number not null -- °áÀç ½ÅÃ»ÀÚ
,subject    varchar2(1000) not null -- °áÀç¹®¼­ Á¦¸ñ
,content    varchar2(4000) not null -- °áÀç¹®¼­ ³»¿ë (.jpg ÆÄÀÏ)
,regDate    date default sysdate not null -- °áÀç ½ÅÃ»³¯Â¥
,approver_seq   number not null -- °áÀçÀÚ »ç¿ø¹øÈ£
,approveDate    date -- °áÀç³¯Â¥
,fileName   varchar2(500) -- ÆÄÀÏÃ·ºÎ(¾÷·Îµå ÆÄÀÏ¸í)
,orgFileName    varchar2(500) -- ÆÄÀÏÃ·ºÎ(±âÁ¸ ÆÄÀÏ¸í)
,fileSize   number -- ÆÄÀÏÅ©±â
,parent_approver    varchar2(100) -- »óÀ§ °áÀçÀÚ
,status     number not null -- °áÀç »óÅÂ(½ÂÀÎ, ¹Ì½ÂÀÎ, ¹İ·Á)
,reason     varchar2(4000) -- °áÀç »çÀ¯( ¹İ·Á »çÀ¯ )
,document_category  number not null -- ¹®¼­ Ç×¸ñ
,constraint fk_document_employee foreign key (fk_employee_seq) references employees_table(employee_seq) on delete set null
,constraint fk_document_category foreign key (document_category) references document_category(document_category_seq)
);

create SEQUENCE document_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- ÇÁ·ÎÁ§Æ® Å×ÀÌºí(project_table) --
create table project_table
(project_seq    number not null -- ÇÁ·ÎÁ§Æ® ¹øÈ£
,groupno        varchar2(50) not null -- ¹®¼­°áÀç Å×ÀÌºí°ú ¿¬µ¿ÇÏµµ·Ï ÇÏ´Â ÄÃ·³
,project_name   varchar2(500) not null -- ÇÁ·ÎÁ§Æ® ÀÌ¸§
,content    varchar2(4000) not null -- ÇÁ·ÎÁ§Æ® ³»¿ë
,term   number not null -- ÇÁ·ÎÁ§Æ® ±â°£
,startDate  date not null -- ÇÁ·ÎÁ§Æ® ½ÃÀÛ³¯Â¥
,manager    varchar2(50) not null -- ÇÁ·ÎÁ§Æ® Ã¥ÀÓÀÚ
,memberCount    number not null -- ÇÁ·ÎÁ§Æ® Âü°¡ ÀÎ¿ø¼ö
,dwonPayment    number -- °è¾à±İ
,middlePayment  number -- Áßµµ±İ
,completionPayment number -- ¿Ï·á±İ
,documentStatus     number default 0 -- ¿¬°áµÇ¾îÀÖ´Â °áÀç¹®¼­ÀÇ ½ÂÀÎ»óÅÂ °ª°ú ¿¬µ¿??(0:°áÀç ÁøÇàÁß, 1:°áÀç¿Ï·á, »èÁ¦:°áÀç¹İ·Á)
,constraint pk_project_table primary key(project_seq)
);
create SEQUENCE project_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- ÇÁ·ÎÁ§Æ® ¸í´Ü Å×ÀÌºí(projectMember_table) --
create table projectMember_table
(projectMember_seq  number not null -- ÇÁ·ÎÁ§Æ® ¸í´Ü ¹øÈ£
,fk_project_seq     number not null -- ÇÁ·ÎÁ§Æ® ¹øÈ£(ÇÁ·ÎÁ§Æ® ¸í, ÁøÇà»óÅÂ join¿ä¼Ò)
,fk_employee_seq    number -- »ç¿ø¹øÈ£(»ç¿ø¸í, Á÷Ã¥, ºÎ¼­ join¿ä¼Ò)
,constraint pk_projectMember_table primary key(projectMember_seq)
,constraint fk_projectMember_project foreign key(fk_project_seq) references project_table(project_seq) on delete cascade
,constraint fk_projectMember_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);
create SEQUENCE projectMember_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;


-- °³ÀÎÀÏÁ¤ Å×ÀÌºí(personalCalendar_table) --
create table personalCalendar_table
(calendar_seq   number not null -- ÀÏÁ¤¹øÈ£
,fk_employee_seq    number not null -- »ç¿ø¹øÈ£
,title      varchar2(500) not null -- ÀÏÁ¤ Å¸ÀÌÆ²
,content    varchar2(2000) not null -- ÀÏÁ¤³»¿ë
,startDate  date not null -- ÀÏÁ¤½ÃÀÛ ³¯Â¥
,endDate    date not null -- ÀÏÁ¤Á¾·á ³¯Â¥
,color      varchar2(100) -- ¹è°æ»ö     
,constraint pk_personalCalendar primary key(calendar_seq)
,constraint fk_personalcalendar_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
);
create SEQUENCE personalCalendar_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

create table companyCalendar_category
(category_num   number not null -- Ç×¸ñ¹øÈ£
,category_name  varchar2(50) not null -- Ç×¸ñ¸í
,constraint pk_companyCalendar_category primary key(category_num)
);

-- È¸»çÀÏÁ¤ Å×ÀÌºí(companyCalendar_table) --
create table companyCalendar_table
(calendar_seq   number not null -- ÀÏÁ¤¹øÈ£
,title      varchar2(500) not null -- ÀÏÁ¤ Å¸ÀÌÆ²
,content    varchar2(2000) not null -- ÀÏÁ¤³»¿ë
,startDate  date not null -- ÀÏÁ¤½ÃÀÛ ³¯Â¥
,endDate    date not null -- ÀÏÁ¤Á¾·á ³¯Â¥
,color      varchar2(100) -- ¹è°æ»ö
,fk_department_seq number -- ºÎ¼­ÀÏÁ¤ÀÎ °æ¿ì »ç¿ëÇÏ´Â ÄÃ·³
,calendar_category  number not null -- ÀÏÁ¤ Ä«Å×°í¸®(°æÁ¶»ç, Çù·ÂÀÏÁ¤, ´Üµ¶ÀÏÁ¤...µî)
,constraint pk_companyCalendar primary key(calendar_seq)
,constraint fk_companyCal_department foreign key(fk_department_seq) references department_table(department_seq)on delete cascade
,constraint fk_companyCal_category foreign key(calendar_category) references companyCalendar_category(category_num)
);
create SEQUENCE companyCalendar_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;



-- ¸Ş½ÅÀú ±×·ì Å×ÀÌºí(messengerRoom_table) --
create table messengerRoom_table
<<<<<<< HEAD
(roomNumber         number not null                 -- ê·¸ë£¹ ë²ˆí˜¸
,fk_employee_seq    number not null                 -- ì°¸ê°€ì ë²ˆí˜¸
,regDate            date default sysdate not null   -- ì°¸ê°€ë‚ ì§œ
=======
(roomNumber     number not null -- ±×·ì ¹øÈ£
,fk_employee_seq   number not null -- Âü°¡ÀÚ ¹øÈ£
,regDate    date default sysdate not null -- Âü°¡³¯Â¥
>>>>>>> 7370937c5bc06870e685bf15f97b25f11e19cb9f
,constraint pk_messengerRoom primary key(roomNumber, fk_employee_seq)
,constraint fk_messengerRoom_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
);

create SEQUENCE messengerRoom_table_seq
<<<<<<< HEAD
start with 1    -- ì‹œì‘ê°’
increment by 1  -- ì¦ê°€ê°’
nomaxvalue      -- ìµœëŒ€ê°’ ì„¤ì •
nominvalue      -- ìµœì†Œê°’ ì„¤ì •
nocycle         -- ë°˜ë³µ ì„¤ì •
=======
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
>>>>>>> 7370937c5bc06870e685bf15f97b25f11e19cb9f
nocache;

-- ¸Ş½ÅÀú ´ëÈ­ Å×ÀÌºí(messenger_table) --
create table messenger_table
<<<<<<< HEAD
(message_seq        number not null                 -- ëŒ€í™” ë²ˆí˜¸
,content            varchar2(4000) not null         -- ëŒ€í™”ë‚´ìš©
,regDate            date default sysdate not null   -- ëŒ€í™”ë‚ ì§œ
,status             number default 1 not null       -- ëŒ€í™”ìƒíƒœ
,fk_roomNumber      number                          -- ë©”ì‹ ì € ê·¸ë£¹ë²ˆí˜¸
,fk_employee_seq    number                          -- ë°œì‹ ì
=======
(message_seq    number not null -- ´ëÈ­ ¹øÈ£
,content    varchar2(4000) not null -- ´ëÈ­³»¿ë
,regDate    date default sysdate not null -- ´ëÈ­³¯Â¥
,status     number default 1 not null -- ´ëÈ­»óÅÂ
,fk_roomNumber      number -- ¸Ş½ÅÀú ±×·ì¹øÈ£
,fk_employee_seq    number  -- ¹ß½ÅÀÚ
>>>>>>> 7370937c5bc06870e685bf15f97b25f11e19cb9f
,constraint pk_messenger_table primary key(message_seq)
,constraint fk_messenger_roomNumber foreign key(fk_roomNumber, fk_employee_seq) references messengerRoom_table(roomNumber, fk_employee_seq)
on delete set null
);
create SEQUENCE messenger_table_seq
<<<<<<< HEAD
start with 1    -- ì‹œì‘ê°’
increment by 1  -- ì¦ê°€ê°’
nomaxvalue      -- ìµœëŒ€ê°’ ì„¤ì •
nominvalue      -- ìµœì†Œê°’ ì„¤ì •
nocycle         -- ë°˜ë³µ ì„¤ì •
=======
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
>>>>>>> 7370937c5bc06870e685bf15f97b25f11e19cb9f
nocache;

-- ´ëÈ­·Î±× Å×ÀÌºí(messengerLog_table) --
create table messengerLog_table
(fk_message_seq     number not null -- ´ëÈ­¹øÈ£ (foreign key)
,msg_receiver       number not null -- ÀĞÀ» »ç¶÷ »ç¿ø¹øÈ£
,constraint fk_messengerLog_table foreign key(fk_message_seq) references messenger_table(message_seq)
);

-- ¸ŞÀÏ Å×ÀÌºí(mail_table) --
create table mail_table
(mail_seq           number not null -- ¸ŞÀÏ ¹øÈ£(P.K)
,mail_groupno       number -- ¼Û½Å/¼ö½Å ±×·ì¹øÈ£ (null=ÀÓ½ÃÀúÀå?)
,fk_employee_seq    number not null -- »ç¿ø ¹øÈ£(F.K) = º¸³»´Â »ç¶÷
,subject            varchar2(1000) not null -- Á¦¸ñ
,content            varchar2(4000) not null -- ³»¿ë
,fileName1          varchar2(500) -- ÆÄÀÏÃ·ºÎÀÌ¸§1
,orgFileName1       varchar2(500) -- ÆÄÀÏÃ·ºÎ ¿ø·¡ ÀÌ¸§1
,fileSize1          varchar2(10) -- ÆÄÀÏ»çÀÌÁî1
,fileName2          varchar2(500) -- ÆÄÀÏÃ·ºÎÀÌ¸§2
,orgFileName2       varchar2(500) -- ÆÄÀÏÃ·ºÎ ¿ø·¡ ÀÌ¸§2
,fileSize2          varchar2(10) -- ÆÄÀÏ»çÀÌÁî2
,fileName3          varchar2(500) -- ÆÄÀÏÃ·ºÎÀÌ¸§3
,orgFileName3       varchar2(500) -- ÆÄÀÏÃ·ºÎ ¿ø·¡ ÀÌ¸§3
,fileSize3          varchar2(10) -- ÆÄÀÏ»çÀÌÁî3
,status         number default 0 not null-- ¹ß¼Û/¼ö½Å »óÅÂ
,readStatus     number default 0 not null -- ±âµ¶ À¯¹«
,mailStatus     number default 1 not null-- »èÁ¦À¯¹« »óÅÂ
,constraint FK_mail_table foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
,constraint CK_mail_table CHECK(status in(0, 1)and mailStatus in(0,1) and readStatus in(0,1))
);
create SEQUENCE mail_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;


-- È¸ÀÇ½Ç Å×ÀÌºí(reservationRoom_table) --
create table reservationRoom_table
(roomNumber     number not null -- È¸ÀÇ½Ç ¹øÈ£
,roomName       varchar2(300) not null -- È¸ÀÇ½ÇÀÌ¸§
,constraint pk_reservationRoom primary key(roomNumber)
);

-- ¿¹¾à°ü¸® Å×ÀÌºí(reservation_table) --
create table reservation_table
(reservation_seq    number not null -- ¿¹¾à¹øÈ£
,fk_employee_seq    number not null -- ¿¹¾à ½ÅÃ»ÀÚ
,fk_roomNumber      number not null -- ¿¹¾à Àå¼Ò(È¸ÀÇ½Ç ¹øÈ£)
,startDate  date not null -- »ç¿ë½ÃÀÛ ½Ã°£(³¯Â¥ Æ÷ÇÔ)
,endDate    date not null -- »ç¿ëÁ¾·á ½Ã°£(³¯Â¥ Æ÷ÇÔ)
,head_seq   number not null -- ¿¹¾à Ã¥ÀÓÀÚ »ç¿ø¹øÈ£
,memberCount    number default 1 not null -- »ç¿ë ÀÎ¿ø
,reason varchar2(2000) not null -- »çÀ¯
,status number default 0 not null -- ½ÂÀÎ »óÅÂ(0: ½ÂÀÎ´ë±âÁß, 1: ½ÂÀÎ¿Ï·á)
,constraint pk_reservation_table primary key(reservation_seq)
,constraint fk_reservation_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
,constraint fk_reservation_roomNumber foreign key(fk_roomNumber) references reservationRoom_table(roomNumber)
);
create SEQUENCE reservation_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- ÃâÅğ±Ù Å×ÀÌºí(attendance_table) --
create table attendance_table
(fk_employee_seq    number not null -- »ç¿ø¹øÈ£
,onTime     date default sysdate not null -- Ãâ±Ù½Ã°£(³â-¿ù-ÀÏ ½Ã-ºĞ-ÃÊ)
,offTime    date -- Åğ±Ù½Ã°£(³â-¿ù-ÀÏ ½Ã-ºĞ-ÃÊ)
,constraint fk_attendance_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete cascade
);

-- °Ô½ÃÆÇ Ç×¸ñ Å×ÀÌºí(board_category) --
create table board_category
(category_seq   number not null -- °Ô½Ã±Û Ç×¸ñ¹øÈ£
,category_name  varchar2(100) not null -- °Ô½Ã±Û Ç×¸ñ¸í
,constraint pk_board_category primary key(category_seq)
);

-- °Ô½ÃÆÇ Å×ÀÌºí(board_table) --
create table board_table
(board_seq  number not null -- ±Û¹øÈ£
,fk_category_num    number not null -- Ç×¸ñ¹øÈ£
,subject    varchar2(50) not null -- Á¦¸ñ
,content    varchar2(4000) not null
,readCnt    number default 0 -- Á¶È¸¼ö
,regDate    date default sysdate not null -- µî·Ï³¯Â¥
,fk_employee_seq    number -- ÀÛ¼ºÀÚ ¹øÈ£
,status     number default 1 not null -- ±Û »óÅÂ
,commentCnt number default 0 not null -- ´ñ±Û ¼ö
,constraint pk_board_table primary key(board_seq)
,constraint fk_board_category foreign key(fk_category_num) references board_category(category_seq)
,constraint fk_board_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);
create SEQUENCE board_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- °Ô½ÃÆÇ Ã·ºÎÆÄÀÏ Å×ÀÌºí(attachFile_table) --
create table attachFile_table
(file_seq   number not null -- ÆÄÀÏ¹øÈ£
,fk_board_seq   number not null -- °Ô½Ã±Û ¹øÈ£
,fileName   varchar2(500) -- ¾÷·Îµå ÆÄÀÏ¸í
,orgFileName    varchar2(500) -- ¿ø·¡ ÆÄÀÏ¸í
,fileSize   varchar2(10) -- ÆÄÀÏÅ©±â
,constraint pk_attachFile_table primary key(file_seq)
,constraint fk_attachFile_board foreign key(fk_board_seq) references board_table(board_seq) on delete cascade
);
create SEQUENCE attachFile_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- ´ñ±Û Å×ÀÌºí(comment_table) --
create table comment_table
(commnet_seq    number not null -- ´ñ±Û¹øÈ£
,fk_board_seq   number not null -- °Ô½Ã±Û ¹øÈ£(±×·ì¹øÈ£)
,fk_employee_seq    number -- ÀÛ¼ºÀÚ »ç¿ø¹øÈ£
,readCnt    number default 0 not null -- Á¶È¸¼ö
,content    varchar2(2000) not null -- ³»¿ë
,status     number default 1 not null -- ±Û»óÅÂ(1:º¸Á¸, 0:»èÁ¦)
,regDate    date default sysdate not null -- ÀÛ¼º³¯Â¥
,parent_seq number -- »óÀ§ ´ñ±Û(°èÃşÇü)
,depthno    number default 0 not null
,constraint pk_comment_seq primary key(commnet_seq)
,constraint fk_commnet_board foreign key(fk_board_seq) references board_table(board_seq) on delete cascade
,constraint fk_comment_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);
create sequence comment_table_seq
start with 1 -- ½ÃÀÛ°ª
increment by 1 -- Áõ°¡°ª
nomaxvalue -- ÃÖ´ë°ª ¼³Á¤
nominvalue -- ÃÖ¼Ò°ª ¼³Á¤
nocycle -- ¹İº¹ ¼³Á¤
nocache;

-- ºñÇ°°ü·Ã Å×ÀÌºí(equipment_table) --
create table equipment_table
(equipment_seq  number not null -- ºñÇ° ±¸ÀÔ¹øÈ£
,fk_department_seq  number -- ºñÇ° ±¸¸ÅÇÑ ºÎ¼­
,equipment_name     varchar2(500) not null -- ºñÇ°¸ñ·Ï ÀÌ¸§
,unit      number not null -- ºñÇ° ´ÜÀ§
,equipment_price    number not null -- ºñÇ° °¡°İ(´ÜÀ§)
,equipment_count    number not null -- ºñÇ° ±¸¸Å ¼ö
,reason     varchar2(4000) -- ±¸¸Å »çÀ¯
,purchaseDate   date not null-- ±¸ÀÔ³¯Â¥
,groupno    varchar2(50) not null
,documentStatus number default 0 not null
,constraint pk_equipment_table primary key(equipment_seq)
,constraint fk_equipment_department foreign key(fk_department_seq) references department_table(department_seq) on delete set null
);


-- Ç×¸ñ(Ä«Å×°í¸®) µ¥ÀÌÅÍ ÀÔ·Â --
insert into position_table(position_seq, position_name, position_salary) values(1,'»ç¿ø',2500);
insert into position_table(position_seq, position_name, position_salary) values(2,'´ë¸®',3400);
insert into position_table(position_seq, position_name, position_salary) values(3,'°úÀå',4100);
insert into position_table(position_seq, position_name, position_salary) values(4,'ºÎÀå',5090);
insert into position_table(position_seq, position_name, position_salary) values(5,'ÀÌ»ç',6400);
insert into position_table(position_seq, position_name, position_salary) values(6,'»çÀå',10000);
commit;

insert into employeeStatus_table(status_seq, status_name) values (1,'ÀÏ¹İ');
insert into employeeStatus_table(status_seq, status_name) values (2,'Åğ»ç');
insert into employeeStatus_table(status_seq, status_name) values (3,'ÈŞ°¡');
insert into employeeStatus_table(status_seq, status_name) values (4,'ÃâÀå');
commit;

insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'µğÀÚÀÎÆÀ');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'°³¹ßÆÀ');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'¿µ¾÷ÆÀ');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'ÀÎ»çÆÀ');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'°æ¿µÁö¿øÆÀ');
commit;

insert into album_category(category_num, category_name) values(1,'»ç³»È°µ¿');
insert into album_category(category_num, category_name) values(2,'µ¿È£È¸');
insert into album_category(category_num, category_name) values(3,'ºÀ»ç');
commit;

insert into grade_table(grade_level, grade_name) values(1,'ÀÏ¹İ');
insert into grade_table(grade_level, grade_name) values(2,'ÀÎ»ç°ü¸®');
insert into grade_table(grade_level, grade_name) values(3,'¿¹¾à°ü¸®');
insert into grade_table(grade_level, grade_name) values(4,'¸ÅÃâ°ü¸®');
insert into grade_table(grade_level, grade_name) values(5,'ÀüÃ¼');
commit;

insert into trip_category(category_num, category_name) values(1,'¿¬Â÷');
insert into trip_category(category_num, category_name) values(2,'¿ùÂ÷');
insert into trip_category(category_num, category_name) values(3,'¹İÂ÷');
insert into trip_category(category_num, category_name) values(4,'¿©¸§ÈŞ°¡');
insert into trip_category(category_num, category_name) values(5,'Ãâ»êÈŞ°¡');
insert into trip_category(category_num, category_name) values(6,'´Ü±âÃâÀå');
insert into trip_category(category_num, category_name) values(7,'Àå±âÃâÀå');
insert into trip_category(category_num, category_name) values(8,'ÇØ¿ÜÃâÀå');
commit;

insert into document_category(document_category_seq, category_name)values(1,'ÈŞ°¡/ÃâÀå');
insert into document_category(document_category_seq, category_name)values(2,'¸ÅÃâ');
insert into document_category(document_category_seq, category_name)values(3,'ÇÁ·ÎÁ§Æ®');
insert into document_category(document_category_seq, category_name)values(4,'Åğ»ç');
insert into document_category(document_category_seq, category_name)values(5,'ÀÎ»ç°í°ú');
insert into document_category(document_category_seq, category_name)values(6,'µ¿È£È¸ °¡ÀÔ');
commit;


insert into board_category(category_seq, category_name) values(1,'°øÁö»çÇ×');
insert into board_category(category_seq, category_name) values(2,'FAQ');
insert into board_category(category_seq, category_name) values(3,'ÀÚÀ¯');
commit;

insert into reservationRoom_table(roomNumber, roomName) values(1,'´ëÈ¸ÀÇ½Ç');
insert into reservationRoom_table(roomNumber, roomName) values(2,'ÁßÈ¸ÀÇ½ÇA');
insert into reservationRoom_table(roomNumber, roomName) values(3,'ÁßÈ¸ÀÇ½ÇB');
insert into reservationRoom_table(roomNumber, roomName) values(4,'ÁßÈ¸ÀÇ½ÇC');
insert into reservationRoom_table(roomNumber, roomName) values(5,'¼ÒÈ¸ÀÇ½Ç1');
insert into reservationRoom_table(roomNumber, roomName) values(6,'¼ÒÈ¸ÀÇ½Ç2');
insert into reservationRoom_table(roomNumber, roomName) values(7,'¼ÒÈ¸ÀÇ½Ç3');
commit;