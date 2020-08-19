-- sys계정 내용 --
show user; -- USER이(가) "SYS"입니다.
create user finalorauser3 identified by eclass
default tablespace users;
 
grant connect, resource, unlimited tablespace to finalorauser3;
grant create view to finalorauser3;
--------------------------------------------------------------------
-- finalorauser3계정 내용 --
show user; -- USER이(가) "FINALORAUSER3"입니다.

select * from tab;
select * from seq;

select *
from employees_table;

-- 테이블 삭제 --
drop table companycalendar_category purge;
drop table equipment_table purge;
drop sequence equipment_table_seq;
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
drop table document_category purge;

 -- 직급 테이블(position_table) --
create table position_table
(position_seq   number not null -- 직책번호
,position_name  varchar2(50) not null -- 직책명
,position_salary    number not null -- 직책 급여
,constraint pk_position_seq primary key(position_seq)
); 

 -- 사원상태 테이블(employeeStatus_table) --
create table employeeStatus_table
(status_seq     number not null -- 사원 상태번호
,status_name    varchar2(50) not null -- 사원 상태명
,constraint pk_employeeStatus primary key(status_seq)
);


 -- 부서테이블(department_table) --
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

 -- 사원테이블(employees_table)--
 create table employees_table
(employee_seq   number -- 사원번호
,employee_name  varchar2(50) not null -- 사원명
,employee_id    varchar2(100) not null -- 사원ID
,employee_pw    varchar2(500) not null -- 사원PW
,email          varchar2(500) not null -- 사내 이메일
,phone          varchar2(500) not null -- 핸드폰번호
,fk_status      number default 1 not null -- 사원상태
,hire_date      date default sysdate not null -- 입사날짜
,fire_date      date -- 퇴사날짜
,fk_position    number default 1 -- 사원직책
,fk_department  number -- 부서
,grade          number default 1 not null -- 권한
,gender         number(1) not null -- 성별(1:남 , 2:여)
,birthday       varchar2(8) not null -- 생년월일
,address        varchar2(300) not null -- 주소
,postcode       varchar2(300) not null -- 우편번호
,detailaddress  varchar2(500)-- 상세주소
,extraaddress  varchar2(500)-- 참고항목
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
,category_name  varchar2(50) not null -- 항목이름
,constraint pk_album_category primary key (category_num)
);



 -- album 테이블(album_table) --
create table album_table
(album_seq  number not null -- album게시글 번호
,album_category number -- album게시글 항목
,fk_employee_seq    number  -- 게시글 작성자 번호
,subject    varchar2(500) not null -- 게시글 제목
,content    varchar2(4000) not null -- 게시글 내용
,regDate    date default sysdate -- 게시글 등록 날짜
,constraint pk_album_table primary key (album_seq)
,constraint fk_album_category foreign key (album_category) REFERENCES album_category(category_num)on delete set null
,constraint fk_album_employee foreign key (fk_employee_seq) references  employees_table(employee_seq) on delete set null
);

create sequence 
start with 1 
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 퇴사사유 테이블(fire_date) --
create table fire_table
(fk_employee_seq    number
,groupno    varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,reason varchar2(4000) -- 퇴사 사유
,interviewer_seq    number not null -- 면담자 사원번호
,interview_content  varchar2(4000) not null -- 면담내용
,documentStatus     number default 0 not null -- 연결되어있는 결재문서의 승인상태 값과 연동??
,constraint fk_fire_employees foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);

