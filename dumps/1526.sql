/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 8.0.45-0ubuntu0.22.04.1 : Database - bunleo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bunleo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `bunleo`;

/*Table structure for table `agenda_playoffs` */

DROP TABLE IF EXISTS `agenda_playoffs`;

CREATE TABLE `agenda_playoffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_torneo` int NOT NULL,
  `id_horario` int NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `leyendados` varchar(150) NOT NULL,
  `leyenda` varchar(150) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_agenda_torneo` (`id_torneo`),
  KEY `idx_agenda_cat` (`categoria`),
  KEY `idx_agenda_activo` (`activo`),
  KEY `fk_agenda_horario` (`id_horario`),
  CONSTRAINT `agenda_playoffs_ibfk_1` FOREIGN KEY (`id_torneo`) REFERENCES `torneos` (`id`),
  CONSTRAINT `fk_agenda_horario` FOREIGN KEY (`id_horario`) REFERENCES `horarios` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `agenda_playoffs` */

/*Table structure for table `detalle_sets` */

DROP TABLE IF EXISTS `detalle_sets`;

CREATE TABLE `detalle_sets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_partido` int NOT NULL,
  `numero_set` int NOT NULL COMMENT '1, 2, o 3 (super TB)',
  `games_local` int NOT NULL,
  `games_visitante` int NOT NULL,
  `es_super_tiebreak` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_partido` (`id_partido`),
  CONSTRAINT `fk_detalle_sets_partido` FOREIGN KEY (`id_partido`) REFERENCES `partido` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=421 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Detalle de cada set jugado';

/*Data for the table `detalle_sets` */

/*Table structure for table `estadisticas_grupo` */

DROP TABLE IF EXISTS `estadisticas_grupo`;

CREATE TABLE `estadisticas_grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_grupo` int NOT NULL,
  `id_inscripto` int NOT NULL,
  `pj` int DEFAULT '0' COMMENT 'partidos jugados',
  `pg` int DEFAULT '0' COMMENT 'partidos ganados (1 punto)',
  `pp` int DEFAULT '0' COMMENT 'partidos perdidos',
  `puntos` int DEFAULT '0',
  `sets_ganados` int DEFAULT '0',
  `sets_perdidos` int DEFAULT '0',
  `dif_sets` int DEFAULT '0' COMMENT 'sets_ganados - sets_perdidos',
  `games_ganados` int DEFAULT '0',
  `games_perdidos` int DEFAULT '0',
  `dif_games` int DEFAULT '0' COMMENT 'games_ganados - games_perdidos',
  `posicion` int DEFAULT NULL,
  `es_primero` tinyint(1) DEFAULT '0',
  `es_segundo` tinyint(1) DEFAULT '0',
  `clasificado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_grupo_inscripto` (`id_grupo`,`id_inscripto`),
  KEY `idx_grupo` (`id_grupo`),
  KEY `idx_inscripto` (`id_inscripto`),
  CONSTRAINT `fk_estadisticas_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_estadisticas_inscripto` FOREIGN KEY (`id_inscripto`) REFERENCES `inscriptos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21434 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Estadísticas calculadas por grupo';

/*Data for the table `estadisticas_grupo` */

insert  into `estadisticas_grupo`(`id`,`id_grupo`,`id_inscripto`,`pj`,`pg`,`pp`,`puntos`,`sets_ganados`,`sets_perdidos`,`dif_sets`,`games_ganados`,`games_perdidos`,`dif_games`,`posicion`,`es_primero`,`es_segundo`,`clasificado`) values (21285,141,270,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21286,141,296,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21287,141,311,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21288,142,272,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21289,142,345,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21290,142,350,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21291,143,244,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21292,143,251,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21293,143,337,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21294,144,248,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21295,144,294,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21296,144,341,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21297,145,293,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21298,145,306,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21299,145,321,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21300,146,258,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21301,146,265,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21302,146,314,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21303,147,347,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21304,147,353,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21305,147,357,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21306,153,243,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21307,153,276,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21308,153,305,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21309,153,327,0,0,0,0,0,0,0,0,0,0,4,0,0,0),(21310,154,266,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21311,154,312,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21312,154,346,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21313,154,355,0,0,0,0,0,0,0,0,0,0,4,0,0,0),(21341,159,249,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21342,159,260,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21343,159,340,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21350,160,246,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21351,160,271,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21352,160,282,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21353,161,289,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21354,161,310,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21355,161,334,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21356,162,262,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21357,162,268,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21358,162,283,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21359,163,255,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21360,163,280,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21361,163,328,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21362,164,261,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21363,164,269,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21364,164,274,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21365,165,252,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21366,165,267,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21367,165,302,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21368,128,275,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21369,128,285,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21370,128,315,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21371,129,247,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21372,129,263,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21373,129,300,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21374,130,308,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21375,130,359,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21376,130,362,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21377,131,290,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21378,131,304,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21379,131,316,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21380,132,279,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21381,132,297,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21382,132,363,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21383,133,256,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21384,133,303,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21385,133,336,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21386,134,319,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21387,134,343,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21388,134,354,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21389,157,325,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21390,157,331,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21391,157,342,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21392,158,320,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21393,158,323,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21394,158,335,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21395,155,338,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21396,155,339,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21397,155,349,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21398,156,329,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21399,156,344,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21400,156,348,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21401,148,287,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21402,148,291,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21403,148,326,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21404,149,299,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21405,149,317,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21406,149,356,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21407,150,288,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21408,150,332,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21409,150,352,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21410,151,284,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21411,151,292,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21412,151,301,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21413,152,245,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21414,152,309,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21415,152,322,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21416,135,254,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21417,135,281,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21418,135,351,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21419,136,307,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21420,136,313,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21421,136,318,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21422,137,264,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21423,137,286,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21424,137,361,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21425,138,242,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21426,138,273,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21427,138,277,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21428,139,259,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21429,139,278,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21430,139,333,0,0,0,0,0,0,0,0,0,0,3,0,0,0),(21431,140,324,0,0,0,0,0,0,0,0,0,0,1,1,0,1),(21432,140,330,0,0,0,0,0,0,0,0,0,0,2,0,1,1),(21433,140,358,0,0,0,0,0,0,0,0,0,0,3,0,0,0);

/*Table structure for table `grupo_integrantes` */

DROP TABLE IF EXISTS `grupo_integrantes`;

CREATE TABLE `grupo_integrantes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_grupo` int NOT NULL,
  `id_inscripto` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_grupo_inscripto` (`id_grupo`,`id_inscripto`),
  KEY `id_inscripto` (`id_inscripto`),
  CONSTRAINT `grupo_integrantes_ibfk_1` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grupo_integrantes_ibfk_2` FOREIGN KEY (`id_inscripto`) REFERENCES `inscriptos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `grupo_integrantes` */

insert  into `grupo_integrantes`(`id`,`id_grupo`,`id_inscripto`) values (387,128,275),(386,128,285),(385,128,315),(389,129,247),(388,129,263),(390,129,300),(391,130,308),(393,130,359),(392,130,362),(394,131,290),(396,131,304),(395,131,316),(397,132,279),(398,132,297),(399,132,363),(400,133,256),(401,133,303),(402,133,336),(405,134,319),(404,134,343),(403,134,354),(408,135,254),(406,135,281),(407,135,351),(409,136,307),(410,136,313),(411,136,318),(414,137,264),(412,137,286),(413,137,361),(417,138,242),(416,138,273),(415,138,277),(418,139,259),(420,139,278),(419,139,333),(421,140,324),(422,140,330),(423,140,358),(425,141,270),(426,141,296),(424,141,311),(427,142,272),(428,142,345),(429,142,350),(432,143,244),(430,143,251),(431,143,337),(433,144,248),(435,144,294),(434,144,341),(437,145,293),(436,145,306),(438,145,321),(440,146,258),(441,146,265),(439,146,314),(444,147,347),(443,147,353),(442,147,357),(446,148,287),(445,148,291),(447,148,326),(448,149,299),(450,149,317),(449,149,356),(452,150,288),(451,150,332),(453,150,352),(455,151,284),(456,151,292),(454,151,301),(459,152,245),(458,152,309),(457,152,322),(462,153,243),(460,153,276),(461,153,305),(463,153,327),(466,154,266),(465,154,312),(467,154,346),(464,154,355),(470,155,338),(468,155,339),(469,155,349),(471,156,329),(472,156,344),(473,156,348),(503,157,325),(502,157,331),(501,157,342),(506,158,320),(505,158,323),(504,158,335),(481,159,249),(482,159,260),(480,159,340),(483,160,246),(484,160,271),(485,160,282),(487,161,289),(488,161,310),(486,161,334),(491,162,262),(489,162,268),(490,162,283),(494,163,255),(493,163,280),(492,163,328),(497,164,261),(495,164,269),(496,164,274),(500,165,252),(498,165,267),(499,165,302);

