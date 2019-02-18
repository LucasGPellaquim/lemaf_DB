--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.6 (Ubuntu 10.6-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: avaliacao_tecnica; Type: SCHEMA; Schema: -; Owner: trans_madeira
--

CREATE SCHEMA avaliacao_tecnica;


ALTER SCHEMA avaliacao_tecnica OWNER TO trans_madeira;

--
-- Name: SCHEMA avaliacao_tecnica; Type: COMMENT; Schema: -; Owner: trans_madeira
--

COMMENT ON SCHEMA avaliacao_tecnica IS 'Schema utilizado para armazenar todos os dados da Trans-madeira';


--
-- Name: calculacapacidade(); Type: FUNCTION; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE FUNCTION avaliacao_tecnica.calculacapacidade() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN
UPDATE avaliacao_tecnica."Veiculo" SET "capacidade" = (altura* largura* comprimento);
return new;
END; $$;


ALTER FUNCTION avaliacao_tecnica.calculacapacidade() OWNER TO postgres;

--
-- Name: data_cadastro_rota(); Type: FUNCTION; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE FUNCTION avaliacao_tecnica.data_cadastro_rota() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

	UPDATE avaliacao_tecnica."Rota" SET "data_cadastro" = now();
	RETURN null;
END;
$$;


ALTER FUNCTION avaliacao_tecnica.data_cadastro_rota() OWNER TO postgres;

--
-- Name: datacadastroproprietario(); Type: FUNCTION; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE FUNCTION avaliacao_tecnica.datacadastroproprietario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

	UPDATE avaliacao_tecnica."Proprietario" SET "data_cadastro" = now();
	RETURN null;
END;
$$;


ALTER FUNCTION avaliacao_tecnica.datacadastroproprietario() OWNER TO postgres;

--
-- Name: datacadastrousuario(); Type: FUNCTION; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE FUNCTION avaliacao_tecnica.datacadastrousuario() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

	UPDATE avaliacao_tecnica."Usuario" SET "data_cadastro" = now();
	RETURN null;
END;
$$;


ALTER FUNCTION avaliacao_tecnica.datacadastrousuario() OWNER TO postgres;

--
-- Name: datacadastroveiculo(); Type: FUNCTION; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE FUNCTION avaliacao_tecnica.datacadastroveiculo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

	UPDATE avaliacao_tecnica."Veiculo" SET "data_cadastro" = now();
	RETURN null;
END;
$$;


ALTER FUNCTION avaliacao_tecnica.datacadastroveiculo() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Empreendimento; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Empreendimento" (
    cnpj character(30) NOT NULL,
    razao_social character(30),
    nome_fantasia character(30),
    nome_proprietario character(70),
    codigo_veiculo integer
);


ALTER TABLE avaliacao_tecnica."Empreendimento" OWNER TO postgres;

--
-- Name: Estado; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Estado" (
    nome character(25),
    codigo_estado integer NOT NULL
);


ALTER TABLE avaliacao_tecnica."Estado" OWNER TO postgres;

--
-- Name: Ferroviario; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Ferroviario" (
    numero integer NOT NULL,
    linha character(25),
    numero_vagoes integer,
    codigo_veiculo integer
);


ALTER TABLE avaliacao_tecnica."Ferroviario" OWNER TO postgres;

--
-- Name: Fluvial; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Fluvial" (
    id_embarcacao integer NOT NULL,
    tipo_embarcacao character(50),
    nome_hidrovia character(50),
    codigo_veiculo integer
);


ALTER TABLE avaliacao_tecnica."Fluvial" OWNER TO postgres;

--
-- Name: GTF; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."GTF" (
    id_gtf integer NOT NULL,
    id_rota integer,
    codigo_veiculo integer,
    madeira_especie character(50),
    data_validade timestamp without time zone,
    volume_transportado double precision,
    tipo_rota character(30)
);


ALTER TABLE avaliacao_tecnica."GTF" OWNER TO postgres;

