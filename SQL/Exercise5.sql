-- Exercise5
-- 实验五  数据查询——复杂查询

-- 1 比会员号是'M20120003'的会员在2012年3月每个销售单的收银金额
I--  大的会员号，会员名及金额；

SELECT DISTINCT A.Mno, Mname, Ssum
FROM Member, Sale A
WHERE Member.Mno = A.Mno AND Ssum > 
	(SELECT MAX(Ssum)
	FROM Sale B
	WHERE B.Mno = 'M20120124002' AND YEAR(SaleDate) = 2012 AND MONTH(SaleDate) = 3
	)

-- 2 分别使用左外连接、右外连接、完整外部连接查询
--   单价大于100的商品的商品名，销售数量和销售价格
--   并比较分析检索的结果

SELECT 

-- 3 找出会员的购买记录
--   要求显示会员编号，会员名，会员级别，购买时间，购买数量，购买单价
--   日期以 yyyy-mm-dd格式显示（提示，需要用到函数）

SELECT Member.Mno, Mname, Mclass, CAST(SaleDate AS date) AS 'date' , QTY, Pprice
FROM Member, Sale, SaleDetail, Product
WHERE Member.Mno = Sale.Mno AND Product.Pno = SaleDetail.Pno
	AND Sale.Sno = SaleDetail.Sno

-- 4 查找在2012年3月中有购物记录的会员编号、名称和订单总额。

SELECT Member.Mno, Mname, SUM(QTY * Discount * Pprice)
FROM Member, Sale, SaleDetail, Product
WHERE Member.Mno = Sale.Mno AND Product.Pno = SaleDetail.Pno
	AND Sale.Sno = SaleDetail.Sno
GROUP BY Member.Mno, Mname

-- 5 找出普通会员所购买的，单个订单金额大于等于2000的会员号，会员名和购买时间

SELECT Member.Mno, Mname, SaleDate
FROM Member, Sale
WHERE Member.Mno = Sale.Mno AND Member.Mclass = 0 AND Ssum >= 2000

-- 6 查找2012年度所销售的‘电器’部门的商品的销售总额

SELECT SUM(QTY * Discount * Pprice)
FROM Sale, SaleDetail, Product
WHERE Pclass = '电器' AND Sale.Sno = SaleDetail.Sno
	AND SaleDetail.Pno = Product.Pno

-- 7 查找从来没有购买‘电器’部门的商品，却是‘银牌会员’的会员名

SELECT Mname
FROM Member
WHERE Member.Mclass = 1 AND NOT EXISTS (
	SELECT *
	FROM Product, SaleDetail, Sale
	WHERE Product.Pno = SaleDetail.Pno AND Pclass = '电器'
		AND Sale.Sno = SaleDetail.Sno AND Member.Mno = Sale.Mno
	)

-- 8 查找一次销售（同一销售时间，同一会员）
--   用100元以内的价格购买到最多的商品数量和购买时间



-- 9 查询单个销售单里面包含3种以上商品
--   且每种商品都买5件（包括5件）以上销售单号和时间


-- 10 各个部门商品的平均价格和商品的种类数量


-- 11 按照年份和月份输出每个会员的购物金额（提示，需要用到函数）


-- 12 所有金牌会员中购物金额最多的人的购物人的姓名和电话


-- 13 查询2012年度购物金额比所有的银牌会员都购物多的金牌会员


-- 14 查找2012年5月至少购物2次的会员号和会员名


-- 15 查询累计销售金额最大的客户名称和总购物金额
-- 16 超出购物单金额大于100的购物单及其会员类型和购物时间；
-- 17 找出每个月份销售额的平均值，并按照月份排序；
-- 18 2012年没有购物记录的金牌会员的会员名和电话号码；
-- 19 计算每一商品每月的销售金额总和
--    并将结果首先按销售月份然后按订货金额降序排序输出。

-- 20 查询2012年度各种不同类型的会员购物总金额最多的会员名和电话
--    （即购物总金额最多的金牌会员，银牌会员，普通会员）
-- 21 计算不同类型的会员的数量；
-- 22 查找2012年买了‘电器’、‘食品’、‘衣物’和‘文具’这四个部门的商品中
--    两个或两个以上商品的销售记录；
-- 23 查询从来没有买过‘电器’部门商品的金卡会员
-- 24 查询购买过所有文具的会员名和电话；
-- 25 查询购买过‘张立立’所购买过的所有商品的会员名和商品名