/*Table structure for table `grupos` */

DROP TABLE IF EXISTS `grupos`;

CREATE TABLE `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_grupo` int NOT NULL,
  `id_torneo_fk` int NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `cantidad_integrantes` int NOT NULL,
  `estado` enum('armado','pendiente','finalizado') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'pendiente',
  PRIMARY KEY (`id`),
  KEY `id_torneo_fk` (`id_torneo_fk`),
  KEY `categoria` (`categoria`),
  CONSTRAINT `grupos_ibfk_1` FOREIGN KEY (`id_torneo_fk`) REFERENCES `torneos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `grupos` */

insert  into `grupos`(`id`,`numero_grupo`,`id_torneo_fk`,`categoria`,`cantidad_integrantes`,`estado`) values (128,1,4,'F-D',3,'armado'),(129,2,4,'F-D',3,'armado'),(130,3,4,'F-D',3,'armado'),(131,4,4,'F-D',3,'armado'),(132,5,4,'F-D',3,'armado'),(133,6,4,'F-D',3,'armado'),(134,7,4,'F-D',3,'armado'),(135,1,4,'M-C',3,'armado'),(136,2,4,'M-C',3,'armado'),(137,3,4,'M-C',3,'armado'),(138,4,4,'M-C',3,'armado'),(139,5,4,'M-C',3,'armado'),(140,6,4,'M-C',3,'armado'),(141,7,4,'M-C',3,'armado'),(142,8,4,'M-C',3,'armado'),(143,1,4,'M-D',3,'armado'),(144,2,4,'M-D',3,'armado'),(145,3,4,'M-D',3,'armado'),(146,4,4,'M-D',3,'armado'),(147,5,4,'M-D',3,'armado'),(148,1,4,'M-B',3,'armado'),(149,2,4,'M-B',3,'armado'),(150,3,4,'M-B',3,'armado'),(151,4,4,'M-B',3,'armado'),(152,5,4,'M-B',3,'armado'),(153,1,4,'M-E',4,'armado'),(154,2,4,'M-E',4,'armado'),(155,1,4,'M-A',3,'armado'),(156,2,4,'M-A',3,'armado'),(157,1,4,'F-E',3,'armado'),(158,2,4,'F-E',3,'armado'),(159,1,4,'F-B',3,'armado'),(160,2,4,'F-B',3,'armado'),(161,1,4,'F-C',3,'armado'),(162,2,4,'F-C',3,'armado'),(163,3,4,'F-C',3,'armado'),(164,4,4,'F-C',3,'armado'),(165,5,4,'F-C',3,'armado');

/*Table structure for table `horarios` */

DROP TABLE IF EXISTS `horarios`;

CREATE TABLE `horarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_torneo_fk` int NOT NULL,
  `dia_semana` varchar(20) NOT NULL,
  `fecha` date NOT NULL,
  `hora_inicio` time NOT NULL,
  `Canchas` int DEFAULT '4',
  `activo` tinyint(1) DEFAULT '1',
  `es_playoff` tinyint(1) DEFAULT '0',
  `lugar` enum('Aeroclub','Malon','Challenger','Estudiantes','Tenis Rio Cuarto','Banda Norte','Jockey Club') DEFAULT 'Aeroclub',
  PRIMARY KEY (`id`),
  KEY `id_torneo_fk` (`id_torneo_fk`),
  CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`id_torneo_fk`) REFERENCES `torneos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8mb3;

/*Data for the table `horarios` */

insert  into `horarios`(`id`,`id_torneo_fk`,`dia_semana`,`fecha`,`hora_inicio`,`Canchas`,`activo`,`es_playoff`,`lugar`) values (119,4,'Lunes','2026-05-04','14:00:00',3,1,0,'Jockey Club'),(120,4,'Lunes','2026-05-04','15:30:00',3,1,0,'Jockey Club'),(122,4,'Domingo','2026-05-05','08:30:00',4,1,1,'Jockey Club'),(123,4,'Lunes','2026-05-04','08:30:00',6,1,0,'Jockey Club'),(124,4,'Lunes','2026-05-04','10:00:00',6,1,0,'Jockey Club'),(125,4,'Lunes','2026-05-04','17:00:00',3,1,0,'Jockey Club'),(126,4,'Lunes','2026-05-04','18:30:00',3,1,0,'Jockey Club'),(127,4,'Lunes','2026-05-04','20:00:00',6,1,0,'Jockey Club'),(128,4,'Lunes','2026-05-04','21:30:00',8,1,0,'Jockey Club'),(129,4,'Martes','2026-05-05','08:30:00',6,1,0,'Jockey Club'),(130,4,'Martes','2026-05-05','10:00:00',6,1,0,'Jockey Club'),(131,4,'Martes','2026-05-05','14:00:00',3,1,0,'Jockey Club'),(132,4,'Martes','2026-05-05','15:30:00',3,1,0,'Jockey Club'),(133,4,'Martes','2026-05-05','17:00:00',3,1,0,'Jockey Club'),(134,4,'Martes','2026-05-05','18:30:00',3,1,0,'Jockey Club'),(135,4,'Martes','2026-05-05','20:00:00',6,1,0,'Jockey Club'),(136,4,'Martes','2026-05-05','21:30:00',8,1,0,'Jockey Club'),(137,4,'Miércoles','2026-05-06','08:30:00',6,1,0,'Jockey Club'),(138,4,'Miércoles','2026-05-06','10:00:00',6,1,0,'Jockey Club'),(139,4,'Miércoles','2026-05-06','14:00:00',3,1,0,'Jockey Club'),(140,4,'Miércoles','2026-05-06','15:30:00',3,1,0,'Jockey Club'),(141,4,'Miércoles','2026-05-06','17:00:00',3,1,0,'Jockey Club'),(142,4,'Miércoles','2026-05-06','18:30:00',3,1,0,'Jockey Club'),(143,4,'Miércoles','2026-05-06','20:00:00',6,1,0,'Jockey Club'),(144,4,'Miércoles','2026-05-06','21:30:00',8,1,0,'Jockey Club'),(145,4,'Jueves','2026-05-07','08:30:00',6,1,0,'Jockey Club'),(146,4,'Jueves','2026-05-07','10:00:00',6,1,0,'Jockey Club'),(147,4,'Jueves','2026-05-07','14:00:00',3,1,0,'Jockey Club'),(148,4,'Jueves','2026-05-07','15:30:00',3,1,0,'Jockey Club'),(149,4,'Jueves','2026-05-07','17:00:00',3,1,0,'Jockey Club'),(150,4,'Jueves','2026-05-07','18:30:00',3,1,0,'Jockey Club'),(151,4,'Jueves','2026-05-07','20:00:00',6,1,0,'Jockey Club'),(152,4,'Jueves','2026-05-07','21:30:00',8,1,0,'Jockey Club'),(153,4,'Viernes','2026-05-08','08:30:00',6,1,0,'Jockey Club'),(154,4,'Viernes','2026-05-08','10:00:00',6,1,0,'Jockey Club'),(155,4,'Viernes','2026-05-08','14:00:00',3,1,0,'Jockey Club'),(156,4,'Viernes','2026-05-08','15:30:00',3,1,0,'Jockey Club'),(157,4,'Viernes','2026-05-08','17:00:00',3,1,0,'Jockey Club'),(158,4,'Viernes','2026-05-08','18:30:00',3,1,0,'Jockey Club'),(159,4,'Viernes','2026-05-08','20:00:00',6,1,0,'Jockey Club'),(160,4,'Viernes','2026-05-08','21:30:00',8,1,0,'Jockey Club'),(161,4,'Sábado','2026-05-09','08:30:00',0,1,0,'Jockey Club'),(162,4,'Sábado','2026-05-09','10:00:00',0,1,0,'Jockey Club'),(163,4,'Sábado','2026-05-09','11:30:00',0,1,0,'Jockey Club'),(164,4,'Sábado','2026-05-09','13:00:00',0,1,0,'Jockey Club'),(165,4,'Domingo','2026-05-03','09:00:00',0,1,0,'Jockey Club'),(166,4,'Domingo','2026-05-03','10:30:00',0,1,0,'Jockey Club'),(167,4,'Domingo','2026-05-03','12:00:00',0,1,0,'Jockey Club'),(168,4,'Domingo','2026-05-03','13:30:00',0,1,0,'Jockey Club'),(169,4,'Domingo','2026-05-03','15:00:00',0,1,0,'Jockey Club'),(170,4,'Domingo','2026-05-03','16:30:00',0,1,0,'Jockey Club'),(171,4,'Domingo','2026-05-03','18:00:00',0,1,0,'Jockey Club');

