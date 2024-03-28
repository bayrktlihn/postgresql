-- DROP FUNCTION e_belediye.fn_get_difference_between_dates(date, date);

CREATE OR REPLACE FUNCTION e_belediye.fn_get_difference_between_dates(p_dts date, p_dte date)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
DECLARE
    totalMonth       int := 0;
    totalYear        int := 0;
    totalDay         int := 0;
    addedYear        date;
    addedMonth       date;
    addedDay         date;
    result           record;
    addedMonthResult boolean;
    addedDayResult   boolean;
    addedYearResult  boolean;
    maxYear int := 100;
BEGIN
    while p_dts < p_dte
        loop

            addedYearResult := false;
            for i in reverse maxYear..1
                loop
                    addedYear := p_dts + cast(concat_ws(' ', cast(i as varchar), 'year') as interval);

                    if addedYear <= p_dte and date_part('day', addedYear) = date_part('day', p_dts) then
                        p_dts := addedYear;
                        totalYear := totalYear + i;
                        addedYearResult := true;
                        exit;
                    end if;

                end loop;




            addedMonthResult := false;
            for i in reverse 11..1
                loop
                    addedMonth := p_dts + cast(concat_ws(' ', cast(i as varchar), 'month') as interval);

                    if addedMonth <= p_dte and date_part('day', addedMonth) = date_part('day', p_dts) then
                        totalMonth := totalMonth + i;
                        p_dts := addedMonth;
                        addedMonthResult := true;
                        exit;
                    end if;

                end loop;



            addedDayResult := false;
            for i in reverse 31..1
                loop
                    addedDay := p_dts + cast(concat_ws(' ', cast(i as varchar), 'day') as interval);

                    if addedDay <= p_dte then
                        totalDay := totalDay + i;
                        p_dts := addedDay;
                        addedDayResult := true;
                        exit;
                    end if;
                end loop;

        end loop;
    select totalYear as yil, totalMonth as ay, totalDay as gun into result;
    return result;
END ;
$function$
;
