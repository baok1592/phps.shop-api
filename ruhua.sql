/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : ruhua102

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2019-01-09 23:11:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for qy_admins
-- ----------------------------
DROP TABLE IF EXISTS `qy_admins`;
CREATE TABLE `qy_admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `password` varchar(60) NOT NULL,
  `group_id` tinyint(4) NOT NULL COMMENT '管理组ID',
  `ip` varchar(30) NOT NULL,
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `description` varchar(200) NOT NULL,
  `login_time` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qy_admins
-- ----------------------------
INSERT INTO `qy_admins` VALUES ('1', 'admin', '074fc4bdfe264122798ab855824e21b6', '1', '', '0', '123', '0', '1536931075');
INSERT INTO `qy_admins` VALUES ('4', 'ruhua', '074fc4bdfe264122798ab855824e21b6', '1', '', '0', 'psw:123456', '0', '1537453403');

-- ----------------------------
-- Table structure for qy_article
-- ----------------------------
DROP TABLE IF EXISTS `qy_article`;
CREATE TABLE `qy_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文章编号',
  `title` varchar(50) NOT NULL COMMENT '文章标题',
  `summary` varchar(140) NOT NULL DEFAULT '' COMMENT '文章摘要',
  `content` text NOT NULL COMMENT '文章正文',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '文章标题图片',
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-显示、1-隐藏',
  `author` varchar(50) NOT NULL COMMENT '发布者用户名 ',
  `create_time` int(11) DEFAULT '0' COMMENT '文章发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=6553 COMMENT='CMS文章表';

-- ----------------------------
-- Records of qy_article
-- ----------------------------
INSERT INTO `qy_article` VALUES ('7', '售后服务', '', '这里是内容填写，这里是内容填写，这里是内容填写，这里是内容填写，这里是内容填写', '', '0', 'admin', '1537432741');
INSERT INTO `qy_article` VALUES ('8', '关于我们', '', '网址：www.phps.shop\n如花拼团属个人开发，永久开源免费，欢迎使用交流', '', '0', 'admin', '1537518357');

-- ----------------------------
-- Table structure for qy_banner
-- ----------------------------
DROP TABLE IF EXISTS `qy_banner`;
CREATE TABLE `qy_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT 'Banner名称，通常作为标识',
  `description` varchar(255) DEFAULT NULL COMMENT 'Banner描述',
  `delete_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='banner管理表';

-- ----------------------------
-- Records of qy_banner
-- ----------------------------
INSERT INTO `qy_banner` VALUES ('1', 'index_banner', '首页banner位', null, null);

-- ----------------------------
-- Table structure for qy_banner_item
-- ----------------------------
DROP TABLE IF EXISTS `qy_banner_item`;
CREATE TABLE `qy_banner_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img_id` int(11) NOT NULL COMMENT '外键，关联image表',
  `key_word` varchar(100) NOT NULL COMMENT '执行关键字，根据不同的type含义不同',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '跳转类型，可能导向商品，可能导向专题，可能导向其他。0，无导向；1：导向商品;2:导向专题',
  `delete_time` int(11) DEFAULT NULL,
  `banner_id` int(11) NOT NULL COMMENT '外键，关联banner表',
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='banner子项表';

-- ----------------------------
-- Records of qy_banner_item
-- ----------------------------
INSERT INTO `qy_banner_item` VALUES ('1', '266', '1', '1', null, '1', '1537431597');
INSERT INTO `qy_banner_item` VALUES ('2', '267', '2', '1', null, '1', '1537431603');
INSERT INTO `qy_banner_item` VALUES ('4', '276', 'xx', '1', null, '1', '1546577999');

-- ----------------------------
-- Table structure for qy_category
-- ----------------------------
DROP TABLE IF EXISTS `qy_category`;
CREATE TABLE `qy_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL DEFAULT '',
  `short_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品分类简称 ',
  `pid` int(11) NOT NULL DEFAULT '0',
  `level` tinyint(4) NOT NULL DEFAULT '0',
  `is_visible` int(11) NOT NULL DEFAULT '1' COMMENT '是否显示  1 显示 0 不显示',
  `sort` int(11) DEFAULT NULL,
  `category_pic` varchar(255) NOT NULL DEFAULT '' COMMENT '商品分类图片',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=244 COMMENT='商品分类表';

-- ----------------------------
-- Records of qy_category
-- ----------------------------
INSERT INTO `qy_category` VALUES ('1', '家用电器', '家电', '0', '1', '1', '0', '81');
INSERT INTO `qy_category` VALUES ('2', '电视机', '电视', '1', '2', '1', '0', '82');
INSERT INTO `qy_category` VALUES ('3', '空调', '空调', '1', '2', '1', '0', '83');
INSERT INTO `qy_category` VALUES ('4', '洗衣机', '洗衣机', '1', '2', '1', '0', '108');
INSERT INTO `qy_category` VALUES ('5', '手机/数码', '手机/数码', '0', '1', '1', '0', '84');
INSERT INTO `qy_category` VALUES ('6', '手机通讯', '手机通讯', '5', '2', '1', '0', '109');
INSERT INTO `qy_category` VALUES ('7', '手机配件', '手机配件', '5', '2', '1', '0', '85');
INSERT INTO `qy_category` VALUES ('8', '摄影摄像', '摄影摄像', '5', '2', '1', '0', '86');
INSERT INTO `qy_category` VALUES ('9', '数码配件', '数码配件', '5', '2', '1', '0', '87');
INSERT INTO `qy_category` VALUES ('10', '电脑/办公', '电脑/办公', '0', '1', '1', '0', '88');
INSERT INTO `qy_category` VALUES ('11', '电脑整机', '电脑', '10', '2', '1', '0', '89');
INSERT INTO `qy_category` VALUES ('12', '电脑配件', '电脑配件', '10', '2', '1', '0', '90');
INSERT INTO `qy_category` VALUES ('13', '外设产品', '外设产品', '10', '2', '1', '0', '91');
INSERT INTO `qy_category` VALUES ('14', '办公设备', '办公设备', '10', '2', '1', '0', '92');
INSERT INTO `qy_category` VALUES ('15', '家居/家具', '家居/家具', '0', '1', '1', '0', '93');
INSERT INTO `qy_category` VALUES ('16', '厨具', '厨具', '15', '2', '1', '0', '94');
INSERT INTO `qy_category` VALUES ('17', '家纺', '家纺', '15', '2', '1', '0', '95');
INSERT INTO `qy_category` VALUES ('18', '灯具', '灯具', '15', '2', '1', '0', '96');
INSERT INTO `qy_category` VALUES ('19', '家具', '家具', '15', '2', '1', '0', '97');
INSERT INTO `qy_category` VALUES ('20', '男装/女装', '服装', '0', '1', '1', '0', '270');
INSERT INTO `qy_category` VALUES ('21', '女装', '女装', '20', '2', '1', '0', '99');
INSERT INTO `qy_category` VALUES ('22', '男装', '男装', '20', '2', '1', '0', '100');
INSERT INTO `qy_category` VALUES ('23', '内衣', '内衣', '20', '2', '1', '0', '101');
INSERT INTO `qy_category` VALUES ('24', '配饰', '配饰', '20', '2', '1', '0', '102');
INSERT INTO `qy_category` VALUES ('25', '美妆/个护清洁', '美妆/个护清洁', '0', '1', '1', '0', '103');
INSERT INTO `qy_category` VALUES ('26', '面部护肤', '面部护肤', '25', '2', '1', '0', '104');
INSERT INTO `qy_category` VALUES ('27', '香水彩妆', '香水彩妆', '25', '2', '1', '0', '105');
INSERT INTO `qy_category` VALUES ('28', '男士护肤', '男士护肤', '25', '2', '1', '0', '106');
INSERT INTO `qy_category` VALUES ('29', '洗发护发', '洗发护发', '25', '2', '1', '0', '107');
INSERT INTO `qy_category` VALUES ('30', '安装维修', '安装维修', '0', '1', '1', '0', '258');
INSERT INTO `qy_category` VALUES ('31', '安装空调', '安装空调', '30', '2', '1', '0', '259');
INSERT INTO `qy_category` VALUES ('32', '家电维修', '家电维修', '30', '2', '1', '0', '261');
INSERT INTO `qy_category` VALUES ('33', '玩具', '玩具', '0', '1', '1', '0', '269');
INSERT INTO `qy_category` VALUES ('34', '益智', '益智', '33', '2', '1', '0', '263');
INSERT INTO `qy_category` VALUES ('35', '数码玩具', '数码玩具', '33', '2', '1', '0', '265');

