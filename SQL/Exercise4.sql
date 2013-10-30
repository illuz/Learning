-- Exercise4
-- 1 查询所有会员的姓名、地址和电话

SELECT Mname, Maddr, TEL
FROM Member

-- 2 查询所有金牌会员的信息

SELECT *
FROM Member
WHERE Mclass = '2'

-- 3 查询名字中姓 “王”的会员的姓名、地址和电话

SELECT Mname, Maddr, TEL
FROM Member
WHERE Mname LIKE '王%'

-- 4 查询名字中含有“强”的名字只有两个字的员工

SELECT *
FROM Member
WHERE Mname LIKE '强%' OR Mname LIKE '%强'

-- 5 查询地址中含有“学校”或“公司”且电话号码不为空的会员，显示其姓名，地址和电话
--   并将以‘金牌会员’，‘银牌会员’或‘普通会员’表示该会员的类型。

SELECT Mname, Maddr, TEL
    REPLACE(REPLACE(REPLACE(Mclass, '0', '普通会员'), '1', '银牌会员'), '2', '金牌会员')
FROM Member
WHERE (Maddr LIKE '%学校%' OR Maddr LIKE '%公司%')
    AND TEL is NOT NULL

-- 6 找出购买了‘奶茶’的销售日期

SELECT SaleDate
FROM Sale, SaleDetail, Product
WHERE Sale.Sno = SaleDetail.Sno AND SaleDetail.Pno = Product.Pno 
    AND Product.Pname = '奶茶'

--7 找订单金额在50到100之间或者150到200之间的销售号

SELECT DISTINCT Sno
FROM Sale
WHERE 
			( Ssum > 50 AND Ssum <= 100)
			OR
			( Ssum > 150 AND Ssum <= 200)

-- 8 找出同一天办卡的会员的办卡日期和姓名

SELECT DISTINCT A.Mname, B.Createdate
FROM Member A, Member B
WHERE A.Mname != B.Mname AND A.Createdate = B.Createdate

-- 9 找出既买了奶茶又买了面包的客户名

SELECT Mname
FROM Member 
WHERE EXISTS
	(
		SELECT *
		FROM Sale, SaleDetail, Product
		WHERE Sale.Sno = SaleDetail.Sno AND SaleDetail.Pno = Product.Pno
		AND Product.Pname = '奶茶' AND Member.Mno = Sale.Mno
	)
	AND EXISTS	(
		SELECT *
		FROM Sale, SaleDetail, Product
		WHERE Sale.Sno = SaleDetail.Sno AND SaleDetail.Pno = Product.Pno 
		AND Product.Pname = '面包' AND Member.Mno = Sale.Mno
	)

-- 10 找出实际销售单价大于100的商品的商品名，销售数量和折扣率

SELECT Pname, SUM(QTY), Discount
FROM Product, Sale, SaleDetail
WHERE Product.Pno = SaleDetail.Pno
	AND SaleDetail.Sno = Sale.Sno 
	AND Product.Pprice * SaleDetail.Discount > 100
GROUP BY Pname, Discount

-- 11 查找购买过‘衣服’的会员名、会员级别、购买时间，并按照购买日期从近到远排序

SELECT Mname, REPLACE(REPLACE(REPLACE(Mclass, '0', '普通会员'), '1', '银牌会员'), '2', '金牌会员'), SaleDate
FROM Member, SaleDetail, Sale, Product
WHERE SaleDetail.Pno = Product.Pno
	AND Pname = '衣服' 
	AND Sale.Sno = SaleDetail.Sno 
	AND Member.Mno = Sale.Mno
ORDER BY SaleDate DESC

-- 12 查找‘王小军’所买的所有商品名称，时间和数量

SELECT Pname, SaleDate, QTY
FROM Member, Product, Sale, SaleDetail
WHERE Mname = '王小军'
	AND Sale.Mno = Member.Mno
	AND Product.Pno = SaleDetail.Pno
	AND Sale.Sno = SaleDetail.Sno

-- 13 查询与‘张立立’电话号码前8位相同的会员名和电话

SELECT B.Mname, B.TEL
FROM Member A, Member B
WHERE A.Mname = '张立立' AND B.Mname != '张立立'
	AND LEFT(A.TEL, 8) = LEFT(B.TEL, 8)

-- 14 卖出的‘奶茶’的数量和平均价格

SELECT SUM(QTY), SUM(QTY * Discount * Pprice) / SUM(QTY)
FROM Product, SaleDetail
WHERE Product.Pname = '奶茶'
	AND Product.Pno = SaleDetail.Pno

-- 15 2012年度没有购物记录的金牌会员的名称和电话

SELECT Mname, TEL
FROM Member
WHERE Mclass = 2
	AND NOT EXISTS (
		SELECT *
		FROM Sale, SaleDetail
		WHERE Sale.Sno = SaleDetail.Sno
			AND YEAR(Sale.SaleDate) = 2012
			AND Sale.Mno = Member.Mno
		)