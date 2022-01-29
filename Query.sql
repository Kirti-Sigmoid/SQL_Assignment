-- time period of dataser
select min(date) as Start_Date ,max(date) as Last_Date from airbnb__calender;
-- find total number of enteries


select listing_id,count(*) from airbnb__calender
group by listing_id,date having  count(*)>1;

-- create a table having no dublicate values

create table new_airbnb__calender as
select distinct * from airbnb__calender;

select * from new_airbnb__calender;

-- Query 3
create table available_table as
select listing_id,
case available
  when 't' then 1
  else 0
   end is_available,
   case available
   when 'f' then 1
   else 0
   end is_not_available
   from new_airbnb__calender;
   drop table available_fraction;
   select * from available_table;
   
   select listing_id, sum(is_available) as is_available ,
   sum(is_not_available) as is_not_available ,
   sum(is_available)/(sum(is_available)+sum(is_not_available)) as fraction
   from available_table group by(listing_id);

-- query 4
create table available_fraction as
 select listing_id, 
   sum(is_available)/(sum(is_available)+sum(is_not_available)) as fraction
   from available_table group by(listing_id);
-- properties are available more then 50% of the day 
select count(listing_id) from available_fraction 
where fraction> 0.5;
-- properties are available more then 75% of the day 
select count(listing_id) from available_fraction 
where fraction> 0.75;
-- Query 5
--  find the min ,max and average of each price
create table table_min_max_average as
select listing_id, min(price) as min,
max(price) as max, 
avg(price) as average from new_airbnb__calender
where available='t'
group by (listing_id) ;

select * from table_min_max_average order by listing_id;
-- query 6
-- extract the listing id having average > 500
select listing_id, average from table_min_max_average
where average> 500;



