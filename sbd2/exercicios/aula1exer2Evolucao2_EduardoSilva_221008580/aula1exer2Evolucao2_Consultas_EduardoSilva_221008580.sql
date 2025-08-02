-- =====     aula1exer2Evolucao2     =====
--
--                    SCRIPT DE INSERCAO (DDL)
--
-- Data Criacao ...........: 31/03/2025
-- Autor(es) ..............: Eduardo Belarmino Silva
-- Banco de Dados .........: MySQL 8.0
-- Base de Dados (nome) ...: aula1exer2Evolucao2
--
-- PROJETO => 01 Base de Dados
--         => 09 Tabelas
--         => 01 Visoes
-- 
-- ---------------------------------------------------------

USE aula1exer2Evolucao2;


-- A)
select id_venda, data_venda from EMPREGADO
where matricula = '90123456789';

-- B)
select id_produto, nome_produto, vi.quantidade*vi.preco_unitario from VENDA v
join VENDA_ITEM vi on vi.id_venda = v.id_venda
join PRODUTO p on p.id_produto = vi.id_produto
where v.id_venda = 1;

-- C)
select matricula, nome from EMPREGADO e
left join PESSOA p on p.cpf = e.cpf
left join GERENTE g on g.cpf = p.cpf
order by nome asc;

-- D)
select * from QUANTIDADE_VENDIDA;

-- E)
select * from QUANTIDADE_VENDIDA
where nome_produto like '%a%';
