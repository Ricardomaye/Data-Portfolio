/*
Approved Food Establishments In Northern Ireland Dataset - April 2023

Skills Utilized: CTE, Creating Tables, Update Tables, Aggregate Functions, Window Functions, Views

Cleaned Data, Explored Data, Created Tables and views (to be used in dashboard).
*/



Select *
From NewProject..APMS_NI_April23


/* DATA CLEANING */


--removing duplicates

with RowNumCTE as(
select *,
	Row_number() over (
	partition by 
			Address1,
			TradingName,
			All_Activities
				order by 
				AppNo
				)row_num
from NewProject..APMS_NI_April23 
)
delete
from RowNumCTE
where row_num >1
order by Town



--Make all Fields in Town column have a standard case

update NewProject..APMS_NI_April23 
set Town = upper(Town);


/* DATA EXPLORATION */


--Number of all activities

select All_Activities, count(All_Activities) as Number_establishments
from NewProject..APMS_NI_April23
group by All_Activities
order by 2 Desc



--Egg

--Which competent authority governs Packing Centres in NI

Create view C_A_Egg_Business as
Select CompetentAuthority, count(CompetentAuthority) as Food_Establishments
From NewProject..APMS_NI_April23
where All_Activities like '%Egg%' 
group by CompetentAuthority



--Percentage of egg businessess vs other businesses using cte and sub query

create view Percent_Egg_vs_other_businesses as
with cte as
(
select All_Activities, count(All_Activities) as Number_establishments
from NewProject..APMS_NI_April23
group by All_Activities
--order by 2 Desc
)
select All_Activities, Number_establishments, ((Number_establishments+0.0)*100/(select sum(Number_establishments) from cte))as Percentage_of_businesses
from cte
where All_Activities not like '%Egg%' 



--Percent other business vs egg

create view Percent_other_businesses_to_egg as
with cte as
(
select All_Activities, count(All_Activities) as Number_establishments
from NewProject..APMS_NI_April23
group by All_Activities
--order by 2 Desc
)
select All_Activities, Number_establishments, (Number_establishments+0.0)*100/(select sum(Number_establishments) from cte)as Percentage_of_businesses
from cte
where All_Activities not like '%Egg%'



--Calculate sum from Percent_Egg_vs_other_businesses

select sum(Percentage_of_businesses) as Percentage
from Percent_Egg_vs_other_businesses



--Calculate Percent_other_businesses_to_egg

select sum(Percentage_of_businesses) as Percentage
from Percent_other_businesses_to_egg



--create table to show egg Businsess to Others Percentage

create table Egg_Business_Vs_Other_Percentage(
   Percent_Egg_vs_other_businesses decimal (10, 2),
    Percent_other_businesses_to_egg decimal (10, 2)
);



--Inserting Values into egg Businsess to Others Percentage Table

INSERT INTO Egg_Business_Vs_Other_Percentage (Percent_Egg_vs_other_businesses, Percent_other_businesses_to_egg)
SELECT
    (SELECT SUM(Percentage_of_businesses) FROM Percent_Egg_vs_other_businesses) AS Percent_Egg_vs_other_businesses,
    (SELECT SUM(Percentage_of_businesses) FROM Percent_other_businesses_to_egg) AS Percent_other_businesses_to_egg;

Select*
from Egg_Business_Vs_Other_Percentage



-- Number of Egg Businesses

Select count(TradingName) as Egg_Establishments_NI
From NewProject..APMS_NI_April23 
where All_Activities like '%Egg%'



--All columns of egg businesses

Select *
From NewProject..APMS_NI_April23 
where All_Activities like '%egg%'
order by Town



--Create view to show egg business per locations

create view EggBussiness_Per_Location as
Select AppNo,Address1,Town,Postcode,Country,TradingName, count(TradingName) over (partition by town) as Egg_Supplier_Count
From NewProject..APMS_NI_April23 
where All_Activities like '%egg%'



--create table to show the categoriy of each egg-business

create table Egg_Activities(All_Activities nvarchar(255),Num_Establishments int)



--using cte to extract the content needed and copying them to table

with cte_ as
(
Select *
From NewProject..APMS_NI_April23 
where All_Activities like '%egg%'
)
insert into Egg_Activities (All_Activities, Num_Establishments)
select distinct(All_Activities), count(All_Activities) As Num_Establishments
from cte_
group by All_Activities

select* 
from Egg_Activities

