SET search_path TO agencia_bancaria;

--agencia
INSERT INTO agencia VALUES ('1000', 'Uberlandia', 'MG'),
							 ('2000', 'Uberlandia', 'MG'),
							 ('3000', 'Uberlandia', 'MG'),
							 ('4000', 'Araguari', 'AC'),
							 ('5000', 'Uberaba', 'MS');
							 
--funcionario
INSERT INTO funcionario VALUES (4101, '4000', 'Ronaldinho Gaúcho', '70707070', '2005-03-12', NULL),
								 (4102, '4000', 'Ronaldo Fenômeno', '987654321', '2015-05-09', 4101),
								 (2101, '2000', 'Roberto Carlos', '97653482', '2017-07-28', NULL),
								 (2102, '2000', 'Cristiano Ronaldo', '32164895', '2015-04-30', 2101),
								 (2103, '2000', 'Neymar Junior', '98724563', '1998-12-30', 2101);
								 
--dependente 
INSERT INTO dependente VALUES ('Gabriel Jesus', 2101),
								('Alberto Gomes', 2102),
								('Carlos Alberto', 4102),
								('David Luiz', 4102),
								('Daniel Alves', 2103);
								 
--cliente
INSERT INTO cliente VALUES (NEXTVAL('Seq_Cliente'), 'Pedro Nóbrega', '00000000000', '1997-11-22', 'Avenida das Flores, 123', 'Uberlandia', 'MG', 2102),
							 (NEXTVAL('Seq_Cliente'), 'Robison Arantes', '11111111111', '2000-05-25', 'Avenida das Raizes, 345', 'Uberlandia', 'MG', 2103),
							 (NEXTVAL('Seq_Cliente'), 'Odelmo Leão', '22222222222', '1995-09-21', 'Avenida dos Caules, 678', 'Uberlandia', 'MG', 2103),
							 (NEXTVAL('Seq_Cliente'), 'Rafael Lemos', '33333333333', '1996-11-22', 'Avenida da India, 951', 'Araguari', 'MG', 4102),
							 (NEXTVAL('Seq_Cliente'), 'Augusto César', '44444444444', '1993-04-18', 'Avenida do Indio, 375', 'Araguari', 'MG', 4101);

--emprestimo
INSERT INTO emprestimo VALUES (NEXTVAL('Seq_Emprestimo'), 250000, 5, '4000'),
								(NEXTVAL('Seq_Emprestimo'), 12500, 2, '5000'),
								(NEXTVAL('Seq_Emprestimo'), 65320, 3, '2000'),
								(NEXTVAL('Seq_Emprestimo'), 1500, 1, '2000'),
								(NEXTVAL('Seq_Emprestimo'), 650, 1, '1000');
								
--emprestimo_cliente
INSERT INTO emprestimo_cliente VALUES (1, 4),
										(1, 5),
										(2, 4),
										(3, 1),
										(4, 2);
										
--conta
INSERT INTO conta VALUES (NEXTVAL('Seq_Conta'), '2005-10-23', 625.75, '2017-06-30', '2000', 'corrente'),
						   (NEXTVAL('Seq_Conta'), '2001-05-12', 15775, '2017-07-01', '2000', 'corrente'),
						   (NEXTVAL('Seq_Conta'), '2010-07-24', 6557, '2017-05-15', '2000', 'corrente'),
						   (NEXTVAL('Seq_Conta'), '2015-07-21', 150, '2017-05-15', '2000', 'poupanca'),
						   (NEXTVAL('Seq_Conta'), '2016-08-12', 3875, '2017-07-03', '2000', 'poupanca'),
						   (NEXTVAL('Seq_Conta'), '2012-12-24', 9872, '2017-07-03', '4000', 'corrente'),
						   (NEXTVAL('Seq_Conta'), '2013-10-21', 5367, '2017-06-30', '4000', 'corrente'),
						   (NEXTVAL('Seq_Conta'), '2012-04-12', 9875, '2016-12-30', '4000', 'poupanca'),
						   (NEXTVAL('Seq_Conta'), '2011-01-02', 35, '2017-07-04', '4000', 'poupanca'),
						   (NEXTVAL('Seq_Conta'), '2010-03-09', 10000, '2017-07-04', '4000', 'poupanca');
						   
---conta_cliente
INSERT INTO conta_cliente VALUES (1, '2000', 1),
								   (1, '2000', 5),
								   (2, '2000', 2),
								   (2, '2000', 4),
								   (3, '2000', 3),
								   (3, '2000', 2),
								   (4, '4000', 6),
								   (4, '4000', 7),
								   (5, '4000', 8),
								   (5, '4000', 9),
								   (4, '4000', 10);
								   
--corrente
INSERT INTO corrente VALUES ('2000', 1, 10.10),
							  ('2000', 2, 11.50),
							  ('2000', 3, 23.40),
							  ('4000', 6, 10.50),
							  ('4000', 7, 10.40);
							  
--poupanca
INSERT INTO poupanca VALUES ('2000', 4, 0),
							  ('2000', 5, 0),
							  ('4000', 8, 0),
							  ('4000', 9, 0),
							  ('4000', 10, 0);

--operacao_bancaria
INSERT INTO operacao_bancaria VALUES (NEXTVAL('Seq_Operacao'), 1, '2000', 'DEBITO', 5250.34, '2017-05-24', 'Tenda do Café'),
									   (NEXTVAL('Seq_Operacao'), 2, '2000', 'CREDITO', 5360.50, '2017-07-03', 'LOL Cafe'),
									   (NEXTVAL('Seq_Operacao'), 6, '4000', 'DEBITO', 5150.65, '2017-07-01', 'Taco Bells'),
									   (NEXTVAL('Seq_Operacao'), 6, '4000', 'CREDITO', 5123.45, '2016-08-05', 'London Barbearia'),
									   (NEXTVAL('Seq_Operacao'), 7, '4000', 'CREDITO', 5050, '2015-05-08', 'Isaac.com');

--cupom
INSERT INTO cupom VALUES (NEXTVAL('Seq_Cupom'), '2017-07-17', 1, 1, '2000'),
                           (NEXTVAL('Seq_Cupom'), '2017-08-05', 2, 2, '2000'),
                           (NEXTVAL('Seq_Cupom'), '2018-05-20', 3, 6, '4000'), 
                           (NEXTVAL('Seq_Cupom'), '2018-05-06', 4, 6, '4000'),
                           (NEXTVAL('Seq_Cupom'), '2017-08-09', 5, 7, '4000');
                           
                           
                           
                           