-- 매출 테이블(sales_table) --
create table sales_table
(sales_seq  number not null -- 매출번호
,groupno    varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,sales_title    varchar2(500) not null -- 매출제목
,sales_price    number  not null -- 매출 가격
,sales_count    number not null -- 매출 개수
,reason     varchar2(4000) not null -- 매출 사유
,fk_department_seq  number -- 매출 부서
,regDate    date default sysdate not null -- 매출 기록 날짜
,documentStatus     number default 0 not null -- 연결되어있는 결재문서의 승인상태 값과 연동??
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
,groupno    varchar2(50) not null -- 문서결재 테이블과 연동하도록 하는 컬럼
,club_name  varchar2(100) not null -- 동호회 이름
,club_info  varchar2(2000) -- 동호회 소개
,regDate    date default sysdate not null -- 동호회 생성날짜
,documentStatus     number default 1 not null -- 연결되어있는 결재문서의 승인상태 값과 연동??
,representative_img  varchar2(500) not null -- 동호회 대표 이미지
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
,fk_employee_seq    number  -- 가입한 사원번호
,documentStatus     number default 1 -- 연결되어있는 결재문서의 승인상태 값과 연동??
,constraint pk_clubMember_table primary key(member_seq)
,constraint fk_clubMember_club foreign key (fk_club) references club_table(club_seq) on delete cascade
,constraint fk_clubMember_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
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
,fk_employee_seq    number -- 대상 사원 번호
,attendance     varchar2(50) not null -- 출결점수
,attitude       varchar2(50) not null -- 태도점수
,performance    varchar2(50) not null -- 업무성과 점수
,manager    varchar2(100) not null -- 기안자(이름)
,reason     varchar2(4000) not null -- 점수를 준 사유(전체)
,regDate    date default sysdate not null -- 근태관리 등록 날짜
,documentStatus     number default 1 -- 연결되어있는 결재문서의 승인상태 값과 연동??
,constraint pk_ta_table primary key(ta_seq)
,constraint fk_ta_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
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
select * from grade_table;
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
,trip_category  number -- 휴가/출장 항목번호
,reason     varchar2(4000) not null -- 사유
,trip_start date not null -- 휴가/출장 시작 날짜
,trip_end   date not null -- 휴가/출장 복귀 날짜
,triplocation      varchar2(1000) -- 출장지
,fk_employee_seq    number  -- 신청자
,documentStatus     number default 0 not null -- 연결되어있는 결재문서가 모두 승인 되면 1
,constraint pk_trip_table primary key (trip_seq)
,constraint fk_trip_employee foreign key (fk_employee_seq) REFERENCES employees_table(employee_seq)on delete set null
,constraint fk_trip_category foreign key (trip_category) references trip_category(category_num) on delete set null
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

-- 문서결재 테이블(document_table) --
create table document_table
(document_seq   number not null -- 문서결재 고유 번호
,groupno        varchar2(50) not null -- 문서 일련번호(각각의 결과 테이블에 사용할 번호)
,fk_employee_seq    number not null -- 결재 신청자
,subject    varchar2(1000) not null -- 결재문서 제목
,content    varchar2(4000) not null -- 결재문서 내용 (.jpg 파일)
,regDate    date default sysdate not null -- 결재 신청날짜
,approver_seq   number not null -- 결재자 사원번호
,approveDate    date -- 결재날짜
,fileName   varchar2(500) -- 파일첨부(업로드 파일명)
,orgFileName    varchar2(500) -- 파일첨부(기존 파일명)
,fileSize   number -- 파일크기
,parent_approver    varchar2(100) -- 상위 결재자
,status     number default 0 not null -- 결재 상태(승인, 미승인, 반려)
,reason     varchar2(4000) -- 결재 사유( 반려 사유 )
,document_category  number not null -- 문서 항목
,constraint fk_document_employee foreign key (fk_employee_seq) references employees_table(employee_seq) on delete set null
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
,reason     varchar2(4000)  -- 프로젝트 중단 사유
,status     number default 0 -- 프로젝트 상태(0: 진행중 1:중단 2:완료)
,downPayment    number -- 계약금
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
,fk_employee_seq    number -- 사원번호(사원명, 직책, 부서 join요소)
,constraint pk_projectMember_table primary key(projectMember_seq)
,constraint fk_projectMember_project foreign key(fk_project_seq) references project_table(project_seq) on delete cascade
,constraint fk_projectMember_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
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
,backgroundColor      varchar2(100) -- 배경색     
,constraint pk_personalCalendar primary key(calendar_seq)
,constraint fk_personalcalendar_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
);
create SEQUENCE personalCalendar_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

create table companyCalendar_category
(category_num   number not null -- 항목번호
,category_name  varchar2(50) not null -- 항목명
,constraint pk_companyCalendar_category primary key(category_num)
);

-- 회사일정 테이블(companyCalendar_table) --
create table companyCalendar_table
(comCalendar_seq   number not null -- 일정번호
,title      varchar2(500) not null -- 일정 타이틀
,content    varchar2(2000) not null -- 일정내용
,startDate  date not null -- 일정시작 날짜
,endDate    date not null -- 일정종료 날짜
,backgroundColor      varchar2(100) -- 배경색
,fk_department_seq number -- 부서일정인 경우 사용하는 컬럼
,calendar_category  number not null -- 일정 카테고리(경조사, 협력일정, 단독일정...등)
,constraint pk_companyCalendar primary key(comCalendar_seq)
,constraint fk_companyCal_department foreign key(fk_department_seq) references department_table(department_seq)on delete cascade
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
,constraint fk_messengerRoom_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
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
,fk_roomNumber      number -- 메신저 그룹번호
,fk_employee_seq    number  -- 발신자
,constraint pk_messenger_table primary key(message_seq)
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

-- 메일 테이블(mail_send_table) --
create table mail_table
(mail_seq           number not null -- 메일 번호(P.K)
,mail_groupno       number -- 송신/수신 그룹번호 (null=임시저장?)
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
,status         number default 0 not null-- 발송/수신 상태(0:보낸 1:받은 2:자신)
,readStatus     number default 0 not null -- 기독 유무
,mailStatus     number default 1 not null-- 삭제유무 상태
,regDate        date default sysdate not null
,constraint FK_mail_table foreign key(fk_employee_seq) references employees_table(employee_seq) on delete cascade
,constraint CK_mail_table CHECK(status in(0, 1, 2)and mailStatus in(0,1) and readStatus in(0,1))
);

create SEQUENCE mail_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

select nvl(max(mail_groupno),0) from mail_table;

-- 회의실 테이블(reservationRoom_table) --
create table reservationRoom_table
(roomNumber     number not null -- 회의실 번호
,roomName       varchar2(300) not null -- 회의실이름
,constraint pk_reservationRoom primary key(roomNumber)
);

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
,status number default 0 not null -- 승인 상태(0: 승인대기중, 1: 승인완료, 2: 반려)
,regDate    date default sysdate not null
,constraint pk_reservation_table primary key(reservation_seq)
,constraint fk_reservation_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete set null
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
,onTime     date default sysdate not null -- 출근시간(년-월-일 시-분-초)
,offTime    date -- 퇴근시간(년-월-일 시-분-초)
,constraint fk_attendance_employee foreign key(fk_employee_seq) references employees_table(employee_seq)on delete cascade
);

-- 게시판 항목 테이블(board_category) --
create table board_category
(category_seq   number not null -- 게시글 항목번호
,category_name  varchar2(100) not null -- 게시글 항목명
,constraint pk_board_category primary key(category_seq)
);

-- 게시판 테이블(board_table) --
create table board_table
(board_seq  number not null -- 글번호
,fk_category_num    number not null -- 항목번호
,subject    varchar2(50) not null -- 제목
,content    varchar2(4000) not null
,readCnt    number default 0 -- 조회수
,regDate    date default sysdate not null -- 등록날짜
,fk_employee_seq    number -- 작성자 번호
,status     number default 1 not null -- 글 상태
,commentCnt number default 0 not null -- 댓글 수
,constraint pk_board_table primary key(board_seq)
,constraint fk_board_category foreign key(fk_category_num) references board_category(category_seq)
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
(comment_seq    number not null -- 댓글번호
,fk_board_seq   number not null -- 게시글 번호(그룹번호)
,fk_employee_seq    number -- 작성자 사원번호
,readCnt    number default 0 not null -- 조회수
,content    varchar2(2000) not null -- 내용
,status     number default 1 not null -- 글상태(1:보존, 0:삭제)
,regDate    date default sysdate not null -- 작성날짜
,parent_seq number -- 상위 댓글(계층형)
,depthno    number default 0 not null
,constraint pk_comment_seq primary key(commnet_seq)
,constraint fk_commnet_board foreign key(fk_board_seq) references board_table(board_seq) on delete cascade
,constraint fk_comment_employee foreign key(fk_employee_seq) references employees_table(employee_seq) on delete set null
);

-- 댓글 테이블 컬럼 변경 -- 
alter table comment_table
rename column commnet_seq to comment_seq;

create sequence comment_table_seq
start with 1 -- 시작값
increment by 1 -- 증가값
nomaxvalue -- 최대값 설정
nominvalue -- 최소값 설정
nocycle -- 반복 설정
nocache;

-- 비품관련 테이블(equipment_table) --
create table equipment_table
(equipment_seq  number not null -- 비품 구입번호
,fk_department_seq  number -- 비품 구매한 부서
,equipment_name     varchar2(500) not null -- 비품목록 이름
,unit      number not null -- 비품 단위
,equipment_price    number not null -- 비품 가격(단위)
,equipment_count    number not null -- 비품 구매 수
,reason     varchar2(4000) -- 구매 사유
,purchaseDate   date not null-- 구입날짜
,groupno    varchar2(50) not null
,documentStatus number default 0 not null
,constraint pk_equipment_table primary key(equipment_seq)
,constraint fk_equipment_department foreign key(fk_department_seq) references department_table(department_seq) on delete set null
);

create sequence equipment_table_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 항목(카테고리) 데이터 입력 --
insert into position_table(position_seq, position_name, position_salary) values(1,'사원',2500);
insert into position_table(position_seq, position_name, position_salary) values(2,'대리',3400);
insert into position_table(position_seq, position_name, position_salary) values(3,'과장',4100);
insert into position_table(position_seq, position_name, position_salary) values(4,'부장',5090);
insert into position_table(position_seq, position_name, position_salary) values(5,'이사',6400);
insert into position_table(position_seq, position_name, position_salary) values(6,'사장',10000);
commit;

insert into employeeStatus_table(status_seq, status_name) values (1,'일반');
insert into employeeStatus_table(status_seq, status_name) values (2,'퇴사');
insert into employeeStatus_table(status_seq, status_name) values (3,'휴가');
insert into employeeStatus_table(status_seq, status_name) values (4,'출장');
commit;


insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'디자인팀');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'개발팀');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'영업팀');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'인사팀');
insert into department_table(department_seq, department_name) values (department_table_seq.nextval,'경영지원팀');
commit;

