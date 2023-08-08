
/*
Data Breach Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views.


The dataset I am exploring shows organizations over the years that have been breached.
I wanted to find out how many organizations have had data breaches over the years based on this dataset.

*/


Select* 
from dbo.Data_Breaches



/*Counted the number of organizations that had been affected. 
Noticed this number was more than the count(distinct([organisation])) which meant there were organisations that were breached more than once.
*/

select count([organisation]) as Number_of_Org_Affected
from dbo.Data_Breaches




--How many organizations have been affected by data breach in dataset only once.

select count(distinct([organisation])) as Number_of_Org_Affected
from dbo.Data_Breaches




-- organizations that have been affected by data breach in dataset more than once

select [organisation], count([organisation]) as Number_of_times_compromised 
from dbo.Data_Breaches
group by [organisation]
having count([organisation])> 1



--copying data into table to allow further comparison
--***also created the table in this query.

select [organisation], count([organisation]) as Number_of_times_compromised 
into Compromised_more_than_once
from dbo.Data_Breaches
group by [organisation]
having count([organisation])> 1



select * from Compromised_more_than_once




--joining table to original table to be able to analyze organizations that were breached individually; 
--to compare size of data breach on each ocassion.

select a.[organisation],[year],[records lost],[method],[sector],[data sensitivity]
from dbo.Data_Breaches a
join Compromised_more_than_once b
on a.[organisation] = b.[organisation]
order by 1,3




-- top 5 years with highest breaches

select top(5) [year],[method],count([method]) as Number_of_breaches
from dbo.Data_Breaches 
group by [method],[year]
order by 3 desc




--Percentage of breaching methods for each year using cte and partition by then storing it in a table.

with Breach_Perc as 
 (select [year],[method], Count(*) as c
  from dbo.Data_Breaches
  group by [method],[year])
select [method],[year], c, 
       ((0.0+c)/(sum(c) over (partition by [year]))*100) as percentage
into percentage_breach_methods_yearly
from Breach_Perc;



select* 
from percentage_breach_methods_yearly;





--Percentage of breaches in year 2020

with Breach_Perc2020 as 
 (select [year],[method], Count(*) as #
  from dbo.Data_Breaches
  where [year] = '2020'
  group by [method],[year])
select [method],[year], #, 
       ((0.0+#)/(sum(#) over (partition by [year]))*100) as percentage
from Breach_Perc2020;




--Percentage of sectors that were compromised each year using cte and partition by.
with Breach_Perc as 
 (select [year],[method], Count(*) as c
  from dbo.Data_Breaches
  group by [method],[year])
select [method],[year], c, 
       ((0.0+c)/(sum(c) over (partition by [year]))*100) as percentage
from Breach_Perc;




--Percentage of sectors that were compromised in year 2020

  with SecBreach_Perc as 
 (select [year],[sector],count([sector]) as number_of_breach
  from dbo.Data_Breaches
  group by [sector], [year])
select [year],[sector], number_of_breach, 
       ((0.0+number_of_breach)/(sum(number_of_breach) over (partition by [year]))*100) as percentage
from SecBreach_Perc;

 with SecBreach_Perc as 
 (select [sector],count([sector]) as number_of_breach
  from dbo.Data_Breaches
  group by [sector])
select [sector], number_of_breach, 
       ((0.0+number_of_breach)/(sum(number_of_breach) over (partition by [sector]))*100) as percentage
from SecBreach_Perc;



--what was the most record lost in 2020 using sub query or order by

--using subquery

select [organisation],[year],[records lost]
from dbo.Data_Breaches 
where [records lost] = (select max([records lost])from dbo.Data_Breaches where [year]= '2020' ) and [year]= '2020'



--using order by

select top(1) [organisation],[year],[records lost]
from dbo.Data_Breaches 
where [year] = '2020'
order by [records lost] Desc
