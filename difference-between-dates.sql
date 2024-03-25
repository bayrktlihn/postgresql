CREATE OR replace FUNCTION fn_difference_between_dates(p_start_date date, p_end_date date)
RETURNS record LANGUAGE plpgsql AS $$
DECLARE
	startDate date;
	endDate date;
	oneYearAdded date;
	oneMonthAdded date;
	oneDayAdded date;
	yearCount int := 0;
	monthCount int := 0;
	dayCount int := 0;
	RESULT record;
BEGIN
	
	startDate := p_start_date;
	endDate := p_end_date;
	
	while startDate < endDate loop
		
		oneYearAdded := CAST((startDate + INTERVAL '1 year') AS date);
		oneMonthAdded := CAST((startDate + INTERVAL '1 month') AS date);
		oneDayAdded := CAST((startDate + INTERVAL '1 day') AS date);
		
		
		IF oneYearAdded <= endDate AND date_part('day', oneYearAdded) = date_part('day', startDate)  THEN 
			yearCount := yearCount + 1;
			startDate := oneYearAdded;
		elsif oneMonthAdded <= endDate AND date_part('day', oneMonthAdded) = date_part('day', startDate) THEN
			monthCount := monthCount + 1;
			startDate := oneMonthAdded;
		elsif oneDayAdded <= endDate THEN
			dayCount := dayCount + 1;
			startDate := oneDayAdded;
		END IF;
		
	end loop;

	SELECT yearCount AS YEAR, monthCount AS MONTH, dayCount AS DAY INTO RESULT;

	RETURN RESULT;	
END;
$$
