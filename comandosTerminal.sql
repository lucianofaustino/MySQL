

/*

show databases; Mostra todos os banco de dados criados

use nome_do_banco_de_dados; Seleciona o banco para uso

status; mostra qual banco está aberto

show tables; Mostra quais são as tabelas do banco selecionado

describe nome_da_tabela; Descreve toda a tabela 

SELECT * FROM nome_da_tabela; Mostra a tabela


------- 
FUNÇÃO

SHOW FUNCTION STATUS WHERE db = 'nome_do_banco'; Mostra as funções da tabela

SHOW FUNCTION STATUS; exibir todas as funções desenvolvidas

SHOW CREATE FUNCTION nome_da_funcao; exibir a estrutura de uma função

DROP FUNCTION fn_desc; Exclui a função selecionada


------- 
PROCEDIMENTO

SHOW PROCEDURE STATUS WHERE db = 'nome_do_banco'; Mostra todos os procedimentos criados no banco

call nome_do_procedimento(n); Mostra o resultado do procedimento. "n" será o número o id caso tenhao sido referenciado

DROP PROCEDURE nome_do_procedimento; Exclui o procedimento selecionado


*/