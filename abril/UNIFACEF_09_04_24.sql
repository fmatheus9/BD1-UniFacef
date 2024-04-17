--CRIANDO O OBJETO "tb_funcionarios"
--RESTRIÇÕES: PK APLICADA A COLUNA "matricula"
create table tb_funcionarios(
matricula	INTEGER,
nome		VARCHAR(60),
end_func	VARCHAR(45),
cel			VARCHAR(15),
fone		VARCHAR(15),
CONSTRAINT pk_tb_funcionarios_matricula PRIMARY KEY(matricula)
);

--CRIANDO O OBJETO "tb_enfermeiros"
--RESTRICOES: PK E FK APLICADA A COLUNA "matricula"
create table tb_enfermeiro(
matricula 	INTEGER,
COREN		INTEGER,
CONSTRAINT fk_tb_enfermeiros_matricula FOREIGN KEY(matricula)
	REFERENCES tb_funcionarios(matricula),
CONSTRAINT pk_tb_enfermeiros_matricula PRIMARY KEY(matricula)
);

--CRIANDO O OBJETO "tb_medicos"
--RESTRICOES: PK E FK APLICADA A COLUNA "matricula"
create table tb_medicos(
matricula 	INTEGER,
CRM			INTEGER,
CONSTRAINT fk_tb_medicos_matricula FOREIGN KEY(matricula)
	REFERENCES tb_funcionarios(matricula),
CONSTRAINT pk_tb_medicos_matricula PRIMARY KEY(matricula)
);

--CRIANDO O OBJETO "tb_tipo_comodo"
--RESTRICOES: PK APLICADA A COLUNA id
create table tb_tipo_comodo(
id			INTEGER,
descricao	VARCHAR(24),
CONSTRAINT pk_tb_tipo_comodo_id PRIMARY KEY(id)
);

--CRIANDO O OBJETO "tb_comodo"
--RESTRIÇÕES: PK APLICADA A COLUNA "numero" E FK APLICADA A COLUNA "id"
create table tb_comodo(
numero		INTEGER,
id			INTEGER,
situacao	BOOL,
CONSTRAINT pk_tb_comodo_numero PRIMARY KEY(numero),
CONSTRAINT fk_tb_comodo_id FOREIGN KEY(id)
	REFERENCES tb_tipo_comodo(id)
);

--CRIANDO O OBJETO "tb_leito"
--RESTRICOES: PK APLICADA A COLUNA "numeroLeito" E FK APLICADA A COLUNA "numero"
create table tb_leito(
numeroLeito	INTEGER,
numero		INTEGER,
situaçaoLeito	BOOL,
CONSTRAINT pk_tb_leito_numeroLeito PRIMARY KEY(numeroLeito),
CONSTRAINT fk_tb_leito_numero FOREIGN KEY(numero)
	REFERENCES tb_comodo(numero)
);

--CRIANDO O OBJETO "tb_alocacao_comodo_enfermeiro"
create table tb_alocacao_comodo_enfermeiro(
numero		INTEGER,
matricula	INTEGER,
CONSTRAINT pk_tb_alocacao_comodo_enfermeiro_numero_matricula PRIMARY KEY(numero, matricula),
CONSTRAINT fk_tb_alocacao_comodo_enfermeiro_numero FOREIGN KEY(numero)
	REFERENCES tb_comodo(numero),
CONSTRAINT fk_tb_alocacao_comodo_enfermeiro_matricula FOREIGN KEY(matricula)
	REFERENCES tb_enfermeiro(matricula)
);

--CRIANDO O OBJETO "tb_planoConvenio"
create table tb_planoConvenio(
codigo		INTEGER,
nome_plano	VARCHAR(20),
CONSTRAINT pk_tb_planoConvenio PRIMARY KEY(codigo)
);

--CRIANDO O OBJETO "tb_paciente"
create table tb_paciente(
codigo_paciente		INTEGER,
numeroLeito	INTEGER,
matricula	INTEGER,
codigo		INTEGER,
nome		VARCHAR(60),
sexo		VARCHAR(20),
data_inicio	DATE,
data_fim	DATE,
CONSTRAINT pk_tb_paciente_codigo PRIMARY KEY(codigo_paciente),
CONSTRAINT fk_tb_paciente_numeroLeito FOREIGN KEY(numeroLeito)
	REFERENCES tb_leito(numeroLeito),
CONSTRAINT fk_tb_paciente_matricula FOREIGN KEY(matricula)
	REFERENCES tb_medicos(matriclua),
CONSTRAINT fk_tb_paciente_codigo FOREIGN KEY(codigo)
	REFERENCES tb_leito(codigo)
);