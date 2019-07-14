SET NAMES UTF8;
DROP DATABASE IF EXISTS cake;
CREATE DATABASE cake CHARSET=UTF8;
USE cake;

/**蛋糕商城用户**/
DROP TABLE IF EXISTS cake_users;
CREATE TABLE cake_users(
	uid BIGINT(32) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '用户id(主键)',	
	username VARCHAR(16) DEFAULT NULL COMMENT '昵称',
	realname VARCHAR(16) DEFAULT NULL COMMENT '真实姓名',
	upassword VARCHAR(64) NOT NULL COMMENT '密码',
	usex BOOL DEFAULT NULL COMMENT '性别',
	uage INT(3) DEFAULT NULL COMMENT '年龄',
	usignd VARCHAR(45) DEFAULT NULL COMMENT '签名',
	uphoto VARCHAR(255) DEFAULT NULL COMMENT '头像存放图片的地址',
	utelephone VARCHAR(11) DEFAULT NULL COMMENT '手机号码',
	umarry INT(1) DEFAULT NULL COMMENT '婚恋状况',
	umycity VARCHAR(64) DEFAULT NULL COMMENT '所在地',
	umyaddress VARCHAR(255) DEFAULT NULL COMMENT '详细地址',
	utrade VARCHAR(10) DEFAULT NULL COMMENT '所在行业',
	uincome DECIMAL(30,2) DEFAULT NULL COMMENT '收入',
	ucreate_time DATETIME DEFAULT NULL COMMENT '创建时间',
	ustatus INT(1) DEFAULT NULL COMMENT '状态'
);

/**商品图片**/
CREATE TABLE pic(
	photo_id BIGINT(32) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '用户头像id(主键)',
	user_id BIGINT(32) NOT NULL COMMENT '用户id(外键)',
	photourl VARCHAR(255) NOT NULL COMMENT '详细地址',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_time DATETIME NOT NULL COMMENT '最后一次更新时间',
	ustatus INT(1) NOT NULL COMMENT '状态',
	FOREIGN KEY(photo_id)REFERENCES cake_users(uid)
);
/**用户充值**/
CREATE TABLE users_charge(
	id BIGINT(32) NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '充值先后顺序id(主键)',
	users_charge_id BIGINT(32) NOT NULL  COMMENT '用户id',
	uaccount_balance DECIMAL(30,2) DEFAULT NULL COMMENT '账户余额',
	uexperience BIGINT(32) DEFAULT NULL COMMENT '我的经验值',
	ucoupons BIGINT(32) DEFAULT NULL COMMENT '我的优惠券',
	ucash BIGINT(32) DEFAULT NULL COMMENT '我的兑换券',
	FOREIGN KEY(users_charge_id)REFERENCES cake_users(uid)

);
/**商城管理员**/
DROP TABLE IF EXISTS manager;
CREATE TABLE manager(
	mid BIGINT NOT  NULL PRIMARY KEY AUTO_INCREMENT COMMENT  '管理员id(主键)',
	mname VARCHAR(32) NOT NULL COMMENT '管理员姓名', 
	password VARCHAR(45) NOT NULL COMMENT '密码',
	status int(1) NOT NULL COMMENT '状态'	
);

/**蛋糕种类**/
CREATE TABLE product_kinds(
	pid BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '类别id(主键)',
	kind_name VARCHAR(45) NOT NULL COMMENT '种类名称',
	used VARCHAR(45) DEFAULT NULL COMMENT '用途',
	status INT(1) NOT NULL COMMENT '状态'
);
/**导航栏推荐表**/
CREATE TABLE product_nav(
	nid BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '导航栏id(主键)',
	nav_name VARCHAR(45) NOT NULL COMMENT '导航推荐名称',
	nav_remark VARCHAR(45) DEFAULT NULL COMMENT '其他',
	status INT(1) NOT NULL COMMENT '状态是否上架'
);




/**蛋糕商品详情**/
CREATE TABLE product_details (
	product_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '商品id(主键)',
	product_kinds_id BIGINT NOT NULL COMMENT '类别id',
	navid BIGINT DEFAULT NULL COMMENT '所属导航栏id',
	cake_name VARCHAR(64) NOT NULL COMMENT '蛋糕名称', 
	relish INT(1) NOT NULL COMMENT '风味标志',
	price DECIMAL(30,2) DEFAULT NULL COMMENT '商品价格',
	count INT(16) DEFAULT NULL COMMENT '商品数量',
	sellcount INT(16) DEFAULT NULL COMMENT '商品销量',
	sizes INT(1) DEFAULT NULL COMMENT '商品规格 0大 1 中 2 小',
	advertisement VARCHAR(200) NOT NULL COMMENT '广告词',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_time DATETIME NOT NULL COMMENT '最后一次更新时间',
	status INT(1) NOT NULL COMMENT '状态',
	recommend INT(1) NOT NULL COMMENT '是否首页推荐',
	img VARCHAR(64) NOT NULL COMMENT '图片地址标准图',
	Bimg VARCHAR(64) NOT NULL COMMENT '图片地址大图',
	img_1 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_1',
	img_2 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_2',
	img_3 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_3',
	img_4 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_4',
	img_5 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_5',
	img_6 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_6',
	img_7 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_7',
	img_8 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_8',
	img_9 VARCHAR(64) NOT NULL COMMENT '详情页主图片地址_9',
	others_one VARCHAR(64) NOT NULL COMMENT '其它1',
	others_two VARCHAR(64) NOT NULL COMMENT '其它2',
	FOREIGN KEY(product_kinds_id)REFERENCES product_kinds(pid)
);

/**收货**/
CREATE TABLE user_address(
	telephone VARCHAR(11) NOT NULL COMMENT '收货人电话',
	address VARCHAR(64) NOT NULL COMMENT '详细地址',
	addname VARCHAR(10) NOT NULL COMMENT '收货人姓名',
	user_id  BIGINT(32) NOT NULL COMMENT '客户id',
	status INT NOT NULL COMMENT '状态',
	FOREIGN KEY (user_id)REFERENCES cake_users(uid)
);
/**订单概览表**/
CREATE TABLE orders(
	user_orders_id BIGINT(32) NOT NULL COMMENT '用户id(外键)',
	orders_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT  '随机订单id',
	nub BIGINT(32) NOT NULL COMMENT '随机订单编号', 
	ordersname VARCHAR(16) NOT NULL COMMENT '收货人姓名',
	telephone VARCHAR(11) DEFAULT NULL COMMENT '电话',
	address VARCHAR(64) NOT NULL COMMENT '收货地址',
	status INT(1) NOT NULL COMMENT '状态',
	FOREIGN KEY(user_orders_id)REFERENCES cake_users(uid)
);
/**订单明细**/
CREATE TABLE orderdetails(
	user_id BIGINT(32) NOT NULL COMMENT '用户id(外键)',
	orders_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '订单id',
	times DATETIME NOT NULL COMMENT '创建时间',
	status INT(1) NOT NULL COMMENT '订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消',
	message VARCHAR(45) DEFAULT NULL COMMENT '付款时留言',
	create_time DATETIME NOT NULL COMMENT '创建时间',
	update_time DATETIME NOT NULL COMMENT '最后一次更新时间',
	received_time DATETIME NOT NULL COMMENT '签收时间',
	FOREIGN KEY(user_id)REFERENCES cake_users(uid)
);