-- ----------------------------
-- Table structure for qy_favorites
-- ----------------------------
DROP TABLE IF EXISTS `qy_favorites`;
CREATE TABLE `qy_favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `fav_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品或店铺ID',
  `type` varchar(20) NOT NULL DEFAULT 'goods' COMMENT '类型:goods为商品,shop为店铺,默认为商品',
  `img_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品收藏时价格',
  `create_time` int(11) DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192 COMMENT='收藏表';

-- ----------------------------
-- Records of qy_favorites
-- ----------------------------

-- ----------------------------
-- Table structure for qy_goods
-- ----------------------------
DROP TABLE IF EXISTS `qy_goods`;
CREATE TABLE `qy_goods` (
  `goods_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品id(SKU)',
  `goods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `style` int(11) NOT NULL DEFAULT '0' COMMENT '0拼团1普通商品',
  `shop_id` int(10) unsigned NOT NULL DEFAULT '1' COMMENT '店铺id',
  `shop_name` varchar(400) NOT NULL COMMENT '店铺名称',
  `category_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `people` tinyint(4) NOT NULL DEFAULT '2' COMMENT '拼团满足人数',
  `brand_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '品牌id',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '拼团价格',
  `only_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单独购买价格',
  `cost_price` decimal(19,2) NOT NULL DEFAULT '0.00' COMMENT '成本价',
  `point_exchange_type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '积分兑换类型 0 非积分兑换 1 只能积分兑换 ',
  `point_exchange` int(11) NOT NULL DEFAULT '0' COMMENT '积分兑换',
  `give_point` int(11) NOT NULL DEFAULT '0' COMMENT '购买商品赠送积分',
  `is_member_discount` int(1) NOT NULL DEFAULT '0' COMMENT '参与会员折扣',
  `shipping_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '运费 0为免运费',
  `shipping_fee_id` int(11) NOT NULL DEFAULT '0' COMMENT '售卖区域id 物流模板id  ns_order_shipping_fee 表id',
  `stock` int(10) NOT NULL DEFAULT '0' COMMENT '商品库存',
  `max_buy` int(11) NOT NULL DEFAULT '0' COMMENT '限购 0 不限购',
  `clicks` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '商品点击数量',
  `min_stock_alarm` int(11) NOT NULL DEFAULT '0' COMMENT '库存预警值',
  `sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销售数量',
  `collects` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `star` tinyint(3) unsigned NOT NULL DEFAULT '5' COMMENT '好评星级',
  `evaluates` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价数',
  `shares` int(11) NOT NULL DEFAULT '0' COMMENT '分享数',
  `province_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一级地区id',
  `city_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '二级地区id',
  `img_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品主图',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '商品关键词',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '商品简介，促销语',
  `content` text NOT NULL COMMENT '商品详情',
  `QRcode` varchar(255) NOT NULL DEFAULT '' COMMENT '商品二维码',
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT '商家编号',
  `is_hot` int(1) NOT NULL DEFAULT '0' COMMENT '是否热销商品',
  `is_recommend` int(1) NOT NULL DEFAULT '0' COMMENT '是否推荐',
  `is_new` int(1) NOT NULL DEFAULT '0' COMMENT '是否新品',
  `state` tinyint(3) NOT NULL DEFAULT '1' COMMENT '商品状态 0下架，1正常，10违规（禁售）',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `img_id_array` varchar(1000) DEFAULT NULL COMMENT '商品图片序列',
  `sku_img_array` varchar(1000) DEFAULT NULL COMMENT '商品sku应用图片列表  属性,属性值，图片ID',
  `real_sales` int(10) NOT NULL DEFAULT '0' COMMENT '实际销量',
  `goods_attribute_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品类型',
  `goods_spec_format` text NOT NULL COMMENT '商品规格',
  `goods_weight` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品重量',
  `goods_volume` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '商品体积',
  `shipping_fee_type` int(11) NOT NULL DEFAULT '1' COMMENT '计价方式1.重量2.体积3.计件',
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供货商id',
  `sale_date` int(11) DEFAULT '0' COMMENT '上下架时间',
  `create_time` int(11) DEFAULT '0' COMMENT '商品添加时间',
  `update_time` int(11) DEFAULT '0' COMMENT '商品编辑时间',
  `min_buy` int(11) NOT NULL DEFAULT '0' COMMENT '最少买几件',
  `virtual_goods_type_id` int(11) DEFAULT '0' COMMENT '虚拟商品类型id',
  `production_date` int(11) NOT NULL DEFAULT '0' COMMENT '生产日期',
  `shelf_life` varchar(50) NOT NULL DEFAULT '' COMMENT '保质期',
  `goods_video_address` varchar(455) DEFAULT '' COMMENT '商品视频地址，不为空时前台显示视频',
  `pc_custom_template` varchar(255) NOT NULL DEFAULT '' COMMENT 'pc端商品自定义模板',
  `wap_custom_template` varchar(255) NOT NULL DEFAULT '' COMMENT 'wap端商品自定义模板',
  `max_use_point` int(11) NOT NULL DEFAULT '0' COMMENT '积分抵现最大可用积分数 0为不可使用',
  `goods_unit` varchar(20) NOT NULL DEFAULT '' COMMENT '商品单位',
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`goods_id`),
  KEY `UK_ns_goods_brand_id` (`brand_id`),
  KEY `UK_ns_goods_category_id` (`category_id`),
  KEY `UK_ns_goods_goods_attribute_id` (`goods_attribute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16554 COMMENT='商品表';

