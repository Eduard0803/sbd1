-- Para executar: sudo sysbench consultas.lua \
--                --db-driver=mysql --mysql-user=root \
--                --mysql-password=root --mysql-db=marketplace \
--                --threads=16 --time=10 run

-- Função chamada pelo Sysbench uma vez ao inicializar o script
function thread_init()
  -- Inicializa o driver MySQL do Sysbench
  drv = sysbench.sql.driver()
  -- Representa a conexão com o MySQL
  con = drv:connect()
end

-- Função chamada pelo Sysbench quando o script termina a execução
function thread_done()
  -- Fecha a conexão com o MySQL
  con:disconnect()
end

-- Função chamada pelo Sysbench para cada execução
function event()
  -- Consulta a ser executada no benchmark

  -- -- Consulta #1
  -- con:query("SELECT COUNT(*) AS `Número de compras em 2015` FROM sale \
  --            WHERE YEAR(date) = 2015 GROUP BY YEAR(date);")
  -- transactions:    272    (26.43 per sec.)
  -- Latency (ms) avg:    297.50

  -- con:query("select count(*) from sale where date >= '2015-01-01' and date <= '2015-12-31';")
  -- transactions:    273    (26.65 per sec.)
  -- Latency (ms) avg:    296.86

  -- -- WITHOUT INDEX
  -- con:query("select count(*) from sale where year(date) = 2015;")
  -- transactions:    324    (31.72 per sec.)
  -- Latency (ms) avg:   249.92

  -- -- WITH INDEX
  -- con:query("select count(*) from sale where year(date) = 2015;")
  -- transactions:    378    (37.23 per sec.)
  -- Latency (ms) avg:    212.93



  -- -- Consulta #2
  con:query("SELECT COUNT(*) AS `Quantidade` FROM product \
             WHERE price BETWEEN 0 AND 1000 AND stock <= 100;")
  -- transactions:    3354   (334.51 per sec.)
  -- Latency (ms) avg:   23.88

  -- WITHOUT INDEX
  -- con:query("SELECT COUNT(*) AS `Quantidade` FROM product WHERE price < 1000 AND stock <= 100;")
  -- transactions:    3801   (379.33 per sec.)
  -- Latency (ms) avg:   21.07

  -- WITH INDEX
  -- con:query("SELECT COUNT(*) AS `Quantidade` FROM product WHERE price < 1000 AND stock <= 100;")
  -- transactions:    37150  (3713.44 per sec.)
  -- Latency (ms) avg:   2.15



  -- -- Consulta #3
  -- WITHOUT INDEX
  -- con:query("SELECT name AS `Nome da categoria` FROM category LIMIT 10;")
  -- transactions:    1432729 (143248.61 per sec.)
  -- Latency (ms) avg:   0.06

  -- WITH INDEX
  -- con:query("SELECT name AS `Nome da categoria` FROM category LIMIT 10;")
  -- transactions:    1486062 (148581.65 per sec.)
  -- Latency (ms) avg:   0.05



  -- -- Consulta #4
  -- con:query("SELECT * FROM sale s \
  --            INNER JOIN customer c ON s.customerId = c.customerId \
  --            WHERE date > CURDATE() - INTERVAL 1 YEAR;")
  -- transactions:    868238 (86810.29 per sec.)
  -- Latency (ms) avg:   0.09

  -- con:query("SELECT * FROM customer c \
  --            INNER JOIN sale s ON s.customerId = c.customerId \
  --            WHERE date > CURDATE() - INTERVAL 1 YEAR;")
  -- transactions:    867731 (86758.68 per sec.)
  -- Latency (ms) avg:   0.09



  -- -- Consulta #5
  -- con:query("SELECT * FROM user WHERE userId = 11100;")
  -- transactions:    1618891 (161863.00 per sec.)
  -- Latency (ms) avg:   0.05



  -- -- Consulta #6
  -- con:query("SELECT * FROM store;")
  -- transactions:    22555  (2252.16 per sec.)
  -- Latency (ms) avg:   3.55

end
