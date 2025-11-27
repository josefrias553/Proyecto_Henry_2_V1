{{ config(materialized='table') }}

with dates as (

    {{ dbt_utils.date_spine(
        start_date="cast('2015-01-01' as date)",
        end_date="cast('2030-12-31' as date)",
        datepart="day"
    ) }}

),

final as (

    select
        cast(to_char(date_day, 'YYYYMMDD') as int) as date_sk,
        date_day as date_value,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day,
        extract(dow from date_day) + 1 as weekday,
        case when extract(dow from date_day) in (5,6) then true else false end as is_weekend,
        false as is_holiday,
        extract(week from date_day) as fiscal_week,
        extract(month from date_day) as fiscal_month,
        extract(year from date_day) as fiscal_year
    from dates

)

select * from final