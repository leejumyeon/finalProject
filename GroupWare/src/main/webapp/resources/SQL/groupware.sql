-- sys계정 내용 --
show user; -- USER이(가) "SYS"입니다.
create user finalorauser3 identified by eclass
default tablespace users;
 
grant connect, resource, unlimited tablespace to finalorauser3;
grant create view to finalorauser3;
--------------------------------------------------------------------
-- finalorauser3계정 내용 --
show user; -- USER이(가) "FINALORAUSER3"입니다.


-- 테이블 삭제 -- 
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



 -- 직책 테이블(position_table) --
create table position_table
(position_seq   number not null -- 직책번호
,position_name  varchar2(50) not null -- 직책명
,position_salary    number not null -- 직책 급여
,constraint pk_position_seq primary key(position_seq)
); 
insert into position_table(position_seq, position_name, position_salary) values(1,'사원',2200);

 -- 사원상태 테이블(employeeStatus_table) --
create table employeeStatus_table
(status_seq     number not null -- 사원 상태번호
,status_name    varchar2(50) not null -- 사원 상태명
,constraint pk_employeeStatus primary key(status_seq)
);
insert into employeeStatus_table(status_seq, status_name) values (1,'일반');

 -- 부서테이블(department_table) --
create table department_table
(department_seq number not null
,department_name    varchar2(100)
,constraint pk_department_table primary key(department_seq)
);

create SEQUENCE department_table_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

 
 -- 사원테이블(employees_table)--
 create table employees_table
