-- =====     aula1exer2Evolucao2     =====
--
--                    SCRIPT DE CRIACAO (DDL)
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

CREATE DATABASE 
    IF NOT EXISTS aula1exer2Evolucao2;
USE aula1exer2Evolucao2;

CREATE TABLE AREA (
    idArea int auto_increment PRIMARY KEY,
    nome varchar(255) not null
) ENGINE=InnoDB;

CREATE TABLE PESSOA (
    cpf char(11) PRIMARY KEY,
    nome varchar(255) not null,
    senha varchar(255) not null
) ENGINE=InnoDB;

CREATE TABLE GERENTE (
    email varchar(255) PRIMARY KEY,
    cpf char(11),
    formacao_escolar enum('infantil', 'fundamental', 'medio', 'superior') not null,
    idArea int not null,
    CONSTRAINT GERENTE_PESSOA_FK FOREIGN KEY (cpf) REFERENCES PESSOA (cpf)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT GERENTE_AREA_FK FOREIGN KEY (idArea) REFERENCES AREA (idArea)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE EMPREGADO (
    matricula varchar(255) PRIMARY KEY,
    cpf char(11),
    uf char(2) not null,
    cidade varchar(255) not null,
    bairro varchar(255) not null,
    logradouro varchar(255) not null,
    complemento varchar(255),
    CONSTRAINT EMPREGADO_PESSOA_FK FOREIGN KEY (cpf) REFERENCES PESSOA (cpf)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE telefone_empregado (
    matricula_empregado varchar(255) NOT NULL,
    ddd varchar(255),
    numero int,
    PRIMARY KEY (matricula_empregado, ddd, numero),
    CONSTRAINT telefone_empregado_EMPREGADO_FK FOREIGN KEY (matricula_empregado) REFERENCES EMPREGADO (matricula)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE supervisiona (
    email varchar(255),
    matricula varchar(255),
    PRIMARY KEY (email, matricula),
    CONSTRAINT supervisiona_GERENTE_FK FOREIGN KEY (email) REFERENCES GERENTE (email)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT supervisiona_EMPREGADO_FK FOREIGN KEY (matricula) REFERENCES EMPREGADO (matricula)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE PRODUTO (
    id_produto int auto_increment PRIMARY KEY,
    nome varchar(255) not null,
    idArea int not null,
    CONSTRAINT PRODUTO_AREA_FK FOREIGN KEY (idArea) REFERENCES AREA (idArea)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE VENDA (
    id_venda int auto_increment PRIMARY KEY,
    matricula_empregado varchar(255) not null,
    data_venda datetime not null,
    CONSTRAINT VENDA_EMPREGADO_FK FOREIGN KEY (matricula_empregado) REFERENCES EMPREGADO (matricula)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE VENDA_ITEM (
    id_venda int,
    id_produto int,
    preco_unitario decimal(10, 2) not null,
    quantidade decimal(5),
    PRIMARY KEY (id_produto, id_venda),
    CONSTRAINT VENDA_ITEM_VENDA_FK FOREIGN KEY (id_venda) REFERENCES VENDA (id_venda)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT VENDA_ITEM_PRODUTO_FK FOREIGN KEY (id_produto) REFERENCES PRODUTO (id_produto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE VIEW QUANTIDADE_VENDIDA AS
select 
    p.id_produto as 'id_produto', 
    p.nome as 'nome_produto', 
    sum(vi.quantidade) as 'quantidade vendida' 
from PRODUTO p
join VENDA_ITEM vi on p.id_produto = vi.id_produto
group by p.id_produto, p.nome
order by p.nome desc
