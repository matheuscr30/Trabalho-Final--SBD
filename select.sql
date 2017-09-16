SET search_path TO agencia_bancaria;

-- 1) Selecionar o nome do funcionario e seu respectivo dependente
SELECT funcionario.nome, dependente.nome
FROM funcionario INNER JOIN dependente
	ON dependente.funcionario = funcionario.numfunc;

-- 2) Clientes que geraram o cupom, e o numero do cupom
SELECT cupom.numero, conta_cliente.id_conta, cliente.nome
FROM cliente INNER JOIN
	(conta_cliente INNER JOIN cupom
		ON conta_cliente.agencia_nome = cupom.agencia_nome AND conta_cliente.id_conta = cupom.id_conta)
	ON cliente.id = conta_cliente.id_cliente;

-- 3) Clientes que possuem conta corrente e poupança
(SELECT cliente.id, cliente.nome
FROM cliente INNER JOIN
	(conta_cliente INNER JOIN corrente
		ON conta_cliente.agencia_nome = corrente.agencia_nome AND conta_cliente.id_conta = corrente.id_conta)
	ON cliente.id = conta_cliente.id_cliente)
INTERSECT
(SELECT cliente.id, cliente.nome
FROM cliente INNER JOIN
	(conta_cliente INNER JOIN poupanca
		ON conta_cliente.agencia_nome = poupanca.agencia_nome AND conta_cliente.id_conta = poupanca.id_conta)
	ON cliente.id = conta_cliente.id_cliente);


-- 4) Clientes que solicitaram emprestimo, e o valor do empréstimo
SELECT cliente.id, cliente.nome, emprestimo.valor
FROM cliente INNER JOIN
	(emprestimo_cliente INNER JOIN emprestimo
		ON emprestimo.id_emprestimo = emprestimo_cliente.id_emprestimo)
	ON cliente.id = emprestimo_cliente.id_cliente;

-- 5) Clientes e seus respectivos gerentes
SELECT cliente.nome, funcionario.nome
FROM cliente INNER JOIN funcionario
	ON cliente.gerente = funcionario.numfunc;

-- 6) Quantidade de agencias por estado (GROUP BY)
SELECT estado, count(*)
FROM agencia
	GROUP BY estado;

-- 7) Quantidades de contas por tipo de conta
SELECT tipo_conta, count(*)
FROM conta
	GROUP BY tipo_conta;

-- 8) Soma do valor de operações bancárias por tipo
SELECT tipo, sum(valor)
FROM operacao_bancaria
	GROUP BY tipo;

-- 9) Média de saldo por cidade com média > 7050.00
SELECT cliente.cidade, AVG(conta.saldo)
FROM conta INNER JOIN 
	(conta_cliente INNER JOIN cliente 
		ON conta_cliente.id_cliente = cliente.id)
	ON conta.id_conta = conta_cliente.id_conta
	GROUP BY cliente.cidade
		HAVING AVG(conta.saldo) > 7050.00;
		
-- 10) Quantidade de funcionários por cidade count > 2
SELECT agencia.cidade, count(*)
FROM agencia INNER JOIN funcionario
	ON agencia.nome = funcionario.agencia_nome
	GROUP BY agencia.cidade
		HAVING count(*) > 2;