/**轮播图列表123**/
CREATE TABLE cake_index_carousel(
	cid  BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '轮播图id',
	pid BIGINT NOT NULL COMMENT '商品id',
	img VARCHAR(64) NOT NULL COMMENT '图片地址',
	cake_name VARCHAR(64) NOT NULL COMMENT '蛋糕名称', 
	href VARCHAR(255)  COMMENT '链接地址',
	create_time  DATETIME  NOT NULL COMMENT '创建时间',
	update_time DATETIME NOT NULL COMMENT '最后一次更新时间',
	status INT(1) NOT NULL COMMENT '状态',
	FOREIGN KEY(pid)REFERENCES product_details(product_id)
);
/**首页商品**/
CREATE TABLE cake_index_product(
	pid  BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '首页商品id',
	car_id BIGINT NOT NULL COMMENT '商品id(外键)',
	index_title VARCHAR(64)  COMMENT '首页商品标题',
	index_details VARCHAR(64)  COMMENT '首页详细标题',
	index_img VARCHAR(64) NOT NULL COMMENT '首页图片地址',
	index_price DECIMAL(30,2) DEFAULT NULL COMMENT '首页商品价格',
	index_href VARCHAR(255)  COMMENT '首页链接地址',
	index_seq_recommended TINYINT COMMENT '首页是否被推荐',
	index_sale_new TINYINT  COMMENT '首页是否新品上市',
	index_seq_top_sale TINYINT  COMMENT '首页是否在售',
	index_other_title VARCHAR(64)  COMMENT '首页商品其他介绍',
	index_picurl VARCHAR(255) NOT NULL COMMENT '首页轮播图地址',
	index_status INT(1) NOT NULL COMMENT '首页状态',
	FOREIGN KEY(car_id)REFERENCES product_details(product_id)
);
/**购物车**/
CREATE TABLE cake_index_cart(
	c_id  BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '随机购物车id',
	user_id BIGINT(32) NOT NULL COMMENT '用户id',
	car_id BIGINT NOT NULL COMMENT '商品id(外键)',
	status INT(1) NOT NULL COMMENT '状态',
	FOREIGN KEY(car_id)REFERENCES product_details(product_id)
);



/**收藏夹**/
CREATE TABLE collects(
	collects_id  BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '随机收藏夹id',
	user_id BIGINT(32) NOT NULL COMMENT '用户id',
	carousel_id BIGINT NOT NULL COMMENT '商品id(外键)',
	status INT(1) NOT NULL COMMENT '状态',
	FOREIGN KEY(carousel_id)REFERENCES product_details(product_id)
);




insert into product_kinds  values
( 1  ,'极致精选','精品蛋糕','1'),
(NULL,'匠心原创','精品蛋糕','1'),
(NULL,'优雅西点','精品蛋糕','1'),
(NULL,'乳品系列','精品蛋糕','1'),
(NULL,'其他系列','精品蛋糕','1');


insert into product_nav  values
( 1  ,'首页',NULL,'1'),
(NULL,'下午茶','精品蛋糕','1'),
(NULL,'送亲子','精品蛋糕','1'),
(NULL,'送恋人','精品蛋糕','1'),
(NULL,'送长辈','精品蛋糕','1'),
(NULL,'活动产品','精品蛋糕','1');

