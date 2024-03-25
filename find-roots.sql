create or replace function fn_find_roots(a numeric, b numeric, c numeric)
returns record language plpgsql as $$
	declare 
		result record;
		delta numeric;
	begin 
		delta := b * b - 4 * a * c;
		select ((-b - sqrt(delta) ) / 2 * a) as x1,  ((-b + sqrt(delta) ) / 2 * a) as x2 into result;
		return result;
	end;
	
$$
