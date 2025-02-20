-- Топ-10 часто летающих пассажиров в месяц --
explain analyze
select passenger_id, count(1) tickets
from bookings.tickets t
	inner join bookings.ticket_flights tf on tf.ticket_no = t.ticket_no 
	inner join bookings.flights f on f.flight_id = tf.flight_id 
where f.scheduled_departure >= '2016-01-01' 
	and f.scheduled_departure < '2016-02-01'
group by t.passenger_id 
having count(1) > 1
order by count(1) desc, passenger_id
limit 10;

-- Определим первый рейс в месяце --
explain analyze
select tf.flight_id
from bookings.tickets t
	inner join bookings.ticket_flights tf on tf.ticket_no = t.ticket_no 
	inner join bookings.flights f on f.flight_id = tf.flight_id 
where f.scheduled_departure>='2016-01-01' and f.scheduled_departure< '20160201'
	and t.passenger_id = '0005 269370'
order by tf.flight_id
limit 1;
--22621

-- Отберем тех кто летал с пассажиром на определенном рейсе
explain analyze
select tf.flight_id, t.passenger_id, t.passenger_name 
from bookings.ticket_flights tf  
inner join bookings.tickets t on t.ticket_no = tf.ticket_no
where tf.flight_id = 22621;


explain analyze
with tf1 as (
	select tf.flight_id
	from bookings.tickets t
		inner join bookings.ticket_flights tf on tf.ticket_no = t.ticket_no 
		inner join bookings.flights f on f.flight_id = tf.flight_id 
	where f.scheduled_departure>='2016-01-01' and f.scheduled_departure< '20160201'
		and t.passenger_id = '0005 269370'
	order by tf.flight_id
	limit 1
)
select tf.flight_id, t.passenger_id, t.passenger_name 
from tf1
inner join bookings.ticket_flights tf on tf1.flight_id = tf.flight_id
inner join bookings.tickets t on t.ticket_no = tf.ticket_no;
	

	
	