insert into product_details  values
( '1','1','2','兔小萌','1','299.99','99999999','218','0','兔小萌生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/兔小萌.png','images/index/兔小萌_b.png','images/index/兔小萌_1.png','images/index/兔小萌_2.png','images/index/兔小萌_3.png','images/index/兔小萌_4.png','images/index/兔小萌_5.png','images/index/兔小萌_6.png','images/index/兔小萌_7.png','images/index/兔小萌_8.png','images/index/兔小萌_9.png','0','0'),
( '2','1','2','冻烤燃情芝士','1','299.99','99999999','314','1','冻烤燃情芝士生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/冻烤燃情芝士.png','images/index/冻烤燃情芝士_b.png','images/index/冻烤燃情芝士_1.png','images/index/冻烤燃情芝士_2.png','images/index/冻烤燃情芝士_3.png','images/index/冻烤燃情芝士_4.png','images/index/冻烤燃情芝士_5.png','images/index/冻烤燃情芝士_6.png','images/index/冻烤燃情芝士_7.png','images/index/冻烤燃情芝士_8.png','images/index/冻烤燃情芝士_9.png','0','0'),
( '3','1','3','可莱思迪客英国进口冰淇淋(500ml)','1','299.99','99999999','45','2','可莱思迪客英国进口冰淇淋(500ml)生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/可莱思迪客英国进口冰淇淋(500ml).png','images/index/可莱思迪客英国进口冰淇淋(500ml)_b.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_1.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_2.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_3.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_4.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_5.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_6.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_7.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_8.png','images/index/可莱思迪客英国进口冰淇淋(500ml)_9.png','0','0'),
( '4','1','4','吉致泡芙(巧克力)','1','299.99','99999999','2','0','吉致泡芙(巧克力)生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/吉致泡芙(巧克力).png','images/index/吉致泡芙(巧克力)_b.png','images/index/吉致泡芙(巧克力)_1.png','images/index/吉致泡芙(巧克力)_2.png','images/index/吉致泡芙(巧克力)_3.png','images/index/吉致泡芙(巧克力)_4.png','images/index/吉致泡芙(巧克力)_5.png','images/index/吉致泡芙(巧克力)_6.png','images/index/吉致泡芙(巧克力)_7.png','images/index/吉致泡芙(巧克力)_8.png','images/index/吉致泡芙(巧克力)_9.png','0','0'),
( '5','1','4','吉致泡芙','1','299.99','99999999','2456','1','吉致泡芙生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/吉致泡芙.png','images/index/吉致泡芙_b.png','images/index/吉致泡芙_1.png','images/index/吉致泡芙_2.png','images/index/吉致泡芙_3.png','images/index/吉致泡芙_4.png','images/index/吉致泡芙_5.png','images/index/吉致泡芙_6.png','images/index/吉致泡芙_7.png','images/index/吉致泡芙_8.png','images/index/吉致泡芙_9.png','0','0'),
( '6','1','2','吉致牛轧糖(巴旦木味)','1','299.99','99999999','12','2','吉致牛轧糖(巴旦木味)生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/吉致牛轧糖(巴旦木味).png','images/index/吉致牛轧糖(巴旦木味)_b.png','images/index/吉致牛轧糖(巴旦木味)_1.png','images/index/吉致牛轧糖(巴旦木味)_2.png','images/index/吉致牛轧糖(巴旦木味)_3.png','images/index/吉致牛轧糖(巴旦木味)_4.png','images/index/吉致牛轧糖(巴旦木味)_5.png','images/index/吉致牛轧糖(巴旦木味)_6.png','images/index/吉致牛轧糖(巴旦木味)_7.png','images/index/吉致牛轧糖(巴旦木味)_8.png','images/index/吉致牛轧糖(巴旦木味)_9.png','0','0'),
( '7','1','3','吉致牛轧糖(巴旦木味)2盒','2','359.99','99999999','244','0','吉致牛轧糖(巴旦木味)2盒生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/吉致牛轧糖(巴旦木味)2盒.png','images/index/吉致牛轧糖(巴旦木味)2盒_b.png','images/index/吉致牛轧糖(巴旦木味)2盒_1.png','images/index/吉致牛轧糖(巴旦木味)2盒_2.png','images/index/吉致牛轧糖(巴旦木味)2盒_3.png','images/index/吉致牛轧糖(巴旦木味)2盒_4.png','images/index/吉致牛轧糖(巴旦木味)2盒_5.png','images/index/吉致牛轧糖(巴旦木味)2盒_6.png','images/index/吉致牛轧糖(巴旦木味)2盒_7.png','images/index/吉致牛轧糖(巴旦木味)2盒_8.png','images/index/吉致牛轧糖(巴旦木味)2盒_9.png','0','0'),
( '8','1','3','吉致生巧','2','359.99','99999999','24','1','吉致生巧生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/吉致生巧.png','images/index/吉致生巧_b.png','images/index/吉致生巧_1.png','images/index/吉致生巧_2.png','images/index/吉致生巧_3.png','images/index/吉致生巧_4.png','images/index/吉致生巧_5.png','images/index/吉致生巧_6.png','images/index/吉致生巧_7.png','images/index/吉致生巧_8.png','images/index/吉致生巧_9.png','0','0'),
( '9','1','4','奥利奥雪域牛乳芝士','2','359.99','99999999','564','2','奥利奥雪域牛乳芝士生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/奥利奥雪域牛乳芝士.png','images/index/奥利奥雪域牛乳芝士_b.png','images/index/奥利奥雪域牛乳芝士_1.png','images/index/奥利奥雪域牛乳芝士_2.png','images/index/奥利奥雪域牛乳芝士_3.png','images/index/奥利奥雪域牛乳芝士_4.png','images/index/奥利奥雪域牛乳芝士_5.png','images/index/奥利奥雪域牛乳芝士_6.png','images/index/奥利奥雪域牛乳芝士_7.png','images/index/奥利奥雪域牛乳芝士_8.png','images/index/奥利奥雪域牛乳芝士_9.png','0','0'),
( '10','2','2','布朗尼精灵','2','359.99','99999999','55','0','布朗尼精灵生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/布朗尼精灵.png','images/index/布朗尼精灵_b.png','images/index/布朗尼精灵_1.png','images/index/布朗尼精灵_2.png','images/index/布朗尼精灵_3.png','images/index/布朗尼精灵_4.png','images/index/布朗尼精灵_5.png','images/index/布朗尼精灵_6.png','images/index/布朗尼精灵_7.png','images/index/布朗尼精灵_8.png','images/index/布朗尼精灵_9.png','0','0'),
( '11','2','3','情定爱情海','2','359.99','99999999','14','1','情定爱情海生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/情定爱情海.png','images/index/情定爱情海_b.png','images/index/情定爱情海_1.png','images/index/情定爱情海_2.png','images/index/情定爱情海_3.png','images/index/情定爱情海_4.png','images/index/情定爱情海_5.png','images/index/情定爱情海_6.png','images/index/情定爱情海_7.png','images/index/情定爱情海_8.png','images/index/情定爱情海_9.png','0','0'),
( '12','2','4','慕尼黑巧克力','2','359.99','99999999','84','2','慕尼黑巧克力生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/慕尼黑巧克力.png','images/index/慕尼黑巧克力_b.png','images/index/慕尼黑巧克力_1.png','images/index/慕尼黑巧克力_2.png','images/index/慕尼黑巧克力_3.png','images/index/慕尼黑巧克力_4.png','images/index/慕尼黑巧克力_5.png','images/index/慕尼黑巧克力_6.png','images/index/慕尼黑巧克力_7.png','images/index/慕尼黑巧克力_8.png','images/index/慕尼黑巧克力_9.png','0','0'),
( '13','2','5','新公爵提拉米苏','3','469.99','99999999','35','0','新公爵提拉米苏生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/新公爵提拉米苏.png','images/index/新公爵提拉米苏_b.png','images/index/新公爵提拉米苏_1.png','images/index/新公爵提拉米苏_2.png','images/index/新公爵提拉米苏_3.png','images/index/新公爵提拉米苏_4.png','images/index/新公爵提拉米苏_5.png','images/index/新公爵提拉米苏_6.png','images/index/新公爵提拉米苏_7.png','images/index/新公爵提拉米苏_8.png','images/index/新公爵提拉米苏_9.png','0','0'),
( '14','2','5','新狮子王','3','469.99','99999999','84','1','新狮子王生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/新狮子王.png','images/index/新狮子王_b.png','images/index/新狮子王_1.png','images/index/新狮子王_2.png','images/index/新狮子王_3.png','images/index/新狮子王_4.png','images/index/新狮子王_5.png','images/index/新狮子王_6.png','images/index/新狮子王_7.png','images/index/新狮子王_8.png','images/index/新狮子王_9.png','0','0'),
( '15','2','5','新疆美果[一级若羌红枣]','3','469.99','99999999','89','2','新疆美果[一级若羌红枣]生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/新疆美果[一级若羌红枣].png','images/index/新疆美果[一级若羌红枣]_b.png','images/index/新疆美果[一级若羌红枣]_1.png','images/index/新疆美果[一级若羌红枣]_2.png','images/index/新疆美果[一级若羌红枣]_3.png','images/index/新疆美果[一级若羌红枣]_4.png','images/index/新疆美果[一级若羌红枣]_5.png','images/index/新疆美果[一级若羌红枣]_6.png','images/index/新疆美果[一级若羌红枣]_7.png','images/index/新疆美果[一级若羌红枣]_8.png','images/index/新疆美果[一级若羌红枣]_9.png','0','0'),
( '16','2','5','新疆美果[开口杏核]','3','469.99','99999999','22','0','新疆美果[开口杏核]生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/新疆美果[开口杏核].png','images/index/新疆美果[开口杏核]_b.png','images/index/新疆美果[开口杏核]_1.png','images/index/新疆美果[开口杏核]_2.png','images/index/新疆美果[开口杏核]_3.png','images/index/新疆美果[开口杏核]_4.png','images/index/新疆美果[开口杏核]_5.png','images/index/新疆美果[开口杏核]_6.png','images/index/新疆美果[开口杏核]_7.png','images/index/新疆美果[开口杏核]_8.png','images/index/新疆美果[开口杏核]_9.png','0','0'),
( '17','2','6','新疆美果[特级黑加仑葡萄干]','3','469.99','99999999','34','1','新疆美果[特级黑加仑葡萄干]生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/新疆美果[特级黑加仑葡萄干].png','images/index/新疆美果[特级黑加仑葡萄干]_b.png','images/index/新疆美果[特级黑加仑葡萄干]_1.png','images/index/新疆美果[特级黑加仑葡萄干]_2.png','images/index/新疆美果[特级黑加仑葡萄干]_3.png','images/index/新疆美果[特级黑加仑葡萄干]_4.png','images/index/新疆美果[特级黑加仑葡萄干]_5.png','images/index/新疆美果[特级黑加仑葡萄干]_6.png','images/index/新疆美果[特级黑加仑葡萄干]_7.png','images/index/新疆美果[特级黑加仑葡萄干]_8.png','images/index/新疆美果[特级黑加仑葡萄干]_9.png','0','0'),
( '18','2','6','旺旺旺','4','269.99','99999999','485','2','旺旺旺生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/旺旺旺.png','images/index/旺旺旺_b.png','images/index/旺旺旺_1.png','images/index/旺旺旺_2.png','images/index/旺旺旺_3.png','images/index/旺旺旺_4.png','images/index/旺旺旺_5.png','images/index/旺旺旺_6.png','images/index/旺旺旺_7.png','images/index/旺旺旺_8.png','images/index/旺旺旺_9.png','0','0'),
( '19','2','6','星光游乐园','4','269.99','99999999','89','0','星光游乐园生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/星光游乐园.png','images/index/星光游乐园_b.png','images/index/星光游乐园_1.png','images/index/星光游乐园_2.png','images/index/星光游乐园_3.png','images/index/星光游乐园_4.png','images/index/星光游乐园_5.png','images/index/星光游乐园_6.png','images/index/星光游乐园_7.png','images/index/星光游乐园_8.png','images/index/星光游乐园_9.png','0','0'),
( '20','2','6','春天芽儿-周茶','4','269.99','99999999','99','1','春天芽儿-周茶生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/春天芽儿-周茶.png','images/index/春天芽儿-周茶_b.png','images/index/春天芽儿-周茶_1.png','images/index/春天芽儿-周茶_2.png','images/index/春天芽儿-周茶_3.png','images/index/春天芽儿-周茶_4.png','images/index/春天芽儿-周茶_5.png','images/index/春天芽儿-周茶_6.png','images/index/春天芽儿-周茶_7.png','images/index/春天芽儿-周茶_8.png','images/index/春天芽儿-周茶_9.png','0','0'),
( '21','2','','朗姆香栗','4','269.99','99999999','2','2','朗姆香栗生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/朗姆香栗.png','images/index/朗姆香栗_b.png','images/index/朗姆香栗_1.png','images/index/朗姆香栗_2.png','images/index/朗姆香栗_3.png','images/index/朗姆香栗_4.png','images/index/朗姆香栗_5.png','images/index/朗姆香栗_6.png','images/index/朗姆香栗_7.png','images/index/朗姆香栗_8.png','images/index/朗姆香栗_9.png','0','0'),
( '22','2','','杯子蛋糕','4','269.99','99999999','4','0','杯子蛋糕生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/杯子蛋糕.png','images/index/杯子蛋糕_b.png','images/index/杯子蛋糕_1.png','images/index/杯子蛋糕_2.png','images/index/杯子蛋糕_3.png','images/index/杯子蛋糕_4.png','images/index/杯子蛋糕_5.png','images/index/杯子蛋糕_6.png','images/index/杯子蛋糕_7.png','images/index/杯子蛋糕_8.png','images/index/杯子蛋糕_9.png','0','0'),
( '23','3','','松露巧克力','1','299.99','99999999','218','0','松露巧克力生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/松露巧克力.png','images/index/松露巧克力_b.png','images/index/松露巧克力_1.png','images/index/松露巧克力_2.png','images/index/松露巧克力_3.png','images/index/松露巧克力_4.png','images/index/松露巧克力_5.png','images/index/松露巧克力_6.png','images/index/松露巧克力_7.png','images/index/松露巧克力_8.png','images/index/松露巧克力_9.png','0','0'),
( '24','3','','沃尔夫斯堡之春','1','299.99','99999999','314','1','沃尔夫斯堡之春生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/沃尔夫斯堡之春.png','images/index/沃尔夫斯堡之春_b.png','images/index/沃尔夫斯堡之春_1.png','images/index/沃尔夫斯堡之春_2.png','images/index/沃尔夫斯堡之春_3.png','images/index/沃尔夫斯堡之春_4.png','images/index/沃尔夫斯堡之春_5.png','images/index/沃尔夫斯堡之春_6.png','images/index/沃尔夫斯堡之春_7.png','images/index/沃尔夫斯堡之春_8.png','images/index/沃尔夫斯堡之春_9.png','0','0'),
( '25','3','','洛可可甜心','1','299.99','99999999','45','2','洛可可甜心生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/洛可可甜心.png','images/index/洛可可甜心_b.png','images/index/洛可可甜心_1.png','images/index/洛可可甜心_2.png','images/index/洛可可甜心_3.png','images/index/洛可可甜心_4.png','images/index/洛可可甜心_5.png','images/index/洛可可甜心_6.png','images/index/洛可可甜心_7.png','images/index/洛可可甜心_8.png','images/index/洛可可甜心_9.png','0','0'),
( '26','3','','浓情花意','1','299.99','99999999','2','0','浓情花意生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/浓情花意.png','images/index/浓情花意_b.png','images/index/浓情花意_1.png','images/index/浓情花意_2.png','images/index/浓情花意_3.png','images/index/浓情花意_4.png','images/index/浓情花意_5.png','images/index/浓情花意_6.png','images/index/浓情花意_7.png','images/index/浓情花意_8.png','images/index/浓情花意_9.png','0','0'),
( '27','3','','清椰瑞士卷2盒','1','299.99','99999999','2456','1','清椰瑞士卷2盒生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/清椰瑞士卷2盒.png','images/index/清椰瑞士卷2盒_b.png','images/index/清椰瑞士卷2盒_1.png','images/index/清椰瑞士卷2盒_2.png','images/index/清椰瑞士卷2盒_3.png','images/index/清椰瑞士卷2盒_4.png','images/index/清椰瑞士卷2盒_5.png','images/index/清椰瑞士卷2盒_6.png','images/index/清椰瑞士卷2盒_7.png','images/index/清椰瑞士卷2盒_8.png','images/index/清椰瑞士卷2盒_9.png','0','0'),
( '28','3','','玫瑰女王','1','299.99','99999999','12','2','玫瑰女王生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/玫瑰女王.png','images/index/玫瑰女王_b.png','images/index/玫瑰女王_1.png','images/index/玫瑰女王_2.png','images/index/玫瑰女王_3.png','images/index/玫瑰女王_4.png','images/index/玫瑰女王_5.png','images/index/玫瑰女王_6.png','images/index/玫瑰女王_7.png','images/index/玫瑰女王_8.png','images/index/玫瑰女王_9.png','0','0'),
( '29','3','','白色红丝绒','2','359.99','99999999','244','0','白色红丝绒生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/白色红丝绒.png','images/index/白色红丝绒_b.png','images/index/白色红丝绒_1.png','images/index/白色红丝绒_2.png','images/index/白色红丝绒_3.png','images/index/白色红丝绒_4.png','images/index/白色红丝绒_5.png','images/index/白色红丝绒_6.png','images/index/白色红丝绒_7.png','images/index/白色红丝绒_8.png','images/index/白色红丝绒_9.png','0','0'),
( '30','3','','红莓森林(3.8特供)','2','359.99','99999999','24','1','红莓森林(3.8特供)生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/红莓森林(3.8特供).png','images/index/红莓森林(3.8特供)_b.png','images/index/红莓森林(3.8特供)_1.png','images/index/红莓森林(3.8特供)_2.png','images/index/红莓森林(3.8特供)_3.png','images/index/红莓森林(3.8特供)_4.png','images/index/红莓森林(3.8特供)_5.png','images/index/红莓森林(3.8特供)_6.png','images/index/红莓森林(3.8特供)_7.png','images/index/红莓森林(3.8特供)_8.png','images/index/红莓森林(3.8特供)_9.png','0','0'),
( '31','3','','美刀刀','2','359.99','99999999','564','2','美刀刀生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/美刀刀.png','images/index/美刀刀_b.png','images/index/美刀刀_1.png','images/index/美刀刀_2.png','images/index/美刀刀_3.png','images/index/美刀刀_4.png','images/index/美刀刀_5.png','images/index/美刀刀_6.png','images/index/美刀刀_7.png','images/index/美刀刀_8.png','images/index/美刀刀_9.png','0','0'),
( '32','3','','芒go','2','359.99','99999999','55','0','芒go生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/芒go.png','images/index/芒go_b.png','images/index/芒go_1.png','images/index/芒go_2.png','images/index/芒go_3.png','images/index/芒go_4.png','images/index/芒go_5.png','images/index/芒go_6.png','images/index/芒go_7.png','images/index/芒go_8.png','images/index/芒go_9.png','0','0'),
( '33','3','','芒来芒趣','2','359.99','99999999','14','1','芒来芒趣生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/芒来芒趣.png','images/index/芒来芒趣_b.png','images/index/芒来芒趣_1.png','images/index/芒来芒趣_2.png','images/index/芒来芒趣_3.png','images/index/芒来芒趣_4.png','images/index/芒来芒趣_5.png','images/index/芒来芒趣_6.png','images/index/芒来芒趣_7.png','images/index/芒来芒趣_8.png','images/index/芒来芒趣_9.png','0','0'),
( '34','3','','茶色生香','2','359.99','99999999','84','2','茶色生香生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/茶色生香.png','images/index/茶色生香_b.png','images/index/茶色生香_1.png','images/index/茶色生香_2.png','images/index/茶色生香_3.png','images/index/茶色生香_4.png','images/index/茶色生香_5.png','images/index/茶色生香_6.png','images/index/茶色生香_7.png','images/index/茶色生香_8.png','images/index/茶色生香_9.png','0','0'),
( '35','3','','草莓拿破仑','3','469.99','99999999','35','0','草莓拿破仑生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/草莓拿破仑.png','images/index/草莓拿破仑_b.png','images/index/草莓拿破仑_1.png','images/index/草莓拿破仑_2.png','images/index/草莓拿破仑_3.png','images/index/草莓拿破仑_4.png','images/index/草莓拿破仑_5.png','images/index/草莓拿破仑_6.png','images/index/草莓拿破仑_7.png','images/index/草莓拿破仑_8.png','images/index/草莓拿破仑_9.png','0','0'),
( '36','3','','莱茵河莓妖精','3','469.99','99999999','84','1','莱茵河莓妖精生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/莱茵河莓妖精.png','images/index/莱茵河莓妖精_b.png','images/index/莱茵河莓妖精_1.png','images/index/莱茵河莓妖精_2.png','images/index/莱茵河莓妖精_3.png','images/index/莱茵河莓妖精_4.png','images/index/莱茵河莓妖精_5.png','images/index/莱茵河莓妖精_6.png','images/index/莱茵河莓妖精_7.png','images/index/莱茵河莓妖精_8.png','images/index/莱茵河莓妖精_9.png','0','0'),
( '37','4','','蓝妃儿','3','469.99','99999999','89','2','蓝妃儿生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/蓝妃儿.png','images/index/蓝妃儿_b.png','images/index/蓝妃儿_1.png','images/index/蓝妃儿_2.png','images/index/蓝妃儿_3.png','images/index/蓝妃儿_4.png','images/index/蓝妃儿_5.png','images/index/蓝妃儿_6.png','images/index/蓝妃儿_7.png','images/index/蓝妃儿_8.png','images/index/蓝妃儿_9.png','0','0'),
( '38','4','','贝丽','3','469.99','99999999','22','0','贝丽生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/贝丽.png','images/index/贝丽_b.png','images/index/贝丽_1.png','images/index/贝丽_2.png','images/index/贝丽_3.png','images/index/贝丽_4.png','images/index/贝丽_5.png','images/index/贝丽_6.png','images/index/贝丽_7.png','images/index/贝丽_8.png','images/index/贝丽_9.png','0','0'),
( '39','4','','贝猪猪','3','469.99','99999999','34','1','贝猪猪生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/贝猪猪.png','images/index/贝猪猪_b.png','images/index/贝猪猪_1.png','images/index/贝猪猪_2.png','images/index/贝猪猪_3.png','images/index/贝猪猪_4.png','images/index/贝猪猪_5.png','images/index/贝猪猪_6.png','images/index/贝猪猪_7.png','images/index/贝猪猪_8.png','images/index/贝猪猪_9.png','0','0'),
( '40','4','','踏雪寻莓','4','269.99','99999999','485','2','踏雪寻莓生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/踏雪寻莓.png','images/index/踏雪寻莓_b.png','images/index/踏雪寻莓_1.png','images/index/踏雪寻莓_2.png','images/index/踏雪寻莓_3.png','images/index/踏雪寻莓_4.png','images/index/踏雪寻莓_5.png','images/index/踏雪寻莓_6.png','images/index/踏雪寻莓_7.png','images/index/踏雪寻莓_8.png','images/index/踏雪寻莓_9.png','0','0'),
( '41','4','','酥心曲奇(牛奶蛋羹味)','4','269.99','99999999','89','0','酥心曲奇(牛奶蛋羹味)生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/酥心曲奇(牛奶蛋羹味).png','images/index/酥心曲奇(牛奶蛋羹味)_b.png','images/index/酥心曲奇(牛奶蛋羹味)_1.png','images/index/酥心曲奇(牛奶蛋羹味)_2.png','images/index/酥心曲奇(牛奶蛋羹味)_3.png','images/index/酥心曲奇(牛奶蛋羹味)_4.png','images/index/酥心曲奇(牛奶蛋羹味)_5.png','images/index/酥心曲奇(牛奶蛋羹味)_6.png','images/index/酥心曲奇(牛奶蛋羹味)_7.png','images/index/酥心曲奇(牛奶蛋羹味)_8.png','images/index/酥心曲奇(牛奶蛋羹味)_9.png','0','0'),
( '42','4','','酸奶芝士','4','269.99','99999999','99','1','酸奶芝士生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/酸奶芝士.png','images/index/酸奶芝士_b.png','images/index/酸奶芝士_1.png','images/index/酸奶芝士_2.png','images/index/酸奶芝士_3.png','images/index/酸奶芝士_4.png','images/index/酸奶芝士_5.png','images/index/酸奶芝士_6.png','images/index/酸奶芝士_7.png','images/index/酸奶芝士_8.png','images/index/酸奶芝士_9.png','0','0'),
( '43','4','','金色榴莲','4','269.99','99999999','2','2','金色榴莲生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/金色榴莲.png','images/index/金色榴莲_b.png','images/index/金色榴莲_1.png','images/index/金色榴莲_2.png','images/index/金色榴莲_3.png','images/index/金色榴莲_4.png','images/index/金色榴莲_5.png','images/index/金色榴莲_6.png','images/index/金色榴莲_7.png','images/index/金色榴莲_8.png','images/index/金色榴莲_9.png','0','0'),
( '44','4','','金装云顶曲奇','4','269.99','99999999','4','0','金装云顶曲奇生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/金装云顶曲奇.png','images/index/金装云顶曲奇_b.png','images/index/金装云顶曲奇_1.png','images/index/金装云顶曲奇_2.png','images/index/金装云顶曲奇_3.png','images/index/金装云顶曲奇_4.png','images/index/金装云顶曲奇_5.png','images/index/金装云顶曲奇_6.png','images/index/金装云顶曲奇_7.png','images/index/金装云顶曲奇_8.png','images/index/金装云顶曲奇_9.png','0','0'),
( '45','4','','麦趣尔一号牧场纯牛奶(250ml×12)','1','269.99','99999999','5','1','麦趣尔一号牧场纯牛奶(250ml×12)生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/麦趣尔一号牧场纯牛奶(250ml×12).png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_b.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_1.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_2.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_3.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_4.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_5.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_6.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_7.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_8.png','images/index/麦趣尔一号牧场纯牛奶(250ml×12)_9.png','0','0'),
( '46','4','','麦趣尔纯牛奶(250mlx12盒)','2','269.99','99999999','7','2','麦趣尔纯牛奶(250mlx12盒)生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/麦趣尔纯牛奶(250mlx12盒).png','images/index/麦趣尔纯牛奶(250mlx12盒)_b.png','images/index/麦趣尔纯牛奶(250mlx12盒)_1.png','images/index/麦趣尔纯牛奶(250mlx12盒)_2.png','images/index/麦趣尔纯牛奶(250mlx12盒)_3.png','images/index/麦趣尔纯牛奶(250mlx12盒)_4.png','images/index/麦趣尔纯牛奶(250mlx12盒)_5.png','images/index/麦趣尔纯牛奶(250mlx12盒)_6.png','images/index/麦趣尔纯牛奶(250mlx12盒)_7.png','images/index/麦趣尔纯牛奶(250mlx12盒)_8.png','images/index/麦趣尔纯牛奶(250mlx12盒)_9.png','0','0'),
( '47','4','','黑白巧克力芝士','3','269.99','99999999','2','0','黑白巧克力芝士生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/黑白巧克力芝士.png','images/index/黑白巧克力芝士_b.png','images/index/黑白巧克力芝士_1.png','images/index/黑白巧克力芝士_2.png','images/index/黑白巧克力芝士_3.png','images/index/黑白巧克力芝士_4.png','images/index/黑白巧克力芝士_5.png','images/index/黑白巧克力芝士_6.png','images/index/黑白巧克力芝士_7.png','images/index/黑白巧克力芝士_8.png','images/index/黑白巧克力芝士_9.png','0','0'),
( '48','4','','黑白配','4','269.99','99999999','87','1','黑白配生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/黑白配.png','images/index/黑白配_b.png','images/index/黑白配_1.png','images/index/黑白配_2.png','images/index/黑白配_3.png','images/index/黑白配_4.png','images/index/黑白配_5.png','images/index/黑白配_6.png','images/index/黑白配_7.png','images/index/黑白配_8.png','images/index/黑白配_9.png','0','0'),
( '49','4','','粉红回忆','1','269.99','99999999','45','2','粉红回忆生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/粉红回忆.png','images/index/粉红回忆_b.png','images/index/粉红回忆_1.png','images/index/粉红回忆_2.png','images/index/粉红回忆_3.png','images/index/粉红回忆_4.png','images/index/粉红回忆_5.png','images/index/粉红回忆_6.png','images/index/粉红回忆_7.png','images/index/粉红回忆_8.png','images/index/粉红回忆_9.png','0','0'),
( '50','4','','巧克力精灵','2','269.99','99999999','2','0','巧克力精灵生日蛋糕,巧克力,芝士,乳酪蛋糕,慕斯,鲜奶,商务,婚庆,提供健康、高品质蛋糕、时尚经典方形蛋糕,在线预订,配送到家','2018-7-1 14:37:01','2018-7-1 14:37:01','1','1','images/index/巧克力精灵.png','images/index/巧克力精灵_b.png','images/index/巧克力精灵_1.png','images/index/巧克力精灵_2.png','images/index/巧克力精灵_3.png','images/index/巧克力精灵_4.png','images/index/巧克力精灵_5.png','images/index/巧克力精灵_6.png','images/index/巧克力精灵_7.png','images/index/巧克力精灵_8.png','images/index/巧克力精灵_9.png','0','0');

