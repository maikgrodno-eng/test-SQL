create table fridge (
	id serial primary key,
	shelves_count integer,
	model varchar(500),
	color varchar(15),
	price numeric(10, 2)
);

insert into fridge (
	shelves_count, model, color, price) 
values (5, 'samsung r32', 'silver', 2999.99);

insert into fridge (
	shelves_count, model, color, price) 
	values (9, 'samsung e56', 'silver', 2799.99),
	(4, 'atlant', 'white', 1499.99),
	(6, 'lg l51', 'silver', 3150),
	(7, 'bosh 153', 'black', 3500),
	(3, 'minsk', 'blue', 1999.99);



select * from fridge;

select id, model from fridge;

select id, shelves_count, model, color, price from fridge where price < 2000;

select id, shelves_count, model, color, price from fridge where model like '%sung%' and price < 3000;

alter table  fridge add column exp_years integer;

update fridge set color = 'green' where id = 3;


update fridge set exp_years = case 
	when id % 2 = 0 then 4
	else 3
end
where exp_years is null;

select sum (price),
min (price),
max (price),
avg (price)

from fridge;


create or replace function get_fridge_info (model text, color text, shelves_count integer)
	returns text
	as $$
	begin
		RETURN model || 'Color:' || color_text || shelves_count;
	end;
	$$ language plpgsql;

create or replace procedure raise_fridge_price (fridge_id integer, koef_rising numeric)
	language plpgsql
	as $$
	declare
	old_price numeric;
	begin
		select price into old_price from fridge where id = fridge_id;
		update fridge set price = old_price * (1 + koef_rising) where id = fridge_id;
	end;
	$$;


call raise_fridge_price (3, 0.2);


