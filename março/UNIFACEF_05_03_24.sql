-- Aqui criaremos o primeiro objeto a partir do DER lógico
--CRIA A TABELA COM O NOME DA TABELA;
--COLOCA AS COLUNAS DA TABELA E SEUS TIPOS PRIMITIVOS DE DADOS;
--COLOCA AS RESTRIÇÕES - Constraints nada mais são do que restrições de informações;
--			tipo da restrição - nome da tabela - coluna
--COLOCA AS REFERENCIAS CASO SEJA UMA RESTRIÇÃO ESTRANGEIRA


-- Criando o primeiro obj - "tb_curso"
-- Restrição: FK aplicada a coluna "cod_curso"
CREATE TABLE tb_curso(
cod_curso INTEGER,
nm_curso VARCHAR(40),
CONSTRAINT pk_tb_curso_cod_curso PRIMARY KEY(cod_curso)
);


--Compilando a tb_curso
SELECT + 
FROM tb_curso;


--Criando o segundo objeto - "tb_aluno"
--Restrição: PK aplicada a coluna "cod_aluno"
--			 FK aplicada a coluna "cod_curso"
CREATE TABLE tb_aluno(
cod_aluno INTEGER,
cod_curso INTEGER,
nm_aluno VARCHAR(60),
CONSTRAINT pk_tb_aluno_cod_aluno PRIMARY KEY(cod_aluno),
CONSTRAINT fk_tb_aluno_cod_curso FOREIGN KEY(cod_curso)
	REFERENCES tb_curso(cod_curso)
);


--Criando o terceiro objeto - "tb_departamento"
--Restrição: PK aplicada a coluna "cod_departamento"
CREATE TABLE tb_departamento(
cod_departamento INTEGER,
nm_departamento VARCHAR(40),
CONSTRAINT pk_tb_depto_cod_depto PRIMARY KEY(cod_departamento)
);


--Criando o quarto objeto - "tb_disciplina"
--Restrição: PK aplicada a "cod_disciplina"
--			 FK aplicada a "cod_departamento"
CREATE TABLE tb_disciplina(
cod_disciplina INTEGER,
cod_departamento INTEGER,
nm_disciplina VARCHAR(40),
credito INTEGER,
CONSTRAINT pk_tb_disciplina_cod_disciplina PRIMARY KEY(cod_disciplina),
CONSTRAINT fk_tb_disciplina_cod_depto FOREIGN KEY(cod_departamento)
	REFERENCES tb_departamento(cod_departamento)
);


--Criando o quinto obj - "tb_grade"
--Restrição: PK composta aplicada as colunas "cod_curso + cod_disciplina"
--			 FK aplicada a coluna "cod_curso"
--			 FK aplicada a coluna "cod_disciplina"
CREATE TABLE tb_grade(
cod_curso INTEGER,
cod_disciplina INTEGER,
CONSTRAINT pk_tb_grade_cod_curso_cod_disciplina
	PRIMARY KEY(cod_curso, cod_disciplina),
CONSTRAINT fk_tb_grade_cod_curso FOREIGN KEY(cod_curso)
	REFERENCES tb_curso(cod_curso),
CONSTRAINT fk_tb_grade_cod_disciplina FOREIGN KEY(cod_disciplina)
	REFERENCES tb_disciplina(cod_disciplina)
);


--Criando o sexto obj - "tb_pre_requisito"
--Restrição: PK composta aplicada a coluna a coluna "cod_disciplina_liberadora + cod_disciplina_liberada"
--			 FK composta aplicada a coluna
CREATE TABLE tb_pre_requisito(
cod_disciplina_liberadora INTEGER,
cod_disciplina_liberada INTEGER,
CONSTRAINT pk_tb_pre_requisito_liberada_liberadora
	PRIMARY KEY(cod_disciplina_liberada, cod_disciplina_liberadora),
CONSTRAINT fk_tb_pre_requisito_liberada
	FOREIGN KEY(cod_disciplina_liberada)
		REFERENCES tb_disciplina(cod_disciplina),
CONSTRAINT fk_tb_pre_requisito_liberadora
	FOREIGN KEY(cod_disciplina_liberadora)
		REFERENCES tb_disciplina(cod_disciplina)
);