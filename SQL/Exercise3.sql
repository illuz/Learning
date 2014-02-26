-- Exercise3
-- (1)

INSERT INTO Product
VALUES('P0100001', '电视', '电器', 3000),
	('P0100002', '空调', '电器', 2000),
	('P0100003', '洗衣机', '电器', 1200),
	('P0200001', '奶茶', '食品', 3),
	('P0200002', '牛奶', '食品', 2),
	('P0200003', '面包', '食品', 2.5),
	('P0200004', '糖果', '食品', 3.5),
	('P0300001', '衣服', '衣物', 109),
	('P0300002', '裤子', '衣物', 188),
	('P0300003', '鞋子', '衣物', 89.8),
	('P0400001', '铅笔', '文具', 0.58),
	('P0400002', '笔记本', '文具', 0.88),
	('P0500001', '手机', '数码', 988),
	('P0500002', '相机', '数码', 1588);
	


INSERT INTO Member
VALUES ('M20110115001', '王小军', '1', '13000000001', '2011-1-15', '乌龙江大道1号'),
	('M20110322002', '王强', '0', '13800302301', '2011-3-22', '科技有限公司'),
	('M20120124001', '张小军', '0', '13200200323', '2012-1-24', '新东方学校'),
	('M20120124002', '张立立', '1', '18935660212', '2012-1-24', '旗山大道235号'),
	('M20120124003', '林大海', '0', '13607260823', '2012-1-24', '新华学校'),
	('M20120525004', '黄梅莹', '2', NULL, '2012-5-25', NULL),
	('M20121213005', '张小东', '2', '18923360121', '2012-12-13',' 东方小区'),
	('M20121213006', '陈国强', '2', '18935660110', '2012-12-13', '五一大厦3号'),
	('M20130215001', '高代鹏', '1', NULL, '2013-2-15', NULL),
	('M20130215002', '陈诗杰', '0', NULL, '2013-2-15', NULL),
	('M20130215003', '喻自强', '0', '15602328213', '2013-3-23', NULL);



INSERT INTO Employee
VALUES ('E2011040301', '王强', '销售员', '888888'),
	('E2011040702', '张宝强', '收银员', '888888'),
	('E2011110701', '李虹冰', '收银员', '888888'),
	('E2012030101', '黄梅莹', '销售员',' 888888'),
	('E2012030102', '陈诗杰', '销售员', '888888'),
	('E2012030103', '吴浮萍', '经理','888888'),
	('E2012030105', '李红兵', '销售员', '888888');


INSERT INTO Sale (Sno, Eno, Mno, SaleDate)
VALUES ('S201104030001', 'E2011040702', 'M20120124001', '2012/1/3'),
	('S201104070002', 'E2011040702', 'M20110115001', '2012/4/7'),
	('S201111070001', 'E2011040702', 'M20121213006', '2012/4/8'),
	('S201111070011', 'E2011110701', 'M20120124002', '2012-3-5'),
	('S201203010001', 'E2011040702', 'M20121213005', '2012/5/1'),
	('S201203010002', 'E2011040702', 'M20130215003', '2012/5/8'),
	('S201203010003', 'E2011110701', 'M20130215003', '2012/5/1'),
	('S201203110004', 'E2011110701', 'M20130215003', '2012/7/11'),
	('S201203130005', 'E2011110701', 'M20130215001', '2012/7/13'),
	('S201204110001', 'E2011110701', 'M20120525004', '2012-7-17'),
	('S201212170001', 'E2011040702', 'M20120124002', '2012/10/17'),
	('S201303010001', 'E2011110701', 'M20120124002', '2013/01/01'),
	('S201302220001', 'E2011110701', 'M20130215003', '2012/7/1');



INSERT INTO SaleDetail 
VALUES ('S201104030001', 'P0200001', 3, 1),
	('S201104030001', 'P0300001', 1, 0.5),
	('S201104070002', 'P0300001', 1, 0.95),
	('S201104070002', 'P0300002', 1, 0.95),
	('S201111070001', 'P0400001', 5, 3),
	('S201111070011', 'P0300001', 1, 1),
	('S201203010001', 'P0200001', 20, 0.95),
	('S201203010001', 'P0200003', 6, 1),
	('S201203010002', 'P0200001', 1, 1),
	('S201203010003', 'P0200001', 1, 1),
	('S201203010003', 'P0200002', 1, 1),
	('S201203010003', 'P0400001', 1, 1),
	('S201203110004', 'P0100002', 1, 0.95),
	('S201203110004', 'P0100001', 1, 1),
	('S201203130005', 'P0500001', 1, 1),
	('S201203130005', 'P0500002', 1, 1),
	('S201204110001', 'P0500001', 1, 1),
	('S201204110001', 'P0500002', 1, 1),
	('S201204110001', 'P0500004', 1, 1),
	('S201212170001', 'P0500002', 1, 1),
	('S201303010001', 'P0400001', 8, 1),
	('S201303010001', 'P0400002', 8, 1),
	('S201303010001', 'P0200004', 5, 1),
	('S201302220001', 'P0400001', 1, 1),
	('S201302220001', 'P0400002', 1, 1),
	('S201302220001', 'P0200004', 8, 1);


-- (2)

DELETE FROM Employee 
WHERE Eno = 'E2012030105'


-- (3)

UPDATE Member
SET Maddr = '乌龙江大道'
WHERE Maddr = '旗山大道'


-- (4)

UPDATE SaleDetail
SET Discount = 0.95
FROM SaleDetail, Product
WHERE SaleDetail.Pno = Product.Pno AND Pprice > 1000

UPDATE SaleDetail
SET Discount = 0.95
FROM SaleDetail, Product
WHERE SaleDetail.Pno = Product.Pno AND Pprice > 500 AND Pprice <= 1000


-- (5)

UPDATE Sale
SET Ssum = 
		(SELECT SUM(QTY * Pprice * Discount)
		 FROM Product, SaleDetail
		 WHERE Product.Pno = SaleDetail.Pno AND Sale.Sno = SaleDetail.Sno
		)


SELECT * FROM Sale, SaleDetail
SELECT * FROM SaleDetail