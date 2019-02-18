CREATE ROLE trans_madeira LOGIN
  SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;

CREATE SCHEMA avaliacao_tecnica
  AUTHORIZATION trans_madeira;
GRANT USAGE ON SCHEMA avaliacao_tecnica TO trans_madeira;

GRANT ALL ON SCHEMA avaliacao_tecnica TO trans_madeira;
COMMENT ON SCHEMA avaliacao_tecnica
  IS 'Schema utilizado para armazenar todos os dados da Trans-madeira';

CREATE TABLE avaliacao_tecnica."Usuario"
(
  data_cadastro timestamp without time zone,
  nome_completo character(70),
  cpf character(14) NOT NULL,
  login character(30),
  senha character(30),
  email character(40),
  endereco character(200),
  celular character(15),
  data_nascimento timestamp without time zone,
  CONSTRAINT "Usuario_pkey" PRIMARY KEY (cpf)
);

CREATE TABLE avaliacao_tecnica."Veiculo"
(
  capacidade double precision,
  altura double precision,
  comprimento double precision,
  largura double precision,
  status boolean,
  ano_fabricacao date,
  data_cadastro timestamp without time zone,
  cod_veiculo integer NOT NULL,
  CONSTRAINT "Veiculo_pkey" PRIMARY KEY (cod_veiculo)
);

CREATE TABLE avaliacao_tecnica."Fluvial"
(
  id_embarcacao integer NOT NULL,
  tipo_embarcacao character(50),
  nome_hidrovia character(50),
  codigo_veiculo integer,
  CONSTRAINT "Fluvial_pkey" PRIMARY KEY (id_embarcacao)
);

CREATE TABLE avaliacao_tecnica."Ferroviario"
(
  numero integer NOT NULL,
  linha character(25),
  numero_vagoes integer,
  codigo_veiculo integer,
  CONSTRAINT "Ferroviario_pkey" PRIMARY KEY (numero)
);

CREATE TABLE avaliacao_tecnica."Estado"
(
  nome character(25),
  codigo_estado integer NOT NULL,
  CONSTRAINT "Estado_pkey" PRIMARY KEY (codigo_estado)
);

CREATE TABLE avaliacao_tecnica."Madeira"
(
  nome_especie character(30) NOT NULL,
  nome_cientifico character(30),
  CONSTRAINT "Madeira_pkey" PRIMARY KEY (nome_especie)
);

CREATE TABLE avaliacao_tecnica."Maritimo"
(
  pais character(18),
  id_embarcacao integer NOT NULL,
  codigo_veiculo integer,
  numero_inscricao integer,
  CONSTRAINT "Maritimo_pkey" PRIMARY KEY (id_embarcacao)
);

CREATE TABLE avaliacao_tecnica."Municipio"
(
  nome character(30) NOT NULL,
  estado character(25),
  CONSTRAINT "Municipio_pkey" PRIMARY KEY (nome)
);

CREATE TABLE avaliacao_tecnica."Proprietario"
(
  cpf_proprietario character(15) NOT NULL,
  login character(30),
  senha character(30),
  data_cadastro timestamp without time zone,
  nome_completo character(70),
  endereco character(200),
  celular character(15),
  email character(70),
  data_nascimento date,
  cpf_do_usuario character(15),
  nome_do_usuario character(70),
  CONSTRAINT "Proprietario_pkey" PRIMARY KEY (cpf_proprietario)
);

