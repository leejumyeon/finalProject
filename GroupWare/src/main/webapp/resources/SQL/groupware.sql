-- sys���� ���� --
show user; -- USER��(��) "SYS"�Դϴ�.
create user finalorauser3 identified by eclass
default tablespace users;
 
grant connect, resource, unlimited tablespace to finalorauser3;
grant create view to finalorauser3;
--------------------------------------------------------------------
-- finalorauser3���� ���� --
show user; -- USER��(��) "FINALORAUSER3"�Դϴ�.


-- ���̺� ���� -- 
drop table comment_table;
drop sequence comment_table_seq;
drop table attachFile_table;
drop SEQUENCE attachFile_table_seq;
drop table board_table;
drop sequence board_table_seq;
drop table board_category;
drop table attendance_table;
drop table reservation_table;
drop sequence reservation_table_seq;
drop table reservationRoom_table;
drop table mailReceive_table;
drop table mail_table;
drop sequence mail_table_seq;
drop table messengerLog_table;
drop table messenger_table;
drop sequence messenger_table_seq;
drop table messengerRoom_table;
drop sequence messengerRoom_table_seq;
drop table companyCalendar_table;
drop sequence companyCalendar_table_seq;
drop table personalCalendar_table;
drop sequence personalCalendar_table_seq;
drop table projectMember_table;
drop sequence projectMember_table_seq;
drop table project_table;
drop sequence project_table_seq;
drop table document_table;
drop sequence document_table_seq;
drop table trip_table;
drop sequence trip_table_seq;
drop table trip_category;
drop table grade_table;
drop table TA_table;
drop sequence ta_table_seq;
drop table clubMember_table;
drop sequence clubMember_table_seq;
drop table club_table;
drop sequence club_table_seq;
drop table sales_table;
drop sequence sales_table_seq;
drop table fire_table;
drop table album_table;
drop sequence album_table_seq;
drop table album_category;
drop table employees_table;
drop sequence employees_table_seq;
drop table department_table;
drop sequence department_table_seq;
drop table employeeStatus_table;
drop table position_table;



 -- ���� ���̺�(position_table) --
create table position_table
(position_seq   number not null -- ��å��ȣ
,position_name  varchar2(50) not null -- ��å��
,position_salary    number not null -- ��å �޿�
,constraint pk_position_seq primary key(position_seq)
); 


 -- ������� ���̺�(employeeStatus_table) --
create table employeeStatus_table
(status_seq     number not null -- ��� ���¹�ȣ
,status_name    varchar2(50) not null -- ��� ���¸�
,constraint pk_employeeStatus primary key(status_seq)
);


 -- �μ����̺�(department_table) --
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

 
 -- ������̺�(employees_table)--
 create table employees_table
