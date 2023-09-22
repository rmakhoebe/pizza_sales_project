
-----------------------------------------------WORKING ON PRIMARY KPIs-------------------------------------------

--TOTAL REVENUE--
SELECT SUM(total_price) as Total_Revenue
FROM pizza_sales;

--AVERAGE ORDER VALUE--
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS Average_Order_Value
FROM pizza_sales;

--TOTAL PIZZAs SOLD--
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

--TOTAL ORDERS--
SELECT COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales;

--AVERAGE PIZZAS PER ORDER--
SELECT CAST(CAST(SUM(quantity) AS DECIMAL)/ 
	CAST(COUNT(DISTINCT order_id) AS DECIMAL) AS DECIMAL(10,2)) as Average_Pizzas_Per_Order
FROM pizza_sales;

------------------------------------CHARTS Requirements Solutions----------------------------------------

--Daily Trend for Total Orders--
SELECT  DATENAME(Weekday,order_date) AS order_day, COUNT(DISTINCT order_id) AS  Total_Orders_by_Day
	FROM pizza_sales
	GROUP BY DATENAME(Weekday,order_date);

--Hourly Trend for Total Orders/ Total Pizzas Sold--
SELECT  DATEPART(HOUR,order_time) AS order_hour, SUM(quantity) as total_pizzas_sold, COUNT(DISTINCT order_id) AS  Total_Orders_by_Day
	FROM pizza_sales
	GROUP BY DATEPART(HOUR,order_time)
	ORDER BY 1;

--Weekly Trend for Total Orders/ Total pizzas Sold
SELECT  DATEPART(WEEK,order_date) AS week_number, COUNT(DISTINCT order_id) AS  Total_Orders_by_Day
	FROM pizza_sales
	GROUP BY DATEPART(WEEK,order_date)
	ORDER BY 1;

	Select*
	From pizza_sales

--Monthly Trend for Total Orders--
SELECT  DATENAME(mm,order_date) AS order_month, COUNT(DISTINCT order_id) AS Total_Orders_by_Month
	FROM pizza_sales
	GROUP BY DATENAME(mm,order_date)
ORDER BY Total_Orders_by_Month DESC;


--Percentage of Sales per Pizza category--
SELECT pizza_category, 
		CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_orders_per_category,
		CAST(SUM(total_price) *100.0/
		(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT                                                                                                                                 
FROM pizza_sales
GROUP BY pizza_category;


--Percentage of Sales by Pizza size--
SELECT  pizza_size, CAST(SUM(total_price)AS DECIMAL(10,2)) AS Total_Sales,
		CAST(SUM(total_price)* 100.0 /
			(SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2))  AS Sales_Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY 3 DESC;

--Total Pizzas Sold by pizza Category--
SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category;


------------------------------Top/Bottom 5 Best Sellers by Revenue, Total Quantity and Total Oders----------------------------

--Top 5 by Revenue--
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2))AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;

--Bottom 5 by Revenue--
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2))AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2;

--Top 5 by quantity--
SELECT TOP 5 pizza_name, CAST(SUM(quantity) AS DECIMAL(10,2))AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;

--Bottom 5 by quantity--
SELECT TOP 5 pizza_name, CAST(SUM(quantity) AS DECIMAL(10,2))AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2;

--Top 5 by Total Orders--
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;

--Bottom 5 by Total Orders--
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2;



