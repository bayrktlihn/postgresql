CREATE OR replace FUNCTION fn_factorial(p_num bigint)
RETURNS bigint LANGUAGE plpgsql AS $$
DECLARE
	result bigint;
BEGIN
	
	if p_num < 0 then
		raise exception 'invalid param';
	end if;

	if p_num = 0 or p_num = 1 then 
		return 1;
	end if;

	return p_num * fn_factorial(p_num - 1);
	
END;
$$



