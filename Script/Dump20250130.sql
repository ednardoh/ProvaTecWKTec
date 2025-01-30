-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: bdpedido
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `Codigo` varchar(10) NOT NULL,
  `Nome` varchar(100) DEFAULT NULL,
  `Cidade` varchar(60) DEFAULT NULL,
  `UF` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`Codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES ('1','ERIALDO DA SILVA DOS ANJOS','MARACANAU','CE'),('10','ISAIAS DA SILVA HONORATO','MARACANAU','CE'),('11','MARIA JOSE DA SILVA LOBATO','MARACANAU','CE'),('12','ADRIANA DA SILVA LUIZ','MARACANAU','CE'),('13','ADRIANA SILVA DO CANTO GRACIANO','MARACANAU','CE'),('14','ADRIANO DA SILVA M.','MARACANAU','CE'),('15','ADRIANO DA SILVA DOS SANTOS','MARACANAU','CE'),('16','ALAOR SILVA ROLDAO','MARACANAU','CE'),('17','ALBERTO DA SILVA PATRICIO','MARACANAU','CE'),('18','ALCIDES DA SILVA NUNES','MARACANAU','CE'),('19','ALDA MARIA DA SILVA TEXEIRA','MARACANAU','CE'),('2','MARIA DO ROSARIO','MARACANAU','CE'),('20','ALESSANDRA DA SILVA GOUDINHO','MARACANAU','CE'),('21','ALESSANDRA DA SILVA LEITE','MARACANAU','CE'),('22','AIUMY DA SILVA FERREIRA','MARACANAU','CE'),('3','NERIVAN DA SILVA SOUZA','MARACANAU','CE'),('4','ERIVALDO DA SILVA GARCIA','MARACANAU','CE'),('5','JOSE DE ABREU E SILVA','MARACANAU','CE'),('6','JOSE ANTONIO ARCARENHA','MARACANAU','CE'),('7','ARNALDO DOS ANJOS SERPA','MARACANAU','CE'),('8','ANDRO SILVA LEVI JUSTUS','MARACANAU','CE'),('9','MARIA DA CUNHA E SILVA','MARACANAU','CE');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_produtos`
--

DROP TABLE IF EXISTS `pedido_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numpedido` int DEFAULT NULL,
  `codigo_produto` varchar(13) DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  `vlr_unitario` double DEFAULT NULL,
  `vlr_total` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `numpedido_idx` (`numpedido`),
  KEY `codigo_idx` (`codigo_produto`),
  CONSTRAINT `codigofk` FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`),
  CONSTRAINT `numpedidofk` FOREIGN KEY (`numpedido`) REFERENCES `pedidos` (`numpedido`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_produtos`
--

