/*
SQLyog 企业版 - MySQL GUI v7.14 
MySQL - 5.5.48-log : Database - myshop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`myshop` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `myshop`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2017-08-08 19:31:36'),(2,'auth','0001_initial','2017-08-08 19:31:39'),(3,'admin','0001_initial','2017-08-08 19:31:39'),(4,'admin','0002_logentry_remove_auto_add','2017-08-08 19:31:39'),(5,'contenttypes','0002_remove_content_type_name','2017-08-08 19:31:39'),(6,'auth','0002_alter_permission_name_max_length','2017-08-08 19:31:39'),(7,'auth','0003_alter_user_email_max_length','2017-08-08 19:31:39'),(8,'auth','0004_alter_user_username_opts','2017-08-08 19:31:39'),(9,'auth','0005_alter_user_last_login_null','2017-08-08 19:31:40'),(10,'auth','0006_require_contenttypes_0002','2017-08-08 19:31:40'),(11,'auth','0007_alter_validators_add_error_messages','2017-08-08 19:31:40'),(12,'auth','0008_alter_user_username_max_length','2017-08-08 19:31:40'),(13,'sessions','0001_initial','2017-08-08 19:31:40');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('0lnpkco765binuiv8l7j18cwz02iv2le','N2NjMjhhMmI0ZTQ5MGZiZWI3MTM2YTFjNTUyOTgyY2RiZjM5MzNiZDp7InNob3BsIjp7IjIiOnsiaWQiOjIsImdvb2RzIjoiXHU4MmY5XHU2NzljNnMiLCJwaWNuYW1lIjoiMTUwMjU0NTY1Mi4xMTU4Njg2LmpwZyIsInByaWNlIjozOTk5LjAsInN0b3JlIjoxMDAwLCJtIjo3fSwiNyI6eyJpZCI6NywiZ29vZHMiOiJcdThmZGVcdTg4NjNcdTg4ZDkiLCJwaWNuYW1lIjoiMTUwMjYwMjMxMC45ODEwNzY3LmpwZyIsInByaWNlIjoxODkuMCwic3RvcmUiOjEwMCwibSI6MX0sIjYiOnsiaWQiOjYsImdvb2RzIjoiXHU4MDU0XHU2MGYzXHU3YjE0XHU4YmIwXHU2NzJjIiwicGljbmFtZSI6IjE1MDI2MDIxOTQuMzQxMjMyNS5qcGciLCJwcmljZSI6NDk5OS4wLCJzdG9yZSI6NTAwLCJtIjo2fSwiMTAiOnsiaWQiOjEwLCJnb29kcyI6Ilx1NGY3M1x1ODBmZFx1NTM1NVx1NTNjZCIsInBpY25hbWUiOiIxNTAyNjAyNTgxLjc0MTM1NTQuanBnIiwicHJpY2UiOjc5OTkuMCwic3RvcmUiOjEwMCwibSI6MX19LCJvcmRlcmxpc3QiOnsiMTAiOnsiaWQiOjEwLCJnb29kcyI6Ilx1NGY3M1x1ODBmZFx1NTM1NVx1NTNjZCIsInBpY25hbWUiOiIxNTAyNjAyNTgxLjc0MTM1NTQuanBnIiwicHJpY2UiOjc5OTkuMCwic3RvcmUiOjEwMCwibSI6MX19LCJ0b3RhbCI6Nzk5OS4wLCJ2ZXJpZnljb2RlIjoiVE5NQSIsImFkbWludXNlciI6IiIsInZpcHVzZXIiOnsiaWQiOjgsInVzZXJuYW1lIjoidHcxOTk0MDQyOSIsIm5hbWUiOiJcdTU1MTBcdTRmMWYiLCJhZGRyZXNzIjoiXHU1MzE3XHU0ZWFjXHU1ZTAyXHU2NjBjXHU1ZTczXHU1MzNhXHU1MTQ0XHU1ZjFmXHU4ZmRlIiwicGhvbmUiOiIxMzkxOTYxMTM4OSIsImNvZGUiOiIxMjM0NTYifX0=','2017-08-28 12:57:21'),('6a3waaaiaimd9muilzdwc6s8vbvcwqsn','ODYyMjE4ZDM1NjhkYzI1MzNiZGNiNTg1Y2ViM2M5NDVlZTIwNTk1YTp7InNob3BsIjp7IjMiOnsiaWQiOjMsImdvb2RzIjoiXHU1MzU1XHU1M2NkXHU3NmY4XHU2NzNhIiwicGljbmFtZSI6IjE1MDI1NDU5MjEuMDM5NjczNi5qcGciLCJwcmljZSI6ODk5OS4wLCJzdG9yZSI6NjAwLCJtIjoxfX19','2017-08-28 06:11:42'),('7pi56moh7a4en53xlwh022qmzx24b0ym','NDAxZjBiOGRlMDdiZDgwMGIxZGVkYWYwNjJlZjhiYjk0N2IwMzcxOTp7InZlcmlmeWNvZGUiOiJBME9YIiwiYWRtaW51c2VyIjoiXHU3YmExXHU3NDA2XHU1NDU4IiwidG90YWwiOjg5Ny4wLCJvcmRlcmxpc3QiOnsiOCI6eyJpZCI6OCwiZ29vZHMiOiJcdTk3ZTlcdTcyNDhcdThmZGVcdTg4NjNcdTg4ZDkiLCJwaWNuYW1lIjoiMTUwMjYwMjM5Ni43NDEzMTEzLmpwZyIsInByaWNlIjoyOTkuMCwic3RvcmUiOjEwMCwibSI6Mn0sIjUiOnsiaWQiOjUsImdvb2RzIjoiVFx1NjA2NCIsInBpY25hbWUiOiIxNTAyNjAyMTA0LjAzNjI4ODUuanBnIiwicHJpY2UiOjI5OS4wLCJzdG9yZSI6MjAwLCJtIjoxfX0sInZpcHVzZXIiOnsiaWQiOjgsInVzZXJuYW1lIjoidHcxOTk0MDQyOSIsIm5hbWUiOiJcdTU1MTBcdTRmMWYiLCJhZGRyZXNzIjoiXHU1MzE3XHU0ZWFjXHU1ZTAyXHU2NjBjXHU1ZTczXHU1MzNhXHU1MTQ0XHU1ZjFmXHU4ZmRlIiwicGhvbmUiOiIxMzkxOTYxMTM4OSIsImNvZGUiOiIxMjM0NTYiLCJlbWFpbCI6IjExMTEyQHFxLmNvbSJ9fQ==','2017-08-30 01:34:46'),('ifathysqkuvf8s6zk1vrq9h8dgtjye0n','NzRkM2VhMmQ0MWUyNzg4OTcxYmJiY2I4ZGRmMjMxZGIzMTZiZGExYzp7InZlcmlmeWNvZGUiOiJRWEpGIiwidmlwdXNlciI6eyJpZCI6OCwidXNlcm5hbWUiOiJ0dzE5OTQwNDI5IiwibmFtZSI6Ilx1NTUxMFx1NGYxZiIsImFkZHJlc3MiOiJcdTUzMTdcdTRlYWNcdTVlMDJcdTY2MGNcdTVlNzNcdTUzM2FcdTUxNDRcdTVmMWZcdThmZGUiLCJwaG9uZSI6IjEzOTE5NjExMzg5IiwiY29kZSI6IjEyMzQ1NiJ9LCJzaG9wbCI6eyIyIjp7ImlkIjoyLCJnb29kcyI6Ilx1ODJmOVx1Njc5YzZzIiwicGljbmFtZSI6IjE1MDI1NDU2NTIuMTE1ODY4Ni5qcGciLCJwcmljZSI6Mzk5OS4wLCJzdG9yZSI6MTAwMCwibSI6OH19fQ==','2017-08-28 13:07:17'),('jnw8hc8hjmrh9ml2xcfmjm5x0nwfjzpk','MjgwZjcxNmJkNGRkMmNjMzVkZGQ1YjNkZTk0NmUzMDcyMGI4N2I4ODp7InZlcmlmeWNvZGUiOiJFRDRSIiwiYWRtaW51c2VyIjoiIiwic2hvcGwiOnsiMyI6eyJpZCI6MywiZ29vZHMiOiJcdTUzNTVcdTUzY2RcdTc2ZjhcdTY3M2EiLCJwaWNuYW1lIjoiMTUwMjU0NTkyMS4wMzk2NzM2LmpwZyIsInByaWNlIjo4OTk5LjAsInN0b3JlIjo2MDAsIm0iOjF9fX0=','2017-08-27 21:07:29'),('ygqucu8sjnjzkr25pxg761v6ai10f78o','NGNmNGQ1ODY0YWI1ZGVkOWY3YmM1NTc1NjJlY2E0YWRlMDA0ODljYzp7InZlcmlmeWNvZGUiOiIyOVJGIiwic2hvcGwiOnsiMyI6eyJpZCI6MywiZ29vZHMiOiJcdTUzNTVcdTUzY2RcdTc2ZjhcdTY3M2EiLCJwaWNuYW1lIjoiMTUwMjU0NTkyMS4wMzk2NzM2LmpwZyIsInByaWNlIjo4OTk5LjAsInN0b3JlIjo2MDAsIm0iOjN9LCI1Ijp7ImlkIjo1LCJnb29kcyI6IlRcdTYwNjQiLCJwaWNuYW1lIjoiMTUwMjYwMjEwNC4wMzYyODg1LmpwZyIsInByaWNlIjoyOTkuMCwic3RvcmUiOjIwMCwibSI6MX0sIjEiOnsiaWQiOjEsImdvb2RzIjoiXHU3YjE0XHU4YmIwXHU2NzJjIiwicGljbmFtZSI6IjE1MDI1NDU3OTYuODgxNzEzMi5qcGciLCJwcmljZSI6NDk5OS4wLCJzdG9yZSI6NTAwLCJtIjoxfSwiNyI6eyJpZCI6NywiZ29vZHMiOiJcdThmZGVcdTg4NjNcdTg4ZDkiLCJwaWNuYW1lIjoiMTUwMjYwMjMxMC45ODEwNzY3LmpwZyIsInByaWNlIjoxODkuMCwic3RvcmUiOjEwMCwibSI6MX19LCJvcmRlcmxpc3QiOnsiMyI6eyJpZCI6MywiZ29vZHMiOiJcdTUzNTVcdTUzY2RcdTc2ZjhcdTY3M2EiLCJwaWNuYW1lIjoiMTUwMjU0NTkyMS4wMzk2NzM2LmpwZyIsInByaWNlIjo4OTk5LjAsInN0b3JlIjo2MDAsIm0iOjN9fSwidG90YWwiOjI2OTk3LjAsImFkbWludXNlciI6Ilx1N2JhMVx1NzQwNlx1NTQ1OCIsInZpcHVzZXIiOnsiaWQiOjgsInVzZXJuYW1lIjoidHcxOTk0MDQyOSIsIm5hbWUiOiJcdTU1MTBcdTRmMWYiLCJhZGRyZXNzIjoiXHU1MzE3XHU0ZWFjXHU1ZTAyXHU2NjBjXHU1ZTczXHU1MzNhXHU1MTQ0XHU1ZjFmXHU4ZmRlIiwicGhvbmUiOiIxMzkxOTYxMTM4OSIsImNvZGUiOiIxMjM0NTYifX0=','2017-08-28 17:52:16'),('yj6vtjnmv8qeam6szmbnt7xd0lesty83','MWQ3ZjQ5NmFlZmE1YzQyMmI4YmE0MDhkOWU1NWViOWNkMmVhZDk2OTp7InZlcmlmeWNvZGUiOiI4NlRQIiwiYWRtaW51c2VyIjoiXHU3YmExXHU3NDA2XHU1NDU4In0=','2017-08-29 10:32:17');

/*Table structure for table `myweb_detail` */