insert into album_category(category_num, category_name) values(1,'사내활동');
insert into album_category(category_num, category_name) values(2,'동호회');
insert into album_category(category_num, category_name) values(3,'봉사');
commit;

insert into grade_table(grade_level, grade_name) values(1,'일반');
insert into grade_table(grade_level, grade_name) values(2,'인사관리');
insert into grade_table(grade_level, grade_name) values(3,'예약관리');
insert into grade_table(grade_level, grade_name) values(4,'매출관리');
insert into grade_table(grade_level, grade_name) values(5,'전체');
commit;


insert into trip_category(category_num, category_name) values(1,'연차');
insert into trip_category(category_num, category_name) values(2,'월차');
insert into trip_category(category_num, category_name) values(3,'반차');
insert into trip_category(category_num, category_name) values(4,'여름휴가');
insert into trip_category(category_num, category_name) values(5,'출산휴가');
insert into trip_category(category_num, category_name) values(6,'단기출장');
insert into trip_category(category_num, category_name) values(7,'장기출장');
insert into trip_category(category_num, category_name) values(8,'해외출장');
commit;

insert into document_category(document_category_seq, category_name)values(1,'휴가신청');
insert into document_category(document_category_seq, category_name)values(2,'출장신청');
insert into document_category(document_category_seq, category_name)values(3,'매출');
insert into document_category(document_category_seq, category_name)values(4,'비품구매');
insert into document_category(document_category_seq, category_name)values(5,'프로젝트 시작');
insert into document_category(document_category_seq, category_name)values(6,'프로젝트 중단');
insert into document_category(document_category_seq, category_name)values(7,'프로젝트 완료');
insert into document_category(document_category_seq, category_name)values(8,'퇴사');
insert into document_category(document_category_seq, category_name)values(9,'인사고과');
insert into document_category(document_category_seq, category_name)values(10,'동호회 신청');
insert into document_category(document_category_seq, category_name)values(11,'동호회 가입');
insert into document_category(document_category_seq, category_name)values(12,'동호회 해체');
commit;