(employee_seq   number -- �����ȣ
,employee_name  varchar2(10) not null -- �����
,employee_id    varchar2(100) not null -- ���ID
,employee_pw    varchar2(500) not null -- ���PW
,email          varchar2(500) not null -- �系 �̸���
,phone          varchar2(100) not null -- �ڵ�����ȣ
,fk_status      number not null -- �������
,hire_date      date default sysdate not null -- �Ի糯¥
,fire_date      date -- ��糯¥
,fk_position    number default 1 -- �����å
,fk_department  number -- �μ�
,grade          number default 1 not null -- ����
,gender         number(1) not null -- ����(1:�� , 2:��)
,birthday       varchar2(8) not null -- �������
,address        varchar2(300) not null -- �ּ�
,postcode       varchar2(300) not null -- �����ȣ
,detailaddress  varchar2(500)-- ���ּ�
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

 -- album ī�װ� ���̺�(album_category) --
 create table album_category
(category_num   number not null -- ���� �Խñ��� �׸��ȣ(ȸ�����, ��ȣȸ, ����)
,category_name  varchar2(50) not null -- �׸��̸�
,constraint pk_album_category primary key (category_num)
);



 -- album ���̺�(album_table) --
create table album_table
(album_seq  number not null -- album�Խñ� ��ȣ
,album_category number -- album�Խñ� �׸�
,fk_employee_seq    number  -- �Խñ� �ۼ��� ��ȣ
,subject    varchar2(500) not null -- �Խñ� ����
,content    varchar2(4000) not null -- �Խñ� ����
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


-- ������ ���̺�(fire_date) --
create table fire_table
(fk_employee_seq    number
,groupno    varchar2(50) not null -- �������� ���̺�� �����ϵ��� �ϴ� �÷�
,reason varchar2(4000) -- ��� ����
,interviewer_seq    number not null -- ����� �����ȣ
,interview_content  varchar2(4000) not null -- ��㳻��
,documentStatus     number default 0 not null -- ����Ǿ��ִ� ���繮���� ���λ��� ���� ����??
,constraint fk_fire_employees foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);

-- ���� ���̺�(sales_table) --
create table sales_table
(sales_seq  number not null -- �����ȣ
,groupno    varchar2(50) not null -- �������� ���̺�� �����ϵ��� �ϴ� �÷�
,sales_title    varchar2(500) not null -- ��������
,sales_price    number  not null -- ���� ����
,sales_count    number not null -- ���� ����
,reason     varchar2(4000) not null -- ���� ����
,fk_department_seq  number -- ���� �μ�
,regDate    date default sysdate not null -- ���� ��� ��¥
,documentStatus     number default 1 not null -- ����Ǿ��ִ� ���繮���� ���λ��� ���� ����??
,constraint pk_sales_approval primary key(sales_seq)
,constraint fk_sales_department foreign key(fk_department_seq) REFERENCES department_table(department_seq) on delete set null
);

create SEQUENCE sales_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

 -- ��ȣȸ ���̺�(club_table) --
create table club_table
(club_seq   number not null -- ��ȣȸ ��ȣ
,groupno    varchar2(50) not null -- �������� ���̺�� �����ϵ��� �ϴ� �÷�
,club_name  varchar2(100) not null -- ��ȣȸ �̸�
,club_info  varchar2(2000) -- ��ȣȸ �Ұ�
,regDate    date default sysdate not null -- ��ȣȸ ������¥
,documentStatus     number default 1 not null -- ����Ǿ��ִ� ���繮���� ���λ��� ���� ����??
,representative_img  varchar2(500) not null -- ��ȣȸ ��ǥ �̹���
,constraint pk_club_table primary key(club_seq)
);

create SEQUENCE club_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;
 
 
-- ��ȣȸ��� ���̺�(clubMember_table)
create table clubMember_table
(member_seq number not null -- ��ܹ�ȣ
,groupno    varchar2(50) not null -- �������� ���̺�� �����ϵ��� �ϴ� �÷�
,fk_club    number not null -- ������ ��ȣȸ
,status     number  default 0 not null -- ����(0:�Ϲ�, 1:ȸ��)
,regDate    date default sysdate not null -- ���Գ�¥
,fk_employee_seq    number  -- ������ �����ȣ
,documentStatus     number default 1 -- ����Ǿ��ִ� ���繮���� ���λ��� ���� ����??
,constraint pk_clubMember_table primary key(member_seq)
,constraint fk_clubMember_club foreign key (fk_club) references club_table(club_seq) on delete cascade
,constraint fk_clubMember_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
);

create SEQUENCE clubMember_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- ���°��� ���̺�(TA_table) --
create table TA_table
(ta_seq     number not null -- ���°��� �� ��ȣ
,groupno    varchar2(50) not null -- �������� ���̺�� �����ϵ��� �ϴ� �÷�
,fk_employee_seq    number -- ��� ��� ��ȣ
,attendance     varchar2(50) not null -- �������
,attitude       varchar2(50) not null -- �µ�����
,performance    varchar2(50) not null -- �������� ����
,manager    varchar2(100) not null -- �����(�̸�)
,reason     varchar2(4000) not null -- ������ �� ����(��ü)
,regDate    date default sysdate not null -- ���°��� ��� ��¥
,documentStatus     number default 1 -- ����Ǿ��ִ� ���繮���� ���λ��� ���� ����??
,constraint pk_ta_table primary key(ta_seq)
,constraint fk_ta_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
);

create SEQUENCE ta_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- ���� �׸� ���̺�(grade_table) --
create table grade_table
(grade_level    number not null
,grade_name     varchar2(50)
,constraint pk_grade_table primary key(grade_level)
);

-- �ް�/���� �׸� ���̺�(trip_category)--
create table trip_category
(category_num   number not null -- �ް�/���� �׸� ��ȣ
,category_name  varchar2(50) not null -- �׸� �̸�
,constraint pk_trip_category primary key(category_num)
);

-- �ް�/���� ���̺�(trip_table) --
create table trip_table
(trip_seq   number not null -- ��ȣ
,groupno    varchar2(50) not null -- �������� ���̺�� �����ϵ��� �ϴ� �÷�
,trip_category  number -- �ް�/���� �׸��ȣ
,reason     varchar2(4000) not null -- ����
,trip_start date not null -- �ް�/���� ���� ��¥
,trip_end   date not null -- �ް�/���� ���� ��¥
,triplocatioin      varchar2(1000) -- ������
,fk_employee_seq    number  -- ��û��
,documentStatus     number default 1 not null -- ����Ǿ��ִ� ���繮���� ���λ��� ���� ����??
,constraint pk_trip_table primary key (trip_seq)
,constraint fk_trip_employee foreign key (fk_employee_seq) REFERENCES employees_table(employee_seq)on delete set null
,constraint fk_trip_category foreign key (trip_category) references trip_category(category_num) on delete set null
);

create SEQUENCE trip_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- �������� �׸����̺�(document_category) --
create table document_category
(document_category_seq  number not null -- �������� �׸��ȣ
,category_name  varchar2(100) not null -- �׸��̸�
,constraint pk_document_category primary key(document_category_seq)
);

-- �������� ���̺�(document_table) --
create table document_table
(document_seq   number not null -- �������� ���� ��ȣ
,groupno        varchar2(50) not null -- ���� �Ϸù�ȣ(������ ��� ���̺� ����� ��ȣ)
,fk_employee_seq    number not null -- ���� ��û��
,subject    varchar2(1000) not null -- ���繮�� ����
,content    varchar2(4000) not null -- ���繮�� ����
,regDate    date default sysdate not null -- ���� ��û��¥
,approver_seq   number not null -- ������ �����ȣ
,approveDate    date -- ���糯¥
,fileName   varchar2(500) -- ����÷��(���ε� ���ϸ�)
,orgFileName    varchar2(500) -- ����÷��(���� ���ϸ�)
,fileSize   number -- ����ũ��
,parent_approver    varchar2(100) -- ���� ������
,status     number not null -- ���� ����(����, �̽���, �ݷ�)
,reason     varchar2(4000) -- ���� ����( �ݷ� ���� )
,document_category  number not null -- ���� �׸�
,constraint fk_document_employee foreign key (fk_employee_seq) references employees_table(employee_seq) on delete set null
,constraint fk_document_category foreign key (document_category) references document_category(document_category_seq)
);

create SEQUENCE document_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- ������Ʈ ���̺�(project_table) --
create table project_table
(project_seq    number not null -- ������Ʈ ��ȣ
,groupno        varchar2(50) not null -- �������� ���̺�� �����ϵ��� �ϴ� �÷�
,project_name   varchar2(500) not null -- ������Ʈ �̸�
,content    varchar2(4000) not null -- ������Ʈ ����
,term   number not null -- ������Ʈ �Ⱓ
,startDate  date not null -- ������Ʈ ���۳�¥
,manager    varchar2(50) not null -- ������Ʈ å����
,memberCount    number not null -- ������Ʈ ���� �ο���
,dwonPayment    number -- ����
,middlePayment  number -- �ߵ���
,completionPayment number -- �Ϸ��
,documentStatus     number default 0 -- ����Ǿ��ִ� ���繮���� ���λ��� ���� ����??(0:���� ������, 1:����Ϸ�, ����:����ݷ�)
,constraint pk_project_table primary key(project_seq)
);
create SEQUENCE project_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- ������Ʈ ��� ���̺�(projectMember_table) --
create table projectMember_table
(projectMember_seq  number not null -- ������Ʈ ��� ��ȣ
,fk_project_seq     number not null -- ������Ʈ ��ȣ(������Ʈ ��, ������� join���)
,fk_employee_seq    number -- �����ȣ(�����, ��å, �μ� join���)
,constraint pk_projectMember_table primary key(projectMember_seq)
,constraint fk_projectMember_project foreign key(fk_project_seq) references project_table(project_seq) on delete cascade
,constraint fk_projectMember_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);
create SEQUENCE projectMember_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;


-- �������� ���̺�(personalCalendar_table) --
create table personalCalendar_table
(calendar_seq   number not null -- ������ȣ
,fk_employee_seq    number not null -- �����ȣ
,title      varchar2(500) not null -- ���� Ÿ��Ʋ
,content    varchar2(2000) not null -- ��������
,startDate  date not null -- �������� ��¥
,endDate    date not null -- �������� ��¥
,color      varchar2(100) -- ����     
,constraint pk_personalCalendar primary key(calendar_seq)
,constraint fk_personalcalendar_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
);
create SEQUENCE personalCalendar_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

create table companyCalendar_category
(category_num   number not null -- �׸��ȣ
,category_name  varchar2(50) not null -- �׸��
,constraint pk_companyCalendar_category primary key(category_num)
);

-- ȸ������ ���̺�(companyCalendar_table) --
create table companyCalendar_table
(calendar_seq   number not null -- ������ȣ
,title      varchar2(500) not null -- ���� Ÿ��Ʋ
,content    varchar2(2000) not null -- ��������
,startDate  date not null -- �������� ��¥
,endDate    date not null -- �������� ��¥
,color      varchar2(100) -- ����
,fk_department_seq number -- �μ������� ��� ����ϴ� �÷�
,calendar_category  number not null -- ���� ī�װ�(������, ��������, �ܵ�����...��)
,constraint pk_companyCalendar primary key(calendar_seq)
,constraint fk_companyCal_department foreign key(fk_department_seq) references department_table(department_seq)on delete cascade
,constraint fk_companyCal_category foreign key(calendar_category) references companyCalendar_category(category_num)
);
create SEQUENCE companyCalendar_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;



-- �޽��� �׷� ���̺�(messengerRoom_table) --
create table messengerRoom_table
(roomNumber     number not null -- �׷� ��ȣ
,fk_employee_seq   number not null -- ������ ��ȣ
,regDate    date default sysdate not null -- ������¥
,constraint pk_messengerRoom primary key(roomNumber, fk_employee_seq)
,constraint fk_messengerRoom_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
);

create SEQUENCE messengerRoom_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- �޽��� ��ȭ ���̺�(messenger_table) --
create table messenger_table
(message_seq    number not null -- ��ȭ ��ȣ
,content    varchar2(4000) not null -- ��ȭ����
,regDate    date default sysdate not null -- ��ȭ��¥
,status     number default 1 not null -- ��ȭ����
,fk_roomNumber      number -- �޽��� �׷��ȣ
,fk_employee_seq    number  -- �߽���
,constraint pk_messenger_table primary key(message_seq)
,constraint fk_messenger_roomNumber foreign key(fk_roomNumber, fk_employee_seq) references messengerRoom_table(roomNumber, fk_employee_seq)
on delete set null
);
create SEQUENCE messenger_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- ��ȭ�α� ���̺�(messengerLog_table) --
create table messengerLog_table
(fk_message_seq     number not null -- ��ȭ��ȣ (foreign key)
,msg_receiver       number not null -- ���� ��� �����ȣ
,constraint fk_messengerLog_table foreign key(fk_message_seq) references messenger_table(message_seq)
);

-- ���� ���̺�(mail_table) --
create table mail_table
(mail_seq           number not null -- ���� ��ȣ(P.K)
,mail_groupno       number -- �۽�/���� �׷��ȣ (null=�ӽ�����?)
,fk_employee_seq    number not null -- ��� ��ȣ(F.K) = ������ ���
,subject            varchar2(1000) not null -- ����
,content            varchar2(4000) not null -- ����
,fileName1          varchar2(500) -- ����÷���̸�1
,orgFileName1       varchar2(500) -- ����÷�� ���� �̸�1
,fileSize1          varchar2(10) -- ���ϻ�����1
,fileName2          varchar2(500) -- ����÷���̸�2
,orgFileName2       varchar2(500) -- ����÷�� ���� �̸�2
,fileSize2          varchar2(10) -- ���ϻ�����2
,fileName3          varchar2(500) -- ����÷���̸�3
,orgFileName3       varchar2(500) -- ����÷�� ���� �̸�3
,fileSize3          varchar2(10) -- ���ϻ�����3
,status         number default 0 not null-- �߼�/���� ����
,readStatus     number default 0 not null -- �⵶ ����
,mailStatus     number default 1 not null-- �������� ����
,constraint FK_mail_table foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
,constraint CK_mail_table CHECK(status in(0, 1)and mailStatus in(0,1) and readStatus in(0,1))
);
create SEQUENCE mail_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;


-- ȸ�ǽ� ���̺�(reservationRoom_table) --
create table reservationRoom_table
(roomNumber     number not null -- ȸ�ǽ� ��ȣ
,roomName       varchar2(300) not null -- ȸ�ǽ��̸�
,constraint pk_reservationRoom primary key(roomNumber)
);

-- ������� ���̺�(reservation_table) --
create table reservation_table
(reservation_seq    number not null -- �����ȣ
,fk_employee_seq    number not null -- ���� ��û��
,fk_roomNumber      number not null -- ���� ���(ȸ�ǽ� ��ȣ)
,startDate  date not null -- ������ �ð�(��¥ ����)
,endDate    date not null -- ������� �ð�(��¥ ����)
,head_seq   number not null -- ���� å���� �����ȣ
,memberCount    number default 1 not null -- ��� �ο�
,reason varchar2(2000) not null -- ����
,status number default 0 not null -- ���� ����(0: ���δ����, 1: ���οϷ�)
,constraint pk_reservation_table primary key(reservation_seq)
,constraint fk_reservation_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
,constraint fk_reservation_roomNumber foreign key(fk_roomNumber) references reservationRoom_table(roomNumber)
);
create SEQUENCE reservation_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- ����� ���̺�(attendance_table) --
create table attendance_table
(fk_employee_seq    number not null -- �����ȣ
,onTime     date default sysdate not null -- ��ٽð�(��-��-�� ��-��-��)
,offTime    date -- ��ٽð�(��-��-�� ��-��-��)
,constraint fk_attendance_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete cascade
);

-- �Խ��� �׸� ���̺�(board_category) --
create table board_category
(category_seq   number not null -- �Խñ� �׸��ȣ
,category_name  varchar2(100) not null -- �Խñ� �׸��
,constraint pk_board_category primary key(category_seq)
);

-- �Խ��� ���̺�(board_table) --
create table board_table
(board_seq  number not null -- �۹�ȣ
,fk_category_num    number not null -- �׸��ȣ
,subject    varchar2(50) not null -- ����
,content    varchar2(4000) not null
,readCnt    number default 0 -- ��ȸ��
,regDate    date default sysdate not null -- ��ϳ�¥
,fk_employee_seq    number -- �ۼ��� ��ȣ
,status     number default 1 not null -- �� ����
,commentCnt number default 0 not null -- ��� ��
,constraint pk_board_table primary key(board_seq)
,constraint fk_board_category foreign key(fk_category_num) references board_category(category_seq)
,constraint fk_board_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);
create SEQUENCE board_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- �Խ��� ÷������ ���̺�(attachFile_table) --
create table attachFile_table
(file_seq   number not null -- ���Ϲ�ȣ
,fk_board_seq   number not null -- �Խñ� ��ȣ
,fileName   varchar2(500) -- ���ε� ���ϸ�
,orgFileName    varchar2(500) -- ���� ���ϸ�
,fileSize   varchar2(10) -- ����ũ��
,constraint pk_attachFile_table primary key(file_seq)
,constraint fk_attachFile_board foreign key(fk_board_seq) references board_table(board_seq) on delete cascade
);
create SEQUENCE attachFile_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- ��� ���̺�(comment_table) --
create table comment_table
(commnet_seq    number not null -- ��۹�ȣ
,fk_board_seq   number not null -- �Խñ� ��ȣ(�׷��ȣ)
,fk_employee_seq    number -- �ۼ��� �����ȣ
,readCnt    number default 0 not null -- ��ȸ��
,content    varchar2(2000) not null -- ����
,status     number default 1 not null -- �ۻ���(1:����, 0:����)
,regDate    date default sysdate not null -- �ۼ���¥
,parent_seq number -- ���� ���(������)
,depthno    number default 0 not null
,constraint pk_comment_seq primary key(commnet_seq)
,constraint fk_commnet_board foreign key(fk_board_seq) references board_table(board_seq) on delete cascade
,constraint fk_comment_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);
create sequence comment_table_seq
start with 1 -- ���۰�
increment by 1 -- ������
nomaxvalue -- �ִ밪 ����
nominvalue -- �ּҰ� ����
nocycle -- �ݺ� ����
nocache;

-- ��ǰ���� ���̺�(equipment_table) --
create table equipment_table
(equipment_seq  number not null -- ��ǰ ���Թ�ȣ
,fk_department_seq  number -- ��ǰ ������ �μ�
,equipment_name     varchar2(500) not null -- ��ǰ��� �̸�
,unit      number not null -- ��ǰ ����
,equipment_price    number not null -- ��ǰ ����(����)
,equipment_count    number not null -- ��ǰ ���� ��
,reason     varchar2(4000) -- ���� ����
,purchaseDate   date not null-- ���Գ�¥
,groupno    varchar2(50) not null
,documentStatus number default 0 not null
,constraint pk_equipment_table primary key(equipment_seq)
,constraint fk_equipment_department foreign key(fk_department_seq) references department_table(department_seq) on delete set null
);


-- �׸�(ī�װ�) ������ �Է� --
insert into position_table(position_seq, position_name, position_salary) values(1,'���',2500);
insert into position_table(position_seq, position_name, position_salary) values(2,'�븮',3400);
insert into position_table(position_seq, position_name, position_salary) values(3,'����',4100);
insert into position_table(position_seq, position_name, position_salary) values(4,'����',5090);
insert into position_table(position_seq, position_name, position_salary) values(5,'�̻�',6400);
insert into position_table(position_seq, position_name, position_salary) values(6,'����',10000);
commit;

insert into employeeStatus_table(status_seq, status_name) values (1,'�Ϲ�');
insert into employeeStatus_table(status_seq, status_name) values (2,'���');
insert into employeeStatus_table(status_seq, status_name) values (3,'�ް�');
insert into employeeStatus_table(status_seq, status_name) values (4,'����');
commit;

insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'��������');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'������');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'������');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'�λ���');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'�濵������');
commit;