DROP TABLE IF EXISTS `myweb_detail`;

CREATE TABLE `myweb_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price` double(6,2) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `addtime` int(11) DEFAULT NULL,
  `picname` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

/*Data for the table `myweb_detail` */

insert  into `myweb_detail`(`id`,`orderid`,`goodsid`,`name`,`price`,`num`,`addtime`,`picname`,`status`) values (54,49,5,'T恤',299.00,2,1502838054,'1502602104.0362885.jpg',1),(55,49,7,'连衣裙',189.00,2,1502838054,'1502602310.9810767.jpg',2),(56,50,7,'连衣裙',189.00,1,1502838873,'1502602310.9810767.jpg',1),(57,51,6,'联想笔记本',4999.00,1,1502841614,'1502602194.3412325.jpg',NULL),(58,52,8,'韩版连衣裙',299.00,2,1502847173,'1502602396.7413113.jpg',NULL),(59,52,5,'T恤',299.00,1,1502847173,'1502602104.0362885.jpg',NULL);

/*Table structure for table `myweb_goods` */

DROP TABLE IF EXISTS `myweb_goods`;

CREATE TABLE `myweb_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `typeid` int(11) unsigned DEFAULT NULL,
  `goods` varchar(32) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `descr` text,
  `price` double(6,2) DEFAULT NULL,
  `picname` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1',
  `store` int(11) unsigned DEFAULT '0',
  `num` int(11) unsigned DEFAULT '0',
  `clicknum` int(11) unsigned DEFAULT '0',
  `addtime` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `typeid` (`typeid`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `myweb_goods` */

insert  into `myweb_goods`(`id`,`typeid`,`goods`,`company`,`descr`,`price`,`picname`,`state`,`store`,`num`,`clicknum`,`addtime`) values (1,11,'笔记本','小米公司','小米最新款电脑             ',4999.00,'1502545796.8817132.jpg',1,500,0,16,1502545797),(2,10,'苹果6s','苹果公司','苹果公司',3999.00,'1502545652.1158686.jpg',2,1000,0,24,1502545652),(3,5,'单反相机','佳能公司',' 佳能单反相机',8999.00,'1502545921.0396736.jpg',1,600,0,50,1502545921),(4,7,'T恤衫','美利坚','时尚的T恤衫 男人的最爱',199.00,'1502602019.092536.jpg',1,600,0,7,1502602019),(5,7,'T恤','七匹狼','男人就要像狼一样',299.00,'1502602104.0362885.jpg',1,200,0,99,1502602104),(6,11,'联想笔记本','联想公司','游戏本',4999.00,'1502602194.3412325.jpg',1,500,0,13,1502602194),(7,8,'连衣裙','优衣库','穿着你会更美 ',189.00,'1502602310.9810767.jpg',1,100,0,113,1502602311),(8,8,'韩版连衣裙','优衣库',' 魅力无限',299.00,'1502602396.7413113.jpg',1,100,0,7,1502602396),(9,8,'韩版粉色连衣裙','优衣库','魅力的开始        ',299.00,'1502602474.918982.jpg',1,100,0,2,1502602474),(10,5,'佳能单反','佳能公司','拍出精彩世界         ',7999.00,'1502602581.7413554.jpg',1,100,0,2,1502602581),(11,9,'时尚外套','特步',' 会更漂亮',90.00,'1502602687.44846.jpg',1,200,0,2,1502602687),(12,9,'粉色童装','优衣库','少女养成中',80.00,'1502602752.263826.jpg',1,100,0,3,1502602752),(13,10,'华为x10','华为公司','支持国产',2999.00,'1502602823.4793794.jpg',1,1000,0,2,1502602823),(17,10,'华为max10','华为公司','你的选择不会错     ',3888.00,'1502757728.170409.jpg',1,100,0,3,1502757728);

/*Table structure for table `myweb_orders` */

DROP TABLE IF EXISTS `myweb_orders`;

CREATE TABLE `myweb_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `linkman` varchar(32) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` char(1) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `addtime` int(11) DEFAULT NULL,
  `total` double(8,2) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `picname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

