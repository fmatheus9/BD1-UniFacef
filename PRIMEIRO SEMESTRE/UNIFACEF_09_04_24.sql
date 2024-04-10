--CRIANDO A TABELA "tb_homens"
create table tb_homens(
rg VARCHAR(11),
nome_homem VARCHAR(40),
constraint pk_tb_homens_rg PRIMARY KEY(rg)
);

--CRIANDO A TABLEA "tb_mulheres"
create table tb_mulheres(
rg VARCHAR(11),
nome_mulher VARCHAR(40),
constraint pk_tb_mulheres_rg PRIMARY KEY(rg)
);

--CRIANDO A TABELA "tb_casamentos"
create table tb_casamentos(
rg_homem VARCHAR(11),
rg_mulher VARCHAR(11) constraint un_tb_casamentos_rg_mulher UNIQUE,
dt_casamento DATE,
constraint pk_tb_casamentos_rg_homem PRIMARY KEY(rg_homem),
constraint fk_tb_casamentos_rg_homem FOREIGN KEY(rg_homem)
	REFERENCES tb_homens(rg),
constraint fk_tb_casamentos_rg_mulher FOREIGN KEY(rg_mulher)
	REFERENCES tb_mulheres(rg)
);

--CIRANDO A TABELA "tb_departamentos"
create table tb_departamentos(
cod_departamento INTEGER,
nm_departamento VARCHAR(20),
ramal INTEGER,
constraint pk_tb_departamentos_cod_departamento PRIMARY KEY(cod_departamento)
);

--CRIANDO A TABELA "tb_empregados"
create table tb_empregados(
cpf VARCHAR(11),
nm_empregado VARCHAR(60),
cod_departamento INTEGER CONSTRAINT nn_tb_empregados_cod_departamento NOT NULL,
dt_locacao DATE,
CONSTRAINT pk_tb_empregados_cpf PRIMARY KEY(cpf),
CONSTRAINT fk_tb_empregados_cod_departamento FOREIGN KEY(cod_departamento)
	REFERENCES tb_departamentos(cod_departamento)
);

--CRIANDO A TABELA "tb_pessoas"
create table tb_pessoas(
rg VARCHAR(11),
nm_pessoa VARCHAR(60),
dt DATE,
CONSTRAINT pk_tb_pessoas_rg PRIMARY KEY(rg)
);

--CRIANDO A TABELA "tb_automoveis"
create table tb_automoveis(
chassi VARCHAR(17),
modelo VARCHAR(15),
ano INTEGER,
CONSTRAINT pk_tb_automoveis_chassi PRIMARY KEY(chassi)
);

--CRIANDO A TABELA "tb_posses"
create table tb_posses(
rg VARCHAR(11),
chassi VARCHAR(17),
dat_compra DATE,
CONSTRAINT pk_tb_posses_chassi PRIMARY KEY(chassi),
CONSTRAINT fk_tb_posses_chassi FOREIGN KEY(chassi)
	REFERENCES tb_automoveis(chassi),
CONSTRAINT fk_tb_posses_rg FOREIGN KEY(rg)
	REFERENCES tb_pessoas(rg)
);

--REMOVENDO A TABELA "tb_empregados"
DROP TABLE tb_empregados CASCADE --CASCADE REMOVE EVENTUAIS VÍNCULOS A TABELA REMOVIDA

--CRIANDO A TABELA "tb_empregados"
create table tb_empregados(
cpf_empregado VARCHAR(11),
nm_empregado VARCHAR(60),
CONSTRAINT pk_tb_empregados_cpf PRIMARY KEY(cpf_empregado)
);

--CRIANDO A TABELA "tb_projetos"
create table tb_projetos(
codigo INTEGER,
nm_projeto VARCHAR(15),
CONSTRAINT pk_projetos_codigo PRIMARY KEY(codigo)
);

--CRIANDO A TABELA "tb_participacoes"
create table tb_participacoes(
cpf VARCHAR(11),
codigo_projeto INTEGER,
data_inicio DATE,
CONSTRAINT pk_tb_participantes_cpf_codigo_projeto PRIMARY KEY(cpf, codigo_projeto),
CONSTRAINT fk_tb_participantes_cpf FOREIGN KEY(cpf)
	REFERENCES tb_empregados(cpf_empregado),
CONSTRAINT fk_tb_participante_cpf_codigo_projeto FOREIGN KEY(codigo_projeto)
	REFERENCES tb_projetos(codigo)
);

DROP TABLE tb_empregados CASCADE 

--RECRIANDO A TABELA "tb_empregados" QUE CONFIGURA UM AUTO-RELACIONAMENTO
create table tb_empregados(
cpf_empregado 	VARCHAR(11),
nm_empregado 	VARCHAR(60),
idade			INTEGER,
cpf_gerente		VARCHAR(11),
CONSTRAINT pk_tb_empregados_cpf PRIMARY KEY(cpf_empregado),
CONSTRAINT fk_tb_empregados_cpf_gerente FOREIGN KEY(cpf_gerente)
	REFERENCES tb_empregados(cpf_empregado) --CONFIGURA UM AUTORELACIONAMENTO POIS A CHAVE ESTRANGEIRA REFERENCIA A TABELA "tb_empregados"
);

--CONSULTAR A TABELA "tb_empregados"
SELECT *
FROM tb_empregados;

--REALIZANDO UMA CARGA DE DADOS COMO EXEMPLO DE UM AUTO-RELACIONAMENTO
insert into tb_empregados(cpf_empregado, nm_empregado, idade, cpf_gerente)
values
('111', 'Bruno da Silva', 29, NULL),
('222', 'Cintia Mendes Garcia', 30, '111'),
('333', 'Matheus Fagundes', 20, '111'),
('444', 'Beatriz Villaça', 20, '222');

--ELABORAR UM RELATÓRIO PARA EXIBIR O NOME DO EMPREGADO, JUNTO COM O NOME DO SEU RESPECTIVO GERENTE
SELECT e.nm_empregado || ' trabalha para ' || g.nm_empregado "Quem é gerente de quem?"
FROM tb_empregados e
INNER JOIN tb_empregados g ON(e.cpf_gerente = g.cpf_empregado)
ORDER BY e.nm_empregado;
