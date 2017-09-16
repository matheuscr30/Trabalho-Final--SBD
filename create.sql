DROP SCHEMA IF EXISTS agencia_bancaria CASCADE;
CREATE SCHEMA agencia_bancaria;
SET search_path TO agencia_bancaria;

CREATE TABLE agencia (
	nome VARCHAR(30),
	cidade VARCHAR(30),
	estado VARCHAR(30),
	
	--restricoes
	CONSTRAINT pk_agencia PRIMARY KEY(nome)
);

CREATE SEQUENCE Seq_Emprestimo
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE emprestimo (
	ID_emprestimo INT,
	valor REAL,
	quantparcelas INT,
	agencia_nome VARCHAR(30),
	
	--restricoes
	CONSTRAINT pk_emprestimo PRIMARY KEY(ID_emprestimo),
	CONSTRAINT fk_agencia FOREIGN KEY(agencia_nome) REFERENCES agencia(nome) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE funcionario (
	numfunc INT,
	agencia_nome VARCHAR(30),
	nome VARCHAR(30),
	telefone VARCHAR(30),
	data_admissao DATE,
	supervisor INT,
	
	--restricoes
	CONSTRAINT pk_funcionario PRIMARY KEY(numfunc),
	CONSTRAINT fk_agencia FOREIGN KEY(agencia_nome) REFERENCES agencia(nome) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_funcionario FOREIGN KEY(supervisor) REFERENCES funcionario(numfunc) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE dependente (
	nome VARCHAR(30),
	funcionario INT,
	
	--restricoes
	CONSTRAINT fk_funcionario FOREIGN KEY(funcionario) REFERENCES funcionario(numfunc) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_dependente PRIMARY KEY(nome, funcionario)
);

CREATE SEQUENCE Seq_Cliente
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE cliente (
	ID INT,
	nome VARCHAR(30),
	CPF VARCHAR(30) UNIQUE,
	data_nasc DATE,
	endereco VARCHAR(30),
	cidade VARCHAR(30),
	estado VARCHAR(30),
	gerente INT,
	
	--restricoes
	CONSTRAINT pk_cliente PRIMARY KEY(ID),
	CONSTRAINT fk_funcionario FOREIGN KEY(gerente) REFERENCES funcionario(numfunc) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE SET NULL
);
	
CREATE TABLE emprestimo_cliente (
	ID_emprestimo INT,
	ID_cliente INT, 
	
	--restricoes
	CONSTRAINT fk_emprestimo FOREIGN KEY(ID_emprestimo) REFERENCES emprestimo(ID_emprestimo) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_cliente FOREIGN KEY(ID_cliente) REFERENCES cliente(ID) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_emprestimo_cliente PRIMARY KEY(ID_emprestimo, ID_cliente)
);

CREATE SEQUENCE Seq_Conta
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE conta (
	ID_conta INT,
	data_criacao DATE,
	saldo REAL,
	acesso_recente DATE,
	agencia_nome VARCHAR(30),
	tipo_conta VARCHAR(15),
	
	--restricoes
	CONSTRAINT fk_agencia FOREIGN KEY(agencia_nome) REFERENCES agencia(nome) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_conta PRIMARY KEY(ID_conta, agencia_nome)
);

CREATE TABLE conta_cliente (
	ID_cliente INT, 
	agencia_nome VARCHAR(30),
	ID_conta INT,
	
	--restricoes
	CONSTRAINT fk_conta FOREIGN KEY(ID_conta, agencia_nome) REFERENCES conta(ID_conta, agencia_nome) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_cliente FOREIGN KEY(ID_cliente) REFERENCES cliente(ID) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_conta_cliente PRIMARY KEY(ID_cliente, agencia_nome, ID_conta)
);

CREATE TABLE corrente (
	agencia_nome VARCHAR(30),
	ID_conta INT,
	tarifa_mensal REAL,
	
	--restricoes
	CONSTRAINT fk_conta FOREIGN KEY(ID_conta, agencia_nome) REFERENCES conta(ID_conta, agencia_nome) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_corrente PRIMARY KEY(agencia_nome, ID_conta)
);

CREATE TABLE poupanca (
	agencia_nome VARCHAR(30),
	ID_conta INT, 
	taxa_juros REAL,
	
	--restricoes
	CONSTRAINT fk_conta FOREIGN KEY(ID_conta, agencia_nome) REFERENCES conta(ID_conta, agencia_nome) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_poupanca PRIMARY KEY(agencia_nome, ID_conta)
);

CREATE SEQUENCE Seq_Operacao
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE operacao_bancaria (
	ID_operacao INT, 
	ID_conta INT, 
	agencia_nome VARCHAR(30),
	tipo VARCHAR(10),
	valor REAL,
	dataop DATE,
	descricao VARCHAR(50),
	
	--restricoes
	CONSTRAINT fk_operacao_bancaria FOREIGN KEY(ID_conta, agencia_nome) REFERENCES corrente(ID_conta, agencia_nome) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT pk_operacao_bancaria PRIMARY KEY(ID_operacao, ID_conta, agencia_nome)
);

CREATE SEQUENCE Seq_Cupom
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE cupom (
	numero INT, 
	validade DATE, 
	ID_operacao_bancaria INT,
	ID_conta INT, 
	agencia_nome VARCHAR(30),
	
	--restricoes
	CONSTRAINT pk_cupom PRIMARY KEY(numero),
	CONSTRAINT fk_operacao_bancaria FOREIGN KEY(ID_operacao_bancaria,ID_conta, agencia_nome) REFERENCES 
		operacao_bancaria(ID_operacao, ID_conta, agencia_nome) MATCH SIMPLE 
			ON UPDATE CASCADE ON DELETE SET NULL
);

-- Triggers e Store Procedures

CREATE FUNCTION ganha_cupom () RETURNS trigger AS
$$
BEGIN
  IF(NEW.valor > 5000) THEN
    
    INSERT INTO cupom 
    VALUES(NEXTVAL('Seq_Cupom'), NOW() + INTERVAL '30 days', NEW.id_operacao, NEW.id_conta , NEW.agencia_nome);
  
  END IF;
  
  RETURN NULL;
END;$$ language plpgsql;

CREATE TRIGGER cupom_trigger AFTER INSERT OR UPDATE
ON operacao_bancaria
FOR EACH ROW  EXECUTE PROCEDURE ganha_cupom();
