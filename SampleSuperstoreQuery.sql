-- =============================================================================
-- Project: Sample Superstore Data Analysis
-- Description: Advanced T-SQL Script covering aggregation, CTEs, window functions, 
--              business logic segmentation (discount tiers), and Stored Procedures.
-- =============================================================================


-- Query 1: Filtering high-discount transactions in the Central region
 --select [City],ROUND( sum([Sales]),2) as Sales,[Sub_Category],ROUND( ([Discount]),2) as Discount
 --from dbo.SampleSuperstoreProject 
 --where [Region] = 'Central' and [Discount] > 0.5
 --group by [City],[Sub_Category],[Discount]
 --order by [Sales] desc


-- Query 2: Category performance aggregated with threshold filtering using HAVING
-- select [Category],ROUND( sum([Sales]),2) as TotalSales,ROUND( sum ([Profit]),2) as TotalProfit,
-- round (avg([Discount]),2) as AvgDiscount
-- from dbo.SampleSuperstoreProject
-- group by[Category]
-- having sum([Sales]) >200000


-- Query 3: Identifying the top 5 least profitable sub-categories using a CTE
-- with cte as  (
-- select Sub_Category ,sum([Profit]) as totalPtofit
-- from dbo.SampleSuperstoreProject
-- group by Sub_Category

-- ) 
-- select top 5 Sub_Category,totalPtofit
-- from cte 
-- order by 2 asc


-- Query 4: Ranking sub-categories by profitability within each category using Window Functions (RANK & PARTITION BY)
-- with cte as (

-- select Category ,Sub_Category,SUM([Profit]) as totalProfit
-- from dbo.SampleSuperstoreProject
-- GROUP BY Category ,Sub_Category)

-- select Category ,Sub_Category ,totalProfit,RANK() OVER (PARTITION BY [Category] order by  totalProfit asc) as rank
-- from cte ;


-- Query 5: Ranking profitable sub-categories by sales performance within each region
-- with cte as (
-- select[Region],[Sub_Category] ,sum ([Sales]) as sales
-- from dbo.SampleSuperstoreProject
-- where Profit>0
-- group by [Region],[Sub_Category]
-- )
-- select [Region],[Sub_Category],sales,RANK () over (PARTITION BY [Region]   order by sales)as rank
-- from cte 


-- Query 6: Evaluating profitability and profit margins across different shipping modes with division-by-zero protection
-- with cte as (
-- select Ship_Mode ,round (sum([Sales]),2)as sales,round (sum([Profit]),2) as profit
-- from dbo.SampleSuperstoreProject
-- group by Ship_Mode)

-- select Ship_Mode ,sales,profit ,ROUND((profit / NULLIF(sales, 0)) * 100, 2) AS ProfitMarginPercentage
-- from cte
-- order by 4 desc


-- Query 7: Identifying the top 5 states by overall profitability
-- with cte as (
-- select s.State, round (sum(s.Sales),2)as totalSales,round (sum(s.Profit),2)as totalProfit
-- from dbo.SampleSuperstoreProject s
-- group by  s.State
--)
-- select  top 5 State,totalSales,totalProfit
-- from cte
-- order by 3 desc 


-- Query 8: Advanced discount tier analysis measuring business volume, revenue, profitability, and margins
-- with cte as (
-- select case when Discount=0 then 'No discount' 
-- when Discount >0 and Discount <= 0.2 then  'Litle discount'
-- when Discount > 0.2 and Discount<=0.5 then 'Good discount'
-- else 'High discount'
-- end as DiscountTier ,Sales,Profit

-- from dbo.SampleSuperstoreProject


-- ),

-- cte1 as (
-- select  DiscountTier, count(*) as totalBusiness, 
-- round (sum(Sales),2)as totalSales,round (sum(Profit),2)as totalProfit
-- from cte
-- group by DiscountTier
-- )

-- select DiscountTier,totalBusiness,totalSales,totalProfit
--,round(totalProfit/ nullif(totalSales,0),2) as ProfitMarginPercentage
-- from cte1
-- order by 1


-- =============================================================================
-- Stored Procedure: sp_GetPerformanceByCategory
-- Description: Accepts a category parameter and returns sub-category performance 
--              metrics sorted by profitability.
-- =============================================================================
--create proc sp_GetPerformanceByCategory 
--    @CategoryName nvarchar (30)
--as
--begin 
--    select 
--        [Sub_Category],
--        round(sum(Sales), 2) as totalSales,
--        round(sum(Profit), 2) as totalProfit
--    from dbo.SampleSuperstoreProject
--    where [Category] = @CategoryName
--    group by [Sub_Category]
--    order by 3 desc 
--end
--go

-- Execution example for the Stored Procedure
--EXEC sp_GetPerformanceByCategory @CategoryName = 'Office Supplies';