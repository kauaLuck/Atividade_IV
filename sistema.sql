CREATE DATABASE  IF NOT EXISTS `sistema_aluguel_veiculos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sistema_aluguel_veiculos`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema_aluguel_veiculos
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id_categoria` int NOT NULL AUTO_INCREMENT,
  `nome_categoria` varchar(100) NOT NULL,
  `descricao` varchar(200) NOT NULL,
  `valor_diaria` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nome_categoria` (`nome_categoria`),
  CONSTRAINT `categorias_chk_1` CHECK ((`valor_diaria` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Econômico','Veículos hatches com motor 1.0, ar-condicionado e direção hidráulica.',110.00),(2,'SUV','Utilitários esportivos com alto espaço interno e câmbio automático.',230.00),(3,'Executivo','Sedans de luxo com bancos em couro e motorização turbo.',380.00),(4,'Utilitário','Veículos comerciais para transporte de cargas e mercadorias.',290.00),(5,'Compacto','Veículos intermediários ideais para viagens curtas.',150.00);
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nome_cliente` varchar(100) NOT NULL,
  `cpf` char(11) NOT NULL,
  `cnh` varchar(20) NOT NULL,
  `categoria_cnh` varchar(5) NOT NULL,
  `data_nascimento` date NOT NULL,
  `telefone` char(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `logradouro` varchar(100) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `bairro` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `estado` char(2) NOT NULL,
  `cep` varchar(10) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `cnh` (`cnh`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Roberto Alencar','11122233344','CNH12345678','B','1988-03-15','(11) 98888-1111','roberto.a@gmail.com','Rua das Flores','100','Centro','São Paulo','SP','01001-000'),(2,'Ana Maria Silva','22233344455','CNH23456789','B','1992-07-22','(11) 99999-3333','ana.silva@hotmail.com','Av. Paulista','1500','Bela Vista','São Paulo','SP','01310-200'),(3,'Marcos Oliveira','33344455566','CNH34567890','AB','1985-11-05','(21) 97777-2222','marcos.o@gmail.com','Rua Copacabana','45','Copacabana','Rio de Janeiro','RJ','22020-001'),(4,'Juliana Paes','44455566677','CNH45678901','B','1995-01-30','(19) 98888-4444','juliana.p@gmail.com','Rua Doutor Quirino','500','Cambuí','Campinas','SP','13025-001'),(5,'Carlos Eduardo','55566677788','CNH56789012','D','1980-09-12','(31) 96666-5555','carlos.edu@yahoo.com.br','Av. Afonso Pena','2000','Savassi','Belo Horizonte','MG','30130-007');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locacao`
--

DROP TABLE IF EXISTS `locacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locacao` (
  `id_locacao` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_veiculo` int NOT NULL,
  `data_retirada` datetime NOT NULL,
  `data_prevista_devolucao` datetime NOT NULL,
  `data_devolucao_real` datetime DEFAULT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `status` enum('ativa','concluida','cancelada') NOT NULL DEFAULT 'ativa',
  PRIMARY KEY (`id_locacao`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_veiculo` (`id_veiculo`),
  CONSTRAINT `locacao_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `locacao_ibfk_2` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id_veiculo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_datas_locacao` CHECK ((`data_prevista_devolucao` >= `data_retirada`)),
  CONSTRAINT `locacao_chk_1` CHECK ((`valor_total` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locacao`
--

LOCK TABLES `locacao` WRITE;
/*!40000 ALTER TABLE `locacao` DISABLE KEYS */;
INSERT INTO `locacao` VALUES (1,1,1,'2026-01-10 08:00:00','2026-01-13 08:00:00','2026-01-13 08:00:00',330.00,'concluida'),(2,2,2,'2026-10-03 14:30:00','2026-10-08 14:30:00',NULL,550.00,'ativa'),(3,3,4,'2026-04-18 11:30:00','2026-04-25 11:30:00','2026-04-25 11:30:00',2660.00,'concluida'),(4,5,5,'2026-10-05 09:00:00','2026-10-12 09:00:00',NULL,1610.00,'ativa'),(5,1,3,'2026-02-10 10:00:00','2026-02-14 10:00:00','2026-02-14 10:00:00',440.00,'concluida');
/*!40000 ALTER TABLE `locacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manutencao`
--

DROP TABLE IF EXISTS `manutencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manutencao` (
  `id_manutencao` int NOT NULL AUTO_INCREMENT,
  `id_veiculo` int NOT NULL,
  `tipo` enum('preventiva','corretiva') NOT NULL,
  `descricao` varchar(255) NOT NULL,
  `data_inicio` date NOT NULL,
  `data_conclusao` date DEFAULT NULL,
  `custo` decimal(10,2) NOT NULL,
  `km_registro` int unsigned NOT NULL,
  PRIMARY KEY (`id_manutencao`),
  KEY `id_veiculo` (`id_veiculo`),
  CONSTRAINT `manutencao_ibfk_1` FOREIGN KEY (`id_veiculo`) REFERENCES `veiculos` (`id_veiculo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `manutencao_chk_1` CHECK ((`custo` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manutencao`
--

LOCK TABLES `manutencao` WRITE;
/*!40000 ALTER TABLE `manutencao` DISABLE KEYS */;
INSERT INTO `manutencao` VALUES (1,3,'preventiva','Troca de óleo e filtro de combustível','2026-03-01','2026-03-01',420.00,60000),(2,2,'corretiva','Substituição das pastilhas de freio dianteiras','2026-05-10','2026-05-11',850.00,12000),(3,5,'preventiva','Revisão periódica de 10.000 km','2026-06-15','2026-06-15',900.00,10000),(4,1,'preventiva','Alinhamento e balanceamento de rodas','2026-07-20','2026-07-20',250.00,35000),(5,4,'preventiva','Higienização do ar-condicionado e troca do filtro de cabine','2026-08-05','2026-08-05',300.00,8000);
/*!40000 ALTER TABLE `manutencao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multa`
--

DROP TABLE IF EXISTS `multa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `multa` (
  `id_multa` int NOT NULL AUTO_INCREMENT,
  `id_locacao` int NOT NULL,
  `data_infracao` datetime NOT NULL,
  `descricao_infracao` varchar(200) NOT NULL,
  `valor_multa` decimal(10,2) NOT NULL,
  `pontos` int NOT NULL DEFAULT '0',
  `status_pagamento` enum('pendente','pago','em_andamento') NOT NULL DEFAULT 'pendente',
  PRIMARY KEY (`id_multa`),
  KEY `id_locacao` (`id_locacao`),
  CONSTRAINT `multa_ibfk_1` FOREIGN KEY (`id_locacao`) REFERENCES `locacao` (`id_locacao`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `multa_chk_1` CHECK ((`valor_multa` > 0)),
  CONSTRAINT `multa_chk_2` CHECK ((`pontos` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multa`
--

LOCK TABLES `multa` WRITE;
/*!40000 ALTER TABLE `multa` DISABLE KEYS */;
INSERT INTO `multa` VALUES (6,1,'2026-01-11 14:20:00','Excesso de velocidade em até 20%',130.16,4,'pago'),(7,2,'2026-10-04 18:45:00','Avanço de sinal vermelho',293.47,7,'pendente'),(8,3,'2026-04-20 09:10:00','Estacionar em local proibido',195.23,4,'pago'),(9,4,'2026-10-06 11:15:00','Uso do celular ao volante',293.47,7,'pendente'),(10,5,'2026-02-12 16:30:00','Transitar em faixa exclusiva de ônibus',195.23,4,'em_andamento');
/*!40000 ALTER TABLE `multa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `veiculos`
--

DROP TABLE IF EXISTS `veiculos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `veiculos` (
  `id_veiculo` int NOT NULL AUTO_INCREMENT,
  `placa` varchar(8) NOT NULL,
  `renavam` varchar(11) NOT NULL,
  `chassi` varchar(17) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `data_fabricacao` date NOT NULL,
  `cor` varchar(30) NOT NULL,
  `km` int unsigned NOT NULL DEFAULT '0',
  `status` enum('disponivel','locado','manutencao','inativo') NOT NULL DEFAULT 'disponivel',
  `id_categoria` int NOT NULL,
  PRIMARY KEY (`id_veiculo`),
  UNIQUE KEY `placa` (`placa`),
  UNIQUE KEY `renavam` (`renavam`),
  UNIQUE KEY `chassi` (`chassi`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `veiculos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `veiculos_chk_1` CHECK ((`km` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veiculos`
--

LOCK TABLES `veiculos` WRITE;
/*!40000 ALTER TABLE `veiculos` DISABLE KEYS */;
INSERT INTO `veiculos` VALUES (1,'MNO-1111','12345678901','9BWZZZ377VT001001','Fiat Argo','2023-01-15','Branco',41000,'disponivel',1),(2,'XYZ-9876','23456789012','9BWZZZ377VT001002','Chevrolet Onix','2024-02-10','Prata',15200,'locado',1),(3,'JKL-5555','34567890123','9BWZZZ377VT001003','Renault Kwid','2022-05-20','Preto',68000,'disponivel',1),(4,'HKJ-4545','45678901234','9BWZZZ377VT001004','Toyota Corolla Altis','2024-06-01','Cinza',11400,'disponivel',3),(5,'ABC-1234','56789012345','9BWZZZ377VT001005','Jeep Compass','2023-11-12','Azul',18350,'locado',2);
/*!40000 ALTER TABLE `veiculos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-15 15:19:13