/*Table structure for table `inscriptos` */

DROP TABLE IF EXISTS `inscriptos`;

CREATE TABLE `inscriptos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_torneo_fk` int NOT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `integrantes` varchar(300) DEFAULT NULL,
  `telefono` varchar(100) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `acepto` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id_torneo_fk` (`id_torneo_fk`),
  CONSTRAINT `inscriptos_ibfk_1` FOREIGN KEY (`id_torneo_fk`) REFERENCES `torneos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=364 DEFAULT CHARSET=utf8mb3;

/*Data for the table `inscriptos` */

insert  into `inscriptos`(`id`,`id_torneo_fk`,`correo`,`integrantes`,`telefono`,`categoria`,`acepto`) values (242,4,'jfpalomas@hotmail.com','FLAVIO LOPEZ  / JAIME PALOMAS ','93586003435','M-C',1),(243,4,'mirkoepavic@hotmail.com','MKRKO E. PAVIC  / MIRKO PAVIC ','3584167243','M-E',1),(244,4,'marianodurany@gmail.com','MARIANO DURANY / MARTÍN DURANY','3584185463','M-D',1),(245,4,'kevinpisinis@gmail.com','KEVIN PISSINIS  / MARTIN FERREYRA ','3585646207','M-B',1),(246,4,'ceci.maitana@gmail.com','ALI PERALTA / CECI MAITANA','3584228750','F-B',1),(247,4,'guadalupealoy.wa@gmail.com','GISELA FERNÁNDE  / GUADALUPE ALOY ','3584863718','F-D',1),(248,4,'hectorzanini@hotmail.com','HECTOR ZANINI / DANIEL IPOLITO','3586000208','M-D',1),(249,4,'ibuffarini@hotmail.com','MALVINA GENTILE / IVANA BUFFARINI ','3584280624','F-B',1),(251,4,'mati-bosco@hotmail.com','MATI BOSCO / ALE BOSCO ','3582404647','M-D',1),(252,4,'rosanalanfrancojl@hotmail.com.ar','STEFANI DE YONG / RO LANFRANCO','3584816079','F-C',1),(254,4,'allerpablo@outlook.com','PABLO ALLER / FEDE DAVICO','3385680248','M-C',1),(255,4,'ayelendiaz94.ad88@gmail.com','AYE DIAZ / VANI SANTOMERO','3584293174','F-C',1),(256,4,'verodegea@hotmail.com','VERO DE GEA / CAMI PAOLONI','3584169692','F-D',1),(258,4,'juancarlosbalcazarreategui@gmail.com','JUAN BALCAZAR / JUAN FERNIGRINI','93586003735','M-D',1),(259,4,'AGUSTINPRONOTTI@OUTLOOK.COM','AGUSTIN PRONOTTI / MARCELO MEDINA','3584020291','M-C',1),(260,4,'kamilasafadi07@gmail.com','KAMI SAFADI  / AMBI SAFADI ','3584314222','F-B',1),(261,4,'romiautran@gmail.com','ROMI AUTRAN / MARIA SENNA','3584011561','F-C',1),(262,4,'enrig717@hotmail.com','SILVIA IRIGOYEN / ENRI GONZALEZ','3585073529','F-C',1),(263,4,'villanuevafer1702@gmail.com','SOFI SABADIAS  / FER VILLANUEVA ','3816140893','F-D',1),(264,4,'tristanamado@gmail.com','TRISTÁN AMADO  / CONS.  TRIULZI','3584196837','M-C',1),(265,4,'j.federico.fernandez1993@gmail.com','FEDE FERNANDEZ / FRANCO PAUTASSO','2664834226','M-D',1),(266,4,'gonza.abogacia@gmail.com','GONZALO ROMERO  / PABLO TROLLIET ','3584186084','M-E',1),(267,4,'que_llueva@hotmail.com','ROMI GIMENEZ / MICA OSELLA','3584015277','F-C',1),(268,4,'eliana_palandri@hotmail.com','ELI PALANDRI / ELE RASGER','3584220596','F-C',1),(269,4,'micaela.franchella@gmail.com','MICA FRANCHELLA / CELE GENGHINI','3584328154','F-C',1),(270,4,'gastonhbar1181@gmail.com','GASTÓN BÁRCENA  / MATÍAS SODERO','3584337689','M-C',1),(271,4,'natalia_diez22@yahoo.com.ar','NATY DIEZ / VANE COWES ','3586011226','F-B',1),(272,4,'l_witowski@hotmail.com','LUCAS WITOWSKI  / SANTIAGO ABRAHAN','3584021283','M-C',1),(273,4,'Jonitessa2@gmail.com','JONI TESSA / LUCAS OVIEDO','03585606707','M-C',1),(274,4,'pilimana9@gmail.com','PILAR MANA  / ANTO  CUCCHIETTI ','3583441742','F-C',1),(275,4,'ingridberomero@gmail.com','INGRID ROMERO  / JESICA CASTAÑÓN ','3584860769','F-D',1),(276,4,'matydebia77@gmail.com','MATÍAS DEBIA / DARÍO BARRIOS','3584021919','M-E',1),(277,4,'fernandobenavidez@gmail.com','GUSTAVO VALLEJOS / FERNANDO BENAVÍDEZ','03586016757','M-C',1),(278,4,'juliolepori@hotmail.com','JULIO LEPORI / DIEGO PAROLI','3583416694','M-C',1),(279,4,'luchytas@hotmail.com','LUCHI SALVADOR / ADRIANA ABALLAY','03584206331','F-D',1),(280,4,'gualtierimariaeugenia@gmail.com','LARA DIGENARO / EUGENIA GUALTIER','03585149897','F-C',1),(281,4,'mariochanique@hotmail.com','MARIO CHANIQUE  / DANIEL CABRAL','3584163726','M-C',1),(282,4,'romybaigorria@hotmail.com','RO BAIGORRIA / NORMA JAIME','03586007905','F-B',1),(283,4,'florortizcenteno@hotmail.com','VALENTINA TORRES / FLORENCIA ORTIZ ','3584903283','F-C',1),(284,4,'emmavillegas994@gmail.com','EMMA VILLEGAS  / DARIO BERNÁRDEZ ','3571522357','M-B',1),(285,4,'susanamoral71@gmail.com','SUSY MORAL  / LU RIVADENEIRA','93586009471','F-D',1),(286,4,'mauriciohege33@gmail.com','MAURICIO HEGE  / MATÍAS CARPIO ','3584012051','M-C',1),(287,4,'nagli.martinelias@gmail.com','MARTÍN NAGLI / HUGO LÓPEZ ','3585480219','M-B',1),(288,4,'germanpisani@outlook.com','GERMÁN PISANI / CRISTIAN GIGANTE','3584307482','M-B',1),(289,4,'ali_bruhn@hotmail.com','JULIETA LOSER / ALINA OVIEDO','3585481172','F-C',1),(290,4,'debocagnolo@gmail.com','DÉBORA RAMADORI  / PAULA ROCCO','3516773280','F-D',1),(291,4,'franciscoswedzky@gmail.com','F SWEDZKY / L MERONI','3584121944','M-B',1),(292,4,'deramojuan21@gmail.com','JUAN D\'ERAMO / LEO CORIA','3585718546','M-B',1),(293,4,'abascalmanu@gmail.com','MANUEL ABASCAL / GASTON THUER','3584021031','M-D',1),(294,4,'rugpiero@hotmail.com','PIERO GONZALEZ  / DIEGO CONSTANTIN','3584196876','M-D',1),(296,4,'fedeucacha@hotmail.com','FEDERICO GALLI / FRANCO RICHARDET','3534206164','M-C',1),(297,4,'lic.valeriaprizzon@gmail.com','PAMELA JULIÁN  / VALERIA PRIZZON ','03584228160','F-D',1),(299,4,'jomarzuoli@gmail.com','JUAN MARZUOLI / MARTIN MOLAYOLI','2657667925','M-B',1),(300,4,'gariboldigisela97@gmail.com','GISE GARIBOLDI / BELU ZALAZAR','03584847402','F-D',1),(301,4,'lopezvalen065@gmail.com','VALENTÍN LÓPEZ  / JOAQUÍN PRIDA','3584320177','M-B',1),(302,4,'cuquenieto59@gmail.com','CUQUE NIETO / MICHI NIETO','3585087963','F-C',1),(303,4,'Silvana_martinelli5@hotmail.com','SIL MARTÍNELLI  / EUGE CANALLINI','0358154018588','F-D',1),(304,4,'marilinamigliori@hotmail.com','MARI MIGLIORI / VANI GONZÁLEZ ','3586008983','F-D',1),(305,4,'gonzalomanavella@hotmail.com','GON MANAVELLA / JULI GALARZA','3584306945','M-E',1),(306,4,'spissinis@gmail.com','SERGIO PISSINIS / MATIAS GHIO ','3586547278','M-D',1),(307,4,'gacantore@hotmail.com','GUSTAVO CANTORE  / MIGUEL MILET','3585061550','M-C',1),(308,4,'marinamedina620@gmail.com','MARINA MEDINA / MIMI BERTOLETTI','3584225868','F-D',1),(309,4,'iancia@yahoo.com.ar','GUSTAVO LASCANO  / IGNACIO ANCÍA ','3584840494','M-B',1),(310,4,'anaroldan5122009@gmail.com','SOFI BLANCO  / ANITA ROLDAN','3584023738','F-C',1),(311,4,'emalpr@gmail.com','RODO DALAISON / EMA ROSAS','3584371753','M-C',1),(312,4,'sebathuer@yahoo.com','WALTER GUEVARA / SEBASTIÁN THÜER ','358154844437','M-E',1),(313,4,'ferchuluca72@gmail.com','MAURICIO DOMINICI / FERNANDO GIRAUDI','3584257638','M-C',1),(314,4,'karolandres30@gmail.com','KAROL DE YONG / MARTIN DE YONG','3584308933','M-D',1),(315,4,'gonzalezsegat@gmail.com','PATRICIA GIGENA / PILAR SEGAT ','3584116325','F-D',1),(316,4,'ruthlorena_30@hotmail.com','LORE CORREA  / ANGELA FERNÁNDEZ','3584195947','F-D',1),(317,4,'isapablo252@gmail.com','PABLO ISA  / SANTI CORONEL','5493584861474','M-B',1),(318,4,'fernandojosecohen@gmail.com','FERNANDO COHEN / GERARDO DOMÍNGUEZ','3586011936','M-C',1),(319,4,'natachanoeliacappellari@gmail.com','MILE DALAISON / NATY CAPPELLARI','3585071528','F-D',1),(320,4,'alicia.heredia186@gmail.com','ESTELA PAGLIONE / ALICIA HEREDIA','3585075287','F-E',1),(321,4,'rebelladavito10@gmail.com','BERNY REBELLA / DAVID REBELLA','3585103751','M-D',1),(322,4,'piligol78@hotmail.com','LUCIANO ALBANESI / GASTÓN CHEETHAM','3584120323','M-B',1),(323,4,'rociovesnaver12@gmail.com','ROCIO VESNAVER  / PAULA BARBERO','3584113870','F-E',1),(324,4,'federicos88@hotmail.com','PEDRA JORGE / SARTORI FEDERICO','3582436086','M-C',1),(325,4,'pauladenisefabbro@gmail.com','PAULA FABBRO  / ALEJANDRA GALARZ','3582432922','F-E',1),(326,4,'rubenjosemarconi@gmail.com','JOSÉ MARCONI / MARTIN LABARI','03586023077','M-B',1),(327,4,'arielavaquero@gmail.com','ARIEL VAQUERO / JUAN FONTANA ','3586002969','M-E',1),(328,4,'lrasger@gmail.com','LU RASGER / AMPI FRIAS','3584840562','F-C',1),(329,4,'Pablo.a.marti@hotmail.com','PABLO MARTI / JOSÉ FRUTTERO','3584280879','M-A',1),(330,4,'P.bunader@gmail.com','PABLO BUNADER / JOSE MARENGO','3586011358','M-C',1),(331,4,'paualgan@gmail.com','PAULA ALGAN  / LAURA MARINO','3584356313','F-E',1),(332,4,'afgoto85@gmail.com','ALE GONZALEZ / PABLO ZONNI','3586025205','M-B',1),(333,4,'drbergagna@gmail.com','MARIAN BEVIACQUA  / MARCOS BERGAGNA ','03584191580','M-C',1),(334,4,'morenasottile99@gmail.com','MORE SOTTILE  / AGUSTINA JORBA ','3584817205','F-C',1),(335,4,'virginicolino@gmail.com','VIRGI NICOLINO / PIA PEROTTI','3584879279','F-E',1),(336,4,'cbernardini26@gmail.com','CANDE BERNARDINI / SOFI BETOZ ','3584208512','F-D',1),(337,4,'pueblamauricio@hotmail.com','MAURICIO PUEBLA  /  ARIEL DOMINGUEZ','3584239228','M-D',1),(338,4,'federperezrama@gmail.com','FEDE PEREZRAMA  / MATIAS PLENASIO ','3584119003','M-A',1),(339,4,'nicolas.gudino85@gmail.com','IGNACIO GIGENA / NICOLÁS GUDIÑO','3584220661','M-A',1),(340,4,'cmartinezu90@gmail.com','CECILIA MARTÍNEZ / VICKY ELLENA','3584314324','F-B',1),(341,4,'emanuelalfonso86@gmail.com','EMMANUEL ENGEL  / EMANUEL ALFONSO ','03585082528','M-D',1),(342,4,'roblecarola@yahoo.com.ar','CARO ROBLE / ALE MOLINA','3584013653','F-E',1),(343,4,'susanapanella@hotmail.com','SUSANA PANELLA / ALICIA CENA','3585061321','F-D',1),(344,4,'juanmapellegrini95@gmail.com','FRAN FISSORE  / JUAN PELLEGRINI ','03586016075','M-A',1),(345,4,'sebagorro@hotmail.com','SEBA GORROCHATEG / ANDRÉS NICOLA','3584167703','M-C',1),(346,4,'jorgemartinelli70@gmail.com','JORGE MARTINELLI / DAVID ZOSSO','3504862500','M-E',1),(347,4,'rubenlarosa1975@gmail.com','RUBÉN LA ROSA / EMI FORESTO','3584240808','M-D',1),(348,4,'leo_martinez92@hotmail.com','LEO MARTINEZ  / MARTÍN GIORDANO ','3584024642','M-A',1),(349,4,'carlos.krabbe@gmail.com','CARLOS KRABBE / MATÍAS MOLAYOLI','3584859574','M-A',1),(350,4,'aukha.mecatronico@gmail.com','AUKHA ASUREY / MARCO DI COLA','3571573676','M-C',1),(351,4,'valen.rod.aba@gmail.com','VALENTIN ABALLAY  /  CESAR HELBLING','3584022446','M-C',1),(352,4,'santiago.liboa@gmail.com','SANTI LIBOA / LEA STEFANINI','3586001450','M-B',1),(353,4,'gavageronimo27@gmail.com','GERO GAVA / GASTON ARGUELLO','+54 9 358 602 8195','M-D',1),(354,4,'lilianafvinci@gmail.com','LILIANA VINCI  / NORMA ROSSI ','03584368509','F-D',1),(355,4,'Maguitosco@hotmail.com','EDGARDO TOSCO / CLAUDIO REINERI','3585486502','M-E',1),(356,4,'emiperrone935@gmail.com','EMI PERRONE / GONZA CARON ','3584906960','M-B',1),(357,4,'geramati@gmail.com','GERARDO RINAUDO / MILTON FUNES ','3584207949','M-D',1),(358,4,'davidamaya22_14@hotmail.com','DAVID AMAYA  / FAUSTO AMAYA ','0358154292403','M-C',1),(359,4,'clarilorenzo99@gmail.com','CLARA LORENZO / IVON ALVARADO ','3584834748','F-D',1),(361,4,'fedemolina3@gmail.com','FEDERICO MOLINA  / MARTIN MOLINA','3586023061','M-C',1),(362,4,'erausquinbelen@gmail.com','BELEN ERAUSQUIN  / MELI MARE','0358154314646','F-D',1),(363,4,'leo_martinez92@hotmail.com','ELI ANDREAZZINI / FLOR MARTÍN ','3584175073','F-D',1);

