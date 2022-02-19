create schema TravelOnTheGo;
use TravelOnTheGo;

Create table passenger(
passenger_name varchar(50),
Category varchar(25),
Gender varchar(10),
Boarding_city varchar(30),
Destination_city varchar(30),
Distance int,
Bus_type varchar(25));

Create table Price (
Bus_type varchar(30) references passenger(bus_type),
distance int references passenger(distance),
price int);

insert into passenger values('Sejal','AC','F','Bengaluru','Chennai','350','Sleeper');
insert into passenger values('Anmol','Non-AC','M','Mumbai','Hyderabad','700','Sitting');
insert into passenger values('Pallavi','AC','F','Panaji','Bengaluru','600','Sleeper');
insert into passenger values('Khusboo','AC','F','Chennai','Mumbai','1500','Sleeper');
insert into passenger values('Udit','Non-AC','M','Trivandrum','panaji','1000','Sleeper');
insert into passenger values('Ankur','AC','M','Nagpur','Hyderabad','500','Sitting');
insert into passenger values('Hemant','Non-AC','M','Panaji','Mumbai','700','Sleeper');
insert into passenger values('Manish','Non-AC','M','Hyderabad','Bengaluru','500','Sitting');
insert into passenger values('Piyush','AC','F','Pune','Nagpur','700','Sleeper');

insert into price values('Sleeper','350','770');
insert into price values('Sleeper','500','1100');
insert into price values('Sleeper','600','1320');
insert into price values('Sleeper','700','1540');
insert into price values('Sleeper','1000','2200');
insert into price values('Sleeper','1200','2640');
insert into price values('Sleeper','1500','2700');

insert into price values('Sitting','500','620');
insert into price values('Sitting','600','744');
insert into price values('Sitting','700','828');
insert into price values('Sitting','1000','1240');
insert into price values('Sitting','1200','1488');
insert into price values('Sitting','1500','1860');



/*How many females and how many male passengers travelled for a minimum distance of
600 KM s */

select gender , count(gender) from passenger where distance< 700 group by gender ;



/* Find the minimum ticket price for Sleeper Bus. */

select min(price) from price where bus_type ='Sleeper'; 



/*Select passenger names whose names start with character 'S' */

select passenger_name from passenger where passenger_name Like'S%';



/* Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/

select Passenger_name, Boarding_city, destination_city,price, passenger.bus_type from passenger left join price on passenger.distance = price.distance group by passenger_name;


/*What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s */

select passenger_name, price.price from passenger inner join price
on passenger.distance = price.distance
where passenger.bus_type='Sitting' and price.distance = 1000 group by passenger_name;



/*What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/

select *, price.price  from passenger 
where boarding_city ='Panaji' and destination_city='Bangalore' In (select price.price from price where distance= 600);



/* List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order. */

select * from passenger group by distance order by distance desc;



/* Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables */

select passenger_name , distance*100/(select sum(distance) from passenger) from passenger;



/*Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500*/

select passenger.distance , price.price,
CASE
when price.distance > 1000 then 'Expensive'
when 500 < price.distance < 1000 then 'Average Cost'
else 'Cheap'
End as PriceCategory
from passenger inner join price
on passenger.distance = price.distance;
