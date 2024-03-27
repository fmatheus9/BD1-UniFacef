-- Data (27/03/2024)

-- Criando o objeto "tb_clientes"
CREATE TABLE tb_clientes(
rg_cliente			VARCHAR(11),
nm_cliente			VARCHAR(60),
dt_nascimento		DATE,
CONSTRAINT pk_tb_clientes_rg_cliente PRIMARY KEY(rg_cliente)	
);


-- Criando o objeto "tb_bibliotecarias"
CREATE TABLE tb_bibliotecarias(
rg_bibliotecaria			VARCHAR(11),
nm_bibliotecaria			VARCHAR(60),
dt_nascimento				DATE,
CONSTRAINT pk_tb_biblio_rg_biblio PRIMARY KEY(rg_bibliotecaria)	
);

-- Criando o objeto "tb_livros"
CREATE TABLE tb_livros(
codigo				INTEGER,
ds_livro			VARCHAR(25),
ds_categoria		VARCHAR(15),
rg_cliente			VARCHAR(11),
dt_devolucao		DATE,
rg_bibliotecaria	VARCHAR(11),
CONSTRAINT pk_tb_livros_codigo PRIMARY KEY(codigo),
CONSTRAINT fk_tb_livros_rg_cliente FOREIGN KEY(rg_cliente)
	REFERENCES tb_clientes(rg_cliente),
CONSTRAINT fk_tb_livros_rg_biblio FOREIGN KEY(rg_bibliotecaria)
	REFERENCES tb_bibliotecarias(rg_bibliotecaria)
);


-- Removendo o objeto "tb_clientes"
DROP TABLE tb_clientes CASCADE;

-- Recriando o objeto "tb_clientes" com uma nova estrutura
CREATE TABLE tb_clientes(
rg_cliente			VARCHAR(11),
nm_cliente			VARCHAR(60),
dt_nascimento		DATE,
CONSTRAINT pk_tb_clientes_rg_cliente PRIMARY KEY(rg_cliente)	
);

-- Criando o objeto "tb_contas"
CREATE TABLE tb_contas(
nr_conta			INTEGER,
ds_conta			VARCHAR(15),
dt_abertura			DATE,
CONSTRAINT pk_tb_contas_nr_conta PRIMARY KEY(nr_conta)	
);

-- Criando o objeto "tb_correntistas" caracterizado pelo exemplo como 
-- entidade associativa (N:N)
CREATE TABLE tb_correntistas(
rg_cliente				VARCHAR(11),
nr_conta				INTEGER,
CONSTRAINT pk_tb_correntistas_rg_nr PRIMARY KEY(rg_cliente, nr_conta),
CONSTRAINT fk_tb_correntistas_rg FOREIGN KEY(rg_cliente)
	REFERENCES tb_clientes(rg_cliente),
CONSTRAINT fk_tb_correntistas_nr FOREIGN KEY(nr_conta)
	REFERENCES tb_contas(nr_conta)
);

-- Criando o objeto "tb_cartoes_magneticos"
CREATE TABLE tb_cartoes_magneticos(
nr_cartao			INTEGER,
dt_expedicao		DATE,
rg_cliente			VARCHAR(11) CONSTRAINT nn_tb_cm_rg_cliente NOT NULL,
nr_conta			INTEGER CONSTRAINT nn_tb_cm_nr_conta NOT NULL,
CONSTRAINT pk_tb_cm_nr_cartao PRIMARY KEY(nr_cartao),
CONSTRAINT fk_tb_cm_rg_cliente FOREIGN KEY(rg_cliente)
	REFERENCES tb_clientes(rg_cliente),
CONSTRAINT fk_tb_cm_nr_conta FOREIGN KEY(nr_conta)
	REFERENCES tb_contas(nr_conta)
);

--CRIANDO O OBJETO "tb_instituicoes"
create table tb_instituicoes(
sigla 				CHAR(3),
nm_instituicao 		VARCHAR(60),
CONSTRAINT pk_tb_instituicoes_sigla PRIMARY KEY(sigla)
);


--CRIANDO O OBJETO "tb_projetos"
create table tb_projetos(
nr_projeto			INTEGER,
dp_projeto			VARCHAR(25),
constraint pk_tb_projetos_nr_projeto PRIMARY KEY(nr_projeto)
);

