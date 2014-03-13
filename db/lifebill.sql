/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50067
Source Host           : localhost:3306
Source Database       : lifebill

Target Server Type    : MYSQL
Target Server Version : 50067
File Encoding         : 65001

Date: 2014-03-13 10:04:02
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `billbudget`
-- ----------------------------
DROP TABLE IF EXISTS `billbudget`;
CREATE TABLE `billbudget` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `years` int(11) NOT NULL COMMENT '年',
  `months` int(11) NOT NULL COMMENT '月',
  `revenue` double NOT NULL COMMENT '收入',
  `outlay` double NOT NULL COMMENT '支出',
  `isava` varchar(1) NOT NULL default 'Y' COMMENT '是否平均',
  `addtime` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP COMMENT '添加的时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of billbudget
-- ----------------------------
INSERT INTO billbudget VALUES ('1', '2014', '3', '0', '1500', '1', '2014-03-06 22:42:29');
INSERT INTO billbudget VALUES ('2', '2013', '11', '0', '1500', '1', '2014-03-06 22:42:40');
INSERT INTO billbudget VALUES ('3', '2013', '12', '0', '1500', '1', '2014-03-06 22:42:53');

-- ----------------------------
-- Table structure for `billdetail`
-- ----------------------------
DROP TABLE IF EXISTS `billdetail`;
CREATE TABLE `billdetail` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `masterid` int(11) NOT NULL COMMENT '外键，主档ID',
  `tagid` int(11) NOT NULL COMMENT '外键，tagid',
  `price` double(8,2) NOT NULL COMMENT '价格',
  `notes` text COMMENT '说明',
  `addtime` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uq_id` (`id`),
  KEY `fk_masterid` (`masterid`),
  KEY `fk_tagid` (`tagid`),
  CONSTRAINT `fk_masterid` FOREIGN KEY (`masterid`) REFERENCES `billmaster` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tagid` FOREIGN KEY (`tagid`) REFERENCES `billtags` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=825 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of billdetail
