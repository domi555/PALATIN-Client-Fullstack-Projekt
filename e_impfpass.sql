--
-- PostgreSQL database dump
--

-- Dumped from database version 13.4
-- Dumped by pg_dump version 13.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: impfeintraege; Type: TABLE; Schema: public; Owner: dominikpalatin
--

CREATE TABLE public.impfeintraege (
    id integer NOT NULL,
    chargennummer character(10) NOT NULL,
    impfdatum timestamp without time zone NOT NULL,
    patienteninfo text,
    impfstoff_zulassungsnummer character(8) NOT NULL
);


ALTER TABLE public.impfeintraege OWNER TO dominikpalatin;

--
-- Name: impfeintraege_id_seq; Type: SEQUENCE; Schema: public; Owner: dominikpalatin
--

CREATE SEQUENCE public.impfeintraege_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.impfeintraege_id_seq OWNER TO dominikpalatin;

--
-- Name: impfeintraege_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dominikpalatin
--

ALTER SEQUENCE public.impfeintraege_id_seq OWNED BY public.impfeintraege.id;


--
-- Name: impfstoffe; Type: TABLE; Schema: public; Owner: dominikpalatin
--

CREATE TABLE public.impfstoffe (
    impfstoffname character varying(50) NOT NULL,
    zulassungsnummer character(8) NOT NULL,
    hersteller character varying(100) NOT NULL,
    einsatzzweck text NOT NULL
);


ALTER TABLE public.impfstoffe OWNER TO dominikpalatin;

--
-- Name: impfeintraege id; Type: DEFAULT; Schema: public; Owner: dominikpalatin
--

ALTER TABLE ONLY public.impfeintraege ALTER COLUMN id SET DEFAULT nextval('public.impfeintraege_id_seq'::regclass);


--
-- Data for Name: impfeintraege; Type: TABLE DATA; Schema: public; Owner: dominikpalatin
--

COPY public.impfeintraege (id, chargennummer, impfdatum, patienteninfo, impfstoff_zulassungsnummer) FROM stdin;
1	C-01104053	2021-05-09 14:21:51	Aufklärung ist erfolgt, Patient unauffällig, Impfstoff intravenös verabreicht	AZD12220
2	C-04839482	2021-07-12 14:23:35	Patient beschreibt Nebenwirkungen bei der 1. Impfung, Einnahme von Mexalen 500mg bei erneuten Auftreten einer Immunreaktion	AZD12220
3	fw04839482	2021-11-10 07:23:39	Patient unauffällig, 3. Schutzimpfung erhalten	BNT162b2
4	vetj341222	2020-08-15 10:32:58	Patient schildert starke Übelkeit, Überweisung in Algemeines KH Wien	PEIV0172
\.


--
-- Data for Name: impfstoffe; Type: TABLE DATA; Schema: public; Owner: dominikpalatin
--

COPY public.impfstoffe (impfstoffname, zulassungsnummer, hersteller, einsatzzweck) FROM stdin;
Comirnaty	BNT162b2	BioNTech, Fosun Pharma, Pfizer	SARS-CoV-2 Intramuskuläre Injektion / RNA
Spikevax	mRNA-127	Moderna, NIAID	SARS-CoV-2 Intramuskuläre Injektion / RNA
Vaxzevria	AZD12220	AstraZeneca, Universität Oxford	SARS-CoV-2 Intramuskuläre Injektion / Nicht replizierender viraler Vektor
Janssen	JNJ-7843	Janssen Pharmaceutical Companies	SARS-CoV-2 Intramuskuläre Injektion / Nicht replizierender viraler Vektor
Nobivac SHPPi	PEIV0172	Intervet	Lyophilisat und Lösungsmittel zur Herstellung einer Injektionssuspension, für Hunde – Staupe-Hepatitis contagiosa-Parvovirose-Parainfluenza-Lebendimpfstoff, gefriergetrocknet
\.


--
-- Name: impfeintraege_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dominikpalatin
--

SELECT pg_catalog.setval('public.impfeintraege_id_seq', 4, true);


--
-- Name: impfeintraege impfeintraege_pk; Type: CONSTRAINT; Schema: public; Owner: dominikpalatin
--

ALTER TABLE ONLY public.impfeintraege
    ADD CONSTRAINT impfeintraege_pk PRIMARY KEY (id);


--
-- Name: impfstoffe impfstoffe_pk; Type: CONSTRAINT; Schema: public; Owner: dominikpalatin
--

ALTER TABLE ONLY public.impfstoffe
    ADD CONSTRAINT impfstoffe_pk PRIMARY KEY (zulassungsnummer);


--
-- Name: impfstoffe_impfstoffname_uindex; Type: INDEX; Schema: public; Owner: dominikpalatin
--

CREATE UNIQUE INDEX impfstoffe_impfstoffname_uindex ON public.impfstoffe USING btree (impfstoffname);


--
-- Name: impfeintraege impfeintraege_impfstoffe_zulassungsnummer_fk; Type: FK CONSTRAINT; Schema: public; Owner: dominikpalatin
--

ALTER TABLE ONLY public.impfeintraege
    ADD CONSTRAINT impfeintraege_impfstoffe_zulassungsnummer_fk FOREIGN KEY (impfstoff_zulassungsnummer) REFERENCES public.impfstoffe(zulassungsnummer) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

