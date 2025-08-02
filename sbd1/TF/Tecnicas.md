O script SQL apresentado faz uso de várias técnicas de banco de dados. Aqui estão três delas:

1. **Chaves Primárias e Auto Incremento**:
   - As chaves primárias são definidas para garantir a unicidade de cada registro em uma tabela. Por exemplo, `idMetodoPagamento`, `idCliente`, `idMarca`, `idCategoria`, `idProduto`, `idPedido`, `idVenda` são todos definidos como `PRIMARY KEY` com a opção `AUTO_INCREMENT`, que automaticamente incrementa o valor da chave primária para cada novo registro. Isso facilita a identificação e referência de registros específicos dentro das tabelas.

   ```sql
   idMetodoPagamento INT NOT NULL AUTO_INCREMENT,
   CONSTRAINT METODOS_PAGAMENTO_PK PRIMARY KEY (idMetodoPagamento)
   ```

2. **Chaves Estrangeiras e Integridade Referencial**:
   - As chaves estrangeiras (`FOREIGN KEY`) são usadas para estabelecer e reforçar relacionamentos entre tabelas. Isso assegura que os valores em uma coluna estejam presentes na coluna de outra tabela, promovendo a integridade referencial. Por exemplo, `idMarca` em `PRODUTO` é uma chave estrangeira que referencia `idMarca` em `MARCA`, e `idCliente` em `VENDA` referencia `idCliente` em `CLIENTE`. As ações `ON DELETE RESTRICT` e `ON UPDATE CASCADE` especificam o comportamento ao deletar ou atualizar os registros referenciados.

   ```sql
   CONSTRAINT PRODUTO_MARCA_FK FOREIGN KEY (idMarca) REFERENCES MARCA (idMarca)
       ON DELETE RESTRICT
       ON UPDATE CASCADE
   ```

3. **Views**:
   - Views são consultas salvas que podem ser tratadas como tabelas virtuais. Elas permitem simplificar consultas complexas e oferecer uma camada de abstração adicional. No script, temos duas views: `ESTOQUE` e `PRODUTOS_VENCIDOS`. A view `ESTOQUE` calcula a quantidade de produtos disponíveis, enquanto a view `PRODUTOS_VENCIDOS` calcula a quantidade de produtos vencidos. Ambas usam agregações (`SUM`) e junções (`JOIN`) para combinar e processar dados de várias tabelas.

   ```sql
   CREATE VIEW ESTOQUE AS
       SELECT 
           ip.idProduto,
           p.nomeProduto,
           m.nomeMarca,
           c.nomeCategoria,
           (IFNULL(SUM(ip.qtdProdutos), 0) - IFNULL(SUM(iv.qtdProdutos), 0)) AS qtdProdutosDisponiveis
       FROM 
           ITEM_PEDIDO ip
       LEFT JOIN 
           ITEM_VENDA iv ON ip.idProduto = iv.idProduto
       JOIN
           PRODUTO p ON ip.idProduto = p.idProduto
       JOIN
           MARCA m ON p.idMarca = m.idMarca
       JOIN
           CATEGORIA c ON p.idCategoria = c.idCategoria
       WHERE 
           ip.dataDeValidade >= CURDATE()
       GROUP BY 
           ip.idProduto, ip.qtdProdutos;
   ```

Além das técnicas mencionadas anteriormente, o script SQL também utiliza as seguintes técnicas de banco de dados:

4. **Enums**:
   - Enums são tipos de dados que permitem definir um conjunto fixo de valores para uma coluna. Isso é útil para garantir que os valores em uma coluna sejam consistentes e estejam dentro de um conjunto predefinido. No script, as colunas `sexo` em `CLIENTE` e `PRODUTO`, e `statusVenda` em `VENDA` usam enums para restringir os valores a opções específicas.

   ```sql
   sexo ENUM('M', 'F', 'U') NOT NULL,
   ```

   ```sql
   statusVenda ENUM("Preparando", "A caminho", "Entregue") NOT NULL,
   ```

5. **Constraints (Restrições)**:
   - Constraints são usadas para definir regras para os dados em uma tabela. Além de chaves primárias e estrangeiras, o script usa restrições únicas (`UNIQUE`) para garantir que certas combinações de colunas sejam únicas. No exemplo, a tabela `telefone` usa uma restrição única para garantir que a combinação de `idCliente`, `numero` e `ddd` seja única.

   ```sql
   CONSTRAINT telefone_idCliente_ddd_numero_UK UNIQUE (idCliente, numero, ddd)
   ```

6. **Engines de Armazenamento (Storage Engines)**:
   - O script especifica o uso da engine de armazenamento `InnoDB` para todas as tabelas. `InnoDB` é uma engine de armazenamento transacional que oferece suporte a chaves estrangeiras e transações ACID (Atomicidade, Consistência, Isolamento, Durabilidade), proporcionando integridade referencial e recuperação de falhas.

   ```sql
   ) ENGINE = InnoDB;
   ```

7. **Funções Agregadas e Funções de Data**:
   - O script faz uso de funções agregadas como `SUM` e funções de data como `CURDATE()` para realizar cálculos e manipulações de datas. Essas funções são usadas, por exemplo, nas views `ESTOQUE` e `PRODUTOS_VENCIDOS` para calcular a quantidade de produtos disponíveis e vencidos, respectivamente.

   ```sql
   (IFNULL(SUM(ip.qtdProdutos), 0) - IFNULL(SUM(iv.qtdProdutos), 0)) AS qtdProdutosDisponiveis
   ```

   ```sql
   WHERE 
       ip.dataDeValidade >= CURDATE()
   ```

8. **Cláusula `GROUP BY`**:
   - A cláusula `GROUP BY` é usada em conjunto com funções agregadas para agrupar resultados por uma ou mais colunas. Nas views `ESTOQUE` e `PRODUTOS_VENCIDOS`, a cláusula `GROUP BY` agrupa os resultados por `idProduto` e `qtdProdutos`.

   ```sql
   GROUP BY 
       ip.idProduto, ip.qtdProdutos;
   ```

9. **Junções (Joins)**:
   - Junções são usadas para combinar registros de duas ou mais tabelas com base em uma condição relacionada. O script usa junções internas (`INNER JOIN`) e junções à esquerda (`LEFT JOIN`) para combinar dados de várias tabelas nas views `ESTOQUE` e `PRODUTOS_VENCIDOS`.

   ```sql
   JOIN
       PRODUTO p ON ip.idProduto = p.idProduto
   LEFT JOIN 
       ITEM_VENDA iv ON ip.idProduto = iv.idProduto
   ```

Essas técnicas, combinadas, permitem a criação de um banco de dados relacional robusto e eficiente, com integridade referencial, regras de consistência de dados e suporte para consultas complexas.
