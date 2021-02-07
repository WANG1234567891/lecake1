SET NAMES UTF8;
DROP DATABASE IF EXISTS ck;
CREATE DATABASE ck CHARSET=UTF8;
USE ck;

--/**蛋糕家族**/
CREATE TABLE ck_product_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,
  fname VARCHAR(32)
);
--/**蛋糕**/
CREATE TABLE product_cake(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  family_id INT,              #所属型号家族编号
  title VARCHAR(128),         #主标题
  details VARCHAR(1024),      #广告语
  img VARCHAR(128),			  #商品图片
  _weight VARCHAR(32),        #重量
  tableware VARCHAR(32),      #餐具套数
  people VARCHAR(32),         #食用人数
  deliveryTime VARCHAR(32),   #配送时间
  price DECIMAL(10,2),        #价格
  size INT                   #尺寸
);

--/**蛋糕购物车图片**/
CREATE TABLE ck_car_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  cack_id INT,              #蛋糕编号
  img1 VARCHAR(128),            #图片1路径
  img2 VARCHAR(128),            #图片2路径
  img3 VARCHAR(128)           #图片3路径
);
--/**蛋糕图片**/
CREATE TABLE ck_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  cack_id INT,              #蛋糕编号
  img1 VARCHAR(128),        #图片1路径
  img2 VARCHAR(128)        #图片2路径
);
--/**用户信息**/
CREATE TABLE ebeecake_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(32),
  password VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),
  user_name VARCHAR(32)    #用户名，如王小明
);

--/**收货地址信息**/
CREATE TABLE ebeecake_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  fixedphone VARCHAR(16),     #固定电话
  postcode CHAR(6),           #邮编
  tag VARCHAR(16),            #标签名
  is_default BOOLEAN          #是否为当前用户的默认收货地址
);

--/**购物车条目**/
CREATE TABLE ck_shoppingcart_item(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,      #用户编号
  product_id INT,   #商品编号
  count INT,        #购买数量
  size  INT       #购买尺寸
  -- is_checked BOOLEAN #是否已勾选，确定购买
);

--/**用户订单**/
CREATE TABLE ck_order(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  address_id INT,
  status INT,             #订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消
  order_time BIGINT,      #下单时间
  pay VARCHAR(16),        #付款方式
  deliver_time BIGINT,    #配送时间
  received_time BIGINT    #签收时间
)AUTO_INCREMENT=10000000;

--/**用户订单**/
CREATE TABLE ck_order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,           #订单编号
  product_id INT,         #产品编号
  count INT,               #购买数量
  size INT                  #购买尺寸
);

--/****首页轮播广告商品****/
CREATE TABLE ck_index_carousel(
  id INT PRIMARY KEY AUTO_INCREMENT,
  img VARCHAR(128)
);

--/****首页商品****/
CREATE TABLE ck_index_product(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64),
  details VARCHAR(128),
  pic1 VARCHAR(128),
  pic2 VARCHAR(128),
  price DECIMAL(10,2),
  href VARCHAR(128),
  seq_recommended TINYINT,
  seq_new_arrival TINYINT,
  seq_top_sale TINYINT
);