-- ----------------------------
-- Records of qy_goods
-- ----------------------------
INSERT INTO `qy_goods` VALUES ('1', '夏普 (SHARP)LCD-60SU470A 60英寸 4K超高清', '0', '1', '', '2', '2', '0', '3299.00', '2299.00', '3199.00', '0.00', '0', '0', '0', '0', '0.00', '0', '111', '1', '0', '0', '25', '0', '5', '0', '0', '0', '0', '112', '', '', '', '', '', '0', '0', '0', '1', '0', '142,143,144', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536649662', '1537499841', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('2', '海尔（Haier) 滚筒洗衣机全自动 8公斤变频 双喷淋泡沫无残留 防霉 EG8012B39SU1', '1', '1', '', '4', '0', '0', '2599.00', '0.02', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '222', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '113', '', '', '', '', '', '1', '0', '0', '1', '0', '145,146,147', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536650081', '1536896347', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('3', '小天鹅（LittleSwan）8公斤变频滚筒洗衣机 1400转电机喷淋无残留 抗菌门封圈 TG80V20DG5', '1', '1', '', '4', '0', '0', '2399.00', '0.02', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '333', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '114', '', '', '', '', '', '1', '0', '0', '1', '0', '148,149,150', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536650373', '1536896347', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('4', '格力正1.5匹 变频 品圆 --测试商品', '1', '1', '', '3', '2', '0', '2999.00', '5.02', '5.02', '0.00', '0', '0', '0', '0', '0.00', '0', '444', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '115', '', '', '', '', '', '1', '0', '0', '1', '0', '151,152,153', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536650841', '1537441369', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('5', '奥克斯  正1.5匹 一级能效 --测试商品', '0', '1', '', '31', '2', '0', '2799.00', '0.02', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '555', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '116', '', '', '', '', '', '0', '0', '0', '1', '0', '154,155,156', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536650906', '1537422006', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('6', 'Apple iPhone 8 Plus --测试商品', '0', '1', '', '35', '2', '0', '5999.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '666', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '117', '', '', '', '', '', '0', '0', '0', '1', '0', '157,158,159', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536651551', '1537422948', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('7', '荣耀9i  幻夜黑 --测试商品', '1', '1', '', '6', '2', '0', '1299.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '777', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '118', '', '', '', '', '', '1', '1', '0', '1', '0', '160,161,162', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536651778', '1537441356', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('8', '尼康单反数码照相机 --测试商品', '0', '1', '', '34', '2', '0', '3000.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '884', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '119', '', '', '', '', '', '0', '0', '1', '1', '0', '163,164,165', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536652779', '1537422959', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('9', '索尼微单数码相机标准套装 --测试商品', '0', '1', '', '8', '2', '0', '3799.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '999', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '120', '', '', '', '', '', '0', '0', '0', '1', '0', '166,167,168', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536652881', '1537421461', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('10', '萌怀表手机扣指环扣支架--测试商品', '0', '1', '', '7', '2', '0', '20.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '10', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '121', '', '', '', '', '', '0', '0', '0', '1', '0', '169,170,171', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536653108', '1537233621', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('11', '戴尔游匣G3烈焰版--测试商品', '0', '1', '', '11', '2', '0', '6299.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '102', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '122', '', '', '', '', '', '0', '0', '0', '1', '0', '172,173,174', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536653303', '1537233503', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('12', '套装/CPU主板主机套装--测试商品', '0', '1', '', '12', '2', '0', '3799.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '122', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '123', '', '', '', '', '', '0', '0', '0', '1', '0', '175,176,177', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536653458', '1537233486', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('13', '希捷酷鱼系列 --测试商品', '0', '1', '', '12', '2', '0', '560.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '133', '2', '0', '0', '0', '0', '5', '0', '0', '0', '0', '124', '', '', '', '', '', '0', '0', '1', '1', '0', '178,179,180', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536653629', '1537421148', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('14', '普多功能三合一黑白激光一体机 --测试商品', '0', '1', '', '14', '2', '0', '1199.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '144', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '125', '', '', '', '', '', '0', '0', '0', '1', '0', '181,182,183', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536653909', '1537421079', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('15', '惠普彩色喷墨三合一', '0', '1', '', '14', '2', '0', '399.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '7', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '126', '', '', '<p style=\"text-align: center;\"><br/></p><p style=\"text-align: center;\">测试图文并茂居中对齐</p><p><br/></p><p style=\"text-align: center;\"><img src=\"https://wx.phps.shop//ue_upload/img/20190109/1547046207.jpg\" style=\"\" title=\"1547046207.jpg\"/></p><p><br/></p><p style=\"text-align: center;\">又是一段文字</p><p style=\"text-align: center;\"><img src=\"https://wx.phps.shop//ue_upload/img/20190109/1547046210.jpg\" style=\"\" title=\"1547046210.jpg\"/></p><p><br/></p>', '', '', '1', '1', '1', '1', '0', '184,185,186', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536654291', '1547046307', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('16', '美厨锅具套装 --测试商品', '0', '1', '', '16', '2', '0', '199.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '166', '2', '0', '0', '0', '0', '5', '0', '0', '0', '0', '127', '', '', '', '', '', '0', '1', '1', '1', '0', '187,188,189', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536654459', '1537233417', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('17', '拜格 锅具套装12件套--测试商品', '0', '1', '', '16', '2', '0', '179.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '177', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '128', '', '', '', '', '', '0', '0', '0', '1', '0', '190,191,192', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536654587', '1537233401', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('18', '南极人被芯家纺', '0', '1', '', '17', '2', '0', '99.00', '5.00', '13.00', '0.00', '0', '0', '0', '0', '0.00', '0', '188', '2', '0', '0', '0', '0', '5', '0', '0', '0', '0', '129', '', '', '', '', '', '1', '0', '1', '1', '0', '193,194,195', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536654681', '1537498948', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('19', '欧普照明吸顶灯具 --测试商品', '0', '1', '', '32', '2', '0', '129.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '188', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '130', '', '', '', '', '', '0', '0', '0', '1', '0', '196,197,198', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536654863', '1537422155', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('20', '欧质 布艺沙发', '0', '1', '', '19', '2', '0', '1199.00', '10.00', '11.00', '0.00', '0', '0', '0', '0', '0.00', '0', '199', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '131', '', '', '', '', '', '0', '0', '1', '1', '0', '199,200,201', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536655038', '1537498939', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('21', '七匹狼 短袖T恤男 --测试商品', '0', '1', '', '22', '2', '0', '169.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '21', '3', '0', '0', '0', '0', '5', '0', '0', '0', '0', '132', '', '', '', '', '', '0', '0', '0', '1', '0', '202,203,204', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536655282', '1537420590', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('22', '子牧棉麻2018秋季新品--测试商品', '0', '1', '', '21', '2', '0', '169.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '221', '2', '0', '0', '0', '0', '5', '0', '0', '0', '0', '133', '', '', '', '', '', '1', '0', '0', '1', '0', '205,206,207', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536655364', '1537233251', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('23', '子牧棉麻2018秋季新品民族风女装中式民国风改良旗袍复古假二件连衣裙9765 蓝色 L(建议100-110斤)', '0', '1', '', '21', '2', '0', '169.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '222', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '0', '', '', '', '', '', '0', '0', '0', '1', '0', null, null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536655458', '1536717507', '0', '0', '0', '', '', '', '', '0', '', '1536717507');
INSERT INTO `qy_goods` VALUES ('24', '宝姿女装2018秋季新品', '0', '1', '', '21', '2', '0', '6700.00', '9.30', '9.40', '0.00', '0', '0', '0', '0', '0.00', '0', '233', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '135', '', '', '', '', '', '1', '1', '0', '1', '0', '211,212,213', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536655581', '1537498932', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('25', '花花公子秋衣秋裤', '0', '1', '', '23', '2', '0', '99.00', '9.00', '9.20', '0.00', '0', '0', '0', '0', '0.00', '0', '244', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '136', '', '', '', '', '', '0', '1', '1', '0', '0', '214,215,216', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536655697', '1540292259', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('26', '衣服配饰四叶草装饰品项链女日韩毛衣链长款大气百搭夏季简约挂件 四叶草银色', '0', '1', '', '24', '2', '0', '49.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '25', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '137', '', '', '', '', '', '0', '0', '0', '1', '0', '217,218,219', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536655780', '1537158467', '0', '0', '0', '', '', '', '', '0', '', '1537158467');
INSERT INTO `qy_goods` VALUES ('27', 'SK-II\"神仙水\"75ml补水保湿精华露护肤套装（礼赠洁面霜+清莹露+面霜+眼霜 面部护肤 精华液）', '0', '1', '', '26', '2', '0', '800.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '26', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '138', '', '', '', '', '', '0', '0', '0', '0', '0', '220,221,222', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536656009', '1536896347', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('28', '洗头水', '0', '1', '', '27', '2', '0', '277.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '27', '1', '0', '0', '0', '0', '5', '0', '0', '0', '0', '139', '', 'xxxxxx', '', '', '', '0', '0', '1', '0', '0', '223,224,225', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536656086', '1546849322', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('29', '悦宝莱撕拉式吸去黑头面膜套装 清洁去粉刺收缩毛孔祛黑头猪鼻贴面膜泥男士女士鼻膜补水保湿吸黑头导出液', '0', '1', '', '25', '2', '0', '78.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '33', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '0', '', '', '', '', '', '0', '0', '0', '1', '0', '0', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536656169', '1546597276', '0', '0', '0', '', '', '', '', '0', '', '1546597276');
INSERT INTO `qy_goods` VALUES ('30', '海飞丝去屑护肤洗发水护根防掉发型200ml', '0', '1', '', '29', '2', '0', '32.00', '0.01', '0.02', '0.00', '0', '0', '0', '0', '0.00', '0', '666', '0', '0', '0', '0', '0', '5', '0', '0', '0', '0', '141', '', '', '', '', '', '0', '0', '0', '0', '0', '229,230,231', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1536656359', '1536896347', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('31', '123aaaa', '0', '1', '', '2', '4', '0', '11.00', '22.00', '3.00', '0.00', '0', '0', '0', '0', '0.00', '0', '33', '5', '0', '0', '22', '0', '5', '0', '0', '0', '0', '234', '', '11', '', '', '', '0', '0', '0', '1', '0', null, null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1537338420', '1537338432', '0', '0', '0', '', '', '', '', '0', '', '1537338432');
INSERT INTO `qy_goods` VALUES ('32', 'aaa', '0', '1', '', '1', '7', '0', '4.00', '5.00', '6.00', '0.00', '0', '0', '0', '0', '3.00', '0', '2', '8', '0', '0', '1', '0', '5', '0', '0', '0', '0', '0', '', 'bb', '', '', '', '0', '0', '0', '1', '0', '271', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1540292425', '1540292538', '0', '0', '0', '', '', '', '', '0', '', '1540292538');
INSERT INTO `qy_goods` VALUES ('33', '123', '0', '1', '', '2', '5', '0', '2.00', '3.00', '4.00', '0.00', '0', '0', '0', '0', '3.00', '0', '2', '6', '0', '0', '1', '0', '5', '0', '0', '0', '0', '274', '', '11', '', '', '', '0', '0', '0', '1', '0', '275', null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1540292560', '1540292581', '0', '0', '0', '', '', '', '', '0', '', '1540292581');
INSERT INTO `qy_goods` VALUES ('34', 'aaa', '0', '1', '', '2', '4', '0', '1.00', '2.00', '3.00', '0.00', '0', '0', '0', '0', '4.00', '0', '3', '5', '0', '0', '2', '0', '5', '0', '0', '0', '0', '278', '', '1', '<p>123</p>', '', '', '0', '0', '0', '0', '0', null, null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1546596856', '1546597117', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('35', '11asdasd', '0', '1', '', '2', '8', '0', '5.00', '6.00', '7.00', '0.00', '0', '0', '0', '0', '4.00', '0', '3', '234', '0', '0', '2', '0', '5', '0', '0', '0', '0', '279', '', '22', '<p>234234</p>', '', '', '0', '0', '0', '0', '0', null, null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1546596878', '1546597126', '0', '0', '0', '', '', '', '', '0', '', null);
INSERT INTO `qy_goods` VALUES ('36', 'xxxxxxx', '0', '1', '', '1', '4', '0', '1.00', '2.00', '3.00', '0.00', '0', '0', '0', '0', '4.00', '0', '33', '5', '0', '0', '22', '0', '5', '0', '0', '0', '0', '280', '', '111', '<p>123aaaaa</p>', '', '', '0', '0', '0', '1', '0', null, null, '0', '0', '', '0.00', '0.00', '1', '0', '0', '1546847890', '1546849318', '0', '0', '0', '', '', '', '', '0', '', '1546849318');

-- ----------------------------
-- Table structure for qy_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `qy_goods_sku`;
CREATE TABLE `qy_goods_sku` (
  `sku_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表序号',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品编号',
  `sku_name` varchar(500) NOT NULL DEFAULT '' COMMENT 'SKU名称',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `only_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '促销价格',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT '如果是第一个sku编码, 可以加图片',
  `create_date` int(11) DEFAULT '0' COMMENT '创建时间',
  `update_date` int(11) DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=481 COMMENT='商品skui规格价格库存信息表';

-- ----------------------------
-- Records of qy_goods_sku
-- ----------------------------
INSERT INTO `qy_goods_sku` VALUES ('1', '3', '8公斤爆款滚筒', '2399.00', '0.04', '0.02', '333', '114', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('2', '3', '10公斤爆款滚筒', '2799.00', '0.01', '0.02', '333', '114', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('3', '4', '大1匹', '3299.00', '0.03', '0.04', '444', '115', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('4', '4', '正1.5匹', '3599.00', '0.02', '0.03', '444', '115', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('5', '7', '幻夜黑 4GB 64GB 标配', '1299.00', '0.03', '0.03', '769', '118', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('6', '7', '梦幻紫 4GB 128GB 标配', '1699.00', '0.05', '0.06', '774', '118', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('7', '9', '白色', '3799.00', '0.01', '0.02', '999', '252', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('8', '9', '黑色', '3799.00', '0.01', '0.02', '999', '253', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('9', '13', '1T', '329.00', '0.01', '0.02', '129', '250', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('10', '13', '2T', '459.00', '0.01', '0.02', '132', '251', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('11', '14', 'M126nw【黑白三合一whif版】', '1899.00', '0.01', '0.02', '33', '248', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('12', '14', 'M126a【黑白三合一】', '1199.00', '0.01', '0.02', '44', '249', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('13', '18', '米黄 5斤', '99.00', '11.00', '12.00', '99', '129', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('14', '18', '米黄 6斤 加厚', '99.00', '12.00', '13.00', '99', '129', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('15', '19', '【纯白款】4.5瓦直径17.3', '129.00', '0.01', '0.02', '99', '244', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('16', '19', '【纯白款】10瓦直径23', '149.00', '0.01', '0.02', '59', '245', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('17', '20', '玛瑙灰3人位PLUS', '1199.00', '12.00', '0.02', '99', '242', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('18', '20', '铂金黄3人位PLUS', '1199.00', '13.00', '0.02', '99', '243', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('19', '21', '柠檬黄', '0.00', '0.01', '0.02', '0', '240', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('20', '21', '湖蓝', '0.00', '0.01', '0.02', '0', '241', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('21', '23', '红色 M', '169.00', '0.01', '0.02', '99', '0', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('22', '23', '蓝色XL', '169.00', '0.01', '0.02', '99', '0', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('23', '25', '黑色深V', '99.00', '9.03', '9.04', '99', '238', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('24', '25', '藏青深V', '99.00', '9.05', '9.06', '99', '239', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('25', '27', '“神仙水”礼盒230ML', '1399.00', '0.01', '0.02', '1399', '0', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('26', '27', '神仙水330ML', '1399.00', '0.01', '0.02', '1399', '0', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('27', '30', '丝质柔滑', '32.00', '0.01', '0.02', '32', '0', '0', '0');
INSERT INTO `qy_goods_sku` VALUES ('28', '30', '清爽去油', '32.00', '0.01', '0.02', '23', '0', '0', '0');

-- ----------------------------
-- Table structure for qy_group
-- ----------------------------
DROP TABLE IF EXISTS `qy_group`;
CREATE TABLE `qy_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `oauth` varchar(2000) NOT NULL,
  `update_time` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qy_group
-- ----------------------------
INSERT INTO `qy_group` VALUES ('1', '超级管理员', 'all,product,product_list,product_add,product_del,product_category,shop,shop_list,shop_add,shop_del,chou,chou_list,chou_set,order_cai,order_list,order_set,caiwu_list,pay,member,member_list,cset,ad_list,article_list,site_set,group_list', '1546174956', '1546174956');
INSERT INTO `qy_group` VALUES ('2', '市场人员', 'all,product,product_list,product_add,product_del,product_category,shop,shop_list,shop_add,shop_del,chou,chou_list,chou_set,order_cai,order_list,order_set,caiwu_list,pay,member,member_list,cset,ad_list,article_list,site_set,group_list', '1546345543', '1546175065');

-- ----------------------------
-- Table structure for qy_image
-- ----------------------------
DROP TABLE IF EXISTS `qy_image`;
CREATE TABLE `qy_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL COMMENT '图片路径',
  `from` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 来自本地，2 来自公网',
  `use_name` varchar(80) NOT NULL,
  `delete_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb4 COMMENT='图片总表';

-- ----------------------------
-- Records of qy_image
-- ----------------------------
INSERT INTO `qy_image` VALUES ('33', '/uploads/category/20180910\\58f6b445a31a388d6d7444b354cf2ec4.jpg', '1', '/category', null, '1536587363');
INSERT INTO `qy_image` VALUES ('34', '/uploads/category/20180910\\6fa3dbec2b59210cd7f61778c3e8c779.jpg', '1', '/category', null, '1536587403');
INSERT INTO `qy_image` VALUES ('35', '/uploads/category/20180910\\ca8a49ee9de00b572b506e4ddcafc6c2.jpg', '1', '', null, '1536587464');
INSERT INTO `qy_image` VALUES ('36', '/uploadscategory/20180910\\fefca0f0a16bc4a4a183e5ec8a807f92.jpg', '1', 'category', null, '1536587541');
INSERT INTO `qy_image` VALUES ('37', '/uploads/category/20180910\\031163e309542938a688968a11aba5e7.jpg', '1', 'category', null, '1536587570');
INSERT INTO `qy_image` VALUES ('38', '/uploads/category/20180910\\5caa279f2c5209209dedca848847da17.jpg', '1', 'category', null, '1536587668');
INSERT INTO `qy_image` VALUES ('39', '/uploads/category/20180910\\e07aacb2f4067cd1da807711576bdd33.jpg', '1', 'category', null, '1536587678');
INSERT INTO `qy_image` VALUES ('40', '/uploads/category/20180910\\4c17609d46e32c57810e6b8498e06175.jpg', '1', 'category', null, '1536587814');
INSERT INTO `qy_image` VALUES ('41', '/uploads/category/20180910\\f771876df5da0012fbcda84e83155616.jpg', '1', 'category', null, '1536587833');
INSERT INTO `qy_image` VALUES ('42', '/uploads/category/20180910\\591d104b43503ba1fd05b380909243a6.jpg', '1', 'category', null, '1536587870');
INSERT INTO `qy_image` VALUES ('43', '/uploads/category/20180910\\5ef26f8c329ea198f57601fe0d583d5d.jpg', '1', 'category', null, '1536588035');
INSERT INTO `qy_image` VALUES ('44', '/uploads/category/20180910\\fd031ddad629511943690949c25e2f20.jpg', '1', 'category', null, '1536588096');
INSERT INTO `qy_image` VALUES ('45', '/uploads/category/20180910\\c3d3bcac6fbbb4d90d4b80a54171a386.jpg', '1', 'category', null, '1536588155');
INSERT INTO `qy_image` VALUES ('46', '/uploads/category/20180910\\4ec3df3b0063bf8bf2731787411ee16c.jpg', '1', 'category', null, '1536588262');
INSERT INTO `qy_image` VALUES ('47', '/uploads/category/20180910\\8b5b94a49a81f52e8c8801ea61821be0.jpg', '1', 'category', null, '1536588279');
INSERT INTO `qy_image` VALUES ('48', '/uploads/category/20180910\\72aad40f4d69cc213eafc3d608da6adb.jpg', '1', 'category', null, '1536588524');
INSERT INTO `qy_image` VALUES ('49', '/uploads/category/20180910\\4a31026cfa29d2e8cde416769245d541.jpg', '1', 'category', null, '1536588547');
INSERT INTO `qy_image` VALUES ('50', '/uploads/category/20180910\\4a692dea5bf632b574acd6e6a41c3b06.jpg', '1', 'category', null, '1536588555');
INSERT INTO `qy_image` VALUES ('51', '/uploads/category/20180910\\0d4e0d725e2ceb5df83ec0780488aa68.jpg', '1', 'category', null, '1536588633');
INSERT INTO `qy_image` VALUES ('52', '/uploads/category/20180910\\8c427d33bcbdb351f4f4fdec7cb8fbf5.jpg', '1', 'category', null, '1536588636');
INSERT INTO `qy_image` VALUES ('53', '/uploads/category/20180910\\1f94cd1986c62fed56308831e9e2cdfb.jpg', '1', 'category', null, '1536588662');
INSERT INTO `qy_image` VALUES ('54', '/uploads/category/20180910\\72c572db0570bf318c94b3fac220bec1.jpg', '1', 'category', null, '1536588681');
INSERT INTO `qy_image` VALUES ('55', '/uploads/category/20180910\\b2800343b1879c40ab3fcf45ff16c929.jpg', '1', 'category', null, '1536588746');
INSERT INTO `qy_image` VALUES ('56', '/uploads/category/20180910\\aeb3d7c1121be04badb4813fe73bf29f.jpg', '1', 'category', null, '1536588768');
INSERT INTO `qy_image` VALUES ('57', '/uploads/category/20180910\\684c5f43e0e2ded74f31bf72ce1792e4.jpg', '1', 'category', null, '1536588844');
INSERT INTO `qy_image` VALUES ('58', '/uploads/category/20180910\\d45a221603f495e026faa920ad303ace.jpg', '1', 'category', null, '1536588955');
INSERT INTO `qy_image` VALUES ('59', '/uploads/category/20180910\\367fd653ddd93ebcd6e80185e635d85d.jpg', '1', 'category', null, '1536589275');
INSERT INTO `qy_image` VALUES ('60', '/uploads/category/20180910\\b55c7fd59af70d51fa90a6e8b50f63b2.jpg', '1', 'category', null, '1536589335');
INSERT INTO `qy_image` VALUES ('61', '/uploads/category/20180910\\8ad8e0dff9d50b1505eacae5a362d7e9.jpg', '1', 'category', null, '1536589370');
INSERT INTO `qy_image` VALUES ('62', '/uploads/category/20180910\\d8de43a4b1077d44fd7ca63972926d7d.jpg', '1', 'category', null, '1536590429');
INSERT INTO `qy_image` VALUES ('63', '/uploads/category/20180910\\bf1609194221da36e5dca92abcf70de3.jpg', '1', 'category', null, '1536591783');
INSERT INTO `qy_image` VALUES ('64', '/uploads/category/20180910\\9b73fbe9c3f4093cffe72905ea22c2e2.jpg', '1', 'category', null, '1536591839');
INSERT INTO `qy_image` VALUES ('65', '/uploads/category/20180910\\80af4c9c70e400ff3b0f9258ba4f3e58.jpg', '1', 'category', null, '1536591849');
INSERT INTO `qy_image` VALUES ('66', '/uploads/category/20180910\\a5760744abf35c1accbff1d9ab3be03c.jpg', '1', 'category', null, '1536591921');
INSERT INTO `qy_image` VALUES ('67', '/uploads/category/20180910\\06a5768c5a54d90783cfc44becc091ea.jpg', '1', 'category', null, '1536591988');
INSERT INTO `qy_image` VALUES ('68', '/uploads/category/20180910\\d9ef4ae804208ebaf931166740c68db6.jpg', '1', 'category', null, '1536592042');
INSERT INTO `qy_image` VALUES ('69', '/uploads/category/20180910\\90120c652c8617a6743d0bc263f5b909.jpg', '1', 'category', null, '1536592053');
INSERT INTO `qy_image` VALUES ('70', '/uploads/category/20180910\\af185d3c76df7293ff48a1df0b1f433d.jpg', '1', 'category', null, '1536592106');
INSERT INTO `qy_image` VALUES ('71', '/uploads/category/20180910\\a3bbc1d02c407ae43d21aadc951781af.jpg', '1', 'category', null, '1536592227');
INSERT INTO `qy_image` VALUES ('72', '/uploads/category/20180910\\ba7eeb31cb4b159647a458c13109045f.jpg', '1', 'category', null, '1536592260');
INSERT INTO `qy_image` VALUES ('73', '/uploads/category/20180910\\c2252b1dca9c0de32ef08b754f0dc09f.jpg', '1', 'category', null, '1536592347');
INSERT INTO `qy_image` VALUES ('74', '/uploads/category/20180910\\081312457ca80417c56218f5ab747e18.jpg', '1', 'category', null, '1536592476');
INSERT INTO `qy_image` VALUES ('75', '/uploads/category/20180910\\64665695152e130efa902697db66c4aa.jpg', '1', 'category', null, '1536592497');
INSERT INTO `qy_image` VALUES ('76', '/uploads/category/20180910\\c8742358593ec0120a5de683e0842356.jpg', '1', 'category', null, '1536592523');
INSERT INTO `qy_image` VALUES ('77', '/uploads/category/20180910\\f879bec6e6c0b8637f2c7f0e266b7d5e.jpg', '1', 'category', null, '1536592542');
INSERT INTO `qy_image` VALUES ('78', '/uploads/category/20180910\\91c57ad080aae95eb470f485584258e7.jpg', '1', 'category', null, '1536592739');
INSERT INTO `qy_image` VALUES ('79', '/uploads/category/20180911\\77057d9a3d4b0a7bddf5dfd4567617cb.jpg', '1', 'category', null, '1536626762');
INSERT INTO `qy_image` VALUES ('80', '/uploads/category/20180911\\0be4355a6871b9703ab7dbb77bab2e85.jpg', '1', 'category', null, '1536626772');
INSERT INTO `qy_image` VALUES ('81', '/uploads/category/20180911\\c3f1ba9160e6d5b2b4db148390056134.png', '1', 'category', null, '1536641999');
INSERT INTO `qy_image` VALUES ('82', '/uploads/category/20180911\\28937f5cf0c464eaa3c4015999200a44.png', '1', 'category', null, '1536642666');
INSERT INTO `qy_image` VALUES ('83', '/uploads/category/20180911\\0344f5d68023bef9d2270782cc4c1afe.png', '1', 'category', null, '1536642721');
INSERT INTO `qy_image` VALUES ('84', '/uploads/category/20180911\\04150a0b381933024e0d403da2cf55a2.png', '1', 'category', null, '1536643245');
INSERT INTO `qy_image` VALUES ('85', '/uploads/category/20180911\\82996bad850a3c4f1657bbd0ff16e2ae.png', '1', 'category', null, '1536643365');
INSERT INTO `qy_image` VALUES ('86', '/uploads/category/20180911\\cdb13b2d5400ced4ccb9e40d837b23d3.png', '1', 'category', null, '1536643416');
INSERT INTO `qy_image` VALUES ('87', '/uploads/category/20180911\\c201274fd7a44862e7e7cbca9f4634d2.png', '1', 'category', null, '1536643466');
INSERT INTO `qy_image` VALUES ('88', '/uploads/category/20180911\\658876d1d4dfa082ef24be9c5219bb0e.png', '1', 'category', null, '1536643734');
INSERT INTO `qy_image` VALUES ('89', '/uploads/category/20180911\\b953efa22705ad7b3125ad9f6ed6bb21.png', '1', 'category', null, '1536643795');
INSERT INTO `qy_image` VALUES ('90', '/uploads/category/20180911\\6dd670dbdbd2cdbd5d11b28ad613c74c.png', '1', 'category', null, '1536643868');
INSERT INTO `qy_image` VALUES ('91', '/uploads/category/20180911\\8243411fbaa74710bc0b987539780740.png', '1', 'category', null, '1536643877');
INSERT INTO `qy_image` VALUES ('92', '/uploads/category/20180911\\723bbb47a13194e6becb88241f960c17.png', '1', 'category', null, '1536643921');
INSERT INTO `qy_image` VALUES ('93', '/uploads/category/20180911\\97405ddd6490e70ab920b6f74359507c.png', '1', 'category', null, '1536644105');
INSERT INTO `qy_image` VALUES ('94', '/uploads/category/20180911\\920f70582eee023df7d47c072a74805e.png', '1', 'category', null, '1536644115');
INSERT INTO `qy_image` VALUES ('95', '/uploads/category/20180911\\55b9f1455c1308b49159fa0203bd7706.png', '1', 'category', null, '1536644125');
INSERT INTO `qy_image` VALUES ('96', '/uploads/category/20180911\\7f2c2050a60d8bab80bf9ff050d47fee.png', '1', 'category', null, '1536644137');
INSERT INTO `qy_image` VALUES ('97', '/uploads/category/20180911\\98b290dfc69e029ca725af669381b23a.png', '1', 'category', null, '1536644146');
INSERT INTO `qy_image` VALUES ('98', '/uploads/category/20180911\\2e89234fad75324da31d5b94b4612ccc.png', '1', 'category', null, '1536644209');
INSERT INTO `qy_image` VALUES ('99', '/uploads/category/20180911\\0988ae6944d67c6af7a85b95418069c7.png', '1', 'category', null, '1536644344');
INSERT INTO `qy_image` VALUES ('100', '/uploads/category/20180911\\58a6f16339233873340120bc0389a986.png', '1', 'category', null, '1536644351');
INSERT INTO `qy_image` VALUES ('101', '/uploads/category/20180911\\f8e0be3f024a880da56518dc9b2c6c4a.png', '1', 'category', null, '1536644370');
INSERT INTO `qy_image` VALUES ('102', '/uploads/category/20180911\\5be31794b193d38a53581baa5b640286.png', '1', 'category', null, '1536644380');
INSERT INTO `qy_image` VALUES ('103', '/uploads/category/20180911\\5bacce76e34604d42b8ad3c95891eaaf.png', '1', 'category', null, '1536644656');
INSERT INTO `qy_image` VALUES ('104', '/uploads/category/20180911\\5dee14297fd7c955552680c257fa1fdc.png', '1', 'category', null, '1536644668');
INSERT INTO `qy_image` VALUES ('105', '/uploads/category/20180911\\9c9073ec055897dc96c74dfed17f6db4.png', '1', 'category', null, '1536644680');
INSERT INTO `qy_image` VALUES ('106', '/uploads/category/20180911\\70a208e6131968d5f91be8222d9378d6.png', '1', 'category', null, '1536644688');
INSERT INTO `qy_image` VALUES ('107', '/uploads/category/20180911\\e1f531b24b43d35c2b5ea890e06b1bc4.png', '1', 'category', null, '1536644698');
INSERT INTO `qy_image` VALUES ('108', '/uploads/category/20180911\\c85fccb8857d15287448031f773f01cc.png', '1', 'category', null, '1536645514');
INSERT INTO `qy_image` VALUES ('109', '/uploads/category/20180911\\7fe84eb312354d686ee6acd97e03eeb5.png', '1', 'category', null, '1536645533');
INSERT INTO `qy_image` VALUES ('112', '/uploads/product/1/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('113', '/uploads/product/2/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('114', '/uploads/product/3/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('115', '/uploads/product/4/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('116', '/uploads/product/5/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('117', '/uploads/product/6/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('118', '/uploads/product/7/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('119', '/uploads/product/8/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('120', '/uploads/product/9/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('121', '/uploads/product/10/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('122', '/uploads/product/11/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('123', '/uploads/product/12/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('124', '/uploads/product/13/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('125', '/uploads/product/14/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('126', '/uploads/product/15/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('127', '/uploads/product/16/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('128', '/uploads/product/17/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('129', '/uploads/product/18/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('130', '/uploads/product/19/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('131', '/uploads/product/20/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('132', '/uploads/product/21/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('133', '/uploads/product/22/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('134', '/uploads/product/23/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('135', '/uploads/product/24/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('136', '/uploads/product/25/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('137', '/uploads/product/26/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('138', '/uploads/product/27/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('139', '/uploads/product/28/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('140', '/uploads/product/29/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('141', '/uploads/product/30/1.jpg', '1', 'product', null, '1536893925');
INSERT INTO `qy_image` VALUES ('142', '/uploads/product/1/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('143', '/uploads/product/1/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('144', '/uploads/product/1/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('145', '/uploads/product/2/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('146', '/uploads/product/2/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('147', '/uploads/product/2/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('148', '/uploads/product/3/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('149', '/uploads/product/3/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('150', '/uploads/product/3/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('151', '/uploads/product/4/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('152', '/uploads/product/4/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('153', '/uploads/product/4/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('154', '/uploads/product/5/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('155', '/uploads/product/5/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('156', '/uploads/product/5/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('157', '/uploads/product/6/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('158', '/uploads/product/6/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('159', '/uploads/product/6/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('160', '/uploads/product/7/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('161', '/uploads/product/7/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('162', '/uploads/product/7/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('163', '/uploads/product/8/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('164', '/uploads/product/8/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('165', '/uploads/product/8/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('166', '/uploads/product/9/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('167', '/uploads/product/9/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('168', '/uploads/product/9/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('169', '/uploads/product/10/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('170', '/uploads/product/10/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('171', '/uploads/product/10/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('172', '/uploads/product/11/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('173', '/uploads/product/11/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('174', '/uploads/product/11/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('175', '/uploads/product/12/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('176', '/uploads/product/12/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('177', '/uploads/product/12/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('178', '/uploads/product/13/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('179', '/uploads/product/13/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('180', '/uploads/product/13/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('181', '/uploads/product/14/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('182', '/uploads/product/14/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('183', '/uploads/product/14/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('184', '/uploads/product/15/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('185', '/uploads/product/15/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('186', '/uploads/product/15/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('187', '/uploads/product/16/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('188', '/uploads/product/16/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('189', '/uploads/product/16/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('190', '/uploads/product/17/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('191', '/uploads/product/17/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('192', '/uploads/product/17/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('193', '/uploads/product/18/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('194', '/uploads/product/18/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('195', '/uploads/product/18/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('196', '/uploads/product/19/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('197', '/uploads/product/19/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('198', '/uploads/product/19/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('199', '/uploads/product/20/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('200', '/uploads/product/20/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('201', '/uploads/product/20/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('202', '/uploads/product/21/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('203', '/uploads/product/21/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('204', '/uploads/product/21/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('205', '/uploads/product/22/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('206', '/uploads/product/22/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('207', '/uploads/product/22/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('208', '/uploads/product/23/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('209', '/uploads/product/23/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('210', '/uploads/product/23/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('211', '/uploads/product/24/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('212', '/uploads/product/24/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('213', '/uploads/product/24/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('214', '/uploads/product/25/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('215', '/uploads/product/25/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('216', '/uploads/product/25/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('217', '/uploads/product/26/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('218', '/uploads/product/26/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('219', '/uploads/product/26/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('220', '/uploads/product/27/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('221', '/uploads/product/27/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('222', '/uploads/product/27/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('223', '/uploads/product/28/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('224', '/uploads/product/28/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('225', '/uploads/product/28/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('226', '/uploads/product/29/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('227', '/uploads/product/29/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('228', '/uploads/product/29/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('229', '/uploads/product/30/a.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('230', '/uploads/product/30/b.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('231', '/uploads/product/30/c.jpg', '1', 'product_info', null, '1536895169');
INSERT INTO `qy_image` VALUES ('232', '/uploads/product/20180919\\6b2cd99eec02d4d76291bb607cd37de5.jpg', '1', 'product', null, '1537337037');
INSERT INTO `qy_image` VALUES ('233', '/uploads/product/20180919\\a0d37a232afeffffbe3a66448d4a7a30.jpg', '1', 'product', null, '1537337340');
INSERT INTO `qy_image` VALUES ('234', '/uploads/product/20180919\\5a98b2ca71d0cbdb1bf7903aa8ae71ef.jpg', '1', 'product', null, '1537338420');
INSERT INTO `qy_image` VALUES ('235', '/uploads/product/20180920\\f5faea16e43baca78cf11c576c974bdd.jpg', '1', 'product', null, '1537419864');
INSERT INTO `qy_image` VALUES ('236', '/uploads/product/20180920\\cc059fbae83ad90896df7cf4e6c4c6ca.jpg', '1', 'product', null, '1537420307');
INSERT INTO `qy_image` VALUES ('237', '/uploads/product/20180920\\7c5d76d4edb67c8eed6d7a8c093385d8.png', '1', 'product', null, '1537420346');
INSERT INTO `qy_image` VALUES ('238', '/uploads/product/20180920\\6b056ec8a5cb33c1dfda966c3b813fbd.png', '1', 'product', null, '1537420398');
INSERT INTO `qy_image` VALUES ('239', '/uploads/product/20180920\\cd778dde77f8a9362f774b485cb39ff9.png', '1', 'product', null, '1537420406');
INSERT INTO `qy_image` VALUES ('240', '/uploads/product/20180920\\3fd3d6f918a545fa6ce5479f4f9ab994.png', '1', 'product', null, '1537420587');
INSERT INTO `qy_image` VALUES ('241', '/uploads/product/20180920\\54e79203ab45f2dd5582137a5afcc326.png', '1', 'product', null, '1537420589');
INSERT INTO `qy_image` VALUES ('242', '/uploads/product/20180920\\e1a5b23518a6306d34b304b88b0f1f96.png', '1', 'product', null, '1537420674');
INSERT INTO `qy_image` VALUES ('243', '/uploads/product/20180920\\951f7953a6e3a667057ca5d76db1bdc3.png', '1', 'product', null, '1537420676');
INSERT INTO `qy_image` VALUES ('244', '/uploads/product/20180920\\a78347b677598e5a26af739ee9b7054c.png', '1', 'product', null, '1537420858');
INSERT INTO `qy_image` VALUES ('245', '/uploads/product/20180920\\722692392760f68bbc91e859e9a1c637.png', '1', 'product', null, '1537420861');
INSERT INTO `qy_image` VALUES ('246', '/uploads/product/20180920\\bbc23ac2dd301c5c1539f86a12ff46f0.png', '1', 'product', null, '1537420953');
INSERT INTO `qy_image` VALUES ('247', '/uploads/product/20180920\\8e02a061e5137d8a06d31f29de740cf1.png', '1', 'product', null, '1537420955');
INSERT INTO `qy_image` VALUES ('248', '/uploads/product/20180920\\785cea92fd52975809244ec195bbce1c.png', '1', 'product', null, '1537421075');
INSERT INTO `qy_image` VALUES ('249', '/uploads/product/20180920\\e4879db9a55d38765fe3ca737e9887e1.png', '1', 'product', null, '1537421077');
INSERT INTO `qy_image` VALUES ('250', '/uploads/product/20180920\\cfd53909e3737979c3ea406efc49033c.png', '1', 'product', null, '1537421144');
INSERT INTO `qy_image` VALUES ('251', '/uploads/product/20180920\\95c766def1ca0eeda2a34fffb8da08b8.png', '1', 'product', null, '1537421146');
INSERT INTO `qy_image` VALUES ('252', '/uploads/product/20180920\\c0734b00d14b528f0adbbb1139519216.png', '1', 'product', null, '1537421458');
INSERT INTO `qy_image` VALUES ('253', '/uploads/product/20180920\\8b33971905de01ded2e92443356f725a.png', '1', 'product', null, '1537421460');
INSERT INTO `qy_image` VALUES ('254', '/uploads/product/20180920\\b55b2f1ef1e1421c56057e605d749748.png', '1', 'product', null, '1537421544');
INSERT INTO `qy_image` VALUES ('255', '/uploads/product/20180920\\cdd0ec8de529ff8d63cced93830c6cf0.png', '1', 'product', null, '1537421546');
INSERT INTO `qy_image` VALUES ('256', '/uploads/product/20180920\\22a2fda84ef39caf7ce1521eec8054f3.png', '1', 'product', null, '1537421642');
INSERT INTO `qy_image` VALUES ('257', '/uploads/product/20180920\\cc6f8f12f4b9d29f6c9889d8d082bb8c.png', '1', 'product', null, '1537421645');
INSERT INTO `qy_image` VALUES ('258', '/uploads/category/20180920\\f97fd7fc2cca1d1590b4242c716a7379.png', '1', 'category', null, '1537421943');
INSERT INTO `qy_image` VALUES ('259', '/uploads/category/20180920\\34205a0209ae6224eee4a022626bc514.png', '1', 'category', null, '1537421952');
INSERT INTO `qy_image` VALUES ('260', '/uploads/category/20180920\\2b7366b22e7973c03b02263cdd61faef.png', '1', 'category', null, '1537421972');
INSERT INTO `qy_image` VALUES ('261', '/uploads/category/20180920\\3468fb6ba4c287ed33bb7838ebf414f4.png', '1', 'category', null, '1537422116');
INSERT INTO `qy_image` VALUES ('262', '/uploads/category/20180920\\7a4a30274c9915597c2a0169975c057c.png', '1', 'category', null, '1537422873');
INSERT INTO `qy_image` VALUES ('263', '/uploads/category/20180920\\c55d4174aebceccfcb6dcec1cda0ccd3.png', '1', 'category', null, '1537422899');
INSERT INTO `qy_image` VALUES ('264', '/uploads/category/20180920\\2ba4bf130ca962188fe5f21d6947f160.png', '1', 'category', null, '1537422919');
INSERT INTO `qy_image` VALUES ('265', '/uploads/category/20180920\\4ccc976835bfd30268808832da72767c.png', '1', 'category', null, '1537422927');
INSERT INTO `qy_image` VALUES ('266', '/uploads/AD/20180920\\660ed4859a1e2d274d73b1a00bc0cd5b.jpg', '1', 'AD', null, '1537431595');
INSERT INTO `qy_image` VALUES ('267', '/uploads/AD/20180920\\60cb87efd7fef001f613c7e2ad0c78f4.jpg', '1', 'AD', null, '1537431602');
INSERT INTO `qy_image` VALUES ('268', '/uploads/AD/20180920\\e9540730b5c8fc2d33a5cdfcc121e15f.jpg', '1', 'AD', null, '1537431606');
INSERT INTO `qy_image` VALUES ('269', '/uploads/category/20180920\\66165f1583a79410260f41da94181e69.png', '1', 'category', null, '1537431933');
INSERT INTO `qy_image` VALUES ('270', '/uploads/category/20180920\\21cf73edaea4654b01c3a25adbb61c27.png', '1', 'category', null, '1537431947');
INSERT INTO `qy_image` VALUES ('271', '/uploads/product/20181023\\00e526c9fb3ace4201e8a4f9e6339e52.jpg', '1', 'product', null, '1540292424');
INSERT INTO `qy_image` VALUES ('272', '/uploads/product/20181023\\9589e48ced4222281a86566625f04472.jpg', '1', 'product', null, '1540292441');
INSERT INTO `qy_image` VALUES ('273', '/uploads/product/20181023\\4ab440fd16bcb1e9e7c5baf1e7728c09.jpg', '1', 'product', null, '1540292501');
INSERT INTO `qy_image` VALUES ('274', '/uploads/product/20181023\\dcf35bac718b86af9316ab2ec691ec2a.jpg', '1', 'product', null, '1540292548');
INSERT INTO `qy_image` VALUES ('275', '/uploads/product/20181023\\85680c9ea6b22ac8c0dbdb77548948a1.jpg', '1', 'product', null, '1540292554');
INSERT INTO `qy_image` VALUES ('276', '/uploads/AD/20190104\\f2812f13802ed2941f52fbd6964edf8b.jpg', '1', 'AD', null, '1546577996');
INSERT INTO `qy_image` VALUES ('277', '/uploads/product/20190104\\3233e4ad8e23f32f0bcdef9ae77bbfd0.jpg', '1', 'product', null, '1546596687');
INSERT INTO `qy_image` VALUES ('278', '/uploads/product/20190104\\92e645dbf6b88a5f6a91950672515a81.jpg', '1', 'product', null, '1546597116');
INSERT INTO `qy_image` VALUES ('279', '/uploads/product/20190104\\9b905ec4c51f63f85fbf4e4792858c33.jpg', '1', 'product', null, '1546597124');
INSERT INTO `qy_image` VALUES ('280', '/uploads/product/20190107\\fbd659a51908c80196f04826f73fbda4.jpg', '1', 'product', null, '1546847886');

-- ----------------------------
-- Table structure for qy_item
-- ----------------------------
DROP TABLE IF EXISTS `qy_item`;
CREATE TABLE `qy_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '团单ID',
  `shop_id` int(11) NOT NULL COMMENT '商铺ID',
  `shop_name` varchar(300) NOT NULL COMMENT '商铺名称',
  `item_people` tinyint(4) NOT NULL COMMENT '团单满足人数',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `goods_name` varchar(200) NOT NULL COMMENT '商品名称',
  `price` decimal(10,2) NOT NULL COMMENT '商品单价',
  `item_status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0过期1待支付2待完成3完成',
  `operator_id` int(11) NOT NULL COMMENT '操作人员id',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='拼团和独立购买';

-- ----------------------------
-- Records of qy_item
-- ----------------------------

-- ----------------------------
-- Table structure for qy_order
-- ----------------------------
DROP TABLE IF EXISTS `qy_order`;
CREATE TABLE `qy_order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_num` varchar(40) NOT NULL COMMENT '订单编号',
  `item_id` int(11) NOT NULL COMMENT '团单ID',
  `user_id` int(11) NOT NULL,
  `is_first` tinyint(1) NOT NULL DEFAULT '0' COMMENT '创团订单',
  `type` int(11) NOT NULL COMMENT '0拼团1普通商品',
  `order_status` int(11) NOT NULL DEFAULT '2' COMMENT '0过期1退款2待付3已付待发4已发待收5已收待评6完成',
  `pay_status` tinyint(1) DEFAULT '0' COMMENT '0未付1已付',
  `pt_status` int(1) NOT NULL DEFAULT '0',
  `drive_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发货',
  `receive_status` int(1) NOT NULL DEFAULT '0' COMMENT '收货状态',
  `evaluate_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否评价 0为未评价 1为已评价 2为已追评',
  `tui_status` tinyint(4) DEFAULT '0',
  `rate_id` int(11) NOT NULL,
  `order_from` tinyint(4) NOT NULL COMMENT '来源小程序或wap',
  `payment_type` varchar(60) NOT NULL COMMENT '支付方式',
  `shipping_money` decimal(10,2) NOT NULL COMMENT '运费',
  `goods_money` decimal(10,2) NOT NULL COMMENT '商品总价',
  `order_money` decimal(10,2) NOT NULL COMMENT '订单总价',
  `edit_moeny` decimal(10,2) NOT NULL,
  `user_ip` varchar(40) NOT NULL,
  `goods_picture` varchar(400) NOT NULL,
  `message` varchar(300) NOT NULL,
  `receiver_name` varchar(60) NOT NULL COMMENT '收货人',
  `receiver_mobile` varchar(60) NOT NULL COMMENT '收货人手机',
  `receiver_city` varchar(60) NOT NULL,
  `receiver_address` varchar(200) NOT NULL,
  `courier_num` varchar(60) NOT NULL,
  `courier` varchar(255) NOT NULL,
  `prepay_id` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qy_order
-- ----------------------------

-- ----------------------------
-- Table structure for qy_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `qy_order_goods`;
CREATE TABLE `qy_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `goods_name` varchar(300) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `sku_name` varchar(300) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `cost_price` decimal(10,2) NOT NULL,
  `num` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `pic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `remark` varchar(400) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qy_order_goods
-- ----------------------------

-- ----------------------------
-- Table structure for qy_order_log
-- ----------------------------
DROP TABLE IF EXISTS `qy_order_log`;
CREATE TABLE `qy_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `type_name` varchar(255) NOT NULL,
  `content` varchar(800) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qy_order_log
-- ----------------------------

-- ----------------------------
-- Table structure for qy_order_payment
-- ----------------------------
DROP TABLE IF EXISTS `qy_order_payment`;
CREATE TABLE `qy_order_payment` (
  `out_trade_no` varchar(30) NOT NULL COMMENT '支付单编号',
  `shop_id` int(11) NOT NULL DEFAULT '0' COMMENT '执行支付的相关店铺ID（0平台）',
  `type` int(11) NOT NULL DEFAULT '1' COMMENT '订单类型1.商城订单2.交易商支付',
  `type_alis_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单类型关联ID',
  `pay_body` varchar(255) NOT NULL DEFAULT '' COMMENT '订单支付简介',
  `pay_detail` varchar(1000) NOT NULL DEFAULT '' COMMENT '订单支付详情',
  `pay_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '支付金额',
  `pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付状态',
  `pay_type` int(11) NOT NULL DEFAULT '1' COMMENT '支付方式',
  `create_time` int(11) DEFAULT '0' COMMENT '创建时间',
  `pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '交易号，支付宝退款用，微信传入空',
  KEY `IDX_ns_order_payment_out_trade_no` (`out_trade_no`),
  KEY `IDX_ns_order_payment_pay_status` (`pay_status`),
  KEY `IDX_ns_order_payment_pay_type` (`pay_type`),
  KEY `IDX_ns_order_payment_shop_id` (`shop_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=963 COMMENT='订单支付表';

-- ----------------------------
-- Records of qy_order_payment
-- ----------------------------

-- ----------------------------
-- Table structure for qy_rate
-- ----------------------------
DROP TABLE IF EXISTS `qy_rate`;
CREATE TABLE `qy_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `rate` int(11) NOT NULL,
  `content` varchar(800) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qy_rate
-- ----------------------------

-- ----------------------------
-- Table structure for qy_shop
-- ----------------------------
DROP TABLE IF EXISTS `qy_shop`;
CREATE TABLE `qy_shop` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '店铺id',
  `shop_name` varchar(50) NOT NULL COMMENT '店铺名称',
  `shop_description` varchar(500) NOT NULL COMMENT '店铺描述',
  `shop_type` int(11) NOT NULL COMMENT '店铺类型等级',
  `uid` int(11) NOT NULL COMMENT '会员id',
  `shop_group_id` int(11) NOT NULL COMMENT '店铺分类',
  `shop_address` varchar(100) NOT NULL DEFAULT '' COMMENT '详细地区',
  `shop_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '店铺状态，0关闭，1开启，2审核中',
  `shop_close_info` varchar(255) DEFAULT NULL COMMENT '店铺关闭原因',
  `shop_sort` int(11) NOT NULL DEFAULT '0' COMMENT '店铺排序',
  `img_id` int(11) DEFAULT '0' COMMENT '店铺头像',
  `shop_phone` varchar(20) DEFAULT NULL COMMENT '商家电话',
  `shop_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐，0为否，1为是，默认为0',
  `shop_collect` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '店铺收藏数量',
  `shop_sales` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺销售额（不计算退款）',
  `store_qtian` tinyint(1) DEFAULT '0' COMMENT '7天退换',
  `shop_zhping` tinyint(1) DEFAULT '0' COMMENT '正品保障',
  `shop_tuihuo` tinyint(1) DEFAULT '0' COMMENT '退货承诺',
  `create_time` int(11) DEFAULT '0' COMMENT '店铺时间',
  `end_time` int(11) DEFAULT '0' COMMENT '店铺关闭时间',
  PRIMARY KEY (`shop_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384 COMMENT='店铺数据表';

-- ----------------------------
-- Records of qy_shop
-- ----------------------------

-- ----------------------------
-- Table structure for qy_tui
-- ----------------------------
DROP TABLE IF EXISTS `qy_tui`;
CREATE TABLE `qy_tui` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `shop_name` varchar(255) NOT NULL,
  `order_num` varchar(40) NOT NULL,
  `money` decimal(10,2) NOT NULL,
  `message` varchar(255) NOT NULL,
  `because` varchar(255) DEFAULT NULL,
  `ip` varchar(100) NOT NULL,
  `status` int(1) NOT NULL,
  `aid` int(11) NOT NULL,
  `wx_id` varchar(50) NOT NULL,
  `remark` varchar(255) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qy_tui
-- ----------------------------

-- ----------------------------
-- Table structure for qy_user
-- ----------------------------
DROP TABLE IF EXISTS `qy_user`;
CREATE TABLE `qy_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `openid` varchar(50) CHARACTER SET utf8 NOT NULL,
  `nickname` varchar(60) NOT NULL,
  `headpic` varchar(500) NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `start` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL COMMENT '注册时间',
  `update_time` int(11) DEFAULT NULL,
  `is_visible` int(1) NOT NULL DEFAULT '1' COMMENT '1显示0隐藏',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qy_user
-- ----------------------------

-- ----------------------------
-- Table structure for qy_user_address
-- ----------------------------
DROP TABLE IF EXISTS `qy_user_address`;
CREATE TABLE `qy_user_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT '收获人姓名',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `city` varchar(400) DEFAULT NULL COMMENT '市',
  `detail` varchar(400) DEFAULT NULL COMMENT '详细地址',
  `user_id` int(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qy_user_address
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `key` varchar(255) NOT NULL DEFAULT '' COMMENT '配置项',
  `value` varchar(1000) NOT NULL DEFAULT '' COMMENT '配置值json',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '描述',
  `type` int(11) NOT NULL COMMENT '1基础2交易',
  `is_use` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否启用 1启用 0不启用',
  `update_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=963 COMMENT='第三方配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', 'web_name', '如花拼团123', '商城名称', '1', '1', '1546850342');
INSERT INTO `sys_config` VALUES ('2', 'api_url', 'https://wx.phps.shop', 'API网址', '1', '1', '1546850342');
INSERT INTO `sys_config` VALUES ('3', 'wx_token_expire', '7200', 'token有效期', '1', '1', '1546850342');
INSERT INTO `sys_config` VALUES ('4', 'gzh_appid', '1', '公众号APPID', '2', '1', '1546850420');
INSERT INTO `sys_config` VALUES ('5', 'gzh_secret', '1', '公众号Secret', '2', '1', '1546850420');
INSERT INTO `sys_config` VALUES ('6', 'wx_app_id', '1', '小程序appid', '2', '1', '1546850420');
INSERT INTO `sys_config` VALUES ('7', 'wx_app_secret', '1', '小程序Secret', '2', '1', '1546850420');
INSERT INTO `sys_config` VALUES ('8', 'pay_num', '1', '商户号', '2', '1', '1546850420');
INSERT INTO `sys_config` VALUES ('9', 'pay_key', '1', '商户key', '2', '1', '1546850420');
INSERT INTO `sys_config` VALUES ('10', 'tel', '000', '联系电话', '1', '1', '1546850342');
INSERT INTO `sys_config` VALUES ('11', 'company', '如花公司', '公司名称', '1', '1', '1546850342');
INSERT INTO `sys_config` VALUES ('12', 'item_expire', '7200', '团单过期时间', '1', '1', '1546850342');
INSERT INTO `sys_config` VALUES ('13', 'accept_time', '7', '自动收货时间', '1', '1', '1546850342');
INSERT INTO `sys_config` VALUES ('14', '', '', '', '0', '1', '0');
