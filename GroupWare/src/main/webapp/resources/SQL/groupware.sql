-- sys계정 내용 --
show user; -- USER이(가) "SYS"입니다.
 create user finalorauser3 identified by eclass
 default tablespace users;
 
 grant connect, resource, unlimited tablespace to finalorauser3;
 grant create view to finalorauser3;
 --------------------------------------------------------------------
 -- finalorauser3계정 내용 --
 show user;