--******************
--******数据导入******
--*******************
--/**笔记本电脑型号家族*
INSERT INTO  ck_product_family VALUES
(NULL,'全部'),
(NULL,'巧克力'),
(NULL,'芝士'),
(NULL,'慕斯'),
(NULL,'冰淇淋'),
(NULL,'含酒'),
(NULL,'奶油'),
(NULL,'水果'),
(NULL,'咖啡');

--/**首页轮播图**/
INSERT INTO ck_index_carousel VALUES
(NULL,'http://localhost:3000/img/banner_img/wb(1).jpg'),
(NULL,'http://localhost:3000/img/banner_img/wb(2).jpg'),
(NULL,'http://localhost:3000/img/banner_img/wb(3).jpg'),
(NULL,'http://localhost:3000/img/banner_img/wb(4).jpg'),
(NULL,'http://localhost:3000/img/banner_img/wb(5).jpg');
-- /**蛋糕表**/
INSERT INTO product_cake VALUES
(NULL,2,'偏爱|海盐黑巧慕斯蛋糕','黑巧蜜语，诉说真挚的爱。醇香浓滑的巧克力，是可可豆的神奇蜕变之旅，它由一颗爱的种子开始，慢慢结出幸福的果实，甜蜜的事，要与TA，一起分享。','http://localhost:3000/img/cack_img/1.jpg','1.4磅(≥650克)','+6套餐具','适合3-6人食用','最早明日08:30配送','295',18),
(NULL,8,'水果缤纷米蛋糕','香甜嫩滑的新鲜水果果肉蕴藏丰富果汁，搭配手工无麸质米粉坯与淡奶油的细腻绵柔，给你多一份的新鲜与曼妙味觉享受。','http://localhost:3000/img/cack_img/2.jpg','1.5磅(≥680克)','+6套餐具','适合3-6人食用','最早22:30配送','225',16),
(NULL,3,'初心|牛油果蛋糕','牛油果的清香弥漫在口腔，和着乳清奶酪咀嚼，仿佛热带的阳光，洒满心房，也惊叹牛油果的神奇，包容所有的味道，升华所有的味觉，伟大的感动，总在不言中。','http://localhost:3000/img/cack_img/3.jpg','1.5磅(≥700克)','+6套餐具','适合3-6人食用','最早22:30配送','335',16),
(NULL,4,'简单|蜂蜜蛋糕','缘份是城市里命定的希望，我们注定快乐，但却远离喧嚣。一种天使般的淡然，就像甜杏仁牵手热情果般的美妙滋味，忽视了谁，都不显完整。','http://localhost:3000/img/cack_img/4.jpg','1.6磅(≥750克)','+6套餐具','适合3-6人食用','最早23:00配送','915',26),
(NULL,4,'热恋|玫瑰慕斯蛋糕','深情犹如芳香的玫瑰酱，挑战你挑剔的味蕾，回味悠长，无力抗拒；没有疲倦，无尽纠缠，沉浸在幸福海洋；只有爱着的才能体会那永远深藏。','http://localhost:3000/img/cack_img/5.jpg','1.4磅(≥650克)','+6套餐具','适合3~6人食用','最早23:00配送',315,16),
(NULL,8,'向往|酸樱桃椰蓉蛋糕','聆听海的声音，体会自然的清新，依然执着对你的向往。清香味道，驻足停畔，奔放不失优雅，亦真亦幻。','http://localhost:3000/img/cack_img/6.jpg','.4磅(≥650克)','+6套餐具','适合3-6人食用','最早23:00配送',225,16),
(NULL,8,'珍贵|芒果慕斯蛋糕','果肉多汁，鲜美可口，那诱人的清香酸甜，沁人心脾，直达内心需要灌溉的干枯，如此美丽的滋润着每个需要的角落。','http://localhost:3000/img/cack_img/7.jpg','1.6磅(≥750克)','+6套餐具','适合3~6人食用','最早23:00配送',335,16),
(NULL,9,'迷恋|提拉米苏蛋糕','凌晨未觉醒的记忆，午夜巴塞罗那的歌声，口中badabada的节奏感…淡淡的咖啡包容着纯纯的奶香，那是情绪里就有的味道。','http://localhost:3000/img/cack_img/8.jpg','1.2磅(≥550克','+6套餐具','适合3~6人食用','最早23:00配送',265,16),
(NULL,2,'菩提|香浓巧克力蛋糕','渐行渐远的背影神忘于菩提树下，虽没人规定过那些尘埃般的光阴，但时间却依然洋洋洒洒……惊叹她的浓郁，恍然知道真谛，犹如豁然品味到的纯美精华。','http://localhost:3000/img/cack_img/9.jpg','1.1磅(≥500克)','+3套餐具','适合1-3人食用','最早23:30配送',185,16),
(NULL,2,'经典|坚果巧克力蛋糕','隐藏奢华，犹如丰富的夹层与馅料，被细腻醇厚的巧克力酱所包裹，不露锋芒。脉络清晰的巧克力树叶，简约却不简单。轻咬一口，便想让时间停留在这美好的时刻。','http://localhost:3000/img/cack_img/10.jpg','1.4磅(≥650克)','+6套餐具','适合3~6人食用','最早23:30配送',335,16),
(NULL,2,'回味|枫糖威士忌坚果巧克力蛋糕','谷物酿造的威士忌，配着轻盈淡雅的枫糖，浅斟慢酌；香脆坚果被巧克力熊抱，感受着调皮与柔情；回味时永远记得的你留下的美好滋味，弥足珍贵。','http://localhost:3000/img/cack_img/11.jpg','1.9磅(≥900克)','+6套餐具','适合3-6人食用','最早23:30配送',495,16),
(NULL,2,'榛爱|黑巧克力榛子蛋糕','自然的狂欢，生命的派对，浓情后的感悟，灵动的碰触沁人心脾，浓厚榛香带来多重口感，煞那间生命无与伦比。','http://localhost:3000/img/cack_img/12.jpg','1.6磅(≥750克','+6套餐具','适合3~6人食用','最早23:30配送',265,16),
(NULL,3,'回归|70蛋糕','收起散落在路上的珍贵点滴，每个年代都有属于自己的童年记忆，70的淡定、80的率性、90的不羁??思绪总是在不曾提起的故事里静静流淌，掠过往事，找寻简单的快乐。','http://localhost:3000/img/cack_img/13.jpg','1.6磅/1.6磅(≥750克)','+6套餐具','适合3-6人食用','最早23:30配送',225,16),
(NULL,3,'回归|80蛋糕','收起散落在路上的珍贵点滴，每个年代都有属于自己的童年记忆，70的淡定、80的率性、90的不羁??思绪总是在不曾提起的故事里静静流淌，掠过往事，找寻简单的快乐。','http://localhost:3000/img/cack_img/14.jpg','1.7磅/1.7磅(≥800克)','+6套餐具','适合3-6人食用','最早明日08:30配送',225,16),
(NULL,3,'回归|90蛋糕','收起散落在路上的珍贵点滴，每个年代都有属于自己的童年记忆，70的淡定、80的率性、90的不羁??思绪总是在不曾提起的故事里静静流淌，掠过往事，找寻简单的快乐。','http://localhost:3000/img/cack_img/15.jpg','1.6磅/1.6磅(≥750克)','+6套餐具','适合3-6人食用','最早明日08:30配送',225,16),
(NULL,3,'我愿意|玫瑰荔枝慕斯蛋糕','亲爱的，我爱你，以后就这样看着你，每一天有同样呼吸，你是否愿意？亲爱的，我需要你，再往前走那一小步，准备了你要的幸福，等你说：我愿意，这是世间最动人的回应！','http://localhost:3000/img/cack_img/16.jpg','1.5磅(≥700克)','+6套餐具','适合3-6人食用','最早明日08:30配送',335,17),
(NUll,7,'珍味|沙棘任小米蛋糕','乳清芝士与特制沙棘酱结合之下的极简之风，就像沙棘治愈着沙漠那般风景如画，更像一首无言的诗。节水小米与沙棘作为内核激发出蛋糕酸甜清爽口感，奶酪飘香浸润舌尖。','http://localhost:3000/img/cack_img/17.jpg','2.2磅(≥1000克)','+6套餐具','适合5~6人食用','最早明日08:30配送',335,20);