update Egg_Activities
set Num_Establishments = '4'
where All_Activities = 'Processing Plant (Egg)'



--Number of Towns With Egg Businesses In NI

Create view Number_Town_Egg_Business as
Select distinct(count(Town)) as NumTownEggsBusinesses
From NewProject..APMS_NI_April23 
where All_Activities like '%Egg%'



--Dairy


--Which competent authority governs Dairy in NI

create view C_A_Dairy as
Select CompetentAuthority, count(CompetentAuthority) as Food_Establishments
From NewProject..APMS_NI_April23
where All_Activities like '%Dairy%'
group by CompetentAuthority
--order by count(CompetentAuthority) desc



-- All Dairy
Select TradingName, All_Activities
From NewProject..APMS_NI_April23 
where All_Activities like '%Dairy%'



--Percentage of Dairy businessess vs other businesses using cte and sub query

create view Percent_Dairy_vs_other_businesses as
with cte as
(
select All_Activities, count(All_Activities) as Number_establishments
from NewProject..APMS_NI_April23
group by All_Activities
--order by 2 Desc
)
select All_Activities, Number_establishments, ((Number_establishments+0.0)*100/(select sum(Number_establishments) from cte))as Percentage_of_businesses
from cte
where All_Activities like '%Dairy%' 



--Percent other business vs Dairy

create view Percent_other_businesses_to_Dairy as
with cte as
(
select All_Activities, count(All_Activities) as Number_establishments
from NewProject..APMS_NI_April23
group by All_Activities
--order by 2 Desc
)
select All_Activities, Number_establishments, (Number_establishments+0.0)*100/(select sum(Number_establishments) from cte)as Percentage_of_businesses
from cte
where All_Activities not like '%Dairy%'



--Calculate sum from Percent_Dairy_vs_other_businesses

select sum(Percentage_of_businesses) as Percentage
from Percent_Dairy_vs_other_businesses



--Calculate Percent_other_businesses_to_Dairy

select sum(Percentage_of_businesses) as Percentage
from Percent_other_businesses_to_Dairy



--create table to show Dairy Businsess to Others Percentage

create table Dairy_Business_Vs_Other_Percentage(
   Percent_Dairy_vs_other_businesses decimal (10, 2),
   Percent_other_businesses_to_Dairy decimal (10, 2)
);



--Inserting Values into Dairy Businsess to Others Percentage Table

INSERT INTO Dairy_Business_Vs_Other_Percentage (Percent_Dairy_vs_other_businesses, Percent_other_businesses_to_Dairy)
SELECT
    (SELECT SUM(Percentage_of_businesses) FROM Percent_Dairy_vs_other_businesses) AS Percent_Dairy_vs_other_businesses,
    (SELECT SUM(Percentage_of_businesses) FROM Percent_other_businesses_to_Dairy) AS Percent_other_businesses_to_Dairy;

Select*
from Dairy_Business_Vs_Other_Percentage



-- Number of Dairy

create view number_Dairy as
Select count(TradingName) as Egg_Establishments_NI
From NewProject..APMS_NI_April23 
where All_Activities like '%Dairy%'



--All columns of Dairy businesses

Select *
From NewProject..APMS_NI_April23 
where All_Activities like '%Dairy%'
order by Town



--Create view to show Dairy business per locations

create view DairyBusiness_Per_Location as
Select AppNo,Address1,Town,Postcode,Country,TradingName, count(TradingName) over (partition by town) as Egg_Supplier_Count
From NewProject..APMS_NI_April23 
where All_Activities like '%Dairy%'



--create table to show the categoriy of each Dairy-business

create table Dairy_Activities(All_Activities nvarchar(255),Num_Establishments int)



--using cte to extract the content needed and copying them to table

with cte_ as
(
Select *
From NewProject..APMS_NI_April23 
where All_Activities like '%Dairy%'
)
insert into Dairy_Activities (All_Activities, Num_Establishments)
select distinct(All_Activities), count(All_Activities) As Num_Establishments
from cte_
group by All_Activities

select* 
from Dairy_Activities

delete 
from Dairy_Activities
where All_Activities like '%egg%'

update Dairy_Activities
set Num_Establishments = '27'
where All_Activities = 'Processing Plant (Dairy)'



--Number of Towns With Dairy Businesses In NI

create view Number_Town_Dairy_Business as
Select distinct(count(Town)) as NumTownEggsBusinesses
From NewProject..APMS_NI_April23 
where All_Activities like '%Dairy%'

