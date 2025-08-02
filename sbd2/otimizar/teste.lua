-- Para executar: sudo sysbench teste.lua \
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
  con:query("SELECT SQL_NO_CACHE * FROM category;")
end
