-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2018-09-21 03:55:44
-- 服务器版本： 10.1.19-MariaDB
-- PHP Version: 5.6.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ptapi`
--

-- --------------------------------------------------------

--
-- 表的结构 `qy_admins`
--

CREATE TABLE `qy_admins` (
  `id` int(11) NOT NULL,
  `username` varchar(40) NOT NULL,
  `password` varchar(60) NOT NULL,
  `group_id` tinyint(4) NOT NULL COMMENT '管理组ID',
  `ip` varchar(30) NOT NULL,
  `state` int(1) NOT NULL DEFAULT '0' COMMENT '是否禁用',
  `description` varchar(200) NOT NULL,
  `login_time` int(11) NOT NULL,
  `create_time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `qy_admins`
--

INSERT INTO `qy_admins` (`id`, `username`, `password`, `group_id`, `ip`, `state`, `description`, `login_time`, `create_time`) VALUES
(1, 'admin', 'ed3958c076df68df0f433043c7d3466b', 1, '', 0, '', 0, 1536931075);

-- --------------------------------------------------------

--
-- 表的结构 `qy_article`
--

CREATE TABLE `qy_article` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '文章编号',
  `title` varchar(50) NOT NULL COMMENT '文章标题',
  `summary` varchar(140) NOT NULL DEFAULT '' COMMENT '文章摘要',
  `content` text NOT NULL COMMENT '文章正文',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '文章标题图片',
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-显示、1-隐藏',
  `author` varchar(50) NOT NULL COMMENT '发布者用户名 ',
  `create_time` int(11) DEFAULT '0' COMMENT '文章发布时间'
) ENGINE=InnoDB AVG_ROW_LENGTH=6553 DEFAULT CHARSET=utf8 COMMENT='CMS文章表';

--
-- 转存表中的数据 `qy_article`
--

INSERT INTO `qy_article` (`id`, `title`, `summary`, `content`, `image`, `is_hidden`, `author`, `create_time`) VALUES
(2, '标题2222', '摘要2222', '内容222222222222222', '', 0, 'admin', 1532923367),
(4, 'aaaaaaa', '', '2222222222222222222222', '', 0, 'admin', 1537245949),
(5, 'vvv', '', 'asdad', '', 0, 'admin', 1537245966);

-- --------------------------------------------------------

--
-- 表的结构 `qy_banner`
--

CREATE TABLE `qy_banner` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL COMMENT 'Banner名称，通常作为标识',
  `description` varchar(255) DEFAULT NULL COMMENT 'Banner描述',
  `delete_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='banner管理表';

--
-- 转存表中的数据 `qy_banner`
--

INSERT INTO `qy_banner` (`id`, `name`, `description`, `delete_time`, `update_time`) VALUES
(1, 'index_banner', '首页banner位', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `qy_banner_item`
--

CREATE TABLE `qy_banner_item` (
  `id` int(11) NOT NULL,
  `img_id` int(11) NOT NULL COMMENT '外键，关联image表',
  `key_word` varchar(100) NOT NULL COMMENT '执行关键字，根据不同的type含义不同',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '跳转类型，可能导向商品，可能导向专题，可能导向其他。0，无导向；1：导向商品;2:导向专题',
  `delete_time` int(11) DEFAULT NULL,
  `banner_id` int(11) NOT NULL COMMENT '外键，关联banner表',
  `update_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='banner子项表';

--
-- 转存表中的数据 `qy_banner_item`
--

INSERT INTO `qy_banner_item` (`id`, `img_id`, `key_word`, `type`, `delete_time`, `banner_id`, `update_time`) VALUES
(1, 232, '1', 1, NULL, 1, 1537412671),
(2, 234, '2', 1, NULL, 1, 1537413115),
(3, 235, '3', 1, NULL, 1, 1537413240),
(4, 236, '4', 1, NULL, 1, 1537413246);

-- --------------------------------------------------------

--
-- 表的结构 `qy_category`
--

CREATE TABLE `qy_category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(50) NOT NULL DEFAULT '',
  `short_name` varchar(50) NOT NULL DEFAULT '' COMMENT '商品分类简称 ',
  `pid` int(11) NOT NULL DEFAULT '0',
  `level` tinyint(4) NOT NULL DEFAULT '0',
  `is_visible` int(11) NOT NULL DEFAULT '1' COMMENT '是否显示  1 显示 0 不显示',
  `sort` int(11) DEFAULT NULL,
  `category_pic` varchar(255) NOT NULL DEFAULT '' COMMENT '商品分类图片'
) ENGINE=InnoDB AVG_ROW_LENGTH=244 DEFAULT CHARSET=utf8 COMMENT='商品分类表';

--
-- 转存表中的数据 `qy_category`
--

INSERT INTO `qy_category` (`category_id`, `category_name`, `short_name`, `pid`, `level`, `is_visible`, `sort`, `category_pic`) VALUES
(1, '家用电器', '家电', 0, 1, 1, 0, '81'),
(2, '电视机', '电视', 1, 2, 1, 0, '82'),
(3, '空调', '空调', 1, 2, 1, 0, '83'),
(4, '洗衣机', '洗衣机', 1, 2, 1, 0, '108'),
(5, '手机/数码', '手机数码', 0, 1, 1, 0, '84'),
(6, '手机通讯', '手机通讯', 5, 2, 1, 0, '109'),
(7, '手机配件', '手机配件', 5, 2, 1, 0, '85'),
(8, '摄影摄像', '摄影摄像', 5, 2, 1, 0, '86'),
(9, '数码配件', '数码配件', 5, 2, 1, 0, '87'),
(10, '电脑/办公', '电脑办公', 0, 1, 1, 0, '88'),
(11, '电脑整机', '电脑', 10, 2, 1, 0, '89'),
(12, '电脑配件', '电脑配件', 10, 2, 1, 0, '90'),
(13, '外设产品', '外设产品', 10, 2, 1, 0, '91'),
(14, '办公设备', '办公设备', 10, 2, 1, 0, '92'),
(15, '家居/家具', '家居家具', 0, 1, 1, 0, '93'),
(16, '厨具', '厨具', 15, 2, 1, 0, '94'),
(17, '家纺', '家纺', 15, 2, 1, 0, '95'),
(18, '灯具', '灯具', 15, 2, 1, 0, '96'),
(19, '家具', '家具', 15, 2, 1, 0, '97'),
(20, '男装/女装', '服装', 0, 1, 1, 0, '98'),
(21, '女装', '女装', 20, 2, 1, 0, '99'),
(22, '男装', '男装', 20, 2, 1, 0, '100'),
(23, '内衣', '内衣', 20, 2, 1, 0, '101'),
(24, '配饰', '配饰', 20, 2, 1, 0, '102'),
(25, '美妆/个护清洁', '美妆个护', 0, 1, 1, 0, '103'),
(26, '面部护肤', '面部护肤', 25, 2, 1, 0, '104'),
(27, '香水彩妆', '香水彩妆', 25, 2, 1, 0, '105'),
(28, '男士护肤', '男士护肤', 25, 2, 1, 0, '106'),
(29, '洗发护发', '洗发护发', 25, 2, 1, 0, '107'),
(30, 'aa', '1', 1, 2, 1, 0, '238');

-- --------------------------------------------------------

--
-- 表的结构 `qy_favorites`
--

CREATE TABLE `qy_favorites` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '记录ID',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '会员ID',
  `fav_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '商品或店铺ID',
  `type` varchar(20) NOT NULL DEFAULT 'goods' COMMENT '类型:goods为商品,shop为店铺,默认为商品',
  `img_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '商品收藏时价格',
  `create_time` int(11) DEFAULT '0' COMMENT '收藏时间'
) ENGINE=InnoDB AVG_ROW_LENGTH=8192 DEFAULT CHARSET=utf8 COMMENT='收藏表';

--
-- 转存表中的数据 `qy_favorites`
--

INSERT INTO `qy_favorites` (`id`, `uid`, `fav_id`, `type`, `img_id`, `price`, `create_time`) VALUES
(1, 14, 7, 'goods', 118, '0.01', 1537417202),
(2, 14, 5, 'goods', 116, '0.01', 1537417448);

-- --------------------------------------------------------

--
-- 表的结构 `qy_goods`
--

CREATE TABLE `qy_goods` (
  `goods_id` int(10) UNSIGNED NOT NULL COMMENT '商品id(SKU)',
  `goods_name` varchar(100) NOT NULL DEFAULT '' COMMENT '商品名称',
  `shop_id` int(10) UNSIGNED NOT NULL DEFAULT '1' COMMENT '店铺id',
  `shop_name` varchar(400) NOT NULL COMMENT '店铺名称',
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '商品分类id',
  `people` tinyint(4) NOT NULL DEFAULT '2' COMMENT '拼团满足人数',
  `brand_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '品牌id',
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
  `clicks` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '商品点击数量',
  `min_stock_alarm` int(11) NOT NULL DEFAULT '0' COMMENT '库存预警值',
  `sales` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '销售数量',
  `collects` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `star` tinyint(3) UNSIGNED NOT NULL DEFAULT '5' COMMENT '好评星级',
  `evaluates` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '评价数',
  `shares` int(11) NOT NULL DEFAULT '0' COMMENT '分享数',
  `province_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '一级地区id',
  `city_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '二级地区id',
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
  `delete_time` int(11) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=16554 DEFAULT CHARSET=utf8 COMMENT='商品表';

