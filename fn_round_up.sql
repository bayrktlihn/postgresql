drop function fn_round_up;
create or replace function fn_round_up(p_num numeric, p_decimal_size int)
returns numeric language plpgsql as $$
	declare 
		up boolean;
		multFlag int := 1;
	begin 
		
		if p_num < 0 then
			multFlag = -1;
			p_num := multFlag * p_num;
		end if;
		
		up := floor(p_num * power(10, p_decimal_size)) != p_num * power(10, p_decimal_size);
		
		if up = true then
			return (ceil(p_num * power(10, p_decimal_size)) /  power(10, p_decimal_size) ) * multFlag;
		end if;
	
		return (floor(p_num * power(10, p_decimal_size)) /  power(10, p_decimal_size) ) * multFlag;
		
	end;
$$
