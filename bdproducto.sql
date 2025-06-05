--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-06-05 13:52:51

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16392)
-- Name: Bodega; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bodega" (
    id character(15) NOT NULL,
    estado numeric DEFAULT 0,
    nombre character(50)
);


ALTER TABLE public."Bodega" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16407)
-- Name: Moneda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Moneda" (
    id character(15) NOT NULL,
    nombre character(50),
    estado numeric(11,0) DEFAULT 20
);


ALTER TABLE public."Moneda" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: Producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Producto" (
    codigo character(15) NOT NULL,
    nombre character(50),
    bodega_id character(15),
    sucursal_id character(15),
    moneda_id character(15),
    precio numeric,
    estado numeric,
    descripcion character(100)
);


ALTER TABLE public."Producto" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16399)
-- Name: Sucursal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sucursal" (
    id character(15) NOT NULL,
    nombre character(50),
    estado numeric DEFAULT 0,
    bodega_id character(15)
);


ALTER TABLE public."Sucursal" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16416)
-- Name: intereses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.intereses (
    id character(15) NOT NULL,
    nombre character(50),
    estado numeric
);


ALTER TABLE public.intereses OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16421)
-- Name: registro_intereses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registro_intereses (
    intereses_id character(15),
    producto_id character(15),
    id integer NOT NULL
);


ALTER TABLE public.registro_intereses OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16448)
-- Name: registro_intereses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.registro_intereses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.registro_intereses_id_seq OWNER TO postgres;

--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 223
-- Name: registro_intereses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.registro_intereses_id_seq OWNED BY public.registro_intereses.id;


--
-- TOC entry 4765 (class 2604 OID 16449)
-- Name: registro_intereses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_intereses ALTER COLUMN id SET DEFAULT nextval('public.registro_intereses_id_seq'::regclass);


--
-- TOC entry 4924 (class 0 OID 16392)
-- Dependencies: 218
-- Data for Name: Bodega; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Bodega" (id, estado, nombre) FROM stdin;
0              	0	central                                           
\.


--
-- TOC entry 4926 (class 0 OID 16407)
-- Dependencies: 220
-- Data for Name: Moneda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Moneda" (id, nombre, estado) FROM stdin;
0              	Dolar                                             	0
\.


--
-- TOC entry 4923 (class 0 OID 16389)
-- Dependencies: 217
-- Data for Name: Producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Producto" (codigo, nombre, bodega_id, sucursal_id, moneda_id, precio, estado, descripcion) FROM stdin;
asdasdasd      	asdasdasd                                         	0              	0              	0              	23123	\N	\N
asdasdaswd     	asdasd                                            	0              	0              	0              	213123	\N	\N
asdasdasddddd  	asdasd                                            	0              	0              	0              	123123	\N	\N
fdgdfgdfgdf    	adsasd                                            	0              	0              	0              	13123123	\N	\N
asdasd         	asdasd                                            	0              	0              	0              	123123123	\N	\N
asdasddddd     	asdasd                                            	0              	0              	0              	123123213	\N	\N
asdasdddddd    	asdasdas                                          	0              	0              	0              	123123123	\N	\N
ttttttttttt    	asdasdas                                          	0              	0              	0              	21312312	\N	\N
xcvxvxcvxcv    	asdasd                                            	0              	0              	0              	123123	\N	\N
asdasdbbbb     	asdasd                                            	0              	0              	0              	123123	\N	\N
asdasdbbbbx    	asdasd                                            	0              	0              	0              	123123	\N	\N
31312213       	asdasd                                            	0              	0              	0              	123123	\N	\N
asdasdbbbbxwww 	asdasd                                            	0              	0              	0              	123123	\N	\N
asdasdbbbbx2   	asdasd                                            	0              	0              	0              	123123	\N	654546456546546                                                                                     
asdasdbbbbff   	asdasd                                            	0              	0              	0              	123123	0	asdasdasdasd                                                                                        
\.


--
-- TOC entry 4925 (class 0 OID 16399)
-- Dependencies: 219
-- Data for Name: Sucursal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sucursal" (id, nombre, estado, bodega_id) FROM stdin;
0              	Central                                           	0	0              
\.


--
-- TOC entry 4927 (class 0 OID 16416)
-- Dependencies: 221
-- Data for Name: intereses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.intereses (id, nombre, estado) FROM stdin;
0              	Plástico                                          	0
1              	Metal                                             	0
2              	Madera                                            	0
3              	Vidrio                                            	0
4              	Textil                                            	0
\.


--
-- TOC entry 4928 (class 0 OID 16421)
-- Dependencies: 222
-- Data for Name: registro_intereses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registro_intereses (intereses_id, producto_id, id) FROM stdin;
0              	\N	1
1              	\N	2
0              	q              	3
1              	q              	4
1              	asdasdasd      	5
2              	asdasdasd      	6
1              	asdasdaswd     	7
2              	asdasdaswd     	8
0              	asdasdasddddd  	9
1              	asdasdasddddd  	10
0              	fdgdfgdfgdf    	11
1              	fdgdfgdfgdf    	12
0              	asdasd         	13
1              	asdasd         	14
0              	asdasddddd     	15
1              	asdasddddd     	16
1              	asdasdddddd    	17
2              	asdasdddddd    	18
0              	ttttttttttt    	19
1              	ttttttttttt    	20
1              	xcvxvxcvxcv    	21
2              	xcvxvxcvxcv    	22
0              	asdasdbbbb     	23
1              	asdasdbbbb     	24
0              	asdasdbbbbx    	25
1              	asdasdbbbbx    	26
0              	31312213       	27
1              	31312213       	28
0              	asdasdbbbbxwww 	29
2              	asdasdbbbbxwww 	30
0              	asdasdbbbbx2   	31
2              	asdasdbbbbx2   	32
0              	asdasdbbbbff   	33
2              	asdasdbbbbff   	34
\.


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 223
-- Name: registro_intereses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.registro_intereses_id_seq', 34, true);


--
-- TOC entry 4769 (class 2606 OID 16456)
-- Name: Bodega Bodega_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bodega"
    ADD CONSTRAINT "Bodega_pkey" PRIMARY KEY (id);


--
-- TOC entry 4773 (class 2606 OID 16470)
-- Name: Moneda Moneda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Moneda"
    ADD CONSTRAINT "Moneda_pkey" PRIMARY KEY (id);


--
-- TOC entry 4767 (class 2606 OID 16490)
-- Name: Producto Producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_pkey" PRIMARY KEY (codigo);


--
-- TOC entry 4775 (class 2606 OID 16548)
-- Name: intereses intereses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.intereses
    ADD CONSTRAINT intereses_pkey PRIMARY KEY (id);


--
-- TOC entry 4777 (class 2606 OID 16454)
-- Name: registro_intereses registro_intereses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registro_intereses
    ADD CONSTRAINT registro_intereses_pkey PRIMARY KEY (id);


--
-- TOC entry 4771 (class 2606 OID 16528)
-- Name: Sucursal sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sucursal"
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (id);


-- Completed on 2025-06-05 13:52:51

--
-- PostgreSQL database dump complete
--