/*Table structure for table `inscriptos_horarios` */

DROP TABLE IF EXISTS `inscriptos_horarios`;

CREATE TABLE `inscriptos_horarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_inscripto_fk` int NOT NULL,
  `id_horario_fk` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_inscripto_fk` (`id_inscripto_fk`),
  KEY `id_horario_fk` (`id_horario_fk`),
  CONSTRAINT `inscriptos_horarios_ibfk_1` FOREIGN KEY (`id_inscripto_fk`) REFERENCES `inscriptos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inscriptos_horarios_ibfk_2` FOREIGN KEY (`id_horario_fk`) REFERENCES `horarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `inscriptos_horarios` */

insert  into `inscriptos_horarios`(`id`,`id_inscripto_fk`,`id_horario_fk`) values (1380,243,119),(1381,243,120),(1382,243,128),(1383,243,131),(1384,243,132),(1385,243,136),(1386,243,139),(1387,243,140),(1388,243,144),(1389,243,147),(1390,243,148),(1391,243,152),(1392,243,155),(1393,243,156),(1394,243,160),(1395,243,164),(1420,245,128),(1421,245,144),(1422,245,160),(1423,246,171),(1424,246,135),(1425,246,143),(1426,246,157),(1427,246,158),(1428,246,162),(1429,246,163),(1430,246,164),(1583,259,135),(1584,259,136),(1585,259,144),(1586,259,151),(1587,259,152),(1588,259,160),(1589,259,161),(1590,259,162),(1591,259,163),(1592,259,164),(1593,260,169),(1594,260,170),(1595,260,171),(1596,260,126),(1597,260,127),(1598,260,128),(1599,260,151),(1600,260,152),(1601,260,157),(1602,260,158),(1603,260,159),(1604,260,160),(1605,260,161),(1606,260,162),(1607,260,163),(1608,260,164),(1658,265,158),(1659,265,159),(1660,265,160),(1661,265,162),(1662,265,163),(1663,265,164),(1664,266,169),(1665,266,170),(1666,266,171),(1667,266,120),(1668,266,125),(1669,266,126),(1670,266,132),(1671,266,133),(1672,266,134),(1673,266,140),(1674,266,141),(1675,266,142),(1676,266,148),(1677,266,149),(1678,266,150),(1679,266,163),(1680,266,164),(1719,271,132),(1720,271,138),(1721,271,148),(1722,271,158),(1723,271,162),(1724,271,163),(1784,276,165),(1785,276,166),(1786,276,167),(1787,276,168),(1788,276,169),(1789,276,170),(1790,276,171),(1791,276,119),(1792,276,120),(1793,276,127),(1794,276,128),(1795,276,131),(1796,276,132),(1797,276,135),(1798,276,136),(1799,276,139),(1800,276,140),(1801,276,143),(1802,276,144),(1803,276,147),(1804,276,148),(1805,276,151),(1806,276,152),(1807,276,155),(1808,276,156),(1809,276,159),(1810,276,160),(1811,276,161),(1812,276,162),(1813,276,163),(1814,276,164),(1892,282,166),(1893,282,125),(1894,282,141),(1895,282,149),(1896,282,157),(1897,282,162),(1913,284,127),(1914,284,128),(1915,284,143),(1916,284,144),(1917,284,159),(1918,284,160),(2070,297,166),(2071,297,126),(2072,297,127),(2073,297,134),(2074,297,135),(2075,297,142),(2076,297,146),(2077,297,150),(2078,297,154),(2079,297,158),(2102,299,133),(2103,299,134),(2104,299,135),(2105,299,136),(2106,299,141),(2107,299,142),(2108,299,143),(2109,299,144),(2110,299,157),(2111,299,158),(2112,299,159),(2113,299,160),(2163,305,165),(2164,305,166),(2165,305,167),(2166,305,168),(2167,305,169),(2168,305,170),(2169,305,171),(2170,305,119),(2171,305,127),(2172,305,128),(2173,305,131),(2174,305,135),(2175,305,136),(2176,305,139),(2177,305,143),(2178,305,144),(2179,305,147),(2180,305,155),(2181,305,159),(2182,305,160),(2183,305,163),(2184,305,164),(2251,309,170),(2252,309,119),(2253,309,131),(2254,309,147),(2255,309,155),(2268,311,171),(2269,311,128),(2270,311,136),(2271,311,144),(2272,311,152),(2273,311,160),(2398,320,166),(2399,320,126),(2400,320,134),(2401,320,142),(2402,320,150),(2403,320,158),(2404,320,163),(2427,323,168),(2428,323,169),(2429,323,170),(2430,323,171),(2431,323,128),(2432,323,134),(2433,323,135),(2434,323,136),(2435,323,144),(2436,323,150),(2437,323,151),(2438,323,152),(2439,323,159),(2440,323,160),(2441,323,163),(2442,323,164),(2453,325,167),(2454,325,168),(2455,325,169),(2456,325,161),(2457,325,162),(2458,325,163),(2459,325,164),(2477,327,129),(2478,327,130),(2479,327,133),(2480,327,134),(2481,327,135),(2482,327,136),(2483,327,137),(2484,327,138),(2485,327,139),(2486,327,140),(2487,327,141),(2488,327,142),(2489,327,143),(2490,327,144),(2491,327,153),(2492,327,154),(2493,327,155),(2494,327,156),(2495,327,157),(2496,327,158),(2497,327,159),(2498,327,161),(2499,327,162),(2500,327,163),(2501,327,164),(2530,331,131),(2531,331,132),(2532,331,147),(2533,331,148),(2534,331,162),(2535,331,163),(2536,331,164),(2596,335,165),(2597,335,166),(2598,335,167),(2599,335,168),(2600,335,169),(2601,335,170),(2602,335,171),(2603,335,125),(2604,335,126),(2605,335,127),(2606,335,128),(2607,335,136),(2608,335,144),(2609,335,152),(2610,335,157),(2611,335,158),(2612,335,159),(2613,335,160),(2614,273,120),(2615,273,127),(2616,273,128),(2617,273,132),(2618,273,140),(2619,273,143),(2620,273,144),(2621,273,148),(2622,273,156),(2623,273,159),(2624,273,160),(2646,337,165),(2647,337,166),(2648,337,167),(2649,337,168),(2650,337,169),(2651,337,170),(2652,337,171),(2653,337,126),(2654,337,127),(2655,337,134),(2656,337,135),(2657,337,142),(2658,337,143),(2659,337,150),(2660,337,151),(2661,337,158),(2662,337,159),(2663,338,127),(2664,338,128),(2665,338,135),(2666,338,143),(2667,338,151),(2668,338,159),(2669,338,163),(2670,338,164),(2731,340,165),(2732,340,166),(2733,340,170),(2734,340,171),(2735,340,125),(2736,340,126),(2737,340,133),(2738,340,134),(2739,340,141),(2740,340,142),(2741,340,149),(2742,340,150),(2743,340,157),(2744,340,158),(2745,340,161),(2746,340,162),(2747,340,163),(2748,340,164),(2786,345,142),(2787,345,150),(2788,345,158),(2789,346,124),(2790,346,130),(2791,346,138),(2792,346,146),(2793,346,154),(2794,346,162),(2808,312,120),(2809,312,125),(2810,312,128),(2811,312,132),(2812,312,133),(2813,312,135),(2814,312,136),(2815,312,142),(2816,312,143),(2817,312,144),(2818,312,148),(2819,312,149),(2820,312,151),(2821,312,152),(2822,312,153),(2823,312,154),(2824,312,164),(2853,249,125),(2854,249,126),(2855,249,133),(2856,249,134),(2857,249,149),(2858,249,150),(2859,249,156),(2860,249,157),(2861,249,158),(2862,249,162),(2863,249,163),(2864,349,159),(2865,349,160),(2866,349,161),(2867,349,162),(2868,349,163),(2869,349,164),(2923,342,129),(2924,342,131),(2925,342,137),(2926,342,145),(2927,342,147),(2928,342,153),(2929,342,155),(2930,342,162),(2964,274,131),(2965,274,132),(2966,274,149),(2967,274,150),(2968,274,155),(2969,274,156),(2970,274,157),(2971,274,158),(2972,355,125),(2973,355,126),(2974,355,127),(2975,355,128),(2976,355,133),(2977,355,134),(2978,355,135),(2979,355,136),(2980,355,141),(2981,355,142),(2982,355,143),(2983,355,144),(2984,355,149),(2985,355,150),(2986,355,151),(2987,355,152),(2988,355,157),(2989,355,158),(2990,355,159),(2991,355,160),(2992,356,126),(2993,356,127),(2994,356,128),(2995,356,141),(2996,356,142),(2997,356,143),(2998,356,144),(2999,356,158),(3000,356,159),(3001,356,160),(3002,357,170),(3003,357,171),(3004,357,128),(3005,357,136),(3006,357,142),(3007,357,143),(3008,357,144),(3009,357,152),(3010,358,166),(3011,358,134),(3012,358,135),(3013,358,155),(3014,358,156),(3015,358,159),(3055,350,119),(3056,350,120),(3057,350,139),(3058,350,140),(3059,350,155),(3060,350,156),(3078,361,165),(3079,361,166),(3080,361,125),(3081,361,126),(3082,361,133),(3083,361,134),(3084,361,135),(3085,361,141),(3086,361,142),(3087,361,143),(3088,361,149),(3089,361,150),(3090,361,151),(3091,361,157),(3092,361,158),(3196,363,169),(3197,363,170),(3198,363,133),(3199,363,134),(3200,363,149),(3201,363,150),(3202,363,157),(3203,363,158),(3204,363,159),(3276,344,136),(3277,344,152),(3278,344,164),(3306,339,165),(3307,339,166),(3308,339,167),(3309,339,168),(3310,339,169),(3311,339,170),(3312,339,171),(3313,339,135),(3314,339,160),(3315,339,162),(3316,339,163),(3317,339,164),(3336,348,152),(3337,348,163),(3338,348,164),(3339,329,136),(3340,329,144),(3341,329,152),(3342,329,163),(3343,329,164),(3344,334,125),(3345,334,126),(3346,334,127),(3347,334,128),(3348,334,133),(3349,334,134),(3350,334,135),(3351,334,136),(3352,334,141),(3353,334,142),(3354,334,143),(3355,334,144),(3356,334,149),(3357,334,150),(3358,334,151),(3359,334,152),(3360,334,157),(3361,334,158),(3362,334,159),(3363,334,160),(3364,328,166),(3365,328,167),(3366,328,168),(3367,328,169),(3368,328,170),(3369,328,128),(3370,328,136),(3371,328,144),(3372,328,152),(3373,328,160),(3374,310,169),(3375,310,170),(3376,310,133),(3377,310,134),(3378,310,149),(3379,310,150),(3380,310,157),(3381,310,158),(3382,310,159),(3383,302,166),(3384,302,134),(3385,302,151),(3386,289,127),(3387,289,128),(3388,289,143),(3389,289,144),(3390,289,151),(3391,289,152),(3392,289,156),(3393,289,157),(3394,289,158),(3395,289,159),(3396,289,160),(3397,283,119),(3398,283,120),(3399,283,125),(3400,283,131),(3401,283,132),(3402,283,133),(3403,283,139),(3404,283,140),(3405,283,141),(3406,283,147),(3407,283,148),(3408,283,149),(3409,280,136),(3410,280,144),(3411,280,152),(3412,280,159),(3413,280,160),(3414,269,170),(3415,269,126),(3416,269,127),(3417,269,133),(3418,269,134),(3419,269,142),(3420,269,149),(3421,269,150),(3422,269,158),(3423,268,166),(3424,268,167),(3425,268,168),(3426,268,169),(3427,268,119),(3428,268,120),(3429,268,139),(3430,268,140),(3431,268,141),(3432,268,147),(3433,268,148),(3434,268,155),(3435,268,156),(3436,268,157),(3437,262,165),(3438,262,119),(3439,262,120),(3440,262,131),(3441,262,132),(3442,262,133),(3443,262,134),(3444,262,139),(3445,262,140),(3446,262,147),(3447,262,148),(3448,261,134),(3449,261,135),(3450,261,150),(3451,261,151),(3452,261,158),(3453,261,159),(3454,255,165),(3455,255,128),(3456,255,135),(3457,255,143),(3458,255,152),(3459,255,160),(3460,252,127),(3461,252,143),(3462,252,159),(3463,362,166),(3464,362,170),(3465,362,171),(3466,362,125),(3467,362,127),(3468,362,135),(3469,362,136),(3470,362,140),(3471,362,141),(3472,362,142),(3473,362,143),(3474,362,144),(3475,362,148),(3476,362,156),(3477,359,167),(3478,359,168),(3479,359,169),(3480,359,170),(3481,359,171),(3482,359,126),(3483,359,140),(3484,359,141),(3485,359,142),(3486,359,156),(3487,359,157),(3488,359,158),(3489,354,120),(3490,354,132),(3491,354,140),(3492,354,148),(3493,354,156),(3494,343,132),(3495,343,140),(3496,343,148),(3497,343,156),(3498,336,127),(3499,336,150),(3500,336,151),(3501,336,158),(3502,336,159),(3503,316,126),(3504,316,127),(3505,316,134),(3506,316,135),(3507,316,142),(3508,316,143),(3509,316,157),(3510,316,158),(3511,316,159),(3512,315,119),(3513,315,120),(3514,315,125),(3515,315,126),(3516,315,129),(3517,315,130),(3518,315,131),(3519,315,132),(3520,315,133),(3521,315,134),(3522,315,137),(3523,315,138),(3524,315,139),(3525,315,140),(3526,315,141),(3527,315,142),(3528,315,145),(3529,315,146),(3530,315,147),(3531,315,148),(3532,315,149),(3533,315,150),(3534,315,153),(3535,315,154),(3536,315,155),(3537,315,156),(3538,315,157),(3539,315,158),(3540,308,166),(3541,308,170),(3542,308,124),(3543,308,119),(3544,308,120),(3545,308,125),(3546,308,130),(3547,308,131),(3548,308,132),(3549,308,133),(3550,308,146),(3551,308,147),(3552,308,148),(3553,308,149),(3554,308,155),(3555,308,156),(3556,308,157),(3557,304,134),(3558,304,135),(3559,304,142),(3560,304,143),(3561,304,150),(3562,304,151),(3563,304,158),(3564,304,159),(3572,300,165),(3573,300,166),(3574,300,167),(3575,300,168),(3576,300,169),(3577,300,170),(3578,300,171),(3579,300,128),(3580,300,136),(3581,300,144),(3582,300,152),(3583,300,160),(3584,290,126),(3585,290,127),(3586,290,128),(3587,290,134),(3588,290,135),(3589,290,136),(3590,290,142),(3591,290,143),(3592,290,144),(3593,290,150),(3594,290,151),(3595,290,152),(3596,290,158),(3597,290,159),(3598,290,160),(3599,285,124),(3600,285,119),(3601,285,120),(3602,285,129),(3603,285,130),(3604,285,131),(3605,285,137),(3606,285,138),(3607,285,139),(3608,285,140),(3609,285,145),(3610,285,146),(3611,285,147),(3612,285,148),(3613,285,153),(3614,285,154),(3615,285,155),(3616,279,170),(3617,279,171),(3618,279,126),(3619,279,127),(3620,279,142),(3621,279,143),(3622,279,149),(3623,279,150),(3624,279,158),(3625,279,159),(3626,275,167),(3627,275,168),(3628,275,130),(3629,275,131),(3630,275,132),(3631,275,136),(3632,275,138),(3633,275,139),(3634,275,140),(3635,275,143),(3636,275,144),(3637,275,147),(3638,275,148),(3639,275,149),(3640,275,150),(3641,275,151),(3642,275,152),(3643,275,154),(3644,275,155),(3645,275,156),(3646,275,157),(3647,275,158),(3648,263,165),(3649,263,166),(3650,263,167),(3651,263,168),(3652,263,169),(3653,263,170),(3654,263,171),(3655,263,134),(3656,263,135),(3657,263,136),(3658,263,143),(3659,263,144),(3660,263,151),(3661,263,152),(3662,263,158),(3663,263,159),(3664,263,160),(3665,256,169),(3666,256,170),(3667,256,171),(3668,256,124),(3669,256,146),(3670,256,150),(3671,256,154),(3672,256,158),(3673,247,167),(3674,247,168),(3675,247,169),(3676,247,170),(3677,247,171),(3678,247,126),(3679,247,128),(3680,247,134),(3681,247,136),(3682,247,142),(3683,247,144),(3684,247,150),(3685,247,152),(3686,247,159),(3687,247,160),(3688,352,126),(3689,352,127),(3690,352,134),(3691,352,135),(3692,352,142),(3693,352,143),(3694,352,150),(3695,352,151),(3696,352,158),(3697,352,159),(3698,332,127),(3699,332,128),(3700,332,135),(3701,332,136),(3702,332,143),(3703,332,144),(3704,332,151),(3705,332,152),(3706,332,159),(3707,332,160),(3708,326,126),(3709,326,127),(3710,326,128),(3711,326,134),(3712,326,135),(3713,326,136),(3714,326,142),(3715,326,143),(3716,326,144),(3717,326,150),(3718,326,151),(3719,326,152),(3720,326,158),(3721,326,159),(3722,326,160),(3723,322,120),(3724,322,125),(3725,322,140),(3726,322,141),(3727,322,156),(3728,322,157),(3729,317,169),(3730,317,170),(3731,317,127),(3732,317,128),(3733,317,134),(3734,317,135),(3735,317,143),(3736,317,144),(3737,317,150),(3738,317,151),(3739,317,159),(3740,317,160),(3741,301,169),(3742,301,170),(3743,301,128),(3744,301,135),(3745,301,144),(3746,301,147),(3747,301,159),(3748,292,128),(3749,292,136),(3750,292,144),(3751,292,152),(3752,292,160),(3753,291,125),(3754,291,126),(3755,291,127),(3756,291,133),(3757,291,134),(3758,291,135),(3759,291,141),(3760,291,142),(3761,291,143),(3762,291,149),(3763,291,150),(3764,291,151),(3765,291,157),(3766,291,158),(3767,291,159),(3768,287,126),(3769,287,127),(3770,287,128),(3771,287,133),(3772,287,134),(3773,287,135),(3774,287,141),(3775,287,142),(3776,287,143),(3777,287,150),(3778,287,151),(3779,287,152),(3780,287,157),(3781,287,158),(3782,288,142),(3783,288,143),(3784,288,144),(3785,288,150),(3786,288,151),(3787,288,152),(3788,288,158),(3789,288,159),(3790,288,160),(3791,351,165),(3792,351,166),(3793,351,167),(3794,351,168),(3795,351,169),(3796,351,170),(3797,351,171),(3798,351,127),(3799,351,128),(3800,351,135),(3801,351,136),(3802,351,143),(3803,351,144),(3804,351,151),(3805,351,152),(3806,351,159),(3807,351,160),(3808,333,169),(3809,333,170),(3810,333,127),(3811,333,128),(3812,333,135),(3813,333,136),(3814,333,151),(3815,333,152),(3816,333,159),(3817,333,160),(3818,330,126),(3819,330,134),(3820,330,135),(3821,330,136),(3822,330,150),(3823,330,158),(3824,330,159),(3825,324,169),(3826,324,170),(3827,324,135),(3828,324,142),(3829,324,143),(3830,324,158),(3831,324,159),(3832,324,160),(3833,318,120),(3834,318,125),(3835,318,132),(3836,318,133),(3837,318,140),(3838,318,141),(3839,318,148),(3840,318,149),(3841,318,156),(3842,318,157),(3843,313,120),(3844,313,125),(3845,313,132),(3846,313,133),(3847,313,140),(3848,313,141),(3849,313,142),(3850,313,148),(3851,313,149),(3852,313,156),(3853,313,157),(3854,313,158),(3855,286,171),(3856,286,125),(3857,286,126),(3858,286,127),(3859,286,133),(3860,286,134),(3861,286,135),(3862,286,141),(3863,286,142),(3864,286,143),(3865,286,149),(3866,286,150),(3867,286,151),(3868,286,157),(3869,286,158),(3870,286,159),(3871,281,166),(3872,281,167),(3873,281,168),(3874,281,169),(3875,281,170),(3876,281,171),(3877,281,134),(3878,281,135),(3879,281,136),(3880,281,142),(3881,281,143),(3882,281,144),(3883,281,150),(3884,281,151),(3885,281,152),(3886,281,158),(3887,281,159),(3888,281,160),(3889,278,134),(3890,278,135),(3891,278,136),(3892,278,142),(3893,278,143),(3894,278,144),(3895,278,150),(3896,278,151),(3897,278,152),(3898,277,119),(3899,277,120),(3900,277,126),(3901,277,141),(3902,277,144),(3903,277,148),(3904,277,149),(3905,277,151),(3906,277,152),(3907,277,156),(3908,277,157),(3909,277,158),(3910,277,159),(3911,277,160),(3912,242,127),(3913,242,128),(3914,242,135),(3915,242,136),(3916,242,142),(3917,242,143),(3918,242,151),(3919,242,152),(3920,242,159),(3921,242,160),(3922,264,126),(3923,264,127),(3924,264,128),(3925,264,142),(3926,264,143),(3927,264,144),(3928,264,150),(3929,264,151),(3930,264,152),(3931,264,158),(3932,264,159),(3933,264,160),(3934,272,131),(3935,272,134),(3936,272,139),(3937,272,142),(3938,272,157),(3939,272,158),(3940,254,126),(3941,254,127),(3942,254,128),(3943,254,134),(3944,254,135),(3945,254,136),(3946,254,142),(3947,254,143),(3948,254,144),(3949,254,150),(3950,254,151),(3951,254,152),(3952,254,158),(3953,254,159),(3954,254,160),(3955,307,165),(3956,307,169),(3957,307,170),(3958,307,120),(3959,307,125),(3960,307,126),(3961,307,132),(3962,307,133),(3963,307,134),(3964,307,140),(3965,307,141),(3966,307,142),(3967,307,148),(3968,307,149),(3969,307,150),(3970,307,156),(3971,307,157),(3972,307,158),(3973,296,165),(3974,296,142),(3975,296,143),(3976,296,144),(3977,296,158),(3978,270,128),(3979,270,136),(3980,270,144),(3981,270,152),(3982,270,160),(3983,353,171),(3984,353,119),(3985,353,131),(3986,353,136),(3987,353,139),(3988,353,152),(3989,353,159),(3990,353,160),(3991,347,127),(3992,347,128),(3993,347,135),(3994,347,143),(3995,347,151),(3996,341,123),(3997,341,120),(3998,341,125),(3999,341,126),(4000,341,131),(4001,341,132),(4002,341,133),(4003,341,137),(4004,341,139),(4005,341,140),(4006,341,141),(4007,341,145),(4008,341,148),(4009,341,149),(4010,341,155),(4011,341,156),(4012,341,157),(4013,321,167),(4014,321,168),(4015,321,169),(4016,321,127),(4017,321,128),(4018,321,135),(4019,321,136),(4020,321,143),(4021,321,144),(4022,321,151),(4023,321,152),(4024,321,160),(4025,314,167),(4026,314,168),(4027,314,169),(4028,314,170),(4029,314,125),(4030,314,126),(4031,314,133),(4032,314,134),(4033,314,141),(4034,314,142),(4035,314,150),(4036,314,151),(4037,314,158),(4038,314,159),(4039,306,165),(4040,306,166),(4041,306,167),(4042,306,171),(4043,306,125),(4044,306,126),(4045,306,127),(4046,306,128),(4047,306,141),(4048,306,142),(4049,306,143),(4050,306,144),(4051,306,159),(4052,306,160),(4053,294,120),(4054,294,125),(4055,294,132),(4056,294,133),(4057,294,140),(4058,294,141),(4059,294,148),(4060,294,149),(4061,294,156),(4062,294,157),(4063,293,126),(4064,293,127),(4065,293,128),(4066,293,136),(4067,293,141),(4068,293,142),(4069,293,143),(4070,293,144),(4071,293,152),(4072,293,157),(4073,293,158),(4074,258,134),(4075,258,135),(4076,258,150),(4077,258,151),(4078,258,158),(4079,251,165),(4080,251,166),(4081,251,167),(4082,251,168),(4083,251,169),(4084,251,170),(4085,251,171),(4086,251,126),(4087,251,127),(4088,251,128),(4089,251,134),(4090,251,135),(4091,251,136),(4092,251,142),(4093,251,143),(4094,251,144),(4095,251,150),(4096,251,151),(4097,251,152),(4098,251,158),(4099,251,159),(4100,251,160),(4101,248,169),(4102,248,170),(4103,248,119),(4104,248,120),(4105,248,125),(4106,248,126),(4107,248,131),(4108,248,132),(4109,248,133),(4110,248,134),(4111,248,139),(4112,248,140),(4113,248,141),(4114,248,142),(4115,248,147),(4116,248,148),(4117,248,149),(4118,248,150),(4119,248,155),(4120,248,156),(4121,248,157),(4122,248,158),(4123,244,125),(4124,244,126),(4125,244,127),(4126,244,128),(4127,244,133),(4128,244,134),(4129,244,135),(4130,244,136),(4131,244,141),(4132,244,142),(4133,244,143),(4134,244,144),(4135,244,149),(4136,244,150),(4137,244,151),(4138,244,152),(4139,244,157),(4140,244,158),(4141,244,159),(4142,244,160),(4143,303,166),(4144,303,169),(4145,303,170),(4146,303,171),(4147,303,126),(4148,303,134),(4149,303,159);