LOCK TABLES `pedido_produtos` WRITE;
/*!40000 ALTER TABLE `pedido_produtos` DISABLE KEYS */;
INSERT INTO `pedido_produtos` VALUES (1,1,'0000000000004',2,27.9,55.8),(2,1,'0000000000004',3,27.9,83.69999999999999),(3,1,'0000000000010',1,27.9,27.9),(4,2,'0000000000007',3,25.9,77.7),(5,2,'0000000000011',2,27.9,55.8),(6,2,'0000000000010',2,27.9,55.8),(7,2,'0000000000013',3,29.9,89.7),(8,2,'0000000000049',3,51.9,155.7),(9,3,'0000000000033',5,29.9,149.5),(10,3,'0000000000003',3,26.9,80.69999999999999),(11,3,'0000000000009',2,25.9,51.8),(12,3,'0000000000011',4,27.9,111.6),(13,4,'0000000000001',5,9.8,49),(14,4,'0000000000004',3,27.9,83.7),(15,4,'0000000000005',3,31.9,95.7),(16,4,'0000000000013',1,29.9,29.9),(17,5,'0000000000003',1,26.9,26.9),(18,5,'0000000000005',5,31.9,159.5),(19,5,'0000000000009',1,25.9,25.9),(20,5,'0000000000012',1,23.9,23.9);
/*!40000 ALTER TABLE `pedido_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `numpedido` int NOT NULL AUTO_INCREMENT,
  `data_emissao` datetime DEFAULT NULL,
  `codigo_cliente` varchar(10) DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  PRIMARY KEY (`numpedido`),
  KEY `codigo_idx` (`codigo_cliente`),
  CONSTRAINT `codigo` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`Codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'2025-01-30 00:00:00','12',167.4),(2,'2025-01-30 00:00:00','16',434.7),(3,'2025-01-30 00:00:00','15',393.6),(4,'2025-01-30 00:00:00','19',258.3),(5,'2025-01-30 00:00:00','15',236.2);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `codigo` varchar(13) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `preco_venda` double DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES ('0000000000001','BLUSA BIONCE',9.8),('0000000000002','BOTAO BAXMANLOX',0.12),('0000000000003','T-SHIRT BIANCA',26.9),('0000000000004','BLUSA ARIA',27.9),('0000000000005','BLUSA BLANDE',31.9),('0000000000006','BLUSA GLORIA',27.9),('0000000000007','REGATA PITTI',25.9),('0000000000008','BLUSA TAYLOR',0),('0000000000009','BLUSA SARAH',25.9),('0000000000010','BLUSA SABRINA',27.9),('0000000000011','BLUSA LOLA   ',27.9),('0000000000012','REGATA NINA',23.9),('0000000000013','BLUSA MILEY',29.9),('0000000000014','T-SHIRT LAURA',29.9),('0000000000015','T-SHIRT PRISCILA',28.9),('0000000000016','T-SHIRT PAMELA',23.9),('0000000000017','BLUSA KATY',29.9),('0000000000018','BLUSA DIVA',26.9),('0000000000019','BLUSA RAQUEL',27.9),('0000000000020','CAMISA XADREZ',34.9),('0000000000021','CAMISA YOCASTA',39.9),('0000000000022','VESTIDO LETICIA',36.9),('0000000000023','BLUSA LOLITA',27.9),('0000000000024','REGATA JHENIFFER',24.9),('0000000000025','BLUSA BEATRIZ',25.9),('0000000000026','CASACO ARIELLE',37.9),('0000000000027','MOLETOM BRITNEY',49.9),('0000000000028','CAMISA FABIOLA',42.9),('0000000000029','REGATA JAQUE',26.9),('0000000000030','BLUSA LARA',29.9),('0000000000031','BLUSA KATIA',29.9),('0000000000032','MOLETOM TWICE',35.9),('0000000000033','T-SHIRT ASHLEY',29.9),('0000000000034','T-SHIRT FUN',27.9),('0000000000035','CAMISA XADREZ CHARLOTTE',39.9),('0000000000036','BLUSA SHAY',27.9),('0000000000037','BLUSA HALEN',23.9),('0000000000038','BLUSA JOANA',25.9),('0000000000039','T-SHIRT SUE',26.9),('0000000000040','BOLERO JULIA',31.9),('0000000000041','BLUSA ERIKA',24.9),('0000000000042','REGATA MICHELLY',26.9),('0000000000043','BLUSA MANU',24.9),('0000000000044','SAIA BIANCA',29.9),('0000000000045','BLUSA BRUNA',27.9),('0000000000046','REGATA ORANGE',25.9),('0000000000047','VESTIDO THATY',39.9),('0000000000048','VESTIDO PIQUE JODIE',35.9),('0000000000049','MOLETOM CRISTINA',51.9),('0000000000050','CALÇA MOLETOM TRACY',37.9),('0000000000051','COLETE MOLETOM SASHA',34.9),('0000000000052','CAMISA PENELOPPE',37.9),('0000000000053','REGATA CELINA',27.9),('0000000000054','BLUSA SILVIA',25.9),('0000000000055','T-SHIRT LADY',27.9),('0000000000056','MOLETOM DUDA',39.9),('0000000000057','POLO MELISSA',26.9),('0000000000058','CAMISA SOPHIA',39.9),('0000000000059','BLAZER KIM',50.9),('0000000000060','CALCA TRENTINI',55.9),('0000000000061','SHORT TRENTINI',21.38),('0000000000062','SHORT NASH',39.9),('0000000000063','CALCA  NASH',49.9),('0000000000064','SHORT KIM',35.9),('0000000000065','SHORT PT MAYER',49.9),('0000000000066','MINI SAIA BELLATRIX BLACK',35.9),('0000000000067','SHORT ATIK',20.39),('0000000000068','SHORT SPEARS',23.57),('0000000000069','CALCA  CASPIO',49.9),('0000000000070','JEGGING',39.9),('0000000000071','CALCA  ZETTA',49.9),('0000000000072','SHORT PT',21.71),('0000000000073','CALCA PT HAITI',63.9),('0000000000074','SHORT PIGMENTHAY',48.9),('0000000000075','BLAZER PT MAYER',48.9),('0000000000076','BLAZER SPEARS',69.9),('0000000000077','PARKA DERECK',69.9),('0000000000078','BATA NINA',35.9),('0000000000079','BATA MAJORIE',23.9),('0000000000080','VESTIDO PIPOCA STACY',44.9),('0000000000081','CAMISETE LESIE KALY',35.9),('0000000000082','SOPREPOSIÇÃO POÁ REGATA',49.9),('0000000000083','VESTIDO FLORAL ANNABEL ',36.9),('0000000000084','SAIA SABIK',59.9),('0000000000085','SHORT BOYFRIEND',39.9),('0000000000086','MACAQUINHO',49.9),('0000000000087','BLUSA SHAYDY',25.9),('0000000000088','CHAPEU XADREZ AZUL',0),('0000000000089','CHAPEU XADREZ PRETO',0),('0000000000090','CHAPEU XADREZ ROSA',0),('0000000000091','CHAPEU PRETO FAIXA RENDA',0),('0000000000092','CHAPEU RISCA DE GIZ',0.54),('0000000000093','CHAPEU PALHA FLORAL',0),('0000000000094','CHAPEU PALHA XADREZ',0),('0000000000095','CHAPEU PALHA POA',0),('0000000000096','CHAPEU PALHA AZUL',0),('0000000000097','GORRO',10.9),('0000000000098','BOINA',12.9),('0000000000099','CACHECOL',10.9),('0000000000100','POLO PIQUE',19.9);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bdpedido'
--

--
-- Dumping routines for database 'bdpedido'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-30  6:50:40
