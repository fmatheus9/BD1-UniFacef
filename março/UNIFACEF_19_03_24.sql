--CRIANDO A TABELA "tb_projetos"
--RESTICOES: PK APLICADA A COLUNA "cod_projeto"
create table tb_projetos(
cod_projeto INTEGER,
nome_projeto VARCHAR(20),
CONSTRAINT pk_tb_projetos_cod_projeto PRIMARY KEY(cod_projeto)
);


--CRIANDO A TABELA "tb_departamentos"
--RESTRICAO: PK APLICADA A COLUNA "sigla"
create table tb_departamentos(
sigla VARCHAR(5),
nome_departamento VARCHAR(40),
ramal INTEGER,
CONSTRAINT pk_tb_dep_sigla PRIMARY KEY(sigla)
);


--CRIANDO A TABELA "tb_funcionarios"
--RESTRICOES: PK APLICADA A CLONUA "matricula_funcionario"
--			: FK APLICADA A COLUNA "sigla"
create table tb_funcionarios(
matricula_funcionario VARCHAR(20),
sigla VARCHAR(5),
nome_funcionario VARCHAR(40),
data_adimissao DATE,
data_nascimento DATE,
data_lotacao DATE,
CONSTRAINT pk_tb_funcionarios_matricula_func PRIMARY KEY(matricula_funcionario),
CONSTRAINT fk_tb_funcionarios_sigla FOREIGN KEY(sigla)
	REFERENCES tb_departamentos(sigla)
);


--CRIANDO A TABELA "tb_alocado"
--RESTRICOES: PK COMPOSTA APLICADA AS COLUNAS "cod_projeto + matricula_funcionario"
--			: FK APLICADA A COLUNA cod_projeto
--			: FK APLICADA A COLUNA matricula_funcionario
create table tb_alocado(
cod_projeto INTEGER,
matricula_funcionario VARCHAR(20),
data_alocacao DATE,
CONSTRAINT pk_tb_alocado_cod_projeto_matricula_funcionario PRIMARY KEY(cod_projeto,matricula_funcionario),
CONSTRAINT fk_tb_alocado_cod_projeto FOREIGN KEY(cod_projeto)
	REFERENCES tb_projetos(cod_projeto),
CONSTRAINT fk_tb_alocado_matricula_funcionario FOREIGN KEY(matricula_funcionario)
	REFERENCES tb_funcionarios(matricula_funcionario)
);