--
-- Name: GTF3; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."GTF3" (
    valor double precision,
    data_gerado timestamp without time zone,
    data_validade timestamp without time zone,
    numero_dae integer NOT NULL,
    id_gtf3 integer,
    tp_rota character(30)
);


ALTER TABLE avaliacao_tecnica."GTF3" OWNER TO postgres;

--
-- Name: Madeira; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Madeira" (
    nome_especie character(30) NOT NULL,
    nome_cientifico character(30)
);


ALTER TABLE avaliacao_tecnica."Madeira" OWNER TO postgres;

--
-- Name: Maritimo; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Maritimo" (
    pais character(18),
    id_embarcacao integer NOT NULL,
    codigo_veiculo integer,
    numero_inscricao integer
);


ALTER TABLE avaliacao_tecnica."Maritimo" OWNER TO postgres;

--
-- Name: Municipio; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Municipio" (
    nome character(30) NOT NULL,
    estado character(25)
);


ALTER TABLE avaliacao_tecnica."Municipio" OWNER TO postgres;

--
-- Name: Proprietario; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Proprietario" (
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
    nome_do_usuario character(70)
);


ALTER TABLE avaliacao_tecnica."Proprietario" OWNER TO postgres;

--
-- Name: Rodoviario; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Rodoviario" (
    placa character(8) NOT NULL,
    modelo character(25),
    renavam character(11),
    chassi character(17),
    marca character(25),
    codigo_veiculo integer
);


ALTER TABLE avaliacao_tecnica."Rodoviario" OWNER TO postgres;

--
-- Name: Rota; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Rota" (
    data_cadastro timestamp without time zone,
    municipio_origem character(30),
    municipio_destino character(30),
    estado_origem character(30),
    estado_destino character(30),
    id_rota integer NOT NULL,
    codigo_veiculo integer,
    nome_especie character(50),
    tipo_rota character(30)
);


ALTER TABLE avaliacao_tecnica."Rota" OWNER TO postgres;

--
-- Name: Usuario; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Usuario" (
    data_cadastro timestamp without time zone,
    nome_completo character(70),
    cpf character(14) NOT NULL,
    login character(30),
    senha character(30),
    email character(40),
    endereco character(200),
    celular character(15),
    data_nascimento timestamp without time zone
);


ALTER TABLE avaliacao_tecnica."Usuario" OWNER TO postgres;

--
-- Name: Veiculo; Type: TABLE; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TABLE avaliacao_tecnica."Veiculo" (
    capacidade double precision,
    altura double precision,
    comprimento double precision,
    largura double precision,
    status boolean,
    ano_fabricacao date,
    data_cadastro timestamp without time zone,
    cod_veiculo integer NOT NULL
);


ALTER TABLE avaliacao_tecnica."Veiculo" OWNER TO postgres;

--
-- Name: somatorio_volume_gtf; Type: VIEW; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE VIEW avaliacao_tecnica.somatorio_volume_gtf AS
 SELECT sum("GTF".volume_transportado) AS volume_cumaru_jatoba_sucupira_respectivamente
   FROM avaliacao_tecnica."GTF"
  WHERE ("GTF".madeira_especie = 'Cumaru'::bpchar)
UNION
 SELECT sum("GTF".volume_transportado) AS volume_cumaru_jatoba_sucupira_respectivamente
   FROM avaliacao_tecnica."GTF"
  WHERE ("GTF".madeira_especie = 'Sucupira'::bpchar)
UNION
 SELECT sum("GTF".volume_transportado) AS volume_cumaru_jatoba_sucupira_respectivamente
   FROM avaliacao_tecnica."GTF"
  WHERE ("GTF".madeira_especie = 'Jatobá'::bpchar);


ALTER TABLE avaliacao_tecnica.somatorio_volume_gtf OWNER TO postgres;

--
-- Name: view_gtf; Type: VIEW; Schema: avaliacao_tecnica; Owner: postgres
--

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


ALTER TABLE avaliacao_tecnica.view_gtf OWNER TO postgres;