--CRAIANDO O OBJETO "tb_pesquisadores"
create table tb_pesquisadores(
rg_pesquisador 		VARCHAR(11),
nm_pesquisador		VARCHAR(60),
titulacao 			VARCHAR(15),
constraint pk_tb_pesquisadores_rg_pesquisador PRIMARY KEY(rg_pesquisador)
);

--CRIANDO O OBJETO "tb_pesquisas" para atender o relacionamento "N:N:N"
CREATE TABLE tb_pesquisas(
sigla			CHAR(3),
nr_projeto		INTEGER,
rg_pesquisador	VARCHAR(11),
CONSTRAINT pk_tb_pesquisas_sigla_nr_rg PRIMARY KEY(sigla, nr_projeto, rg_pesquisador), --CHAVE PRIMÁRIA COMPOSTA POR 3 COLUNAS, QUE TAMBEM SÃO ESTRANGEIRAS
CONSTRAINT fk_tb_pesquisas_sigla FOREIGN KEY(sigla)
	REFERENCES tb_instituicoes(sigla),
CONSTRAINT fk_tb_pesquisas_nr FOREIGN KEY(nr_projeto)
	REFERENCES tb_projetos(nr_projeto),
CONSTRAINT fk_tb_pesquisas_rg FOREIGN KEY(rg_pesquisador)
	REFERENCES tb_pesquisadores(rg_pesquisador)
);

-- Criando o objeto "tb_produtos"
CREATE TABLE tb_produtos(
codigo			INTEGER,
ds_produto		VARCHAR(25),
preco_venda		NUMERIC(5,2),
CONSTRAINT pk_tb_produtos_codigo PRIMARY KEY(codigo)	
);

-- Criando o objeto "tb_cidades"
CREATE TABLE tb_cidades(
codigo			INTEGER,
nm_cidade		VARCHAR(40),
estado			CHAR(2),
CONSTRAINT pk_tb_cidades_codigo PRIMARY KEY(codigo)	
);

-- Criando o objeto "tb_distribuidores"
CREATE TABLE tb_distribuidores(
rg_distribuidor			VARCHAR(11),
nm_distribidor			VARCHAR(60),
CONSTRAINT pk_tb_dist_rg_dist PRIMARY KEY(rg_distribuidor)	
);

-- Criando o objeto "tb_distribuicoes" para atender ao relacionamento "1:N:N"
CREATE TABLE tb_distribuicoes(
cod_produto			INTEGER,
cod_cidade			INTEGER,
rg_distribuidor		VARCHAR(11),
CONSTRAINT pk_tb_distribuicoes_cod_prod_cod_cid PRIMARY KEY(cod_produto, cod_cidade),
CONSTRAINT fk_tb_distribuicoes_cod_prod FOREIGN KEY(cod_produto)
	REFERENCES tb_produtos(codigo),
CONSTRAINT fk_tb_distribuicoes_cod_cid FOREIGN KEY(cod_cidade)
	REFERENCES tb_cidades(codigo),
CONSTRAINT fk_tb_distribuicoes_rg FOREIGN KEY(rg_distribuidor)
	REFERENCES tb_distribuidores(rg_distribuidor)
);


-- Criando o objeto "tb_bairros"
CREATE TABLE tb_bairros(
codigo			INTEGER,
ds_bairro		VARCHAR(25),
CONSTRAINT pk_tb_bairros_codigo PRIMARY KEY(codigo)	
);

-- Criando o objeto "tb_carteiros"
CREATE TABLE tb_carteiros(
rg_carteiro			VARCHAR(11),
nm_carteiro			VARCHAR(60),
dt_admissao			DATE,
CONSTRAINT pk_tb_carteiros_rg PRIMARY KEY(rg_carteiro)	
);

-- Criando o objeto "tb_correspondencias" o qual acomodará as chaves-estrangeira "1:1:N"
CREATE TABLE tb_correspondencias(
codigo			INTEGER,
peso			FLOAT,
cod_bairro		INTEGER,
rg_carteiro		VARCHAR(11),
CONSTRAINT pk_tb_correspondencias_codigo PRIMARY KEY(codigo),
CONSTRAINT fk_tb_correspondencias_cod_bairro FOREIGN KEY(cod_bairro)
	REFERENCES tb_bairros(codigo),
CONSTRAINT fk_tb_correspondencias_rg_carteiro FOREIGN KEY(rg_carteiro)
	REFERENCES tb_carteiros(rg_carteiro)
);




