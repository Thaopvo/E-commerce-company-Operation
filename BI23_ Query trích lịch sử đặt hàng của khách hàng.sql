/*Tạo một bảng dim_customer*/

SELECT customer_id,customer_city, customer_state, a.customer_unique_id,
history_buying_times,			/*Số lần mua hàng trên hệ thống*/
Customer_Relationship			/*Mức độ thân thiết của khách hàng*/
INTO dim_customers
FROM customers_dataset s
RIGHT JOIN (
			SELECT count(Distinct order_id) history_buying_times, 
				customer_unique_id, 
				CASE
				WHEN count(Distinct order_id) = 1 THEN 'New' /*Mua hàng lần đầu được coi là khách hàng mới*/
				ELSE 'Close' /*Khách được ghi nhận mua hàng từ 2 lần trở lên được coi là Khách hàng thân thiết*/
				END AS Customer_Relationship 
				FROM customers_dataset C
			LEFT JOIN Orders_overview O
			on C.customer_id= O.customer_id
			Group by customer_unique_id
			) a
ON a.customer_unique_id= s.customer_unique_id

