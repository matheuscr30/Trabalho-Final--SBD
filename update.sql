SET search_path TO agencia_bancaria;

INSERT INTO agencia VALUES('6000', 'Uberaba', 'MG');

DELETE FROM conta
	WHERE ID_conta = 1;

DELETE FROM funcionario
	WHERE agencia_nome = '2000';
	
DELETE FROM cliente
	WHERE cidade = 'Araguari';
	
UPDATE cliente 
	SET estado = 'AC' 
		WHERE cidade = 'Uberlandia';

UPDATE cliente
	SET endereco = 'Avenida dos Mafagafos, 789'
		WHERE id = 2;

UPDATE cliente
	SET gerente = (SELECT numfunc FROM funcionario WHERE numfunc = 4102)
		WHERE id = 3;

