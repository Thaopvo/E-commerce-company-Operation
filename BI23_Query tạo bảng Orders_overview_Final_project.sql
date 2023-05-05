/*Tạo một bảng mới thể hiện tổng quan đơn hàng: Orders_overview */

SELECT S.*, 
ItemNumber,					/*Số lượng sản phẩm trong đơn hàng (tính bằng thứ tự cao nhất của 1 item có cùng order_id)*/
Order_value,				/*Tổng giá trị đơn hàng mà khách hàng phải chi trả bao gồm cả phí ship*/
Sale,					/*Doanh thu từ đơn hàng*/		
OID.freight_value
INTO Fact_orders_table
FROM orders_dataset S
LEFT JOIN order_items_dataset OID
ON OID.order_id= S.order_id
LEFT JOIN products_dataset P
ON P.product_id= OID.product_id
RIGHT JOIN (
		SELECT od.order_id,
		MAX(COALESCE (order_item_id,0)) ItemNumber,
		SUM(COALESCE(price,0)) Sale,  
		SUM(COALESCE(price,0) + COALESCE(freight_value,0)) Order_value 
		FROM orders_dataset od
		LEFT JOIN order_items_dataset oi ON od.order_id= oi.order_id
		group by od.order_id
		) A
ON A.order_id= S.order_id




