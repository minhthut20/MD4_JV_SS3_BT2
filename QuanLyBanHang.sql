use sales_management;
insert into customer values 
(1, "Minh Quan", 10),
(2, "Ngoc Oanh" , 20),
(3, "Hong Ha" , 50);
insert into orders values
(1, "2006-3-21", null, 1),
(2, "2006-3-23", null, 2),
(3, "2006-3-16", null, 1);
select * from orders;
select * from customer;
insert into product values
(1, "May giat", 3),
(2, "Tu Lanh", 5),
(3, "Dieu Hoa", 7),
(4, "Quat", 1),
(5, "Bep Dien", 2);
select * from product;
insert into order_detail values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

-- Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
select oID, oDate, oTotalPrice from orders;
-- Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select customer.cName, product.pName, order_detail.odQTY
from (((customer
join orders on customer.cID = orders.cID)
join order_detail on orders.oID = order_detail.oID)
join product on product.pID = order_detail.pID);
-- Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
select customer.cName
from customer
where not exists (select orders.cID from orders where customer.cID = orders.cID);
-- Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice) 
select orders.oID, orders.oDate, concat(order_detail.odQTY * product.pPrice) as Total
from (((customer
join orders on customer.cID = orders.cID)
join order_detail on orders.oID = order_detail.oID)
join product on product.pID = order_detail.pID)