(employee_seq   number -- 사원번호
,employee_name  varchar2(10) not null -- 사원명
,employee_id    varchar2(100) not null -- 사원ID
,employee_pw    varchar2(500) not null -- 사원PW
,email          varchar2(500) not null -- 사내 이메일
,phone          varchar2(100) not null -- 핸드폰번호
,fk_status      number not null -- 사원상태
,hire_date      date default sysdate not null -- 입사날짜
,fire_date      date -- 퇴사날짜
,fk_position    number default 1 -- 사원직책
,fk_department  number -- 부서
,grade          number default 1 not null-- 권한
,gender         varchar2(1) -- 성별
,birthday       varchar2(8)-- 생년월일
,address        varchar2(300)-- 주소
,postcode       varchar2(300)-- 우편번호
,detailaddress  varchar2(500)-- 상세주소
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

 -- album 카테고리 테이블(album_category) --
 create table album_category
(category_num   number not null -- 엘범 게시글의 항목번호(회사행사, 동호회, 봉사)
,category_name  varchar2(50) -- 항목이름
,constraint pk_album_category primary key (category_num)
);
insert into album_category(category_num, category_name) values(1,'동호회album');



 -- album 테이블(album_table) --
create table album_table
(album_seq  number not null -- album게시글 번호
,album_category number -- album게시글 항목
,fk_employee_seq    number  -- 게시글 작성자 번호
,subject    varchar2(500) not null -- 게시글 제목
,content    varchar2(4000) not null -- 게시글 내용
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


-- 퇴사사유 테이블(fire_date) --
create table fire_table
(fk_employee_seq    number not null
,groupno    varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,reason varchar2(4000) -- 퇴사 사유
,documentStatus     number default 0 -- 연결되어있는 결재문서의 승인상태 값과 연동??
,constraint fk_fire_employees foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);

-- 매출 테이블(sales_table) --
create table sales_table
(sales_seq  number not null -- 매출번호
,groupno    varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,sales_title    varchar2(500) not null -- 매출제목
,sales_price    number  not null -- 매출 가격
,sales_count    number not null -- 매출 개수
,reason     varchar2(4000) -- 매출 사유
,fk_department_seq  number -- 매출 부서
,regDate    date default sysdate not null -- 매출 기록 날짜
,documentStatus     number default 1 -- 연결되어있는 결재문서의 승인상태 값과 연동??
,constraint pk_sales_approval primary key(sales_seq)
,constraint fk_sales_department foreign key(fk_department_seq) REFERENCES department_table(department_seq) on delete set null
);

create SEQUENCE sales_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

 -- 동호회 테이블(club_table) --
create table club_table
(club_seq   number not null -- 동호회 번호
,club_name  varchar2(100) not null -- 동호회 이름
,club_info  varchar2(2000) -- 동호회 설명
,regDate    date default sysdate not null -- 동호회 생성날짜
,representative_img  varchar2(500) -- 동호회 대표 이미지
,constraint pk_club_table primary key(club_seq)
);

create SEQUENCE club_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;
 
 
-- 동호회명단 테이블(clubMember_table)
create table clubMember_table
(member_seq number not null -- 명단번호
,groupno    varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,fk_club    number not null -- 가입한 동호회
,status     number  default 0 not null -- 상태(0:일반, 1:회장)
,regDate    date default sysdate not null -- 가입날짜
,fk_employee_seq    number not null -- 가입한 사원번호
,documentStatus     number default 1 -- 연결되어있는 결재문서의 승인상태 값과 연동??
,constraint pk_clubMember_table primary key(member_seq)
,constraint fk_clubMember_club foreign key (fk_club) references club_table(club_seq)
,constraint fk_clubMember_employee foreign key(fk_employee_seq) references employees_table(employee_seq)
);

create SEQUENCE clubMember_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 근태관리 테이블(TA_table) --
create table TA_table
(ta_seq     number not null -- 근태관리 행 번호
,groupno    varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,fk_employee_seq    number not null -- 대상 사원 번호
,attendance     varchar2(50) not null -- 출결점수
,attitude       varchar2(50) not null -- 태도점수
,performance    varchar2(50) not null -- 업무성과 점수
,manager    varchar2(100) not null -- 기안자(이름)
,reason     varchar2(4000) not null -- 점수를 준 사유(전체)
,regDate    date default sysdate not null -- 근태관리 등록 날짜
,documentStatus     number default 1 -- 연결되어있는 결재문서의 승인상태 값과 연동??
,constraint pk_ta_table primary key(ta_seq)
,constraint fk_ta_employee foreign key(fk_employee_seq) references employees_table(employee_seq)
);

create SEQUENCE ta_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 권한 항목 테이블(grade_table) --
create table grade_table
(grade_level    number not null
,grade_name     varchar2(50)
,constraint pk_grade_table primary key(grade_level)
);

-- 휴가/출장 항목 테이블(trip_category)--
create table trip_category
(category_num   number not null -- 휴가/출장 항목 번호
,category_name  varchar2(50) not null -- 항목 이름
,constraint pk_trip_category primary key(category_num)
);

-- 휴가/출장 테이블(trip_table) --
create table trip_table
(trip_seq   number not null -- 번호
,groupno    varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,trip_category  number not null -- 휴가/출장 항목번호
,reason     varchar2(4000) -- 사유
,trip_start date not null -- 휴가/출장 시작 날짜
,trip_end   date not null -- 휴가/출장 복귀 날짜
,fk_employee_seq    number not null -- 신청자
,documentStatus     number default 1 -- 연결되어있는 결재문서의 승인상태 값과 연동??
,constraint pk_trip_table primary key (trip_seq)
,constraint fk_trip_employee foreign key (fk_employee_seq) REFERENCES employees_table(employee_seq)
);

create SEQUENCE trip_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 문서결재 항목테이블(document_category) --
create table document_category
(document_category_seq  number not null -- 문서결재 항목번호
,category_name  varchar2(100) not null -- 항목이름
,constraint pk_document_category primary key(document_category_seq)
);
insert into document_category(document_category_seq, category_name)values(1,'');

-- 문서결재 테이블(document_table) --
create table document_table
(document_seq   number not null -- 문서결재 고유 번호
,groupno        varchar2(50) not null -- 문서 일련번호(각각의 결과 테이블에 사용할 번호)
,fk_employee_seq    number not null -- 결재 신청자
,subject    varchar2(1000) not null
,content    varchar2(4000) not null -- 결재문서 내용
,regDate    date default sysdate not null -- 결재 신청날짜
,approver_seq   number not null -- 결재자 사원번호
,approveDate    date -- 결재날짜
,parent_approver    varchar2(100) -- 상위 결재자
,status     number not null -- 결재 상태(승인, 미승인, 반려)
,reason     varchar2(4000) -- 결재 사유( 반려 사유 )
,document_category  number not null -- 문서 항목
,constraint fk_document_employee foreign key (fk_employee_seq) references employees_table(employee_seq)
,constraint fk_document_category foreign key (document_category) references document_category(document_category_seq)
);

create SEQUENCE document_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 프로젝트 테이블(project_table) --
create table project_table
(project_seq    number not null -- 프로젝트 번호
,groupno        varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,project_name   varchar2(500) not null -- 프로젝트 이름
,content    varchar2(4000) not null -- 프로젝트 내용
,term   number not null -- 프로젝트 기간
,startDate  date not null -- 프로젝트 시작날짜
,manager    varchar2(50) not null -- 프로젝트 책임자
,memberCount    number not null -- 프로젝트 참가 인원수
,dwonPayment    number -- 계약금
,middlePayment  number -- 중도금
,completionPayment number -- 완료금
,documentStatus     number default 0 -- 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)
,constraint pk_project_table primary key(project_seq)
);
create SEQUENCE project_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 프로젝트 명단 테이블(projectMember_table) --
create table projectMember_table
(projectMember_seq  number not null -- 프로젝트 명단 번호
,fk_project_seq     number not null -- 프로젝트 번호(프로젝트 명, 진행상태 join요소)
,fk_employee_seq    number not null -- 사원번호(사원명, 직책, 부서 join요소)
,constraint pk_projectMember_table primary key(projectMember_seq)
,constraint fk_projectMember_project foreign key(fk_project_seq) references project_table(project_seq)
,constraint fk_projectMember_employee foreign key(fk_employee_seq) references employees_table(employee_seq)
);
create SEQUENCE projectMember_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;


-- 개인일정 테이블(personalCalendar_table) --
create table personalCalendar_table
(calendar_seq   number not null -- 일정번호
,fk_employee_seq    number not null -- 사원번호
,title      varchar2(500) not null -- 일정 타이틀
,content    varchar2(2000) not null -- 일정내용
,startDate  date not null -- 일정시작 날짜
,endDate    date not null -- 일정종료 날짜
,color      varchar2(100) -- 배경색
,type       
,constraint pk_personalCalendar primary key(calendar_seq)
);
create SEQUENCE personalCalendar_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

create table companyCalendar_category
(category_num   number not null
,category_name  varchar2(50) not null
);

-- 회사일정 테이블(companyCalendar_table) --
create table companyCalendar_table
(calendar_seq   number not null -- 일정번호
,title      varchar2(500) not null -- 일정 타이틀
,content    varchar2(2000) not null -- 일정내용
,startDate  date not null -- 일정시작 날짜
,endDate    date not null -- 일정종료 날짜
,color      varchar2(100) -- 배경색
,fk_department_seq number -- 부서일정인 경우 사용하는 컬럼
,calendar_category  number not null -- 일정 카테고리(경조사, 협력일정, 단독일정...등)
,constraint pk_companyCalendar primary key(calendar_seq)
,constraint fk_companyCal_department foreign key(fk_department_seq) references department_table(department_seq)
,constraint fk_companyCal_category foreign key(calendar_category) references companyCalendar_category(category_num)
);
create SEQUENCE companyCalendar_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;



-- 메신저 그룹 테이블(messengerRoom_table) --
create table messengerRoom_table
(roomNumber     number not null -- 그룹 번호
,fk_employee_seq   number not null -- 참가자 번호
,regDate    date default sysdate not null -- 참가날짜
,constraint pk_messengerRoom primary key(roomNumber, fk_employee_seq)
);

create SEQUENCE messengerRoom_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 메신저 대화 테이블(messenger_table) --
create table messenger_table
(message_seq    number not null -- 대화 번호
,content    varchar2(4000) not null -- 대화내용
,regDate    date default sysdate not null -- 대화날짜
,status     number default 1 not null -- 대화상태
,fk_roomNumber      number not null -- 메신저 그룹번호
,fk_employee_seq    number not null -- 발신자
,constraint pk_messenger_table primary key(message_seq)
,constraint fk_messenger_roomNumber foreign key(fk_roomNumber, fk_employee_seq) references messengerRoom_table(roomNumber, fk_employee_seq)
);
create SEQUENCE messenger_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 대화로그 테이블(messengerLog_table) --
create table messengerLog_table
(fk_message_seq     number not null -- 대화번호 (foreign key)
,msg_receiver       number not null -- 읽을 사람 사원번호
,constraint fk_messengerLog_table foreign key(fk_message_seq) references messenger_table(message_seq)
);

-- 메일 테이블(mail_table) --
create table mail_table
(mail_seq           number not null -- 메일 번호(P.K)
,fk_employee_seq    number not null -- 사원 번호(F.K) = 보내는 사람
,subject            varchar2(1000) not null -- 제목
,content            varchar2(4000) not null -- 내용
,fileName1          varchar2(500) -- 파일첨부이름1
,orgFileName1       varchar2(500) -- 파일첨부 원래 이름1
,fileSize1          varchar2(10) -- 파일사이즈1
,fileName2          varchar2(500) -- 파일첨부이름2
,orgFileName2       varchar2(500) -- 파일첨부 원래 이름2
,fileSize2          varchar2(10) -- 파일사이즈2
,fileName3          varchar2(500) -- 파일첨부이름3
,orgFileName3       varchar2(500) -- 파일첨부 원래 이름3
,fileSize3          varchar2(10) -- 파일사이즈3
,status         number default 0 -- 발송/수신 상태
,readStatus     number default 0
,mailStatus     number default 1 -- 삭제유무 상태
,constraint FK_mail_table foreign key(fk_employee_seq) references employees_table(employee_seq)
,constraint CK_mail_table CHECK(status in(0, 1)and readStatus in(0,1))
);
create SEQUENCE mail_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;


-- 회의실 테이블(reservationRoom_table) --
create table reservationRoom_table
(roomNumber     number not null -- 회의실 번호
,roomName       varchar2(300) not null -- 회의실이름
,constraint pk_reservationRoom primary key(roomNumber)
);
insert into reservationRoom_table(roomNumber,roomName) values(1,'제1회의실');

-- 예약관리 테이블(reservation_table) --
create table reservation_table
(reservation_seq    number not null -- 예약번호
,fk_employee_seq    number not null -- 예약 신청자
,fk_roomNumber      number not null -- 예약 장소(회의실 번호)
,startDate  date not null -- 사용시작 시간(날짜 포함)
,endDate    date not null -- 사용종료 시간(날짜 포함)
,head_seq   number not null -- 예약 책임자 사원번호
,memberCount    number default 1 not null -- 사용 인원
,reason varchar2(2000) not null -- 사유
,status number default 0 not null -- 승인 상태
,constraint pk_reservation_table primary key(reservation_seq)
,constraint fk_reservation_employee foreign key(fk_employee_seq) references employees_table(employee_seq)
,constraint fk_reservation_roomNumber foreign key(fk_roomNumber) references reservationRoom_table(roomNumber)
);
create SEQUENCE reservation_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 출퇴근 테이블(attendance_table) --
create table attendance_table
(fk_employee_seq    number not null -- 사원번호
,onTime     date default sysdate -- 출근시간(년-월-일 시-분-초)
,offTime    date -- 퇴근시간(년-월-일 시-분-초)
,constraint fk_attendance_employee foreign key(fk_employee_seq) references employees_table(employee_seq)
);

-- 게시판 항목 테이블(board_category) --
create table board_category
(category_seq   number not null -- 게시글 항목번호
,category_name  varchar2(100) not null -- 게시글 항목명
,constraint pk_board_category primary key(category_seq)
);
insert into board_category(category_seq, category_name) values(1,'자유');

-- 게시판 테이블(board_table) --
create table board_table
(board_seq  number not null -- 글번호
,fk_category_num    number not null -- 항목번호
,subject    varchar2(50) not null -- 제목
,content    varchar2(4000) not null
,readCnt    number default 0 -- 조회수
,regDate    date default sysdate not null -- 등록날짜
,fk_employee_seq    number not null -- 작성자 번호
,status     number default 1 not null -- 글 상태
,commentCnt number default 0 not null -- 댓글 수
,constraint pk_board_table primary key(board_seq)
,constraint fk_board_category foreign key(fk_category_num) references board_category(category_seq) on delete set null
,constraint fk_board_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);
create SEQUENCE board_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 게시판 첨부파일 테이블(attachFile_table) --
create table attachFile_table
(file_seq   number not null -- 파일번호
,fk_board_seq   number not null -- 게시글 번호
,fileName   varchar2(500) -- 업로드 파일명
,orgFileName    varchar2(500) -- 원래 파일명
,fileSize   varchar2(10) -- 파일크기
,constraint pk_attachFile_table primary key(file_seq)
,constraint fk_attachFile_board foreign key(fk_board_seq) references board_table(board_seq) on delete cascade
);
create SEQUENCE attachFile_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 댓글 테이블(comment_table) --
create table comment_table
(commnet_seq    number not null -- 댓글번호
,fk_board_seq   number not null -- 게시글 번호(그룹번호)
,fk_employee_seq    number -- 작성자 사원번호
,readCnt    number default 0 not null -- 조회수
,content    varchar2(2000) -- 내용
,status     number default 1 -- 글상태(1:보존, 0:삭제)
,regDate    date default sysdate not null -- 작성날짜
,parent_seq number -- 상위 댓글(계층형)
,depthno    number default 0 -- 
);
create sequence comment_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;