CREATE TABLE avaliacao_tecnica."Rodoviario"
(
  placa character(8) NOT NULL,
  modelo character(25),
  renavam character(11),
  chassi character(17),
  marca character(25),
  codigo_veiculo integer,
  CONSTRAINT "Rodoviario_pkey" PRIMARY KEY (placa),
  CONSTRAINT "Rodoviario_codigo_veiculo_fkey" FOREIGN KEY (codigo_veiculo)
      REFERENCES avaliacao_tecnica."Veiculo" (cod_veiculo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE avaliacao_tecnica."Empreendimento"
(
  cnpj character(30) NOT NULL,
  razao_social character(30),
  nome_fantasia character(30),
  nome_proprietario character(70),
  codigo_veiculo integer,
  CONSTRAINT "Empreendimento_pkey" PRIMARY KEY (cnpj),
  CONSTRAINT "Empreendimento_codigo_veiculo_fkey" FOREIGN KEY (codigo_veiculo)
      REFERENCES avaliacao_tecnica."Veiculo" (cod_veiculo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE avaliacao_tecnica."Rota"
(
  data_cadastro timestamp without time zone,
  municipio_origem character(30),
  municipio_destino character(30),
  estado_origem character(30),
  estado_destino character(30),
  id_rota integer NOT NULL,
  codigo_veiculo integer,
  nome_especie character(50),
  tipo_rota character(30),
  CONSTRAINT "Rota_pkey" PRIMARY KEY (id_rota),
  CONSTRAINT "Rota_codigo_veiculo_fkey" FOREIGN KEY (codigo_veiculo)
      REFERENCES avaliacao_tecnica."Veiculo" (cod_veiculo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE avaliacao_tecnica."GTF"
(
  id_gtf integer NOT NULL,
  id_rota integer,
  codigo_veiculo integer,
  madeira_especie character(50),
  data_validade timestamp without time zone,
  volume_transportado double precision,
  tipo_rota character(30),
  CONSTRAINT "GTF_pkey" PRIMARY KEY (id_gtf),
  CONSTRAINT "GTF_codigo_veiculo_fkey" FOREIGN KEY (codigo_veiculo)
      REFERENCES avaliacao_tecnica."Veiculo" (cod_veiculo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "GTF_id_rota_fkey" FOREIGN KEY (id_rota)
      REFERENCES avaliacao_tecnica."Rota" (id_rota) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "GTF_madeira_especie_fkey" FOREIGN KEY (madeira_especie)
      REFERENCES avaliacao_tecnica."Madeira" (nome_especie) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE avaliacao_tecnica."GTF3"
(
  valor double precision,
  data_gerado timestamp without time zone,
  data_validade timestamp without time zone,
  numero_dae integer NOT NULL,
  id_gtf3 integer,
  tp_rota character(30),
  CONSTRAINT "GTF3_pkey" PRIMARY KEY (numero_dae)
);

CREATE VIEW avaliacao_tecnica.somatorio_volume_gtf AS
 SELECT sum("GTF".volume_transportado) AS volume_cumaru_jatoba_sucupira_respectivamente
 FROM avaliacao_tecnica."GTF"
 where "GTF".madeira_especie = 'Cumaru'UNION
 SELECT sum("GTF".volume_transportado)
 FROM avaliacao_tecnica."GTF"
 where "GTF".madeira_especie = 'Sucupira' UNION
 SELECT sum("GTF".volume_transportado)
 FROM avaliacao_tecnica."GTF"
 where "GTF".madeira_especie = 'Jatobá' ;

CREATE VIEW avaliacao_tecnica.view_gtf AS
 SELECT g.madeira_especie,
    g.volume_transportado,
    r.municipio_origem,
    r.municipio_destino,
    v.capacidade,
    e.nome_fantasia
   FROM (((avaliacao_tecnica."GTF" g
     JOIN avaliacao_tecnica."Rota" r ON ((g.id_rota = r.id_rota)))
     JOIN avaliacao_tecnica."Veiculo" v ON ((r.codigo_veiculo = v.cod_veiculo)))
     JOIN avaliacao_tecnica."Empreendimento" e ON ((v.cod_veiculo = e.codigo_veiculo)));

INSERT INTO avaliacao_tecnica."Madeira" (nome_especie, nome_cientifico) VALUES ('Cumaru','Bowdichia nitida');
INSERT INTO avaliacao_tecnica."Madeira" (nome_especie, nome_cientifico) VALUES ('Sucupira','Dipteryx odorata');
INSERT INTO avaliacao_tecnica."Madeira" (nome_especie, nome_cientifico) VALUES ('Jatobá','Hymenaea courbaril');
INSERT INTO avaliacao_tecnica."Estado" (nome,codigo_estado)
VALUES ('Minas Gerais','110');
INSERT INTO avaliacao_tecnica."Estado" (nome,codigo_estado)
VALUES ('São Paulo','100');
INSERT INTO avaliacao_tecnica."Municipio" (nome,estado)
VALUES ('Patrocínio','Minas Gerais');
INSERT INTO avaliacao_tecnica."Municipio" (nome,estado)
VALUES ('Lavras','Minas Gerais');
INSERT INTO avaliacao_tecnica."Municipio" (nome,estado)
VALUES ('Ribeirão Preto','São Paulo');
INSERT INTO avaliacao_tecnica."Municipio" (nome,estado)
VALUES ('Franca','São Paulo');
INSERT INTO avaliacao_tecnica."Usuario" (cpf,login,senha,data_cadastro,nome_completo,endereco, celular,email,data_nascimento)
VALUES ('134.938.886-60','lucasPellaquim','senhadolucas','17-02-2019','Lucas Gonçalves Pellaquim', 'Elias Alves Cunha -1095. Nossa Senhora de Fátima','(34)98815-2387','lucaspellaqui.lp@gmail.com','01-03-1996');
INSERT INTO avaliacao_tecnica."Veiculo" (ano_fabricacao,capacidade,data_cadastro,altura,largura,comprimento,status,cod_veiculo)
VALUES ('01-01-2017','0','01-01-1901','5','4','20','true','100');
INSERT INTO avaliacao_tecnica."Veiculo" (ano_fabricacao,capacidade,data_cadastro,altura,largura,comprimento,status,cod_veiculo)
VALUES ('21-11-2013','0','01-01-1901','3','4','200','true','110');
INSERT INTO avaliacao_tecnica."Veiculo" (ano_fabricacao,capacidade,data_cadastro,altura,largura,comprimento,status,cod_veiculo)
VALUES ('07-12-2018','0','01-01-1901','4','4','25','true','120');
INSERT INTO avaliacao_tecnica."Veiculo" (ano_fabricacao,capacidade,data_cadastro,altura,largura,comprimento,status,cod_veiculo)
VALUES ('14-05-2007','0','01-01-1901','8','25','60','false','130');
INSERT INTO avaliacao_tecnica."Rodoviario" (placa,modelo,renavam,chassi,marca,codigo_veiculo)
VALUES ('ELZ-7505','Scania-p360','144003058','9bg116gw0400001','Scania','100');
INSERT INTO avaliacao_tecnica."Ferroviario" (numero,linha,numero_vagoes,codigo_veiculo)
VALUES ('15','23','20','110');
INSERT INTO avaliacao_tecnica."Fluvial" (tipo_embarcacao,nome_hidrovia,id_embarcacao,codigo_veiculo)
VALUES ('Chalana','Hidrovia do São Francisco','123','120');
INSERT INTO avaliacao_tecnica."Maritimo" (numero_inscricao,pais,id_embarcacao,codigo_veiculo)
VALUES ('55','Brasil','452','130');
INSERT INTO avaliacao_tecnica."Proprietario" (cpf_proprietario,login,senha,data_cadastro,nome_completo,endereco,celular,email,data_nascimento,cpf_do_usuario,nome_do_usuario)
VALUES ('155.695.365-52','MarcosFerreira2','senhadomarcos','01-04-2017','Marcos Ferreira Melo','São Gotardo','(34)99854-1254 ','marcos.ferreira@gmail.com','05-05-1990','134.938.886-60 ','Lucas Goncalves Pellaquim ');
INSERT INTO avaliacao_tecnica."Proprietario" (cpf_proprietario,login,senha,data_cadastro,nome_completo,endereco,celular,email,data_nascimento,cpf_do_usuario,nome_do_usuario)
VALUES ('159.091.115-28','V1_gomes','senhadovinicius','01-04-2017 ','Vinicius Gomes','Patos','(34)99211-4744 ','vinicius.gomes@gmail.com','21-12-1989','134.938.886-60 ','Lucas Goncalves Pellaquim ');
INSERT INTO avaliacao_tecnica."Proprietario" (cpf_proprietario,login,senha,data_cadastro,nome_completo,endereco,celular,email,data_nascimento,cpf_do_usuario,nome_do_usuario)
VALUES ('175.710.305-02','DudaFalcucci','senhadaduda','01-04-2017','Eduarda Falcucci Melo','Patrocínio','(34)98808-9080 ','duda.fmelo@gmail.com','18-08-1999','134.938.886-60 ','Lucas Goncalves Pellaquim ');
INSERT INTO avaliacao_tecnica."Empreendimento" (cnpj, razao_social, nome_fantasia, nome_proprietario,codigo_veiculo)
VALUES ('39.752.873/0005-90','Decora - Móveis planejados','Decora','Eduarda Falcucci Melo','100');
INSERT INTO avaliacao_tecnica."Empreendimento" (cnpj, razao_social, nome_fantasia, nome_proprietario,codigo_veiculo)
VALUES ('15.480.447/2587-04','Madereira Madsul','Madsul','Vinicius Gomes','110');
INSERT INTO avaliacao_tecnica."Empreendimento" (cnpj, razao_social, nome_fantasia, nome_proprietario,codigo_veiculo)
VALUES ('90.100.102/1036-61','Sacoman Design','Sacoman','Marcos Ferreira Melo','120');
INSERT INTO avaliacao_tecnica."GTF3" (valor,data_gerado,data_validade,numero_dae,tp_rota,id_gtf3)
VALUES ('500','17-02-2019','30-03-2019','18824019','Interestadual','3');
INSERT INTO avaliacao_tecnica."GTF3" (valor,data_gerado,data_validade,numero_dae,tp_rota,id_gtf3)
VALUES ('500','16-02-2019','28-03-2019','21185547','Interestadual','311');
INSERT INTO avaliacao_tecnica."Rota" (data_cadastro, municipio_origem, municipio_destino, estado_origem, estado_destino,id_rota,codigo_veiculo,nome_especie,tipo_rota)
VALUES ('17-02-2019','Patrocinio','Lavras','Minas Gerais','Minas Gerais','1','100','Jatobá','Intermunicipal');
INSERT INTO avaliacao_tecnica."Rota" (data_cadastro, municipio_origem, municipio_destino, estado_origem, estado_destino,id_rota,codigo_veiculo,nome_especie,tipo_rota)
VALUES ('17-02-2019','Patrocinio','Patrocinio','Minas Gerais','Minas Gerais','2','130','Sucupira','Municipal');
INSERT INTO avaliacao_tecnica."Rota" (data_cadastro, municipio_origem, municipio_destino, estado_origem, estado_destino,id_rota,codigo_veiculo,nome_especie,tipo_rota)
VALUES ('17-02-2019','Patrocinio','Ribeirão Ṕreto','Minas Gerais','São Paulo','3','120','Cumaru','Interestadual');
INSERT INTO avaliacao_tecnica."GTF" (id_gtf,id_rota,codigo_veiculo,madeira_especie,data_validade,volume_transportado,tipo_rota)
VALUES ('0017','1','110','Cumaru','01-04-2017','100','Intermunicipal');
INSERT INTO avaliacao_tecnica."GTF" (id_gtf,id_rota,codigo_veiculo,madeira_especie,data_validade,volume_transportado,tipo_rota)
VALUES ('0011','1','100','Jatobá','01-04-2017','150','Intermunicipal');
INSERT INTO avaliacao_tecnica."GTF" (id_gtf,id_rota,codigo_veiculo,madeira_especie,data_validade,volume_transportado,tipo_rota)
VALUES ('0015','2','120','Cumaru','01-04-2017','200','Municipal');
INSERT INTO avaliacao_tecnica."GTF" (id_gtf,id_rota,codigo_veiculo,madeira_especie,data_validade,volume_transportado,tipo_rota)
VALUES ('0020','3','120','Sucupira','01-04-2017','500','Interestadual');


CREATE OR REPLACE FUNCTION avaliacao_tecnica.datacadastroveiculo()
  RETURNS trigger AS
$BODY$
BEGIN

	UPDATE avaliacao_tecnica."Veiculo" SET "data_cadastro" = now();
	RETURN null;
END;
$BODY$
  LANGUAGE plpgsql

CREATE TRIGGER data_cadastro_veiculo
  AFTER INSERT
  ON avaliacao_tecnica."Veiculo"
  FOR EACH ROW
  EXECUTE PROCEDURE avaliacao_tecnica.datacadastroveiculo();



CREATE OR REPLACE FUNCTION avaliacao_tecnica.datacadastroproprietario()
  RETURNS trigger AS
$BODY$
BEGIN

	UPDATE avaliacao_tecnica."Proprietario" SET "data_cadastro" = now();
	RETURN null;
END;
$BODY$
  LANGUAGE plpgsql

CREATE TRIGGER data_cadastro_proprietario
  AFTER INSERT
  ON avaliacao_tecnica."Proprietario"
  FOR EACH ROW
  EXECUTE PROCEDURE avaliacao_tecnica.datacadastroproprietario();


CREATE OR REPLACE FUNCTION avaliacao_tecnica.calculacapacidade()
  RETURNS trigger AS
$BODY$ BEGIN
UPDATE avaliacao_tecnica."Veiculo" SET "capacidade" = (altura* largura* comprimento);
return new;
END; $BODY$
  LANGUAGE plpgsql

CREATE TRIGGER gatilhocapacidade
  AFTER INSERT
  ON avaliacao_tecnica."Veiculo"
  FOR EACH ROW
  EXECUTE PROCEDURE avaliacao_tecnica.calculacapacidade();


CREATE OR REPLACE FUNCTION avaliacao_tecnica.datacadastrousuario()
  RETURNS trigger AS
$BODY$
BEGIN

	UPDATE avaliacao_tecnica."Usuario" SET "data_cadastro" = now();
	RETURN null;
END;
$BODY$
  LANGUAGE plpgsql

CREATE TRIGGER data_cadastro_usuario
  AFTER INSERT
  ON avaliacao_tecnica."Usuario"
  FOR EACH STATEMENT
  EXECUTE PROCEDURE avaliacao_tecnica.datacadastrousuario();


CREATE OR REPLACE FUNCTION avaliacao_tecnica.data_cadastro_rota()
  RETURNS trigger AS
$BODY$
BEGIN

	UPDATE avaliacao_tecnica."Rota" SET "data_cadastro" = now();
	RETURN null;
END;
$BODY$
  LANGUAGE plpgsql

CREATE TRIGGER data_cadastrorota
  AFTER INSERT
  ON avaliacao_tecnica."Rota"
  FOR EACH STATEMENT
  EXECUTE PROCEDURE avaliacao_tecnica.data_cadastro_rota();
