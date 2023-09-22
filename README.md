# pizza_sales_project
Client had asked for help to analyze key indicators for their pizza sales data to gain insights into the business performance. 

PIZZA SALES REPORT

PROBLEM STATEMENT
We need to analyze key indicators for our pizza sales data to gain insights into our business performance. Specifically, we want to calculate the following metrics:

KPI’s REQUIREMENT
1.	Total Revenue: The sum of the total price of all pizza orders.
2.	Average Order Value: The average amount spent per order, calculated by dividing the total revenue by the total number of orders.
3.	Total Pizzas Sold: The sum of the quantities of all pizzas sold.
4.	Total Orders: The total number of orders placed.
5.	Average Pizzas per Order: The average number of pizza sold per order, calculated by dividing the total number of pizzas sold by the total number of orders.
CHARTS REQUIREMENT
We would like to visualize various aspects of our pizza sales data to gain insights and understand key trends. We have identified the following requirements for creating charts:
1.	Daily Trend for Total Orders: Create a bar chart that displays the daily trend of total orders over a specific time period. This chart will help us identify any patterns or fluctuations in order volumes on a daily basis.
2.	Hourly Trend for Total Orders: Create a bar chart that illustrates the hourly trend of total orders and total pizzas sold throughout the day. This chart will allow us to identify peak hours or periods of high order activity.
3.	Weekly Trend for Total Orders: Create a chart that illustrates the weekly trend of total orders throughout the weeks. 
4.	Percentage of Sales by Pizza Category: Create a pie/doughnut chart that shows the distribution of sales across different pizza categories. This chart will provide insights into the popularity of various pizza categories and their contribution to overall sales.
5.	Percentage of Sales by Pizza Size: Generate a pie chart that represents the percentage of sales attributed to different pizza sizes. This chart will help us understand customer preferences for pizza sizes and their impact on sales.
6.	Total Pizzas Sold by Pizza Category: Create a funnel chart that represents the total number of pizza sold each pizza category. This chart will allow us to compare the sales performance of different pizza categories.
7.	Top 5 Best Sellers by Revenue, Total Quantity and Total Orders: Create a bar chart highlighting the top 5 best-selling pizzas based on the Revenue, Total Quantity, and Total Orders. This chart will help us identify the most popular pizza options.
8.	Bottom 5 Best Sellers by Revenue, Total Quantity and Total Orders: Create a bar chart highlighting the bottom 5 worst-selling pizzas based on the Revenue, Total Quantity, and Total Orders. This chart will help us identify the most popular pizza options.


SQL SOLUTIONS

KPIs
1.	Total Revenue:
SELECT SUM(total_price) as Total_Revenue
FROM pizza_sales

![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/9f52f085-025a-42fc-85b2-df7f967070c6)

 
2.	Average Order Value:
SELECT ROUND(SUM(total_price)/COUNT(DISTINCT order_id),2) AS Average_Order_Value
FROM pizza_sales
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/c831580f-9b92-4337-a839-b380a1dad79f)

 
3.	Total Pizzas Sold:
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales

 ![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/84381f72-f629-49bc-ad4f-4daac600defc)


4.	Total Orders:
SELECT COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
 
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/a605f39a-e536-42d7-87e1-b38a54213a8c)




5.	Average Pizzas per Order:
SELECT CAST(CAST(SUM(quantity) AS DECIMAL)/ 
	CAST(COUNT(DISTINCT order_id) AS DECIMAL) AS DECIMAL(10,2)) as Average_Pizzas_Per_Order
FROM pizza_sales
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/5bd1893a-c9c7-4747-9338-4ab2a30d0755)

 
CHARTS REQUIREMENTS Solutions
1.	Hourly Trend for Total Orders and Total Pizzas sold
SELECT  DATEPART(HOUR,order_time) AS order_hour, SUM(quantity) as total_pizzas_sold, COUNT(DISTINCT order_id) AS  Total_Orders_by_Day
	FROM pizza_sales
	GROUP BY DATEPART(HOUR,order_time)
	ORDER BY DATEPART(HOUR, order_time);
 
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/c3c3a84c-3821-48f4-959f-b1597913d0ec)





2.	Daily Trend for Total Orders
SELECT  DATENAME(Weekday,order_date) AS order_day, COUNT(DISTINCT order_id) AS  Total_Orders_by_Day
	FROM pizza_sales
	GROUP BY DATENAME(Weekday,order_date)
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/7819166f-7a55-415c-870e-24554eed1e76)

 

3.	Weekly Trend for Total Orders
SELECT  DATEPART(WEEK,order_date) AS week_number, COUNT(DISTINCT order_id) AS  Total_Orders_by_Day
	FROM pizza_sales
	GROUP BY DATEPART(WEEK,order_date)
	ORDER BY 1;
 
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/35c1ea27-a9b6-435a-a308-98cf4a224dcc)




4.	Monthly Trend for Total Orders
SELECT  DATENAME(mm,order_date) AS order_month, COUNT(DISTINCT order_id) AS Total_Orders_by_Month
	FROM pizza_sales
	GROUP BY DATENAME(mm,order_date)
ORDER BY Total_Orders_by_Month DESC
 
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/7455f5c4-0796-4579-a94c-49b68ae36f69)


5.	Percentage of Sales by Pizza Category:
SELECT pizza_category, 
		CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_orders_per_category,
		CAST(SUM(total_price) *100.0/
(SELECT SUM(total_price)
						FROM pizza_sales) AS DECIMAL(10,2)) AS PCT                                                                                                                                 
FROM pizza_sales
GROUP BY pizza_category;

 
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/d09b30d0-4e0b-49c8-80e9-4c31046da90d)



6.	Percentage of Sales by Pizza Size:
SELECT  pizza_size, CAST(SUM(total_price)AS DECIMAL(10,2)) AS Total_Sales,
	CAST(SUM(total_price)* 100.0 /
(SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2))  AS Sales_Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY 3 DESC;
 
![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/6c1f1fc1-a79e-4bf1-88a7-fd52ad03fa85)


7.	Total Pizzas Sold by Pizza Category:
SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category;

![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/90471eb5-96b5-4087-891c-4634bccfbba6)

 
8.	Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

Top 5 by Revenue
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2))AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;

 ![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/736e5f4d-e035-477f-98be-eeb2a229e216)


Bottom 5 by Revenue
SELECT TOP 5 pizza_name, CAST(SUM(total_price) AS DECIMAL(10,2))AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2;
 ![image](https://github.com/rmakhoebe/pizza_sales_project/assets/97227644/4d6f3f4f-14e8-48fe-b9bf-5dc0c856d9a2)


Top 5 by Quantity
SELECT TOP 5 pizza_name, CAST(SUM(quantity) AS DECIMAL(10,2))AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;
 



Bottom 5 by Quantity
SELECT TOP 5 pizza_name, CAST(SUM(quantity) AS DECIMAL(10,2))AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 ASC;

 

Top 5 by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC;
 

Bottom 5 by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 ASC;
 