insert into board_category(category_seq, category_name) values(1,'공지사항');
insert into board_category(category_seq, category_name) values(2,'FAQ');
insert into board_category(category_seq, category_name) values(3,'자유');
commit;

insert into reservationRoom_table(roomNumber, roomName) values(1,'대회의실');
insert into reservationRoom_table(roomNumber, roomName) values(2,'중회의실A');
insert into reservationRoom_table(roomNumber, roomName) values(3,'중회의실B');
insert into reservationRoom_table(roomNumber, roomName) values(4,'중회의실C');
insert into reservationRoom_table(roomNumber, roomName) values(5,'소회의실1');
insert into reservationRoom_table(roomNumber, roomName) values(6,'소회의실2');
insert into reservationRoom_table(roomNumber, roomName) values(7,'소회의실3');
commit;

insert into companyCalendar_category(category_num, category_name) values(1,'경조사');
insert into companyCalendar_category(category_num, category_name) values(2,'워크샵');
insert into companyCalendar_category(category_num, category_name) values(3,'협력일정');
insert into companyCalendar_category(category_num, category_name) values(4,'채용일정');

-- 메일 테이블 check 제약조건 수정 --
alter table mail_table drop constraint CK_mail_table;
alter table mail_table add constraint CK_mail_table CHECK(status in(0, 1, 2)and mailStatus in(0,1) and readStatus in(0,1));