insert into album_category(category_num, category_name) values(1,'�系Ȱ��');
insert into album_category(category_num, category_name) values(2,'��ȣȸ');
insert into album_category(category_num, category_name) values(3,'����');
commit;

insert into grade_table(grade_level, grade_name) values(1,'�Ϲ�');
insert into grade_table(grade_level, grade_name) values(2,'�λ����');
insert into grade_table(grade_level, grade_name) values(3,'�������');
insert into grade_table(grade_level, grade_name) values(4,'�������');
insert into grade_table(grade_level, grade_name) values(5,'��ü');
commit;

insert into trip_category(category_num, category_name) values(1,'����');
insert into trip_category(category_num, category_name) values(2,'����');
insert into trip_category(category_num, category_name) values(3,'����');
insert into trip_category(category_num, category_name) values(4,'�����ް�');
insert into trip_category(category_num, category_name) values(5,'����ް�');
insert into trip_category(category_num, category_name) values(6,'�ܱ�����');
insert into trip_category(category_num, category_name) values(7,'�������');
insert into trip_category(category_num, category_name) values(8,'�ؿ�����');
commit;

insert into document_category(document_category_seq, category_name)values(1,'�ް�/����');
insert into document_category(document_category_seq, category_name)values(2,'����');
insert into document_category(document_category_seq, category_name)values(3,'������Ʈ');
insert into document_category(document_category_seq, category_name)values(4,'���');
insert into document_category(document_category_seq, category_name)values(5,'�λ���');
insert into document_category(document_category_seq, category_name)values(6,'��ȣȸ ����');
commit;


insert into board_category(category_seq, category_name) values(1,'��������');
insert into board_category(category_seq, category_name) values(2,'FAQ');
insert into board_category(category_seq, category_name) values(3,'����');
commit;

insert into reservationRoom_table(roomNumber, roomName) values(1,'��ȸ�ǽ�');
insert into reservationRoom_table(roomNumber, roomName) values(2,'��ȸ�ǽ�A');
insert into reservationRoom_table(roomNumber, roomName) values(3,'��ȸ�ǽ�B');
insert into reservationRoom_table(roomNumber, roomName) values(4,'��ȸ�ǽ�C');
insert into reservationRoom_table(roomNumber, roomName) values(5,'��ȸ�ǽ�1');
insert into reservationRoom_table(roomNumber, roomName) values(6,'��ȸ�ǽ�2');
insert into reservationRoom_table(roomNumber, roomName) values(7,'��ȸ�ǽ�3');
commit;