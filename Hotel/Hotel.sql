--Will copy this into advanced sql query in Power BI when importing data set
--Will show us the combined tables
with cte_ as
(
select * 
from dbo.[2018]
union
select * 
from dbo.[2019]
union
select * 
from dbo.[2020] 
)
select * from cte_ a
left join market_segment b
on a."market_segment" = b."market_segment"
left join meal_cost c
on a."meal" = c."meal"