--
-- Data for Name: Empreendimento; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Empreendimento" (cnpj, razao_social, nome_fantasia, nome_proprietario, codigo_veiculo) FROM stdin;
39.752.873/0005-90            	Decora - Móveis planejados    	Decora                        	Eduarda Falcucci Melo                                                 	100
15.480.447/2587-04            	Madereira Madsul              	Madsul                        	Vinicius Gomes                                                        	110
90.100.102/1036-61            	Sacoman Design                	Sacoman                       	Marcos Ferreira Melo                                                  	120
\.


--
-- Data for Name: Estado; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Estado" (nome, codigo_estado) FROM stdin;
Minas Gerais             	110
São Paulo                	100
\.


--
-- Data for Name: Ferroviario; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Ferroviario" (numero, linha, numero_vagoes, codigo_veiculo) FROM stdin;
15	23                       	20	110
\.


--
-- Data for Name: Fluvial; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Fluvial" (id_embarcacao, tipo_embarcacao, nome_hidrovia, codigo_veiculo) FROM stdin;
123	Chalana                                           	Hidrovia do São Francisco                         	120
\.


--
-- Data for Name: GTF; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."GTF" (id_gtf, id_rota, codigo_veiculo, madeira_especie, data_validade, volume_transportado, tipo_rota) FROM stdin;
17	1	110	Cumaru                                            	2017-04-01 00:00:00	100	Intermunicipal                
11	1	100	Jatobá                                            	2017-04-01 00:00:00	150	Intermunicipal                
15	2	120	Cumaru                                            	2017-04-01 00:00:00	200	Municipal                     
20	3	120	Sucupira                                          	2017-04-01 00:00:00	500	Interestadual                 
\.


--
-- Data for Name: GTF3; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."GTF3" (valor, data_gerado, data_validade, numero_dae, id_gtf3, tp_rota) FROM stdin;
500	2019-02-17 00:00:00	2019-03-30 00:00:00	18824019	3	Interestadual                 
500	2019-02-16 00:00:00	2019-03-28 00:00:00	21185547	311	Interestadual                 
\.


--
-- Data for Name: Madeira; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Madeira" (nome_especie, nome_cientifico) FROM stdin;
Cumaru                        	Bowdichia nitida              
Sucupira                      	Dipteryx odorata              
Jatobá                        	Hymenaea courbaril            
\.


--
-- Data for Name: Maritimo; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Maritimo" (pais, id_embarcacao, codigo_veiculo, numero_inscricao) FROM stdin;
Brasil            	452	130	55
\.


--
-- Data for Name: Municipio; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Municipio" (nome, estado) FROM stdin;
Patrocínio                    	Minas Gerais             
Lavras                        	Minas Gerais             
Ribeirão Preto                	São Paulo                
Franca                        	São Paulo                
\.


--
-- Data for Name: Proprietario; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Proprietario" (cpf_proprietario, login, senha, data_cadastro, nome_completo, endereco, celular, email, data_nascimento, cpf_do_usuario, nome_do_usuario) FROM stdin;
155.695.365-52 	MarcosFerreira2               	senhadomarcos                 	2017-04-01 00:00:00	Marcos Ferreira Melo                                                  	São Gotardo                                                                                                                                                                                             	(34)99854-1254 	marcos.ferreira@gmail.com                                             	1990-05-05	134.938.886-60 	Lucas Goncalves Pellaquim                                             
159.091.115-28 	V1_gomes                      	senhadovinicius               	2017-04-01 00:00:00	Vinicius Gomes                                                        	Patos                                                                                                                                                                                                   	(34)99211-4744 	vinicius.gomes@gmail.com                                              	1989-12-21	134.938.886-60 	Lucas Goncalves Pellaquim                                             
175.710.305-02 	DudaFalcucci                  	senhadaduda                   	2017-04-01 00:00:00	Eduarda Falcucci Melo                                                 	Patrocínio                                                                                                                                                                                              	(34)98808-9080 	duda.fmelo@gmail.com                                                  	1999-08-18	134.938.886-60 	Lucas Goncalves Pellaquim                                             
\.


