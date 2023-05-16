/*
SQLyog Community v13.1.8 (64 bit)
MySQL - 10.4.21-MariaDB : Database - sbs_proj_2023
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sbs_proj_2023` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `sbs_proj_2023`;

/*Table structure for table `article` */

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `boardId` int(10) unsigned NOT NULL,
  `title` char(100) NOT NULL,
  `body` text NOT NULL,
  `hitCount` int(10) unsigned NOT NULL DEFAULT 0,
  `goodReactionPoint` int(10) unsigned NOT NULL DEFAULT 0,
  `badReactionPoint` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `article` */

insert  into `article`(`id`,`regDate`,`updateDate`,`memberId`,`boardId`,`title`,`body`,`hitCount`,`goodReactionPoint`,`badReactionPoint`) values 
(1,'2023-05-12 18:14:26','2023-05-12 18:14:26',2,1,'제목1','내용1',0,1,2),
(2,'2023-05-12 18:14:26','2023-05-12 18:14:26',2,1,'제목2','내용2',1,2,0),
(3,'2023-05-12 18:14:26','2023-05-12 18:14:26',2,2,'제목3','내용3',0,0,0);

/*Table structure for table `attr` */

DROP TABLE IF EXISTS `attr`;

CREATE TABLE `attr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `relTypeCode` char(20) NOT NULL,
  `relId` int(10) NOT NULL,
  `typeCode` char(30) NOT NULL,
  `type2Code` char(70) NOT NULL,
  `value` text NOT NULL,
  `expireDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relTypeCode` (`relTypeCode`,`relId`,`typeCode`,`type2Code`),
  KEY `relTypeCode_2` (`relTypeCode`,`typeCode`,`type2Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `attr` */

/*Table structure for table `board` */

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `code` char(50) NOT NULL COMMENT 'notice(공지사항), free1(자유게시판1), free2(자유게시판2,...',
  `name` char(50) NOT NULL COMMENT '게시판 이름',
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '삭제여부(0=탈퇴전, 1=탈퇴)',
  `delDate` datetime DEFAULT NULL COMMENT '삭제날짜',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

/*Data for the table `board` */

insert  into `board`(`id`,`regDate`,`updateDate`,`code`,`name`,`delStatus`,`delDate`) values 
(1,'2023-05-12 18:14:26','2023-05-12 18:14:26','notice','공지사항',0,NULL),
(2,'2023-05-12 18:14:26','2023-05-12 18:14:26','free1','자유',0,NULL);

/*Table structure for table `calendar` */

DROP TABLE IF EXISTS `calendar`;

CREATE TABLE `calendar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `title` varchar(200) NOT NULL,
  `writer` varchar(50) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `startDate` datetime NOT NULL,
  `endDate` datetime NOT NULL,
  `allDay` tinyint(1) unsigned DEFAULT NULL,
  `textColor` varchar(50) DEFAULT NULL,
  `backgroundColor` varchar(50) DEFAULT NULL,
  `borderColor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `calendar` */

insert  into `calendar`(`id`,`regDate`,`updateDate`,`title`,`writer`,`content`,`startDate`,`endDate`,`allDay`,`textColor`,`backgroundColor`,`borderColor`) values 
(1,'2023-05-16 20:25:50','2023-05-16 20:25:50','test1','test','test1','2023-05-01 20:25:50','2023-05-03 20:25:50',0,'yellow','navy','navy'),
(2,'2023-05-16 20:25:51','2023-05-16 20:25:51','test3','test','test1','2023-05-17 20:25:51','2023-05-18 20:25:51',0,'yellow','navy','navy'),
(3,'2023-05-16 20:25:51','2023-05-16 20:25:51','test2','test','test1','2023-05-24 20:25:51','2023-05-31 20:25:51',0,'yellow','navy','navy');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `loginId` char(20) NOT NULL,
  `authLevel` smallint(2) unsigned DEFAULT 3 COMMENT '(3=일반, 7=관리자)',
  `loginPw` varchar(100) NOT NULL,
  `name` char(20) NOT NULL,
  `nickname` char(20) NOT NULL,
  `cellphoneNo` char(20) NOT NULL,
  `email` char(50) NOT NULL,
  `delStatus` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '탈퇴여부',
  `delDate` datetime DEFAULT NULL COMMENT '탈퇴날짜',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `member` */

insert  into `member`(`id`,`regDate`,`updateDate`,`loginId`,`authLevel`,`loginPw`,`name`,`nickname`,`cellphoneNo`,`email`,`delStatus`,`delDate`) values 
(1,'2023-05-12 18:14:26','2023-05-12 18:14:26','admin',7,'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918','관리자','관리자','01011111111','admin@gmail.com',0,NULL),
(2,'2023-05-12 18:14:26','2023-05-12 18:14:26','user1',3,'0a041b9462caa4a31bac3567e0b6e6fd9100787db2ab433d96f6d178cabfce90','사용자1','사용자1','01011111111','user1@gmail.com',0,NULL),
(3,'2023-05-12 18:14:26','2023-05-12 18:14:26','user2',3,'6025d18fe48abd45168528f18a82e265dd98d421a7084aa09f61b341703901a3','사용자2','사용자2','01011111111','user2@gmail.com',0,NULL);

/*Table structure for table `reactionPoint` */

DROP TABLE IF EXISTS `reactionPoint`;

CREATE TABLE `reactionPoint` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `relTypeCode` char(30) NOT NULL COMMENT '관련데이터타입코드',
  `relId` int(10) unsigned NOT NULL COMMENT '관련데이터번호',
  `point` smallint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `reactionPoint` */

insert  into `reactionPoint`(`id`,`regDate`,`updateDate`,`memberId`,`relTypeCode`,`relId`,`point`) values 
(1,'2023-05-12 18:14:26','2023-05-12 18:14:26',1,'article',1,-1),
(2,'2023-05-12 18:14:26','2023-05-12 18:14:26',1,'article',2,1),
(3,'2023-05-12 18:14:26','2023-05-12 18:14:26',2,'article',1,-1),
(4,'2023-05-12 18:14:26','2023-05-12 18:14:26',2,'article',2,1),
(5,'2023-05-12 18:14:26','2023-05-12 18:14:26',3,'article',1,1);

/*Table structure for table `reply` */

DROP TABLE IF EXISTS `reply`;

CREATE TABLE `reply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `regDate` datetime NOT NULL,
  `updateDate` datetime NOT NULL,
  `memberId` int(10) unsigned NOT NULL,
  `relTypeCode` char(30) NOT NULL COMMENT '관련데이터타입코드',
  `relId` int(10) unsigned NOT NULL COMMENT '관련데이터번호',
  `body` text NOT NULL,
  `badReactionPoint` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `reply` */

insert  into `reply`(`id`,`regDate`,`updateDate`,`memberId`,`relTypeCode`,`relId`,`body`,`badReactionPoint`) values 
(1,'2023-05-12 18:14:26','2023-05-12 18:14:26',1,'article',1,'댓글 1',0),
(2,'2023-05-12 18:14:26','2023-05-12 18:14:26',2,'article',1,'댓글 2',0),
(3,'2023-05-12 18:14:26','2023-05-12 18:14:26',2,'article',2,'댓글 3',0),
(4,'2023-05-12 18:14:26','2023-05-12 18:14:26',1,'article',2,'댓글 4',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
