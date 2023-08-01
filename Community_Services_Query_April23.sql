/*
Community Services Data Exploration

Skills used: Aggregate Functions, Creating Views, Converting Data Types, Sub Queries, Creating Table

*/

-- All Dimensions in data
select distinct([DIMENSION]) 
from dbo.csds_april23_exp_prov_data 

--Care contacts by service 
select [MEASURE_DESC], sum([MEASURE_VALUE]) as Measure_value,sum([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18,sum([MEASURE_VALUE_19_64])as MEASURE_VALUE_19_64,sum([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS
from dbo.csds_april23_exp_prov_data 
WHere [DIMENSION] = 'ServiceType' 
Group by [MEASURE_DESC]
order by 2 DESC

-- Total Number of referrals from Providers
select sum([MEASURE_VALUE]) as Total_Referrals,sum([MEASURE_VALUE_0_18]) as Total_Children_And_Young_People, sum([MEASURE_VALUE_19_64]) as Total_Adults_Ages_19_64, sum([MEASURE_VALUE_65_PLUS]) as Total_Adults_Ages_65_Plus 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalReferrals' and [ORG_LEVEL] = 'Provider' and [ORG_LEVEL] = 'Provider'

--View showing Total Number of referrals from Providers
create view Total_of_referrals_from_Providers as 
select sum([MEASURE_VALUE]) as Total_Referrals,sum([MEASURE_VALUE_0_18]) as Total_Children_And_Young_People, sum([MEASURE_VALUE_19_64]) as Total_Adults_Ages_19_64, sum([MEASURE_VALUE_65_PLUS]) as Total_Adults_Ages_65_Plus 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalReferrals' and [ORG_LEVEL] = 'Provider' and [ORG_LEVEL] = 'Provider'


select * from Total_of_referrals_from_Providers 

-- Total Number of referrals from Providers Relating to persons needing care
select sum([MEASURE_VALUE]) as Total_Referrals_Needing_Care,sum([MEASURE_VALUE_0_18]) as Total_Children_And_Young_People, sum([MEASURE_VALUE_19_64]) as Total_Adults_Ages_19_64, sum([MEASURE_VALUE_65_PLUS]) as Total_Adults_Ages_65_Plus 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalPatientWithReferral' and [ORG_LEVEL] = 'Provider' and [ORG_LEVEL] = 'Provider'

-- Copying Total Number of referrals from Providers Relating to persons needing care to a new table
create view Total_Referrals_Needing_Care_from_Providers as 
select sum([MEASURE_VALUE]) as Total_Referrals,sum([MEASURE_VALUE_0_18]) as Total_Children_And_Young_People, sum([MEASURE_VALUE_19_64]) as Total_Adults_Ages_19_64, sum([MEASURE_VALUE_65_PLUS]) as Total_Adults_Ages_65_Plus 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalPatientWithReferral'  and [ORG_LEVEL] = 'Provider' and [ORG_LEVEL] = 'Provider'

select * from Total_Referrals_Needing_Care_from_Providers

-- Total Number of Care Contacts
select sum([MEASURE_VALUE]) as Total_Number_of_Care_Contacts,sum([MEASURE_VALUE_0_18]) as Total_Children_And_Young_People, sum([MEASURE_VALUE_19_64]) as Total_Adults_Ages_19_64, sum([MEASURE_VALUE_65_PLUS]) as Total_Adults_Ages_65_Plus 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalCareContacts' and [ORG_LEVEL] = 'Provider'

--View showing Total Number of Care Contacts
create view Total_Number_of_Care_Contacts as 
select sum([MEASURE_VALUE]) as Total_Number_of_Care_Contacts,sum([MEASURE_VALUE_0_18]) as Total_Children_And_Young_People, sum([MEASURE_VALUE_19_64]) as Total_Adults_Ages_19_64, sum([MEASURE_VALUE_65_PLUS]) as Total_Adults_Ages_65_Plus 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalCareContacts' and [ORG_LEVEL] = 'Provider'

select * from Total_Number_of_Care_Contacts


--Number of Providers who Submitted Referral Data 
Select count([ORG_NAME]) as Number_of_Providers_who_Submitted_Referral_Data  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalReferrals' and [ORG_LEVEL] = 'Provider'

--View showing Number of Providers who Submitted Referral Data 
create view Number_Providers_Submitted_Referral_Data as 
select count([ORG_NAME]) as Number_of_Providers_who_Submitted_Referral_Data  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalReferrals' and [ORG_LEVEL] = 'Provider'

select * from Number_Providers_Submitted_Referral_Data

--Number of Providers who Submitted Care Contact Data 
Select count([ORG_NAME]) as Number_of_Providers_who_Submitted_Care_Contact_Data  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalCareContacts' and [ORG_LEVEL] = 'Provider'

-- View Showing Number of Providers who Submitted Care Contact Data 
create view Number_of_Providers_who_Submitted_Care_Contact_Data as 
select count([ORG_NAME]) as Number_of_Providers_who_Submitted_Care_Contact_Data  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalCareContacts' and [ORG_LEVEL] = 'Provider'

select* from Number_of_Providers_who_Submitted_Care_Contact_Data

--Patient with referrals Age Range and Gender 
select * from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'AgeYr_Referral_ReceivedDate_Gender_PatientWithReferrals' and [ORG_LEVEL] = 'Provider' 

-- View Showing Patient with referrals Age Range and Gender 
create view Patient_with_referrals_Age_Range_and_Gender  as 
select * 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'AgeYr_Referral_ReceivedDate_Gender_PatientWithReferrals' and [ORG_LEVEL] = 'Provider' 

select * from Patient_with_referrals_Age_Range_and_Gender

--Referrals Age Range and Gender 
select * 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'AgeYr_Referral_ReceivedDate_Gender_Referrals' and [ORG_LEVEL] = 'Provider' 

--View showing Referrals Age Range and Gender 
create view Referrals_Age_Range_and_Gender as 
select * 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'AgeYr_Referral_ReceivedDate_Gender_Referrals' and [ORG_LEVEL] = 'Provider' 

select * from Referrals_Age_Range_and_Gender


--Referral Reasons grouped by total and age group
select [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'PrimaryReferralReason' and [ORG_LEVEL] = 'Provider' group by [MEASURE_DESC]
order by 2 Desc

--View Showing Referral Reasons grouped by total and age group
create view Referral_Reasons_grouped_by_total_and_age_group as 
select [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'PrimaryReferralReason' and [ORG_LEVEL] = 'Provider' group by [MEASURE_DESC]

select * from Referral_Reasons_grouped_by_total_and_age_group

--Care Contact Age Range and Gender 
select * from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'Age_CareContactDate_Gender' and [ORG_LEVEL] = 'Provider' 
order by 12

--View Showing Care Contact Age Range and Gender 
create view Care_Contact_Age_Range_and_Gender as 
select * 
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'Age_CareContactDate_Gender' and [ORG_LEVEL] = 'Provider' 

select * from Care_Contact_Age_Range_and_Gender

--Care contact grouped by Consultation Medium
select [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'ConsultationMedium' and [ORG_LEVEL] = 'Provider' 
group by [MEASURE_DESC]
order by 2 Desc

--Creating table to copy values of care contacts by consultation so the percantage of care contacts by consultation can be calculated.

SELECT [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS   INTO Consultation_Medium FROM dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'ConsultationMedium' and [ORG_LEVEL] = 'Provider' 
group by [MEASURE_DESC]
GO
SELECT sum([MEASURE_VALUE]) FROM Consultation_Medium


-- Percentage of care contacts by consultation using Sub Queries
select MEASURE_DESC, [MEASURE_VALUE] *100.0 /(select SUM([MEASURE_VALUE]) from Consultation_Medium) as MeasureValuePerentage, [MEASURE_VALUE_0_18] *100.0 /(select SUM([MEASURE_VALUE_0_18]) from Consultation_Medium) as Ages_0_18Perentage,[MEASURE_VALUE_19_64] *100.0 /(select SUM([MEASURE_VALUE_19_64]) from Consultation_Medium) as Ages_19_64Perentage,[MEASURE_VALUE_65_PLUS] *100.0 /(select SUM([MEASURE_VALUE_65_PLUS]) from Consultation_Medium) as Ages_65_PlusPerentage
from Consultation_Medium
group by [MEASURE_DESC],[MEASURE_VALUE],[MEASURE_VALUE_0_18],[MEASURE_VALUE_19_64],[MEASURE_VALUE_65_PLUS]
order by 2 Desc

--View Showing Percentage of care contacts by consultation 
create view Percentage_of_care_contacts_by_consultation_medium as 
select MEASURE_DESC, [MEASURE_VALUE] *100.0 /(select SUM([MEASURE_VALUE]) from Consultation_Medium) as MeasureValuePerentage, [MEASURE_VALUE_0_18] *100.0 /(select SUM([MEASURE_VALUE_0_18]) from Consultation_Medium) as Ages_0_18Perentage,[MEASURE_VALUE_19_64] *100.0 /(select SUM([MEASURE_VALUE_19_64]) from Consultation_Medium) as Ages_19_64Perentage,[MEASURE_VALUE_65_PLUS] *100.0 /(select SUM([MEASURE_VALUE_65_PLUS]) from Consultation_Medium) as Ages_65_PlusPerentage
from Consultation_Medium
group by [MEASURE_DESC],[MEASURE_VALUE],[MEASURE_VALUE_0_18],[MEASURE_VALUE_19_64],[MEASURE_VALUE_65_PLUS]
--order by 2 Desc

select * from Percentage_of_care_contacts_by_consultation_medium 


--View Showing Care contact grouped by Consultation Medium
create view Care_contact_grouped_by_Consultation_Medium as 
select [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'ConsultationMedium' and [ORG_LEVEL] = 'Provider' 
group by [MEASURE_DESC]

select * from Care_contact_grouped_by_Consultation_Medium

--Consultation Type
Select [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS   
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'ConsultType' and [ORG_LEVEL] = 'Provider'
group by [MEASURE_DESC]

--View Showing Consultation Type
create view Consultation_Type as 
Select [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'ConsultType' and [ORG_LEVEL] = 'Provider'
group by [MEASURE_DESC]


select * from Consultation_Type 

--Source of referrals
Select [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'SourceOfReferral' and [ORG_LEVEL] = 'Provider'
group by [MEASURE_DESC]

--View showing source of Referrals
create view Source_of_referrals as 
Select [MEASURE_DESC], SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'SourceOfReferral' and [ORG_LEVEL] = 'Provider'
group by [MEASURE_DESC]

select * from Source_of_referrals

--Total Patient With Care Contacts
select SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalPatientWithCareContact' and [ORG_LEVEL] = 'Provider' 
--order by 12

-- View Showing Total Patient With Care Contacts
create view Total_Patient_With_Care_Contact	as 
select SUM([MEASURE_VALUE]) as MEASURE_VALUE,SUM([MEASURE_VALUE_0_18]) as MEASURE_VALUE_0_18 ,SUM([MEASURE_VALUE_19_64]) as MEASURE_VALUE_19_64, SUM([MEASURE_VALUE_65_PLUS]) as MEASURE_VALUE_65_PLUS  
from dbo.csds_april23_exp_prov_data 
where [DIMENSION] = 'TotalPatientWithCareContact' and [ORG_LEVEL] = 'Provider' 


select * from Total_Patient_With_Care_Contact

--HV Appointments
select * from dbo.csds_apr23_exp_hv_data 
where [COUNT_OF] = 'children'

select [MEASURE],sum([MEASURE_VALUE]) as MEASURE_VALUE 
from dbo.csds_apr23_exp_hv_data 
where [COUNT_OF] = 'children' and [MEASURE] like 'Count%' and [ORG_LEVEL] != 'Local Authority of Residence (Upper)'and[ORG_LEVEL] !='National' 
group by [MEASURE]
order by 2 Desc