/*Data for the table `myweb_orders` */

insert  into `myweb_orders`(`id`,`uid`,`linkman`,`address`,`code`,`phone`,`addtime`,`total`,`status`,`picname`) values (49,8,'唐伟','北京市昌平区兄弟连','1','13919611389',1502838054,976.00,0,''),(50,8,'唐伟','北京市昌平区兄弟连','1','13919611389',1502838873,189.00,0,''),(51,8,'唐伟','北京市昌平区兄弟连','1','13919611389',1502841614,4999.00,0,''),(52,8,'唐伟','北京市昌平区兄弟连','1','13919611389',1502847173,897.00,0,'');

/*Table structure for table `myweb_types` */

DROP TABLE IF EXISTS `myweb_types`;

CREATE TABLE `myweb_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `pid` int(11) DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `myweb_types` */

insert  into `myweb_types`(`id`,`name`,`pid`,`path`) values (1,'服装',0,'0,'),(2,'数码',0,'0,'),(3,'食品',0,'0,'),(5,'相机',2,'0,2,'),(7,'男装',1,'0,1,'),(8,'女装',1,'0,1,'),(9,'童装',1,'0,1,'),(10,'手机',2,'0,2,'),(11,'电脑',2,'0,2,'),(12,'电视',2,'0,2,');

/*Table structure for table `myweb_users` */

DROP TABLE IF EXISTS `myweb_users`;

CREATE TABLE `myweb_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `name` varchar(16) DEFAULT NULL,
  `password` char(32) NOT NULL,
  `sex` tinyint(4) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` char(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `state` tinyint(4) DEFAULT '1',
  `addtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex1` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 CHECKSUM=1 DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;

/*Data for the table `myweb_users` */

insert  into `myweb_users`(`id`,`username`,`name`,`password`,`sex`,`address`,`code`,`phone`,`email`,`state`,`addtime`) values (4,'admin','管理员','e10adc3949ba59abbe56e057f20f883e',1,'北京市昌平区兄弟连','123456','1332424355','12432554@qq.com',0,1502217338),(5,'li1234434','李四','e10adc3949ba59abbe56e057f20f883e',0,'北京市昌平区兄弟连','132123','12432435','231314@qq.com',2,1502217677),(6,'libai1234','李白','e10adc3949ba59abbe56e057f20f883e',1,'北京市昌平区兄弟连','121312','110119120','1321112@qq.com',1,1502440870),(7,'tw6666','李刚','e10adc3949ba59abbe56e057f20f883e',1,'北京市昌平区兄弟连','123456','12345678998','123243@qq.com',1,1502469640),(8,'tw19940429','唐伟','25f9e794323b453885f5181f1b624d0b',1,'北京市昌平区兄弟连','123456','13919611389','11112@qq.com',0,1502574777),(14,'tt1111','','e10adc3949ba59abbe56e057f20f883e',1,'','','11111111111','12343@qq.com',1,1502601000),(15,'99999','','e10adc3949ba59abbe56e057f20f883e',1,'','','99999','999@qq.com',1,1502601330),(16,'tt-12','','e10adc3949ba59abbe56e057f20f883e',1,'','','12345678910','1234@qq.com',1,1502704660),(17,'yy-99','','e10adc3949ba59abbe56e057f20f883e',1,'','','110119120114','1123@qq.com',1,1502709508),(18,'tt','','e10adc3949ba59abbe56e057f20f883e',1,'','','123456789','13232@qq.com',1,1502757125),(19,'tt123456','','e10adc3949ba59abbe56e057f20f883e',1,'','','123456','123@qq.com',1,1502814130),(20,'12345','','827ccb0eea8a706c4c34a16891f84e7b',1,'','','12345','123@qq.com',1,1502830368);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