/*Table structure for table `llave_avance` */

DROP TABLE IF EXISTS `llave_avance`;

CREATE TABLE `llave_avance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_llave_origen` int NOT NULL,
  `id_llave_destino` int NOT NULL,
  `slot_destino` tinyint NOT NULL COMMENT '1=id_inscripto_1, 2=id_inscripto_2',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_origen_unico` (`id_llave_origen`),
  UNIQUE KEY `uq_destino_slot` (`id_llave_destino`,`slot_destino`),
  CONSTRAINT `fk_llave_avance_destino` FOREIGN KEY (`id_llave_destino`) REFERENCES `llave_eliminacion` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_llave_avance_origen` FOREIGN KEY (`id_llave_origen`) REFERENCES `llave_eliminacion` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_slot_destino` CHECK ((`slot_destino` in (1,2)))
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `llave_avance` */

/*Table structure for table `llave_eliminacion` */

DROP TABLE IF EXISTS `llave_eliminacion`;

CREATE TABLE `llave_eliminacion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_torneo` int NOT NULL,
  `categoria` varchar(50) NOT NULL COMMENT 'Categoría del torneo',
  `ronda` varchar(20) NOT NULL COMMENT 'dieciseisavos, octavos, cuartos, semifinal, final',
  `posicion` int NOT NULL COMMENT 'Posición en el bracket (1 a N)',
  `id_partido` int DEFAULT NULL,
  `id_inscripto_1` int DEFAULT NULL,
  `id_inscripto_2` int DEFAULT NULL,
  `id_grupo_1` int DEFAULT NULL COMMENT 'Para evitar cruces del mismo grupo',
  `id_grupo_2` int DEFAULT NULL,
  `ganador_id` int DEFAULT NULL,
  `es_bye` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_torneo_categoria` (`id_torneo`,`categoria`),
  KEY `idx_ronda` (`ronda`),
  KEY `idx_partido` (`id_partido`),
  KEY `fk_llave_inscripto_1` (`id_inscripto_1`),
  KEY `fk_llave_inscripto_2` (`id_inscripto_2`),
  KEY `fk_llave_ganador` (`ganador_id`),
  KEY `fk_llave_grupo_1` (`id_grupo_1`),
  KEY `fk_llave_grupo_2` (`id_grupo_2`),
  CONSTRAINT `fk_llave_ganador` FOREIGN KEY (`ganador_id`) REFERENCES `inscriptos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_llave_grupo_1` FOREIGN KEY (`id_grupo_1`) REFERENCES `grupos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_llave_grupo_2` FOREIGN KEY (`id_grupo_2`) REFERENCES `grupos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_llave_inscripto_1` FOREIGN KEY (`id_inscripto_1`) REFERENCES `inscriptos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_llave_inscripto_2` FOREIGN KEY (`id_inscripto_2`) REFERENCES `inscriptos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_llave_partido` FOREIGN KEY (`id_partido`) REFERENCES `partido` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_llave_torneo` FOREIGN KEY (`id_torneo`) REFERENCES `torneos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Estructura de la llave de eliminación';