-- /**用户信息**/
-- INSERT INTO xz_user VALUES
-- (NULL, 'dingding', '123456', 'ding@qq.com', '13501234567', 'img/avatar/default.png', '丁伟', '1'),
-- (NULL, 'dangdang', '123456', 'dang@qq.com', '13501234568', 'img/avatar/default.png', '林当', '1'),
-- (NULL, 'doudou', '123456', 'dou@qq.com', '13501234569', 'img/avatar/default.png', '窦志强', '1'),
-- (NULL, 'yaya', '123456', 'ya@qq.com', '13501234560', 'img/avatar/default.png', '秦小雅', '0');

-- /****首页商品****/
-- INSERT INTO xz_index_product VALUES
-- (NULL, 'Apple MacBook Air系列', '酷睿双核i5处理器|256GB SSD|8GB内存|英特尔HD显卡620含共享显卡内存', 'img/index/study_computer_img1.png', 6988, 'product_details.html?lid=1', 1, 1, 1),
-- (NULL, '小米Air 金属超轻薄', '酷睿双核i5处理器|512GB SSD|2GB内存|英特尔HD独立显卡', 'img/index/study_computer_img2.png', 3488, 'product_details.html?lid=5', 2, 2, 2),
-- (NULL, '联想E480C 轻薄系列', '酷睿双核i7处理器|256GB SSD|4GB内存|英特尔HD显卡680M', 'img/index/study_computer_img3.png', 5399, 'product_details.html?lid=9', 3, 3, 3),
-- (NULL, '华硕RX310 金属超极本', '酷睿双核i5处理器|512GB SSD|4GB内存|英特尔HD游戏级显卡', 'img/index/study_computer_img4.png', 4966, 'product_details.html?lid=13', 4, 4, 4),
-- (NULL, '联想小新700 电竞版游戏本', '酷睿双核i7处理器|1TGB SSD|8GB内存|英特尔HD显卡620含共享显卡内存', 'img/index/study_computer_img5.png', 6299, 'product_details.html?lid=17', 5, 5, 5),
-- (NULL, '戴尔灵越燃7000 轻薄窄边', '酷睿双核i5处理器|512GB SSD|2GB内存|英特尔HD显卡', 'img/index/study_computer_img3.png', 5199, 'product_details.html?lid=19', 6, 6, 6),
-- (NULL, '神州战神Z7M 高性价比游戏本', '酷睿双核i7处理器|1TGB SSD|8GB内存|英特尔HD游戏机独立显卡', 'img/index/study_computer_img4.png', 5799, 'product_details.html?lid=38', 0, 0, 0);

