-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22/11/2024 às 21:12
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `agenda_telefonica`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `contato`
--

CREATE TABLE `contato` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `numero` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `contato`
--

INSERT INTO `contato` (`id`, `nome`, `numero`) VALUES
(12, 'Anderson Trabalho', '84985043858'),
(13, 'Fernando Mecânica', '68981096875'),
(14, 'Rafaela Stefany', '16984747794'),
(16, 'Emanuelly Cláudia', '14981529105'),
(17, 'Maitê Cristiane ', '11992893841'),
(18, 'Maria Eduarda', '71982233454'),
(19, 'Rodrigo Lima', '11976882423'),
(20, 'Thiago Rodrigues', '11975508762'),
(21, 'Ana Claudia', '7187220138'),
(22, 'Diego Pereira', '614052374'),
(23, 'Henrique Lopes', '849772326'),
(25, 'Sabrina Diniz', '82654402118'),
(26, 'Douglas Anunciação', '2898800123'),
(27, 'Manuela Santos', '1194230118'),
(28, 'Carlos Eduardo ', '71905423667'),
(29, 'Miguell Silva', '8287002456'),
(30, 'Pedro Loker', '6897664421'),
(31, 'Bruno Melos', '9587220344'),
(32, 'Agatha Andrade', '2188735621'),
(33, 'Juliana Fernandes', '51970023456'),
(34, 'Júlio Guedes', '21967882124'),
(37, 'Milena Braga', '11234568456');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `contato`
--
ALTER TABLE `contato`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `contato`
--
ALTER TABLE `contato`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