/*Data for the table `llave_eliminacion` */

/*Table structure for table `partido` */

DROP TABLE IF EXISTS `partido`;

CREATE TABLE `partido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_horario` int DEFAULT NULL,
  `id_inscriptoL` int NOT NULL,
  `id_inscriptov` int NOT NULL,
  `estado` enum('pendiente','jugado','wo_local','wo_visitante','suspendido') DEFAULT 'pendiente',
  `ganador_id` int DEFAULT NULL,
  `sets_local` int DEFAULT '0',
  `sets_visitante` int DEFAULT '0',
  `games_local` int DEFAULT '0',
  `games_visitante` int DEFAULT '0',
  `tiebreak_local` int DEFAULT NULL,
  `tiebreak_visitante` int DEFAULT NULL,
  `es_bye` tinyint(1) DEFAULT '0',
  `ronda` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_horario` (`id_horario`),
  KEY `id_inscriptoL` (`id_inscriptoL`),
  KEY `id_inscriptov` (`id_inscriptov`),
  KEY `fk_partido_ganador` (`ganador_id`),
  CONSTRAINT `fk_partido_ganador` FOREIGN KEY (`ganador_id`) REFERENCES `inscriptos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `partido_ibfk_1` FOREIGN KEY (`id_horario`) REFERENCES `horarios` (`id`),
  CONSTRAINT `partido_ibfk_2` FOREIGN KEY (`id_inscriptoL`) REFERENCES `inscriptos` (`id`),
  CONSTRAINT `partido_ibfk_3` FOREIGN KEY (`id_inscriptov`) REFERENCES `inscriptos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=527 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `partido` */

insert  into `partido`(`id`,`id_horario`,`id_inscriptoL`,`id_inscriptov`,`estado`,`ganador_id`,`sets_local`,`sets_visitante`,`games_local`,`games_visitante`,`tiebreak_local`,`tiebreak_visitante`,`es_bye`,`ronda`) values (401,140,354,319,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(402,156,343,319,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(403,155,345,350,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(404,152,353,347,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(405,120,322,309,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(406,144,322,245,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(407,160,309,245,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(408,141,355,346,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(409,163,266,346,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(411,135,267,302,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(412,159,267,252,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(413,151,302,252,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(414,127,303,336,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(415,144,311,296,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(416,136,270,296,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(417,139,272,350,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(418,158,258,265,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(419,154,312,346,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(421,148,271,282,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(422,150,256,336,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(423,135,324,358,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(424,158,272,345,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(425,159,314,265,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(426,128,357,347,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(427,128,301,292,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(428,152,344,348,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(429,157,246,282,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(430,160,280,255,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(431,150,274,261,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(432,156,308,359,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(433,134,297,363,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(434,159,256,303,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(435,159,324,330,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(436,151,330,358,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(437,136,357,353,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(438,144,301,284,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(439,160,284,292,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(440,135,339,338,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(441,159,349,338,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(442,136,329,344,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(443,164,329,348,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(446,164,246,271,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(447,157,289,310,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(448,152,328,255,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(449,158,269,274,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(450,134,269,261,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(451,132,354,343,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(452,151,277,242,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(453,151,333,278,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(454,134,314,258,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(455,163,339,349,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(457,136,328,280,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(458,125,308,362,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(459,126,279,297,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(460,149,279,363,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(461,127,273,242,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(462,135,259,333,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(463,144,259,278,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(464,128,311,270,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(465,151,332,352,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(466,126,249,260,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(467,140,362,359,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(468,142,316,304,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(469,142,361,264,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(470,156,277,273,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(471,128,306,321,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(472,144,293,321,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(473,143,299,317,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(474,127,356,317,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(475,143,332,288,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(476,159,288,352,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(477,119,268,262,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(478,159,306,293,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(479,160,299,356,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(480,155,243,327,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(481,133,334,310,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(482,141,268,283,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(483,126,290,316,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(484,150,290,304,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(485,127,286,264,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(486,125,355,266,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(487,148,312,266,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(488,130,285,275,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(489,139,305,327,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(490,157,340,260,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(491,147,283,262,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(492,152,247,300,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(493,128,351,254,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(494,120,307,318,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(495,132,313,318,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(496,142,337,244,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(497,120,248,294,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(498,133,341,294,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(499,135,291,326,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(500,119,305,243,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(502,149,340,249,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(503,143,334,289,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(504,144,263,247,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(505,160,263,300,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(506,151,287,326,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(507,133,355,312,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(508,152,281,254,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(509,140,307,313,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(510,141,291,287,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(511,149,286,361,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(512,135,276,327,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(513,136,281,351,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(514,148,248,341,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(515,138,315,275,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(516,127,251,244,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(517,145,315,285,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(518,147,276,243,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(519,151,251,337,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(520,155,276,305,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(521,164,325,331,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(522,162,325,342,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(523,131,342,331,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(524,128,335,323,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(525,158,335,320,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL),(526,163,320,323,'pendiente',NULL,0,0,0,0,NULL,NULL,0,NULL);

/*Table structure for table `torneos` */

DROP TABLE IF EXISTS `torneos`;

CREATE TABLE `torneos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo_torneo` varchar(50) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `activo_inscripcion` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_torneo` (`codigo_torneo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

/*Data for the table `torneos` */

insert  into `torneos`(`id`,`codigo_torneo`,`nombre`,`fecha_inicio`,`fecha_fin`,`activo_inscripcion`) values (4,'Torneo-Dobles','Torneo dobles DAMAS/CABALLEROS','2026-05-04','2026-05-10',1);

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `pass` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tipousuario` int DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `usuario` */

insert  into `usuario`(`id`,`nombre`,`pass`,`tipousuario`,`activo`) values (3,'Pablobun','$2b$10$84cDr9fPo5VDOnJeKSheIu29XS.MEHCd.B4v1M/wd8Y7WyH5FUZq6',1,1),(4,'Leo','$2b$10$a8Q/rfb8pfpfEnB.4HHkFejU5NJSLywmmoQLBY.kVGvS.kU7IfKsy',2,1),(5,'Charly','$2b$10$a8Q/rfb8pfpfEnB.4HHkFejU5NJSLywmmoQLBY.kVGvS.kU7IfKsy',2,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