--
-- 转存表中的数据 `qy_goods`
--

INSERT INTO `qy_goods` (`goods_id`, `goods_name`, `shop_id`, `shop_name`, `category_id`, `people`, `brand_id`, `market_price`, `price`, `only_price`, `cost_price`, `point_exchange_type`, `point_exchange`, `give_point`, `is_member_discount`, `shipping_fee`, `shipping_fee_id`, `stock`, `max_buy`, `clicks`, `min_stock_alarm`, `sales`, `collects`, `star`, `evaluates`, `shares`, `province_id`, `city_id`, `img_id`, `keywords`, `description`, `content`, `QRcode`, `code`, `is_hot`, `is_recommend`, `is_new`, `state`, `sort`, `img_id_array`, `sku_img_array`, `real_sales`, `goods_attribute_id`, `goods_spec_format`, `goods_weight`, `goods_volume`, `shipping_fee_type`, `supplier_id`, `sale_date`, `create_time`, `update_time`, `min_buy`, `virtual_goods_type_id`, `production_date`, `shelf_life`, `goods_video_address`, `pc_custom_template`, `wap_custom_template`, `max_use_point`, `goods_unit`, `delete_time`) VALUES
(1, '夏普 (SHARP)LCD-60SU470A 60英寸 4K超高清人工智能语音 HDR 智能网络液晶平板电视机', 1, '', 2, 2, 0, '3299.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '11.00', 0, 111, 0, 0, 0, 102, 0, 5, 0, 0, 0, 0, 112, '', '', '', '', '', 0, 1, 1, 0, 0, '142,143,144', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536649662, 1536896347, 0, 0, 0, '', '', '', '', 0, '', NULL),
(2, '海尔（Haier) 滚筒洗衣机全自动 8公斤变频 双喷淋泡沫无残留 防霉 EG8012B39SU1', 1, '', 4, 2, 0, '2599.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '22.00', 0, 222, 0, 0, 0, 56, 0, 5, 0, 0, 0, 0, 113, '', '', '', '', '', 0, 1, 0, 0, 0, '145,146,147', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536650081, 1536896347, 0, 0, 0, '', '', '', '', 0, '', NULL),
(3, '小天鹅（LittleSwan）8公斤变频滚筒洗衣机 1400转电机喷淋无残留 抗菌门封圈 TG80V20DG5', 1, '', 4, 2, 0, '2399.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '33.00', 0, 333, 0, 0, 0, 102, 0, 5, 0, 0, 0, 0, 114, '', '', '', '', '', 0, 1, 0, 0, 0, '148,149,150', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536650373, 1536896347, 0, 0, 0, '', '', '', '', 0, '', NULL),
(4, '格力正1.5匹 变频 品圆 --测试商品', 1, '', 3, 2, 0, '2999.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '44.00', 0, 444, 1, 0, 0, 12, 0, 5, 0, 0, 0, 0, 115, '', '', '', '', '', 0, 0, 0, 1, 0, '151,152,153', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536650841, 1537416244, 0, 0, 0, '', '', '', '', 0, '', NULL),
(5, '奥克斯  正1.5匹 一级能效 --测试商品', 1, '', 3, 2, 0, '2799.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '55.00', 0, 555, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 116, '', '', '', '', '', 0, 0, 0, 1, 0, '154,155,156', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536650906, 1537233729, 0, 0, 0, '', '', '', '', 0, '', NULL),
(6, 'Apple iPhone 8 Plus --测试商品', 1, '', 6, 2, 0, '5999.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '66.00', 0, 666, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 117, '', '', '', '', '', 0, 0, 0, 1, 0, '157,158,159', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536651551, 1537233712, 0, 0, 0, '', '', '', '', 0, '', NULL),
(7, '荣耀9i  幻夜黑 --测试商品', 1, '', 6, 2, 0, '1299.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '77.00', 0, 777, 1, 0, 0, 54, 0, 5, 0, 0, 0, 0, 118, '', '', '', '', '', 0, 0, 0, 1, 0, '160,161,162', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536651778, 1537234896, 0, 0, 0, '', '', '', '', 0, '', NULL),
(8, '尼康单反数码照相机 --测试商品', 1, '', 8, 2, 0, '3000.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '88.00', 0, 888, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 119, '', '', '', '', '', 0, 0, 0, 1, 0, '163,164,165', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536652779, 1537233657, 0, 0, 0, '', '', '', '', 0, '', NULL),
(9, '索尼微单数码相机标准套装 --测试商品', 1, '', 8, 2, 0, '3799.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '99.00', 0, 999, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 120, '', '', '', '', '', 0, 0, 0, 1, 0, '166,167,168', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536652881, 1537233635, 0, 0, 0, '', '', '', '', 0, '', NULL),
(10, '萌怀表手机扣指环扣支架--测试商品', 1, '', 7, 2, 0, '20.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '10.00', 0, 10, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 121, '', '', '', '', '', 1, 0, 0, 1, 0, '169,170,171', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536653108, 1537233621, 0, 0, 0, '', '', '', '', 0, '', NULL),
(11, '戴尔游匣G3烈焰版--测试商品', 1, '', 11, 2, 0, '6299.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '11.00', 0, 111, 1, 0, 0, 121, 0, 5, 0, 0, 0, 0, 122, '', '', '', '', '', 0, 0, 0, 1, 0, '172,173,174', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536653303, 1537233503, 0, 0, 0, '', '', '', '', 0, '', NULL),
(12, '套装/CPU主板主机套装--测试商品', 1, '', 12, 2, 0, '3799.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '12.00', 0, 122, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 123, '', '', '', '', '', 0, 0, 1, 1, 0, '175,176,177', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536653458, 1537233486, 0, 0, 0, '', '', '', '', 0, '', NULL),
(13, '希捷酷鱼系列 --测试商品', 1, '', 12, 2, 0, '560.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '13.00', 0, 133, 2, 0, 0, 102, 0, 5, 0, 0, 0, 0, 124, '', '', '', '', '', 0, 0, 0, 1, 0, '178,179,180', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536653629, 1537233468, 0, 0, 0, '', '', '', '', 0, '', NULL),
(14, '普多功能三合一黑白激光一体机 --测试商品', 1, '', 14, 2, 0, '1199.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '14.00', 0, 144, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 125, '', '', '', '', '', 0, 0, 0, 1, 0, '181,182,183', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536653909, 1537233451, 0, 0, 0, '', '', '', '', 0, '', NULL),
(15, '惠普彩色喷墨三合一--测试商品', 1, '', 14, 2, 0, '399.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '15.00', 0, 15, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 126, '', '', '', '', '', 0, 0, 0, 1, 0, '184,185,186', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536654291, 1537233436, 0, 0, 0, '', '', '', '', 0, '', NULL),
(16, '美厨锅具套装 --测试商品', 1, '', 16, 2, 0, '199.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '16.00', 0, 166, 2, 0, 0, 152, 0, 5, 0, 0, 0, 0, 127, '', '', '', '', '', 1, 0, 0, 1, 0, '187,188,189', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536654459, 1537233417, 0, 0, 0, '', '', '', '', 0, '', NULL),
(17, '拜格 锅具套装12件套--测试商品', 1, '', 16, 2, 0, '179.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '17.00', 0, 177, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 128, '', '', '', '', '', 0, 0, 0, 1, 0, '190,191,192', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536654587, 1537233401, 0, 0, 0, '', '', '', '', 0, '', NULL),
(18, '南极人被芯家纺 --测试商品', 1, '', 17, 2, 0, '99.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '18.00', 0, 188, 2, 0, 0, 102, 0, 5, 0, 0, 0, 0, 129, '', '', '', '', '', 0, 0, 0, 1, 0, '193,194,195', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536654681, 1537233313, 0, 0, 0, '', '', '', '', 0, '', NULL),
(19, '欧普照明吸顶灯具 --测试商品', 1, '', 18, 2, 0, '129.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '18.00', 0, 188, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 130, '', '', '', '', '', 0, 0, 1, 1, 0, '196,197,198', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536654863, 1537233299, 0, 0, 0, '', '', '', '', 0, '', NULL),
(20, '欧质 布艺沙发 --测试商品', 1, '', 19, 2, 0, '1199.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '19.00', 0, 199, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 131, '', '', '', '', '', 0, 0, 0, 0, 0, '199,200,201', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536655038, 1537233280, 0, 0, 0, '', '', '', '', 0, '', NULL),
(21, '七匹狼 短袖T恤男 --测试商品', 1, '', 22, 2, 0, '169.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '21.00', 0, 21, 3, 0, 0, 102, 0, 5, 0, 0, 0, 0, 132, '', '', '', '', '', 0, 0, 0, 1, 0, '202,203,204', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536655282, 1537234666, 0, 0, 0, '', '', '', '', 0, '', NULL),
(22, '子牧棉麻2018秋季新品--测试商品', 1, '', 21, 2, 0, '169.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '22.00', 0, 222, 2, 0, 0, 45, 0, 5, 0, 0, 0, 0, 133, '', '', '', '', '', 0, 1, 0, 0, 0, '205,206,207', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536655364, 1537233251, 0, 0, 0, '', '', '', '', 0, '', NULL),
(23, '子牧棉麻2018秋季新品民族风女装中式民国风改良旗袍复古假二件连衣裙9765 蓝色 L(建议100-110斤)', 1, '', 21, 2, 0, '169.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '22.00', 0, 222, 0, 0, 0, 102, 0, 5, 0, 0, 0, 0, 0, '', '', '', '', '', 0, 0, 0, 1, 0, NULL, NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536655458, 1536717507, 0, 0, 0, '', '', '', '', 0, '', 1536717507),
(24, '宝姿女装2018秋季新品--测试商品', 1, '', 21, 2, 0, '6700.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '23.00', 0, 233, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 135, '', '', '', '', '', 0, 0, 0, 0, 0, '211,212,213', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536655581, 1537233227, 0, 0, 0, '', '', '', '', 0, '', NULL),
(25, '花花公子秋衣秋裤--测试商品', 1, '', 23, 2, 0, '99.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '24.00', 0, 244, 1, 0, 0, 22, 0, 5, 0, 0, 0, 0, 136, '', '', '', '', '', 0, 0, 0, 1, 0, '214,215,216', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536655697, 1537234975, 0, 0, 0, '', '', '', '', 0, '', NULL),
(26, '衣服配饰四叶草装饰品项链女日韩毛衣链长款大气百搭夏季简约挂件 四叶草银色', 1, '', 24, 2, 0, '49.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '25.00', 0, 25, 0, 0, 0, 102, 0, 5, 0, 0, 0, 0, 137, '', '', '', '', '', 0, 0, 0, 1, 0, '217,218,219', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536655780, 1537158467, 0, 0, 0, '', '', '', '', 0, '', 1537158467),
(27, 'SK-II"神仙水"75ml补水保湿精华露护肤套装（礼赠洁面霜+清莹露+面霜+眼霜 面部护肤 精华液）', 1, '', 26, 2, 0, '800.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '26.00', 0, 26, 0, 0, 0, 102, 0, 5, 0, 0, 0, 0, 138, '', '', '', '', '', 0, 0, 0, 0, 0, '220,221,222', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536656009, 1536896347, 0, 0, 0, '', '', '', '', 0, '', NULL),
(28, '俏美人彩妆套装--测试商品', 1, '', 27, 2, 0, '277.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '27.00', 0, 27, 1, 0, 0, 102, 0, 5, 0, 0, 0, 0, 139, '', '', '', '', '', 0, 0, 0, 1, 0, '223,224,225', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536656086, 1537233212, 0, 0, 0, '', '', '', '', 0, '', NULL),
(29, '悦宝莱撕拉式吸去黑头面膜套装 清洁去粉刺收缩毛孔祛黑头猪鼻贴面膜泥男士女士鼻膜补水保湿吸黑头导出液', 1, '', 25, 2, 0, '78.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '27.00', 0, 33, 0, 0, 0, 102, 0, 5, 0, 0, 0, 0, 0, '', '', '', '', '', 0, 0, 0, 0, 0, '0', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536656169, 1536730844, 0, 0, 0, '', '', '', '', 0, '', NULL),
(30, '海飞丝去屑护肤洗发水护根防掉发型200ml', 1, '', 29, 2, 0, '32.00', '0.01', '0.02', '0.00', 0, 0, 0, 0, '6.00', 0, 666, 0, 0, 0, 102, 0, 5, 0, 0, 0, 0, 141, '', '', '', '', '', 0, 0, 0, 0, 0, '229,230,231', NULL, 0, 0, '', '0.00', '0.00', 1, 0, 0, 1536656359, 1536896347, 0, 0, 0, '', '', '', '', 0, '', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `qy_goods_sku`
--

CREATE TABLE `qy_goods_sku` (
  `sku_id` int(11) NOT NULL COMMENT '表序号',
  `goods_id` int(11) NOT NULL DEFAULT '0' COMMENT '商品编号',
  `sku_name` varchar(500) NOT NULL DEFAULT '' COMMENT 'SKU名称',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `only_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单独购买价格',
  `stock` int(11) NOT NULL DEFAULT '0' COMMENT '库存',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT '如果是第一个sku编码, 可以加图片',
  `create_date` int(11) DEFAULT '0' COMMENT '创建时间',
  `update_date` int(11) DEFAULT '0' COMMENT '修改时间'
) ENGINE=InnoDB AVG_ROW_LENGTH=481 DEFAULT CHARSET=utf8 COMMENT='商品skui规格价格库存信息表';

--
-- 转存表中的数据 `qy_goods_sku`
--

INSERT INTO `qy_goods_sku` (`sku_id`, `goods_id`, `sku_name`, `market_price`, `price`, `only_price`, `stock`, `picture`, `create_date`, `update_date`) VALUES
(1, 3, '8公斤爆款滚筒', '2399.00', '0.01', '0.02', 333, 0, 0, 0),
(2, 3, '10公斤爆款滚筒', '2799.00', '0.02', '0.03', 333, 0, 0, 0),
(3, 4, '大1匹', '3299.00', '0.01', '0.02', 444, 239, 0, 0),
(4, 4, '正1.5匹', '3599.00', '0.02', '0.03', 444, 240, 0, 0),
(5, 7, '幻夜黑 4GB 64GB 标配', '1299.00', '0.01', '0.02', 777, 247, 0, 0),
(6, 7, '梦幻紫 4GB 128GB 标配', '1699.00', '0.02', '0.03', 777, 0, 0, 0),
(7, 9, '白色', '3799.00', '0.01', '0.02', 999, 0, 0, 0),
(8, 9, '黑色', '3799.00', '0.01', '0.02', 999, 0, 0, 0),
(9, 13, '1T', '329.00', '0.01', '0.02', 133, 0, 0, 0),
(10, 13, '2T', '459.00', '0.01', '0.02', 133, 0, 0, 0),
(11, 14, 'M126nw【黑白三合一whif版】', '1899.00', '0.01', '0.02', 33, 0, 0, 0),
(12, 14, 'M126a【黑白三合一】', '1199.00', '0.01', '0.02', 44, 0, 0, 0),
(13, 18, '米黄 5斤', '99.00', '0.01', '0.02', 99, 0, 0, 0),
(14, 18, '米黄 6斤 加厚', '99.00', '0.01', '0.02', 99, 0, 0, 0),
(15, 19, '【纯白款】4.5瓦直径17.3', '129.00', '0.01', '0.02', 99, 0, 0, 0),
(16, 19, '【纯白款】10瓦直径23', '149.00', '0.01', '0.02', 59, 0, 0, 0),
(17, 20, '玛瑙灰3人位PLUS', '1199.00', '0.01', '0.02', 99, 0, 0, 0),
(18, 20, '铂金黄3人位PLUS', '1199.00', '0.02', '0.03', 99, 0, 0, 0),
(19, 21, '柠檬黄', '0.00', '0.01', '0.02', 0, 243, 0, 0),
(20, 21, '湖蓝', '0.00', '0.01', '0.02', 0, 244, 0, 0),
(21, 23, '红色 M', '169.00', '0.01', '0.02', 99, 0, 0, 0),
(22, 23, '蓝色XL', '169.00', '0.02', '0.03', 99, 0, 0, 0),
(23, 25, '黑色深V', '99.00', '0.01', '0.02', 99, 246, 0, 0),
(24, 25, '藏青深V', '99.00', '0.01', '0.02', 99, 248, 0, 0),
(25, 27, '“神仙水”礼盒230ML', '1399.00', '0.01', '0.02', 1399, 0, 0, 0),
(26, 27, '神仙水330ML', '1399.00', '0.01', '0.02', 1399, 0, 0, 0),
(27, 30, '丝质柔滑', '32.00', '0.01', '0.02', 32, 0, 0, 0),
(28, 30, '清爽去油', '32.00', '0.01', '0.02', 23, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `qy_image`
--

CREATE TABLE `qy_image` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL COMMENT '图片路径',
  `from` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 来自本地，2 来自公网',
  `use_name` varchar(80) NOT NULL,
  `delete_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图片总表';

--
-- 转存表中的数据 `qy_image`
--

INSERT INTO `qy_image` (`id`, `url`, `from`, `use_name`, `delete_time`, `update_time`) VALUES
(33, '/uploads/category/20180910\\58f6b445a31a388d6d7444b354cf2ec4.jpg', 1, '/category', NULL, 1536587363),
(34, '/uploads/category/20180910\\6fa3dbec2b59210cd7f61778c3e8c779.jpg', 1, '/category', NULL, 1536587403),
(35, '/uploads/category/20180910\\ca8a49ee9de00b572b506e4ddcafc6c2.jpg', 1, '', NULL, 1536587464),
(36, '/uploadscategory/20180910\\fefca0f0a16bc4a4a183e5ec8a807f92.jpg', 1, 'category', NULL, 1536587541),
(37, '/uploads/category/20180910\\031163e309542938a688968a11aba5e7.jpg', 1, 'category', NULL, 1536587570),
(38, '/uploads/category/20180910\\5caa279f2c5209209dedca848847da17.jpg', 1, 'category', NULL, 1536587668),
(39, '/uploads/category/20180910\\e07aacb2f4067cd1da807711576bdd33.jpg', 1, 'category', NULL, 1536587678),
(40, '/uploads/category/20180910\\4c17609d46e32c57810e6b8498e06175.jpg', 1, 'category', NULL, 1536587814),
(41, '/uploads/category/20180910\\f771876df5da0012fbcda84e83155616.jpg', 1, 'category', NULL, 1536587833),
(42, '/uploads/category/20180910\\591d104b43503ba1fd05b380909243a6.jpg', 1, 'category', NULL, 1536587870),
(43, '/uploads/category/20180910\\5ef26f8c329ea198f57601fe0d583d5d.jpg', 1, 'category', NULL, 1536588035),
(44, '/uploads/category/20180910\\fd031ddad629511943690949c25e2f20.jpg', 1, 'category', NULL, 1536588096),
(45, '/uploads/category/20180910\\c3d3bcac6fbbb4d90d4b80a54171a386.jpg', 1, 'category', NULL, 1536588155),
(46, '/uploads/category/20180910\\4ec3df3b0063bf8bf2731787411ee16c.jpg', 1, 'category', NULL, 1536588262),
(47, '/uploads/category/20180910\\8b5b94a49a81f52e8c8801ea61821be0.jpg', 1, 'category', NULL, 1536588279),
(48, '/uploads/category/20180910\\72aad40f4d69cc213eafc3d608da6adb.jpg', 1, 'category', NULL, 1536588524),
(49, '/uploads/category/20180910\\4a31026cfa29d2e8cde416769245d541.jpg', 1, 'category', NULL, 1536588547),
(50, '/uploads/category/20180910\\4a692dea5bf632b574acd6e6a41c3b06.jpg', 1, 'category', NULL, 1536588555),
(51, '/uploads/category/20180910\\0d4e0d725e2ceb5df83ec0780488aa68.jpg', 1, 'category', NULL, 1536588633),
(52, '/uploads/category/20180910\\8c427d33bcbdb351f4f4fdec7cb8fbf5.jpg', 1, 'category', NULL, 1536588636),
(53, '/uploads/category/20180910\\1f94cd1986c62fed56308831e9e2cdfb.jpg', 1, 'category', NULL, 1536588662),
(54, '/uploads/category/20180910\\72c572db0570bf318c94b3fac220bec1.jpg', 1, 'category', NULL, 1536588681),
(55, '/uploads/category/20180910\\b2800343b1879c40ab3fcf45ff16c929.jpg', 1, 'category', NULL, 1536588746),
(56, '/uploads/category/20180910\\aeb3d7c1121be04badb4813fe73bf29f.jpg', 1, 'category', NULL, 1536588768),
(57, '/uploads/category/20180910\\684c5f43e0e2ded74f31bf72ce1792e4.jpg', 1, 'category', NULL, 1536588844),
(58, '/uploads/category/20180910\\d45a221603f495e026faa920ad303ace.jpg', 1, 'category', NULL, 1536588955),
(59, '/uploads/category/20180910\\367fd653ddd93ebcd6e80185e635d85d.jpg', 1, 'category', NULL, 1536589275),
(60, '/uploads/category/20180910\\b55c7fd59af70d51fa90a6e8b50f63b2.jpg', 1, 'category', NULL, 1536589335),
(61, '/uploads/category/20180910\\8ad8e0dff9d50b1505eacae5a362d7e9.jpg', 1, 'category', NULL, 1536589370),
(62, '/uploads/category/20180910\\d8de43a4b1077d44fd7ca63972926d7d.jpg', 1, 'category', NULL, 1536590429),
(63, '/uploads/category/20180910\\bf1609194221da36e5dca92abcf70de3.jpg', 1, 'category', NULL, 1536591783),
(64, '/uploads/category/20180910\\9b73fbe9c3f4093cffe72905ea22c2e2.jpg', 1, 'category', NULL, 1536591839),
(65, '/uploads/category/20180910\\80af4c9c70e400ff3b0f9258ba4f3e58.jpg', 1, 'category', NULL, 1536591849),
(66, '/uploads/category/20180910\\a5760744abf35c1accbff1d9ab3be03c.jpg', 1, 'category', NULL, 1536591921),
(67, '/uploads/category/20180910\\06a5768c5a54d90783cfc44becc091ea.jpg', 1, 'category', NULL, 1536591988),
(68, '/uploads/category/20180910\\d9ef4ae804208ebaf931166740c68db6.jpg', 1, 'category', NULL, 1536592042),
(69, '/uploads/category/20180910\\90120c652c8617a6743d0bc263f5b909.jpg', 1, 'category', NULL, 1536592053),
(70, '/uploads/category/20180910\\af185d3c76df7293ff48a1df0b1f433d.jpg', 1, 'category', NULL, 1536592106),
(71, '/uploads/category/20180910\\a3bbc1d02c407ae43d21aadc951781af.jpg', 1, 'category', NULL, 1536592227),
(72, '/uploads/category/20180910\\ba7eeb31cb4b159647a458c13109045f.jpg', 1, 'category', NULL, 1536592260),
(73, '/uploads/category/20180910\\c2252b1dca9c0de32ef08b754f0dc09f.jpg', 1, 'category', NULL, 1536592347),
(74, '/uploads/category/20180910\\081312457ca80417c56218f5ab747e18.jpg', 1, 'category', NULL, 1536592476),
(75, '/uploads/category/20180910\\64665695152e130efa902697db66c4aa.jpg', 1, 'category', NULL, 1536592497),
(76, '/uploads/category/20180910\\c8742358593ec0120a5de683e0842356.jpg', 1, 'category', NULL, 1536592523),
(77, '/uploads/category/20180910\\f879bec6e6c0b8637f2c7f0e266b7d5e.jpg', 1, 'category', NULL, 1536592542),
(78, '/uploads/category/20180910\\91c57ad080aae95eb470f485584258e7.jpg', 1, 'category', NULL, 1536592739),
(79, '/uploads/category/20180911\\77057d9a3d4b0a7bddf5dfd4567617cb.jpg', 1, 'category', NULL, 1536626762),
(80, '/uploads/category/20180911\\0be4355a6871b9703ab7dbb77bab2e85.jpg', 1, 'category', NULL, 1536626772),
(81, '/uploads/category/20180911\\c3f1ba9160e6d5b2b4db148390056134.png', 1, 'category', NULL, 1536641999),
(82, '/uploads/category/20180911\\28937f5cf0c464eaa3c4015999200a44.png', 1, 'category', NULL, 1536642666),
(83, '/uploads/category/20180911\\0344f5d68023bef9d2270782cc4c1afe.png', 1, 'category', NULL, 1536642721),
(84, '/uploads/category/20180911\\04150a0b381933024e0d403da2cf55a2.png', 1, 'category', NULL, 1536643245),
(85, '/uploads/category/20180911\\82996bad850a3c4f1657bbd0ff16e2ae.png', 1, 'category', NULL, 1536643365),
(86, '/uploads/category/20180911\\cdb13b2d5400ced4ccb9e40d837b23d3.png', 1, 'category', NULL, 1536643416),
(87, '/uploads/category/20180911\\c201274fd7a44862e7e7cbca9f4634d2.png', 1, 'category', NULL, 1536643466),
(88, '/uploads/category/20180911\\658876d1d4dfa082ef24be9c5219bb0e.png', 1, 'category', NULL, 1536643734),
(89, '/uploads/category/20180911\\b953efa22705ad7b3125ad9f6ed6bb21.png', 1, 'category', NULL, 1536643795),
(90, '/uploads/category/20180911\\6dd670dbdbd2cdbd5d11b28ad613c74c.png', 1, 'category', NULL, 1536643868),
(91, '/uploads/category/20180911\\8243411fbaa74710bc0b987539780740.png', 1, 'category', NULL, 1536643877),
(92, '/uploads/category/20180911\\723bbb47a13194e6becb88241f960c17.png', 1, 'category', NULL, 1536643921),
(93, '/uploads/category/20180911\\97405ddd6490e70ab920b6f74359507c.png', 1, 'category', NULL, 1536644105),
(94, '/uploads/category/20180911\\920f70582eee023df7d47c072a74805e.png', 1, 'category', NULL, 1536644115),
(95, '/uploads/category/20180911\\55b9f1455c1308b49159fa0203bd7706.png', 1, 'category', NULL, 1536644125),
(96, '/uploads/category/20180911\\7f2c2050a60d8bab80bf9ff050d47fee.png', 1, 'category', NULL, 1536644137),
(97, '/uploads/category/20180911\\98b290dfc69e029ca725af669381b23a.png', 1, 'category', NULL, 1536644146),
(98, '/uploads/category/20180911\\2e89234fad75324da31d5b94b4612ccc.png', 1, 'category', NULL, 1536644209),
(99, '/uploads/category/20180911\\0988ae6944d67c6af7a85b95418069c7.png', 1, 'category', NULL, 1536644344),
(100, '/uploads/category/20180911\\58a6f16339233873340120bc0389a986.png', 1, 'category', NULL, 1536644351),
(101, '/uploads/category/20180911\\f8e0be3f024a880da56518dc9b2c6c4a.png', 1, 'category', NULL, 1536644370),
(102, '/uploads/category/20180911\\5be31794b193d38a53581baa5b640286.png', 1, 'category', NULL, 1536644380),
(103, '/uploads/category/20180911\\5bacce76e34604d42b8ad3c95891eaaf.png', 1, 'category', NULL, 1536644656),
(104, '/uploads/category/20180911\\5dee14297fd7c955552680c257fa1fdc.png', 1, 'category', NULL, 1536644668),
(105, '/uploads/category/20180911\\9c9073ec055897dc96c74dfed17f6db4.png', 1, 'category', NULL, 1536644680),
(106, '/uploads/category/20180911\\70a208e6131968d5f91be8222d9378d6.png', 1, 'category', NULL, 1536644688),
(107, '/uploads/category/20180911\\e1f531b24b43d35c2b5ea890e06b1bc4.png', 1, 'category', NULL, 1536644698),
(108, '/uploads/category/20180911\\c85fccb8857d15287448031f773f01cc.png', 1, 'category', NULL, 1536645514),
(109, '/uploads/category/20180911\\7fe84eb312354d686ee6acd97e03eeb5.png', 1, 'category', NULL, 1536645533),
(112, '/uploads/product/1/1.jpg', 1, 'product', NULL, 1536893925),
(113, '/uploads/product/2/1.jpg', 1, 'product', NULL, 1536893925),
(114, '/uploads/product/3/1.jpg', 1, 'product', NULL, 1536893925),
(115, '/uploads/product/4/1.jpg', 1, 'product', NULL, 1536893925),
(116, '/uploads/product/5/1.jpg', 1, 'product', NULL, 1536893925),
(117, '/uploads/product/6/1.jpg', 1, 'product', NULL, 1536893925),
(118, '/uploads/product/7/1.jpg', 1, 'product', NULL, 1536893925),
(119, '/uploads/product/8/1.jpg', 1, 'product', NULL, 1536893925),
(120, '/uploads/product/9/1.jpg', 1, 'product', NULL, 1536893925),
(121, '/uploads/product/10/1.jpg', 1, 'product', NULL, 1536893925),
(122, '/uploads/product/11/1.jpg', 1, 'product', NULL, 1536893925),
(123, '/uploads/product/12/1.jpg', 1, 'product', NULL, 1536893925),
(124, '/uploads/product/13/1.jpg', 1, 'product', NULL, 1536893925),
(125, '/uploads/product/14/1.jpg', 1, 'product', NULL, 1536893925),
(126, '/uploads/product/15/1.jpg', 1, 'product', NULL, 1536893925),
(127, '/uploads/product/16/1.jpg', 1, 'product', NULL, 1536893925),
(128, '/uploads/product/17/1.jpg', 1, 'product', NULL, 1536893925),
(129, '/uploads/product/18/1.jpg', 1, 'product', NULL, 1536893925),
(130, '/uploads/product/19/1.jpg', 1, 'product', NULL, 1536893925),
(131, '/uploads/product/20/1.jpg', 1, 'product', NULL, 1536893925),
(132, '/uploads/product/21/1.jpg', 1, 'product', NULL, 1536893925),
(133, '/uploads/product/22/1.jpg', 1, 'product', NULL, 1536893925),
(134, '/uploads/product/23/1.jpg', 1, 'product', NULL, 1536893925),
(135, '/uploads/product/24/1.jpg', 1, 'product', NULL, 1536893925),
(136, '/uploads/product/25/1.jpg', 1, 'product', NULL, 1536893925),
(137, '/uploads/product/26/1.jpg', 1, 'product', NULL, 1536893925),
(138, '/uploads/product/27/1.jpg', 1, 'product', NULL, 1536893925),
(139, '/uploads/product/28/1.jpg', 1, 'product', NULL, 1536893925),
(140, '/uploads/product/29/1.jpg', 1, 'product', NULL, 1536893925),
(141, '/uploads/product/30/1.jpg', 1, 'product', NULL, 1536893925),
(142, '/uploads/product/1/a.jpg', 1, 'product_info', NULL, 1536895169),
(143, '/uploads/product/1/b.jpg', 1, 'product_info', NULL, 1536895169),
(144, '/uploads/product/1/c.jpg', 1, 'product_info', NULL, 1536895169),
(145, '/uploads/product/2/a.jpg', 1, 'product_info', NULL, 1536895169),
(146, '/uploads/product/2/b.jpg', 1, 'product_info', NULL, 1536895169),
(147, '/uploads/product/2/c.jpg', 1, 'product_info', NULL, 1536895169),
(148, '/uploads/product/3/a.jpg', 1, 'product_info', NULL, 1536895169),
(149, '/uploads/product/3/b.jpg', 1, 'product_info', NULL, 1536895169),
(150, '/uploads/product/3/c.jpg', 1, 'product_info', NULL, 1536895169),
(151, '/uploads/product/4/a.jpg', 1, 'product_info', NULL, 1536895169),
(152, '/uploads/product/4/b.jpg', 1, 'product_info', NULL, 1536895169),
(153, '/uploads/product/4/c.jpg', 1, 'product_info', NULL, 1536895169),
(154, '/uploads/product/5/a.jpg', 1, 'product_info', NULL, 1536895169),
(155, '/uploads/product/5/b.jpg', 1, 'product_info', NULL, 1536895169),
(156, '/uploads/product/5/c.jpg', 1, 'product_info', NULL, 1536895169),
(157, '/uploads/product/6/a.jpg', 1, 'product_info', NULL, 1536895169),
(158, '/uploads/product/6/b.jpg', 1, 'product_info', NULL, 1536895169),
(159, '/uploads/product/6/c.jpg', 1, 'product_info', NULL, 1536895169),
(160, '/uploads/product/7/a.jpg', 1, 'product_info', NULL, 1536895169),
(161, '/uploads/product/7/b.jpg', 1, 'product_info', NULL, 1536895169),
(162, '/uploads/product/7/c.jpg', 1, 'product_info', NULL, 1536895169),
(163, '/uploads/product/8/a.jpg', 1, 'product_info', NULL, 1536895169),
(164, '/uploads/product/8/b.jpg', 1, 'product_info', NULL, 1536895169),
(165, '/uploads/product/8/c.jpg', 1, 'product_info', NULL, 1536895169),
(166, '/uploads/product/9/a.jpg', 1, 'product_info', NULL, 1536895169),
(167, '/uploads/product/9/b.jpg', 1, 'product_info', NULL, 1536895169),
(168, '/uploads/product/9/c.jpg', 1, 'product_info', NULL, 1536895169),
(169, '/uploads/product/10/a.jpg', 1, 'product_info', NULL, 1536895169),
(170, '/uploads/product/10/b.jpg', 1, 'product_info', NULL, 1536895169),
(171, '/uploads/product/10/c.jpg', 1, 'product_info', NULL, 1536895169),
(172, '/uploads/product/11/a.jpg', 1, 'product_info', NULL, 1536895169),
(173, '/uploads/product/11/b.jpg', 1, 'product_info', NULL, 1536895169),
(174, '/uploads/product/11/c.jpg', 1, 'product_info', NULL, 1536895169),
(175, '/uploads/product/12/a.jpg', 1, 'product_info', NULL, 1536895169),
(176, '/uploads/product/12/b.jpg', 1, 'product_info', NULL, 1536895169),
(177, '/uploads/product/12/c.jpg', 1, 'product_info', NULL, 1536895169),
(178, '/uploads/product/13/a.jpg', 1, 'product_info', NULL, 1536895169),
(179, '/uploads/product/13/b.jpg', 1, 'product_info', NULL, 1536895169),
(180, '/uploads/product/13/c.jpg', 1, 'product_info', NULL, 1536895169),
(181, '/uploads/product/14/a.jpg', 1, 'product_info', NULL, 1536895169),
(182, '/uploads/product/14/b.jpg', 1, 'product_info', NULL, 1536895169),
(183, '/uploads/product/14/c.jpg', 1, 'product_info', NULL, 1536895169),
(184, '/uploads/product/15/a.jpg', 1, 'product_info', NULL, 1536895169),
(185, '/uploads/product/15/b.jpg', 1, 'product_info', NULL, 1536895169),
(186, '/uploads/product/15/c.jpg', 1, 'product_info', NULL, 1536895169),
(187, '/uploads/product/16/a.jpg', 1, 'product_info', NULL, 1536895169),
(188, '/uploads/product/16/b.jpg', 1, 'product_info', NULL, 1536895169),
(189, '/uploads/product/16/c.jpg', 1, 'product_info', NULL, 1536895169),
(190, '/uploads/product/17/a.jpg', 1, 'product_info', NULL, 1536895169),
(191, '/uploads/product/17/b.jpg', 1, 'product_info', NULL, 1536895169),
(192, '/uploads/product/17/c.jpg', 1, 'product_info', NULL, 1536895169),
(193, '/uploads/product/18/a.jpg', 1, 'product_info', NULL, 1536895169),
(194, '/uploads/product/18/b.jpg', 1, 'product_info', NULL, 1536895169),
(195, '/uploads/product/18/c.jpg', 1, 'product_info', NULL, 1536895169),
(196, '/uploads/product/19/a.jpg', 1, 'product_info', NULL, 1536895169),
(197, '/uploads/product/19/b.jpg', 1, 'product_info', NULL, 1536895169),
(198, '/uploads/product/19/c.jpg', 1, 'product_info', NULL, 1536895169),
(199, '/uploads/product/20/a.jpg', 1, 'product_info', NULL, 1536895169),
(200, '/uploads/product/20/b.jpg', 1, 'product_info', NULL, 1536895169),
(201, '/uploads/product/20/c.jpg', 1, 'product_info', NULL, 1536895169),
(202, '/uploads/product/21/a.jpg', 1, 'product_info', NULL, 1536895169),
(203, '/uploads/product/21/b.jpg', 1, 'product_info', NULL, 1536895169),
(204, '/uploads/product/21/c.jpg', 1, 'product_info', NULL, 1536895169),
(205, '/uploads/product/22/a.jpg', 1, 'product_info', NULL, 1536895169),
(206, '/uploads/product/22/b.jpg', 1, 'product_info', NULL, 1536895169),
(207, '/uploads/product/22/c.jpg', 1, 'product_info', NULL, 1536895169),
(208, '/uploads/product/23/a.jpg', 1, 'product_info', NULL, 1536895169),
(209, '/uploads/product/23/b.jpg', 1, 'product_info', NULL, 1536895169),
(210, '/uploads/product/23/c.jpg', 1, 'product_info', NULL, 1536895169),
(211, '/uploads/product/24/a.jpg', 1, 'product_info', NULL, 1536895169),
(212, '/uploads/product/24/b.jpg', 1, 'product_info', NULL, 1536895169),
(213, '/uploads/product/24/c.jpg', 1, 'product_info', NULL, 1536895169),
(214, '/uploads/product/25/a.jpg', 1, 'product_info', NULL, 1536895169),
(215, '/uploads/product/25/b.jpg', 1, 'product_info', NULL, 1536895169),
(216, '/uploads/product/25/c.jpg', 1, 'product_info', NULL, 1536895169),
(217, '/uploads/product/26/a.jpg', 1, 'product_info', NULL, 1536895169),
(218, '/uploads/product/26/b.jpg', 1, 'product_info', NULL, 1536895169),
(219, '/uploads/product/26/c.jpg', 1, 'product_info', NULL, 1536895169),
(220, '/uploads/product/27/a.jpg', 1, 'product_info', NULL, 1536895169),
(221, '/uploads/product/27/b.jpg', 1, 'product_info', NULL, 1536895169),
(222, '/uploads/product/27/c.jpg', 1, 'product_info', NULL, 1536895169),
(223, '/uploads/product/28/a.jpg', 1, 'product_info', NULL, 1536895169),
(224, '/uploads/product/28/b.jpg', 1, 'product_info', NULL, 1536895169),
(225, '/uploads/product/28/c.jpg', 1, 'product_info', NULL, 1536895169),
(226, '/uploads/product/29/a.jpg', 1, 'product_info', NULL, 1536895169),
(227, '/uploads/product/29/b.jpg', 1, 'product_info', NULL, 1536895169),
(228, '/uploads/product/29/c.jpg', 1, 'product_info', NULL, 1536895169),
(229, '/uploads/product/30/a.jpg', 1, 'product_info', NULL, 1536895169),
(230, '/uploads/product/30/b.jpg', 1, 'product_info', NULL, 1536895169),
(231, '/uploads/product/30/c.jpg', 1, 'product_info', NULL, 1536895169),
(232, '/uploads/AD/20180920\\dda879c74904da68d06c071c18817bc1.jpg', 1, 'AD', NULL, 1537412659),
(233, '/uploads/AD/20180920\\0fc280d20e63fc19cfda83d9cbd1592a.jpg', 1, 'AD', NULL, 1537412674),
(234, '/uploads/AD/20180920\\4ea2e287de43359a651c9c1f45c71b6c.jpg', 1, 'AD', NULL, 1537413113),
(235, '/uploads/AD/20180920\\d40bef00722482a9ad938f235d6af080.jpg', 1, 'AD', NULL, 1537413240),
(236, '/uploads/AD/20180920\\3cbf293ba4498ae5bd0617a08e518527.jpg', 1, 'AD', NULL, 1537413245),
(237, '/uploads/AD/20180920\\6131c319d10c93cf8b1b18f3f5ba3336.jpg', 1, 'AD', NULL, 1537413593),
(238, '/uploads/category/20180920\\bf231fc924349578c02588eabe18edd7.jpg', 1, 'category', NULL, 1537413602),
(239, '/uploads/product/20180920\\d5ff22676f9e5cf6b4c6fa2e56e0ba50.jpg', 1, 'product', NULL, 1537416240),
(240, '/uploads/product/20180920\\028d3dfbd79eeb9394a3c7fc9691acb8.jpg', 1, 'product', NULL, 1537416242);

-- --------------------------------------------------------

--
-- 表的结构 `qy_item`
--

CREATE TABLE `qy_item` (
  `id` int(11) NOT NULL COMMENT '团单ID',
  `item_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0拼团1单独买',
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
  `delete_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拼团和独立购买';

-- --------------------------------------------------------

--
-- 表的结构 `qy_order`
--

CREATE TABLE `qy_order` (
  `order_id` int(11) NOT NULL,
  `order_num` varchar(40) NOT NULL COMMENT '订单编号',
  `item_id` int(11) NOT NULL COMMENT '团单ID',
  `user_id` int(11) NOT NULL,
  `create_item` tinyint(1) NOT NULL DEFAULT '0' COMMENT '创团订单',
  `goods_id` int(11) NOT NULL COMMENT '商品ID',
  `goods_name` varchar(200) NOT NULL COMMENT '商品名称',
  `goods_picture` int(11) NOT NULL COMMENT '商品图片id',
  `num` tinyint(4) NOT NULL COMMENT '购买数量',
  `sku_id` int(11) NOT NULL,
  `sku_name` varchar(200) NOT NULL,
  `pay_status` tinyint(1) DEFAULT '0' COMMENT '0未付1已付',
  `drive_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否发货',
  `evaluate_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否评价 0为未评价 1为已评价 2为已追评',
  `order_from` tinyint(4) NOT NULL COMMENT '来源小程序或wap',
  `payment_type` varchar(60) NOT NULL COMMENT '支付方式',
  `shipping_money` decimal(10,2) NOT NULL COMMENT '运费',
  `price` decimal(10,2) NOT NULL COMMENT '单价',
  `goods_money` decimal(10,2) NOT NULL COMMENT '商品总价',
  `order_money` decimal(10,2) NOT NULL COMMENT '订单总价',
  `user_ip` varchar(40) NOT NULL,
  `user_name` varchar(40) NOT NULL,
  `receiver_name` varchar(60) NOT NULL COMMENT '收货人',
  `receiver_mobile` varchar(60) NOT NULL COMMENT '收货人手机',
  `receiver_province` varchar(60) NOT NULL,
  `receiver_city` varchar(60) NOT NULL,
  `receiver_district` varchar(60) NOT NULL,
  `receiver_address` varchar(200) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `delete_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `qy_order_payment`
--

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
  `trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '交易号，支付宝退款用，微信传入空'
) ENGINE=InnoDB AVG_ROW_LENGTH=963 DEFAULT CHARSET=utf8 COMMENT='订单支付表';

-- --------------------------------------------------------

--
-- 表的结构 `qy_shop`
--

CREATE TABLE `qy_shop` (
  `shop_id` int(11) NOT NULL COMMENT '店铺id',
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
  `shop_collect` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT '店铺收藏数量',
  `shop_sales` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '店铺销售额（不计算退款）',
  `store_qtian` tinyint(1) DEFAULT '0' COMMENT '7天退换',
  `shop_zhping` tinyint(1) DEFAULT '0' COMMENT '正品保障',
  `shop_tuihuo` tinyint(1) DEFAULT '0' COMMENT '退货承诺',
  `create_time` int(11) DEFAULT '0' COMMENT '店铺时间',
  `end_time` int(11) DEFAULT '0' COMMENT '店铺关闭时间'
) ENGINE=InnoDB AVG_ROW_LENGTH=16384 DEFAULT CHARSET=utf8 COMMENT='店铺数据表';

--
-- 转存表中的数据 `qy_shop`
--

INSERT INTO `qy_shop` (`shop_id`, `shop_name`, `shop_description`, `shop_type`, `uid`, `shop_group_id`, `shop_address`, `shop_state`, `shop_close_info`, `shop_sort`, `img_id`, `shop_phone`, `shop_recommend`, `shop_collect`, `shop_sales`, `store_qtian`, `shop_zhping`, `shop_tuihuo`, `create_time`, `end_time`) VALUES
(1, '美食天地', '一家好吃的店', 0, 0, 0, '兴义大道xxxx', 1, NULL, 0, 12, '13800001111', 0, 20, '590.00', 1, 0, 1, 0, 0),
(2, 'A数码城', '某某数码店', 0, 0, 0, '桔山大道xxxx', 1, NULL, 0, 13, '0859-3333333', 0, 12, '302.00', 1, 1, 0, 0, 0);

-- --------------------------------------------------------

--
-- 表的结构 `qy_user`
--

CREATE TABLE `qy_user` (
  `id` int(11) NOT NULL,
  `openid` varchar(50) CHARACTER SET utf8 NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `nickname` varchar(60) NOT NULL,
  `start` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL COMMENT '注册时间',
  `update_time` int(11) DEFAULT NULL,
  `mobile` varchar(20) NOT NULL,
  `is_visible` int(1) NOT NULL DEFAULT '1' COMMENT '1显示0隐藏'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `qy_user`
--

INSERT INTO `qy_user` (`id`, `openid`, `username`, `nickname`, `start`, `create_time`, `update_time`, `mobile`, `is_visible`) VALUES
(14, 'oq_jb4rVwe_DobhVJrO-G-hCmyZI', NULL, '', NULL, 1536300490, 1536300490, '13312341234', 1),
(15, 'oq_jb4veqIJBFcr7Gy6rROTVEQ-A', NULL, '', NULL, 1536550598, 1536550598, '18611112222', 1);

-- --------------------------------------------------------

--
-- 表的结构 `qy_user_address`
--

CREATE TABLE `qy_user_address` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL COMMENT '收获人姓名',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `province` varchar(20) DEFAULT NULL COMMENT '省',
  `city` varchar(20) DEFAULT NULL COMMENT '市',
  `country` varchar(20) DEFAULT NULL COMMENT '区',
  `detail` varchar(100) DEFAULT NULL COMMENT '详细地址',
  `user_id` int(11) NOT NULL,
  `select` tinyint(1) NOT NULL,
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 转存表中的数据 `qy_user_address`
--

INSERT INTO `qy_user_address` (`id`, `name`, `mobile`, `province`, `city`, `country`, `detail`, `user_id`, `select`, `create_time`, `update_time`) VALUES
(35, '老王', '13312345678', '北京市', '市辖区', '西城区', '1', 14, 1, 1536300552, 1536300552),
(36, '三大', '13290299485', '浙江省', '杭州市', '市辖区', '隧道口连接', 15, 1, 1536550873, 1536550873);

-- --------------------------------------------------------

--
-- 表的结构 `sys_config`
--

CREATE TABLE `sys_config` (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `key` varchar(255) NOT NULL DEFAULT '' COMMENT '配置项',
  `value` varchar(1000) NOT NULL DEFAULT '' COMMENT '配置值json',
  `desc` varchar(1000) NOT NULL DEFAULT '' COMMENT '描述',
  `type` int(11) NOT NULL COMMENT '1基础2交易',
  `is_use` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否启用 1启用 0不启用',
  `update_time` int(11) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=963 DEFAULT CHARSET=utf8 COMMENT='第三方配置表';

--
-- 转存表中的数据 `sys_config`
--

INSERT INTO `sys_config` (`id`, `key`, `value`, `desc`, `type`, `is_use`, `update_time`) VALUES
(1, 'web_name', '', '商城名称', 1, 1, 1537259814),
(2, 'api_url', 'http://192.168.1.109', 'API网址', 1, 1, 1537259814),
(3, 'wx_token_expire', '7200', 'token有效期', 1, 1, 1537259814),
(4, 'gzh_appid', '2123', '公众号APPID', 2, 1, 1537257089),
(5, 'gzh_secret', '1', '公众号Secret', 2, 1, 1537257089),
(6, 'wx_app_id', '', '小程序appid', 2, 1, 1537257089),
(7, 'wx_app_secret', '', '小程序Secret', 2, 1, 1537257089),
(8, 'pay_num', '', '商户号', 2, 1, 1537257089),
(9, 'pay_key', '', '商户key', 2, 1, 1537257089),
(10, 'tel', '1', '联系电话', 1, 1, 1537259814),
(11, 'company', '2', '公司名称', 1, 1, 1537259814),
(12, 'item_expire', '123', '团单过期时间', 1, 1, 1537259814),
(13, 'accept_time', '1', '自动收货时间', 1, 1, 1537259814);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `qy_admins`
--
ALTER TABLE `qy_admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qy_article`
--
ALTER TABLE `qy_article`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qy_banner`
--
ALTER TABLE `qy_banner`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qy_banner_item`
--
ALTER TABLE `qy_banner_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qy_category`
--
ALTER TABLE `qy_category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `qy_favorites`
--
ALTER TABLE `qy_favorites`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qy_goods`
--
ALTER TABLE `qy_goods`
  ADD PRIMARY KEY (`goods_id`),
  ADD KEY `UK_ns_goods_brand_id` (`brand_id`),
  ADD KEY `UK_ns_goods_category_id` (`category_id`),
  ADD KEY `UK_ns_goods_goods_attribute_id` (`goods_attribute_id`);

--
-- Indexes for table `qy_goods_sku`
--
ALTER TABLE `qy_goods_sku`
  ADD PRIMARY KEY (`sku_id`);

--
-- Indexes for table `qy_image`
--
ALTER TABLE `qy_image`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qy_item`
--
ALTER TABLE `qy_item`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qy_order`
--
ALTER TABLE `qy_order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `qy_order_payment`
--
ALTER TABLE `qy_order_payment`
  ADD KEY `IDX_ns_order_payment_out_trade_no` (`out_trade_no`),
  ADD KEY `IDX_ns_order_payment_pay_status` (`pay_status`),
  ADD KEY `IDX_ns_order_payment_pay_type` (`pay_type`),
  ADD KEY `IDX_ns_order_payment_shop_id` (`shop_id`);

--
-- Indexes for table `qy_shop`
--
ALTER TABLE `qy_shop`
  ADD PRIMARY KEY (`shop_id`);

--
-- Indexes for table `qy_user`
--
ALTER TABLE `qy_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `qy_user_address`
--
ALTER TABLE `qy_user_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sys_config`
--
ALTER TABLE `sys_config`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `qy_admins`
--
ALTER TABLE `qy_admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `qy_article`
--
ALTER TABLE `qy_article`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章编号', AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `qy_banner`
--
ALTER TABLE `qy_banner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `qy_banner_item`
--
ALTER TABLE `qy_banner_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- 使用表AUTO_INCREMENT `qy_category`
--
ALTER TABLE `qy_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- 使用表AUTO_INCREMENT `qy_favorites`
--
ALTER TABLE `qy_favorites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '记录ID', AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `qy_goods`
--
ALTER TABLE `qy_goods`
  MODIFY `goods_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品id(SKU)', AUTO_INCREMENT=31;
--
-- 使用表AUTO_INCREMENT `qy_goods_sku`
--
ALTER TABLE `qy_goods_sku`
  MODIFY `sku_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表序号', AUTO_INCREMENT=29;
--
-- 使用表AUTO_INCREMENT `qy_image`
--
ALTER TABLE `qy_image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=241;
--
-- 使用表AUTO_INCREMENT `qy_item`
--
ALTER TABLE `qy_item`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '团单ID';
--
-- 使用表AUTO_INCREMENT `qy_order`
--
ALTER TABLE `qy_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `qy_shop`
--
ALTER TABLE `qy_shop`
  MODIFY `shop_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '店铺id', AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `qy_user`
--
ALTER TABLE `qy_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- 使用表AUTO_INCREMENT `qy_user_address`
--
ALTER TABLE `qy_user_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- 使用表AUTO_INCREMENT `sys_config`
--
ALTER TABLE `sys_config`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=14;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