insert into cake_users values 
( '1','xiaohong','康麟','123456','1','10','NULL','1','15093390000','1','深圳','深圳','NULL','2599','2018/7/1 14:37:01','1'),
( '2','xiaolan','禹锡','123456','1','11','NULL','1','15093390001','1','深圳','深圳','NULL','2600','2018/7/1 14:37:02','1'),
( '3','honghong','智涛','123456','1','12','NULL','1','15093390002','1','深圳','深圳','NULL','2601','2018/7/1 14:37:03','1'),
( '4','haha','磊贯','123456','1','13','NULL','1','15093390003','1','深圳','深圳','NULL','2602','2018/7/1 14:37:04','1'),
( '5','yaya','嘉恩','123456','1','14','NULL','1','15093390004','1','深圳','深圳','NULL','2603','2018/7/1 14:37:05','1'),
( '6','wawa','启儒','123456','1','15','NULL','1','15093390005','1','深圳','深圳','NULL','2604','2018/7/1 14:37:06','1'),
( '7','kaixin','帆松','123456','1','16','NULL','1','15093390006','1','深圳','深圳','NULL','2605','2018/7/1 14:37:07','1'),
( '8','kuaile','玮桦','123456','1','17','NULL','1','15093390007','1','深圳','深圳','NULL','2606','2018/7/1 14:37:08','1'),
( '9','fenfen','荣衡','123456','1','18','NULL','1','15093390008','1','深圳','深圳','NULL','2607','2018/7/1 14:37:09','1'),
( '10','songsong','锡杭','123456','1','19','NULL','1','15093390009','1','深圳','深圳','NULL','2608','2018/7/1 14:37:10','1'),
( '11','aya','成炫','123456','1','20','NULL','1','15093390010','1','深圳','深圳','NULL','2609','2018/7/1 14:37:11','1'),
( '12','happy','颖禹','123456','1','21','NULL','1','15093390011','1','深圳','深圳','NULL','2610','2018/7/1 14:37:12','1'),
( '13','cccccc','鹏儒','123456','1','22','NULL','1','15093390012','1','深圳','深圳','NULL','2611','2018/7/1 14:37:13','1'),
( '14','feifei','亮尧','123456','1','23','NULL','1','15093390013','1','深圳','深圳','NULL','2612','2018/7/1 14:37:14','1'),
( '15','qingqing','清瑄','123456','1','24','NULL','1','15093390014','1','深圳','深圳','NULL','2613','2018/7/1 14:37:15','1'),
( '16','fengfeng','烽狄','123456','1','25','NULL','1','15093390015','1','深圳','深圳','NULL','2614','2018/7/1 14:37:16','1'),
( '17','longlong','衡龙','123456','1','26','NULL','1','15093390016','1','深圳','深圳','NULL','2615','2018/7/1 14:37:17','1'),
( '18','liang','梁羲','123456','1','27','NULL','1','15093390017','1','深圳','深圳','NULL','2616','2018/7/1 14:37:18','1'),
( '19','jing','经崴','123456','1','28','NULL','1','15093390018','1','深圳','深圳','NULL','2617','2018/7/1 14:37:19','1'),
( '20','si','思彬','123456','1','29','NULL','1','15093390019','1','深圳','深圳','NULL','3000','2018/7/1 14:37:20','1'),
( '21','shao','帆少','123456','1','30','NULL','1','15093390020','1','上海','上海','NULL','3000','2018/7/1 14:37:21','1'),
( '22','shan','善颖','123456','1','31','NULL','1','15093390021','1','上海','上海','NULL','3000','2018/7/1 14:37:22','1'),
( '23','shaoshao','少靖','123456','1','32','NULL','1','15093390022','1','上海','上海','NULL','3000','2018/7/1 14:37:23','1'),
( '24','zhaozhao','兆威','123456','1','33','NULL','1','15093390023','1','上海','上海','NULL','3000','2018/7/1 14:37:24','1'),
( '25','zhongha','仲盛','123456','0','34','NULL','1','15093390024','0','上海','上海','NULL','3000','2018/7/1 14:37:25','1'),
( '26','daodao','道道','123456','0','35','NULL','1','15093390025','0','上海','上海','NULL','3000','2018/7/1 14:37:26','1'),
( '27','lalala','谦瀚','123456','0','36','NULL','1','15093390026','0','上海','上海','NULL','3000','2018/7/1 14:37:27','1'),
( '28','金树','金树','123456','0','37','NULL','1','15093390027','0','上海','上海','NULL','3000','2018/7/1 14:37:28','1'),
( '29','旭伟','旭伟','123456','0','38','NULL','1','15093390028','0','上海','上海','NULL','3000','2018/7/1 14:37:29','1'),
( '30','鹏航','鹏航','123456','0','39','NULL','1','15093390029','0','上海','上海','NULL','3000','2018/7/1 14:37:30','1'),
( '31','杭喜','杭喜','123456','0','40','NULL','1','15093390030','0','上海','上海','NULL','3500','2018/7/1 14:37:31','1'),
( '32','锡河','锡河','123456','0','41','NULL','1','15093390031','0','上海','上海','NULL','3500','2018/7/1 14:37:32','1'),
( '33','以飞','以飞','123456','0','42','NULL','1','15093390032','0','上海','上海','NULL','3500','2018/7/1 14:37:33','1'),
( '34','秋海','秋海','123456','0','43','NULL','1','15093390033','0','上海','上海','NULL','3500','2018/7/1 14:37:34','1'),
( '35','广振','广振','123456','0','20','NULL','1','15093390034','0','上海','上海','NULL','3500','2018/7/1 14:37:35','1'),
( '36','衡民','衡民','123456','0','20','NULL','1','15093390035','0','上海','上海','NULL','3500','2018/7/1 14:37:36','1'),
( '37','正滨','正滨','123456','0','20','NULL','1','15093390036','0','上海','上海','NULL','3500','2018/7/1 14:37:37','1'),
( '38','钧清','钧清','123456','0','20','NULL','1','15093390037','0','上海','上海','NULL','3500','2018/7/1 14:37:38','1'),
( '39','宸靖','宸靖','123456','0','20','NULL','1','15093390038','0','上海','上海','NULL','3500','2018/7/1 14:37:39','1'),
( '40','腾镇','腾镇','123456','0','20','NULL','1','15093390039','0','上海','上海','NULL','3500','2018/7/1 14:37:40','1'),
( '41','绍龙','绍龙','123456','0','20','NULL','1','15093390040','0','上海','上海','NULL','3500','2018/7/1 14:37:41','1'),
( '42','朗杭','朗杭','123456','0','20','NULL','1','15093390041','0','上海','上海','NULL','3500','2018/7/1 14:37:42','1'),
( '43','景坤','景坤','123456','0','20','NULL','1','15093390042','0','上海','上海','NULL','4500','2018/7/1 14:37:43','1'),
( '44','宏刚','宏刚','123456','0','20','NULL','1','15093390043','0','广州','广州','NULL','4500','2018/7/1 14:37:44','1'),
( '45','泽广','泽广','123456','0','20','NULL','1','15093390044','0','广州','广州','NULL','4500','2018/7/1 14:37:45','1'),
( '46','兆澄','兆澄','123456','0','22','NULL','1','15093390045','0','广州','广州','NULL','4500','2018/7/1 14:37:46','1'),
( '47','衡林','衡林','123456','0','22','NULL','1','15093390046','0','广州','广州','NULL','4500','2018/7/1 14:37:47','1'),
( '48','隽盛','隽盛','123456','0','22','NULL','1','15093390047','0','广州','广州','NULL','4500','2018/7/1 14:37:48','1'),
( '49','卫杰','卫杰','123456','0','22','NULL','1','15093390048','0','广州','广州','NULL','4500','2018/7/1 14:37:49','1'),
( '50','海升','海升','123456','0','22','NULL','1','15093390049','0','广州','广州','NULL','4500','2018/7/1 14:37:50','1'),
( '51','廷宇','廷宇','123456','0','22','NULL','1','15093390050','0','广州','广州','NULL','4500','2018/7/1 14:37:51','1'),
( '52','金喜','金喜','123456','0','22','NULL','1','15093390051','0','广州','广州','NULL','4500','2018/7/1 14:37:52','1'),
( '53','熙雷','熙雷','123456','0','22','NULL','1','15093390052','0','广州','广州','NULL','5000','2018/7/1 14:37:53','1'),
( '54','健栋','健栋','123456','0','22','NULL','1','15093390053','0','广州','广州','NULL','5000','2018/7/1 14:37:54','1'),
( '55','道宸','道宸','123456','0','22','NULL','1','15093390054','0','广州','广州','NULL','5000','2018/7/1 14:37:55','1'),
( '56','恒元','恒元','123456','0','22','NULL','1','15093390055','0','广州','广州','NULL','5000','2018/7/1 14:37:56','1'),
( '57','品中','品中','123456','0','22','NULL','1','15093390056','0','广州','广州','NULL','5000','2018/7/1 14:37:57','1'),
( '58','俊宗','俊宗','123456','2','31','NULL','1','15093390057','2','广州','广州','NULL','5000','2018/7/1 14:37:58','1'),
( '59','权敬','权敬','123456','2','31','NULL','1','15093390058','2','广州','广州','NULL','5000','2018/7/1 14:37:59','1'),
( '60','炫奕','炫奕','123456','2','31','NULL','1','15093390059','2','广州','广州','NULL','5000','2018/7/1 14:37:60','1'),
( '61','敬辰','敬辰','123456','2','31','NULL','1','15093390060','2','广州','广州','NULL','5000','2018/7/1 14:37:61','1'),
( '62','喜飞','喜飞','123456','2','31','NULL','1','15093390061','2','广州','广州','NULL','5000','2018/7/1 14:37:62','1'),
( '63','以枫','以枫','123456','2','31','NULL','1','15093390062','2','广州','广州','NULL','5000','2018/7/1 14:37:63','1'),
( '64','城麟','城麟','123456','2','31','NULL','1','15093390063','2','广州','广州','NULL','5000','2018/7/1 14:37:64','1'),
( '65','君伊','君伊','123456','2','31','NULL','1','15093390064','2','广州','广州','NULL','5000','2018/7/1 14:37:65','1'),
( '66','世家','世家','123456','2','31','NULL','1','15093390065','2','广州','广州','NULL','5500','2018/7/1 14:37:66','1'),
( '67','克顺','克顺','123456','2','25','NULL','1','15093390066','2','广州','广州','NULL','5500','2018/7/1 14:37:67','1'),
( '68','蓝宇','蓝宇','123456','2','25','NULL','1','15093390067','2','广州','广州','NULL','5500','2018/7/1 14:37:68','1'),
( '69','炎敬','炎敬','123456','2','25','NULL','1','15093390068','2','厦门','厦门','NULL','5500','2018/7/1 14:37:69','1'),
( '70','品聪','品聪','123456','2','25','NULL','1','15093390069','2','厦门','厦门','NULL','5500','2018/7/1 14:37:70','1'),
( '71','楠泽','楠泽','123456','2','25','NULL','1','15093390070','2','厦门','厦门','NULL','5500','2018/7/1 14:37:71','1'),
( '72','祥朝','祥朝','123456','2','25','NULL','1','15093390071','2','厦门','厦门','NULL','5500','2018/7/1 14:37:72','1'),
( '73','伦翔','伦翔','123456','2','25','NULL','1','15093390072','2','厦门','厦门','NULL','5500','2018/7/1 14:37:73','1'),
( '74','汉瑄','汉瑄','123456','2','25','NULL','1','15093390073','2','厦门','厦门','NULL','5500','2018/7/1 14:37:74','1'),
( '75','弘彪','弘彪','123456','2','25','NULL','1','15093390074','2','厦门','厦门','NULL','5500','2018/7/1 14:37:75','1'),
( '76','楠颂','楠颂','123456','2','27','NULL','1','15093390075','2','厦门','厦门','NULL','5500','2018/7/1 14:37:76','1'),
( '77','青纶','青纶','123456','2','27','NULL','1','15093390076','2','厦门','厦门','NULL','5500','2018/7/1 14:37:77','1'),
( '78','庆辉','庆辉','123456','2','27','NULL','1','15093390077','2','厦门','厦门','NULL','5500','2018/7/1 14:37:78','1'),
( '79','山绍','山绍','123456','2','27','NULL','1','15093390078','2','厦门','厦门','NULL','6500','2018/7/1 14:37:79','1'),
( '80','君建','君建','123456','2','27','NULL','1','15093390079','2','厦门','厦门','NULL','6500','2018/7/1 14:37:80','1'),
( '81','安云','安云','123456','2','27','NULL','1','15093390080','2','厦门','厦门','NULL','6500','2018/7/1 14:37:81','1'),
( '82','智宇','智宇','123456','2','27','NULL','1','15093390081','2','厦门','厦门','NULL','6500','2018/7/1 14:37:82','1'),
( '83','峰启','峰启','123456','2','27','NULL','1','15093390082','2','厦门','厦门','NULL','6500','2018/7/1 14:37:83','1'),
( '84','浩宏','浩宏','123456','2','27','NULL','1','15093390083','2','厦门','厦门','NULL','6500','2018/7/1 14:37:84','1'),
( '85','才聪','才聪','123456','2','27','NULL','1','15093390084','2','厦门','厦门','NULL','6500','2018/7/1 14:37:85','1'),
( '86','朋元','朋元','123456','2','27','NULL','1','15093390085','2','厦门','厦门','NULL','6500','2018/7/1 14:37:86','1'),
( '87','楠朋','楠朋','123456','2','27','NULL','1','15093390086','2','厦门','厦门','NULL','6500','2018/7/1 14:37:87','1'),
( '88','彪勤','彪勤','123456','2','27','NULL','1','15093390087','2','厦门','厦门','NULL','6500','2018/7/1 14:37:88','1'),
( '89','嘉家','嘉家','123456','2','27','NULL','1','15093390088','2','厦门','厦门','NULL','6500','2018/7/1 14:37:89','1'),
( '90','侨蓝','侨蓝','123456','2','27','NULL','1','15093390089','2','厦门','厦门','NULL','6500','2018/7/1 14:37:90','1'),
( '91','颂楠','颂楠','123456','2','27','NULL','1','15093390090','2','厦门','厦门','NULL','6500','2018/7/1 14:37:91','1'),
( '92','恩伟','恩伟','123456','2','36','NULL','1','15093390091','2','厦门','厦门','NULL','6500','2018/7/1 14:37:92','1'),
( '93','才亮','才亮','123456','2','36','NULL','1','15093390092','2','厦门','厦门','NULL','6500','2018/7/1 14:37:93','1'),
( '94','田锌','田锌','123456','2','36','NULL','1','15093390093','2','郑州','郑州','NULL','8000','2018/7/1 14:37:94','1'),
( '95','力杉','力杉','123456','2','36','NULL','1','15093390094','2','郑州','郑州','NULL','8000','2018/7/1 14:37:95','1'),
( '96','颂希','颂希','123456','2','36','NULL','1','15093390095','2','郑州','郑州','NULL','8000','2018/7/1 14:37:96','1'),
( '97','锋振','锋振','123456','2','36','NULL','1','15093390096','2','郑州','郑州','NULL','8000','2018/7/1 14:37:97','1'),
( '98','茂河','茂河','123456','2','36','NULL','1','15093390097','2','郑州','郑州','NULL','8000','2018/7/1 14:37:98','1'),
( '99','曦健','曦健','123456','2','36','NULL','1','15093390098','2','郑州','郑州','NULL','8000','2018/7/1 14:37:99','1'),
( '100','言皓','言皓','123456','2','36','NULL','1','15093390099','2','郑州','郑州','NULL','8000','2018/7/1 14:37:100','1'),
( '101','承树','承树','123456','2','36','NULL','1','15093390100','2','郑州','郑州','NULL','8000','2018/7/1 14:37:101','1'),
( '102','楚嘉','楚嘉','123456','2','21','NULL','1','15093390101','2','郑州','郑州','NULL','8000','2018/7/1 14:37:102','1'),
( '103','泰刚','泰刚','123456','2','21','NULL','1','15093390102','2','郑州','郑州','NULL','8000','2018/7/1 14:37:103','1'),
( '104','林浩','林浩','123456','2','21','NULL','1','15093390103','2','郑州','郑州','NULL','8900','2018/7/1 14:37:104','1'),
( '105','群彪','群彪','123456','2','21','NULL','1','15093390104','2','郑州','郑州','NULL','8900','2018/7/1 14:37:105','1'),
( '106','同松','同松','123456','2','21','NULL','1','15093390105','2','郑州','郑州','NULL','8900','2018/7/1 14:37:106','1'),
( '107','祖贤','祖贤','123456','2','21','NULL','1','15093390106','2','郑州','郑州','NULL','8900','2018/7/1 14:37:107','1'),
( '108','雷威','雷威','123456','2','21','NULL','1','15093390107','2','郑州','郑州','NULL','8900','2018/7/1 14:37:108','1'),
( '109','升恒','升恒','123456','2','21','NULL','1','15093390108','2','郑州','郑州','NULL','8900','2018/7/1 14:37:109','1'),
( '110','天慧','天慧','123456','2','21','NULL','1','15093390109','2','郑州','郑州','NULL','8900','2018/7/1 14:37:110','1'),
( '111','成健','成健','123456','2','21','NULL','1','15093390110','2','郑州','郑州','NULL','8900','2018/7/1 14:37:111','1'),
( '112','骏颖','骏颖','123456','2','21','NULL','1','15093390111','2','郑州','郑州','NULL','8900','2018/7/1 14:37:112','1'),
( '113','达秋','达秋','123456','2','21','NULL','1','15093390112','2','郑州','郑州','NULL','8900','2018/7/1 14:37:113','1'),
( '114','洋奕','洋奕','123456','2','21','NULL','1','15093390113','2','郑州','郑州','NULL','9000','2018/7/1 14:37:114','1'),
( '115','秦腾','秦腾','123456','2','21','NULL','1','15093390114','2','郑州','郑州','NULL','9000','2018/7/1 14:37:115','1'),
( '116','钧源','钧源','123456','2','21','NULL','1','15093390115','2','郑州','郑州','NULL','9000','2018/7/1 14:37:116','1'),
( '117','成鸣','成鸣','123456','2','21','NULL','1','15093390116','2','郑州','郑州','NULL','9000','2018/7/1 14:37:117','1'),
( '118','龙才','龙才','123456','2','21','NULL','1','15093390117','2','郑州','郑州','NULL','9000','2018/7/1 14:37:118','1'),
( '119','慧恒','慧恒','123456','2','38','NULL','1','15093390118','2','郑州','郑州','NULL','9000','2018/7/1 14:37:119','1'),
( '120','敬顺','敬顺','123456','2','38','NULL','1','15093390119','2','郑州','郑州','NULL','9000','2018/7/1 14:37:120','1'),
( '121','逸纯','逸纯','123456','2','38','NULL','1','15093390120','2','郑州','郑州','NULL','9000','2018/7/1 14:37:121','1'),
( '122','骏奕','骏奕','123456','2','38','NULL','1','15093390121','2','郑州','郑州','NULL','10000','2018/7/1 14:37:122','1'),
( '123','金栋','金栋','123456','2','38','NULL','1','15093390122','2','郑州','郑州','NULL','10000','2018/7/1 14:37:123','1'),
( '124','良品','良品','123456','2','38','NULL','1','15093390123','2','郑州','郑州','NULL','10000','2018/7/1 14:37:124','1'),
( '125','平嘉','平嘉','123456','2','38','NULL','1','15093390124','2','郑州','郑州','NULL','10000','2018/7/1 14:37:125','1'),
( '126','生锦','生锦','123456','2','38','NULL','1','15093390125','2','郑州','郑州','NULL','10000','2018/7/1 14:37:126','1'),
( '127','中哲','中哲','123456','2','38','NULL','1','15093390126','2','郑州','郑州','NULL','10000','2018/7/1 14:37:127','1'),
( '128','俊阳','俊阳','123456','2','38','NULL','1','15093390127','2','郑州','郑州','NULL','10000','2018/7/1 14:37:128','1'),
( '129','畅亚','畅亚','123456','2','38','NULL','1','15093390128','2','郑州','郑州','NULL','10000','2018/7/1 14:37:129','1'),
( '130','澄驰','澄驰','123456','2','38','NULL','1','15093390129','2','郑州','郑州','NULL','10000','2018/7/1 14:37:130','1');
