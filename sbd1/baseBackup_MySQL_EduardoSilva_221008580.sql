-- -------- < metacritic > --------
--
-- Data Criacao ...........: 09/07/2024
-- Autor(es) ..............: Eduardo Silva
-- Banco de Dados .........: MySQL 8.0
-- Base de Dados (nome) ...: metacritic
--
-- PROJETO => 01 Base de Dados
--         => 03 Tabelas
--
-- Nome da Base de Dados => metacritic
--
-- Quantidades de Tabelas nesta Base de Dados => 03 Tabelas
--
-- Quantidades de Tuplas em CADA TABELA dessa Base de Dados => GAME (12043) GENRE (12) PUBLISHER (1696)
--
-- ---------------------------------------------------------

-- 1) Restaurar o backup do arquivo que está na Área de Compartilhamento (pasta /aulas/basesDados e arquivo baseDados_metacritic_jogos.zip):
mysql -u root -D metacritic -p < baseDados_metacritic_jogos.sql

-- 2) Inserir na tabela GAME somente mais 1 tupla nova com o novo jogo sendo Rainbow Six com os demais dados podendo ser fictícios nesta tabela, mas respeitando as possíveis regras de negócio existentes:
INSERT INTO GAME (
    name,
    id_genre,
    id_publisher,
    year_of_release,
    developer,
    platform,
    na_sales,
    eu_sales,
    jp_sales,
    other_sales,
    critic_score,
    critic_count,
    user_score,
    user_count,
    rating
) VALUES (
    'Rainbow Six',
    1,
    4321,
    '1998',
    'Red Storm Entertainment',
    'PC',
    1.23,
    0.95,
    0.10,
    0.20,
    85,
    50,
    '8.7',
    200,
    'M'
);

-- 3) Comando que faz um novo backup desta base de dados contendo uma nova tupla:
mysqldump -u root metacritic -p > baseDados_metacritic_jogos.sql