select * from mail_table order by mail_seq desc;
delete from mail_table;
commit;




-- 예약 신청 조회 (혜민)
select R.reservation_seq
     , E.employee_name
     , D.department_name
     , P.position_name
     , V.roomName
     , to_char(R.startDate, 'yyyy.mm.dd hh24:mi') as startDate
     , to_char(R.endDate, 'yyyy.mm.dd hh24:mi') as endDate
     , R.memberCount
     , to_char(R.startDate, 'yyyy.mm.dd')
     , case R.status when 0 then '승인대기중'
                     when 1 then '승인완료'
                     when 2 then '반려'
       end AS status
     , reason  
     , to_char(R.regDate , 'yyyy.mm.dd hh24:mi:ss') as regDate
from reservation_table R join employees_table E
on R.fk_employee_seq = E.employee_seq
join department_table D
on E.fk_department = D.department_seq
join position_table P
on E.fk_position = P.position_seq
join reservationRoom_table V
on R.fk_roomNumber = V.roomNumber
where R.status = 0
order by R.reservation_seq desc;




-- 자유게시판 페이징처리를 위한 데이터
begin
    for i in 1..100 loop 
        insert into board_table(board_seq, fk_category_num, subject, content, readCnt, regDate, fk_employee_seq, status, commentCnt)
        values(board_table_seq.nextval, 3, '파이리가 쓴 글'||i, '파이리 입니다.'||i, default, default, 1, default, default); 
    end loop;
end;
commit;

-- 자유게시판 댓글 페이징처리를 위한 데이터
begin
    for i in 1..100 loop 
        insert into comment_table(comment_seq, fk_board_seq, fk_employee_seq, readCnt, content, status, regDate, parent_seq, depthno)
		values(comment_table_seq.nextval, 1, 1, default, '댓글 테스트 입니다.'||i, default, default, 0, default); 
    end loop;
end;
commit;


begin
    for i in 1..20 loop 
        insert into board_table(board_seq, fk_category_num, subject, content, readCnt, regDate, fk_employee_seq, status, commentCnt)
        values(board_table_seq.nextval, 2, '파이리가 쓴 글'||i, '파이리 입니다.'||i, default, default, 4, default, default); 
    end loop;
end;

commit;