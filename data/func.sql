#sites
select * from Sites;

select * from Sites
where sid = 1;

select * from Sites
where name = 'The Museum of Modern Art (MoMA)';

set @zip = 10020;
select * from Sites
where abs(zipcode - @zip) < 20;
#manhattan: 100, 101, 102
#bronx: 104
#brooklyn:112
#queens: 110,113,114,116
#staten island: 103

#notes
select * from Notes;

select * from Notes where uid = 1;

select * from Notes where nid = 2;

select * from Notes order by clicked desc;

update Notes
set clicked = clicked + 1
where nid = 3;

insert into Notes (title, content, time, clicked, uid, sid)
values ('test', 'testing', 'May-5', 0, 1, 1);

delete from Notes
where nid = 5;


#users
select * from Users;

select password from Users
where name = 'xy2251';

insert into Users (name, password, email, description, preference)
values ('dejiyu', '19920311', 'dejiyu@gmail.com', 'sb', 'lakita');


#events
select * from Events;

select * from Events
where eid = '1';

set @zip = 10020;
select * from Events
where start_date > '20150430' and abs(zipcode - @zip) < 20;