--
-- Data for Name: Rodoviario; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Rodoviario" (placa, modelo, renavam, chassi, marca, codigo_veiculo) FROM stdin;
ELZ-7505	Scania-p360              	144003058  	9bg116gw0400001  	Scania                   	100
\.


--
-- Data for Name: Rota; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Rota" (data_cadastro, municipio_origem, municipio_destino, estado_origem, estado_destino, id_rota, codigo_veiculo, nome_especie, tipo_rota) FROM stdin;
2019-02-17 00:00:00	Patrocinio                    	Lavras                        	Minas Gerais                  	Minas Gerais                  	1	100	Jatobá                                            	Intermunicipal                
2019-02-17 00:00:00	Patrocinio                    	Patrocinio                    	Minas Gerais                  	Minas Gerais                  	2	130	Sucupira                                          	Municipal                     
2019-02-17 00:00:00	Patrocinio                    	Ribeirão Ṕreto                	Minas Gerais                  	São Paulo                     	3	120	Cumaru                                            	Interestadual                 
\.


--
-- Data for Name: Usuario; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Usuario" (data_cadastro, nome_completo, cpf, login, senha, email, endereco, celular, data_nascimento) FROM stdin;
2019-02-17 00:00:00	Lucas Gonçalves Pellaquim                                             	134.938.886-60	lucasPellaquim                	senhadolucas                  	lucaspellaqui.lp@gmail.com              	Elias Alves Cunha -1095. Nossa Senhora de Fátima                                                                                                                                                        	(34)98815-2387 	1996-03-01 00:00:00
\.


--
-- Data for Name: Veiculo; Type: TABLE DATA; Schema: avaliacao_tecnica; Owner: postgres
--

COPY avaliacao_tecnica."Veiculo" (capacidade, altura, comprimento, largura, status, ano_fabricacao, data_cadastro, cod_veiculo) FROM stdin;
0	5	20	4	t	2017-01-01	1901-01-01 00:00:00	100
0	3	200	4	t	2013-11-21	1901-01-01 00:00:00	110
0	4	25	4	t	2018-12-07	1901-01-01 00:00:00	120
0	8	60	25	f	2007-05-14	1901-01-01 00:00:00	130
\.


--
-- Name: Empreendimento Empreendimento_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Empreendimento"
    ADD CONSTRAINT "Empreendimento_pkey" PRIMARY KEY (cnpj);


--
-- Name: Estado Estado_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Estado"
    ADD CONSTRAINT "Estado_pkey" PRIMARY KEY (codigo_estado);


--
-- Name: Ferroviario Ferroviario_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Ferroviario"
    ADD CONSTRAINT "Ferroviario_pkey" PRIMARY KEY (numero);


--
-- Name: Fluvial Fluvial_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Fluvial"
    ADD CONSTRAINT "Fluvial_pkey" PRIMARY KEY (id_embarcacao);


--
-- Name: GTF3 GTF3_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."GTF3"
    ADD CONSTRAINT "GTF3_pkey" PRIMARY KEY (numero_dae);


--
-- Name: GTF GTF_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."GTF"
    ADD CONSTRAINT "GTF_pkey" PRIMARY KEY (id_gtf);


--
-- Name: Madeira Madeira_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Madeira"
    ADD CONSTRAINT "Madeira_pkey" PRIMARY KEY (nome_especie);


--
-- Name: Maritimo Maritimo_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Maritimo"
    ADD CONSTRAINT "Maritimo_pkey" PRIMARY KEY (id_embarcacao);


--
-- Name: Municipio Municipio_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Municipio"
    ADD CONSTRAINT "Municipio_pkey" PRIMARY KEY (nome);


--
-- Name: Proprietario Proprietario_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Proprietario"
    ADD CONSTRAINT "Proprietario_pkey" PRIMARY KEY (cpf_proprietario);


--
-- Name: Rodoviario Rodoviario_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Rodoviario"
    ADD CONSTRAINT "Rodoviario_pkey" PRIMARY KEY (placa);


