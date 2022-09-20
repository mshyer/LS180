--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5 (Homebrew)
-- Dumped by pg_dump version 14.5 (Homebrew)

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

--
-- Name: spectral_type_enum; Type: TYPE; Schema: public; Owner: michaelshyer
--

CREATE TYPE public.spectral_type_enum AS ENUM (
    'O',
    'B',
    'A',
    'F',
    'G',
    'K',
    'M'
);


ALTER TYPE public.spectral_type_enum OWNER TO michaelshyer;

--
-- Name: moons_designation_sequence; Type: SEQUENCE; Schema: public; Owner: michaelshyer
--

CREATE SEQUENCE public.moons_designation_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moons_designation_sequence OWNER TO michaelshyer;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: moons; Type: TABLE; Schema: public; Owner: michaelshyer
--

CREATE TABLE public.moons (
    id integer NOT NULL,
    planet_id integer NOT NULL,
    designation integer DEFAULT nextval('public.moons_designation_sequence'::regclass) NOT NULL,
    semi_major_axis numeric,
    mass numeric,
    CONSTRAINT moons_mass_check CHECK ((mass > 0.0)),
    CONSTRAINT moons_semi_major_axis_check CHECK ((semi_major_axis > 0.0))
);


ALTER TABLE public.moons OWNER TO michaelshyer;

--
-- Name: moons_id_seq; Type: SEQUENCE; Schema: public; Owner: michaelshyer
--

ALTER TABLE public.moons ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.moons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: planets; Type: TABLE; Schema: public; Owner: michaelshyer
--

CREATE TABLE public.planets (
    id integer NOT NULL,
    designation character(1) NOT NULL,
    mass numeric NOT NULL,
    star_id integer NOT NULL,
    semi_major_axis numeric NOT NULL,
    CONSTRAINT planets_designation_check CHECK ((designation ~ similar_to_escape('[a-zA-Z]'::text))),
    CONSTRAINT planets_mass_check CHECK ((mass >= (0)::numeric))
);


ALTER TABLE public.planets OWNER TO michaelshyer;

--
-- Name: planets_id_seq; Type: SEQUENCE; Schema: public; Owner: michaelshyer
--

ALTER TABLE public.planets ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.planets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: stars; Type: TABLE; Schema: public; Owner: michaelshyer
--

CREATE TABLE public.stars (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    distance numeric NOT NULL,
    spectral_type public.spectral_type_enum NOT NULL,
    companions integer NOT NULL,
    CONSTRAINT stars_companions_check CHECK ((companions >= 0)),
    CONSTRAINT stars_distance_check CHECK ((distance > (0)::numeric))
);


ALTER TABLE public.stars OWNER TO michaelshyer;

--
-- Name: stars_id_seq; Type: SEQUENCE; Schema: public; Owner: michaelshyer
--

ALTER TABLE public.stars ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.stars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: moons; Type: TABLE DATA; Schema: public; Owner: michaelshyer
--

COPY public.moons (id, planet_id, designation, semi_major_axis, mass) FROM stdin;
\.


--
-- Data for Name: planets; Type: TABLE DATA; Schema: public; Owner: michaelshyer
--

COPY public.planets (id, designation, mass, star_id, semi_major_axis) FROM stdin;
\.


--
-- Data for Name: stars; Type: TABLE DATA; Schema: public; Owner: michaelshyer
--

COPY public.stars (id, name, distance, spectral_type, companions) FROM stdin;
1	Alpha Orionis	643	O	9
\.


--
-- Name: moons_designation_sequence; Type: SEQUENCE SET; Schema: public; Owner: michaelshyer
--

SELECT pg_catalog.setval('public.moons_designation_sequence', 1, false);


--
-- Name: moons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: michaelshyer
--

SELECT pg_catalog.setval('public.moons_id_seq', 1, false);


--
-- Name: planets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: michaelshyer
--

SELECT pg_catalog.setval('public.planets_id_seq', 1, false);


--
-- Name: stars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: michaelshyer
--

SELECT pg_catalog.setval('public.stars_id_seq', 1, true);


--
-- Name: moons moons_pkey; Type: CONSTRAINT; Schema: public; Owner: michaelshyer
--

ALTER TABLE ONLY public.moons
    ADD CONSTRAINT moons_pkey PRIMARY KEY (id);


--
-- Name: planets planets_designation_key; Type: CONSTRAINT; Schema: public; Owner: michaelshyer
--

ALTER TABLE ONLY public.planets
    ADD CONSTRAINT planets_designation_key UNIQUE (designation);


--
-- Name: planets planets_pkey; Type: CONSTRAINT; Schema: public; Owner: michaelshyer
--

ALTER TABLE ONLY public.planets
    ADD CONSTRAINT planets_pkey PRIMARY KEY (id);


--
-- Name: stars stars_name_key; Type: CONSTRAINT; Schema: public; Owner: michaelshyer
--

ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_name_key UNIQUE (name);


--
-- Name: stars stars_pkey; Type: CONSTRAINT; Schema: public; Owner: michaelshyer
--

ALTER TABLE ONLY public.stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (id);


--
-- Name: moons moons_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: michaelshyer
--

ALTER TABLE ONLY public.moons
    ADD CONSTRAINT moons_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planets(id);


--
-- Name: planets planets_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: michaelshyer
--

ALTER TABLE ONLY public.planets
    ADD CONSTRAINT planets_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.stars(id);


--
-- PostgreSQL database dump complete
--

