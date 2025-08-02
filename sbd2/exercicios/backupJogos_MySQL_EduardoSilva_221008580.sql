-- =====     metacritic     =====
--
--
--
-- Data Criacao ...........: 09/04/2025
-- Autor(es) ..............: Eduardo Belarmino Silva
-- Banco de Dados .........: MySQL 8.0
-- Base de Dados (nome) ...: metacritic
-- 
-- Nome: Eduardo Belarmino Silva
-- Matricula 221008580
--
-- PROJETO => 01 Base de Dados
--         => 03 Tabelas
-- 
-- Nome da Base de Dados => metacritic
--
-- Quantidades de Tabelas nesta Base de Dados => 3
-- 
-- Quantidades de Tuplas em CADA TABELA dessa Base de Dados 
-- +--------------------+
-- | TABELA    | TUPLAS |
-- +--------------------+
-- | GENRE     | 12     |
-- | PUBLISHER | 1696   |
-- | GAME      | 12043  |
-- +--------------------+
-- ---------------------------------------------------------

-- 1) Restaurar o backup do arquivo que está na Área de Compartilhamento (pasta /aulas/basesDados e arquivo projetoBaseDados_Jogos_2020.zip):
mysql -u root -p -e "create database if not exists metacritic"
mysql -u root -p metacritic < SqlDump_baseDados_Jogos.sql

-- 2) Inserir na tabela GAME somente mais 1 tupla nova com o novo jogo sendo War Thunder com os demais dados somente OBRIGATÓRIOS sendo preenchidos com dados fictícios nesta tabela, mas respeitando as possíveis regras de negócio existentes e com o gênero devendo ser informado como de COMBATE (fighting):
insert into GAME (name, id_genre, id_publisher, platform, na_sales, eu_sales, jp_sales, other_sales, year_of_release)
values
(
  'War Thunder', 
  (select id_genre from GENRE where description = lower('fighting')), 
  (select min(id_publisher) from PUBLISHER), 
  'PC', 10, 10, 10, 10, 2025
);

-- 3) Comando que faz um novo backup desta base de dados contendo uma nova tupla incluída pela instrução anterior (questão 2):
mysqldump -u root -p -d metacritic > SqlDump_baseDados_Jogos.sql

