alter session set "_oracle_script"=true;  
create user editorial identified by editorial;
GRANT CONNECT, RESOURCE, DBA TO editorial;
