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

INSERT INTO AREA (nome) VALUES
('Recursos Humanos'),
('Financeiro'),
('Tecnologia da Informação'),
('Marketing'),
('Logística'),
('Jurídico'),
('Pesquisa e Desenvolvimento'),
('Comercial'),
('Suporte Técnico'),
('Vendas Online'),
('Design de Produto'),
('Controle de Qualidade');

INSERT INTO PESSOA (cpf, nome, senha) VALUES
('12345678901', 'Ana Souza', 'senha'),
('23456789012', 'Bruno Lima', 'senha'),
('34567890123', 'Carlos Alberto', 'senha'),
('45678901234', 'Daniela Costa', 'senha'),
('56789012345', 'Eduardo Silva', 'senha'),
('67890123456', 'Fernanda Rocha', 'senha'),
('78901234567', 'Gabriel Martins', 'senha'),
('89012345678', 'Helena Dias', 'senha'),
('90123456789', 'Igor Ferreira', 'senha'),
('01234567890', 'Juliana Mendes', 'senha'),
('09876543210', 'Larissa Moura', 'senha'),
('10987654321', 'Marcos Vinicius', 'senha'),
('21098765432', 'Natália Ribeiro', 'senha'),
('32109876543', 'Otávio Neves', 'senha'),
('43210987654', 'Patrícia Gomes', 'senha'),
('54321098765', 'Ricardo Pinto', 'senha'),
('65432109876', 'Sandra Duarte', 'senha'),
('76543210987', 'Thiago Almeida', 'senha'),
('87654321098', 'Vanessa Cruz', 'senha'),
('98765432109', 'William Barros', 'senha');

INSERT INTO GERENTE (email, cpf, formacao_escolar, idArea) VALUES
('ana.souza@empresa.com', '12345678901', 'superior', 1),
('bruno.lima@empresa.com', '23456789012', 'medio', 2),
('carlos.alberto@empresa.com', '34567890123', 'superior', 3),
('daniela.costa@empresa.com', '45678901234', 'fundamental', 4),
('eduardo.silva@empresa.com', '56789012345', 'medio', 5),
('fernanda.rocha@empresa.com', '67890123456', 'superior', 6),
('gabriel.martins@empresa.com', '78901234567', 'medio', 7);

INSERT INTO EMPREGADO (matricula, cpf, uf, cidade, bairro, logradouro, complemento) VALUES
('EMP001', '67890123456', 'SP', 'São Paulo', 'Bela Vista', 'Rua A', 'Apto 101'),
('EMP002', '78901234567', 'RJ', 'Rio de Janeiro', 'Copacabana', 'Avenida Atlântica', NULL),
('EMP003', '89012345678', 'MG', 'Belo Horizonte', 'Savassi', 'Rua B', 'Fundos'),
('EMP004', '90123456789', 'RS', 'Porto Alegre', 'Centro', 'Rua C', 'Sala 4'),
('EMP005', '01234567890', 'BA', 'Salvador', 'Barra', 'Rua D', NULL),
('EMP006', '09876543210', 'PR', 'Curitiba', 'Batel', 'Rua E', 'Cobertura'),
('EMP007', '10987654321', 'PE', 'Recife', 'Boa Viagem', 'Avenida Boa Viagem', NULL);

INSERT INTO telefone_empregado (matricula_empregado, ddd, numero) VALUES
('EMP001', '11', 987654321),
('EMP002', '21', 998877665),
('EMP003', '31', 912345678),
('EMP004', '51', 934567890),
('EMP005', '71', 976543210),
('EMP006', '41', 988776655),
('EMP007', '81', 997755331);

INSERT INTO supervisiona (email, matricula) VALUES
('ana.souza@empresa.com', 'EMP001'),
('bruno.lima@empresa.com', 'EMP002'),
('carlos.alberto@empresa.com', 'EMP003'),
('daniela.costa@empresa.com', 'EMP004'),
('eduardo.silva@empresa.com', 'EMP005'),
('fernanda.rocha@empresa.com', 'EMP006'),
('gabriel.martins@empresa.com', 'EMP007');

INSERT INTO PRODUTO (nome, idArea) VALUES
('Notebook Dell Inspiron', 1),
('Smartphone Samsung Galaxy', 2),
('Mouse Logitech', 3),
('Monitor LG 24"', 4),
('Teclado Mecânico Redragon', 5),
('Webcam Logitech C920', 6),
('Headset HyperX Cloud', 7);

INSERT INTO VENDA (matricula_empregado, data_venda) VALUES
('EMP001', '2025-03-01 10:30:00'),
('EMP002', '2025-03-02 14:15:00'),
('EMP003', '2025-03-03 11:45:00'),
('EMP004', '2025-03-04 16:00:00'),
('EMP005', '2025-03-05 13:20:00'),
('EMP006', '2025-03-06 09:50:00'),
('EMP007', '2025-03-07 15:10:00');

INSERT INTO VENDA_ITEM (id_venda, id_produto, preco_unitario, quantidade) VALUES
(1, 1, 3500.00, 1),
(2, 2, 2500.00, 2),
(3, 3, 150.00, 3),
(4, 4, 1200.00, 1),
(4, 7, 600.00, 3),
(5, 5, 300.00, 2),
(6, 6, 450.00, 1),
(7, 7, 600.00, 1);
