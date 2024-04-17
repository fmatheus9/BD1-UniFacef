--CRIANDO A TABELA CLINICAS:
--RESTRIÇÕES: CHAVE PRIMARIA PK, APLICADA A COLUNA CNPJ
CREATE TABLE tb_clinicas(
cnpj VARCHAR(15),
nm_clinica VARCHAR(60),
CONSTRAINT pk_tb_clinicas PRIMARY KEY(cnpj)
);
--CONSULTANDO O OBJETO "tb_clinicas"
SELECT *
FROM tb_clinicas;

--REALIZANDO UMA CARGA DE DADOS NA "tb_clinicas"
INSERT INTO tb_clinicas(cnpj, nm_clinica)
VALUES
('123456789100000', 'Clinica da Unimed'),
('123456789100004', 'Clinica da Santa Casa');


--CRIANDO A TABELA "tb_especialidades"
--RESTRIÇÃO: PK APLICADA A COLUNA "cod_especialidade"
CREATE TABLE tb_especialidades(
cod_especialidade INTEGER,
ds_especialidade VARCHAR(40),
CONSTRAINT pk_tb_especialidades_cod_esp PRIMARY KEY(cod_especialidade)
);
--CONSULTANDO O OBJETO "tb_especialidades"
SELECT *
FROM tb_especialidades;
INSERT INTO tb_especialidades(cod_especialidade, ds_especialidade)
VALUES
(1,'Cardiologia'),
(2,'Clinico Geral'),
(3, 'Ginecologia'),
(4, 'Ortopedia');


--CRIANDO A TABELA "tb_medicos"
--RESTRIÇÃO: UM PK APLICADA A COLUNA "crm_medicos"
--		   : UMA FK APLICADA A COLUNA "cod_especialidade"	
CREATE TABLE tb_medicos(
crm_medicos VARCHAR(8),
cod_especialidade INTEGER,
nm_medico VARCHAR(60),
salario NUMERIC(7,2),
CONSTRAINT pk_tb_medicos PRIMARY KEY(crm_medicos),
CONSTRAINT fk_tb_medicos_cod_esp FOREIGN KEY(cod_especialidade)
	REFERENCES tb_especialidades(cod_especialidade)
);


--CRIANDO A TABELA "tb_quartos"
--RESTRIÇÃO: UM PK APLICADA A COLUNA "num_quarto"
CREATE TABLE tb_quartos(
num_quarto INTEGER,
andar INTEGER,
tamanho FLOAT,
categoria VARCHAR(10),
CONSTRAINT pk_tb_quartos PRIMARY KEY(num_quarto)
);


--CRIANDO A TABELA "tb_paciente"
--RESTRIÇÃO: UM PK APLICADA A COLUNA "cpf"
--		   : FK APLICADA A COLUNA "num_quarto"
--		   : FK APLICADA A COLUNA "crm_medico"
--         : UNIQUE APLICADA A COLUNA "nr_quarto"
CREATE TABLE tb_pacientes(
cpf VARCHAR(11),
num_quarto INTEGER CONSTRAINT uq_tb_pacientes_nr_quaro UNIQUE,
crm_medico VARCHAR(8),
nm_paciente VARCHAR(60),
endereço VARCHAR(60),
rg VARCHAR(11),
telefone VARCHAR(15),
hr_visita TIME,
CONSTRAINT pk_tb_pacientes_cpf PRIMARY KEY(cpf),
CONSTRAINT fk_tb_pacientes_num_quartos FOREIGN KEY(num_quarto)
	REFERENCES tb_quartos(num_quarto),
CONSTRAINT fk_tb_pacientes_crm_medico FOREIGN KEY(crm_medico)
	REFERENCES tb_medicos(crm_medicos)
);


--CRIANDO A TABELA "tb_tratamentos"
--RESTRIÇÕES: PK COMPOSTAS PELA COLUNA "crm_medico" + "cpf"
--RESTRIÇÕES: FK APLICADA A COLUNA "crm_medico"
--RESTRIÇÕES: FK APLICADA A COLUNA "cpf"
CREATE TABLE tb_tratamentos(
crm_medico VARCHAR(8),
cpf VARCHAR(11),
CONSTRAINT pk_tb_tratamentos_crm_cpf PRIMARY KEY(crm_medico, cpf),
CONSTRAINT fk_tb_tratamentos_crm FOREIGN KEY(crm_medico)
	REFERENCES tb_medicos(crm_medicos),
CONSTRAINT fk_tb_tratamentos_cpf FOREIGN KEY(cpf)
	REFERENCES tb_pacientes(cpf)
);


--CRIANDO A TABELA "tb_clinicas_medicos"
--RESTRIÇÕES: PK COMPOSTAS PELA COLUNA "crm_medico" + "cnpj"
--RESTRIÇÕES: FK APLICADA A COLUNA "crm_medico"
--RESTRIÇÕES: FK APLICADA A COLUNA "cnpj"
CREATE TABLE tb_clinicas_medicos(
crm_medicos VARCHAR(8),
cnpj VARCHAR(15),
CONSTRAINT pk_tb_clinicas_medicos_crm_cnpj PRIMARY KEY(crm_medicos, cnpj),
CONSTRAINT fk_tb_clinicas_medicos_crm FOREIGN KEY(crm_medicos)
	REFERENCES tb_medicos(crm_medicos),
CONSTRAINT fk_tb_clinicas_medicos_cnpj FOREIGN KEY(cnpj)
	REFERENCES tb_clinicas(cnpj)
);


--CRIANDO A TABELA "tb_clinicas_pacientes"
--RESTRIÇÕES: PK COMPOSTAS PELA COLUNA "cpf" + "cnpj"
--RESTRIÇÕES: FK APLICADA A COLUNA "cpf"
--RESTRIÇÕES: FK APLICADA A COLUNA "cnpj"
CREATE TABLE tb_clinicas_pacientes(
cpf VARCHAR(11),
cnpj VARCHAR(15),
CONSTRAINT pk_tb_clinicas_pacientes_cpf_cnpj PRIMARY KEY(cpf, cnpj),
CONSTRAINT fk_tb_clinicas_pacientes_cpf FOREIGN KEY(cpf)
	REFERENCES tb_pacientes(cpf),
CONSTRAINT fk_tb_clinicas_pacientes_cnpj FOREIGN KEY(cnpj)
	REFERENCES tb_clinicas(cnpj)
);