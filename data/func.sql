#sites
select * from Sites;

select * from Sites
where sid = 1;

select * from Sites
where name = 'Museum of Modern Art';

#minimize range using zipcode
set @zip = 10020;
select * from Sites
where abs(zipcode - @zip) < 20;
#manhattan: 100, 101, 102
#bronx: 104
#brooklyn:112
#queens: 110,113,114,116
#staten island: 103

#recommend sites, shorter distances first
set @curlong = 10;
set @curla = 10;
select * from Sites
order by (longtitude-curlong)*(longtitude-curlong) + (latitude-curla)*(latitude-curla);

#recommend sites by rank which is indicated by sid
select * from Sites
order by sid;


#notes: 
# select contents of one note
select content, photourl from Contents
where nid = 1 order by cid;

# select notes by title from one user
select N.title, C.photourl from Notes N, Contents C
where N.uid = 1 and C.nid = N.nid and C.cid = 1 order by N.nid;

# select notes by popularity
select title from Notes order by clicked desc;

update Notes
set clicked = clicked + 1
where nid = 3;

insert into Notes (title, time, clicked, uid, sid, public, photourl)
values ('test', 'May-12', 0, 1, 1, 0, '');

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

#recommend events, shorter distances first
set @curlong = 10;
set @curla = 10;
select * from Events
order by (longtitude-curlong)*(longtitude-curlong) + (latitude-curla)*(latitude-curla)