--
-- Name: Rota Rota_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Rota"
    ADD CONSTRAINT "Rota_pkey" PRIMARY KEY (id_rota);


--
-- Name: Usuario Usuario_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Usuario"
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY (cpf);


--
-- Name: Veiculo Veiculo_pkey; Type: CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Veiculo"
    ADD CONSTRAINT "Veiculo_pkey" PRIMARY KEY (cod_veiculo);


--
-- Name: Proprietario data_cadastro_proprietario; Type: TRIGGER; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TRIGGER data_cadastro_proprietario AFTER INSERT ON avaliacao_tecnica."Proprietario" FOR EACH ROW EXECUTE PROCEDURE avaliacao_tecnica.datacadastroproprietario();


--
-- Name: Usuario data_cadastro_usuario; Type: TRIGGER; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TRIGGER data_cadastro_usuario AFTER INSERT ON avaliacao_tecnica."Usuario" FOR EACH STATEMENT EXECUTE PROCEDURE avaliacao_tecnica.datacadastrousuario();


--
-- Name: Veiculo data_cadastro_veiculo; Type: TRIGGER; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TRIGGER data_cadastro_veiculo AFTER INSERT ON avaliacao_tecnica."Veiculo" FOR EACH ROW EXECUTE PROCEDURE avaliacao_tecnica.datacadastroveiculo();


--
-- Name: Rota data_cadastrorota; Type: TRIGGER; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TRIGGER data_cadastrorota AFTER INSERT ON avaliacao_tecnica."Rota" FOR EACH STATEMENT EXECUTE PROCEDURE avaliacao_tecnica.data_cadastro_rota();


--
-- Name: Veiculo gatilhocapacidade; Type: TRIGGER; Schema: avaliacao_tecnica; Owner: postgres
--

CREATE TRIGGER gatilhocapacidade AFTER INSERT ON avaliacao_tecnica."Veiculo" FOR EACH ROW EXECUTE PROCEDURE avaliacao_tecnica.calculacapacidade();


--
-- Name: Empreendimento Empreendimento_codigo_veiculo_fkey; Type: FK CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Empreendimento"
    ADD CONSTRAINT "Empreendimento_codigo_veiculo_fkey" FOREIGN KEY (codigo_veiculo) REFERENCES avaliacao_tecnica."Veiculo"(cod_veiculo);


--
-- Name: GTF GTF_codigo_veiculo_fkey; Type: FK CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."GTF"
    ADD CONSTRAINT "GTF_codigo_veiculo_fkey" FOREIGN KEY (codigo_veiculo) REFERENCES avaliacao_tecnica."Veiculo"(cod_veiculo);


--
-- Name: GTF GTF_id_rota_fkey; Type: FK CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."GTF"
    ADD CONSTRAINT "GTF_id_rota_fkey" FOREIGN KEY (id_rota) REFERENCES avaliacao_tecnica."Rota"(id_rota);


--
-- Name: GTF GTF_madeira_especie_fkey; Type: FK CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."GTF"
    ADD CONSTRAINT "GTF_madeira_especie_fkey" FOREIGN KEY (madeira_especie) REFERENCES avaliacao_tecnica."Madeira"(nome_especie);


--
-- Name: Rodoviario Rodoviario_codigo_veiculo_fkey; Type: FK CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Rodoviario"
    ADD CONSTRAINT "Rodoviario_codigo_veiculo_fkey" FOREIGN KEY (codigo_veiculo) REFERENCES avaliacao_tecnica."Veiculo"(cod_veiculo);


--
-- Name: Rota Rota_codigo_veiculo_fkey; Type: FK CONSTRAINT; Schema: avaliacao_tecnica; Owner: postgres
--

ALTER TABLE ONLY avaliacao_tecnica."Rota"
    ADD CONSTRAINT "Rota_codigo_veiculo_fkey" FOREIGN KEY (codigo_veiculo) REFERENCES avaliacao_tecnica."Veiculo"(cod_veiculo);


--
-- PostgreSQL database dump complete
--