-- ----------------------------
INSERT INTO billdetail VALUES ('17', '36', '12', '5.50', '鸡蛋：2;\r\n小笼包：3.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('18', '36', '11', '2.00', '冰糖葫芦：2', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('19', '36', '15', '7.00', '猪肉：7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('20', '36', '14', '27.50', '干辣椒：1;\r\n鸡蛋：4.5;\r\n小鱼干:7;\r\n藕：2.5;\r\n包菜：2.5;\r\n姜：3.5;\r\n西红柿:3.5;\r\n辣椒：2.5;\r\n蒜苗:0.5;\r\n', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('21', '36', '13', '15.50', '梨：2.5;\r\n葡萄:8;\r\n枣:5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('28', '38', '12', '16.00', '早餐：16', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('29', '38', '7', '15.00', '袜子：15', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('30', '38', '9', '598.00', '拍婚纱照化妆套餐：598', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('31', '38', '22', '12.00', '拍婚纱照买水12', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('32', '38', '18', '55.00', '晚餐在外面吃\r\n汤菜：35;\r\n烧烤：6;\r\n炸菜：7;\r\n啤酒+椰汁：7', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('33', '37', '18', '32.50', '中餐:32.5\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('34', '37', '7', '600.00', '猪头外套：165;\r\n猪头毛衣：69;\r\n猪头衬衫：158;\r\n蜗牛外套：129;\r\n蜗牛毛衣：79;\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('35', '37', '6', '60.00', '猪头运动鞋：60;\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('36', '37', '24', '169.00', '被套：169;\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('37', '37', '14', '7.50', '豆腐：0.5;\r\n金针菇：2：\r\n扁豆：3;\r\n莲藕：2;\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('38', '37', '42', '50.00', '看电影：50\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('39', '37', '22', '12.00', '桶装水：12', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('40', '39', '12', '4.00', '早餐：4', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('41', '39', '19', '208.00', '看婚纱照请花菜，唐瑞娇吃晚饭', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('42', '39', '41', '3068.00', '婚纱照缴费：3000;\r\n买蛋糕：58(蜗牛生日);\r\nXX：10', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('43', '40', '12', '5.50', '早餐：5.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('44', '40', '14', '11.00', '晚上买菜：11', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('45', '40', '11', '2.00', '糖葫芦', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('46', '41', '12', '6.50', '早餐：6.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('52', '42', '12', '6.50', '                            早餐：6.5\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('53', '42', '17', '11.00', '                            面条：3.5;\r\n花生酱：7.5\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('54', '42', '14', '8.80', '                            晚上买菜：8.8\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('55', '42', '11', '2.00', '                            冰糖葫芦：2\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('56', '42', '7', '49.00', '                            隐形内衣：49\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('57', '43', '14', '31.00', '晚上买菜：31', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('58', '43', '13', '4.00', '水果：4', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('59', '44', '11', '2.00', '烤面筋：2', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('60', '45', '15', '31.00', '鸡肉：31', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('61', '45', '13', '31.00', '水果：31', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('62', '45', '14', '44.50', '晚上买菜：44.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('63', '45', '11', '2.00', '烤面筋：2', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('64', '46', '12', '3.00', '鸡蛋：2;\r\n包子：1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('65', '46', '14', '4.50', '菜+馒头：4.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('66', '47', '12', '3.00', '早餐：3', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('67', '47', '32', '1.00', '晚上蜗牛坐车：1', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('68', '48', '12', '2.00', '早餐：2', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('69', '48', '14', '38.00', '买菜：38', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('70', '48', '22', '12.00', '桶装水：12', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('71', '48', '18', '10.00', '蜗牛中午快餐：10', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('76', '49', '12', '3.00', '早餐：3\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('77', '49', '18', '84.00', '晚餐烤鱼：80;\r\n椰汁：4;\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('78', '49', '11', '14.00', '瓜子：8.5;\r\n面包：5.5;\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('79', '49', '28', '6425.76', '猪头工资：3775.76;\r\n蜗牛工资：2650;\r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('80', '50', '12', '4.00', '早餐：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('81', '50', '17', '8.50', '辣椒酱：8.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('82', '50', '13', '26.00', '水果：26', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('95', '51', '17', '131.90', '                                                        盐:1.5;\r\n油:119.9;\r\n辣椒酱:10.5;\r\n                        \r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('96', '51', '25', '109.70', '                                                        浴巾:29.9;\r\n肥皂:5.9;\r\n洗衣粉：18.9;\r\n护发素：6.2;\r\n牙刷：5.4;\r\n剃须刀：13.5;\r\n洗发水：29.9;\r\n                        \r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('97', '51', '24', '40.90', '                                                        纸巾：40.9\r\n                        \r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('98', '51', '11', '21.00', '                                                        牛奶：18.8;\r\n棒棒糖：2.2;\r\n                        \r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('99', '51', '16', '9.90', '                                                        9.9\r\n                        \r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('100', '51', '24', '18.50', '                                                        XX:18.5\r\n                        \r\n                        ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('101', '51', '14', '32.00', '晚上买菜：32', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('102', '51', '13', '15.50', '水果：15.5           ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('103', '51', '41', '5.00', '老鼠药：5 ', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('104', '52', '41', '1000.00', '婚纱照定金：1000', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('105', '52', '18', '65.00', '中餐：30;\r\n晚餐：35;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('106', '52', '43', '2.00', '螺丝刀：2', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('107', '52', '25', '2.50', '发夹：2.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('108', '52', '13', '2.00', '西瓜', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('109', '53', '12', '8.50', '早餐：8.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('110', '53', '18', '42.00', '晚餐出去吃：42', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('111', '54', '12', '5.50', '早餐：5.5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('112', '54', '14', '18.00', '晚上买菜：18', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('113', '55', '12', '4.00', '早餐：4', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('114', '55', '24', '8.00', 'XX:8', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('115', '55', '26', '280.00', '猪头用药：280;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('116', '55', '7', '38.00', '衣服：38', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('117', '56', '12', '5.00', '早餐：5', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('118', '56', '43', '4.00', '电池：4', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('119', '56', '11', '2.00', '冰糖葫芦：2', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('120', '57', '12', '2.00', '早餐：2', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('121', '57', '14', '23.00', '菜：23', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('122', '57', '13', '8.00', '水果：8', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('123', '57', '11', '2.00', '烤面筋：2', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('124', '57', '20', '450.00', '房租：450', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('125', '57', '19', '355.00', '请蜗牛同学吃饭', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('131', '59', '11', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('132', '59', '18', '10.00', '午餐叫快餐：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('133', '59', '14', '5.00', '鸡蛋：2;\r\n藕：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('134', '59', '13', '5.00', '冬枣：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('135', '58', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('136', '58', '18', '17.00', '晚餐：\r\n牛肉炒刀削面：10;\r\n刀削面：7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('137', '58', '41', '3000.00', '婚纱照：3000;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('138', '58', '11', '14.00', '鸡腿：8.5;\r\n火腿肠：5.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('143', '60', '12', '5.50', '早餐：5.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('144', '60', '11', '2.00', '零食：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('145', '60', '15', '8.00', '鱼：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('146', '60', '14', '14.00', '买菜：14;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('147', '60', '30', '0.50', '进账：0.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('148', '61', '12', '7.50', '早餐：7.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('149', '61', '16', '8.50', '酒：8.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('284', '62', '12', '3.50', '早餐：3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('285', '62', '37', '50.00', '蜗牛话费：50;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('286', '62', '18', '6.00', '午餐酸辣粉：6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('287', '62', '15', '10.00', '肉：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('288', '62', '17', '92.40', '糯米：4;\r\n酱油：7.9;\r\n口味汤：8.9;\r\n陈醋：4.5;\r\n鸡精：8.2;\r\n金龙鱼优质丝苗米：58.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('289', '62', '14', '19.50', '鸡蛋：3.5;\r\n西红柿：2.5;\r\n胡萝卜：2;\r\n土豆：2;\r\n青菜：1;\r\n葱：0.5;\r\n花生：6;\r\n紫薯：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('290', '62', '13', '23.50', '橙子：4.5;\r\n提子：6;\r\n苹果：13;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('291', '62', '9', '47.00', '安安150ml橄榄油水活柔肤水：47;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('292', '62', '11', '18.40', '鸡肉火腿肠：3.5;\r\n伊利红枣8连杯酸奶：11.9;\r\n纯奶：3；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('293', '62', '44', '11.00', '保鲜袋：7.9;\r\n垃圾袋：2.9;\r\n购物袋：0.2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('294', '62', '7', '28.80', '猪头喜玛狐内裤：28.8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('295', '62', '20', '400.00', '房租：400;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('296', '62', '22', '14.00', '水费：4T：14;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('297', '62', '21', '74.00', '电费：74;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('298', '62', '41', '15.00', '污水处理费：10；\r\n玩游戏：5；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('303', '64', '12', '4.00', '早餐：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('304', '64', '15', '28.00', '排骨：19;\r\n肉：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('305', '64', '14', '20.00', '馒头：1.5;\r\n生姜：3.5;\r\n大蒜：3.5;\r\n胡萝卜：2;\r\n冬瓜：1;\r\n藕：1;\r\n葱+香菜：1;\r\n苦瓜：3;\r\n鸡蛋：3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('306', '63', '11', '14.80', '酸梅汤：6;\r\n糖葫芦：2;\r\n瓜子：6.8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('307', '63', '32', '9.00', '去芙蓉寺车费：8;停自行车：1；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('308', '63', '15', '14.40', '北京烤鸭：14.4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('309', '63', '14', '4.50', '真姬菇：4.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('312', '66', '18', '19.00', '叉烧粉：7;\r\n猪头肉饭：12;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('313', '66', '13', '20.00', '葡萄：14;\r\n橘子：2.5;\r\n橙子：3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('314', '66', '15', '9.00', '猪肉：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('315', '66', '16', '5.00', '高粱酒：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('316', '66', '14', '14.20', '蘑菇：3.5;\r\n莴笋：2.5;\r\n莲藕：3.5;\r\n包菜：2.7;\r\n炸菜：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('317', '65', '12', '1.00', '包子：1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('318', '65', '11', '7.00', '鸭脖：5;\r\n炸菜：1;\r\n金针菇：1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('319', '67', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('320', '67', '11', '9.00', '红糖：3.5;\r\n零食：5.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('321', '67', '18', '26.00', '晚餐：19;\r\n饼：7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('322', '68', '26', '53.00', '看病：49;\r\n包子：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('328', '69', '12', '5.00', '炒米粉：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('329', '69', '15', '15.20', '猪肉：15.2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('330', '69', '11', '8.60', '素牛肉干：4.6;\r\n面包：4；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('331', '69', '14', '13.40', '四季豆：2.5;\r\n青尖椒：2.7;\r\n鸡蛋：2.2;\r\n洋葱：1.2;\r\n香干：3.6;\r\n干辣椒：1.2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('332', '69', '41', '0.20', '购物袋：0.2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('333', '70', '12', '4.00', '早餐：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('334', '70', '41', '69.00', '钱包：69;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('335', '70', '7', '406.00', '内衣：406;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('338', '71', '12', '2.00', '早餐：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('339', '71', '41', '9.90', '手机壳：9.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('340', '71', '18', '20.00', '拉面：20；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('341', '72', '11', '0.00', '没有消费：0.0;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('342', '73', '12', '2.00', '早餐：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('343', '73', '15', '5.50', '莲藕土豆：5.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('344', '74', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('345', '74', '14', '16.50', '16.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('346', '74', '37', '30.00', '猪头话费：30;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('347', '75', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('348', '75', '14', '5.00', '菜：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('349', '75', '15', '27.00', '猪肉：6;\r\n凉菜：21;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('350', '76', '12', '16.00', '早餐：16;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('351', '76', '32', '129.00', '出租车：30;\r\n高铁：89;\r\n地铁：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('355', '77', '32', '131.00', '地铁：12;\r\n高铁：89;\r\n出租车：30;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('356', '77', '30', '200.00', '打牌赢钱：200;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('357', '77', '18', '16.00', '吃饭：16;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('358', '77', '32', '43.80', '菜钱：43.8；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('359', '77', '13', '9.00', '葡萄：9；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('360', '78', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('361', '78', '11', '61.50', '零食：55;\r\n臭豆腐：3;\r\n饮料：3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('362', '78', '41', '6150.00', '求婚戒指：6150;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('363', '78', '18', '24.00', '烫菜：24;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('364', '78', '14', '14.40', '香菇：6;\r\n花生米：8.4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('365', '79', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('366', '79', '18', '8.00', '蜗牛中午快餐：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('367', '79', '6', '19.00', '鞋子：19;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('368', '80', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('369', '80', '15', '8.40', '猪肉：8.4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('370', '80', '14', '7.10', '油麦菜：1.2;\r\n辣椒：2;\r\n香干：3.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('371', '80', '11', '11.90', '红枣牛奶：11.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('372', '80', '41', '0.20', '购物袋：0.2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('373', '81', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('374', '81', '15', '11.00', '猪排骨：11;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('375', '81', '14', '5.00', '青菜：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('376', '82', '12', '3.50', '早餐：3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('377', '82', '18', '74.00', '鸡煲：74;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('378', '83', '12', '5.50', '鸭蛋：3;\r\n馒头：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('379', '83', '15', '22.00', '肉：8;\r\n鸡脚：14;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('380', '83', '14', '16.00', '青菜：13;\r\n鸡蛋：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('381', '83', '11', '6.00', '瓜子：6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('382', '83', '37', '80.00', '猪头：50;\r\n犀牛：30;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('383', '84', '12', '10.50', '早餐：5;\r\n泡面：3.5;\r\n茶鸡蛋：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('384', '84', '11', '40.00', '红枣酸奶：11.9;\r\n果冻：12.9;\r\n素牛肉干：9.2;\r\n椰子汁：6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('385', '84', '15', '5.90', '猪肉：5.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('386', '84', '14', '10.80', '番茄：1.6;\r\n包菜：1.8;\r\n青瓜：1.7;\r\n火腿肠：2.1;\r\n大蒜：1.1;\r\n鸡蛋：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('387', '84', '41', '0.20', '购物袋：0.2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('388', '84', '18', '60.00', '牛肉丸：10;\r\n乳鸽：15;\r\n印度博饼：15;\r\n螃蟹：10;\r\n羊肉串：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('389', '84', '13', '5.00', '橙子：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('390', '85', '42', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('391', '85', '18', '8.00', '蜗牛快餐：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('392', '85', '14', '2.00', '土豆：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('393', '85', '11', '3.00', '糖葫芦：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('394', '86', '12', '4.00', '早餐：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('395', '86', '15', '16.00', '肉：16;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('396', '86', '14', '14.50', '辣椒：5.5;\r\n芹菜：3;\r\n葱：1;\r\n面皮：4;\r\n土豆：1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('397', '86', '33', '2750.00', '蜗牛学费：2750；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('398', '86', '11', '4.90', '零食：4.9；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('399', '86', '17', '9.00', '浓汤宝：9；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('400', '87', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('401', '87', '18', '9.00', '蜗牛快餐：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('402', '87', '14', '4.50', '菜钱：4.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('403', '88', '11', '6.00', '早餐：6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('404', '88', '15', '6.00', '猪肉：6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('405', '88', '14', '9.00', '青菜：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('406', '88', '33', '87.70', '犀牛书：87.7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('407', '89', '21', '7.00', '早餐：7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('408', '89', '32', '57.00', '车费：6;\r\n15;\r\n28;\r\n8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('409', '89', '18', '22.50', '吃饭：22.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('410', '89', '24', '10.00', 'XXXX：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('411', '90', '12', '10.50', '早餐：10.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('412', '90', '18', '100.00', '晚餐香辣虾：100;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('413', '90', '11', '0.00', '', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('414', '90', '13', '142.00', '榴莲：125.9;\r\n橙子：2.5;\r\n苹果：13.6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('415', '90', '11', '16.00', '酸奶：11.9;\r\n西瓜子：4.1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('416', '90', '25', '9.00', '漂白液：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('417', '91', '15', '23.00', '猪肉：11;\r\n鱼：12;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('418', '91', '14', '24.60', '豆腐干：2.5;\r\n西红柿：3.6;\r\n萝卜：1;\r\n红辣椒：3.5;\r\n芹菜：1.5;\r\n葱：1.5;\r\n苦瓜：2;\r\n鸡蛋：2.5;\r\n萝卜干：2.5;\r\n青菜：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('426', '94', '12', '1.50', '早餐：1.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('427', '94', '14', '23.00', '菜：23；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('428', '94', '15', '21.50', '猪肉：11；\r\n鸡肉：10.5；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('429', '94', '13', '4.00', '橙子：4；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('430', '94', '41', '71.50', '去超市购物：\r\n抽纸，牙膏，洗洁精，洗衣液，盐，零食，酸奶：71.5；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('431', '92', '12', '1.50', '早餐：1.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('432', '92', '14', '9.00', '菜：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('433', '92', '15', '5.00', '猪肉：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('434', '93', '12', '2.00', '早餐：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('435', '93', '14', '16.00', '菜：6;\r\n凉菜：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('436', '93', '41', '33.40', '拔罐器：22.40\r\n                        污水处理费：11；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('437', '93', '37', '30.50', '蜗牛话费：30.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('438', '93', '20', '400.00', '房租：400', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('439', '93', '22', '14.00', '水费：14；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('440', '93', '21', '68.00', '电费：68；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('441', '95', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('442', '95', '18', '8.50', '猪扎：8.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('443', '96', '11', '2.50', '早餐：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('444', '96', '18', '22.00', '猪脚饭：22;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('445', '97', '12', '13.50', '早餐：13.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('446', '97', '24', '8.00', '刷子+粉扑：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('447', '97', '15', '39.80', '牛肉：29;\r\n鸡肉：10.8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('448', '97', '14', '2.50', '辣椒：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('449', '98', '12', '17.50', '早餐：17.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('450', '98', '32', '71.00', '去厚街车费：28+15+28;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('451', '98', '18', '22.00', '猪脚饭：22;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('452', '98', '22', '12.00', '桶装水：12；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('456', '100', '12', '2.00', '早餐：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('457', '100', '11', '49.00', '零食：49;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('458', '99', '12', '2.00', '早餐：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('459', '99', '18', '30.00', '吃饭：30;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('460', '99', '41', '3755.00', '黄金：3755;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('461', '101', '12', '1.00', '早餐：1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('462', '101', '15', '36.00', '猪肉：5;\r\n鸡肉：31;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('463', '101', '14', '9.90', '辣椒：3;\r\n青菜：2.5;\r\n黄瓜+大蒜：1.5;\r\n鸡蛋：2.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('464', '101', '44', '80.00', '煤气灶：80;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('468', '103', '12', '10.00', '早餐：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('469', '103', '18', '35.50', '烧烤：11.5;\r\n汤菜：24;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('470', '104', '7', '2616.00', '西装：1578;\r\n衬衣：360;\r\n皮带：238;\r\n皮鞋：569; 打了8.8折', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('471', '104', '7', '239.00', '蜗牛包：239;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('472', '104', '9', '218.00', '眼霜：218;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('473', '104', '41', '8200.00', '男戒：2295;\r\n女戒：2415;\r\n项链+吊坠：3490;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('474', '104', '11', '6.00', '双皮奶：6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('475', '104', '18', '52.00', '吃饭：52;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('476', '102', '12', '1.00', '早餐：1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('477', '102', '18', '30.00', '吃饭：30;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('478', '102', '42', '24.00', '电影风暴：24;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('479', '105', '18', '27.00', '麦当劳：27;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('480', '105', '7', '1116.00', '蜗牛衣服：1116;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('481', '105', '14', '15.00', '菜钱：15', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('482', '105', '15', '13.00', '福寿鱼：5;\r\n鸡杂：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('483', '106', '32', '10.00', '早上坐出租车：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('484', '106', '12', '1.50', '1.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('485', '106', '11', '15.00', '花生：5;\r\n酒：8.5;\r\n鸭脚：1.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('486', '107', '15', '5.00', '猪肉：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('487', '107', '14', '10.50', '青菜：10.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('488', '107', '12', '2.00', '2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('495', '109', '12', '2.00', '早餐：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('496', '109', '14', '9.00', '菜钱：2;\r\n凉菜：7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('497', '109', '11', '5.00', '零食：5；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('498', '108', '11', '42.40', '瓜子：6.1;\r\n糖：8.1;\r\n酸奶：22.2;\r\n零食：6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('499', '108', '15', '32.40', '鱼：23.6;\r\n猪肉：8.8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('500', '108', '14', '22.40', '菇：4.5;\r\n豆腐：2.8;\r\n蒜头：0.5;\r\n桂皮：1.4;\r\n干辣椒：2;\r\n大葱：3;\r\n青菜：2.2;\r\n小辣椒：6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('501', '108', '13', '19.50', '橙子：4.4;\r\n苹果：9.2\r\n菠萝：5.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('502', '108', '12', '3.00', '早餐：3；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('515', '111', '11', '13.50', '泡面：5.5;\r\n牛筋：2;\r\n花生：4;\r\n水：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('516', '111', '41', '1159.00', '快递费：13;\r\n耳钉：1144;\r\n                     \r\n启动器电灯：2；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('517', '111', '37', '50.00', '话费：50;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('518', '111', '32', '36.00', '车费：36;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('519', '111', '15', '26.00', '排骨：21;\r\n猪肉：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('520', '111', '14', '11.80', '萝卜：0.8;\r\n莲藕：1;\r\n玉米：2;\r\n生姜：5;\r\n马蹄：2.5;\r\n香菜：0.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('521', '111', '26', '15.00', '凉茶：15;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('522', '111', '7', '155.00', '护膝：35;\r\n裙子：25;\r\n衣服：60;\r\n毛线裤：35;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('523', '111', '18', '12.00', '吃饭：12;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('524', '111', '9', '28.00', '眼线笔：28;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('525', '110', '12', '1.50', '早餐：1.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('526', '110', '18', '15.00', '晚餐：15;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('527', '110', '26', '35.00', '感冒药：35；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('528', '112', '15', '10.00', '猪肉：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('529', '112', '14', '17.50', '莴笋：2;\r\n红辣椒：6;\r\n鸡蛋：2.5;\r\n饺子皮：4;\r\n芹菜：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('530', '112', '18', '12.00', '午餐：12;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('531', '112', '12', '7.50', '早餐：7.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('532', '112', '7', '534.00', '犀牛保暖衣：139;\r\n蜗牛衣服：395;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('533', '112', '6', '20.00', '两双拖鞋：20;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('534', '112', '11', '10.00', '零食：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('535', '112', '26', '24.00', '三杯凉茶：24;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('536', '113', '12', '3.50', '3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('537', '113', '24', '80.00', '气球：80;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('538', '113', '14', '2.00', '酸菜：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('544', '115', '12', '2.50', '早餐：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('551', '116', '12', '2.50', '早餐：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('552', '116', '14', '19.56', '西红柿：5;\r\n蒜薹：5;\r\n包菜：6.9;\r\n萝卜干：2.66;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('553', '116', '15', '4.40', '猪肉：4.4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('554', '116', '11', '9.82', '鸡爪：9.82;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('555', '116', '24', '5.90', '纸巾：5.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('556', '116', '13', '3.10', '柠檬：3.1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('557', '116', '7', '600.00', '给犀牛弟弟衣服：上衣：419;牛仔裤：181;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('558', '114', '11', '31.90', '饼干：7.8;\r\n凤爪：3.6;\r\n凉茶：3.8;\r\n火腿肠：7.9;\r\n花生米：5.8;\r\n热干面：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('559', '114', '15', '24.20', '猪肉：5.6;\r\n猪脚：18.6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('560', '114', '13', '7.90', '苹果：7.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('561', '114', '14', '11.20', '上海青：1.5;\r\n菇：4.7;\r\n莲藕：3.7;\r\n红萝卜：1.3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('562', '114', '44', '349.00', '电压力锅：349;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('563', '114', '12', '3.50', '早餐：3.5；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('564', '114', '9', '23.75', '润唇霜：23.75；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('567', '118', '41', '150.00', '蜗牛染头发：150;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('568', '118', '18', '42.00', '桂林米粉：14;\r\n汤菜：28;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('569', '118', '26', '8.00', '凉茶：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('570', '118', '41', '22.00', '烟：22;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('571', '118', '37', '20.00', '话费：20;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('572', '117', '12', '2.00', '2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('573', '117', '18', '9.00', '吃饭：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('574', '117', '11', '2.00', '炸菜：2；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('575', '119', '18', '32.00', '吃饭：32;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('576', '119', '7', '539.60', '犀牛衣服：500;\r\n犀牛内裤：24.6;\r\n蜗牛内裤：15;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('577', '119', '9', '191.00', '卸妆油：191;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('578', '119', '15', '4.80', '猪肉：4.8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('579', '119', '14', '10.10', '大白菜：3.9;\r\n芹菜：2.2;\r\n面条：2.7;\r\n鸡蛋：1.3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('580', '119', '17', '23.20', '米：22.2;\r\n酱油：1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('581', '119', '11', '16.20', '零食：3.7;\r\n酸奶：12.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('582', '119', '41', '0.20', '购物袋：0.2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('590', '120', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('591', '120', '14', '2.50', '萝卜：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('592', '120', '15', '29.00', '排骨：20;\r\n凉菜：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('593', '120', '9', '40.00', '口红：40；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('594', '121', '12', '3.00', '早餐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('595', '121', '15', '4.00', '肉：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('596', '121', '14', '2.50', '茄子：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('597', '121', '26', '8.00', '凉茶：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('598', '121', '11', '32.00', '花生：4;\r\n凉菜：15;\r\n橘子：6;\r\n加多宝：3.5;\r\n橙汁：3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('599', '122', '12', '15.00', '早餐：8;\r\n常德米粉：7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('600', '122', '7', '979.60', '蜗牛两条裤子：359;\r\n高跟鞋：295.6;\r\n安踏鞋子：239;\r\n围巾2条：75;\r\n袖套：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('601', '122', '9', '358.90', '面霜：79;\r\n化妆棉：19.9;\r\n爽肤水：260;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('602', '122', '11', '7.00', '奶茶：7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('603', '122', '37', '99.00', '话费：99;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('604', '122', '25', '15.00', '沐浴露：15;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('605', '122', '32', '50.00', '14+6+10+5+15', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('606', '122', '18', '8.50', '麦当劳：8.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('607', '122', '41', '5.00', '气球：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('611', '123', '12', '2.50', '早餐：2.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('612', '123', '14', '3.00', '茄子：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('613', '123', '32', '15.00', '打的：15;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('614', '123', '12', '5.00', '烤面筋：2；\r\n热干面：3；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('618', '124', '12', '4.00', '早餐：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('619', '124', '14', '3.00', '茄子：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('620', '124', '11', '56.00', '热干面：3;\r\n烤面筋：2;\r\n零食：51；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('625', '126', '15', '19.50', '猪肉：11.5;\r\n鸡翅：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('626', '126', '14', '26.00', '鸡蛋：3.5;\r\n土豆：2;\r\n辣椒：6.5;\r\n青菜：3;\r\n生姜大蒜：6;\r\n芒果：2;\r\n韭菜：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('627', '126', '41', '765.00', '耳钉：723;\r\nXXOO：30;\r\n痒痒捞：2;\r\n打游戏：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('628', '126', '18', '228.00', '西餐：228;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('629', '126', '11', '11.50', '矿泉水：1.5;\r\n烤鱿鱼：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('630', '126', '7', '29.00', '蜗牛毛衣：29;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('631', '126', '43', '25.00', '保温杯：25;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('632', '126', '9', '4.00', '修眉刀：4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('633', '125', '12', '5.00', '汤面：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('634', '125', '18', '8.00', '午饭：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('635', '125', '14', '8.00', '菜：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('636', '125', '15', '10.00', '猪肉：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('637', '125', '22', '12.00', '桶装水：12；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('638', '127', '12', '5.00', '早餐：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('639', '127', '18', '8.00', '蜗牛快餐：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('640', '127', '11', '5.00', '热干面：3;\r\n烤面筋：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('641', '128', '11', '4.50', '零食：4.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('642', '128', '12', '5.00', '早餐：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('643', '128', '15', '24.00', '鸡肉：24;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('644', '128', '14', '9.00', '黄瓜：4;\r\n香菇：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('645', '128', '13', '16.00', '苹果：9;\r\n橙子：7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('646', '129', '12', '3.00', '早晨：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('647', '130', '32', '8.00', '车费：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('648', '130', '0', '22.00', '香：12;\r\n纸钱：10;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('649', '130', '15', '9.00', '猪肉：9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('650', '130', '14', '11.50', '土豆：2;\r\n辣椒：4;\r\n芹菜：2;\r\n蒜薹：3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('651', '130', '13', '8.00', '小西红柿：3;\r\n橙子：5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('652', '131', '0', '38.00', '饺子：30.5;\r\n汤圆：7.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('653', '131', '14', '5.80', '生姜：5.8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('654', '131', '13', '6.80', '金桔：2.4;\r\n葡萄干：4.4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('657', '133', '0', '25.00', '驾照体检：25;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('658', '133', '32', '20.00', '出租车：20;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('659', '133', '26', '31.50', '看病：31.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('660', '133', '18', '47.00', '回味鸡：42+5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('661', '132', '32', '2.00', '车费：2;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('662', '132', '33', '6395.00', '考驾照：6300;\r\n办居住证：50;\r\n照相：45;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('663', '132', '24', '239.50', '羊毛被：199；\r\n枕头：32.9；\r\n纸巾：7.6；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('664', '132', '14', '6.60', '玉米：1.3；\r\n红萝卜：1.3；\r\n茶树菇：4；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('665', '132', '15', '18.60', '猪排骨：18.6；', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('666', '134', '11', '52.80', '麦片：27.5;\r\n火腿肠：3.5;\r\n欧式蛋糕：8.2;\r\n素牛肉干：7.8;\r\n梅子：5.8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('667', '134', '14', '6.40', '鸡蛋：6.4;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('668', '135', '17', '30.90', '珍珠米：30.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('669', '135', '14', '3.50', '萝卜：1.6;\r\n大蒜：1.1;\r\n白菜：0.8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('670', '135', '17', '89.40', '料酒：5.5;\r\n油：83.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('671', '136', '11', '30.16', '早酥梨：13.96;\r\n散装花生：1;\r\n提子干：2.2;\r\n麻辣豆：6.2;\r\n蜜枣：2.3;\r\n素牛排：4.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('672', '136', '44', '54.90', '锅盖：19.9;\r\n刀：35;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('673', '136', '25', '28.70', '毛巾：13.9;\r\n软毛刷：4.9;\r\n牙膏：9.9;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('674', '136', '14', '8.90', '油麦菜：1.4;\r\n云南小瓜：4.9;\r\n青辣椒：2.6;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('675', '137', '11', '8.00', '烧饼：8;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('676', '137', '15', '5.70', '猪肉：5.7;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('677', '137', '14', '10.40', '萝卜：1.3;\r\n鸡蛋：9.1;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('678', '138', '12', '1.50', '早餐：1.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('679', '138', '14', '6.50', '芹菜：3.5;\r\n豆腐：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('680', '139', '12', '3.50', '早晨：3.5;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('681', '139', '14', '6.00', '芹菜：3;\r\n辣椒：3;', '2014-02-20 21:04:39');
INSERT INTO billdetail VALUES ('682', '140', '15', '9.00', '猪肉：9;', '2014-02-21 21:16:56');
INSERT INTO billdetail VALUES ('683', '140', '14', '15.50', '辣椒：3;\r\n香菜：0.5;\r\n大蒜：3;\r\n千张：6;\r\n馒头：3;', '2014-02-21 21:16:57');
INSERT INTO billdetail VALUES ('684', '140', '43', '20.00', '煤气罐接头：20;', '2014-02-21 21:16:57');
INSERT INTO billdetail VALUES ('690', '141', '14', '11.50', '干辣椒：1.5;\r\n韭菜：0.5;\r\n菠菜：2;\r\n红萝卜：1.5;\r\n土豆：2;\r\n豆角：3;\r\n香菜：1;', '2014-02-22 22:35:25');
INSERT INTO billdetail VALUES ('691', '141', '15', '15.00', '鱿鱼：15;', '2014-02-22 22:35:25');
INSERT INTO billdetail VALUES ('692', '141', '13', '24.00', '苹果：8;\r\n香蕉：7;\r\n橙子：4;\r\n金钱橘：1;\r\n番石榴：4;', '2014-02-22 22:35:25');
INSERT INTO billdetail VALUES ('693', '141', '43', '6.00', '橡胶手套：5;\r\n煤气罐上的铁圈：1;', '2014-02-22 22:35:25');
INSERT INTO billdetail VALUES ('694', '141', '45', '10.00', '理发：10;', '2014-02-22 22:35:25');
INSERT INTO billdetail VALUES ('695', '142', '12', '8.00', '早晨：8;', '2014-02-24 19:16:03');
INSERT INTO billdetail VALUES ('696', '142', '32', '72.00', '去厚街：36;\r\n回黄江：36;', '2014-02-24 19:16:03');
INSERT INTO billdetail VALUES ('697', '143', '14', '8.50', '西兰花：3.5;\r\n荷兰豆：3;\r\n葱花：0.5;\r\n辣椒：1.5;', '2014-02-24 19:19:34');
INSERT INTO billdetail VALUES ('698', '143', '15', '18.00', '猪肉：9;\r\n鱼头：9;', '2014-02-24 19:19:34');
INSERT INTO billdetail VALUES ('699', '143', '11', '4.00', '菠萝：4;', '2014-02-24 19:19:34');
INSERT INTO billdetail VALUES ('700', '143', '12', '1.50', '早餐：1.5;', '2014-02-24 19:19:34');
INSERT INTO billdetail VALUES ('715', '167', '12', '2.00', '早晨:2;', '2014-02-25 21:18:00');
INSERT INTO billdetail VALUES ('720', '169', '12', '3.00', '早餐:3;', '2014-02-28 19:22:53');
INSERT INTO billdetail VALUES ('721', '169', '15', '14.00', '猪肉:9;\n鱼:5;', '2014-02-28 19:22:53');
INSERT INTO billdetail VALUES ('722', '169', '14', '24.50', '南瓜:3;\n莲藕:3;\n红薯:3;\n花菜:3.5;\n辣椒:5;\n香菜:1;\n大蒜+生姜:6;', '2014-02-28 19:22:53');
INSERT INTO billdetail VALUES ('723', '169', '11', '4.00', '饼:4;', '2014-02-28 19:22:53');
INSERT INTO billdetail VALUES ('724', '170', '18', '4.00', '蜗牛快餐:4;', '2014-02-28 19:25:14');
INSERT INTO billdetail VALUES ('725', '170', '12', '4.00', '早餐:4;', '2014-02-28 19:25:14');
INSERT INTO billdetail VALUES ('726', '170', '14', '22.50', '金针菇:6;\n鸡蛋:5.5;\n豆腐:1;\n凉菜:10;', '2014-02-28 19:25:14');
INSERT INTO billdetail VALUES ('727', '170', '11', '4.00', '饼:4;', '2014-02-28 19:25:14');
INSERT INTO billdetail VALUES ('728', '170', '32', '1.00', '蜗牛公交车:1;', '2014-02-28 19:25:14');
INSERT INTO billdetail VALUES ('729', '168', '15', '42.00', '虾:42;', '2014-02-28 19:25:42');
INSERT INTO billdetail VALUES ('730', '168', '14', '18.20', '黑木耳:2.6;\n香菜:1.1;\n杏鲍菇:5;\n五香花生:9.5;', '2014-02-28 19:25:42');
INSERT INTO billdetail VALUES ('731', '168', '13', '14.30', '苹果:14.3;', '2014-02-28 19:25:42');
INSERT INTO billdetail VALUES ('732', '168', '12', '1.50', '早晨:1.5;', '2014-02-28 19:25:42');
INSERT INTO billdetail VALUES ('733', '168', '11', '3.00', '零食:3;', '2014-02-28 19:25:42');
INSERT INTO billdetail VALUES ('734', '171', '12', '4.00', '早餐:4;', '2014-03-02 19:45:16');
INSERT INTO billdetail VALUES ('735', '171', '32', '2.00', '公交车:2;', '2014-03-02 19:45:16');
INSERT INTO billdetail VALUES ('736', '171', '18', '83.00', '出去吃饭:83;', '2014-03-02 19:45:16');
INSERT INTO billdetail VALUES ('737', '172', '12', '5.00', '早餐:5;', '2014-03-02 19:51:05');
INSERT INTO billdetail VALUES ('738', '172', '14', '7.00', '菜:7;', '2014-03-02 19:51:05');
INSERT INTO billdetail VALUES ('739', '172', '13', '30.20', '丰水梨:10.1;\n皇冠梨:11.4;\n红富士:8.7;', '2014-03-02 19:51:05');
INSERT INTO billdetail VALUES ('740', '172', '27', '6.50', '手帕纸:6.5;', '2014-03-02 19:51:05');
INSERT INTO billdetail VALUES ('741', '172', '25', '47.70', '洗发液:32;\n洗衣液:7.9;\n洗衣皂:7.8;', '2014-03-02 19:51:05');
INSERT INTO billdetail VALUES ('742', '172', '11', '32.10', '罐装菜:9.9;\n优乐美:8.9;\n鸡筋:3;\n海苔:10.3;', '2014-03-02 19:51:05');
INSERT INTO billdetail VALUES ('743', '172', '7', '22.90', '男士裤衩:22.9;', '2014-03-02 19:51:05');
INSERT INTO billdetail VALUES ('744', '172', '41', '0.20', '购物袋:0.2;', '2014-03-02 19:51:05');
INSERT INTO billdetail VALUES ('748', '173', '12', '2.00', '早餐:2;', '2014-03-03 20:47:24');
INSERT INTO billdetail VALUES ('749', '173', '14', '3.50', '青菜:3.5;', '2014-03-03 20:47:24');
INSERT INTO billdetail VALUES ('750', '173', '32', '2.00', '公交车:2;', '2014-03-03 20:47:24');
INSERT INTO billdetail VALUES ('751', '173', '33', '316.00', '树莓派(树莓派SD卡电源线外壳):316;', '2014-03-03 20:47:24');
INSERT INTO billdetail VALUES ('752', '174', '32', '2.00', '公交车:2;', '2014-03-04 22:19:30');
INSERT INTO billdetail VALUES ('753', '174', '12', '1.50', '早餐:1.5;', '2014-03-04 22:19:30');
INSERT INTO billdetail VALUES ('754', '174', '14', '5.50', '青菜:5.5;', '2014-03-04 22:19:30');
INSERT INTO billdetail VALUES ('755', '175', '12', '4.00', '早餐:4;', '2014-03-06 22:28:59');
INSERT INTO billdetail VALUES ('756', '175', '11', '3.00', '热干面:3;', '2014-03-06 22:28:59');
INSERT INTO billdetail VALUES ('757', '175', '14', '5.50', '青菜:5.5;', '2014-03-06 22:28:59');
INSERT INTO billdetail VALUES ('758', '176', '12', '6.00', '早餐:6;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('759', '176', '11', '48.80', '火腿肠:3.5;\n趣多多:5.6;\n红泥花生:9.8\n牛肉干:6.5;\n徐福记糖果:9.2;\n香辣牛肉面:2.9;\n老坛酸菜牛肉面:2.7;\n字母饼:2;\n香菇牛肉面:3.6;\n鸡筋:3;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('760', '176', '13', '49.20', '梨:19.1;\n苹果:22.5;\n香蕉:7.6;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('761', '176', '17', '11.40', '鸡精:5.1;\n酱油:1;\n紫菜:5.3;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('762', '176', '14', '5.80', '鸡蛋:5.8;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('763', '176', '41', '10.20', '购物袋:0.2;\n垃圾费:10;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('764', '176', '20', '400.00', '房租:400;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('765', '176', '21', '42.00', '电费:42;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('766', '176', '22', '17.00', '水费:7;\n桶装水:10;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('767', '176', '18', '41.00', '吃饭:41;', '2014-03-06 22:37:20');
INSERT INTO billdetail VALUES ('768', '177', '12', '4.50', '早餐:4.5;', '2014-03-07 19:39:36');
INSERT INTO billdetail VALUES ('769', '177', '15', '23.00', '猪肉:6;\n排骨:17;', '2014-03-07 19:39:36');
INSERT INTO billdetail VALUES ('770', '177', '14', '14.50', '青菜:11;\n土豆:2.5;\n葱:1;', '2014-03-07 19:39:36');
INSERT INTO billdetail VALUES ('771', '177', '13', '5.00', '菠萝:5;', '2014-03-07 19:39:36');
INSERT INTO billdetail VALUES ('772', '178', '12', '3.00', '早餐:3;', '2014-03-09 13:08:19');
INSERT INTO billdetail VALUES ('773', '178', '14', '3.00', '辣椒:1.8;\n青菜:1.2;', '2014-03-09 13:08:19');
INSERT INTO billdetail VALUES ('774', '178', '15', '21.60', '猪肉:12.8;\n肌肉:8.8;', '2014-03-09 13:08:19');
INSERT INTO billdetail VALUES ('801', '183', '12', '2.00', '早餐2', '2014-03-10 21:27:18');
INSERT INTO billdetail VALUES ('802', '183', '14', '6.00', '青菜6', '2014-03-10 21:27:18');
INSERT INTO billdetail VALUES ('807', '184', '15', '5.00', '猪肉:5;', '2014-03-12 22:30:25');
INSERT INTO billdetail VALUES ('808', '184', '14', '10.00', '青菜:5;\n凉菜:5;', '2014-03-12 22:30:26');
INSERT INTO billdetail VALUES ('809', '184', '12', '1.50', '早餐:1.5;', '2014-03-12 22:30:26');
INSERT INTO billdetail VALUES ('810', '184', '33', '82.00', '犀牛买书:82;', '2014-03-12 22:30:26');
INSERT INTO billdetail VALUES ('811', '184', '8', '97.77', '犀牛电脑包:97.77;', '2014-03-12 22:30:26');
INSERT INTO billdetail VALUES ('812', '179', '11', '26.70', '零食:23.7;\n饼:3;', '2014-03-12 22:31:14');
INSERT INTO billdetail VALUES ('813', '179', '15', '9.00', '鱼:9;', '2014-03-12 22:31:14');
INSERT INTO billdetail VALUES ('814', '179', '14', '4.00', '葱:1;\n小辣椒:1;\n玉米:2;', '2014-03-12 22:31:14');
INSERT INTO billdetail VALUES ('815', '179', '13', '7.50', '西红柿:4;\n金桔:3.5;', '2014-03-12 22:31:14');
INSERT INTO billdetail VALUES ('816', '179', '41', '10.00', '老鼠药:10;', '2014-03-12 22:31:14');
INSERT INTO billdetail VALUES ('817', '179', '38', '8.00', '买彩票:8;', '2014-03-12 22:31:14');
INSERT INTO billdetail VALUES ('818', '185', '12', '6.00', '早餐:6;', '2014-03-12 22:32:11');
INSERT INTO billdetail VALUES ('819', '185', '46', '195.00', '新西兰纽派叶酸:195;', '2014-03-12 22:32:11');
INSERT INTO billdetail VALUES ('820', '185', '14', '6.50', '青菜:6.5;', '2014-03-12 22:32:11');
INSERT INTO billdetail VALUES ('821', '185', '11', '20.00', '零食:17;\n小吃:3;', '2014-03-12 22:32:11');
INSERT INTO billdetail VALUES ('822', '185', '26', '36.00', '奇正贴:36;', '2014-03-12 22:32:11');
INSERT INTO billdetail VALUES ('823', '185', '8', '34.00', '蜗牛背包:34;', '2014-03-12 22:32:11');
INSERT INTO billdetail VALUES ('824', '185', '17', '14.00', '米:14;', '2014-03-12 22:32:11');

-- ----------------------------
-- Table structure for `billmaster`
-- ----------------------------
DROP TABLE IF EXISTS `billmaster`;
CREATE TABLE `billmaster` (
  `ID` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `years` int(11) NOT NULL COMMENT '日期:年月日',
  `months` int(11) NOT NULL,
  `days` int(11) NOT NULL,
  `revenue` double(8,2) NOT NULL,
  `outlay` double(8,2) NOT NULL COMMENT '总金额',
  `addtime` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP COMMENT '添加时间',
  `userid` int(11) NOT NULL COMMENT '用户ID',
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `uq_date` (`years`,`months`,`days`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of billmaster
-- ----------------------------
INSERT INTO billmaster VALUES ('36', '2013', '10', '28', '0.00', '57.50', '2013-10-28 20:17:49', '1');
INSERT INTO billmaster VALUES ('37', '2013', '10', '27', '0.00', '931.00', '2013-10-28 20:38:34', '1');
INSERT INTO billmaster VALUES ('38', '2013', '10', '26', '0.00', '696.00', '2013-10-28 20:37:25', '1');
INSERT INTO billmaster VALUES ('39', '2013', '10', '25', '0.00', '3280.00', '2013-10-28 20:42:06', '1');
INSERT INTO billmaster VALUES ('40', '2013', '10', '24', '0.00', '18.50', '2013-10-28 20:43:16', '1');
INSERT INTO billmaster VALUES ('41', '2013', '10', '23', '0.00', '6.50', '2013-10-28 20:44:05', '1');
INSERT INTO billmaster VALUES ('42', '2013', '10', '22', '0.00', '77.30', '2013-10-28 20:48:54', '1');
INSERT INTO billmaster VALUES ('43', '2013', '10', '21', '0.00', '35.00', '2013-10-28 20:50:32', '1');
INSERT INTO billmaster VALUES ('44', '2013', '10', '20', '0.00', '2.00', '2013-10-28 20:50:51', '1');
INSERT INTO billmaster VALUES ('45', '2013', '10', '19', '0.00', '108.50', '2013-10-28 20:54:14', '1');
INSERT INTO billmaster VALUES ('46', '2013', '10', '18', '0.00', '7.50', '2013-10-28 20:55:21', '1');
INSERT INTO billmaster VALUES ('47', '2013', '10', '17', '0.00', '4.00', '2013-10-28 20:56:16', '1');
INSERT INTO billmaster VALUES ('48', '2013', '10', '16', '0.00', '62.00', '2013-10-28 20:58:40', '1');
INSERT INTO billmaster VALUES ('49', '2013', '10', '15', '6425.76', '101.00', '2013-10-28 21:03:35', '1');
INSERT INTO billmaster VALUES ('50', '2013', '10', '14', '0.00', '38.50', '2013-10-28 21:06:29', '1');
INSERT INTO billmaster VALUES ('51', '2013', '10', '13', '0.00', '384.40', '2013-10-28 21:23:37', '1');
INSERT INTO billmaster VALUES ('52', '2013', '10', '12', '0.00', '1071.50', '2013-10-28 21:28:12', '1');
INSERT INTO billmaster VALUES ('53', '2013', '10', '11', '0.00', '50.50', '2013-10-28 21:29:12', '1');
INSERT INTO billmaster VALUES ('54', '2013', '10', '10', '0.00', '23.50', '2013-10-28 21:29:49', '1');
INSERT INTO billmaster VALUES ('55', '2013', '10', '9', '0.00', '330.00', '2013-10-28 21:32:39', '1');
INSERT INTO billmaster VALUES ('56', '2013', '10', '8', '0.00', '11.00', '2013-10-28 21:33:28', '1');
INSERT INTO billmaster VALUES ('57', '2013', '10', '7', '0.00', '840.00', '2013-10-28 21:36:18', '1');
INSERT INTO billmaster VALUES ('58', '2013', '10', '29', '0.00', '3034.00', '2013-10-30 20:35:36', '1');
INSERT INTO billmaster VALUES ('59', '2013', '10', '30', '0.00', '23.00', '2013-10-30 20:35:04', '1');
INSERT INTO billmaster VALUES ('60', '2013', '10', '31', '0.50', '29.50', '2013-10-31 22:13:57', '1');
INSERT INTO billmaster VALUES ('61', '2013', '11', '1', '0.00', '16.00', '2013-11-01 23:10:25', '1');
INSERT INTO billmaster VALUES ('62', '2013', '11', '2', '0.00', '813.10', '2013-11-02 22:03:06', '1');
INSERT INTO billmaster VALUES ('63', '2013', '11', '3', '0.00', '42.70', '2013-11-04 19:46:05', '1');
INSERT INTO billmaster VALUES ('64', '2013', '11', '4', '0.00', '52.00', '2013-11-04 19:45:44', '1');
INSERT INTO billmaster VALUES ('65', '2013', '11', '5', '0.00', '8.00', '2013-11-06 23:30:50', '1');
INSERT INTO billmaster VALUES ('66', '2013', '11', '6', '0.00', '67.20', '2013-11-06 23:30:43', '1');
INSERT INTO billmaster VALUES ('67', '2013', '11', '7', '0.00', '38.00', '2013-11-07 23:10:57', '1');
INSERT INTO billmaster VALUES ('68', '2013', '11', '8', '0.00', '53.00', '2013-11-09 18:29:41', '1');
INSERT INTO billmaster VALUES ('69', '2013', '11', '9', '0.00', '42.40', '2013-11-09 18:34:56', '1');
INSERT INTO billmaster VALUES ('70', '2013', '11', '11', '0.00', '479.00', '2013-11-12 20:52:51', '1');
INSERT INTO billmaster VALUES ('71', '2013', '11', '12', '0.00', '31.90', '2013-11-12 20:54:03', '1');
INSERT INTO billmaster VALUES ('72', '2013', '11', '10', '0.00', '0.00', '2013-11-12 20:54:27', '1');
INSERT INTO billmaster VALUES ('73', '2013', '11', '13', '0.00', '7.50', '2013-11-14 21:11:11', '1');
INSERT INTO billmaster VALUES ('74', '2013', '11', '14', '0.00', '49.50', '2013-11-14 21:12:10', '1');
INSERT INTO billmaster VALUES ('75', '2013', '11', '15', '0.00', '35.00', '2013-11-18 07:39:24', '1');
INSERT INTO billmaster VALUES ('76', '2013', '11', '16', '0.00', '145.00', '2013-11-18 07:40:14', '1');
INSERT INTO billmaster VALUES ('77', '2013', '11', '17', '200.00', '199.80', '2013-11-18 18:04:50', '1');
INSERT INTO billmaster VALUES ('78', '2013', '11', '18', '0.00', '6252.90', '2013-11-18 22:52:27', '1');
INSERT INTO billmaster VALUES ('79', '2013', '11', '19', '0.00', '30.00', '2013-11-19 22:26:06', '1');
INSERT INTO billmaster VALUES ('80', '2013', '11', '20', '0.00', '30.60', '2013-11-20 22:31:40', '1');
INSERT INTO billmaster VALUES ('81', '2013', '11', '21', '0.00', '19.00', '2013-11-21 21:12:41', '1');
INSERT INTO billmaster VALUES ('82', '2013', '11', '22', '0.00', '77.50', '2013-11-24 22:23:36', '1');
INSERT INTO billmaster VALUES ('83', '2013', '11', '23', '0.00', '129.50', '2013-11-24 22:26:04', '1');
INSERT INTO billmaster VALUES ('84', '2013', '11', '24', '0.00', '132.40', '2013-11-24 22:37:00', '1');
INSERT INTO billmaster VALUES ('85', '2013', '11', '25', '0.00', '16.00', '2013-11-26 07:38:12', '1');
INSERT INTO billmaster VALUES ('86', '2013', '11', '26', '0.00', '2798.40', '2013-11-27 23:14:14', '1');
INSERT INTO billmaster VALUES ('87', '2013', '11', '27', '0.00', '16.50', '2013-11-27 23:16:34', '1');
INSERT INTO billmaster VALUES ('88', '2013', '11', '28', '0.00', '108.70', '2013-11-29 22:56:41', '1');
INSERT INTO billmaster VALUES ('89', '2013', '11', '29', '0.00', '96.50', '2013-11-29 23:00:02', '1');
INSERT INTO billmaster VALUES ('90', '2013', '11', '30', '0.00', '277.50', '2013-12-01 20:53:26', '1');
INSERT INTO billmaster VALUES ('91', '2013', '12', '1', '0.00', '47.60', '2013-12-01 20:54:54', '1');
INSERT INTO billmaster VALUES ('92', '2013', '12', '3', '0.00', '15.50', '2013-12-05 22:16:26', '1');
INSERT INTO billmaster VALUES ('93', '2013', '12', '2', '0.00', '563.90', '2013-12-05 22:18:21', '1');
INSERT INTO billmaster VALUES ('94', '2013', '12', '4', '0.00', '121.50', '2013-12-05 22:16:17', '1');
INSERT INTO billmaster VALUES ('95', '2013', '12', '5', '0.00', '11.50', '2013-12-05 22:19:24', '1');
INSERT INTO billmaster VALUES ('96', '2013', '12', '6', '0.00', '24.50', '2013-12-08 20:53:49', '1');
INSERT INTO billmaster VALUES ('97', '2013', '12', '7', '0.00', '63.80', '2013-12-08 20:55:51', '1');
INSERT INTO billmaster VALUES ('98', '2013', '12', '8', '0.00', '122.50', '2013-12-10 20:17:56', '1');
INSERT INTO billmaster VALUES ('99', '2013', '12', '9', '0.00', '3787.00', '2013-12-10 20:20:26', '1');
INSERT INTO billmaster VALUES ('100', '2013', '12', '10', '0.00', '51.00', '2013-12-10 20:20:13', '1');
INSERT INTO billmaster VALUES ('101', '2013', '12', '11', '0.00', '126.90', '2013-12-11 21:03:53', '1');
INSERT INTO billmaster VALUES ('102', '2013', '12', '12', '0.00', '55.00', '2013-12-16 23:00:05', '1');
INSERT INTO billmaster VALUES ('103', '2013', '12', '13', '0.00', '45.50', '2013-12-15 00:32:09', '1');
INSERT INTO billmaster VALUES ('104', '2013', '12', '14', '0.00', '11331.00', '2013-12-15 00:38:22', '1');
INSERT INTO billmaster VALUES ('105', '2013', '12', '15', '0.00', '1171.00', '2013-12-16 23:03:24', '1');
INSERT INTO billmaster VALUES ('106', '2013', '12', '16', '0.00', '26.50', '2013-12-16 23:05:25', '1');
INSERT INTO billmaster VALUES ('107', '2013', '12', '17', '0.00', '17.50', '2013-12-19 20:53:12', '1');
INSERT INTO billmaster VALUES ('108', '2013', '12', '18', '0.00', '119.70', '2013-12-19 21:00:49', '1');
INSERT INTO billmaster VALUES ('109', '2013', '12', '19', '0.00', '16.00', '2013-12-19 21:00:12', '1');
INSERT INTO billmaster VALUES ('110', '2013', '12', '20', '0.00', '51.50', '2013-12-21 20:45:27', '1');
INSERT INTO billmaster VALUES ('111', '2013', '12', '21', '0.00', '1506.30', '2013-12-21 20:45:10', '1');
INSERT INTO billmaster VALUES ('112', '2013', '12', '22', '0.00', '635.00', '2013-12-22 22:10:12', '1');
INSERT INTO billmaster VALUES ('113', '2013', '12', '23', '0.00', '85.50', '2013-12-23 22:43:01', '1');
INSERT INTO billmaster VALUES ('114', '2013', '12', '24', '0.00', '451.45', '2013-12-26 22:34:07', '1');
INSERT INTO billmaster VALUES ('115', '2013', '12', '25', '0.00', '2.50', '2013-12-26 22:27:20', '1');
INSERT INTO billmaster VALUES ('116', '2013', '12', '26', '0.00', '645.28', '2013-12-26 22:33:15', '1');
INSERT INTO billmaster VALUES ('117', '2013', '12', '27', '0.00', '13.00', '2013-12-28 23:33:10', '1');
INSERT INTO billmaster VALUES ('118', '2013', '12', '28', '0.00', '242.00', '2013-12-28 23:32:35', '1');
INSERT INTO billmaster VALUES ('119', '2013', '12', '29', '0.00', '817.10', '2013-12-30 19:02:34', '1');
INSERT INTO billmaster VALUES ('120', '2013', '12', '30', '0.00', '74.50', '2013-12-30 19:07:30', '1');
INSERT INTO billmaster VALUES ('121', '2013', '12', '31', '0.00', '49.50', '2014-01-02 22:20:00', '1');
INSERT INTO billmaster VALUES ('122', '2014', '1', '1', '0.00', '1538.00', '2014-01-02 22:29:23', '1');
INSERT INTO billmaster VALUES ('123', '2014', '1', '2', '0.00', '25.50', '2014-01-02 22:32:43', '1');
INSERT INTO billmaster VALUES ('124', '2014', '1', '3', '0.00', '63.00', '2014-01-05 22:42:59', '1');
INSERT INTO billmaster VALUES ('125', '2014', '1', '4', '0.00', '43.00', '2014-01-05 22:48:55', '1');
INSERT INTO billmaster VALUES ('126', '2014', '1', '5', '0.00', '1108.00', '2014-01-05 22:48:31', '1');
INSERT INTO billmaster VALUES ('127', '2014', '1', '6', '0.00', '18.00', '2014-01-07 21:17:28', '1');
INSERT INTO billmaster VALUES ('128', '2014', '1', '7', '0.00', '58.50', '2014-01-07 21:19:37', '1');
INSERT INTO billmaster VALUES ('129', '2014', '2', '17', '0.00', '3.00', '2014-02-17 20:54:12', '1');
INSERT INTO billmaster VALUES ('130', '2014', '2', '16', '0.00', '58.50', '2014-02-17 20:58:13', '1');
INSERT INTO billmaster VALUES ('131', '2014', '2', '15', '0.00', '50.60', '2014-02-17 21:02:25', '1');
INSERT INTO billmaster VALUES ('132', '2014', '2', '10', '0.00', '6661.70', '2014-02-17 21:13:04', '1');
INSERT INTO billmaster VALUES ('133', '2014', '2', '11', '0.00', '123.50', '2014-02-17 21:10:37', '1');
INSERT INTO billmaster VALUES ('134', '2014', '2', '12', '0.00', '59.20', '2014-02-17 21:14:28', '1');
INSERT INTO billmaster VALUES ('135', '2014', '2', '9', '0.00', '123.80', '2014-02-17 21:17:23', '1');
INSERT INTO billmaster VALUES ('136', '2014', '2', '4', '0.00', '122.66', '2014-02-17 21:21:41', '1');
INSERT INTO billmaster VALUES ('137', '2014', '2', '18', '0.00', '24.10', '2014-02-18 22:06:02', '1');
INSERT INTO billmaster VALUES ('138', '2014', '2', '19', '0.00', '8.00', '2014-02-19 21:08:16', '1');
INSERT INTO billmaster VALUES ('139', '2014', '2', '20', '0.00', '9.50', '2014-02-20 20:39:18', '1');
INSERT INTO billmaster VALUES ('140', '2014', '2', '21', '0.00', '44.50', '2014-02-21 21:16:56', '1');
INSERT INTO billmaster VALUES ('141', '2014', '2', '22', '0.00', '66.50', '2014-02-22 22:35:25', '1');
INSERT INTO billmaster VALUES ('142', '2014', '2', '23', '0.00', '80.00', '2014-02-24 19:16:03', '1');
INSERT INTO billmaster VALUES ('143', '2014', '2', '24', '0.00', '32.00', '2014-02-24 19:19:34', '1');
INSERT INTO billmaster VALUES ('167', '2014', '2', '25', '0.00', '2.00', '2014-02-25 21:17:59', '1');
INSERT INTO billmaster VALUES ('168', '2014', '2', '26', '0.00', '79.00', '2014-02-28 19:25:42', '1');
INSERT INTO billmaster VALUES ('169', '2014', '2', '27', '0.00', '45.50', '2014-02-28 19:22:53', '1');
INSERT INTO billmaster VALUES ('170', '2014', '2', '28', '0.00', '35.50', '2014-02-28 19:25:14', '1');
INSERT INTO billmaster VALUES ('171', '2014', '3', '1', '0.00', '89.00', '2014-03-02 19:45:16', '1');
INSERT INTO billmaster VALUES ('172', '2014', '3', '2', '0.00', '151.60', '2014-03-02 19:51:05', '1');
INSERT INTO billmaster VALUES ('173', '2014', '3', '3', '0.00', '323.50', '2014-03-03 20:47:24', '1');
INSERT INTO billmaster VALUES ('174', '2014', '3', '4', '0.00', '9.00', '2014-03-04 22:19:30', '1');
INSERT INTO billmaster VALUES ('175', '2014', '3', '5', '0.00', '12.50', '2014-03-06 22:28:59', '1');
INSERT INTO billmaster VALUES ('176', '2014', '3', '6', '0.00', '631.40', '2014-03-06 22:37:20', '1');
INSERT INTO billmaster VALUES ('177', '2014', '3', '7', '0.00', '47.00', '2014-03-07 19:39:36', '1');
INSERT INTO billmaster VALUES ('178', '2014', '3', '8', '0.00', '27.60', '2014-03-09 13:08:19', '1');
INSERT INTO billmaster VALUES ('179', '2014', '3', '9', '0.00', '65.20', '2014-03-12 22:31:14', '1');
INSERT INTO billmaster VALUES ('183', '2014', '3', '10', '0.00', '11.00', '2014-03-10 21:27:18', '1');
INSERT INTO billmaster VALUES ('184', '2014', '3', '11', '0.00', '196.27', '2014-03-12 22:30:25', '1');
INSERT INTO billmaster VALUES ('185', '2014', '3', '12', '0.00', '311.50', '2014-03-12 22:32:11', '1');

-- ----------------------------
-- Table structure for `billtags`
-- ----------------------------
DROP TABLE IF EXISTS `billtags`;
CREATE TABLE `billtags` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `tagname` varchar(100) NOT NULL COMMENT 'tag名称',
  `tagtype` varchar(4) NOT NULL,
  `isshow` varchar(2) NOT NULL COMMENT '是否显示',
  `pid` int(11) NOT NULL,
  `addtime` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of billtags
-- ----------------------------
INSERT INTO billtags VALUES ('1', '衣', 'O', 'Y', '0', '2014-02-20 11:37:50');
INSERT INTO billtags VALUES ('2', '食', 'O', 'Y', '0', '2014-02-20 11:38:33');
INSERT INTO billtags VALUES ('3', '住', 'O', 'Y', '0', '2014-02-20 11:38:51');
INSERT INTO billtags VALUES ('4', '行', 'O', 'Y', '0', '2014-02-20 11:39:17');
INSERT INTO billtags VALUES ('5', '它', 'O', 'Y', '0', '2014-02-24 21:17:41');
INSERT INTO billtags VALUES ('6', '鞋子', 'O', 'Y', '1', '2014-02-20 12:19:50');
INSERT INTO billtags VALUES ('7', '衣服', 'O', 'Y', '1', '2014-02-20 12:19:51');
INSERT INTO billtags VALUES ('8', '饰品', 'O', 'Y', '1', '2014-02-20 12:19:51');
INSERT INTO billtags VALUES ('9', '化妆品', 'O', 'Y', '1', '2014-02-20 12:19:51');
INSERT INTO billtags VALUES ('10', '女士用品', 'O', 'Y', '1', '2014-02-20 12:19:51');
INSERT INTO billtags VALUES ('11', '零食', 'O', 'Y', '2', '2014-02-20 12:19:52');
INSERT INTO billtags VALUES ('12', '早餐', 'O', 'Y', '2', '2014-02-20 12:19:53');
INSERT INTO billtags VALUES ('13', '水果', 'O', 'Y', '2', '2014-02-20 12:19:54');
INSERT INTO billtags VALUES ('14', '蔬菜', 'O', 'Y', '2', '2014-02-20 12:19:55');
INSERT INTO billtags VALUES ('15', '肉类', 'O', 'Y', '2', '2014-02-20 12:19:57');
INSERT INTO billtags VALUES ('16', '酒', 'O', 'Y', '2', '2014-02-20 12:19:58');
INSERT INTO billtags VALUES ('17', '柴米油盐', 'O', 'Y', '2', '2014-02-20 12:19:59');
INSERT INTO billtags VALUES ('18', '自己吃饭', 'O', 'Y', '2', '2014-02-20 12:20:00');
INSERT INTO billtags VALUES ('19', '请客吃饭', 'O', 'Y', '2', '2014-02-20 12:20:01');
INSERT INTO billtags VALUES ('20', '房租', 'O', 'Y', '3', '2014-02-20 12:20:02');
INSERT INTO billtags VALUES ('21', '电费', 'O', 'Y', '3', '2014-02-20 12:20:03');
INSERT INTO billtags VALUES ('22', '水费', 'O', 'Y', '3', '2014-02-20 12:20:05');
INSERT INTO billtags VALUES ('23', '家电', 'O', 'Y', '3', '2014-02-20 12:20:06');
INSERT INTO billtags VALUES ('24', '床上', 'O', 'Y', '3', '2014-02-20 12:20:07');
INSERT INTO billtags VALUES ('25', '洗漱', 'O', 'Y', '3', '2014-02-20 12:20:08');
INSERT INTO billtags VALUES ('26', '医药', 'O', 'Y', '3', '2014-02-20 12:20:09');
INSERT INTO billtags VALUES ('27', '纸类', 'O', 'Y', '3', '2014-02-20 12:20:10');
INSERT INTO billtags VALUES ('28', '工资', 'I', 'Y', '5', '2014-02-20 21:35:50');
INSERT INTO billtags VALUES ('29', '借钱出去', 'O', 'Y', '5', '2014-02-20 21:35:52');
INSERT INTO billtags VALUES ('30', '还钱进来', 'I', 'Y', '5', '2014-02-20 21:35:54');
INSERT INTO billtags VALUES ('31', '非工资', 'I', 'Y', '5', '2014-02-20 21:35:55');
INSERT INTO billtags VALUES ('32', '车费', 'O', 'Y', '4', '2014-02-20 12:20:16');
INSERT INTO billtags VALUES ('33', '学习', 'O', 'Y', '4', '2014-02-20 12:20:17');
INSERT INTO billtags VALUES ('34', '送礼', 'O', 'Y', '4', '2014-02-20 12:20:19');
INSERT INTO billtags VALUES ('35', '娱乐', 'O', 'Y', '4', '2014-02-20 12:20:20');
INSERT INTO billtags VALUES ('36', '礼佛', 'O', 'Y', '4', '2014-02-20 12:20:21');
INSERT INTO billtags VALUES ('37', '话费', 'O', 'Y', '4', '2014-02-20 12:20:22');
INSERT INTO billtags VALUES ('38', '虚拟', 'O', 'Y', '5', '2014-02-20 12:20:23');
INSERT INTO billtags VALUES ('39', '卫生', 'O', 'Y', '5', '2014-02-20 12:20:24');
INSERT INTO billtags VALUES ('40', '巨额', 'O', 'Y', '5', '2014-02-20 12:20:25');
INSERT INTO billtags VALUES ('41', '其他', 'O', 'Y', '5', '2014-02-20 12:20:27');
INSERT INTO billtags VALUES ('42', '电影', 'O', 'Y', '4', '2014-02-20 21:09:41');
INSERT INTO billtags VALUES ('43', '工具', 'O', 'Y', '3', '2014-02-20 21:09:44');
INSERT INTO billtags VALUES ('44', '厨具', 'O', 'Y', '3', '2014-02-20 21:09:46');
INSERT INTO billtags VALUES ('45', '理发', 'O', 'Y', '1', '2014-02-22 22:34:55');
INSERT INTO billtags VALUES ('46', '给孩子', 'O', 'Y', '5', '2014-03-12 22:24:17');

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment COMMENT '主键ID',
  `login` varchar(255) NOT NULL COMMENT '登录账号',
  `pswd` varchar(255) NOT NULL COMMENT '登录密码',
  `name` varchar(255) NOT NULL COMMENT '显示名称',
  `tel` varchar(255) default NULL COMMENT '电话',
  `email` varchar(255) default NULL COMMENT '邮箱',
  `sex` varchar(255) NOT NULL COMMENT '性别',
  `addtime` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO users VALUES ('1', 'Dn9x', '6A204BD89F3C8348AFD5C77C717A097A', 'Dn9x', '13794829675', 'xiuxu123@live.cn', 'M', '2013-10-25 08:22:39');
