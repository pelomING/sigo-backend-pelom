--
-- PostgreSQL database dump
--

-- Dumped from database version 13.11
-- Dumped by pg_dump version 15.3

-- Started on 2023-10-23 12:46:02

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
-- TOC entry 9 (class 2615 OID 376991)
-- Name: _auth; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _auth;


ALTER SCHEMA _auth OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 376995)
-- Name: _comun; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _comun;


ALTER SCHEMA _comun OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 376990)
-- Name: obras; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA obras;


ALTER SCHEMA obras OWNER TO postgres;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 6 (class 2615 OID 376989)
-- Name: sae; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sae;


ALTER SCHEMA sae OWNER TO postgres;

--
-- TOC entry 10 (class 2615 OID 426154)
-- Name: temp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA temp;


ALTER SCHEMA temp OWNER TO postgres;

--
-- TOC entry 324 (class 1255 OID 450716)
-- Name: reservas_obras(); Type: FUNCTION; Schema: obras; Owner: postgres
--

CREATE FUNCTION obras.reservas_obras() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin

DELETE from obras.reservas_obras WHERE reserva not in 
	(select distinct on (reserva) reserva from obras.bom);
	
return new;
   
end
$$;


ALTER FUNCTION obras.reservas_obras() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 385780)
-- Name: personas; Type: TABLE; Schema: _auth; Owner: postgres
--

CREATE TABLE _auth.personas (
    id integer NOT NULL,
    rut character varying(30) NOT NULL,
    apellido_1 character varying(50) NOT NULL,
    apellido_2 character varying(50),
    nombres character varying(100) NOT NULL,
    base integer,
    cliente integer,
    id_funcion integer,
    activo boolean DEFAULT true
);


ALTER TABLE _auth.personas OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 385784)
-- Name: personas_id_seq; Type: SEQUENCE; Schema: _auth; Owner: postgres
--

CREATE SEQUENCE _auth.personas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _auth.personas_id_seq OWNER TO postgres;

--
-- TOC entry 3897 (class 0 OID 0)
-- Dependencies: 229
-- Name: personas_id_seq; Type: SEQUENCE OWNED BY; Schema: _auth; Owner: postgres
--

ALTER SEQUENCE _auth.personas_id_seq OWNED BY _auth.personas.id;


--
-- TOC entry 211 (class 1259 OID 385602)
-- Name: roles; Type: TABLE; Schema: _auth; Owner: postgres
--

CREATE TABLE _auth.roles (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    sistema boolean DEFAULT false
);


ALTER TABLE _auth.roles OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 385846)
-- Name: user_roles; Type: TABLE; Schema: _auth; Owner: postgres
--

CREATE TABLE _auth.user_roles (
    "roleId" integer NOT NULL,
    "userId" integer NOT NULL
);


ALTER TABLE _auth.user_roles OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 385825)
-- Name: users; Type: TABLE; Schema: _auth; Owner: postgres
--

CREATE TABLE _auth.users (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE _auth.users OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 385831)
-- Name: users_id_seq; Type: SEQUENCE; Schema: _auth; Owner: postgres
--

CREATE SEQUENCE _auth.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _auth.users_id_seq OWNER TO postgres;

--
-- TOC entry 3898 (class 0 OID 0)
-- Dependencies: 233
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: _auth; Owner: postgres
--

ALTER SEQUENCE _auth.users_id_seq OWNED BY _auth.users.id;


--
-- TOC entry 223 (class 1259 OID 385710)
-- Name: base; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.base (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    id_paquete integer
);


ALTER TABLE _comun.base OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 385809)
-- Name: camionetas; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.camionetas (
    id integer NOT NULL,
    patente character varying(10) NOT NULL,
    marca character varying(20) NOT NULL,
    modelo character varying(20),
    id_base integer,
    activa boolean DEFAULT true,
    observacion character varying(50)
);


ALTER TABLE _comun.camionetas OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 385813)
-- Name: camionetas_id_seq; Type: SEQUENCE; Schema: _comun; Owner: postgres
--

CREATE SEQUENCE _comun.camionetas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _comun.camionetas_id_seq OWNER TO postgres;

--
-- TOC entry 3899 (class 0 OID 0)
-- Dependencies: 231
-- Name: camionetas_id_seq; Type: SEQUENCE OWNED BY; Schema: _comun; Owner: postgres
--

ALTER SEQUENCE _comun.camionetas_id_seq OWNED BY _comun.camionetas.id;


--
-- TOC entry 218 (class 1259 OID 385662)
-- Name: cliente; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.cliente (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE _comun.cliente OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 385665)
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: _comun; Owner: postgres
--

CREATE SEQUENCE _comun.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _comun.cliente_id_seq OWNER TO postgres;

--
-- TOC entry 3900 (class 0 OID 0)
-- Dependencies: 219
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: _comun; Owner: postgres
--

ALTER SEQUENCE _comun.cliente_id_seq OWNED BY _comun.cliente.id;


--
-- TOC entry 217 (class 1259 OID 385648)
-- Name: comunas; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.comunas (
    codigo character varying(5) NOT NULL,
    nombre character varying,
    provincia character varying
);


ALTER TABLE _comun.comunas OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 385638)
-- Name: eventos_tipo; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.eventos_tipo (
    id integer NOT NULL,
    codigo character varying(5) NOT NULL,
    descripcion character varying(100) NOT NULL
);


ALTER TABLE _comun.eventos_tipo OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 385641)
-- Name: eventos_tipo_id_seq; Type: SEQUENCE; Schema: _comun; Owner: postgres
--

CREATE SEQUENCE _comun.eventos_tipo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _comun.eventos_tipo_id_seq OWNER TO postgres;

--
-- TOC entry 3901 (class 0 OID 0)
-- Dependencies: 216
-- Name: eventos_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: _comun; Owner: postgres
--

ALTER SEQUENCE _comun.eventos_tipo_id_seq OWNED BY _comun.eventos_tipo.id;


--
-- TOC entry 214 (class 1259 OID 385630)
-- Name: meses; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.meses (
    id integer NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE _comun.meses OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 385670)
-- Name: paquete; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.paquete (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    id_zonal integer NOT NULL
);


ALTER TABLE _comun.paquete OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 385616)
-- Name: provincias; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.provincias (
    codigo character varying(3) NOT NULL,
    nombre character varying,
    region character varying
);


ALTER TABLE _comun.provincias OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 385608)
-- Name: regiones; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.regiones (
    codigo character varying(2) NOT NULL,
    nombre character varying
);


ALTER TABLE _comun.regiones OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 385721)
-- Name: servicio_comuna; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.servicio_comuna (
    id integer NOT NULL,
    servicio character varying(10) NOT NULL,
    comuna character varying(5) NOT NULL,
    paquete integer NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE _comun.servicio_comuna OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 385725)
-- Name: servicio_comuna_id_seq; Type: SEQUENCE; Schema: _comun; Owner: postgres
--

CREATE SEQUENCE _comun.servicio_comuna_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _comun.servicio_comuna_id_seq OWNER TO postgres;

--
-- TOC entry 3902 (class 0 OID 0)
-- Dependencies: 225
-- Name: servicio_comuna_id_seq; Type: SEQUENCE OWNED BY; Schema: _comun; Owner: postgres
--

ALTER SEQUENCE _comun.servicio_comuna_id_seq OWNED BY _comun.servicio_comuna.id;


--
-- TOC entry 209 (class 1259 OID 385590)
-- Name: servicios; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.servicios (
    id integer NOT NULL,
    codigo character varying(10) NOT NULL,
    descripcion character varying(100) NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    sae boolean DEFAULT false NOT NULL
);


ALTER TABLE _comun.servicios OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 385595)
-- Name: servicios_id_seq; Type: SEQUENCE; Schema: _comun; Owner: postgres
--

CREATE SEQUENCE _comun.servicios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _comun.servicios_id_seq OWNER TO postgres;

--
-- TOC entry 3903 (class 0 OID 0)
-- Dependencies: 210
-- Name: servicios_id_seq; Type: SEQUENCE OWNED BY; Schema: _comun; Owner: postgres
--

ALTER SEQUENCE _comun.servicios_id_seq OWNED BY _comun.servicios.id;


--
-- TOC entry 208 (class 1259 OID 385583)
-- Name: tipo_funcion_personal; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.tipo_funcion_personal (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    sistema boolean,
    maestro boolean DEFAULT false,
    ayudante boolean DEFAULT false
);


ALTER TABLE _comun.tipo_funcion_personal OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 385575)
-- Name: turnos; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.turnos (
    id integer NOT NULL,
    inicio time without time zone NOT NULL,
    fin time without time zone NOT NULL,
    observacion character varying(50)
);


ALTER TABLE _comun.turnos OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 385578)
-- Name: turnos_id_seq; Type: SEQUENCE; Schema: _comun; Owner: postgres
--

CREATE SEQUENCE _comun.turnos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE _comun.turnos_id_seq OWNER TO postgres;

--
-- TOC entry 3904 (class 0 OID 0)
-- Dependencies: 207
-- Name: turnos_id_seq; Type: SEQUENCE OWNED BY; Schema: _comun; Owner: postgres
--

ALTER SEQUENCE _comun.turnos_id_seq OWNED BY _comun.turnos.id;


--
-- TOC entry 205 (class 1259 OID 385570)
-- Name: zonal; Type: TABLE; Schema: _comun; Owner: postgres
--

CREATE TABLE _comun.zonal (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE _comun.zonal OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 386030)
-- Name: maestro_actividades; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.maestro_actividades (
    id integer NOT NULL,
    actividad character varying,
    id_tipo_actividad integer NOT NULL,
    uc_instalacion double precision,
    uc_retiro double precision,
    uc_traslado double precision,
    descripcion text
);


ALTER TABLE obras.maestro_actividades OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 386036)
-- Name: actividades_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.actividades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.actividades_id_seq OWNER TO postgres;

--
-- TOC entry 3905 (class 0 OID 0)
-- Dependencies: 252
-- Name: actividades_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.actividades_id_seq OWNED BY obras.maestro_actividades.id;


--
-- TOC entry 253 (class 1259 OID 386038)
-- Name: actividades_obra; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.actividades_obra (
    id bigint NOT NULL,
    clase character(1),
    actividad bigint,
    cantidad numeric,
    id_obra bigint NOT NULL
);


ALTER TABLE obras.actividades_obra OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 386044)
-- Name: actividades_obra_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.actividades_obra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.actividades_obra_id_seq OWNER TO postgres;

--
-- TOC entry 3906 (class 0 OID 0)
-- Dependencies: 254
-- Name: actividades_obra_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.actividades_obra_id_seq OWNED BY obras.actividades_obra.id;


--
-- TOC entry 255 (class 1259 OID 386046)
-- Name: adicionales_edp; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.adicionales_edp (
    id bigint NOT NULL,
    id_encabezado_edp bigint,
    clase character(1),
    actividad bigint,
    cantidad numeric
);


ALTER TABLE obras.adicionales_edp OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 386052)
-- Name: adicionales_edp_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.adicionales_edp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.adicionales_edp_id_seq OWNER TO postgres;

--
-- TOC entry 3907 (class 0 OID 0)
-- Dependencies: 256
-- Name: adicionales_edp_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.adicionales_edp_id_seq OWNED BY obras.adicionales_edp.id;


--
-- TOC entry 257 (class 1259 OID 386054)
-- Name: bom; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.bom (
    id bigint NOT NULL,
    id_obra bigint NOT NULL,
    reserva bigint,
    codigo_sap_material bigint,
    cantidad_requerida numeric
);


ALTER TABLE obras.bom OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 386057)
-- Name: bom_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.bom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.bom_id_seq OWNER TO postgres;

--
-- TOC entry 3908 (class 0 OID 0)
-- Dependencies: 258
-- Name: bom_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.bom_id_seq OWNED BY obras.bom.id;


--
-- TOC entry 259 (class 1259 OID 386059)
-- Name: coordinadores_contratista; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.coordinadores_contratista (
    id integer NOT NULL,
    nombre character varying,
    id_empresa integer NOT NULL,
    rut character varying NOT NULL
);


ALTER TABLE obras.coordinadores_contratista OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 386065)
-- Name: coordinadores_contratista_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.coordinadores_contratista_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.coordinadores_contratista_id_seq OWNER TO postgres;

--
-- TOC entry 3909 (class 0 OID 0)
-- Dependencies: 260
-- Name: coordinadores_contratista_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.coordinadores_contratista_id_seq OWNED BY obras.coordinadores_contratista.id;


--
-- TOC entry 261 (class 1259 OID 386067)
-- Name: delegaciones; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.delegaciones (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE obras.delegaciones OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 386073)
-- Name: delegaciones_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.delegaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.delegaciones_id_seq OWNER TO postgres;

--
-- TOC entry 3910 (class 0 OID 0)
-- Dependencies: 262
-- Name: delegaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.delegaciones_id_seq OWNED BY obras.delegaciones.id;


--
-- TOC entry 263 (class 1259 OID 386075)
-- Name: detalle_edp; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.detalle_edp (
    id bigint NOT NULL,
    id_encabezado_edp bigint,
    clase character(1),
    actividad bigint,
    cantidad numeric
);


ALTER TABLE obras.detalle_edp OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 386081)
-- Name: detalle_edp_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.detalle_edp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.detalle_edp_id_seq OWNER TO postgres;

--
-- TOC entry 3911 (class 0 OID 0)
-- Dependencies: 264
-- Name: detalle_edp_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.detalle_edp_id_seq OWNED BY obras.detalle_edp.id;


--
-- TOC entry 265 (class 1259 OID 386083)
-- Name: detalle_pedido_material; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.detalle_pedido_material (
    id bigint NOT NULL,
    id_encabezado_pedido bigint NOT NULL,
    id_bom bigint,
    cantidad_requerida numeric,
    cantidad_entregada numeric,
    id_obra bigint
);


ALTER TABLE obras.detalle_pedido_material OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 386089)
-- Name: detalle_pedido_material_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.detalle_pedido_material_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.detalle_pedido_material_id_seq OWNER TO postgres;

--
-- TOC entry 3912 (class 0 OID 0)
-- Dependencies: 266
-- Name: detalle_pedido_material_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.detalle_pedido_material_id_seq OWNED BY obras.detalle_pedido_material.id;


--
-- TOC entry 267 (class 1259 OID 386091)
-- Name: detalle_reporte_diario_actividad; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.detalle_reporte_diario_actividad (
    id bigint NOT NULL,
    tipo_operacion integer,
    id_actividad bigint NOT NULL,
    cantidad numeric,
    id_encabezado_rep bigint
);


ALTER TABLE obras.detalle_reporte_diario_actividad OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 386097)
-- Name: detalle_reporte_diario_actividad_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.detalle_reporte_diario_actividad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.detalle_reporte_diario_actividad_id_seq OWNER TO postgres;

--
-- TOC entry 3913 (class 0 OID 0)
-- Dependencies: 268
-- Name: detalle_reporte_diario_actividad_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.detalle_reporte_diario_actividad_id_seq OWNED BY obras.detalle_reporte_diario_actividad.id;


--
-- TOC entry 269 (class 1259 OID 386099)
-- Name: detalle_reporte_diario_material; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.detalle_reporte_diario_material (
    id bigint NOT NULL,
    tipo_operacion integer,
    id_material bigint NOT NULL,
    cantidad numeric,
    id_encabezado_rep bigint
);


ALTER TABLE obras.detalle_reporte_diario_material OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 386105)
-- Name: detalle_reporte_diario_material_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.detalle_reporte_diario_material_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.detalle_reporte_diario_material_id_seq OWNER TO postgres;

--
-- TOC entry 3914 (class 0 OID 0)
-- Dependencies: 270
-- Name: detalle_reporte_diario_material_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.detalle_reporte_diario_material_id_seq OWNED BY obras.detalle_reporte_diario_material.id;


--
-- TOC entry 271 (class 1259 OID 386107)
-- Name: detalle_reporte_diario_otras_actividades; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.detalle_reporte_diario_otras_actividades (
    id bigint NOT NULL,
    glosa text,
    uc_unitaria numeric,
    cantidad numeric,
    total_uc numeric,
    id_encabezado_rep bigint
);


ALTER TABLE obras.detalle_reporte_diario_otras_actividades OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 386113)
-- Name: detalle_reporte_diario_otras_actividades_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.detalle_reporte_diario_otras_actividades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.detalle_reporte_diario_otras_actividades_id_seq OWNER TO postgres;

--
-- TOC entry 3915 (class 0 OID 0)
-- Dependencies: 272
-- Name: detalle_reporte_diario_otras_actividades_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.detalle_reporte_diario_otras_actividades_id_seq OWNED BY obras.detalle_reporte_diario_otras_actividades.id;


--
-- TOC entry 273 (class 1259 OID 386115)
-- Name: empresas_contratista; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.empresas_contratista (
    id integer NOT NULL,
    nombre character varying,
    rut character varying
);


ALTER TABLE obras.empresas_contratista OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 386121)
-- Name: empresas_contratista_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.empresas_contratista_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.empresas_contratista_id_seq OWNER TO postgres;

--
-- TOC entry 3916 (class 0 OID 0)
-- Dependencies: 274
-- Name: empresas_contratista_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.empresas_contratista_id_seq OWNED BY obras.empresas_contratista.id;


--
-- TOC entry 275 (class 1259 OID 386123)
-- Name: encabezado_edp; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.encabezado_edp (
    id bigint NOT NULL,
    id_cliente integer NOT NULL,
    fecha_asignacion date,
    tipo_trabajo integer,
    segmento integer,
    solicitante integer,
    numero_ot character varying,
    jefe_faena integer,
    comuna character varying(5) NOT NULL,
    direccion text,
    numero_flexiapp character varying,
    fecha_ejecucion date,
    gestor_cge character varying,
    nombre_obra text,
    recargo_trabajos_menores numeric,
    recargo_distancia numeric,
    recargo_horas_extra numeric
);


ALTER TABLE obras.encabezado_edp OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 386129)
-- Name: encabezado_edp_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.encabezado_edp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.encabezado_edp_id_seq OWNER TO postgres;

--
-- TOC entry 3917 (class 0 OID 0)
-- Dependencies: 276
-- Name: encabezado_edp_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.encabezado_edp_id_seq OWNED BY obras.encabezado_edp.id;


--
-- TOC entry 277 (class 1259 OID 386131)
-- Name: encabezado_pedido_material; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.encabezado_pedido_material (
    id bigint NOT NULL,
    solicitante text,
    fecha date,
    id_obra bigint NOT NULL,
    estado integer
);


ALTER TABLE obras.encabezado_pedido_material OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 386137)
-- Name: encabezado_pedido_material_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.encabezado_pedido_material_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.encabezado_pedido_material_id_seq OWNER TO postgres;

--
-- TOC entry 3918 (class 0 OID 0)
-- Dependencies: 278
-- Name: encabezado_pedido_material_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.encabezado_pedido_material_id_seq OWNED BY obras.encabezado_pedido_material.id;


--
-- TOC entry 279 (class 1259 OID 386139)
-- Name: encabezado_reporte_diario; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.encabezado_reporte_diario (
    id bigint NOT NULL,
    id_obra bigint NOT NULL,
    fecha_reporte date,
    jefe_faena text,
    sdi text,
    gestor_cliente text,
    id_area integer,
    brigada_pesada boolean,
    observaciones text,
    entregado_por_persona text,
    fecha_entregado date,
    revisado_por_persona text,
    fecha_revisado date,
    sector text,
    hora_salida_base timestamp without time zone,
    hora_llegada_terreno timestamp without time zone,
    hora_salida_terreno timestamp without time zone,
    hora_llegada_base timestamp without time zone
);


ALTER TABLE obras.encabezado_reporte_diario OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 386145)
-- Name: encabezado_reporte_diario_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.encabezado_reporte_diario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.encabezado_reporte_diario_id_seq OWNER TO postgres;

--
-- TOC entry 3919 (class 0 OID 0)
-- Dependencies: 280
-- Name: encabezado_reporte_diario_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.encabezado_reporte_diario_id_seq OWNED BY obras.encabezado_reporte_diario.id;


--
-- TOC entry 317 (class 1259 OID 418070)
-- Name: estado_obra; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.estado_obra (
    id integer NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE obras.estado_obra OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 418068)
-- Name: estado_obra_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.estado_obra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.estado_obra_id_seq OWNER TO postgres;

--
-- TOC entry 3920 (class 0 OID 0)
-- Dependencies: 316
-- Name: estado_obra_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.estado_obra_id_seq OWNED BY obras.estado_obra.id;


--
-- TOC entry 321 (class 1259 OID 450720)
-- Name: estado_visita; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.estado_visita (
    id integer NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE obras.estado_visita OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 450718)
-- Name: estado_visita_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.estado_visita_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.estado_visita_id_seq OWNER TO postgres;

--
-- TOC entry 3921 (class 0 OID 0)
-- Dependencies: 320
-- Name: estado_visita_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.estado_visita_id_seq OWNED BY obras.estado_visita.id;


--
-- TOC entry 281 (class 1259 OID 386147)
-- Name: estructura_material; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.estructura_material (
    id_estructura bigint NOT NULL,
    cod_sap_material bigint NOT NULL,
    cantidad bigint,
    unidad character varying
);


ALTER TABLE obras.estructura_material OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 386153)
-- Name: estructuras_obra; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.estructuras_obra (
    id_estructura bigint NOT NULL,
    id_obra bigint NOT NULL,
    cantidad numeric
);


ALTER TABLE obras.estructuras_obra OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 386159)
-- Name: jefes_faena; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.jefes_faena (
    id integer NOT NULL,
    nombre character varying
);


ALTER TABLE obras.jefes_faena OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 386165)
-- Name: jefes_faena_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.jefes_faena_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.jefes_faena_id_seq OWNER TO postgres;

--
-- TOC entry 3922 (class 0 OID 0)
-- Dependencies: 284
-- Name: jefes_faena_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.jefes_faena_id_seq OWNED BY obras.jefes_faena.id;


--
-- TOC entry 285 (class 1259 OID 386167)
-- Name: maestro_estructura; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.maestro_estructura (
    id integer NOT NULL,
    nomenclatura character varying,
    descripcion character varying
);


ALTER TABLE obras.maestro_estructura OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 386173)
-- Name: maestro_estructura_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.maestro_estructura_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.maestro_estructura_id_seq OWNER TO postgres;

--
-- TOC entry 3923 (class 0 OID 0)
-- Dependencies: 286
-- Name: maestro_estructura_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.maestro_estructura_id_seq OWNED BY obras.maestro_estructura.id;


--
-- TOC entry 287 (class 1259 OID 386175)
-- Name: maestro_materiales; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.maestro_materiales (
    codigo_sap bigint NOT NULL,
    texto_breve character varying,
    descripcion character varying,
    id_unidad integer
);


ALTER TABLE obras.maestro_materiales OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 386181)
-- Name: maestro_unidades; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.maestro_unidades (
    id integer NOT NULL,
    nombre character varying,
    codigo_corto character varying
);


ALTER TABLE obras.maestro_unidades OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 386187)
-- Name: maestro_unidades_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.maestro_unidades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.maestro_unidades_id_seq OWNER TO postgres;

--
-- TOC entry 3924 (class 0 OID 0)
-- Dependencies: 289
-- Name: maestro_unidades_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.maestro_unidades_id_seq OWNED BY obras.maestro_unidades.id;


--
-- TOC entry 290 (class 1259 OID 386189)
-- Name: obras; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.obras (
    id bigint NOT NULL,
    codigo_obra character varying NOT NULL,
    numero_ot character varying,
    nombre_obra character varying NOT NULL,
    zona integer,
    delegacion integer,
    gestor_cliente character varying,
    numero_aviso bigint,
    numero_oc character varying,
    monto bigint,
    cantidad_uc double precision,
    fecha_llegada date,
    fecha_inicio date,
    fecha_termino date,
    tipo_trabajo integer,
    persona_envia_info character varying,
    cargo_persona_envia_info character varying,
    empresa_contratista integer,
    coordinador_contratista integer,
    comuna character varying(5),
    ubicacion character varying,
    estado integer,
    tipo_obra integer,
    segmento integer,
    eliminada boolean DEFAULT false
);


ALTER TABLE obras.obras OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 386195)
-- Name: obras_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.obras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.obras_id_seq OWNER TO postgres;

--
-- TOC entry 3925 (class 0 OID 0)
-- Dependencies: 291
-- Name: obras_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.obras_id_seq OWNED BY obras.obras.id;


--
-- TOC entry 292 (class 1259 OID 386197)
-- Name: otros_cargos_edp; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.otros_cargos_edp (
    id bigint NOT NULL,
    glosa text,
    cantidad numeric,
    uc numeric,
    id_encabezado_edp bigint NOT NULL
);


ALTER TABLE obras.otros_cargos_edp OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 386203)
-- Name: otros_cargos_edp_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.otros_cargos_edp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.otros_cargos_edp_id_seq OWNER TO postgres;

--
-- TOC entry 3926 (class 0 OID 0)
-- Dependencies: 293
-- Name: otros_cargos_edp_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.otros_cargos_edp_id_seq OWNED BY obras.otros_cargos_edp.id;


--
-- TOC entry 294 (class 1259 OID 386205)
-- Name: otros_cargos_obra; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.otros_cargos_obra (
    id bigint NOT NULL,
    glosa text,
    cantidad numeric,
    uc numeric,
    id_obra bigint NOT NULL
);


ALTER TABLE obras.otros_cargos_obra OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 386211)
-- Name: recibido_bodega_pelom; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.recibido_bodega_pelom (
    id bigint NOT NULL,
    codigo_sap_material bigint,
    cantidad numeric,
    reserva bigint,
    guia_despacho bigint,
    fecha_recepcion date
);


ALTER TABLE obras.recibido_bodega_pelom OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 386217)
-- Name: recibido_bodega_pelom_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.recibido_bodega_pelom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.recibido_bodega_pelom_id_seq OWNER TO postgres;

--
-- TOC entry 3927 (class 0 OID 0)
-- Dependencies: 296
-- Name: recibido_bodega_pelom_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.recibido_bodega_pelom_id_seq OWNED BY obras.recibido_bodega_pelom.id;


--
-- TOC entry 319 (class 1259 OID 442524)
-- Name: reservas_obras; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.reservas_obras (
    reserva bigint NOT NULL,
    id_obra bigint NOT NULL
);


ALTER TABLE obras.reservas_obras OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 386219)
-- Name: segmento; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.segmento (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying
);


ALTER TABLE obras.segmento OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 386225)
-- Name: segmento_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.segmento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.segmento_id_seq OWNER TO postgres;

--
-- TOC entry 3928 (class 0 OID 0)
-- Dependencies: 298
-- Name: segmento_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.segmento_id_seq OWNED BY obras.segmento.id;


--
-- TOC entry 299 (class 1259 OID 386227)
-- Name: solicitantes; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.solicitantes (
    id integer NOT NULL,
    nombre character varying,
    id_delegacion integer NOT NULL
);


ALTER TABLE obras.solicitantes OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 386233)
-- Name: solicitantes_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.solicitantes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.solicitantes_id_seq OWNER TO postgres;

--
-- TOC entry 3929 (class 0 OID 0)
-- Dependencies: 300
-- Name: solicitantes_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.solicitantes_id_seq OWNED BY obras.solicitantes.id;


--
-- TOC entry 301 (class 1259 OID 386235)
-- Name: tipo_actividad; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.tipo_actividad (
    id bigint NOT NULL,
    descripcion character varying
);


ALTER TABLE obras.tipo_actividad OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 386241)
-- Name: tipo_actividad_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.tipo_actividad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.tipo_actividad_id_seq OWNER TO postgres;

--
-- TOC entry 3930 (class 0 OID 0)
-- Dependencies: 302
-- Name: tipo_actividad_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.tipo_actividad_id_seq OWNED BY obras.tipo_actividad.id;


--
-- TOC entry 303 (class 1259 OID 386243)
-- Name: tipo_obra; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.tipo_obra (
    id bigint NOT NULL,
    descripcion character varying
);


ALTER TABLE obras.tipo_obra OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 386249)
-- Name: tipo_obra_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.tipo_obra_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.tipo_obra_id_seq OWNER TO postgres;

--
-- TOC entry 3931 (class 0 OID 0)
-- Dependencies: 304
-- Name: tipo_obra_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.tipo_obra_id_seq OWNED BY obras.tipo_obra.id;


--
-- TOC entry 323 (class 1259 OID 467102)
-- Name: tipo_operacion; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.tipo_operacion (
    id integer NOT NULL,
    nombre character varying NOT NULL
);


ALTER TABLE obras.tipo_operacion OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 467100)
-- Name: tipo_operacion_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.tipo_operacion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.tipo_operacion_id_seq OWNER TO postgres;

--
-- TOC entry 3932 (class 0 OID 0)
-- Dependencies: 322
-- Name: tipo_operacion_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.tipo_operacion_id_seq OWNED BY obras.tipo_operacion.id;


--
-- TOC entry 305 (class 1259 OID 386251)
-- Name: tipo_trabajo; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.tipo_trabajo (
    id integer NOT NULL,
    descripcion character varying
);


ALTER TABLE obras.tipo_trabajo OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 386257)
-- Name: tipo_trabajo_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.tipo_trabajo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.tipo_trabajo_id_seq OWNER TO postgres;

--
-- TOC entry 3933 (class 0 OID 0)
-- Dependencies: 306
-- Name: tipo_trabajo_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.tipo_trabajo_id_seq OWNED BY obras.tipo_trabajo.id;


--
-- TOC entry 307 (class 1259 OID 386259)
-- Name: valor_uc; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.valor_uc (
    id integer NOT NULL,
    fecha date,
    precio numeric
);


ALTER TABLE obras.valor_uc OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 386265)
-- Name: valor_uc_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.valor_uc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.valor_uc_id_seq OWNER TO postgres;

--
-- TOC entry 3934 (class 0 OID 0)
-- Dependencies: 308
-- Name: valor_uc_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.valor_uc_id_seq OWNED BY obras.valor_uc.id;


--
-- TOC entry 309 (class 1259 OID 386267)
-- Name: visitas_terreno; Type: TABLE; Schema: obras; Owner: postgres
--

CREATE TABLE obras.visitas_terreno (
    id bigint NOT NULL,
    id_obra bigint NOT NULL,
    fecha_visita date,
    direccion character varying,
    persona_mandante character varying,
    cargo_mandante character varying,
    persona_contratista character varying,
    cargo_contratista character varying,
    observacion text,
    estado integer NOT NULL,
    fecha_modificacion date
);


ALTER TABLE obras.visitas_terreno OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 386273)
-- Name: visitas_terreno_id_seq; Type: SEQUENCE; Schema: obras; Owner: postgres
--

CREATE SEQUENCE obras.visitas_terreno_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE obras.visitas_terreno_id_seq OWNER TO postgres;

--
-- TOC entry 3935 (class 0 OID 0)
-- Dependencies: 310
-- Name: visitas_terreno_id_seq; Type: SEQUENCE OWNED BY; Schema: obras; Owner: postgres
--

ALTER SEQUENCE obras.visitas_terreno_id_seq OWNED BY obras.visitas_terreno.id;


--
-- TOC entry 315 (class 1259 OID 393393)
-- Name: _oficinas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._oficinas (
    id integer NOT NULL,
    nombre character varying(255),
    id_zonal integer
);


ALTER TABLE public._oficinas OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 385683)
-- Name: cargo_fijo; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.cargo_fijo (
    id integer NOT NULL,
    id_cliente integer,
    id_paquete integer,
    id_turno integer,
    valor bigint NOT NULL,
    observacion character varying(100),
    cantidad_brigada integer,
    CONSTRAINT valor_minimo CHECK ((valor >= 0))
);


ALTER TABLE sae.cargo_fijo OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 385687)
-- Name: cargo_fijo_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.cargo_fijo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.cargo_fijo_id_seq OWNER TO postgres;

--
-- TOC entry 3936 (class 0 OID 0)
-- Dependencies: 222
-- Name: cargo_fijo_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.cargo_fijo_id_seq OWNED BY sae.cargo_fijo.id;


--
-- TOC entry 235 (class 1259 OID 385861)
-- Name: movil_eventos; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.movil_eventos (
    id integer NOT NULL,
    estado integer NOT NULL,
    datos json NOT NULL,
    fecha_insert timestamp without time zone NOT NULL,
    fecha_update timestamp without time zone NOT NULL
);


ALTER TABLE sae.movil_eventos OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 385867)
-- Name: movil_eventos_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.movil_eventos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.movil_eventos_id_seq OWNER TO postgres;

--
-- TOC entry 3937 (class 0 OID 0)
-- Dependencies: 236
-- Name: movil_eventos_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.movil_eventos_id_seq OWNED BY sae.movil_eventos.id;


--
-- TOC entry 237 (class 1259 OID 385872)
-- Name: movil_jornadas; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.movil_jornadas (
    id integer NOT NULL,
    estado integer NOT NULL,
    datos json NOT NULL,
    fecha_insert timestamp without time zone NOT NULL,
    fecha_update timestamp without time zone NOT NULL
);


ALTER TABLE sae.movil_jornadas OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 385878)
-- Name: movil_jornadas_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.movil_jornadas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.movil_jornadas_id_seq OWNER TO postgres;

--
-- TOC entry 3938 (class 0 OID 0)
-- Dependencies: 238
-- Name: movil_jornadas_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.movil_jornadas_id_seq OWNED BY sae.movil_jornadas.id;


--
-- TOC entry 226 (class 1259 OID 385750)
-- Name: precios_base; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.precios_base (
    id integer NOT NULL,
    id_cliente integer,
    id_paquete integer,
    id_evento_tipo integer,
    id_turno integer,
    valor bigint NOT NULL,
    observacion character varying(100),
    CONSTRAINT valor_minimo CHECK ((valor >= 0))
);


ALTER TABLE sae.precios_base OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 385754)
-- Name: precios_base_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.precios_base_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.precios_base_id_seq OWNER TO postgres;

--
-- TOC entry 3939 (class 0 OID 0)
-- Dependencies: 227
-- Name: precios_base_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.precios_base_id_seq OWNED BY sae.precios_base.id;


--
-- TOC entry 239 (class 1259 OID 385883)
-- Name: reporte_detalle_estado_resultado; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.reporte_detalle_estado_resultado (
    id integer NOT NULL,
    id_estado_resultado integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE sae.reporte_detalle_estado_resultado OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 385886)
-- Name: reporte_detalle_estado_resultado_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.reporte_detalle_estado_resultado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.reporte_detalle_estado_resultado_id_seq OWNER TO postgres;

--
-- TOC entry 3940 (class 0 OID 0)
-- Dependencies: 240
-- Name: reporte_detalle_estado_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.reporte_detalle_estado_resultado_id_seq OWNED BY sae.reporte_detalle_estado_resultado.id;


--
-- TOC entry 241 (class 1259 OID 385891)
-- Name: reporte_errores; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.reporte_errores (
    id integer NOT NULL,
    tipo_tabla character varying(3),
    id_tabla bigint,
    descripcion text
);


ALTER TABLE sae.reporte_errores OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 385897)
-- Name: reporte_errores_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.reporte_errores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.reporte_errores_id_seq OWNER TO postgres;

--
-- TOC entry 3941 (class 0 OID 0)
-- Dependencies: 242
-- Name: reporte_errores_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.reporte_errores_id_seq OWNED BY sae.reporte_errores.id;


--
-- TOC entry 243 (class 1259 OID 385902)
-- Name: reporte_estado_resultado; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.reporte_estado_resultado (
    id integer NOT NULL,
    id_usuario integer,
    zona integer,
    paquete integer,
    mes integer,
    fecha_inicio timestamp without time zone,
    fecha_final timestamp without time zone,
    nombre_doc character varying NOT NULL,
    url_doc character varying NOT NULL,
    fecha_creacion timestamp without time zone,
    fecha_modificacion timestamp without time zone,
    estado integer,
    id_cliente integer NOT NULL
);


ALTER TABLE sae.reporte_estado_resultado OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 385908)
-- Name: reporte_estado_resultado_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.reporte_estado_resultado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.reporte_estado_resultado_id_seq OWNER TO postgres;

--
-- TOC entry 3942 (class 0 OID 0)
-- Dependencies: 244
-- Name: reporte_estado_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.reporte_estado_resultado_id_seq OWNED BY sae.reporte_estado_resultado.id;


--
-- TOC entry 245 (class 1259 OID 385931)
-- Name: reporte_estados; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.reporte_estados (
    id integer NOT NULL,
    nombre character varying(10) NOT NULL
);


ALTER TABLE sae.reporte_estados OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 385934)
-- Name: reporte_estados_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.reporte_estados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.reporte_estados_id_seq OWNER TO postgres;

--
-- TOC entry 3943 (class 0 OID 0)
-- Dependencies: 246
-- Name: reporte_estados_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.reporte_estados_id_seq OWNED BY sae.reporte_estados.id;


--
-- TOC entry 247 (class 1259 OID 385939)
-- Name: reporte_eventos; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.reporte_eventos (
    id integer NOT NULL,
    numero_ot character varying NOT NULL,
    tipo_evento character varying(5) NOT NULL,
    rut_maestro character varying(30) NOT NULL,
    rut_ayudante character varying(30) NOT NULL,
    codigo_turno integer NOT NULL,
    id_paquete integer NOT NULL,
    requerimiento character varying(255),
    direccion character varying(255),
    fecha_hora timestamp without time zone NOT NULL,
    estado integer,
    id_movil character varying,
    coordenadas json
);


ALTER TABLE sae.reporte_eventos OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 385945)
-- Name: reporte_eventos_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.reporte_eventos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.reporte_eventos_id_seq OWNER TO postgres;

--
-- TOC entry 3944 (class 0 OID 0)
-- Dependencies: 248
-- Name: reporte_eventos_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.reporte_eventos_id_seq OWNED BY sae.reporte_eventos.id;


--
-- TOC entry 249 (class 1259 OID 385985)
-- Name: reporte_jornada; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.reporte_jornada (
    id integer NOT NULL,
    rut_maestro character varying(30) NOT NULL,
    rut_ayudante character varying(30) NOT NULL,
    codigo_turno integer NOT NULL,
    patente character varying(10) NOT NULL,
    id_paquete integer NOT NULL,
    km_inicial bigint NOT NULL,
    km_final bigint NOT NULL,
    fecha_hora_ini timestamp without time zone NOT NULL,
    fecha_hora_fin timestamp without time zone NOT NULL,
    estado integer,
    id_movil character varying,
    coordenadas json
);


ALTER TABLE sae.reporte_jornada OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 385991)
-- Name: reporte_jornada_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.reporte_jornada_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.reporte_jornada_id_seq OWNER TO postgres;

--
-- TOC entry 3945 (class 0 OID 0)
-- Dependencies: 250
-- Name: reporte_jornada_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.reporte_jornada_id_seq OWNED BY sae.reporte_jornada.id;


--
-- TOC entry 314 (class 1259 OID 393384)
-- Name: resultado_estado_resultado; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.resultado_estado_resultado (
    id integer NOT NULL,
    id_usuario integer NOT NULL,
    zona integer NOT NULL,
    paquete integer NOT NULL,
    mes integer NOT NULL,
    fecha_inicio character varying(255) NOT NULL,
    fecha_final character varying(255) NOT NULL,
    nombre_doc character varying(255),
    url_doc character varying(255),
    fecha_creacion character varying(255),
    fecha_modificacion character varying(255),
    estado integer
);


ALTER TABLE sae.resultado_estado_resultado OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 393382)
-- Name: resultado_estado_resultado_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.resultado_estado_resultado_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.resultado_estado_resultado_id_seq OWNER TO postgres;

--
-- TOC entry 3946 (class 0 OID 0)
-- Dependencies: 313
-- Name: resultado_estado_resultado_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.resultado_estado_resultado_id_seq OWNED BY sae.resultado_estado_resultado.id;


--
-- TOC entry 312 (class 1259 OID 393374)
-- Name: resultado_estados; Type: TABLE; Schema: sae; Owner: postgres
--

CREATE TABLE sae.resultado_estados (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE sae.resultado_estados OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 393372)
-- Name: resultado_estados_id_seq; Type: SEQUENCE; Schema: sae; Owner: postgres
--

CREATE SEQUENCE sae.resultado_estados_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sae.resultado_estados_id_seq OWNER TO postgres;

--
-- TOC entry 3947 (class 0 OID 0)
-- Dependencies: 311
-- Name: resultado_estados_id_seq; Type: SEQUENCE OWNED BY; Schema: sae; Owner: postgres
--

ALTER SEQUENCE sae.resultado_estados_id_seq OWNED BY sae.resultado_estados.id;


--
-- TOC entry 318 (class 1259 OID 426155)
-- Name: rendimiento; Type: TABLE; Schema: temp; Owner: postgres
--

CREATE TABLE temp.rendimiento (
    cod_sap bigint,
    descripcion character varying,
    unidad character varying
);


ALTER TABLE temp.rendimiento OWNER TO postgres;

--
-- TOC entry 3308 (class 2604 OID 385786)
-- Name: personas id; Type: DEFAULT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.personas ALTER COLUMN id SET DEFAULT nextval('_auth.personas_id_seq'::regclass);


--
-- TOC entry 3312 (class 2604 OID 385833)
-- Name: users id; Type: DEFAULT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.users ALTER COLUMN id SET DEFAULT nextval('_auth.users_id_seq'::regclass);


--
-- TOC entry 3310 (class 2604 OID 385815)
-- Name: camionetas id; Type: DEFAULT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.camionetas ALTER COLUMN id SET DEFAULT nextval('_comun.camionetas_id_seq'::regclass);


--
-- TOC entry 3303 (class 2604 OID 385667)
-- Name: cliente id; Type: DEFAULT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.cliente ALTER COLUMN id SET DEFAULT nextval('_comun.cliente_id_seq'::regclass);


--
-- TOC entry 3302 (class 2604 OID 385643)
-- Name: eventos_tipo id; Type: DEFAULT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.eventos_tipo ALTER COLUMN id SET DEFAULT nextval('_comun.eventos_tipo_id_seq'::regclass);


--
-- TOC entry 3305 (class 2604 OID 385727)
-- Name: servicio_comuna id; Type: DEFAULT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicio_comuna ALTER COLUMN id SET DEFAULT nextval('_comun.servicio_comuna_id_seq'::regclass);


--
-- TOC entry 3298 (class 2604 OID 385597)
-- Name: servicios id; Type: DEFAULT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicios ALTER COLUMN id SET DEFAULT nextval('_comun.servicios_id_seq'::regclass);


--
-- TOC entry 3295 (class 2604 OID 385580)
-- Name: turnos id; Type: DEFAULT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.turnos ALTER COLUMN id SET DEFAULT nextval('_comun.turnos_id_seq'::regclass);


--
-- TOC entry 3322 (class 2604 OID 386275)
-- Name: actividades_obra id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.actividades_obra ALTER COLUMN id SET DEFAULT nextval('obras.actividades_obra_id_seq'::regclass);


--
-- TOC entry 3323 (class 2604 OID 386276)
-- Name: adicionales_edp id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.adicionales_edp ALTER COLUMN id SET DEFAULT nextval('obras.adicionales_edp_id_seq'::regclass);


--
-- TOC entry 3324 (class 2604 OID 386277)
-- Name: bom id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.bom ALTER COLUMN id SET DEFAULT nextval('obras.bom_id_seq'::regclass);


--
-- TOC entry 3325 (class 2604 OID 386278)
-- Name: coordinadores_contratista id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.coordinadores_contratista ALTER COLUMN id SET DEFAULT nextval('obras.coordinadores_contratista_id_seq'::regclass);


--
-- TOC entry 3326 (class 2604 OID 386279)
-- Name: delegaciones id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.delegaciones ALTER COLUMN id SET DEFAULT nextval('obras.delegaciones_id_seq'::regclass);


--
-- TOC entry 3327 (class 2604 OID 386280)
-- Name: detalle_edp id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_edp ALTER COLUMN id SET DEFAULT nextval('obras.detalle_edp_id_seq'::regclass);


--
-- TOC entry 3328 (class 2604 OID 386281)
-- Name: detalle_pedido_material id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_pedido_material ALTER COLUMN id SET DEFAULT nextval('obras.detalle_pedido_material_id_seq'::regclass);


--
-- TOC entry 3329 (class 2604 OID 386282)
-- Name: detalle_reporte_diario_actividad id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_reporte_diario_actividad ALTER COLUMN id SET DEFAULT nextval('obras.detalle_reporte_diario_actividad_id_seq'::regclass);


--
-- TOC entry 3330 (class 2604 OID 386283)
-- Name: detalle_reporte_diario_material id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_reporte_diario_material ALTER COLUMN id SET DEFAULT nextval('obras.detalle_reporte_diario_material_id_seq'::regclass);


--
-- TOC entry 3331 (class 2604 OID 386284)
-- Name: detalle_reporte_diario_otras_actividades id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_reporte_diario_otras_actividades ALTER COLUMN id SET DEFAULT nextval('obras.detalle_reporte_diario_otras_actividades_id_seq'::regclass);


--
-- TOC entry 3332 (class 2604 OID 386285)
-- Name: empresas_contratista id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.empresas_contratista ALTER COLUMN id SET DEFAULT nextval('obras.empresas_contratista_id_seq'::regclass);


--
-- TOC entry 3333 (class 2604 OID 386286)
-- Name: encabezado_edp id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.encabezado_edp ALTER COLUMN id SET DEFAULT nextval('obras.encabezado_edp_id_seq'::regclass);


--
-- TOC entry 3334 (class 2604 OID 386287)
-- Name: encabezado_pedido_material id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.encabezado_pedido_material ALTER COLUMN id SET DEFAULT nextval('obras.encabezado_pedido_material_id_seq'::regclass);


--
-- TOC entry 3335 (class 2604 OID 386288)
-- Name: encabezado_reporte_diario id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.encabezado_reporte_diario ALTER COLUMN id SET DEFAULT nextval('obras.encabezado_reporte_diario_id_seq'::regclass);


--
-- TOC entry 3352 (class 2604 OID 418073)
-- Name: estado_obra id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estado_obra ALTER COLUMN id SET DEFAULT nextval('obras.estado_obra_id_seq'::regclass);


--
-- TOC entry 3353 (class 2604 OID 450723)
-- Name: estado_visita id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estado_visita ALTER COLUMN id SET DEFAULT nextval('obras.estado_visita_id_seq'::regclass);


--
-- TOC entry 3336 (class 2604 OID 386289)
-- Name: jefes_faena id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.jefes_faena ALTER COLUMN id SET DEFAULT nextval('obras.jefes_faena_id_seq'::regclass);


--
-- TOC entry 3321 (class 2604 OID 386290)
-- Name: maestro_actividades id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_actividades ALTER COLUMN id SET DEFAULT nextval('obras.actividades_id_seq'::regclass);


--
-- TOC entry 3337 (class 2604 OID 386291)
-- Name: maestro_estructura id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_estructura ALTER COLUMN id SET DEFAULT nextval('obras.maestro_estructura_id_seq'::regclass);


--
-- TOC entry 3338 (class 2604 OID 386292)
-- Name: maestro_unidades id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_unidades ALTER COLUMN id SET DEFAULT nextval('obras.maestro_unidades_id_seq'::regclass);


--
-- TOC entry 3339 (class 2604 OID 386293)
-- Name: obras id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras ALTER COLUMN id SET DEFAULT nextval('obras.obras_id_seq'::regclass);


--
-- TOC entry 3341 (class 2604 OID 386294)
-- Name: otros_cargos_edp id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.otros_cargos_edp ALTER COLUMN id SET DEFAULT nextval('obras.otros_cargos_edp_id_seq'::regclass);


--
-- TOC entry 3342 (class 2604 OID 386295)
-- Name: recibido_bodega_pelom id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.recibido_bodega_pelom ALTER COLUMN id SET DEFAULT nextval('obras.recibido_bodega_pelom_id_seq'::regclass);


--
-- TOC entry 3343 (class 2604 OID 386296)
-- Name: segmento id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.segmento ALTER COLUMN id SET DEFAULT nextval('obras.segmento_id_seq'::regclass);


--
-- TOC entry 3344 (class 2604 OID 386297)
-- Name: solicitantes id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.solicitantes ALTER COLUMN id SET DEFAULT nextval('obras.solicitantes_id_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 386298)
-- Name: tipo_actividad id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.tipo_actividad ALTER COLUMN id SET DEFAULT nextval('obras.tipo_actividad_id_seq'::regclass);


--
-- TOC entry 3346 (class 2604 OID 386299)
-- Name: tipo_obra id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.tipo_obra ALTER COLUMN id SET DEFAULT nextval('obras.tipo_obra_id_seq'::regclass);


--
-- TOC entry 3354 (class 2604 OID 467105)
-- Name: tipo_operacion id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.tipo_operacion ALTER COLUMN id SET DEFAULT nextval('obras.tipo_operacion_id_seq'::regclass);


--
-- TOC entry 3347 (class 2604 OID 386300)
-- Name: tipo_trabajo id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.tipo_trabajo ALTER COLUMN id SET DEFAULT nextval('obras.tipo_trabajo_id_seq'::regclass);


--
-- TOC entry 3348 (class 2604 OID 386301)
-- Name: valor_uc id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.valor_uc ALTER COLUMN id SET DEFAULT nextval('obras.valor_uc_id_seq'::regclass);


--
-- TOC entry 3349 (class 2604 OID 386302)
-- Name: visitas_terreno id; Type: DEFAULT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.visitas_terreno ALTER COLUMN id SET DEFAULT nextval('obras.visitas_terreno_id_seq'::regclass);


--
-- TOC entry 3304 (class 2604 OID 385689)
-- Name: cargo_fijo id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.cargo_fijo ALTER COLUMN id SET DEFAULT nextval('sae.cargo_fijo_id_seq'::regclass);


--
-- TOC entry 3313 (class 2604 OID 385869)
-- Name: movil_eventos id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.movil_eventos ALTER COLUMN id SET DEFAULT nextval('sae.movil_eventos_id_seq'::regclass);


--
-- TOC entry 3314 (class 2604 OID 385880)
-- Name: movil_jornadas id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.movil_jornadas ALTER COLUMN id SET DEFAULT nextval('sae.movil_jornadas_id_seq'::regclass);


--
-- TOC entry 3307 (class 2604 OID 385756)
-- Name: precios_base id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.precios_base ALTER COLUMN id SET DEFAULT nextval('sae.precios_base_id_seq'::regclass);


--
-- TOC entry 3315 (class 2604 OID 385888)
-- Name: reporte_detalle_estado_resultado id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_detalle_estado_resultado ALTER COLUMN id SET DEFAULT nextval('sae.reporte_detalle_estado_resultado_id_seq'::regclass);


--
-- TOC entry 3316 (class 2604 OID 385899)
-- Name: reporte_errores id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_errores ALTER COLUMN id SET DEFAULT nextval('sae.reporte_errores_id_seq'::regclass);


--
-- TOC entry 3317 (class 2604 OID 385910)
-- Name: reporte_estado_resultado id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_estado_resultado ALTER COLUMN id SET DEFAULT nextval('sae.reporte_estado_resultado_id_seq'::regclass);


--
-- TOC entry 3318 (class 2604 OID 385936)
-- Name: reporte_estados id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_estados ALTER COLUMN id SET DEFAULT nextval('sae.reporte_estados_id_seq'::regclass);


--
-- TOC entry 3319 (class 2604 OID 385947)
-- Name: reporte_eventos id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos ALTER COLUMN id SET DEFAULT nextval('sae.reporte_eventos_id_seq'::regclass);


--
-- TOC entry 3320 (class 2604 OID 385993)
-- Name: reporte_jornada id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada ALTER COLUMN id SET DEFAULT nextval('sae.reporte_jornada_id_seq'::regclass);


--
-- TOC entry 3351 (class 2604 OID 393387)
-- Name: resultado_estado_resultado id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.resultado_estado_resultado ALTER COLUMN id SET DEFAULT nextval('sae.resultado_estado_resultado_id_seq'::regclass);


--
-- TOC entry 3350 (class 2604 OID 393377)
-- Name: resultado_estados id; Type: DEFAULT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.resultado_estados ALTER COLUMN id SET DEFAULT nextval('sae.resultado_estados_id_seq'::regclass);


--
-- TOC entry 3795 (class 0 OID 385780)
-- Dependencies: 228
-- Data for Name: personas; Type: TABLE DATA; Schema: _auth; Owner: postgres
--

INSERT INTO _auth.personas VALUES (1, '12345678-9', 'Soto', NULL, 'Juan', 6, 1, 1, true);
INSERT INTO _auth.personas VALUES (2, 'app_saemovil', 'SAE', NULL, 'MÓVIL', 1, 1, 3, true);
INSERT INTO _auth.personas VALUES (3, '12345234-7', 'Perez', NULL, 'Pedro', 6, 1, 2, true);
INSERT INTO _auth.personas VALUES (4, '12345678-0', 'Soto', '', 'Claudio', 1, 1, 1, true);
INSERT INTO _auth.personas VALUES (5, '19007717-9', 'Cortés', 'Valenzuela', 'Jordan Eduardo', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (6, '20270401-8', 'Olmazabal', 'Aguilera', 'Sergio Nicolás', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (7, '14546635-0', 'Zuñiga', 'Abrigo', 'Héctor Alejandro', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (8, '17981015-8', 'López', 'González', 'Leonardo Alfredo', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (10, '13783806-0', 'Quezada', 'Ortiz', 'Rodrigo Alejabdro', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (11, '19997579-K', 'Rosales', 'Cerda', 'Juan Carlos', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (12, '16904505-4', 'Aburto', 'Vergara', 'José Luis', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (13, '14437033-3', 'Navarro', 'Campos', 'Óscar Domingo', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (9, '13371113-9', 'Vásquez', 'González', 'Ricardo Iván', 5, 1, 1, true);
INSERT INTO _auth.personas VALUES (15, '18344097-7', 'Sepúlveda', 'Hernández', 'Camilo Alejandro', 7, 1, 1, true);
INSERT INTO _auth.personas VALUES (16, '18779113-8', 'Vega', 'Zurita', 'Alejandro', 7, 1, 1, true);
INSERT INTO _auth.personas VALUES (17, '17332391-3', 'Parra', 'Chandía', 'Christian Arnoldo', 7, 1, 1, true);
INSERT INTO _auth.personas VALUES (18, '20316388-6', 'Yañez', 'Ortega', 'Brayan Andres', 7, 1, 1, true);
INSERT INTO _auth.personas VALUES (19, '23.567.789-1', 'Gonzalez', 'Muñoz', 'Marcela', 1, 1, 1, true);
INSERT INTO _auth.personas VALUES (20, 'test_admin', 'test', NULL, 'admin', 1, 1, 3, true);


--
-- TOC entry 3778 (class 0 OID 385602)
-- Dependencies: 211
-- Data for Name: roles; Type: TABLE DATA; Schema: _auth; Owner: postgres
--

INSERT INTO _auth.roles VALUES (1, 'admin', false);
INSERT INTO _auth.roles VALUES (2, 'supervisor', false);
INSERT INTO _auth.roles VALUES (3, 'tecnico', false);
INSERT INTO _auth.roles VALUES (4, 'sistema', true);


--
-- TOC entry 3801 (class 0 OID 385846)
-- Dependencies: 234
-- Data for Name: user_roles; Type: TABLE DATA; Schema: _auth; Owner: postgres
--

INSERT INTO _auth.user_roles VALUES (3, 2);
INSERT INTO _auth.user_roles VALUES (4, 3);
INSERT INTO _auth.user_roles VALUES (3, 4);
INSERT INTO _auth.user_roles VALUES (1, 7);
INSERT INTO _auth.user_roles VALUES (1, 8);
INSERT INTO _auth.user_roles VALUES (1, 9);
INSERT INTO _auth.user_roles VALUES (1, 10);
INSERT INTO _auth.user_roles VALUES (1, 11);
INSERT INTO _auth.user_roles VALUES (1, 13);
INSERT INTO _auth.user_roles VALUES (1, 14);
INSERT INTO _auth.user_roles VALUES (1, 15);
INSERT INTO _auth.user_roles VALUES (1, 16);
INSERT INTO _auth.user_roles VALUES (1, 18);
INSERT INTO _auth.user_roles VALUES (1, 19);
INSERT INTO _auth.user_roles VALUES (1, 20);
INSERT INTO _auth.user_roles VALUES (1, 21);
INSERT INTO _auth.user_roles VALUES (1, 22);
INSERT INTO _auth.user_roles VALUES (1, 23);


--
-- TOC entry 3799 (class 0 OID 385825)
-- Dependencies: 232
-- Data for Name: users; Type: TABLE DATA; Schema: _auth; Owner: postgres
--

INSERT INTO _auth.users VALUES (3, 'app_saemovil', 'sae.movil@pelomingenieria.cl', '$2a$08$rr1I97wKSS7USi3/Nu.CCOm1xgznBdiJxqLv5ZTM3oN9iHdLWA7jS');
INSERT INTO _auth.users VALUES (2, '12345678-9', 'juan.soto@pelomingenieria.cl', '$2a$08$wZ9L6UFGWPRpCVTVPboCL.FjAKw92YSWh7cUazm1fFowsJg78iYCW');
INSERT INTO _auth.users VALUES (7, '12345678-0', 'uno@pelom.cl', '$2a$08$MDU69Jo2/rIYD.nZSRLmUeoNDSRzkPSYXwumZFvLDhxD3NVUjIgTu');
INSERT INTO _auth.users VALUES (4, '12345234-7', 'pedro.perez@pelomingenieria.cl', '$2a$08$MDU69Jo2/rIYD.nZSRLmUeoNDSRzkPSYXwumZFvLDhxD3NVUjIgTu');
INSERT INTO _auth.users VALUES (8, '19007717-9', 'jcortes@pelomingenieria.cl', '$2a$08$8zc.GBFXAU8yRL3zlunNUOTrQJy/ILl1QolLTQPdOn6E9/PJuIDZO');
INSERT INTO _auth.users VALUES (9, '20270401-8', 'solmazabal@pelomingenieria.cl', '$2a$08$FfCzuwIi8ZCybgfmY7ZSZOFS/ZJ3XiGr6OOTLBy0J1q8pQ.Kf36rO');
INSERT INTO _auth.users VALUES (10, '14546635-0', 'hzuniga@pelomingenieria.cl', '$2a$08$rF8Kcd/RNNHtoWd40uYJr.8UxaRDptc5NxFZaubMlAVnhsx0yn80O');
INSERT INTO _auth.users VALUES (11, '17981015-8', 'llopez@pelomingenieria.cl', '$2a$08$/m0AzLtZuUaOQMBgExI7WeIXnCdcmg3fzz2P7THljED0kCGGjt55a');
INSERT INTO _auth.users VALUES (13, '13783806-0', 'rquezada@pelomingenieria.cl', '$2a$08$lsAgbirkOu.G30NGTGyin.xRdMM1UJu7cUclV0EvOMsn14EYEhGDS');
INSERT INTO _auth.users VALUES (14, '19997579-K', 'jrosales@pelomingenieria.cl', '$2a$08$mQsyH168DFZtkadfaukGiuiZBlkzqeFAnKE3tgEwN5.Q6goxbxzt6');
INSERT INTO _auth.users VALUES (15, '16904505-4', 'jaburto@pelomingenieria.cl', '$2a$08$zEYnTVGkjlopY/NeVPGudONw5xzKjzQlUzg1l3tvHXCBuoXngsGpO');
INSERT INTO _auth.users VALUES (16, '14437033-3', 'onavarro@pelomingenieria.cl', '$2a$08$tAki1gDZv2/cGuJyExtjW.IC4UB4xyOgZksCSJ9QrtXRIYpGrpEme');
INSERT INTO _auth.users VALUES (18, '13371113-9', 'rvazquez@pelomingenieria.cl', '$2a$08$UGxXChP3xNoVbh0s17IuJOFOaCQDDF9xXzN.4CIOs16HYSmc//TzS');
INSERT INTO _auth.users VALUES (19, '18344097-7', 'csepulveda@pelomingenieria.cl', '$2a$08$3U4APqWtfuWQUwfBWEROfemRIZHnBECrZ3vrfhreoMCLag09k2gAC');
INSERT INTO _auth.users VALUES (20, '18779113-8', 'avega@pelomingenieria.cl', '$2a$08$sAYzurQh8zborE.U4Q9sFOih0mLU3Hl9N5jQjsnn6.IxWlgs5pMDS');
INSERT INTO _auth.users VALUES (21, '17332391-3', 'cparra@pelomingenieria.cl', '$2a$08$q/qmJDsj3hWN6WQ19TviwuXJzz8c8NNKHBQNunv36kfSez4dPjZtC');
INSERT INTO _auth.users VALUES (22, '20316388-6', 'byanez@pelomingenieria.cl', '$2a$08$Cz2HeDJXj.7ES4ik3J7Gve9mmGqADmNXoezpiXjZPAegn5RO6rW/C');
INSERT INTO _auth.users VALUES (23, 'test_admin', 'test_admin@pelom.cl', '$2a$08$JlMJmNPyCzMpeNq0Qp/Y9eaESNQ0Yl3FYZmVD/TjA5u9XkyrigbF.');


--
-- TOC entry 3790 (class 0 OID 385710)
-- Dependencies: 223
-- Data for Name: base; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.base VALUES (1, 'Constitución', 1);
INSERT INTO _comun.base VALUES (2, 'San Clemente', 1);
INSERT INTO _comun.base VALUES (3, 'San Javier', 1);
INSERT INTO _comun.base VALUES (4, 'Licantén', 2);
INSERT INTO _comun.base VALUES (5, 'Molina', 2);
INSERT INTO _comun.base VALUES (6, 'Linares', 3);
INSERT INTO _comun.base VALUES (7, 'Parral', 3);
INSERT INTO _comun.base VALUES (8, 'Pelluhue', 3);


--
-- TOC entry 3797 (class 0 OID 385809)
-- Dependencies: 230
-- Data for Name: camionetas; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.camionetas VALUES (2, 'SWCX-56', 'FOTON', 'G7', 1, true, NULL);
INSERT INTO _comun.camionetas VALUES (3, 'SGSS-44', 'FOTON', 'G7', 1, true, NULL);
INSERT INTO _comun.camionetas VALUES (1, 'AABB-00', 'KIA', 'XX', 1, false, '');


--
-- TOC entry 3785 (class 0 OID 385662)
-- Dependencies: 218
-- Data for Name: cliente; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.cliente VALUES (1, 'CGE');


--
-- TOC entry 3784 (class 0 OID 385648)
-- Dependencies: 217
-- Data for Name: comunas; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.comunas VALUES ('05301', 'Los Andes', '053');
INSERT INTO _comun.comunas VALUES ('05201', 'Isla  de Pascua', '052');
INSERT INTO _comun.comunas VALUES ('10403', 'Hualaihué', '104');
INSERT INTO _comun.comunas VALUES ('04204', 'Salamanca', '042');
INSERT INTO _comun.comunas VALUES ('09108', 'Lautaro', '091');
INSERT INTO _comun.comunas VALUES ('12402', 'Torres del Paine', '124');
INSERT INTO _comun.comunas VALUES ('05802', 'Limache', '058');
INSERT INTO _comun.comunas VALUES ('13602', 'El Monte', '136');
INSERT INTO _comun.comunas VALUES ('13605', 'Peñaflor', '136');
INSERT INTO _comun.comunas VALUES ('06201', 'Pichilemu', '062');
INSERT INTO _comun.comunas VALUES ('14103', 'Lanco', '141');
INSERT INTO _comun.comunas VALUES ('13112', 'La Pintana', '131');
INSERT INTO _comun.comunas VALUES ('09101', 'Temuco', '091');
INSERT INTO _comun.comunas VALUES ('05109', 'Viña del Mar', '051');
INSERT INTO _comun.comunas VALUES ('04101', 'La Serena', '041');
INSERT INTO _comun.comunas VALUES ('13125', 'Quilicura', '131');
INSERT INTO _comun.comunas VALUES ('08111', 'Tomé', '081');
INSERT INTO _comun.comunas VALUES ('09211', 'Victoria', '092');
INSERT INTO _comun.comunas VALUES ('13108', 'Independencia', '131');
INSERT INTO _comun.comunas VALUES ('03303', 'Freirina', '033');
INSERT INTO _comun.comunas VALUES ('12103', 'Río Verde', '121');
INSERT INTO _comun.comunas VALUES ('07202', 'Chanco', '072');
INSERT INTO _comun.comunas VALUES ('14101', 'Valdivia', '141');
INSERT INTO _comun.comunas VALUES ('06304', 'Lolol', '063');
INSERT INTO _comun.comunas VALUES ('09103', 'Cunco', '091');
INSERT INTO _comun.comunas VALUES ('07308', 'Teno', '073');
INSERT INTO _comun.comunas VALUES ('10103', 'Cochamó', '101');
INSERT INTO _comun.comunas VALUES ('14102', 'Corral', '141');
INSERT INTO _comun.comunas VALUES ('07401', 'Linares', '074');
INSERT INTO _comun.comunas VALUES ('13127', 'Recoleta', '131');
INSERT INTO _comun.comunas VALUES ('13105', 'El Bosque', '131');
INSERT INTO _comun.comunas VALUES ('07110', 'San Rafael', '071');
INSERT INTO _comun.comunas VALUES ('13404', 'Paine', '134');
INSERT INTO _comun.comunas VALUES ('05103', 'Concón', '051');
INSERT INTO _comun.comunas VALUES ('01107', 'Alto Hospicio', '011');
INSERT INTO _comun.comunas VALUES ('10107', 'Llanquihue', '101');
INSERT INTO _comun.comunas VALUES ('16301', 'San Carlos', '163');
INSERT INTO _comun.comunas VALUES ('07307', 'Sagrada Familia', '073');
INSERT INTO _comun.comunas VALUES ('05303', 'Rinconada', '053');
INSERT INTO _comun.comunas VALUES ('06203', 'Litueche', '062');
INSERT INTO _comun.comunas VALUES ('08105', 'Hualqui', '081');
INSERT INTO _comun.comunas VALUES ('06102', 'Codegua', '061');
INSERT INTO _comun.comunas VALUES ('13202', 'Pirque', '132');
INSERT INTO _comun.comunas VALUES ('06204', 'Marchihue', '062');
INSERT INTO _comun.comunas VALUES ('12202', 'Antártica', '122');
INSERT INTO _comun.comunas VALUES ('09116', 'Saavedra', '091');
INSERT INTO _comun.comunas VALUES ('16103', 'Chillán Viejo', '161');
INSERT INTO _comun.comunas VALUES ('06308', 'Placilla', '063');
INSERT INTO _comun.comunas VALUES ('05401', 'La Ligua', '054');
INSERT INTO _comun.comunas VALUES ('03103', 'Tierra Amarilla', '031');
INSERT INTO _comun.comunas VALUES ('10204', 'Curaco de Vélez', '102');
INSERT INTO _comun.comunas VALUES ('09202', 'Collipulli', '092');
INSERT INTO _comun.comunas VALUES ('07104', 'Empedrado', '071');
INSERT INTO _comun.comunas VALUES ('07101', 'Talca', '071');
INSERT INTO _comun.comunas VALUES ('04301', 'Ovalle', '043');
INSERT INTO _comun.comunas VALUES ('16108', 'San Ignacio', '161');
INSERT INTO _comun.comunas VALUES ('13201', 'Puente Alto', '132');
INSERT INTO _comun.comunas VALUES ('08106', 'Lota', '081');
INSERT INTO _comun.comunas VALUES ('01401', 'Pozo Almonte', '014');
INSERT INTO _comun.comunas VALUES ('06116', 'Requínoa', '061');
INSERT INTO _comun.comunas VALUES ('13203', 'San José de Maipo', '132');
INSERT INTO _comun.comunas VALUES ('07403', 'Longaví', '074');
INSERT INTO _comun.comunas VALUES ('10106', 'Los Muermos', '101');
INSERT INTO _comun.comunas VALUES ('14201', 'La Unión', '142');
INSERT INTO _comun.comunas VALUES ('16305', 'San Nicolás', '163');
INSERT INTO _comun.comunas VALUES ('14105', 'Máfil', '141');
INSERT INTO _comun.comunas VALUES ('06307', 'Peralillo', '063');
INSERT INTO _comun.comunas VALUES ('09207', 'Lumaco', '092');
INSERT INTO _comun.comunas VALUES ('10101', 'Puerto Montt', '101');
INSERT INTO _comun.comunas VALUES ('09109', 'Loncoche', '091');
INSERT INTO _comun.comunas VALUES ('08312', 'Tucapel', '083');
INSERT INTO _comun.comunas VALUES ('03304', 'Huasco', '033');
INSERT INTO _comun.comunas VALUES ('11302', 'OHiggins', '113');
INSERT INTO _comun.comunas VALUES ('10303', 'Purranque', '103');
INSERT INTO _comun.comunas VALUES ('04304', 'Punitaqui', '043');
INSERT INTO _comun.comunas VALUES ('09110', 'Melipeuco', '091');
INSERT INTO _comun.comunas VALUES ('16102', 'Bulnes', '161');
INSERT INTO _comun.comunas VALUES ('11301', 'Cochrane', '113');
INSERT INTO _comun.comunas VALUES ('08108', 'San Pedro de la Paz', '081');
INSERT INTO _comun.comunas VALUES ('08302', 'Antuco', '083');
INSERT INTO _comun.comunas VALUES ('07203', 'Pelluhue', '072');
INSERT INTO _comun.comunas VALUES ('08309', 'Quilleco', '083');
INSERT INTO _comun.comunas VALUES ('07302', 'Hualañé', '073');
INSERT INTO _comun.comunas VALUES ('08307', 'Negrete', '083');
INSERT INTO _comun.comunas VALUES ('08103', 'Chiguayante', '081');
INSERT INTO _comun.comunas VALUES ('09105', 'Freire', '091');
INSERT INTO _comun.comunas VALUES ('13403', 'Calera de Tango', '134');
INSERT INTO _comun.comunas VALUES ('06115', 'Rengo', '061');
INSERT INTO _comun.comunas VALUES ('12101', 'Punta Arenas', '121');
INSERT INTO _comun.comunas VALUES ('08102', 'Coronel', '081');
INSERT INTO _comun.comunas VALUES ('06306', 'Palmilla', '063');
INSERT INTO _comun.comunas VALUES ('13302', 'Lampa', '133');
INSERT INTO _comun.comunas VALUES ('16105', 'Pemuco', '161');
INSERT INTO _comun.comunas VALUES ('05501', 'Quillota', '055');
INSERT INTO _comun.comunas VALUES ('08306', 'Nacimiento', '083');
INSERT INTO _comun.comunas VALUES ('08110', 'Talcahuano', '081');
INSERT INTO _comun.comunas VALUES ('07402', 'Colbún', '074');
INSERT INTO _comun.comunas VALUES ('08207', 'Tirúa', '082');
INSERT INTO _comun.comunas VALUES ('10307', 'San Pablo', '103');
INSERT INTO _comun.comunas VALUES ('07108', 'Río Claro', '071');
INSERT INTO _comun.comunas VALUES ('01101', 'Iquique', '011');
INSERT INTO _comun.comunas VALUES ('05804', 'Villa Alemana', '058');
INSERT INTO _comun.comunas VALUES ('11402', 'Río Ibáñez', '114');
INSERT INTO _comun.comunas VALUES ('14108', 'Panguipulli', '141');
INSERT INTO _comun.comunas VALUES ('09114', 'Pitrufquén', '091');
INSERT INTO _comun.comunas VALUES ('09209', 'Renaico', '092');
INSERT INTO _comun.comunas VALUES ('09112', 'Padre Las Casas', '091');
INSERT INTO _comun.comunas VALUES ('09106', 'Galvarino', '091');
INSERT INTO _comun.comunas VALUES ('06309', 'Pumanque', '063');
INSERT INTO _comun.comunas VALUES ('06111', 'Olivar', '061');
INSERT INTO _comun.comunas VALUES ('08201', 'Lebu', '082');
INSERT INTO _comun.comunas VALUES ('04201', 'Illapel', '042');
INSERT INTO _comun.comunas VALUES ('10305', 'Río Negro', '103');
INSERT INTO _comun.comunas VALUES ('13115', 'Lo Barnechea', '131');
INSERT INTO _comun.comunas VALUES ('04106', 'Vicuña', '041');
INSERT INTO _comun.comunas VALUES ('06117', 'San Vicente', '061');
INSERT INTO _comun.comunas VALUES ('08313', 'Yumbel', '083');
INSERT INTO _comun.comunas VALUES ('05602', 'Algarrobo', '056');
INSERT INTO _comun.comunas VALUES ('05503', 'Hijuelas', '055');
INSERT INTO _comun.comunas VALUES ('12302', 'Primavera', '123');
INSERT INTO _comun.comunas VALUES ('05101', 'Valparaíso', '051');
INSERT INTO _comun.comunas VALUES ('14106', 'Mariquina', '141');
INSERT INTO _comun.comunas VALUES ('05105', 'Puchuncaví', '051');
INSERT INTO _comun.comunas VALUES ('01405', 'Pica', '014');
INSERT INTO _comun.comunas VALUES ('04105', 'Paiguano', '041');
INSERT INTO _comun.comunas VALUES ('09119', 'Vilcún', '091');
INSERT INTO _comun.comunas VALUES ('08104', 'Florida', '081');
INSERT INTO _comun.comunas VALUES ('13501', 'Melipilla', '135');
INSERT INTO _comun.comunas VALUES ('07305', 'Rauco', '073');
INSERT INTO _comun.comunas VALUES ('10304', 'Puyehue', '103');
INSERT INTO _comun.comunas VALUES ('14107', 'Paillaco', '141');
INSERT INTO _comun.comunas VALUES ('13132', 'Vitacura', '131');
INSERT INTO _comun.comunas VALUES ('08205', 'Curanilahue', '082');
INSERT INTO _comun.comunas VALUES ('03201', 'Chañaral', '032');
INSERT INTO _comun.comunas VALUES ('13402', 'Buin', '134');
INSERT INTO _comun.comunas VALUES ('09201', 'Angol', '092');
INSERT INTO _comun.comunas VALUES ('13121', 'Pedro Aguirre Cerda', '131');
INSERT INTO _comun.comunas VALUES ('05603', 'Cartagena', '056');
INSERT INTO _comun.comunas VALUES ('05502', 'Calera', '055');
INSERT INTO _comun.comunas VALUES ('06114', 'Quinta de Tilcoco', '061');
INSERT INTO _comun.comunas VALUES ('10109', 'Puerto Varas', '101');
INSERT INTO _comun.comunas VALUES ('07407', 'Villa Alegre', '074');
INSERT INTO _comun.comunas VALUES ('09113', 'Perquenco', '091');
INSERT INTO _comun.comunas VALUES ('06305', 'Nancagua', '063');
INSERT INTO _comun.comunas VALUES ('08301', 'Los Ángeles', '083');
INSERT INTO _comun.comunas VALUES ('13104', 'Conchalí', '131');
INSERT INTO _comun.comunas VALUES ('06103', 'Coinco', '061');
INSERT INTO _comun.comunas VALUES ('11303', 'Tortel', '113');
INSERT INTO _comun.comunas VALUES ('16206', 'Ránquil', '162');
INSERT INTO _comun.comunas VALUES ('16205', 'Portezuelo', '162');
INSERT INTO _comun.comunas VALUES ('05803', 'Olmué', '058');
INSERT INTO _comun.comunas VALUES ('11401', 'Chile Chico', '114');
INSERT INTO _comun.comunas VALUES ('06202', 'La Estrella', '062');
INSERT INTO _comun.comunas VALUES ('09102', 'Carahue', '091');
INSERT INTO _comun.comunas VALUES ('11101', 'Coihaique', '111');
INSERT INTO _comun.comunas VALUES ('01403', 'Colchane', '014');
INSERT INTO _comun.comunas VALUES ('15101', 'Arica', '151');
INSERT INTO _comun.comunas VALUES ('08304', 'Laja', '083');
INSERT INTO _comun.comunas VALUES ('13503', 'Curacaví', '135');
INSERT INTO _comun.comunas VALUES ('09107', 'Gorbea', '091');
INSERT INTO _comun.comunas VALUES ('13601', 'Talagante', '136');
INSERT INTO _comun.comunas VALUES ('13401', 'San Bernardo', '134');
INSERT INTO _comun.comunas VALUES ('13113', 'La Reina', '131');
INSERT INTO _comun.comunas VALUES ('15102', 'Camarones', '151');
INSERT INTO _comun.comunas VALUES ('07301', 'Curicó', '073');
INSERT INTO _comun.comunas VALUES ('16104', 'El Carmen', '161');
INSERT INTO _comun.comunas VALUES ('13301', 'Colina', '133');
INSERT INTO _comun.comunas VALUES ('05302', 'Calle Larga', '053');
INSERT INTO _comun.comunas VALUES ('05704', 'Panquehue', '057');
INSERT INTO _comun.comunas VALUES ('09204', 'Ercilla', '092');
INSERT INTO _comun.comunas VALUES ('07107', 'Pencahue', '071');
INSERT INTO _comun.comunas VALUES ('13106', 'Estación Central', '131');
INSERT INTO _comun.comunas VALUES ('13120', 'Ñuñoa', '131');
INSERT INTO _comun.comunas VALUES ('02202', 'Ollagüe', '022');
INSERT INTO _comun.comunas VALUES ('16207', 'Treguaco', '162');
INSERT INTO _comun.comunas VALUES ('06303', 'Chimbarongo', '063');
INSERT INTO _comun.comunas VALUES ('05701', 'San Felipe', '057');
INSERT INTO _comun.comunas VALUES ('10104', 'Fresia', '101');
INSERT INTO _comun.comunas VALUES ('07102', 'Constitución', '071');
INSERT INTO _comun.comunas VALUES ('06112', 'Peumo', '061');
INSERT INTO _comun.comunas VALUES ('13128', 'Renca', '131');
INSERT INTO _comun.comunas VALUES ('13502', 'Alhué', '135');
INSERT INTO _comun.comunas VALUES ('08305', 'Mulchén', '083');
INSERT INTO _comun.comunas VALUES ('04305', 'Río Hurtado', '043');
INSERT INTO _comun.comunas VALUES ('10205', 'Dalcahue', '102');
INSERT INTO _comun.comunas VALUES ('08203', 'Cañete', '082');
INSERT INTO _comun.comunas VALUES ('16204', 'Ninhue', '162');
INSERT INTO _comun.comunas VALUES ('10201', 'Castro', '102');
INSERT INTO _comun.comunas VALUES ('05703', 'Llaillay', '057');
INSERT INTO _comun.comunas VALUES ('13603', 'Isla de Maipo', '136');
INSERT INTO _comun.comunas VALUES ('13119', 'Maipú', '131');
INSERT INTO _comun.comunas VALUES ('07309', 'Vichuquén', '073');
INSERT INTO _comun.comunas VALUES ('12303', 'Timaukel', '123');
INSERT INTO _comun.comunas VALUES ('09111', 'Nueva Imperial', '091');
INSERT INTO _comun.comunas VALUES ('06206', 'Paredones', '062');
INSERT INTO _comun.comunas VALUES ('10203', 'Chonchi', '102');
INSERT INTO _comun.comunas VALUES ('06109', 'Malloa', '061');
INSERT INTO _comun.comunas VALUES ('07304', 'Molina', '073');
INSERT INTO _comun.comunas VALUES ('09120', 'Villarrica', '091');
INSERT INTO _comun.comunas VALUES ('07103', 'Curepto', '071');
INSERT INTO _comun.comunas VALUES ('11201', 'Aisén', '112');
INSERT INTO _comun.comunas VALUES ('06107', 'Las Cabras', '061');
INSERT INTO _comun.comunas VALUES ('03301', 'Vallenar', '033');
INSERT INTO _comun.comunas VALUES ('02104', 'Taltal', '021');
INSERT INTO _comun.comunas VALUES ('13123', 'Providencia', '131');
INSERT INTO _comun.comunas VALUES ('16101', 'Chillán', '161');
INSERT INTO _comun.comunas VALUES ('13111', 'La Granja', '131');
INSERT INTO _comun.comunas VALUES ('02102', 'Mejillones', '021');
INSERT INTO _comun.comunas VALUES ('05601', 'San Antonio', '056');
INSERT INTO _comun.comunas VALUES ('05604', 'El Quisco', '056');
INSERT INTO _comun.comunas VALUES ('01404', 'Huara', '014');
INSERT INTO _comun.comunas VALUES ('07404', 'Parral', '074');
INSERT INTO _comun.comunas VALUES ('07105', 'Maule', '071');
INSERT INTO _comun.comunas VALUES ('05104', 'Juan Fernández', '051');
INSERT INTO _comun.comunas VALUES ('10108', 'Maullín', '101');
INSERT INTO _comun.comunas VALUES ('16202', 'Cobquecura', '162');
INSERT INTO _comun.comunas VALUES ('04203', 'Los Vilos', '042');
INSERT INTO _comun.comunas VALUES ('06302', 'Chépica', '063');
INSERT INTO _comun.comunas VALUES ('15201', 'Putre', '152');
INSERT INTO _comun.comunas VALUES ('09203', 'Curacautín', '092');
INSERT INTO _comun.comunas VALUES ('08112', 'Hualpén', '081');
INSERT INTO _comun.comunas VALUES ('04302', 'Combarbalá', '043');
INSERT INTO _comun.comunas VALUES ('04103', 'Andacollo', '041');
INSERT INTO _comun.comunas VALUES ('13131', 'San Ramón', '131');
INSERT INTO _comun.comunas VALUES ('13110', 'La Florida', '131');
INSERT INTO _comun.comunas VALUES ('09205', 'Lonquimay', '092');
INSERT INTO _comun.comunas VALUES ('02301', 'Tocopilla', '023');
INSERT INTO _comun.comunas VALUES ('09208', 'Purén', '092');
INSERT INTO _comun.comunas VALUES ('13604', 'Padre Hurtado', '136');
INSERT INTO _comun.comunas VALUES ('05702', 'Catemu', '057');
INSERT INTO _comun.comunas VALUES ('06106', 'Graneros', '061');
INSERT INTO _comun.comunas VALUES ('11202', 'Cisnes', '112');
INSERT INTO _comun.comunas VALUES ('05405', 'Zapallar', '054');
INSERT INTO _comun.comunas VALUES ('02101', 'Antofagasta', '021');
INSERT INTO _comun.comunas VALUES ('07106', 'Pelarco', '071');
INSERT INTO _comun.comunas VALUES ('12104', 'San Gregorio', '121');
INSERT INTO _comun.comunas VALUES ('05606', 'Santo Domingo', '056');
INSERT INTO _comun.comunas VALUES ('14204', 'Río Bueno', '142');
INSERT INTO _comun.comunas VALUES ('04202', 'Canela', '042');
INSERT INTO _comun.comunas VALUES ('13118', 'Macul', '131');
INSERT INTO _comun.comunas VALUES ('13124', 'Pudahuel', '131');
INSERT INTO _comun.comunas VALUES ('13122', 'Peñalolén', '131');
INSERT INTO _comun.comunas VALUES ('06108', 'Machalí', '061');
INSERT INTO _comun.comunas VALUES ('05404', 'Petorca', '054');
INSERT INTO _comun.comunas VALUES ('14104', 'Los Lagos', '141');
INSERT INTO _comun.comunas VALUES ('05102', 'Casablanca', '051');
INSERT INTO _comun.comunas VALUES ('09210', 'Traiguén', '092');
INSERT INTO _comun.comunas VALUES ('16109', 'Yungay', '161');
INSERT INTO _comun.comunas VALUES ('15202', 'General Lagos', '152');
INSERT INTO _comun.comunas VALUES ('11102', 'Lago Verde', '111');
INSERT INTO _comun.comunas VALUES ('08101', 'Concepción', '081');
INSERT INTO _comun.comunas VALUES ('08308', 'Quilaco', '083');
INSERT INTO _comun.comunas VALUES ('08204', 'Contulmo', '082');
INSERT INTO _comun.comunas VALUES ('10306', 'San Juan de la Costa', '103');
INSERT INTO _comun.comunas VALUES ('16201', 'Quirihue', '162');
INSERT INTO _comun.comunas VALUES ('05506', 'Nogales', '055');
INSERT INTO _comun.comunas VALUES ('07306', 'Romeral', '073');
INSERT INTO _comun.comunas VALUES ('05605', 'El Tabo', '056');
INSERT INTO _comun.comunas VALUES ('09121', 'Cholchol', '091');
INSERT INTO _comun.comunas VALUES ('05504', 'La Cruz', '055');
INSERT INTO _comun.comunas VALUES ('16106', 'Pinto', '161');
INSERT INTO _comun.comunas VALUES ('10210', 'Quinchao', '102');
INSERT INTO _comun.comunas VALUES ('16302', 'Coihueco', '163');
INSERT INTO _comun.comunas VALUES ('02302', 'María Elena', '023');
INSERT INTO _comun.comunas VALUES ('13303', 'Tiltil', '133');
INSERT INTO _comun.comunas VALUES ('16203', 'Coelemu', '162');
INSERT INTO _comun.comunas VALUES ('10207', 'Queilén', '102');
INSERT INTO _comun.comunas VALUES ('09206', 'Los Sauces', '092');
INSERT INTO _comun.comunas VALUES ('16303', 'Ñiquén', '163');
INSERT INTO _comun.comunas VALUES ('12301', 'Porvenir', '123');
INSERT INTO _comun.comunas VALUES ('05107', 'Quintero', '051');
INSERT INTO _comun.comunas VALUES ('14203', 'Lago Ranco', '142');
INSERT INTO _comun.comunas VALUES ('13129', 'San Joaquín', '131');
INSERT INTO _comun.comunas VALUES ('08206', 'Los Álamos', '082');
INSERT INTO _comun.comunas VALUES ('07406', 'San Javier', '074');
INSERT INTO _comun.comunas VALUES ('13114', 'Las Condes', '131');
INSERT INTO _comun.comunas VALUES ('08109', 'Santa Juana', '081');
INSERT INTO _comun.comunas VALUES ('05705', 'Putaendo', '057');
INSERT INTO _comun.comunas VALUES ('08303', 'Cabrero', '083');
INSERT INTO _comun.comunas VALUES ('13116', 'Lo Espejo', '131');
INSERT INTO _comun.comunas VALUES ('13117', 'Lo Prado', '131');
INSERT INTO _comun.comunas VALUES ('06310', 'Santa Cruz', '063');
INSERT INTO _comun.comunas VALUES ('06205', 'Navidad', '062');
INSERT INTO _comun.comunas VALUES ('06105', 'Doñihue', '061');
INSERT INTO _comun.comunas VALUES ('05706', 'Santa María', '057');
INSERT INTO _comun.comunas VALUES ('02203', 'San Pedro de Atacama', '022');
INSERT INTO _comun.comunas VALUES ('13505', 'San Pedro', '135');
INSERT INTO _comun.comunas VALUES ('03302', 'Alto del Carmen', '033');
INSERT INTO _comun.comunas VALUES ('13504', 'María Pinto', '135');
INSERT INTO _comun.comunas VALUES ('13109', 'La Cisterna', '131');
INSERT INTO _comun.comunas VALUES ('06104', 'Coltauco', '061');
INSERT INTO _comun.comunas VALUES ('05801', 'Quilpué', '058');
INSERT INTO _comun.comunas VALUES ('13107', 'Huechuraba', '131');
INSERT INTO _comun.comunas VALUES ('04102', 'Coquimbo', '041');
INSERT INTO _comun.comunas VALUES ('10105', 'Frutillar', '101');
INSERT INTO _comun.comunas VALUES ('06110', 'Mostazal', '061');
INSERT INTO _comun.comunas VALUES ('09115', 'Pucón', '091');
INSERT INTO _comun.comunas VALUES ('01402', 'Camiña', '014');
INSERT INTO _comun.comunas VALUES ('10202', 'Ancud', '102');
INSERT INTO _comun.comunas VALUES ('16304', 'San Fabián', '163');
INSERT INTO _comun.comunas VALUES ('07303', 'Licantén', '073');
INSERT INTO _comun.comunas VALUES ('04303', 'Monte Patria', '043');
INSERT INTO _comun.comunas VALUES ('03102', 'Caldera', '031');
INSERT INTO _comun.comunas VALUES ('10402', 'Futaleufú', '104');
INSERT INTO _comun.comunas VALUES ('04104', 'La Higuera', '041');
INSERT INTO _comun.comunas VALUES ('11203', 'Guaitecas', '112');
INSERT INTO _comun.comunas VALUES ('10208', 'Quellón', '102');
INSERT INTO _comun.comunas VALUES ('13130', 'San Miguel', '131');
INSERT INTO _comun.comunas VALUES ('07201', 'Cauquenes', '072');
INSERT INTO _comun.comunas VALUES ('05402', 'Cabildo', '054');
INSERT INTO _comun.comunas VALUES ('13101', 'Santiago', '131');
INSERT INTO _comun.comunas VALUES ('08107', 'Penco', '081');
INSERT INTO _comun.comunas VALUES ('02201', 'Calama', '022');
INSERT INTO _comun.comunas VALUES ('07408', 'Yerbas Buenas', '074');
INSERT INTO _comun.comunas VALUES ('10209', 'Quemchi', '102');
INSERT INTO _comun.comunas VALUES ('06301', 'San Fernando', '063');
INSERT INTO _comun.comunas VALUES ('12201', 'Cabo de Hornos', '122');
INSERT INTO _comun.comunas VALUES ('08310', 'San Rosendo', '083');
INSERT INTO _comun.comunas VALUES ('08202', 'Arauco', '082');
INSERT INTO _comun.comunas VALUES ('12102', 'Laguna Blanca', '121');
INSERT INTO _comun.comunas VALUES ('13103', 'Cerro Navia', '131');
INSERT INTO _comun.comunas VALUES ('10401', 'Chaitén', '104');
INSERT INTO _comun.comunas VALUES ('08314', 'Alto Biobío', '083');
INSERT INTO _comun.comunas VALUES ('13126', 'Quinta Normal', '131');
INSERT INTO _comun.comunas VALUES ('12401', 'Natales', '124');
INSERT INTO _comun.comunas VALUES ('09104', 'Curarrehue', '091');
INSERT INTO _comun.comunas VALUES ('08311', 'Santa Bárbara', '083');
INSERT INTO _comun.comunas VALUES ('02103', 'Sierra Gorda', '021');
INSERT INTO _comun.comunas VALUES ('10404', 'Palena', '104');
INSERT INTO _comun.comunas VALUES ('14202', 'Futrono', '142');
INSERT INTO _comun.comunas VALUES ('09117', 'Teodoro Schmidt', '091');
INSERT INTO _comun.comunas VALUES ('05304', 'San Esteban', '053');
INSERT INTO _comun.comunas VALUES ('07109', 'San Clemente', '071');
INSERT INTO _comun.comunas VALUES ('09118', 'Toltén', '091');
INSERT INTO _comun.comunas VALUES ('03101', 'Copiapó', '031');
INSERT INTO _comun.comunas VALUES ('10301', 'Osorno', '103');
INSERT INTO _comun.comunas VALUES ('06113', 'Pichidegua', '061');
INSERT INTO _comun.comunas VALUES ('16107', 'Quillón', '161');
INSERT INTO _comun.comunas VALUES ('03202', 'Diego de Almagro', '032');
INSERT INTO _comun.comunas VALUES ('13102', 'Cerrillos', '131');
INSERT INTO _comun.comunas VALUES ('10206', 'Puqueldón', '102');
INSERT INTO _comun.comunas VALUES ('07405', 'Retiro', '074');
INSERT INTO _comun.comunas VALUES ('06101', 'Rancagua', '061');
INSERT INTO _comun.comunas VALUES ('10302', 'Puerto Octay', '103');
INSERT INTO _comun.comunas VALUES ('05403', 'Papudo', '054');
INSERT INTO _comun.comunas VALUES ('10102', 'Calbuco', '101');


--
-- TOC entry 3782 (class 0 OID 385638)
-- Dependencies: 215
-- Data for Name: eventos_tipo; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.eventos_tipo VALUES (1, 'DOMIC', 'EVENTO DOMICILIARIO');
INSERT INTO _comun.eventos_tipo VALUES (2, 'SSEEB', 'EVENTO EN SSEE Y/O BT');
INSERT INTO _comun.eventos_tipo VALUES (3, 'LINMT', 'EVENTO EN LINEA MT');
INSERT INTO _comun.eventos_tipo VALUES (4, 'REPAR', 'TRABAJOS MENORES DE REPARACION DE LINEAS POR FALLA');
INSERT INTO _comun.eventos_tipo VALUES (5, 'VIFRU', 'VIAJE FRUSTRADO');


--
-- TOC entry 3781 (class 0 OID 385630)
-- Dependencies: 214
-- Data for Name: meses; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.meses VALUES (1, 'Enero');
INSERT INTO _comun.meses VALUES (2, 'Febrero');
INSERT INTO _comun.meses VALUES (3, 'Marzo');
INSERT INTO _comun.meses VALUES (4, 'Abril');
INSERT INTO _comun.meses VALUES (5, 'Mayo');
INSERT INTO _comun.meses VALUES (6, 'Junio');
INSERT INTO _comun.meses VALUES (7, 'Julio');
INSERT INTO _comun.meses VALUES (8, 'Agosto');
INSERT INTO _comun.meses VALUES (9, 'Septiembre');
INSERT INTO _comun.meses VALUES (10, 'Octubre');
INSERT INTO _comun.meses VALUES (11, 'Noviembre');
INSERT INTO _comun.meses VALUES (12, 'Diciembre');


--
-- TOC entry 3787 (class 0 OID 385670)
-- Dependencies: 220
-- Data for Name: paquete; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.paquete VALUES (1, 'Talca', 1);
INSERT INTO _comun.paquete VALUES (2, 'Curicó', 1);
INSERT INTO _comun.paquete VALUES (3, 'Parral', 2);
INSERT INTO _comun.paquete VALUES (4, 'Pelluhue', 2);


--
-- TOC entry 3780 (class 0 OID 385616)
-- Dependencies: 213
-- Data for Name: provincias; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.provincias VALUES ('124', 'Ultima Esperanza', '12');
INSERT INTO _comun.provincias VALUES ('011', 'Iquique  ', '01');
INSERT INTO _comun.provincias VALUES ('114', 'General Carrera', '11');
INSERT INTO _comun.provincias VALUES ('082', 'Arauco', '08');
INSERT INTO _comun.provincias VALUES ('081', 'Concepción  ', '08');
INSERT INTO _comun.provincias VALUES ('071', 'Talca', '07');
INSERT INTO _comun.provincias VALUES ('162', 'Itata', '16');
INSERT INTO _comun.provincias VALUES ('073', 'Curico', '07');
INSERT INTO _comun.provincias VALUES ('083', 'Bío- Bío', '08');
INSERT INTO _comun.provincias VALUES ('056', 'San Antonio  ', '05');
INSERT INTO _comun.provincias VALUES ('141', 'Valdivia  ', '14');
INSERT INTO _comun.provincias VALUES ('072', 'Cauquenes', '07');
INSERT INTO _comun.provincias VALUES ('102', 'Chiloe', '10');
INSERT INTO _comun.provincias VALUES ('092', 'Malleco', '09');
INSERT INTO _comun.provincias VALUES ('041', 'Elqui', '04');
INSERT INTO _comun.provincias VALUES ('033', 'Huasco', '03');
INSERT INTO _comun.provincias VALUES ('151', 'Arica  ', '15');
INSERT INTO _comun.provincias VALUES ('142', 'Ranco', '14');
INSERT INTO _comun.provincias VALUES ('031', 'Copiapó  ', '03');
INSERT INTO _comun.provincias VALUES ('021', 'Antofagasta', '02');
INSERT INTO _comun.provincias VALUES ('152', 'Parinacota', '15');
INSERT INTO _comun.provincias VALUES ('101', 'Llanquihue', '10');
INSERT INTO _comun.provincias VALUES ('042', 'Choapa', '04');
INSERT INTO _comun.provincias VALUES ('135', 'Melipilla', '13');
INSERT INTO _comun.provincias VALUES ('091', 'Cautín', '09');
INSERT INTO _comun.provincias VALUES ('061', 'Cachapoal', '06');
INSERT INTO _comun.provincias VALUES ('123', 'Tierra del Fuego', '12');
INSERT INTO _comun.provincias VALUES ('014', 'Tamarugal', '01');
INSERT INTO _comun.provincias VALUES ('062', 'Cardenal Caro', '06');
INSERT INTO _comun.provincias VALUES ('022', 'El Loa', '02');
INSERT INTO _comun.provincias VALUES ('054', 'Petorca', '05');
INSERT INTO _comun.provincias VALUES ('113', 'Capitan Prat', '11');
INSERT INTO _comun.provincias VALUES ('136', 'Talagante  ', '13');
INSERT INTO _comun.provincias VALUES ('053', 'Los Andes  ', '05');
INSERT INTO _comun.provincias VALUES ('133', 'Chacabuco', '13');
INSERT INTO _comun.provincias VALUES ('074', 'Linares  ', '07');
INSERT INTO _comun.provincias VALUES ('052', 'Isla de Pascua  ', '05');
INSERT INTO _comun.provincias VALUES ('161', 'Diguillín', '16');
INSERT INTO _comun.provincias VALUES ('023', 'Tocopilla  ', '02');
INSERT INTO _comun.provincias VALUES ('122', 'Antártica Chilena', '12');
INSERT INTO _comun.provincias VALUES ('057', 'San Felipe  ', '05');
INSERT INTO _comun.provincias VALUES ('112', 'Aisén  ', '11');
INSERT INTO _comun.provincias VALUES ('103', 'Osorno  ', '10');
INSERT INTO _comun.provincias VALUES ('032', 'Chañaral  ', '03');
INSERT INTO _comun.provincias VALUES ('058', 'Marga Marga', '05');
INSERT INTO _comun.provincias VALUES ('043', 'Limari', '04');
INSERT INTO _comun.provincias VALUES ('111', 'Coihaique  ', '11');
INSERT INTO _comun.provincias VALUES ('055', 'Quillota  ', '05');
INSERT INTO _comun.provincias VALUES ('134', 'Maipo', '13');
INSERT INTO _comun.provincias VALUES ('131', 'Santiago  ', '13');
INSERT INTO _comun.provincias VALUES ('132', 'Cordillera', '13');
INSERT INTO _comun.provincias VALUES ('063', 'Colchagua', '06');
INSERT INTO _comun.provincias VALUES ('104', 'Palena', '10');
INSERT INTO _comun.provincias VALUES ('163', 'Punilla', '16');
INSERT INTO _comun.provincias VALUES ('051', 'Valparaíso  ', '05');
INSERT INTO _comun.provincias VALUES ('121', 'Magallanes', '12');


--
-- TOC entry 3779 (class 0 OID 385608)
-- Dependencies: 212
-- Data for Name: regiones; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.regiones VALUES ('13', 'Metropolitana de Santiago');
INSERT INTO _comun.regiones VALUES ('15', 'De Arica y Parinacota');
INSERT INTO _comun.regiones VALUES ('09', 'De La Araucanía');
INSERT INTO _comun.regiones VALUES ('03', 'De Atacama');
INSERT INTO _comun.regiones VALUES ('01', 'De Tarapacá');
INSERT INTO _comun.regiones VALUES ('14', 'De Los Ríos');
INSERT INTO _comun.regiones VALUES ('02', 'De Antofagasta');
INSERT INTO _comun.regiones VALUES ('04', 'De Coquimbo');
INSERT INTO _comun.regiones VALUES ('10', 'De Los Lagos');
INSERT INTO _comun.regiones VALUES ('16', 'De Ñuble');
INSERT INTO _comun.regiones VALUES ('07', 'Del Maule');
INSERT INTO _comun.regiones VALUES ('12', 'De Magallanes y de La Antártica Chilena');
INSERT INTO _comun.regiones VALUES ('06', 'Del Libertador B. OHiggins');
INSERT INTO _comun.regiones VALUES ('05', 'De Valparaíso');
INSERT INTO _comun.regiones VALUES ('08', 'Del Bíobío');
INSERT INTO _comun.regiones VALUES ('11', 'De Aisén del Gral. C. Ibáñez del Campo');


--
-- TOC entry 3791 (class 0 OID 385721)
-- Dependencies: 224
-- Data for Name: servicio_comuna; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.servicio_comuna VALUES (1, 'SAE', '07202', 4, true);
INSERT INTO _comun.servicio_comuna VALUES (2, 'SAE', '07308', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (3, 'SAE', '07401', 3, true);
INSERT INTO _comun.servicio_comuna VALUES (4, 'SAE', '07307', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (5, 'SAE', '07403', 3, true);
INSERT INTO _comun.servicio_comuna VALUES (6, 'SAE', '07203', 4, true);
INSERT INTO _comun.servicio_comuna VALUES (7, 'SAE', '07302', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (8, 'SAE', '07402', 3, true);
INSERT INTO _comun.servicio_comuna VALUES (9, 'SAE', '07305', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (10, 'SAE', '07407', 3, true);
INSERT INTO _comun.servicio_comuna VALUES (11, 'SAE', '07301', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (12, 'SAE', '07309', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (13, 'SAE', '07304', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (14, 'SAE', '07404', 3, true);
INSERT INTO _comun.servicio_comuna VALUES (15, 'SAE', '07306', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (16, 'SAE', '07406', 3, true);
INSERT INTO _comun.servicio_comuna VALUES (17, 'SAE', '07303', 2, true);
INSERT INTO _comun.servicio_comuna VALUES (18, 'SAE', '07201', 4, true);
INSERT INTO _comun.servicio_comuna VALUES (19, 'SAE', '07408', 3, true);
INSERT INTO _comun.servicio_comuna VALUES (20, 'SAE', '07405', 3, true);


--
-- TOC entry 3776 (class 0 OID 385590)
-- Dependencies: 209
-- Data for Name: servicios; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.servicios VALUES (1, 'SAE', 'Servicio de Atención de Emergencias', true, true);


--
-- TOC entry 3775 (class 0 OID 385583)
-- Dependencies: 208
-- Data for Name: tipo_funcion_personal; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.tipo_funcion_personal VALUES (1, 'Maestro', false, true, false);
INSERT INTO _comun.tipo_funcion_personal VALUES (2, 'Ayudante', false, false, true);
INSERT INTO _comun.tipo_funcion_personal VALUES (3, 'sistema', true, false, false);


--
-- TOC entry 3773 (class 0 OID 385575)
-- Dependencies: 206
-- Data for Name: turnos; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.turnos VALUES (1, '00:00:00', '08:00:00', 'primer turno');
INSERT INTO _comun.turnos VALUES (2, '08:00:00', '16:00:00', 'segundo turno');
INSERT INTO _comun.turnos VALUES (3, '16:00:00', '24:00:00', 'tercer turno');
INSERT INTO _comun.turnos VALUES (4, '08:00:00', '18:30:00', 'cuarto turno');


--
-- TOC entry 3772 (class 0 OID 385570)
-- Dependencies: 205
-- Data for Name: zonal; Type: TABLE DATA; Schema: _comun; Owner: postgres
--

INSERT INTO _comun.zonal VALUES (1, '09. Maule Norte');
INSERT INTO _comun.zonal VALUES (2, '10. Maule Sur');


--
-- TOC entry 3820 (class 0 OID 386038)
-- Dependencies: 253
-- Data for Name: actividades_obra; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3822 (class 0 OID 386046)
-- Dependencies: 255
-- Data for Name: adicionales_edp; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3824 (class 0 OID 386054)
-- Dependencies: 257
-- Data for Name: bom; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.bom VALUES (32, 1, 123, 63241, 8);
INSERT INTO obras.bom VALUES (33, 1, 123, 49, 1);
INSERT INTO obras.bom VALUES (34, 1, 123, 40760, 2675.4);
INSERT INTO obras.bom VALUES (35, 1, 123, 13661, 10);
INSERT INTO obras.bom VALUES (36, 1, 124, 13661, 10);


--
-- TOC entry 3826 (class 0 OID 386059)
-- Dependencies: 259
-- Data for Name: coordinadores_contratista; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.coordinadores_contratista VALUES (1, 'Juan Soto', 1, '12.234.567.-7');


--
-- TOC entry 3828 (class 0 OID 386067)
-- Dependencies: 261
-- Data for Name: delegaciones; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.delegaciones VALUES (1, 'CGE Distribución Talca');
INSERT INTO obras.delegaciones VALUES (2, 'CGE Distribución Curicó');
INSERT INTO obras.delegaciones VALUES (3, 'CGE Distribución Cauquenes');
INSERT INTO obras.delegaciones VALUES (4, 'CGE Distribución Linares');
INSERT INTO obras.delegaciones VALUES (5, 'CGE Distribución Constitución');


--
-- TOC entry 3830 (class 0 OID 386075)
-- Dependencies: 263
-- Data for Name: detalle_edp; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3832 (class 0 OID 386083)
-- Dependencies: 265
-- Data for Name: detalle_pedido_material; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3834 (class 0 OID 386091)
-- Dependencies: 267
-- Data for Name: detalle_reporte_diario_actividad; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3836 (class 0 OID 386099)
-- Dependencies: 269
-- Data for Name: detalle_reporte_diario_material; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3838 (class 0 OID 386107)
-- Dependencies: 271
-- Data for Name: detalle_reporte_diario_otras_actividades; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3840 (class 0 OID 386115)
-- Dependencies: 273
-- Data for Name: empresas_contratista; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.empresas_contratista VALUES (1, 'Pelom Ingeniería', '76.000.000-1');


--
-- TOC entry 3842 (class 0 OID 386123)
-- Dependencies: 275
-- Data for Name: encabezado_edp; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3844 (class 0 OID 386131)
-- Dependencies: 277
-- Data for Name: encabezado_pedido_material; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3846 (class 0 OID 386139)
-- Dependencies: 279
-- Data for Name: encabezado_reporte_diario; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3884 (class 0 OID 418070)
-- Dependencies: 317
-- Data for Name: estado_obra; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.estado_obra VALUES (1, 'activo');
INSERT INTO obras.estado_obra VALUES (2, 'Visita Terreno coordinada');
INSERT INTO obras.estado_obra VALUES (3, 'Lista para Iniciar faena');
INSERT INTO obras.estado_obra VALUES (4, 'En Faena');
INSERT INTO obras.estado_obra VALUES (5, 'Paralizada');
INSERT INTO obras.estado_obra VALUES (6, 'Estado Pago Enviado');
INSERT INTO obras.estado_obra VALUES (7, 'Factura Emitida');
INSERT INTO obras.estado_obra VALUES (8, 'Factura Emitida');


--
-- TOC entry 3888 (class 0 OID 450720)
-- Dependencies: 321
-- Data for Name: estado_visita; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.estado_visita VALUES (2, 'EN EJECUCIÓN');
INSERT INTO obras.estado_visita VALUES (3, 'CANCELADA');
INSERT INTO obras.estado_visita VALUES (4, 'FALLIDA');
INSERT INTO obras.estado_visita VALUES (5, 'POSTERGADA');
INSERT INTO obras.estado_visita VALUES (6, 'EFECTUADA OK');
INSERT INTO obras.estado_visita VALUES (1, 'AGENDADA');


--
-- TOC entry 3848 (class 0 OID 386147)
-- Dependencies: 281
-- Data for Name: estructura_material; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3849 (class 0 OID 386153)
-- Dependencies: 282
-- Data for Name: estructuras_obra; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3850 (class 0 OID 386159)
-- Dependencies: 283
-- Data for Name: jefes_faena; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3818 (class 0 OID 386030)
-- Dependencies: 251
-- Data for Name: maestro_actividades; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.maestro_actividades VALUES (2, 'CAl 2 AAAC 1C', 11, 0.06, 0.04, 0.1, 'CAl 2 AAAC 1C');
INSERT INTO obras.maestro_actividades VALUES (3, 'CAl 2/2 AAAC 2C', 11, 0.11, 0.07, 0.18, 'CAl 2/2 AAAC 2C');
INSERT INTO obras.maestro_actividades VALUES (4, 'CAl 2/2 AAAC 3C', 11, 0.17, 0.11, 0.28, 'CAl 2/2 AAAC 3C');
INSERT INTO obras.maestro_actividades VALUES (5, 'CAl 2/2 AAAC 4C', 11, 0.23, 0.15, 0.38, 'CAl 2/2 AAAC 4C');
INSERT INTO obras.maestro_actividades VALUES (6, 'CAl 3/0 AAAC 1C', 11, 0.11, 0.09, 0.2, 'CAl 3/0 AAAC 1C');
INSERT INTO obras.maestro_actividades VALUES (7, 'CAl 3/0-3/0 AAAC 2C', 11, 0.23, 0.17, 0.4, 'CAl 3/0-3/0 AAAC 2C');
INSERT INTO obras.maestro_actividades VALUES (8, 'CAl 3/0-3/0 AAAC 3C', 11, 0.34, 0.26, 0.6, 'CAl 3/0-3/0 AAAC 3C');
INSERT INTO obras.maestro_actividades VALUES (9, 'CAl 3/0-3/0 AAAC 4C', 11, 0.45, 0.35, 0.8, 'CAl 3/0-3/0 AAAC 4C');
INSERT INTO obras.maestro_actividades VALUES (10, 'CCu 10 MM2 1C', 11, 0.04, 0.02, 0.06, 'CCu 10 MM2 1C');
INSERT INTO obras.maestro_actividades VALUES (11, 'CCu 10/10 MM2 2C', 11, 0.07, 0.05, 0.12, 'CCu 10/10 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (12, 'CCu 10/10 MM2 3C', 11, 0.11, 0.07, 0.18, 'CCu 10/10 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (13, 'CCu 13/13 MM2 2C', 11, 0.06, 0.04, 0.1, 'CCu 13/13 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (14, 'CCu 16 MM2 1C', 11, 0.04, 0.03, 0.07, 'CCu 16 MM2 1C');
INSERT INTO obras.maestro_actividades VALUES (15, 'CCu 16/16 MM2 2C', 11, 0.077, 0.05, 0.127, 'CCu 16/16 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (16, 'CCu 16/16 MM2 3C', 11, 0.114, 0.08, 0.194, 'CCu 16/16 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (17, 'CCu 16/16 MM2 4C', 11, 0.153, 0.1, 0.253, 'CCu 16/16 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (18, 'CCu 21/21 MM2 4C', 11, 0.14, 0.1, 0.24, 'CCu 21/21 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (19, 'CCu 25 MM2 1C', 11, 0.04, 0.03, 0.07, 'CCu 25 MM2 1C');
INSERT INTO obras.maestro_actividades VALUES (20, 'CCu 25/16 MM2 2C', 11, 0.08, 0.06, 0.14, 'CCu 25/16 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (21, 'CCu 25/16 MM2 3C', 11, 0.12, 0.09, 0.21, 'CCu 25/16 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (22, 'CCu 25/16 MM2 4C', 11, 0.16, 0.12, 0.28, 'CCu 25/16 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (23, 'CCu 25/25 MM2 2C', 11, 0.09, 0.06, 0.15, 'CCu 25/25 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (24, 'CCu 25/25 MM2 3C', 11, 0.13, 0.09, 0.22, 'CCu 25/25 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (25, 'CCu 25/25 MM2 4C', 11, 0.17, 0.12, 0.29, 'CCu 25/25 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (26, 'CCu 26.7/16 MM2 4C', 11, 0.16, 0.12, 0.28, 'CCu 26.7/16 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (27, 'CCu 26.7/26.7 MM2 4C', 11, 0.17, 0.12, 0.29, 'CCu 26.7/26.7 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (28, 'CCu 33.6 MM2 1C', 11, 0.05, 0.04, 0.09, 'CCu 33.6 MM2 1C');
INSERT INTO obras.maestro_actividades VALUES (29, 'CCu 33.6/16 MM2 2C', 11, 0.09, 0.06, 0.15, 'CCu 33.6/16 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (30, 'CCu 33.6/16 MM2 3C', 11, 0.14, 0.1, 0.24, 'CCu 33.6/16 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (31, 'CCu 33.6/16 MM2 4C', 11, 0.2, 0.14, 0.34, 'CCu 33.6/16 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (32, 'CCu 33.6/25 MM2 2C', 11, 0.1, 0.07, 0.17, 'CCu 33.6/25 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (33, 'CCu 33.6/25 MM2 3C', 11, 0.15, 0.11, 0.26, 'CCu 33.6/25 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (34, 'CCu 33.6/25 MM2 4C', 11, 0.2, 0.14, 0.34, 'CCu 33.6/25 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (35, 'CCu 33.6/33.6 MM2 2C', 11, 0.11, 0.08, 0.19, 'CCu 33.6/33.6 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (36, 'CCu 33.6/33.6 MM2 3C', 11, 0.16, 0.11, 0.27, 'CCu 33.6/33.6 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (37, 'CCu 33.6/33.6 MM2 4C', 11, 0.21, 0.15, 0.36, 'CCu 33.6/33.6 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (38, 'CCu 53.5 MM2 1C', 11, 0.08, 0.06, 0.14, 'CCu 53.5 MM2 1C');
INSERT INTO obras.maestro_actividades VALUES (39, 'CCu 53.5/25 MM2 2C', 11, 0.12, 0.09, 0.21, 'CCu 53.5/25 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (40, 'CCu 53.5/25 MM2 3C', 11, 0.2, 0.14, 0.34, 'CCu 53.5/25 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (41, 'CCu 53.5/25 MM2 4C', 11, 0.28, 0.2, 0.48, 'CCu 53.5/25 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (42, 'CCu 53.5/33.6 MM2 2C', 11, 0.13, 0.09, 0.22, 'CCu 53.5/33.6 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (43, 'CCu 53.5/33.6 MM2 3C', 11, 0.21, 0.15, 0.36, 'CCu 53.5/33.6 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (44, 'CCu 53.5/33.6 MM2 4C', 11, 0.29, 0.2, 0.49, 'CCu 53.5/33.6 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (45, 'CCu 53.5/53.5 MM2 2C', 11, 0.16, 0.11, 0.27, 'CCu 53.5/53.5 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (46, 'CCu 53.5/53.5 MM2 3C', 11, 0.23, 0.16, 0.39, 'CCu 53.5/53.5 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (47, 'CCu 53.5/53.5 MM2 4C', 11, 0.32, 0.22, 0.54, 'CCu 53.5/53.5 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (48, 'CCu 67.4 MM2 1C', 11, 0.1, 0.07, 0.17, 'CCu 67.4 MM2 1C');
INSERT INTO obras.maestro_actividades VALUES (49, 'CCu 67.4/25 MM2 4C', 11, 0.34, 0.24, 0.58, 'CCu 67.4/25 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (50, 'CCu 67.4/33.6 MM2 2C', 11, 0.15, 0.11, 0.26, 'CCu 67.4/33.6 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (51, 'CCu 67.4/33.6 MM2 3C', 11, 0.25, 0.17, 0.42, 'CCu 67.4/33.6 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (52, 'CCu 67.4/33.6 MM2 4C', 11, 0.35, 0.24, 0.59, 'CCu 67.4/33.6 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (53, 'CCu 67.4/53.5 MM2 2C', 11, 0.18, 0.13, 0.31, 'CCu 67.4/53.5 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (54, 'CCu 67.4/53.5 MM2 3C', 11, 0.28, 0.2, 0.48, 'CCu 67.4/53.5 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (55, 'CCu 67.4/53.5 MM2 4C', 11, 0.38, 0.27, 0.65, 'CCu 67.4/53.5 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (56, 'CCu 67.4/67.4 MM2 2C', 11, 0.2, 0.14, 0.34, 'CCu 67.4/67.4 MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (57, 'CCu 67.4/67.4 MM2 3C', 11, 0.3, 0.21, 0.51, 'CCu 67.4/67.4 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (58, 'CCu 67.4/67.4 MM2 4C', 11, 0.4, 0.27, 0.67, 'CCu 67.4/67.4 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (59, 'CCu 85/33.6 MM2 4C', 11, 0.35, 0.24, 0.59, 'CCu 85/33.6 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (60, 'CCu 85/53.5 MM2 4C', 11, 0.4, 0.28, 0.68, 'CCu 85/53.5 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (61, 'CCu 85/85 MM2 4C', 11, 0.45, 0.32, 0.77, 'CCu 85/85 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (62, 'Cpre 2x16', 11, 0.04, 0.02, 0.06, 'Cpre 2x16');
INSERT INTO obras.maestro_actividades VALUES (63, 'CPre 2x16 Neutro Des', 11, 0.04, 0.02, 0.06, 'CPre 2x16 Neutro Des');
INSERT INTO obras.maestro_actividades VALUES (64, 'CPre 2x25 Neutro Des', 11, 0.04, 0.02, 0.06, 'CPre 2x25 Neutro Des');
INSERT INTO obras.maestro_actividades VALUES (65, 'CPre 3x35/50', 11, 0.11, 0.08, 0.19, 'CPre 3x35/50');
INSERT INTO obras.maestro_actividades VALUES (66, 'CPre 3x50/50', 11, 0.13, 0.09, 0.22, 'CPre 3x50/50');
INSERT INTO obras.maestro_actividades VALUES (67, 'CPre 3x70/50', 11, 0.15, 0.1, 0.25, 'CPre 3x70/50');
INSERT INTO obras.maestro_actividades VALUES (68, 'CPre 3x95/50', 11, 0.17, 0.11, 0.28, 'CPre 3x95/50');
INSERT INTO obras.maestro_actividades VALUES (69, 'AlambreCu 6AWG 1ø', 12, 0.05, 0.04, 0.09, 'AlambreCu 6AWG 1ø');
INSERT INTO obras.maestro_actividades VALUES (70, 'AlambreCu 6AWG 2ø', 12, 0.07, 0.05, 0.12, 'AlambreCu 6AWG 2ø');
INSERT INTO obras.maestro_actividades VALUES (71, 'AlambreCu 6AWG 3ø', 12, 0.1, 0.07, 0.17, 'AlambreCu 6AWG 3ø');
INSERT INTO obras.maestro_actividades VALUES (72, 'CableCu #5AWG 3ø', 12, 0.1, 0.07, 0.17, 'CableCu #5AWG 3ø');
INSERT INTO obras.maestro_actividades VALUES (73, 'CableCu 350 MCM 3ø', 12, 0.4, 0.28, 0.68, 'CableCu 350 MCM 3ø');
INSERT INTO obras.maestro_actividades VALUES (74, 'CableCu 3AWG 2ø', 12, 0.08, 0.05, 0.13, 'CableCu 3AWG 2ø');
INSERT INTO obras.maestro_actividades VALUES (75, 'CableCu 3AWG 3ø', 12, 0.12, 0.08, 0.2, 'CableCu 3AWG 3ø');
INSERT INTO obras.maestro_actividades VALUES (76, 'CAl 1/0 AAAC 2ø', 12, 0.18, 0.12, 0.3, 'CAl 1/0 AAAC 2ø');
INSERT INTO obras.maestro_actividades VALUES (77, 'CAl 1/0 AAAC 3ø', 12, 0.26, 0.18, 0.44, 'CAl 1/0 AAAC 3ø');
INSERT INTO obras.maestro_actividades VALUES (78, 'CAl 120mm2 3ø', 12, 0.34, 0.26, 0.6, 'CAl 120mm2 3ø');
INSERT INTO obras.maestro_actividades VALUES (79, 'CAl 2 AAAC 1ø', 12, 0.08, 0.06, 0.14, 'CAl 2 AAAC 1ø');
INSERT INTO obras.maestro_actividades VALUES (80, 'CAl 2 AAAC 2ø', 12, 0.11, 0.08, 0.19, 'CAl 2 AAAC 2ø');
INSERT INTO obras.maestro_actividades VALUES (81, 'CAl 2 AAAC 3ø', 12, 0.17, 0.11, 0.28, 'CAl 2 AAAC 3ø');
INSERT INTO obras.maestro_actividades VALUES (82, 'CAl 3/0 AAAC 3ø', 12, 0.34, 0.26, 0.6, 'CAl 3/0 AAAC 3ø');
INSERT INTO obras.maestro_actividades VALUES (83, 'CAl 300mm2 3ø', 12, 0.52, 0.46, 0.98, 'CAl 300mm2 3ø');
INSERT INTO obras.maestro_actividades VALUES (84, 'CCo 150 mm2 3ø 15KV', 12, 0.6, 0.42, 1.02, 'CCo 150 mm2 3ø 15KV');
INSERT INTO obras.maestro_actividades VALUES (85, 'CCo 185 mm2 3Ø 25KV', 12, 0.63, 0.44, 1.07, 'CCo 185 mm2 3Ø 25KV');
INSERT INTO obras.maestro_actividades VALUES (86, 'CCo 300 mm2 3Ø 25KV', 12, 0.69, 0.48, 1.17, 'CCo 300 mm2 3Ø 25KV');
INSERT INTO obras.maestro_actividades VALUES (87, 'CCo 50 mm2 3ø 25 KV', 12, 0.48, 0.34, 0.82, 'CCo 50 mm2 3ø 25 KV');
INSERT INTO obras.maestro_actividades VALUES (88, 'CCo 70 mm2 2ø 25 KV', 12, 0.46, 0.32, 0.78, 'CCo 70 mm2 2ø 25 KV');
INSERT INTO obras.maestro_actividades VALUES (89, 'CCo 70 mm2 3ø 25 KV', 12, 0.52, 0.36, 0.88, 'CCo 70 mm2 3ø 25 KV');
INSERT INTO obras.maestro_actividades VALUES (90, 'CCo 95 mm2 3ø 15 KV', 12, 0.55, 0.39, 0.94, 'CCo 95 mm2 3ø 15 KV');
INSERT INTO obras.maestro_actividades VALUES (91, 'CCo 95 mm2 3ø 25KV', 12, 0.55, 0.39, 0.94, 'CCo 95 mm2 3ø 25KV');
INSERT INTO obras.maestro_actividades VALUES (92, 'CCu 107 mm2  3ø', 12, 0.31, 0.24, 0.55, 'CCu 107 mm2  3ø');
INSERT INTO obras.maestro_actividades VALUES (93, 'CCu 16 mm2  1ø', 12, 0.05, 0.04, 0.09, 'CCu 16 mm2  1ø');
INSERT INTO obras.maestro_actividades VALUES (94, 'CCu 16 mm2  2ø', 12, 0.07, 0.05, 0.12, 'CCu 16 mm2  2ø');
INSERT INTO obras.maestro_actividades VALUES (95, 'CCu 16 mm2  3ø', 12, 0.1, 0.07, 0.17, 'CCu 16 mm2  3ø');
INSERT INTO obras.maestro_actividades VALUES (96, 'CCu 25 mm2  2ø', 12, 0.08, 0.05, 0.13, 'CCu 25 mm2  2ø');
INSERT INTO obras.maestro_actividades VALUES (97, 'CCu 25 mm2  3ø', 12, 0.11, 0.08, 0.19, 'CCu 25 mm2  3ø');
INSERT INTO obras.maestro_actividades VALUES (98, 'CCu 33,6 mm2  2ø', 12, 0.1, 0.07, 0.17, 'CCu 33,6 mm2  2ø');
INSERT INTO obras.maestro_actividades VALUES (99, 'CCu 33,6 mm2  3ø', 12, 0.15, 0.1, 0.25, 'CCu 33,6 mm2  3ø');
INSERT INTO obras.maestro_actividades VALUES (100, 'CCu 53,5 mm2  2ø', 12, 0.16, 0.11, 0.27, 'CCu 53,5 mm2  2ø');
INSERT INTO obras.maestro_actividades VALUES (101, 'CCu 53,5 mm2  3ø', 12, 0.24, 0.16, 0.4, 'CCu 53,5 mm2  3ø');
INSERT INTO obras.maestro_actividades VALUES (102, 'CCu 67,4 mm2  2ø', 12, 0.19, 0.12, 0.31, 'CCu 67,4 mm2  2ø');
INSERT INTO obras.maestro_actividades VALUES (103, 'CCu 67,4 mm2  3ø', 12, 0.28, 0.19, 0.47, 'CCu 67,4 mm2  3ø');
INSERT INTO obras.maestro_actividades VALUES (104, 'CCu 85 mm2  3ø', 12, 0.31, 0.24, 0.55, 'CCu 85 mm2  3ø');
INSERT INTO obras.maestro_actividades VALUES (105, 'CPr 185 MM2 3Ø 25KV', 12, 0.5, 0.35, 0.85, 'CPr 185 MM2 3Ø 25KV');
INSERT INTO obras.maestro_actividades VALUES (106, 'CPr 300 mm2 3Ø 25KV', 12, 0.56, 0.39, 0.95, 'CPr 300 mm2 3Ø 25KV');
INSERT INTO obras.maestro_actividades VALUES (107, 'CPr 50 mm2 1ø 25 KV', 12, 0.19, 0.13, 0.32, 'CPr 50 mm2 1ø 25 KV');
INSERT INTO obras.maestro_actividades VALUES (108, 'CPr 50 mm2 2ø 25 KV', 12, 0.22, 0.15, 0.37, 'CPr 50 mm2 2ø 25 KV');
INSERT INTO obras.maestro_actividades VALUES (109, 'CPr 50 mm2 3Ø 25KV', 12, 0.35, 0.25, 0.6, 'CPr 50 mm2 3Ø 25KV');
INSERT INTO obras.maestro_actividades VALUES (110, 'CPr 70 mm2 2ø 25 KV', 12, 0.26, 0.18, 0.44, 'CPr 70 mm2 2ø 25 KV');
INSERT INTO obras.maestro_actividades VALUES (111, 'CPr 70 mm2 3ø 25 KV', 12, 0.39, 0.27, 0.66, 'CPr 70 mm2 3ø 25 KV');
INSERT INTO obras.maestro_actividades VALUES (112, 'CPr 95 mm2 3ø 15 KV', 12, 0.42, 0.3, 0.72, 'CPr 95 mm2 3ø 15 KV');
INSERT INTO obras.maestro_actividades VALUES (113, 'CPr 95 mm2 3ø 25KV', 12, 0.42, 0.3, 0.72, 'CPr 95 mm2 3ø 25KV');
INSERT INTO obras.maestro_actividades VALUES (114, 'THW 107/107 MM2 3C', 13, 0.5, 0.4, 0.9, 'THW 107/107 MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (115, 'THW 107/107 MM2 4C', 13, 0.66, 0.57, 1.23, 'THW 107/107 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (116, 'THW 107/THW 33MM2 4C', 13, 0.6, 0.4, 1, 'THW 107/THW 33MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (117, 'THW 21.2/13 MM2 4C', 13, 0.32, 0.24, 0.56, 'THW 21.2/13 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (118, 'THW 21.2/21.2 MM2 4C', 13, 0.32, 0.24, 0.56, 'THW 21.2/21.2 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (119, 'THW 21.2mm2  1C', 13, 0.08, 0.06, 0.14, 'THW 21.2mm2  1C');
INSERT INTO obras.maestro_actividades VALUES (120, 'THW 33.6/21.2 MM2 4C', 13, 0.44, 0.27, 0.71, 'THW 33.6/21.2 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (121, 'THW 33.6/33.6 MM2 4C', 13, 0.48, 0.32, 0.8, 'THW 33.6/33.6 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (122, 'THW 33.6MM2 1C', 13, 0.12, 0.09, 0.21, 'THW 33.6MM2 1C');
INSERT INTO obras.maestro_actividades VALUES (123, 'THW 400/400 MCM 4C', 13, 1, 0.88, 1.88, 'THW 400/400 MCM 4C');
INSERT INTO obras.maestro_actividades VALUES (124, 'THW 67.4/33.6 MM2 4C', 13, 0.57, 0.45, 1.02, 'THW 67.4/33.6 MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (125, 'THW 67.4/67.4MM2 4C', 13, 0.6, 0.48, 1.08, 'THW 67.4/67.4MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (126, 'USE 107/THW 33MM2 4C', 13, 0.63, 0.54, 1.17, 'USE 107/THW 33MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (127, 'USE 107/THW 67MM2 4C', 13, 0.66, 0.57, 1.23, 'USE 107/THW 67MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (128, 'USE 13/THW 13MM2 2C', 13, 0.23, 0.19, 0.42, 'USE 13/THW 13MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (129, 'USE 13/THW 13MM2 3C', 13, 0.23, 0.19, 0.42, 'USE 13/THW 13MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (130, 'USE 13/THW 13MM2 4C', 13, 0.23, 0.19, 0.42, 'USE 13/THW 13MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (131, 'USE 152/THW 107MM2 4', 13, 0.77, 0.66, 1.43, 'USE 152/THW 107MM2 4');
INSERT INTO obras.maestro_actividades VALUES (132, 'USE 177/THW 107MM2 4', 13, 0.77, 0.66, 1.43, 'USE 177/THW 107MM2 4');
INSERT INTO obras.maestro_actividades VALUES (133, 'USE 21/ 21MM2 2C', 13, 0.16, 0.12, 0.28, 'USE 21/ 21MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (134, 'USE 21/THW 13MM2 2C', 13, 0.3, 0.2, 0.5, 'USE 21/THW 13MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (135, 'USE 21/THW 13MM2 3C', 13, 0.22, 0.17, 0.39, 'USE 21/THW 13MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (136, 'USE 21/THW 13MM2 4C', 13, 0.3, 0.23, 0.53, 'USE 21/THW 13MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (137, 'USE 21/THW 21MM2 2C', 13, 0.32, 0.24, 0.56, 'USE 21/THW 21MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (138, 'USE 21/THW 21MM2 3C', 13, 0.24, 0.18, 0.42, 'USE 21/THW 21MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (139, 'USE 21/THW 21MM2 4C', 13, 0.32, 0.24, 0.56, 'USE 21/THW 21MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (140, 'USE 300/THW 300MCM 4', 13, 0.54, 0.3, 0.84, 'USE 300/THW 300MCM 4');
INSERT INTO obras.maestro_actividades VALUES (141, 'USE 33/THW 21MM2 2C', 13, 0.2, 0.15, 0.35, 'USE 33/THW 21MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (142, 'USE 33/THW 21MM2 3C', 13, 0.32, 0.24, 0.56, 'USE 33/THW 21MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (143, 'USE 33/THW 21MM2 4C', 13, 0.44, 0.27, 0.71, 'USE 33/THW 21MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (144, 'USE 33/THW 33MM2 2C', 13, 0.2, 0.15, 0.35, 'USE 33/THW 33MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (145, 'USE 33/THW 33MM2 3C', 13, 0.2, 0.15, 0.35, 'USE 33/THW 33MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (146, 'USE 33/THW 33MM2 4C', 13, 0.2, 0.15, 0.35, 'USE 33/THW 33MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (147, 'USE 53/THW 21MM2 4C', 13, 0.2, 0.15, 0.35, 'USE 53/THW 21MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (148, 'USE 53/USE 33MM2 4C', 13, 0.2, 0.15, 0.35, 'USE 53/USE 33MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (149, 'USE 53MM2 4C', 13, 0.2, 0.15, 0.35, 'USE 53MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (150, 'USE 67/THW 33MM2 4C', 13, 0.2, 0.15, 0.35, 'USE 67/THW 33MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (151, 'USE 67/THW 67MM2 4C', 13, 0.2, 0.15, 0.35, 'USE 67/THW 67MM2 4C');
INSERT INTO obras.maestro_actividades VALUES (152, 'USEoXTU 107/107 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 107/107 4C');
INSERT INTO obras.maestro_actividades VALUES (153, 'USEoXTU 107/67.4 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 107/67.4 4C');
INSERT INTO obras.maestro_actividades VALUES (154, 'USEOXTU 107/TH107 4C', 13, 0.2, 0.15, 0.35, 'USEOXTU 107/TH107 4C');
INSERT INTO obras.maestro_actividades VALUES (155, 'USEoXTU 152/107 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 152/107 4C');
INSERT INTO obras.maestro_actividades VALUES (156, 'USEoXTU 21.2/13.2 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 21.2/13.2 4C');
INSERT INTO obras.maestro_actividades VALUES (157, 'USEoXTU 21.2/21.2 3C', 13, 0.2, 0.15, 0.35, 'USEoXTU 21.2/21.2 3C');
INSERT INTO obras.maestro_actividades VALUES (158, 'USEoXTU 21.2/21.2 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 21.2/21.2 4C');
INSERT INTO obras.maestro_actividades VALUES (159, 'USEoXTU 33.6 1C', 13, 0.2, 0.15, 0.35, 'USEoXTU 33.6 1C');
INSERT INTO obras.maestro_actividades VALUES (160, 'USEoXTU 33.6/21.2 2C', 13, 0.2, 0.15, 0.35, 'USEoXTU 33.6/21.2 2C');
INSERT INTO obras.maestro_actividades VALUES (161, 'USEoXTU 33.6/21.2 3C', 13, 0.2, 0.15, 0.35, 'USEoXTU 33.6/21.2 3C');
INSERT INTO obras.maestro_actividades VALUES (162, 'USEoXTU 33.6/21.2 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 33.6/21.2 4C');
INSERT INTO obras.maestro_actividades VALUES (163, 'USEoXTU 33.6/33.6 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 33.6/33.6 4C');
INSERT INTO obras.maestro_actividades VALUES (164, 'USEoXTU 53.5MM2 2C', 13, 0.2, 0.15, 0.35, 'USEoXTU 53.5MM2 2C');
INSERT INTO obras.maestro_actividades VALUES (165, 'USEoXTU 53.5MM2 3C', 13, 0.2, 0.15, 0.35, 'USEoXTU 53.5MM2 3C');
INSERT INTO obras.maestro_actividades VALUES (166, 'USEoXTU 67.4/21.2 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 67.4/21.2 4C');
INSERT INTO obras.maestro_actividades VALUES (167, 'USEoXTU 67.4/33.6 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 67.4/33.6 4C');
INSERT INTO obras.maestro_actividades VALUES (168, 'USEoXTU 67/67.4 4C', 13, 0.2, 0.15, 0.35, 'USEoXTU 67/67.4 4C');
INSERT INTO obras.maestro_actividades VALUES (169, 'XT 500/500 MCM 4C', 13, 0.2, 0.15, 0.35, 'XT 500/500 MCM 4C');
INSERT INTO obras.maestro_actividades VALUES (170, 'XLPE # 1 AWG 3F 23K', 14, 0.21, 0.15, 0.36, 'XLPE # 1 AWG 3F 23K');
INSERT INTO obras.maestro_actividades VALUES (171, 'XLPE  240 mm2 3F 15K', 14, 0.42, 0.34, 0.76, 'XLPE  240 mm2 3F 15K');
INSERT INTO obras.maestro_actividades VALUES (172, 'XLPE #2AWG 2ø 15KV', 14, 0.24, 0.29, 0.53, 'XLPE #2AWG 2ø 15KV');
INSERT INTO obras.maestro_actividades VALUES (173, 'XLPE #2AWG 3ø 15KV', 14, 0.36, 0.29, 0.65, 'XLPE #2AWG 3ø 15KV');
INSERT INTO obras.maestro_actividades VALUES (174, 'XLPE #3/0AWG 3F 15KV', 14, 0.36, 0.29, 0.65, 'XLPE #3/0AWG 3F 15KV');
INSERT INTO obras.maestro_actividades VALUES (175, 'XLPE 120 mm ²3F 15KV', 14, 0.42, 0.34, 0.76, 'XLPE 120 mm ²3F 15KV');
INSERT INTO obras.maestro_actividades VALUES (176, 'XLPE 120 mm ²3F 23KV', 14, 0.42, 0.34, 0.76, 'XLPE 120 mm ²3F 23KV');
INSERT INTO obras.maestro_actividades VALUES (177, 'XLPE 240 mm ²3F 23KV', 14, 0.42, 0.34, 0.76, 'XLPE 240 mm ²3F 23KV');
INSERT INTO obras.maestro_actividades VALUES (178, 'Mufa Terminal 15KV', 14, 45, 27, 72, 'Mufa Terminal 15KV');
INSERT INTO obras.maestro_actividades VALUES (179, 'Mufa Union 15KV', 14, 45, 27, 72, 'Mufa Union 15KV');
INSERT INTO obras.maestro_actividades VALUES (180, 'Bota 90Gr 2AWG 600A', 14, 4.5, 3, 7.5, 'Bota 90Gr 2AWG 600A');
INSERT INTO obras.maestro_actividades VALUES (181, 'Bota 3/0 AWG', 14, 4.5, 3, 7.5, 'Bota 3/0 AWG');
INSERT INTO obras.maestro_actividades VALUES (182, 'XLPE 70 mm ²3F 23KV', 14, 0.42, 0.34, 0.76, 'XLPE 70 mm ²3F 23KV');
INSERT INTO obras.maestro_actividades VALUES (183, 'Cavanna 1ø', 15, 5, 3.8, 8.8, 'Cavanna 1ø');
INSERT INTO obras.maestro_actividades VALUES (184, 'Cavanna 2ø', 15, 5.5, 4, 9.5, 'Cavanna 2ø');
INSERT INTO obras.maestro_actividades VALUES (185, 'Cavanna 3ø', 15, 6, 4.2, 10.2, 'Cavanna 3ø');
INSERT INTO obras.maestro_actividades VALUES (186, 'Cavanna cuchillo LZ', 15, 6, 4.2, 10.2, 'Cavanna cuchillo LZ');
INSERT INTO obras.maestro_actividades VALUES (187, 'Cavanna NH00 1Ø', 15, 5, 3.8, 8.8, 'Cavanna NH00 1Ø');
INSERT INTO obras.maestro_actividades VALUES (188, 'Cavanna NH00 2Ø', 15, 5.5, 4, 9.5, 'Cavanna NH00 2Ø');
INSERT INTO obras.maestro_actividades VALUES (189, 'Cavanna NH00 3Ø', 15, 6, 4.2, 10.2, 'Cavanna NH00 3Ø');
INSERT INTO obras.maestro_actividades VALUES (190, 'PROT. 1F 5KVA', 15, 8, 4.8, 12.8, 'PROT. 1F 5KVA');
INSERT INTO obras.maestro_actividades VALUES (191, 'PROT. 1F 10KVA', 15, 8, 4.8, 12.8, 'PROT. 1F 10KVA');
INSERT INTO obras.maestro_actividades VALUES (192, 'PROT. 1F 15KVA', 15, 8, 4.8, 12.8, 'PROT. 1F 15KVA');
INSERT INTO obras.maestro_actividades VALUES (193, 'PROT. 1F 25KVA', 15, 8, 4.8, 12.8, 'PROT. 1F 25KVA');
INSERT INTO obras.maestro_actividades VALUES (194, 'PROT. 3F 15KVA', 15, 8, 4.8, 12.8, 'PROT. 3F 15KVA');
INSERT INTO obras.maestro_actividades VALUES (195, 'PROT. 3F 30KVA', 15, 10, 6, 16, 'PROT. 3F 30KVA');
INSERT INTO obras.maestro_actividades VALUES (196, 'PROT. 3F 45KVA', 15, 10, 6, 16, 'PROT. 3F 45KVA');
INSERT INTO obras.maestro_actividades VALUES (197, 'PROT. 3F 75KVA', 15, 17, 10.2, 27.2, 'PROT. 3F 75KVA');
INSERT INTO obras.maestro_actividades VALUES (198, 'PROT. 3F 100KVA', 15, 17, 10.2, 27.2, 'PROT. 3F 100KVA');
INSERT INTO obras.maestro_actividades VALUES (199, 'PROT. 3F 150KVA', 15, 17, 10.2, 27.2, 'PROT. 3F 150KVA');
INSERT INTO obras.maestro_actividades VALUES (200, 'PROT. 3F 200KVA', 15, 19, 11.4, 30.4, 'PROT. 3F 200KVA');
INSERT INTO obras.maestro_actividades VALUES (201, 'PROT. 3F 250KVA', 15, 19, 11.4, 30.4, 'PROT. 3F 250KVA');
INSERT INTO obras.maestro_actividades VALUES (202, 'PROT. 3F 300KVA', 15, 21, 12.6, 33.6, 'PROT. 3F 300KVA');
INSERT INTO obras.maestro_actividades VALUES (203, 'PSeg Ae 1ø', 15, 0.1, 0.1, 0.2, 'PSeg Ae 1ø');
INSERT INTO obras.maestro_actividades VALUES (204, 'PSeg Ae 2ø ', 15, 0.2, 0.1, 0.3, 'PSeg Ae 2ø ');
INSERT INTO obras.maestro_actividades VALUES (205, 'PSeg Ae 3ø', 15, 0.3, 0.1, 0.4, 'PSeg Ae 3ø');
INSERT INTO obras.maestro_actividades VALUES (206, 'Alduti 15kV', 16, 9.4, 6.6, 16, 'Alduti 15kV');
INSERT INTO obras.maestro_actividades VALUES (207, 'Alduti 23kV', 16, 9.4, 6.6, 16, 'Alduti 23kV');
INSERT INTO obras.maestro_actividades VALUES (208, 'TMC 2ø 15KV', 16, 13.5, 9.4, 22.9, 'TMC 2ø 15KV');
INSERT INTO obras.maestro_actividades VALUES (209, 'TMC 3ø 15KV', 16, 13.5, 9.4, 22.9, 'TMC 3ø 15KV');
INSERT INTO obras.maestro_actividades VALUES (210, 'RECONECT 15kV', 16, 13.5, 9.4, 22.9, 'RECONECT 15kV');
INSERT INTO obras.maestro_actividades VALUES (211, 'Gen Mov MT', 16, 28.3, 19.9, 48.2, 'Gen Mov MT');
INSERT INTO obras.maestro_actividades VALUES (212, 'AutoTransformador', 16, 28.3, 19.9, 48.2, 'AutoTransformador');
INSERT INTO obras.maestro_actividades VALUES (213, 'Banco Condensador 300kVAR', 16, 14.2, 10, 24.2, 'Banco Condensador 300kVAR');
INSERT INTO obras.maestro_actividades VALUES (214, 'Banco Condensador 450KVAR', 16, 14.2, 10, 24.2, 'Banco Condensador 450KVAR');
INSERT INTO obras.maestro_actividades VALUES (215, 'Banco Condensador 600KVAR', 16, 14.2, 10, 24.2, 'Banco Condensador 600KVAR');
INSERT INTO obras.maestro_actividades VALUES (216, 'Banco Condensador 750KVAR', 16, 14.2, 10, 24.2, 'Banco Condensador 750KVAR');
INSERT INTO obras.maestro_actividades VALUES (217, 'Banco Condensador 900KVAR', 16, 14.2, 10, 24.2, 'Banco Condensador 900KVAR');
INSERT INTO obras.maestro_actividades VALUES (218, 'Controlador Bco Condensadores', 16, 8.1, 5.7, 13.8, 'Controlador Bco Condensadores');
INSERT INTO obras.maestro_actividades VALUES (219, 'DF Rupt. 10000A 15/25kV', 16, 6.9, 4.9, 11.8, 'DF Rupt. 10000A 15/25kV');
INSERT INTO obras.maestro_actividades VALUES (220, 'DF Rupt. 12000A 15/25kV', 16, 6.9, 4.9, 11.8, 'DF Rupt. 12000A 15/25kV');
INSERT INTO obras.maestro_actividades VALUES (221, 'DF Rupt. 8000A 15/25kV', 16, 6.9, 4.9, 11.8, 'DF Rupt. 8000A 15/25kV');
INSERT INTO obras.maestro_actividades VALUES (222, 'M - FORCE 15 KV', 16, 9.4, 6.6, 16, 'M - FORCE 15 KV');
INSERT INTO obras.maestro_actividades VALUES (223, 'M - FORCE 23 KV', 16, 9.4, 6.6, 16, 'M - FORCE 23 KV');
INSERT INTO obras.maestro_actividades VALUES (224, 'Omnirupter 15KV', 16, 9.4, 6.6, 16, 'Omnirupter 15KV');
INSERT INTO obras.maestro_actividades VALUES (225, 'Omnirupter 23kV', 16, 9.4, 6.6, 16, 'Omnirupter 23kV');
INSERT INTO obras.maestro_actividades VALUES (226, 'Pararrayos 15 Kv 2ø', 16, 2, 1, 3, 'Pararrayos 15 Kv 2ø');
INSERT INTO obras.maestro_actividades VALUES (227, 'Pararrayos 15 Kv 3ø', 16, 3, 1.5, 4.5, 'Pararrayos 15 Kv 3ø');
INSERT INTO obras.maestro_actividades VALUES (228, 'Pararrayos 23 Kv 2ø', 16, 2, 1, 3, 'Pararrayos 23 Kv 2ø');
INSERT INTO obras.maestro_actividades VALUES (229, 'Pararrayos 23 Kv 3ø', 16, 3, 1.5, 4.5, 'Pararrayos 23 Kv 3ø');
INSERT INTO obras.maestro_actividades VALUES (230, 'Reconectador Electronico para 15KV', 16, 13.5, 9.4, 22.9, 'Reconectador Electronico para 15KV');
INSERT INTO obras.maestro_actividades VALUES (231, 'Reconectador Electronico para 23KV', 16, 13.5, 9.4, 22.9, 'Reconectador Electronico para 23KV');
INSERT INTO obras.maestro_actividades VALUES (232, 'Regulador de Voltaje 15 kV', 16, 122.83, 85.9, 208.73, 'Regulador de Voltaje 15 kV');
INSERT INTO obras.maestro_actividades VALUES (233, 'Regulador de Voltaje 23 kV', 16, 122.83, 85.9, 208.73, 'Regulador de Voltaje 23 kV');
INSERT INTO obras.maestro_actividades VALUES (234, 'DF 8kAR 1ø', 16, 1.5, 1.1, 2.6, 'DF 8kAR 1ø');
INSERT INTO obras.maestro_actividades VALUES (235, 'DF 8kAR 2ø', 16, 3.1, 2.2, 5.3, 'DF 8kAR 2ø');
INSERT INTO obras.maestro_actividades VALUES (236, 'DF 8kAR 3ø', 16, 3.8, 2.7, 6.5, 'DF 8kAR 3ø');
INSERT INTO obras.maestro_actividades VALUES (237, 'SC 2ø 300A 15/25kV', 16, 3.1, 2.2, 5.3, 'SC 2ø 300A 15/25kV');
INSERT INTO obras.maestro_actividades VALUES (390, 'BT P 76 M B1  n', 19, 0.4, 0.3, 0.7, 'BT P 76 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (238, 'SC 2ø 900A 15/25kV', 16, 3.1, 2.2, 5.3, 'SC 2ø 900A 15/25kV');
INSERT INTO obras.maestro_actividades VALUES (239, 'SC 3ø 300A 15/25kV', 16, 3.8, 2.7, 6.5, 'SC 3ø 300A 15/25kV');
INSERT INTO obras.maestro_actividades VALUES (240, 'SC 3ø 900A 15/25kV', 16, 3.8, 2.7, 6.5, 'SC 3ø 900A 15/25kV');
INSERT INTO obras.maestro_actividades VALUES (241, 'Protección BT NH hasta 400A', 17, 6, 4.2, 10.2, 'Protección BT NH hasta 400A');
INSERT INTO obras.maestro_actividades VALUES (242, 'Protección BT NH hasta 400A C/A', 17, 6, 4.2, 10.2, 'Protección BT NH hasta 400A C/A');
INSERT INTO obras.maestro_actividades VALUES (243, 'Protección BT NH hasta 630A C/A', 17, 6, 4.2, 10.2, 'Protección BT NH hasta 630A C/A');
INSERT INTO obras.maestro_actividades VALUES (244, 'ABB 2 vias', 18, 28.3, 19.9, 48.2, 'ABB 2 vias');
INSERT INTO obras.maestro_actividades VALUES (245, 'ABB 3 vias', 18, 28.3, 19.9, 48.2, 'ABB 3 vias');
INSERT INTO obras.maestro_actividades VALUES (246, 'ABB 4 vias', 18, 28.3, 19.9, 48.2, 'ABB 4 vias');
INSERT INTO obras.maestro_actividades VALUES (247, 'Vista 4 vias', 18, 28.3, 12, 40.3, 'Vista 4 vias');
INSERT INTO obras.maestro_actividades VALUES (248, 'Vista 5 vias', 18, 28.3, 12, 40.3, 'Vista 5 vias');
INSERT INTO obras.maestro_actividades VALUES (249, 'BARRA SE1PC 2*5C', 19, 3.7, 2.9, 6.6, 'BARRA SE1PC 2*5C');
INSERT INTO obras.maestro_actividades VALUES (250, 'BARRA SE1PC 3C', 19, 1.7, 1.3, 3, 'BARRA SE1PC 3C');
INSERT INTO obras.maestro_actividades VALUES (251, 'BARRA SE1PC 4C', 19, 2.1, 1.6, 3.7, 'BARRA SE1PC 4C');
INSERT INTO obras.maestro_actividades VALUES (252, 'BARRA SE1PC 5C', 19, 2.3, 1.7, 4, 'BARRA SE1PC 5C');
INSERT INTO obras.maestro_actividades VALUES (253, 'BARRA SE1PC PR1ø', 19, 1.2, 1, 2.2, 'BARRA SE1PC PR1ø');
INSERT INTO obras.maestro_actividades VALUES (254, 'BARRA SE1PC PR1ø 2S', 19, 3.2, 2.6, 5.8, 'BARRA SE1PC PR1ø 2S');
INSERT INTO obras.maestro_actividades VALUES (255, 'BARRA SE1PC PR3ø', 19, 3.3, 2.4, 5.7, 'BARRA SE1PC PR3ø');
INSERT INTO obras.maestro_actividades VALUES (256, 'BARRA SE1PC PR3ø 2S', 19, 3.9, 3, 6.9, 'BARRA SE1PC PR3ø 2S');
INSERT INTO obras.maestro_actividades VALUES (257, 'BARRA SE2PC', 19, 20.2, 14.2, 34.4, 'BARRA SE2PC');
INSERT INTO obras.maestro_actividades VALUES (258, 'BARRA SE2PC PR3ø', 19, 5.2, 4, 9.2, 'BARRA SE2PC PR3ø');
INSERT INTO obras.maestro_actividades VALUES (259, 'BT BS 3"', 19, 26.7, 8.4, 29.8, 'BT BS 3"');
INSERT INTO obras.maestro_actividades VALUES (260, 'BT BS 4"', 19, 26.7, 8.4, 29.8, 'BT BS 4"');
INSERT INTO obras.maestro_actividades VALUES (261, 'DUCTO PVC BT 1 X 110', 19, 1.2, 0.84, 1.56, 'DUCTO PVC BT 1 X 110');
INSERT INTO obras.maestro_actividades VALUES (262, 'BT 76 M 5C ES', 19, 2.2, 1.7, 3.3, 'BT 76 M 5C ES');
INSERT INTO obras.maestro_actividades VALUES (263, 'BT LZ 57 B SB nr', 19, 1.1, 0.8, 1.9, 'BT LZ 57 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (264, 'BT LZ 57 B SB nrs', 19, 1.7, 1.3, 3, 'BT LZ 57 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (265, 'BT LZ 57 B SB nrst', 19, 2.3, 1.8, 4.1, 'BT LZ 57 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (266, 'BT LZ 57 M B1  nr', 19, 1.1, 0.8, 1.9, 'BT LZ 57 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (267, 'BT LZ 57 M SB nr', 19, 1.1, 0.8, 1.9, 'BT LZ 57 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (268, 'BT LZ 57 M SB nrs', 19, 1.7, 1.3, 3, 'BT LZ 57 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (269, 'BT LZ 57 M SB nrst', 19, 2.3, 1.8, 4.1, 'BT LZ 57 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (270, 'BT LZ 76 B B1  n', 19, 0.8, 0.6, 1.4, 'BT LZ 76 B B1  n');
INSERT INTO obras.maestro_actividades VALUES (271, 'BT LZ 76 B B1  nr', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B B1  nr');
INSERT INTO obras.maestro_actividades VALUES (272, 'BT LZ 76 B B1  nrs', 19, 1.7, 1.3, 3, 'BT LZ 76 B B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (273, 'BT LZ 76 B B1  nrst', 19, 2.3, 1.8, 4.1, 'BT LZ 76 B B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (274, 'BT LZ 76 B B1  nrt', 19, 1.7, 1.3, 3, 'BT LZ 76 B B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (275, 'BT LZ 76 B B1  ns', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B B1  ns');
INSERT INTO obras.maestro_actividades VALUES (276, 'BT LZ 76 B B1  nst', 19, 1.7, 1.3, 3, 'BT LZ 76 B B1  nst');
INSERT INTO obras.maestro_actividades VALUES (277, 'BT LZ 76 B B1  nt', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B B1  nt');
INSERT INTO obras.maestro_actividades VALUES (278, 'BT LZ 76 B B2  n', 19, 0.8, 0.6, 1.4, 'BT LZ 76 B B2  n');
INSERT INTO obras.maestro_actividades VALUES (279, 'BT LZ 76 B B2  nr', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B B2  nr');
INSERT INTO obras.maestro_actividades VALUES (280, 'BT LZ 76 B B2  nrs', 19, 1.7, 1.3, 3, 'BT LZ 76 B B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (281, 'BT LZ 76 B B2  nrst', 19, 2.3, 1.8, 4.1, 'BT LZ 76 B B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (282, 'BT LZ 76 B B2  nrt', 19, 1.7, 1.3, 3, 'BT LZ 76 B B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (283, 'BT LZ 76 B B2  ns', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B B2  ns');
INSERT INTO obras.maestro_actividades VALUES (284, 'BT LZ 76 B B2  nst', 19, 1.7, 1.3, 3, 'BT LZ 76 B B2  nst');
INSERT INTO obras.maestro_actividades VALUES (285, 'BT LZ 76 B B2  nt', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B B2  nt');
INSERT INTO obras.maestro_actividades VALUES (286, 'BT LZ 76 B SB n', 19, 0.8, 0.6, 1.4, 'BT LZ 76 B SB n');
INSERT INTO obras.maestro_actividades VALUES (287, 'BT LZ 76 B SB nr', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (288, 'BT LZ 76 B SB nrs', 19, 1.7, 1.3, 3, 'BT LZ 76 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (289, 'BT LZ 76 B SB nrst', 19, 2.3, 1.8, 4.1, 'BT LZ 76 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (290, 'BT LZ 76 B SB nrt', 19, 1.7, 1.3, 3, 'BT LZ 76 B SB nrt');
INSERT INTO obras.maestro_actividades VALUES (291, 'BT LZ 76 B SB ns', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B SB ns');
INSERT INTO obras.maestro_actividades VALUES (292, 'BT LZ 76 B SB nst', 19, 1.7, 1.3, 3, 'BT LZ 76 B SB nst');
INSERT INTO obras.maestro_actividades VALUES (293, 'BT LZ 76 B SB nt', 19, 1.1, 0.8, 1.9, 'BT LZ 76 B SB nt');
INSERT INTO obras.maestro_actividades VALUES (294, 'BT LZ 76 M B1  n', 19, 0.8, 0.6, 1.4, 'BT LZ 76 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (295, 'BT LZ 76 M B1  nr', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (296, 'BT LZ 76 M B1  nrs', 19, 1.7, 1.3, 3, 'BT LZ 76 M B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (297, 'BT LZ 76 M B1  nrst', 19, 2.3, 1.8, 4.1, 'BT LZ 76 M B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (298, 'BT LZ 76 M B1  nrt', 19, 1.7, 1.3, 3, 'BT LZ 76 M B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (299, 'BT LZ 76 M B1  ns', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M B1  ns');
INSERT INTO obras.maestro_actividades VALUES (300, 'BT LZ 76 M B1  nst', 19, 1.7, 1.3, 3, 'BT LZ 76 M B1  nst');
INSERT INTO obras.maestro_actividades VALUES (301, 'BT LZ 76 M B1  nt', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M B1  nt');
INSERT INTO obras.maestro_actividades VALUES (302, 'BT LZ 76 M B2  n', 19, 0.8, 0.6, 1.4, 'BT LZ 76 M B2  n');
INSERT INTO obras.maestro_actividades VALUES (303, 'BT LZ 76 M B2  nr', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M B2  nr');
INSERT INTO obras.maestro_actividades VALUES (304, 'BT LZ 76 M B2  nrs', 19, 1.7, 1.3, 3, 'BT LZ 76 M B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (305, 'BT LZ 76 M B2  nrst', 19, 2.3, 1.8, 4.1, 'BT LZ 76 M B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (306, 'BT LZ 76 M B2  nrt', 19, 1.7, 1.3, 3, 'BT LZ 76 M B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (307, 'BT LZ 76 M B2  ns', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M B2  ns');
INSERT INTO obras.maestro_actividades VALUES (308, 'BT LZ 76 M B2  nst', 19, 1.7, 1.3, 3, 'BT LZ 76 M B2  nst');
INSERT INTO obras.maestro_actividades VALUES (309, 'BT LZ 76 M B2  nt', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M B2  nt');
INSERT INTO obras.maestro_actividades VALUES (310, 'BT LZ 76 M SB n', 19, 0.8, 0.6, 1.4, 'BT LZ 76 M SB n');
INSERT INTO obras.maestro_actividades VALUES (311, 'BT LZ 76 M SB nr', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (312, 'BT LZ 76 M SB nrs', 19, 1.7, 1.3, 3, 'BT LZ 76 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (313, 'BT LZ 76 M SB nrst', 19, 2.3, 1.8, 4.1, 'BT LZ 76 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (314, 'BT LZ 76 M SB nrt', 19, 1.7, 1.3, 3, 'BT LZ 76 M SB nrt');
INSERT INTO obras.maestro_actividades VALUES (315, 'BT LZ 76 M SB ns', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M SB ns');
INSERT INTO obras.maestro_actividades VALUES (316, 'BT LZ 76 M SB nst', 19, 1.7, 1.3, 3, 'BT LZ 76 M SB nst');
INSERT INTO obras.maestro_actividades VALUES (317, 'BT LZ 76 M SB nt', 19, 1.1, 0.8, 1.9, 'BT LZ 76 M SB nt');
INSERT INTO obras.maestro_actividades VALUES (318, 'BT P 57 B B1  n', 19, 0.4, 0.3, 0.7, 'BT P 57 B B1  n');
INSERT INTO obras.maestro_actividades VALUES (319, 'BT P 57 B B1  nr', 19, 0.7, 0.5, 1.2, 'BT P 57 B B1  nr');
INSERT INTO obras.maestro_actividades VALUES (320, 'BT P 57 B B1  nrs', 19, 1, 0.8, 1.8, 'BT P 57 B B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (321, 'BT P 57 B B1  nrst', 19, 1.3, 1, 2.3, 'BT P 57 B B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (322, 'BT P 57 B B1  nrt', 19, 1, 0.8, 1.8, 'BT P 57 B B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (323, 'BT P 57 B B1  ns', 19, 0.7, 0.5, 1.2, 'BT P 57 B B1  ns');
INSERT INTO obras.maestro_actividades VALUES (324, 'BT P 57 B B1  nst', 19, 1, 0.8, 1.8, 'BT P 57 B B1  nst');
INSERT INTO obras.maestro_actividades VALUES (325, 'BT P 57 B B1  nt', 19, 0.7, 0.5, 1.2, 'BT P 57 B B1  nt');
INSERT INTO obras.maestro_actividades VALUES (326, 'BT P 57 B B2  n', 19, 0.4, 0.3, 0.7, 'BT P 57 B B2  n');
INSERT INTO obras.maestro_actividades VALUES (327, 'BT P 57 B B2  nr', 19, 0.7, 0.5, 1.2, 'BT P 57 B B2  nr');
INSERT INTO obras.maestro_actividades VALUES (328, 'BT P 57 B B2  nrs', 19, 1, 0.8, 1.8, 'BT P 57 B B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (329, 'BT P 57 B B2  nrst', 19, 1.3, 1, 2.3, 'BT P 57 B B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (330, 'BT P 57 B B2  nrt', 19, 1, 0.8, 1.8, 'BT P 57 B B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (331, 'BT P 57 B B2  ns', 19, 0.7, 0.5, 1.2, 'BT P 57 B B2  ns');
INSERT INTO obras.maestro_actividades VALUES (332, 'BT P 57 B B2  nst', 19, 1, 0.8, 1.8, 'BT P 57 B B2  nst');
INSERT INTO obras.maestro_actividades VALUES (333, 'BT P 57 B B2  nt', 19, 0.7, 0.5, 1.2, 'BT P 57 B B2  nt');
INSERT INTO obras.maestro_actividades VALUES (334, 'BT P 57 B SB n', 19, 0.4, 0.3, 0.7, 'BT P 57 B SB n');
INSERT INTO obras.maestro_actividades VALUES (335, 'BT P 57 B SB nr', 19, 0.7, 0.5, 1.2, 'BT P 57 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (336, 'BT P 57 B SB nrs', 19, 1, 0.8, 1.8, 'BT P 57 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (337, 'BT P 57 B SB nrst', 19, 1.3, 1, 2.3, 'BT P 57 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (338, 'BT P 57 B SB nrt', 19, 1, 0.8, 1.8, 'BT P 57 B SB nrt');
INSERT INTO obras.maestro_actividades VALUES (339, 'BT P 57 B SB ns', 19, 0.7, 0.5, 1.2, 'BT P 57 B SB ns');
INSERT INTO obras.maestro_actividades VALUES (340, 'BT P 57 B SB nst', 19, 1, 0.8, 1.8, 'BT P 57 B SB nst');
INSERT INTO obras.maestro_actividades VALUES (341, 'BT P 57 B SB nt', 19, 0.7, 0.5, 1.2, 'BT P 57 B SB nt');
INSERT INTO obras.maestro_actividades VALUES (342, 'BT P 57 M B1  n', 19, 0.4, 0.3, 0.7, 'BT P 57 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (343, 'BT P 57 M B1  nr', 19, 0.7, 0.5, 1.2, 'BT P 57 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (344, 'BT P 57 M B1  nrs', 19, 1, 0.8, 1.8, 'BT P 57 M B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (345, 'BT P 57 M B1  nrst', 19, 1.3, 1, 2.3, 'BT P 57 M B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (346, 'BT P 57 M B1  nrt', 19, 1, 0.8, 1.8, 'BT P 57 M B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (347, 'BT P 57 M B1  ns', 19, 0.7, 0.5, 1.2, 'BT P 57 M B1  ns');
INSERT INTO obras.maestro_actividades VALUES (348, 'BT P 57 M B1  nst', 19, 1, 0.8, 1.8, 'BT P 57 M B1  nst');
INSERT INTO obras.maestro_actividades VALUES (349, 'BT P 57 M B1  nt', 19, 0.7, 0.5, 1.2, 'BT P 57 M B1  nt');
INSERT INTO obras.maestro_actividades VALUES (350, 'BT P 57 M B2  n', 19, 0.4, 0.3, 0.7, 'BT P 57 M B2  n');
INSERT INTO obras.maestro_actividades VALUES (351, 'BT P 57 M B2  nr', 19, 0.7, 0.5, 1.2, 'BT P 57 M B2  nr');
INSERT INTO obras.maestro_actividades VALUES (352, 'BT P 57 M B2  nrs', 19, 1, 0.8, 1.8, 'BT P 57 M B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (353, 'BT P 57 M B2  nrst', 19, 1.3, 1, 2.3, 'BT P 57 M B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (354, 'BT P 57 M B2  nrt', 19, 1, 0.8, 1.8, 'BT P 57 M B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (355, 'BT P 57 M B2  ns', 19, 0.7, 0.5, 1.2, 'BT P 57 M B2  ns');
INSERT INTO obras.maestro_actividades VALUES (356, 'BT P 57 M B2  nst', 19, 1, 0.8, 1.8, 'BT P 57 M B2  nst');
INSERT INTO obras.maestro_actividades VALUES (357, 'BT P 57 M B2  nt', 19, 0.7, 0.5, 1.2, 'BT P 57 M B2  nt');
INSERT INTO obras.maestro_actividades VALUES (358, 'BT P 57 M SB n', 19, 0.4, 0.3, 0.7, 'BT P 57 M SB n');
INSERT INTO obras.maestro_actividades VALUES (359, 'BT P 57 M SB nr', 19, 0.7, 0.5, 1.2, 'BT P 57 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (360, 'BT P 57 M SB nrs', 19, 1, 0.8, 1.8, 'BT P 57 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (574, 'BT RL 76 M SB n', 19, 0.4, 0.3, 0.7, 'BT RL 76 M SB n');
INSERT INTO obras.maestro_actividades VALUES (361, 'BT P 57 M SB nrst', 19, 1.3, 1, 2.3, 'BT P 57 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (362, 'BT P 57 M SB nrt', 19, 1, 0.8, 1.8, 'BT P 57 M SB nrt');
INSERT INTO obras.maestro_actividades VALUES (363, 'BT P 57 M SB ns', 19, 0.7, 0.5, 1.2, 'BT P 57 M SB ns');
INSERT INTO obras.maestro_actividades VALUES (364, 'BT P 57 M SB nst', 19, 1, 0.8, 1.8, 'BT P 57 M SB nst');
INSERT INTO obras.maestro_actividades VALUES (365, 'BT P 57 M SB nt', 19, 0.7, 0.5, 1.2, 'BT P 57 M SB nt');
INSERT INTO obras.maestro_actividades VALUES (366, 'BT P 76 B B1  n', 19, 0.4, 0.3, 0.7, 'BT P 76 B B1  n');
INSERT INTO obras.maestro_actividades VALUES (367, 'BT P 76 B B1  nr', 19, 0.7, 0.5, 1.2, 'BT P 76 B B1  nr');
INSERT INTO obras.maestro_actividades VALUES (368, 'BT P 76 B B1  nrs', 19, 1, 0.8, 1.8, 'BT P 76 B B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (369, 'BT P 76 B B1  nrst', 19, 1.3, 1, 2.3, 'BT P 76 B B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (370, 'BT P 76 B B1  nrt', 19, 1, 0.8, 1.8, 'BT P 76 B B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (371, 'BT P 76 B B1  ns ', 19, 0.7, 0.5, 1.2, 'BT P 76 B B1  ns ');
INSERT INTO obras.maestro_actividades VALUES (372, 'BT P 76 B B1  nst', 19, 1, 0.8, 1.8, 'BT P 76 B B1  nst');
INSERT INTO obras.maestro_actividades VALUES (373, 'BT P 76 B B1  nt', 19, 0.7, 0.5, 1.2, 'BT P 76 B B1  nt');
INSERT INTO obras.maestro_actividades VALUES (374, 'BT P 76 B B2  n', 19, 0.4, 0.3, 0.7, 'BT P 76 B B2  n');
INSERT INTO obras.maestro_actividades VALUES (375, 'BT P 76 B B2  nr', 19, 0.7, 0.5, 1.2, 'BT P 76 B B2  nr');
INSERT INTO obras.maestro_actividades VALUES (376, 'BT P 76 B B2  nrs', 19, 1, 0.8, 1.8, 'BT P 76 B B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (377, 'BT P 76 B B2  nrst', 19, 1.3, 1, 2.3, 'BT P 76 B B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (378, 'BT P 76 B B2  nrt', 19, 1, 0.8, 1.8, 'BT P 76 B B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (379, 'BT P 76 B B2  ns', 19, 0.7, 0.5, 1.2, 'BT P 76 B B2  ns');
INSERT INTO obras.maestro_actividades VALUES (380, 'BT P 76 B B2  nst', 19, 1, 0.8, 1.8, 'BT P 76 B B2  nst');
INSERT INTO obras.maestro_actividades VALUES (381, 'BT P 76 B B2  nt', 19, 0.7, 0.5, 1.2, 'BT P 76 B B2  nt');
INSERT INTO obras.maestro_actividades VALUES (382, 'BT P 76 B SB n', 19, 0.4, 0.3, 0.7, 'BT P 76 B SB n');
INSERT INTO obras.maestro_actividades VALUES (383, 'BT P 76 B SB nr', 19, 0.7, 0.5, 1.2, 'BT P 76 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (384, 'BT P 76 B SB nrs', 19, 1, 0.8, 1.8, 'BT P 76 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (385, 'BT P 76 B SB nrst', 19, 1.3, 1, 2.3, 'BT P 76 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (386, 'BT P 76 B SB nrt', 19, 1, 0.8, 1.8, 'BT P 76 B SB nrt');
INSERT INTO obras.maestro_actividades VALUES (387, 'BT P 76 B SB ns', 19, 0.7, 0.5, 1.2, 'BT P 76 B SB ns');
INSERT INTO obras.maestro_actividades VALUES (388, 'BT P 76 B SB nst', 19, 1, 0.8, 1.8, 'BT P 76 B SB nst');
INSERT INTO obras.maestro_actividades VALUES (389, 'BT P 76 B SB nt', 19, 0.7, 0.5, 1.2, 'BT P 76 B SB nt');
INSERT INTO obras.maestro_actividades VALUES (391, 'BT P 76 M B1  nr', 19, 0.7, 0.5, 1.2, 'BT P 76 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (392, 'BT P 76 M B1  nrs', 19, 1, 0.8, 1.8, 'BT P 76 M B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (393, 'BT P 76 M B1  nrst', 19, 1.3, 1, 2.3, 'BT P 76 M B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (394, 'BT P 76 M B1  nrt', 19, 1, 0.8, 1.8, 'BT P 76 M B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (395, 'BT P 76 M B1  ns', 19, 0.7, 0.5, 1.2, 'BT P 76 M B1  ns');
INSERT INTO obras.maestro_actividades VALUES (396, 'BT P 76 M B1  nst', 19, 1, 0.8, 1.8, 'BT P 76 M B1  nst');
INSERT INTO obras.maestro_actividades VALUES (397, 'BT P 76 M B1  nt', 19, 0.7, 0.5, 1.2, 'BT P 76 M B1  nt');
INSERT INTO obras.maestro_actividades VALUES (398, 'BT P 76 M B2  n', 19, 0.4, 0.3, 0.7, 'BT P 76 M B2  n');
INSERT INTO obras.maestro_actividades VALUES (399, 'BT P 76 M B2  nr', 19, 0.7, 0.5, 1.2, 'BT P 76 M B2  nr');
INSERT INTO obras.maestro_actividades VALUES (400, 'BT P 76 M B2  nrs', 19, 1, 0.8, 1.8, 'BT P 76 M B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (401, 'BT P 76 M B2  nrst', 19, 1.3, 1, 2.3, 'BT P 76 M B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (402, 'BT P 76 M B2  nrt', 19, 1, 0.8, 1.8, 'BT P 76 M B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (403, 'BT P 76 M B2  ns', 19, 0.7, 0.5, 1.2, 'BT P 76 M B2  ns');
INSERT INTO obras.maestro_actividades VALUES (404, 'BT P 76 M B2  nst', 19, 1, 0.8, 1.8, 'BT P 76 M B2  nst');
INSERT INTO obras.maestro_actividades VALUES (405, 'BT P 76 M B2  nt', 19, 0.7, 0.5, 1.2, 'BT P 76 M B2  nt');
INSERT INTO obras.maestro_actividades VALUES (406, 'BT P 76 M SB n', 19, 0.4, 0.3, 0.7, 'BT P 76 M SB n');
INSERT INTO obras.maestro_actividades VALUES (407, 'BT P 76 M SB nr', 19, 0.7, 0.5, 1.2, 'BT P 76 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (408, 'BT P 76 M SB nrs', 19, 1, 0.8, 1.8, 'BT P 76 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (409, 'BT P 76 M SB nrst', 19, 1.3, 1, 2.3, 'BT P 76 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (410, 'BT P 76 M SB nrt', 19, 1, 0.8, 1.8, 'BT P 76 M SB nrt');
INSERT INTO obras.maestro_actividades VALUES (411, 'BT P 76 M SB ns ', 19, 0.7, 0.5, 1.2, 'BT P 76 M SB ns ');
INSERT INTO obras.maestro_actividades VALUES (412, 'BT P 76 M SB nst', 19, 1, 0.8, 1.8, 'BT P 76 M SB nst');
INSERT INTO obras.maestro_actividades VALUES (413, 'BT P 76 M SB nt', 19, 0.7, 0.5, 1.2, 'BT P 76 M SB nt');
INSERT INTO obras.maestro_actividades VALUES (414, 'BT R 57 B SB nr', 19, 0.7, 0.5, 1.2, 'BT R 57 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (415, 'BT R 57 B SB nrs', 19, 1, 0.8, 1.8, 'BT R 57 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (416, 'BT R 57 B SB nrst', 19, 1.3, 2, 3.3, 'BT R 57 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (417, 'BT R 57 M B1  n', 19, 0.4, 0.3, 0.7, 'BT R 57 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (418, 'BT R 57 M B1  nr', 19, 0.7, 0.5, 1.2, 'BT R 57 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (419, 'BT R 57 M SB nr', 19, 0.7, 0.5, 1.2, 'BT R 57 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (420, 'BT R 57 M SB nrs', 19, 1, 0.8, 1.8, 'BT R 57 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (421, 'BT R 57 M SB nrst', 19, 1.3, 2, 3.3, 'BT R 57 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (422, 'BT R 76 B B1  n', 19, 0.4, 0.3, 0.7, 'BT R 76 B B1  n');
INSERT INTO obras.maestro_actividades VALUES (423, 'BT R 76 B B1  nr', 19, 0.7, 0.5, 1.2, 'BT R 76 B B1  nr');
INSERT INTO obras.maestro_actividades VALUES (424, 'BT R 76 B B1  nrs', 19, 1, 0.8, 1.8, 'BT R 76 B B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (425, 'BT R 76 B B1  nrst', 19, 1.3, 1, 2.3, 'BT R 76 B B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (426, 'BT R 76 B B1  nrt', 19, 1, 0.8, 1.8, 'BT R 76 B B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (427, 'BT R 76 B B1  ns', 19, 0.7, 0.5, 1.2, 'BT R 76 B B1  ns');
INSERT INTO obras.maestro_actividades VALUES (428, 'BT R 76 B B1  nst', 19, 1, 0.8, 1.8, 'BT R 76 B B1  nst');
INSERT INTO obras.maestro_actividades VALUES (429, 'BT R 76 B B1  nt', 19, 0.7, 0.5, 1.2, 'BT R 76 B B1  nt');
INSERT INTO obras.maestro_actividades VALUES (430, 'BT R 76 B B2  n', 19, 0.4, 0.3, 0.7, 'BT R 76 B B2  n');
INSERT INTO obras.maestro_actividades VALUES (431, 'BT R 76 B B2  nr', 19, 0.7, 0.5, 1.2, 'BT R 76 B B2  nr');
INSERT INTO obras.maestro_actividades VALUES (432, 'BT R 76 B B2  nrs', 19, 1, 0.8, 1.8, 'BT R 76 B B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (649, 'PP 1C (=<25mm2)', 19, 0.1, 0.1, 0.2, 'PP 1C (=<25mm2)');
INSERT INTO obras.maestro_actividades VALUES (433, 'BT R 76 B B2  nrst', 19, 1.3, 1, 2.3, 'BT R 76 B B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (434, 'BT R 76 B B2  nrt', 19, 1, 0.8, 1.8, 'BT R 76 B B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (435, 'BT R 76 B B2  ns', 19, 0.7, 0.5, 1.2, 'BT R 76 B B2  ns');
INSERT INTO obras.maestro_actividades VALUES (436, 'BT R 76 B B2  nst', 19, 1, 0.8, 1.8, 'BT R 76 B B2  nst');
INSERT INTO obras.maestro_actividades VALUES (437, 'BT R 76 B B2  nt', 19, 0.7, 0.5, 1.2, 'BT R 76 B B2  nt');
INSERT INTO obras.maestro_actividades VALUES (438, 'BT R 76 B SB n', 19, 0.4, 0.3, 0.7, 'BT R 76 B SB n');
INSERT INTO obras.maestro_actividades VALUES (439, 'BT R 76 B SB nr', 19, 0.7, 0.5, 1.2, 'BT R 76 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (440, 'BT R 76 B SB nrs', 19, 1, 0.8, 1.8, 'BT R 76 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (441, 'BT R 76 B SB nrst', 19, 1.3, 1, 2.3, 'BT R 76 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (442, 'BT R 76 B SB nrt', 19, 1, 0.8, 1.8, 'BT R 76 B SB nrt');
INSERT INTO obras.maestro_actividades VALUES (443, 'BT R 76 B SB ns', 19, 0.7, 0.5, 1.2, 'BT R 76 B SB ns');
INSERT INTO obras.maestro_actividades VALUES (444, 'BT R 76 B SB nst', 19, 1, 0.8, 1.8, 'BT R 76 B SB nst');
INSERT INTO obras.maestro_actividades VALUES (445, 'BT R 76 B SB nt', 19, 0.7, 0.5, 1.2, 'BT R 76 B SB nt');
INSERT INTO obras.maestro_actividades VALUES (446, 'BT R 76 M B1  n', 19, 0.4, 0.3, 0.7, 'BT R 76 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (447, 'BT R 76 M B1  nr', 19, 0.7, 0.5, 1.2, 'BT R 76 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (448, 'BT R 76 M B1  nrs', 19, 1, 0.8, 1.8, 'BT R 76 M B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (449, 'BT R 76 M B1  nrst', 19, 1.3, 1, 2.3, 'BT R 76 M B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (450, 'BT R 76 M B1  nrt', 19, 1, 0.8, 1.8, 'BT R 76 M B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (451, 'BT R 76 M B1  ns', 19, 0.7, 0.5, 1.2, 'BT R 76 M B1  ns');
INSERT INTO obras.maestro_actividades VALUES (452, 'BT R 76 M B1  nst', 19, 1, 0.8, 1.8, 'BT R 76 M B1  nst');
INSERT INTO obras.maestro_actividades VALUES (453, 'BT R 76 M B1  nt', 19, 0.7, 0.5, 1.2, 'BT R 76 M B1  nt');
INSERT INTO obras.maestro_actividades VALUES (454, 'BT R 76 M B2  n', 19, 0.4, 0.3, 0.7, 'BT R 76 M B2  n');
INSERT INTO obras.maestro_actividades VALUES (455, 'BT R 76 M B2  nr', 19, 0.7, 0.5, 1.2, 'BT R 76 M B2  nr');
INSERT INTO obras.maestro_actividades VALUES (456, 'BT R 76 M B2  nrs', 19, 1, 0.8, 1.8, 'BT R 76 M B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (457, 'BT R 76 M B2  nrst', 19, 1.3, 1, 2.3, 'BT R 76 M B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (458, 'BT R 76 M B2  nrt', 19, 1, 0.8, 1.8, 'BT R 76 M B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (459, 'BT R 76 M B2  ns', 19, 0.7, 0.5, 1.2, 'BT R 76 M B2  ns');
INSERT INTO obras.maestro_actividades VALUES (460, 'BT R 76 M B2  nst', 19, 1, 0.8, 1.8, 'BT R 76 M B2  nst');
INSERT INTO obras.maestro_actividades VALUES (461, 'BT R 76 M B2  nt', 19, 0.7, 0.5, 1.2, 'BT R 76 M B2  nt');
INSERT INTO obras.maestro_actividades VALUES (462, 'BT R 76 M SB n', 19, 0.4, 0.3, 0.7, 'BT R 76 M SB n');
INSERT INTO obras.maestro_actividades VALUES (463, 'BT R 76 M SB nr', 19, 0.7, 0.5, 1.2, 'BT R 76 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (464, 'BT R 76 M SB nrs', 19, 1, 0.8, 1.8, 'BT R 76 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (465, 'BT R 76 M SB nrst', 19, 1.3, 1, 2.3, 'BT R 76 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (698, 'MONT REC 1PC', 20, 2, 1.4, 3.4, 'MONT REC 1PC');
INSERT INTO obras.maestro_actividades VALUES (466, 'BT R 76 M SB nrt', 19, 1, 0.8, 1.8, 'BT R 76 M SB nrt');
INSERT INTO obras.maestro_actividades VALUES (467, 'BT R 76 M SB ns', 19, 0.7, 0.5, 1.2, 'BT R 76 M SB ns');
INSERT INTO obras.maestro_actividades VALUES (468, 'BT R 76 M SB nst', 19, 1, 0.8, 1.8, 'BT R 76 M SB nst');
INSERT INTO obras.maestro_actividades VALUES (469, 'BT R 76 M SB nt', 19, 0.7, 0.5, 1.2, 'BT R 76 M SB nt');
INSERT INTO obras.maestro_actividades VALUES (470, 'BT R2 57 B SB nr', 19, 1.6, 1.2, 2.8, 'BT R2 57 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (471, 'BT R2 57 B SB nrs', 19, 2.3, 1.9, 4.2, 'BT R2 57 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (472, 'BT R2 57 B SB nrst', 19, 2.6, 2, 4.6, 'BT R2 57 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (473, 'BT R2 57 M B1  n', 19, 0.8, 0.6, 1.4, 'BT R2 57 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (474, 'BT R2 57 M B1  nr', 19, 1.6, 1.2, 2.8, 'BT R2 57 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (475, 'BT R2 57 M B1  nrst', 19, 2.6, 2, 4.6, 'BT R2 57 M B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (476, 'BT R2 57 M SB nr', 19, 1.6, 1.2, 2.8, 'BT R2 57 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (477, 'BT R2 57 M SB nrs', 19, 2.3, 1.9, 4.2, 'BT R2 57 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (478, 'BT R2 57 M SB nrst', 19, 2.6, 2, 4.6, 'BT R2 57 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (479, 'BT R2 76 B B1  n', 19, 0.8, 0.6, 1.4, 'BT R2 76 B B1  n');
INSERT INTO obras.maestro_actividades VALUES (480, 'BT R2 76 B B1  nr', 19, 1.4, 1, 2.4, 'BT R2 76 B B1  nr');
INSERT INTO obras.maestro_actividades VALUES (481, 'BT R2 76 B B1  nrs', 19, 2, 1.6, 3.6, 'BT R2 76 B B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (482, 'BT R2 76 B B1  nrst', 19, 2.6, 2, 4.6, 'BT R2 76 B B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (483, 'BT R2 76 B B1  nrt', 19, 2, 1.6, 3.6, 'BT R2 76 B B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (484, 'BT R2 76 B B1  ns', 19, 1.4, 1, 2.4, 'BT R2 76 B B1  ns');
INSERT INTO obras.maestro_actividades VALUES (485, 'BT R2 76 B B1  nst', 19, 2, 1.6, 3.6, 'BT R2 76 B B1  nst');
INSERT INTO obras.maestro_actividades VALUES (486, 'BT R2 76 B B1  nt', 19, 1.4, 1, 2.4, 'BT R2 76 B B1  nt');
INSERT INTO obras.maestro_actividades VALUES (487, 'BT R2 76 B B2  n', 19, 0.8, 0.6, 1.4, 'BT R2 76 B B2  n');
INSERT INTO obras.maestro_actividades VALUES (488, 'BT R2 76 B B2  nr', 19, 1.4, 1, 2.4, 'BT R2 76 B B2  nr');
INSERT INTO obras.maestro_actividades VALUES (489, 'BT R2 76 B B2  nrs', 19, 2, 1.6, 3.6, 'BT R2 76 B B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (490, 'BT R2 76 B B2  nrst', 19, 2.6, 2, 4.6, 'BT R2 76 B B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (491, 'BT R2 76 B B2  nrt', 19, 2, 1.6, 3.6, 'BT R2 76 B B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (492, 'BT R2 76 B B2  ns', 19, 1.4, 1, 2.4, 'BT R2 76 B B2  ns');
INSERT INTO obras.maestro_actividades VALUES (493, 'BT R2 76 B B2  nst', 19, 2, 1.6, 3.6, 'BT R2 76 B B2  nst');
INSERT INTO obras.maestro_actividades VALUES (494, 'BT R2 76 B B2  nt', 19, 1.4, 1, 2.4, 'BT R2 76 B B2  nt');
INSERT INTO obras.maestro_actividades VALUES (495, 'BT R2 76 B SB n', 19, 0.8, 0.6, 1.4, 'BT R2 76 B SB n');
INSERT INTO obras.maestro_actividades VALUES (496, 'BT R2 76 B SB nr', 19, 1.4, 1, 2.4, 'BT R2 76 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (497, 'BT R2 76 B SB nrs', 19, 2, 1.6, 3.6, 'BT R2 76 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (498, 'BT R2 76 B SB nrst', 19, 2.6, 2, 4.6, 'BT R2 76 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (499, 'BT R2 76 B SB nrt', 19, 2, 1.6, 3.6, 'BT R2 76 B SB nrt');
INSERT INTO obras.maestro_actividades VALUES (500, 'BT R2 76 B SB ns', 19, 1.4, 1, 2.4, 'BT R2 76 B SB ns');
INSERT INTO obras.maestro_actividades VALUES (501, 'BT R2 76 B SB nst', 19, 2, 1.6, 3.6, 'BT R2 76 B SB nst');
INSERT INTO obras.maestro_actividades VALUES (502, 'BT R2 76 B SB nt', 19, 1.4, 1, 2.4, 'BT R2 76 B SB nt');
INSERT INTO obras.maestro_actividades VALUES (503, 'BT R2 76 M B1  n', 19, 0.8, 0.6, 1.4, 'BT R2 76 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (802, 'MTAL 15V 2L JA', 20, 5.3, 3.7, 9, 'MTAL 15V 2L JA');
INSERT INTO obras.maestro_actividades VALUES (504, 'BT R2 76 M B1  nr', 19, 1.4, 1, 2.4, 'BT R2 76 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (505, 'BT R2 76 M B1  nrs', 19, 2, 1.6, 3.6, 'BT R2 76 M B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (506, 'BT R2 76 M B1  nrt', 19, 2, 1.6, 3.6, 'BT R2 76 M B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (507, 'BT R2 76 M B1  ns', 19, 1.4, 1, 2.4, 'BT R2 76 M B1  ns');
INSERT INTO obras.maestro_actividades VALUES (508, 'BT R2 76 M B1  nst', 19, 2, 1.6, 3.6, 'BT R2 76 M B1  nst');
INSERT INTO obras.maestro_actividades VALUES (509, 'BT R2 76 M B1  nt', 19, 1.4, 1, 2.4, 'BT R2 76 M B1  nt');
INSERT INTO obras.maestro_actividades VALUES (510, 'BT R2 76 M B1 nrst', 19, 2.6, 2, 4.6, 'BT R2 76 M B1 nrst');
INSERT INTO obras.maestro_actividades VALUES (511, 'BT R2 76 M B2  n', 19, 0.8, 0.6, 1.4, 'BT R2 76 M B2  n');
INSERT INTO obras.maestro_actividades VALUES (512, 'BT R2 76 M B2  nr', 19, 1.4, 1, 2.4, 'BT R2 76 M B2  nr');
INSERT INTO obras.maestro_actividades VALUES (513, 'BT R2 76 M B2  nrs', 19, 2, 1.6, 3.6, 'BT R2 76 M B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (514, 'BT R2 76 M B2  nrst', 19, 2.6, 2, 4.6, 'BT R2 76 M B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (515, 'BT R2 76 M B2  nrt', 19, 2, 1.6, 3.6, 'BT R2 76 M B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (516, 'BT R2 76 M B2  ns', 19, 1.4, 1, 2.4, 'BT R2 76 M B2  ns');
INSERT INTO obras.maestro_actividades VALUES (517, 'BT R2 76 M B2  nst', 19, 2, 1.6, 3.6, 'BT R2 76 M B2  nst');
INSERT INTO obras.maestro_actividades VALUES (518, 'BT R2 76 M B2  nt', 19, 1.4, 1, 2.4, 'BT R2 76 M B2  nt');
INSERT INTO obras.maestro_actividades VALUES (519, 'BT R2 76 M SB n', 19, 0.8, 0.6, 1.4, 'BT R2 76 M SB n');
INSERT INTO obras.maestro_actividades VALUES (520, 'BT R2 76 M SB nr', 19, 1.4, 1, 2.4, 'BT R2 76 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (521, 'BT R2 76 M SB nrs', 19, 2, 1.6, 3.6, 'BT R2 76 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (522, 'BT R2 76 M SB nrst', 19, 2.6, 2, 4.6, 'BT R2 76 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (523, 'BT R2 76 M SB nrt', 19, 2, 1.6, 3.6, 'BT R2 76 M SB nrt');
INSERT INTO obras.maestro_actividades VALUES (524, 'BT R2 76 M SB ns', 19, 1.4, 1, 2.4, 'BT R2 76 M SB ns');
INSERT INTO obras.maestro_actividades VALUES (525, 'BT R2 76 M SB nst', 19, 2, 1.6, 3.6, 'BT R2 76 M SB nst');
INSERT INTO obras.maestro_actividades VALUES (526, 'BT R2 76 M SB nt', 19, 1.4, 1, 2.4, 'BT R2 76 M SB nt');
INSERT INTO obras.maestro_actividades VALUES (527, 'BT RL 57 B SB nr', 19, 0.7, 0.5, 1.2, 'BT RL 57 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (528, 'BT RL 57 B SB nrs', 19, 1, 0.8, 1.8, 'BT RL 57 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (529, 'BT RL 57 B SB nrst', 19, 1.3, 1, 2.3, 'BT RL 57 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (530, 'BT RL 57 M B1  n', 19, 0.4, 0.3, 0.7, 'BT RL 57 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (531, 'BT RL 57 M SB nr', 19, 0.7, 0.5, 1.2, 'BT RL 57 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (532, 'BT RL 57 M SB nrs', 19, 1, 0.8, 1.8, 'BT RL 57 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (533, 'BT RL 57 M SB nrst', 19, 1.3, 1, 2.3, 'BT RL 57 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (534, 'BT RL 76 B B1  n', 19, 0.4, 0.3, 0.7, 'BT RL 76 B B1  n');
INSERT INTO obras.maestro_actividades VALUES (535, 'BT RL 76 B B1  nr', 19, 0.7, 0.5, 1.2, 'BT RL 76 B B1  nr');
INSERT INTO obras.maestro_actividades VALUES (536, 'BT RL 76 B B1  nrs', 19, 1, 0.8, 1.8, 'BT RL 76 B B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (537, 'BT RL 76 B B1  nrst', 19, 1.3, 1, 2.3, 'BT RL 76 B B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (538, 'BT RL 76 B B1  nrt', 19, 1, 0.8, 1.8, 'BT RL 76 B B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (539, 'BT RL 76 B B1  ns', 19, 0.7, 0.5, 1.2, 'BT RL 76 B B1  ns');
INSERT INTO obras.maestro_actividades VALUES (540, 'BT RL 76 B B1  nst', 19, 1, 0.8, 1.8, 'BT RL 76 B B1  nst');
INSERT INTO obras.maestro_actividades VALUES (541, 'BT RL 76 B B1  nt', 19, 0.7, 0.5, 1.2, 'BT RL 76 B B1  nt');
INSERT INTO obras.maestro_actividades VALUES (542, 'BT RL 76 B B2  n', 19, 0.4, 0.3, 0.7, 'BT RL 76 B B2  n');
INSERT INTO obras.maestro_actividades VALUES (543, 'BT RL 76 B B2  nr', 19, 0.7, 0.5, 1.2, 'BT RL 76 B B2  nr');
INSERT INTO obras.maestro_actividades VALUES (544, 'BT RL 76 B B2  nrs', 19, 1, 0.8, 1.8, 'BT RL 76 B B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (545, 'BT RL 76 B B2  nrst', 19, 1.3, 1, 2.3, 'BT RL 76 B B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (546, 'BT RL 76 B B2  nrt', 19, 1, 0.8, 1.8, 'BT RL 76 B B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (547, 'BT RL 76 B B2  ns', 19, 0.7, 0.5, 1.2, 'BT RL 76 B B2  ns');
INSERT INTO obras.maestro_actividades VALUES (548, 'BT RL 76 B B2  nst', 19, 1, 0.8, 1.8, 'BT RL 76 B B2  nst');
INSERT INTO obras.maestro_actividades VALUES (549, 'BT RL 76 B B2  nt', 19, 0.7, 0.5, 1.2, 'BT RL 76 B B2  nt');
INSERT INTO obras.maestro_actividades VALUES (550, 'BT RL 76 B SB n', 19, 0.4, 0.3, 0.7, 'BT RL 76 B SB n');
INSERT INTO obras.maestro_actividades VALUES (551, 'BT RL 76 B SB nr', 19, 0.7, 0.5, 1.2, 'BT RL 76 B SB nr');
INSERT INTO obras.maestro_actividades VALUES (552, 'BT RL 76 B SB nrs', 19, 1, 0.8, 1.8, 'BT RL 76 B SB nrs');
INSERT INTO obras.maestro_actividades VALUES (553, 'BT RL 76 B SB nrst', 19, 1.3, 1, 2.3, 'BT RL 76 B SB nrst');
INSERT INTO obras.maestro_actividades VALUES (554, 'BT RL 76 B SB nrt', 19, 1, 0.8, 1.8, 'BT RL 76 B SB nrt');
INSERT INTO obras.maestro_actividades VALUES (555, 'BT RL 76 B SB ns', 19, 0.7, 0.5, 1.2, 'BT RL 76 B SB ns');
INSERT INTO obras.maestro_actividades VALUES (556, 'BT RL 76 B SB nst', 19, 1, 0.8, 1.8, 'BT RL 76 B SB nst');
INSERT INTO obras.maestro_actividades VALUES (557, 'BT RL 76 B SB nt', 19, 0.7, 0.5, 1.2, 'BT RL 76 B SB nt');
INSERT INTO obras.maestro_actividades VALUES (558, 'BT RL 76 M B1  n', 19, 0.4, 0.3, 0.7, 'BT RL 76 M B1  n');
INSERT INTO obras.maestro_actividades VALUES (559, 'BT RL 76 M B1  nr', 19, 0.7, 0.5, 1.2, 'BT RL 76 M B1  nr');
INSERT INTO obras.maestro_actividades VALUES (560, 'BT RL 76 M B1  nrs', 19, 1, 0.8, 1.8, 'BT RL 76 M B1  nrs');
INSERT INTO obras.maestro_actividades VALUES (561, 'BT RL 76 M B1  nrst', 19, 1.3, 1, 2.3, 'BT RL 76 M B1  nrst');
INSERT INTO obras.maestro_actividades VALUES (562, 'BT RL 76 M B1  nrt', 19, 1, 0.8, 1.8, 'BT RL 76 M B1  nrt');
INSERT INTO obras.maestro_actividades VALUES (563, 'BT RL 76 M B1  ns', 19, 0.7, 0.5, 1.2, 'BT RL 76 M B1  ns');
INSERT INTO obras.maestro_actividades VALUES (564, 'BT RL 76 M B1  nst', 19, 1, 0.8, 1.8, 'BT RL 76 M B1  nst');
INSERT INTO obras.maestro_actividades VALUES (565, 'BT RL 76 M B1  nt', 19, 0.7, 0.5, 1.2, 'BT RL 76 M B1  nt');
INSERT INTO obras.maestro_actividades VALUES (566, 'BT RL 76 M B2  n', 19, 0.4, 0.3, 0.7, 'BT RL 76 M B2  n');
INSERT INTO obras.maestro_actividades VALUES (567, 'BT RL 76 M B2  nr', 19, 0.7, 0.5, 1.2, 'BT RL 76 M B2  nr');
INSERT INTO obras.maestro_actividades VALUES (568, 'BT RL 76 M B2  nrs', 19, 1, 0.8, 1.8, 'BT RL 76 M B2  nrs');
INSERT INTO obras.maestro_actividades VALUES (569, 'BT RL 76 M B2  nrst', 19, 1.3, 1, 2.3, 'BT RL 76 M B2  nrst');
INSERT INTO obras.maestro_actividades VALUES (570, 'BT RL 76 M B2  nrt', 19, 1, 0.8, 1.8, 'BT RL 76 M B2  nrt');
INSERT INTO obras.maestro_actividades VALUES (571, 'BT RL 76 M B2  ns', 19, 0.7, 0.5, 1.2, 'BT RL 76 M B2  ns');
INSERT INTO obras.maestro_actividades VALUES (572, 'BT RL 76 M B2  nst', 19, 1, 0.8, 1.8, 'BT RL 76 M B2  nst');
INSERT INTO obras.maestro_actividades VALUES (573, 'BT RL 76 M B2  nt', 19, 0.7, 0.5, 1.2, 'BT RL 76 M B2  nt');
INSERT INTO obras.maestro_actividades VALUES (575, 'BT RL 76 M SB nr', 19, 0.7, 0.5, 1.2, 'BT RL 76 M SB nr');
INSERT INTO obras.maestro_actividades VALUES (576, 'BT RL 76 M SB nrs', 19, 1, 0.8, 1.8, 'BT RL 76 M SB nrs');
INSERT INTO obras.maestro_actividades VALUES (577, 'BT RL 76 M SB nrst', 19, 1.3, 1, 2.3, 'BT RL 76 M SB nrst');
INSERT INTO obras.maestro_actividades VALUES (578, 'BT RL 76 M SB nrt', 19, 1, 0.8, 1.8, 'BT RL 76 M SB nrt');
INSERT INTO obras.maestro_actividades VALUES (579, 'BT RL 76 M SB ns', 19, 0.7, 0.5, 1.2, 'BT RL 76 M SB ns');
INSERT INTO obras.maestro_actividades VALUES (580, 'BT RL 76 M SB nst', 19, 1, 0.8, 1.8, 'BT RL 76 M SB nst');
INSERT INTO obras.maestro_actividades VALUES (581, 'BT RL 76 M SB nt', 19, 0.7, 0.5, 1.2, 'BT RL 76 M SB nt');
INSERT INTO obras.maestro_actividades VALUES (582, 'BTPre CE B 1ø', 19, 3.5, 2.5, 6, 'BTPre CE B 1ø');
INSERT INTO obras.maestro_actividades VALUES (583, 'BTPre CE B 2ø', 19, 4.1, 2.9, 7, 'BTPre CE B 2ø');
INSERT INTO obras.maestro_actividades VALUES (584, 'BTPre CE B 3ø', 19, 4.7, 3.3, 8, 'BTPre CE B 3ø');
INSERT INTO obras.maestro_actividades VALUES (585, 'BTPre CE M 1ø', 19, 3.5, 2.5, 6, 'BTPre CE M 1ø');
INSERT INTO obras.maestro_actividades VALUES (586, 'BTPre CE M 2ø', 19, 4.1, 2.9, 7, 'BTPre CE M 2ø');
INSERT INTO obras.maestro_actividades VALUES (587, 'BTPre CE M 3ø', 19, 4.7, 3.3, 8, 'BTPre CE M 3ø');
INSERT INTO obras.maestro_actividades VALUES (588, 'BTPre LZ 57 B 1F', 19, 0.8, 0.6, 1.4, 'BTPre LZ 57 B 1F');
INSERT INTO obras.maestro_actividades VALUES (589, 'BTPre LZ 57 M 1F', 19, 0.8, 0.6, 1.4, 'BTPre LZ 57 M 1F');
INSERT INTO obras.maestro_actividades VALUES (590, 'BTPre LZ 76 B 1F', 19, 0.8, 0.6, 1.4, 'BTPre LZ 76 B 1F');
INSERT INTO obras.maestro_actividades VALUES (591, 'BTPre LZ 76 M 1F', 19, 0.8, 0.6, 1.4, 'BTPre LZ 76 M 1F');
INSERT INTO obras.maestro_actividades VALUES (592, 'BTPre LZ B', 19, 1.7, 1.1, 2.8, 'BTPre LZ B');
INSERT INTO obras.maestro_actividades VALUES (593, 'BTPre LZ M', 19, 1.7, 1.1, 2.8, 'BTPre LZ M');
INSERT INTO obras.maestro_actividades VALUES (594, 'BTPre P 57 B 1F', 19, 0.4, 0.3, 0.7, 'BTPre P 57 B 1F');
INSERT INTO obras.maestro_actividades VALUES (595, 'BTPre P 57 M 1F', 19, 0.4, 0.3, 0.7, 'BTPre P 57 M 1F');
INSERT INTO obras.maestro_actividades VALUES (596, 'BTPre P 76 B 1F', 19, 0.4, 0.3, 0.7, 'BTPre P 76 B 1F');
INSERT INTO obras.maestro_actividades VALUES (597, 'BTPre P 76 M 1F', 19, 0.4, 0.3, 0.7, 'BTPre P 76 M 1F');
INSERT INTO obras.maestro_actividades VALUES (598, 'BTPre P B', 19, 0.5, 0.3, 0.8, 'BTPre P B');
INSERT INTO obras.maestro_actividades VALUES (599, 'BTPre P M', 19, 0.5, 0.3, 0.8, 'BTPre P M');
INSERT INTO obras.maestro_actividades VALUES (600, 'BTPre R 57 B 1F', 19, 0.4, 0.3, 0.7, 'BTPre R 57 B 1F');
INSERT INTO obras.maestro_actividades VALUES (601, 'BTPre R 57 M 1F', 19, 0.4, 0.3, 0.7, 'BTPre R 57 M 1F');
INSERT INTO obras.maestro_actividades VALUES (602, 'BTPre R 76 B 1F', 19, 0.4, 0.3, 0.7, 'BTPre R 76 B 1F');
INSERT INTO obras.maestro_actividades VALUES (603, 'BTPre R 76 M 1F', 19, 0.4, 0.3, 0.7, 'BTPre R 76 M 1F');
INSERT INTO obras.maestro_actividades VALUES (604, 'BTPre R B', 19, 1.4, 0.7, 2.1, 'BTPre R B');
INSERT INTO obras.maestro_actividades VALUES (605, 'BTPre R M', 19, 1.4, 0.7, 2.1, 'BTPre R M');
INSERT INTO obras.maestro_actividades VALUES (606, 'BTPre R2 57 B 1F', 19, 0.8, 0.6, 1.4, 'BTPre R2 57 B 1F');
INSERT INTO obras.maestro_actividades VALUES (607, 'BTPre R2 57 M 1F', 19, 0.8, 0.6, 1.4, 'BTPre R2 57 M 1F');
INSERT INTO obras.maestro_actividades VALUES (608, 'BTPre R2 76 B 1F', 19, 0.8, 0.6, 1.4, 'BTPre R2 76 B 1F');
INSERT INTO obras.maestro_actividades VALUES (609, 'BTPre R2 76 M 1F', 19, 0.8, 0.6, 1.4, 'BTPre R2 76 M 1F');
INSERT INTO obras.maestro_actividades VALUES (610, 'BTPre RD B', 19, 1.7, 1.1, 2.8, 'BTPre RD B');
INSERT INTO obras.maestro_actividades VALUES (611, 'BTPre RD M', 19, 1.7, 1.1, 2.8, 'BTPre RD M');
INSERT INTO obras.maestro_actividades VALUES (612, 'BTPre RL 57 B 1F', 19, 0.4, 0.3, 0.7, 'BTPre RL 57 B 1F');
INSERT INTO obras.maestro_actividades VALUES (613, 'BTPre RL 57 M 1F', 19, 0.4, 0.3, 0.7, 'BTPre RL 57 M 1F');
INSERT INTO obras.maestro_actividades VALUES (614, 'BTPre RL 76 B 1F', 19, 0.4, 0.3, 0.7, 'BTPre RL 76 B 1F');
INSERT INTO obras.maestro_actividades VALUES (615, 'BTPre RL 76 M 1F', 19, 0.4, 0.3, 0.7, 'BTPre RL 76 M 1F');
INSERT INTO obras.maestro_actividades VALUES (616, 'BTPre RL B', 19, 1.4, 0.7, 2.1, 'BTPre RL B');
INSERT INTO obras.maestro_actividades VALUES (617, 'BTPre RL M', 19, 1.4, 0.7, 2.1, 'BTPre RL M');
INSERT INTO obras.maestro_actividades VALUES (618, 'EM 1ø BT', 19, 8.1, 5.7, 13.8, 'EM 1ø BT');
INSERT INTO obras.maestro_actividades VALUES (619, 'EM 3ø BT Dir. 15kVA', 19, 12.2, 8.6, 20.8, 'EM 3ø BT Dir. 15kVA');
INSERT INTO obras.maestro_actividades VALUES (620, 'EM 3ø BT Dir. 30kVA', 19, 12.2, 8.6, 20.8, 'EM 3ø BT Dir. 30kVA');
INSERT INTO obras.maestro_actividades VALUES (621, 'EM 3ø BT Dir. 45kVA', 19, 12.2, 8.6, 20.8, 'EM 3ø BT Dir. 45kVA');
INSERT INTO obras.maestro_actividades VALUES (622, 'EM 3ø BT Dir. 75kVA', 19, 12.2, 8.6, 20.8, 'EM 3ø BT Dir. 75kVA');
INSERT INTO obras.maestro_actividades VALUES (623, 'EM 3ø BT Indir. c/TC', 19, 29.1, 20.5, 49.6, 'EM 3ø BT Indir. c/TC');
INSERT INTO obras.maestro_actividades VALUES (624, 'EM 3ø AT c/TMC', 19, 12.2, 8.6, 17.7, 'EM 3ø AT c/TMC');
INSERT INTO obras.maestro_actividades VALUES (625, 'Poste AP Subterraneo', 19, 12.52, 8.9, 16.3, 'Poste AP Subterraneo');
INSERT INTO obras.maestro_actividades VALUES (626, 'Conect Empalme 1C', 19, 0.1, 0.07, 0.13, 'Conect Empalme 1C');
INSERT INTO obras.maestro_actividades VALUES (627, 'Conect Empalme 2C', 19, 0.2, 0.14, 0.26, 'Conect Empalme 2C');
INSERT INTO obras.maestro_actividades VALUES (628, 'Conect Empalme 3C', 19, 0.3, 0.21, 0.39, 'Conect Empalme 3C');
INSERT INTO obras.maestro_actividades VALUES (629, 'Conect Empalme 4C', 19, 0.4, 0.28, 0.52, 'Conect Empalme 4C');
INSERT INTO obras.maestro_actividades VALUES (630, 'BR 1.5" PC9 100-250', 19, 4.9, 3.36, 6.37, 'BR 1.5" PC9 100-250');
INSERT INTO obras.maestro_actividades VALUES (631, 'BR 2" PC9 250-400', 19, 4.9, 3.36, 6.37, 'BR 2" PC9 250-400');
INSERT INTO obras.maestro_actividades VALUES (632, 'BR 1.5" PC11 100-250', 19, 4.9, 3.36, 6.37, 'BR 1.5" PC11 100-250');
INSERT INTO obras.maestro_actividades VALUES (633, 'BR 2" PC11 250-400', 19, 4.9, 3.36, 6.37, 'BR 2" PC11 250-400');
INSERT INTO obras.maestro_actividades VALUES (634, 'E. Control AP 1ø 1s', 19, 18.1, 12.7, 23.5, 'E. Control AP 1ø 1s');
INSERT INTO obras.maestro_actividades VALUES (635, 'Ferr Lum c/Br 4773', 19, 3.3, 2.29, 4.31, 'Ferr Lum c/Br 4773');
INSERT INTO obras.maestro_actividades VALUES (636, 'E. Control AP 3ø', 19, 21.6, 15.1, 28.1, 'E. Control AP 3ø');
INSERT INTO obras.maestro_actividades VALUES (637, 'E. Control AP 1ø 2s', 19, 18.1, 12.7, 23.5, 'E. Control AP 1ø 2s');
INSERT INTO obras.maestro_actividades VALUES (638, 'Conect Ampactinho', 19, 0.2, 0.14, 0.26, 'Conect Ampactinho');
INSERT INTO obras.maestro_actividades VALUES (639, 'Luminaria Sodio 70w', 19, 0.1, 0.07, 0.17, 'Luminaria Sodio 70w');
INSERT INTO obras.maestro_actividades VALUES (640, 'Luminaria Sodio 100w', 19, 0.1, 0.07, 0.17, 'Luminaria Sodio 100w');
INSERT INTO obras.maestro_actividades VALUES (641, 'Luminaria Sodio 150w', 19, 0.1, 0.07, 0.17, 'Luminaria Sodio 150w');
INSERT INTO obras.maestro_actividades VALUES (642, 'Ampolleta Sodio 70w', 19, 0.1, 0.07, 0.17, 'Ampolleta Sodio 70w');
INSERT INTO obras.maestro_actividades VALUES (643, 'Ampolleta Sodio 100w', 19, 0.1, 0.07, 0.17, 'Ampolleta Sodio 100w');
INSERT INTO obras.maestro_actividades VALUES (644, 'Ampolleta Sodio 150w', 19, 0.1, 0.07, 0.17, 'Ampolleta Sodio 150w');
INSERT INTO obras.maestro_actividades VALUES (645, 'Mufa derivacion 2F', 19, 3, 1.5, 4, 'Mufa derivacion 2F');
INSERT INTO obras.maestro_actividades VALUES (646, 'Mufa derivacion 3F', 19, 4, 2, 5.2, 'Mufa derivacion 3F');
INSERT INTO obras.maestro_actividades VALUES (647, 'Mufa Empalme', 19, 1, 1.5, 2.5, 'Mufa Empalme');
INSERT INTO obras.maestro_actividades VALUES (648, 'Mufa Empalme BT', 19, 2, 1.5, 3.5, 'Mufa Empalme BT');
INSERT INTO obras.maestro_actividades VALUES (650, 'PP 1C (>=33 mm2)', 19, 0.1, 0.1, 0.2, 'PP 1C (>=33 mm2)');
INSERT INTO obras.maestro_actividades VALUES (651, 'PP 2C (=<25 mm2)', 19, 0.2, 0.2, 0.4, 'PP 2C (=<25 mm2)');
INSERT INTO obras.maestro_actividades VALUES (652, 'PP 2C (>=33 mm2)', 19, 0.2, 0.2, 0.4, 'PP 2C (>=33 mm2)');
INSERT INTO obras.maestro_actividades VALUES (653, 'PP 3C (=<25mm 2)', 19, 0.3, 0.3, 0.6, 'PP 3C (=<25mm 2)');
INSERT INTO obras.maestro_actividades VALUES (654, 'PP 3C (>=33 mm2)', 19, 0.3, 0.3, 0.6, 'PP 3C (>=33 mm2)');
INSERT INTO obras.maestro_actividades VALUES (655, 'PP 4c (>=33 mm2)', 19, 0.4, 0.4, 0.8, 'PP 4c (>=33 mm2)');
INSERT INTO obras.maestro_actividades VALUES (656, 'PP 4C(=<25 mm2)', 19, 0.4, 0.4, 0.8, 'PP 4C(=<25 mm2)');
INSERT INTO obras.maestro_actividades VALUES (657, 'PP Pre 1F', 19, 0.1, 0.1, 0.2, 'PP Pre 1F');
INSERT INTO obras.maestro_actividades VALUES (658, 'PP Pre 2C', 19, 0.2, 0.2, 0.4, 'PP Pre 2C');
INSERT INTO obras.maestro_actividades VALUES (659, 'PP Pre 4C', 19, 0.4, 0.4, 0.6, 'PP Pre 4C');
INSERT INTO obras.maestro_actividades VALUES (660, 'Conector Pre TT 4C', 19, 0.4, 0.4, 0.8, 'Conector Pre TT 4C');
INSERT INTO obras.maestro_actividades VALUES (661, 'PP Pre monof. Neutro', 19, 0.1, 0.1, 0.2, 'PP Pre monof. Neutro');
INSERT INTO obras.maestro_actividades VALUES (662, 'PP Pre solo neutro', 19, 0.1, 0.1, 0.2, 'PP Pre solo neutro');
INSERT INTO obras.maestro_actividades VALUES (663, 'PP Pre/Des 1C', 19, 0.1, 0.1, 0.2, 'PP Pre/Des 1C');
INSERT INTO obras.maestro_actividades VALUES (664, 'PP Pre/Des 2C', 19, 0.2, 0.2, 0.4, 'PP Pre/Des 2C');
INSERT INTO obras.maestro_actividades VALUES (665, 'PP Pre/Des 3C', 19, 0.3, 0.3, 0.6, 'PP Pre/Des 3C');
INSERT INTO obras.maestro_actividades VALUES (666, 'PP Pre/Des 4C', 19, 0.4, 0.4, 0.8, 'PP Pre/Des 4C');
INSERT INTO obras.maestro_actividades VALUES (667, 'Prensa 502 1c', 19, 0.1, 0.1, 0.2, 'Prensa 502 1c');
INSERT INTO obras.maestro_actividades VALUES (668, 'Prensa 502 2c', 19, 0.2, 0.2, 0.4, 'Prensa 502 2c');
INSERT INTO obras.maestro_actividades VALUES (669, 'Prensa 502 3c', 19, 0.3, 0.3, 0.6, 'Prensa 502 3c');
INSERT INTO obras.maestro_actividades VALUES (670, 'Prensa 502 4c', 19, 0.4, 0.4, 0.8, 'Prensa 502 4c');
INSERT INTO obras.maestro_actividades VALUES (671, 'Ampac 031-2 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 031-2 3ø');
INSERT INTO obras.maestro_actividades VALUES (672, 'Ampac 031-6 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 031-6 3ø');
INSERT INTO obras.maestro_actividades VALUES (673, 'Ampac 046-5 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 046-5 2ø');
INSERT INTO obras.maestro_actividades VALUES (674, 'Ampac 046-5 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 046-5 3ø');
INSERT INTO obras.maestro_actividades VALUES (675, 'Ampac 046-6 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 046-6 2ø');
INSERT INTO obras.maestro_actividades VALUES (676, 'Ampac 046-6 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 046-6 3ø');
INSERT INTO obras.maestro_actividades VALUES (677, 'Ampac 046-7 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 046-7 2ø');
INSERT INTO obras.maestro_actividades VALUES (678, 'Ampac 046-7 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 046-7 3ø');
INSERT INTO obras.maestro_actividades VALUES (679, 'Ampac 046-9 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 046-9 2ø');
INSERT INTO obras.maestro_actividades VALUES (680, 'Ampac 046-9 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 046-9 3ø');
INSERT INTO obras.maestro_actividades VALUES (681, 'Ampac 403A 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 403A 2ø');
INSERT INTO obras.maestro_actividades VALUES (682, 'Ampac 403A 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 403A 3ø');
INSERT INTO obras.maestro_actividades VALUES (683, 'Ampac 446A 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 446A 2ø');
INSERT INTO obras.maestro_actividades VALUES (684, 'Ampac 446A 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 446A 3ø');
INSERT INTO obras.maestro_actividades VALUES (685, 'Ampac 458A 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 458A 2ø');
INSERT INTO obras.maestro_actividades VALUES (686, 'Ampac 458A 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 458A 3ø');
INSERT INTO obras.maestro_actividades VALUES (687, 'Ampac 459A 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 459A 2ø');
INSERT INTO obras.maestro_actividades VALUES (688, 'Ampac 459A 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 459A 3ø');
INSERT INTO obras.maestro_actividades VALUES (689, 'Ampac 528R 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 528R 2ø');
INSERT INTO obras.maestro_actividades VALUES (690, 'Ampac 528R 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 528R 3ø');
INSERT INTO obras.maestro_actividades VALUES (691, 'Ampac 529A 2ø', 20, 0.3, 0.3, 0.6, 'Ampac 529A 2ø');
INSERT INTO obras.maestro_actividades VALUES (692, 'Ampac 529A 3ø', 20, 0.4, 0.4, 0.8, 'Ampac 529A 3ø');
INSERT INTO obras.maestro_actividades VALUES (693, '2do Plano S/Aisldores', 20, 2.3, 1.5, 3.8, '2do Plano S/Aisldores');
INSERT INTO obras.maestro_actividades VALUES (694, '2plano s/aisl cru FE', 20, 2, 1.5, 3, '2plano s/aisl cru FE');
INSERT INTO obras.maestro_actividades VALUES (695, 'Montaje DDCC 2P', 20, 0.7, 2.8, 5.5, 'Montaje DDCC 2P');
INSERT INTO obras.maestro_actividades VALUES (696, 'EM 3ø AT c/TMC', 20, 12.2, 8.6, 17.7, 'EM 3ø AT c/TMC');
INSERT INTO obras.maestro_actividades VALUES (697, 'MONT ECM 1PC', 20, 2, 1.2, 3.2, 'MONT ECM 1PC');
INSERT INTO obras.maestro_actividades VALUES (699, 'MT BS 2ø', 20, 36.4, 11.7, 40.9, 'MT BS 2ø');
INSERT INTO obras.maestro_actividades VALUES (700, 'MT BS 4" 3ø', 20, 53.4, 16.7, 59.6, 'MT BS 4" 3ø');
INSERT INTO obras.maestro_actividades VALUES (701, 'MT BS 6" 3ø', 20, 53.4, 16.7, 59.6, 'MT BS 6" 3ø');
INSERT INTO obras.maestro_actividades VALUES (702, 'Control REC', 20, 8, 4.8, 12.8, 'Control REC');
INSERT INTO obras.maestro_actividades VALUES (703, 'MONT TRAF 1PC', 20, 0.2, 0.1, 0.3, 'MONT TRAF 1PC');
INSERT INTO obras.maestro_actividades VALUES (704, 'MONT TRAF 2PC', 20, 16.2, 11.3, 27.5, 'MONT TRAF 2PC');
INSERT INTO obras.maestro_actividades VALUES (705, 'MT SE1PC 2F', 20, 0.4, 0.4, 0.8, 'MT SE1PC 2F');
INSERT INTO obras.maestro_actividades VALUES (706, 'MT SE1PC 2F S1P', 20, 0.4, 0.4, 0.8, 'MT SE1PC 2F S1P');
INSERT INTO obras.maestro_actividades VALUES (707, 'MT SE1PC 2F S2P', 20, 1.8, 1.2, 3, 'MT SE1PC 2F S2P');
INSERT INTO obras.maestro_actividades VALUES (708, 'MT SE1PC 2F S2P PV', 20, 1.8, 1.2, 3, 'MT SE1PC 2F S2P PV');
INSERT INTO obras.maestro_actividades VALUES (709, 'MT SE1PC 3F', 20, 0.6, 0.6, 1.2, 'MT SE1PC 3F');
INSERT INTO obras.maestro_actividades VALUES (710, 'MT SE1PC 3F S1P', 20, 0.6, 0.6, 1.2, 'MT SE1PC 3F S1P');
INSERT INTO obras.maestro_actividades VALUES (711, 'MT SE1PC 3F S2P', 20, 2, 1.4, 3.4, 'MT SE1PC 3F S2P');
INSERT INTO obras.maestro_actividades VALUES (712, 'MT SE1PC 3F S2P PROT', 20, 2, 1.4, 3.4, 'MT SE1PC 3F S2P PROT');
INSERT INTO obras.maestro_actividades VALUES (713, 'MT SE1PC 3F S2P PV', 20, 2, 1.4, 3.4, 'MT SE1PC 3F S2P PV');
INSERT INTO obras.maestro_actividades VALUES (714, 'MT SE2PC 15C', 20, 3, 2.2, 5.2, 'MT SE2PC 15C');
INSERT INTO obras.maestro_actividades VALUES (715, 'MT SE2PC 15C S', 20, 9, 6.3, 15.3, 'MT SE2PC 15C S');
INSERT INTO obras.maestro_actividades VALUES (716, 'MT SE2PC 15N', 20, 3, 2.2, 5.2, 'MT SE2PC 15N');
INSERT INTO obras.maestro_actividades VALUES (717, 'MT SE2PC 15N S', 20, 9, 6.3, 15.3, 'MT SE2PC 15N S');
INSERT INTO obras.maestro_actividades VALUES (718, 'MT SE2PC 23N', 20, 3, 2.2, 5.2, 'MT SE2PC 23N');
INSERT INTO obras.maestro_actividades VALUES (719, 'MT SE2PC 23N S', 20, 9, 6.3, 15.3, 'MT SE2PC 23N S');
INSERT INTO obras.maestro_actividades VALUES (720, 'MT SE2PC 23V', 20, 3, 2.2, 5.2, 'MT SE2PC 23V');
INSERT INTO obras.maestro_actividades VALUES (721, 'MT SE2PC 23V S ', 20, 9, 6.3, 15.3, 'MT SE2PC 23V S ');
INSERT INTO obras.maestro_actividades VALUES (722, 'MTAL 15N 2/3L A1TE', 20, 4.7, 3.4, 8.1, 'MTAL 15N 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (723, 'MTAL 15N 2/3L A1TES', 20, 4.5, 3.2, 7.7, 'MTAL 15N 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (724, 'MTAL 15N 2L A1TE', 20, 4.2, 3, 7.2, 'MTAL 15N 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (725, 'MTAL 15N 2L A1TES', 20, 4, 2.8, 6.8, 'MTAL 15N 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (726, 'MTAL 15N 2L A1TJ', 20, 4.8, 3.4, 8.2, 'MTAL 15N 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (727, 'MTAL 15N 2L A1TJS', 20, 4.6, 3.2, 7.8, 'MTAL 15N 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (728, 'MTAL 15N 2L A2PA', 20, 2.3, 1.5, 3.8, 'MTAL 15N 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (729, 'MTAL 15N 2L A2PAS', 20, 2.3, 1.5, 3.8, 'MTAL 15N 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (730, 'MTAL 15N 2L A2PE', 20, 2.3, 1.5, 3.8, 'MTAL 15N 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (731, 'MTAL 15N 2L A2PEJ', 20, 3.8, 2.6, 6.4, 'MTAL 15N 2L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (732, 'MTAL 15N 2L A2PEJS ', 20, 3.8, 2.6, 6.4, 'MTAL 15N 2L A2PEJS ');
INSERT INTO obras.maestro_actividades VALUES (733, 'MTAL 15N 2L A2PES', 20, 2.6, 1.8, 4.4, 'MTAL 15N 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (734, 'MTAL 15N 2L A2RA', 20, 5.6, 3.8, 9.4, 'MTAL 15N 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (735, 'MTAL 15N 2L A2RE', 20, 6.5, 4.7, 11.2, 'MTAL 15N 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (736, 'MTAL 15N 2L JA', 20, 5.3, 3.7, 9, 'MTAL 15N 2L JA');
INSERT INTO obras.maestro_actividades VALUES (737, 'MTAL 15N 2L JI', 20, 4.8, 3.4, 8.2, 'MTAL 15N 2L JI');
INSERT INTO obras.maestro_actividades VALUES (738, 'MTAL 15N 2L JP', 20, 6.3, 4.5, 10.8, 'MTAL 15N 2L JP');
INSERT INTO obras.maestro_actividades VALUES (739, 'MTAL 15N 2L PC', 20, 2.3, 1.5, 3.8, 'MTAL 15N 2L PC');
INSERT INTO obras.maestro_actividades VALUES (740, 'MTAL 15N 2L PCD', 20, 3.4, 2.4, 5.8, 'MTAL 15N 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (741, 'MTAL 15N 2L PD', 20, 3.4, 2.4, 5.8, 'MTAL 15N 2L PD');
INSERT INTO obras.maestro_actividades VALUES (742, 'MTAL 15N 2L PS', 20, 2.3, 1.5, 3.8, 'MTAL 15N 2L PS');
INSERT INTO obras.maestro_actividades VALUES (743, 'MTAL 15N 2L RS', 20, 3.3, 2.3, 5.6, 'MTAL 15N 2L RS');
INSERT INTO obras.maestro_actividades VALUES (744, 'MTAL 15N 2L RT', 20, 2.1, 1.3, 3.4, 'MTAL 15N 2L RT');
INSERT INTO obras.maestro_actividades VALUES (745, 'MTAL 15N 3/2L A1TE', 20, 4.5, 3.3, 7.8, 'MTAL 15N 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (746, 'MTAL 15N 3/2L A1TES', 20, 4.3, 3.1, 7.4, 'MTAL 15N 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (747, 'MTAL 15N 3/2L A1TJ', 20, 5.3, 3.8, 9.1, 'MTAL 15N 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (748, 'MTAL 15N 3/2L A1TJS', 20, 5.1, 3.6, 8.7, 'MTAL 15N 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (749, 'MTAL 15N 3/2L A2RA', 20, 6.1, 4.2, 10.3, 'MTAL 15N 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (750, 'MTAL 15N 3/2L A2RE', 20, 7.1, 5.2, 12.3, 'MTAL 15N 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (751, 'MTAL 15N 3L A1TE', 20, 5.1, 3.8, 8.9, 'MTAL 15N 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (752, 'MTAL 15N 3L A1TES', 20, 4.8, 3.5, 8.3, 'MTAL 15N 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (753, 'MTAL 15N 3L A1TJ', 20, 6.4, 4.6, 11, 'MTAL 15N 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (754, 'MTAL 15N 3L A1TJS ', 20, 6.1, 4.3, 10.4, 'MTAL 15N 3L A1TJS ');
INSERT INTO obras.maestro_actividades VALUES (755, 'MTAL 15N 3L A2PA', 20, 2.7, 1.9, 4.6, 'MTAL 15N 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (756, 'MTAL 15N 3L A2PAS', 20, 2.7, 1.9, 4.6, 'MTAL 15N 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (757, 'MTAL 15N 3L A2PE', 20, 2.7, 1.9, 4.6, 'MTAL 15N 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (758, 'MTAL 15N 3L A2PES', 20, 3, 2.2, 5.2, 'MTAL 15N 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (759, 'MTAL 15N 3L A2RA', 20, 6.5, 4.6, 11.1, 'MTAL 15N 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (760, 'MTAL 15N 3L A2RE', 20, 7.4, 5.5, 12.9, 'MTAL 15N 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (761, 'MTAL 15N 3L JA', 20, 6.6, 4.8, 11.4, 'MTAL 15N 3L JA');
INSERT INTO obras.maestro_actividades VALUES (762, 'MTAL 15N 3L JI', 20, 6.4, 4.6, 11, 'MTAL 15N 3L JI');
INSERT INTO obras.maestro_actividades VALUES (763, 'MTAL 15N 3L JIA', 20, 6.1, 4.3, 10.4, 'MTAL 15N 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (764, 'MTAL 15N 3L JP', 20, 7.4, 5.4, 12.8, 'MTAL 15N 3L JP');
INSERT INTO obras.maestro_actividades VALUES (765, 'MTAL 15N 3L PC', 20, 2.7, 1.9, 4.6, 'MTAL 15N 3L PC');
INSERT INTO obras.maestro_actividades VALUES (766, 'MTAL 15N 3L PCD', 20, 4, 3, 7, 'MTAL 15N 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (767, 'MTAL 15N 3L PD', 20, 4, 3, 7, 'MTAL 15N 3L PD');
INSERT INTO obras.maestro_actividades VALUES (768, 'MTAL 15N 3L PS', 20, 2.7, 1.9, 4.6, 'MTAL 15N 3L PS');
INSERT INTO obras.maestro_actividades VALUES (769, 'MTAL 15N 3L RS', 20, 3.8, 2.7, 6.5, 'MTAL 15N 3L RS');
INSERT INTO obras.maestro_actividades VALUES (770, 'MTAL 15N 3L RT', 20, 2.4, 1.6, 4, 'MTAL 15N 3L RT');
INSERT INTO obras.maestro_actividades VALUES (771, 'MTAL 15N 3P A1TJ', 20, 8.5, 6, 14.5, 'MTAL 15N 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (772, 'MTAL 15N 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTAL 15N 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (773, 'MTAL 15N 3P A2PA', 20, 2.4, 1.6, 4, 'MTAL 15N 3P A2PA');
INSERT INTO obras.maestro_actividades VALUES (774, 'MTAL 15N 3P A2PAS', 20, 2.4, 1.6, 4, 'MTAL 15N 3P A2PAS');
INSERT INTO obras.maestro_actividades VALUES (775, 'MTAL 15N 3P A2PE', 20, 4.6, 3.3, 7.9, 'MTAL 15N 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (776, 'MTAL 15N 3P A2PES', 20, 4.6, 3.3, 7.9, 'MTAL 15N 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (777, 'MTAL 15N 3P A2RA', 20, 9.2, 7.1, 16.3, 'MTAL 15N 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (778, 'MTAL 15N 3P JA', 20, 8.7, 6.2, 14.9, 'MTAL 15N 3P JA');
INSERT INTO obras.maestro_actividades VALUES (779, 'MTAL 15N 3P JI', 20, 8.5, 6, 14.5, 'MTAL 15N 3P JI');
INSERT INTO obras.maestro_actividades VALUES (780, 'MTAL 15N 3P JIA', 20, 8.2, 5.7, 13.9, 'MTAL 15N 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (781, 'MTAL 15N 3P JP', 20, 7.4, 5.4, 12.8, 'MTAL 15N 3P JP');
INSERT INTO obras.maestro_actividades VALUES (782, 'MTAL 15N 3P PC', 20, 2.7, 1.9, 4.6, 'MTAL 15N 3P PC');
INSERT INTO obras.maestro_actividades VALUES (783, 'MTAL 15N 3P PCD', 20, 4, 3, 7, 'MTAL 15N 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (784, 'MTAL 15N 3P PD', 20, 4, 3, 7, 'MTAL 15N 3P PD');
INSERT INTO obras.maestro_actividades VALUES (785, 'MTAL 15N 3P PS', 20, 2.7, 1.9, 4.6, 'MTAL 15N 3P PS');
INSERT INTO obras.maestro_actividades VALUES (786, 'MTAL 15N 3P RS', 20, 5.9, 4.1, 10, 'MTAL 15N 3P RS');
INSERT INTO obras.maestro_actividades VALUES (787, 'MTAL 15N 3P RT', 20, 2.4, 1.6, 4, 'MTAL 15N 3P RT');
INSERT INTO obras.maestro_actividades VALUES (788, 'MTAL 15V 2/3L A1TE', 20, 4.7, 3.4, 8.1, 'MTAL 15V 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (789, 'MTAL 15V 2/3L A1TES', 20, 4.5, 3.2, 7.7, 'MTAL 15V 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (790, 'MTAL 15V 2L A1TE', 20, 4.2, 3, 7.2, 'MTAL 15V 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (791, 'MTAL 15V 2L A1TES ', 20, 4, 2.8, 6.8, 'MTAL 15V 2L A1TES ');
INSERT INTO obras.maestro_actividades VALUES (792, 'MTAL 15V 2L A1TJ', 20, 4.8, 3.4, 8.2, 'MTAL 15V 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (793, 'MTAL 15V 2L A1TJS', 20, 4.6, 3.2, 7.8, 'MTAL 15V 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (794, 'MTAL 15V 2L A2PA', 20, 2.3, 1.5, 3.8, 'MTAL 15V 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (795, 'MTAL 15V 2L A2PAS', 20, 2.3, 1.5, 3.8, 'MTAL 15V 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (796, 'MTAL 15V 2L A2PE', 20, 2.3, 1.5, 3.8, 'MTAL 15V 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (797, 'MTAL 15V 2L A2PEJ', 20, 3.8, 2.6, 6.4, 'MTAL 15V 2L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (798, 'MTAL 15V 2L A2PEJS', 20, 3.8, 2.6, 6.4, 'MTAL 15V 2L A2PEJS');
INSERT INTO obras.maestro_actividades VALUES (799, 'MTAL 15V 2L A2PES', 20, 2.6, 1.8, 4.4, 'MTAL 15V 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (800, 'MTAL 15V 2L A2RA', 20, 5.6, 3.8, 9.4, 'MTAL 15V 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (801, 'MTAL 15V 2L A2RE', 20, 6.5, 4.7, 11.2, 'MTAL 15V 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (803, 'MTAL 15V 2L JI', 20, 4.8, 3.4, 8.2, 'MTAL 15V 2L JI');
INSERT INTO obras.maestro_actividades VALUES (804, 'MTAL 15V 2L JP', 20, 6.3, 4.5, 10.8, 'MTAL 15V 2L JP');
INSERT INTO obras.maestro_actividades VALUES (805, 'MTAL 15V 2L PC', 20, 2.3, 1.5, 3.8, 'MTAL 15V 2L PC');
INSERT INTO obras.maestro_actividades VALUES (806, 'MTAL 15V 2L PCD', 20, 3.4, 2.4, 5.8, 'MTAL 15V 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (807, 'MTAL 15V 2L PD', 20, 3.4, 2.4, 5.8, 'MTAL 15V 2L PD');
INSERT INTO obras.maestro_actividades VALUES (808, 'MTAL 15V 2L PS', 20, 2.3, 1.5, 3.8, 'MTAL 15V 2L PS');
INSERT INTO obras.maestro_actividades VALUES (809, 'MTAL 15V 2L RS', 20, 3.3, 2.3, 5.6, 'MTAL 15V 2L RS');
INSERT INTO obras.maestro_actividades VALUES (810, 'MTAL 15V 2L RT', 20, 2.1, 1.3, 3.4, 'MTAL 15V 2L RT');
INSERT INTO obras.maestro_actividades VALUES (811, 'MTAL 15V 3/2L A1TE', 20, 4.5, 3.3, 7.8, 'MTAL 15V 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (812, 'MTAL 15V 3/2L A1TES', 20, 4.3, 3.1, 7.4, 'MTAL 15V 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (813, 'MTAL 15V 3/2L A1TJ', 20, 5.3, 3.8, 9.1, 'MTAL 15V 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (814, 'MTAL 15V 3/2L A1TJS', 20, 5.1, 3.6, 8.7, 'MTAL 15V 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (815, 'MTAL 15V 3/2L A2RA', 20, 6.1, 4.2, 10.3, 'MTAL 15V 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (816, 'MTAL 15V 3/2L A2RE', 20, 7.1, 5.2, 12.3, 'MTAL 15V 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (817, 'MTAL 15V 3L A1TE', 20, 5.1, 3.8, 8.9, 'MTAL 15V 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (818, 'MTAL 15V 3L A1TES', 20, 4.8, 3.5, 8.3, 'MTAL 15V 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (819, 'MTAL 15V 3L A1TJ', 20, 6.4, 4.6, 11, 'MTAL 15V 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (820, 'MTAL 15V 3L A1TJS', 20, 6.1, 4.3, 10.4, 'MTAL 15V 3L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (821, 'MTAL 15V 3L A2PA', 20, 2.7, 1.9, 4.6, 'MTAL 15V 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (822, 'MTAL 15V 3L A2PAS', 20, 2.7, 1.9, 4.6, 'MTAL 15V 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (823, 'MTAL 15V 3L A2PE', 20, 2.7, 1.9, 4.6, 'MTAL 15V 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (824, 'MTAL 15V 3L A2PES', 20, 3, 2.2, 5.2, 'MTAL 15V 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (825, 'MTAL 15V 3L A2RA', 20, 6.5, 4.6, 11.1, 'MTAL 15V 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (826, 'MTAL 15V 3L A2RE', 20, 7.4, 5.5, 12.9, 'MTAL 15V 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (827, 'MTAL 15V 3L JA', 20, 6.6, 4.8, 11.4, 'MTAL 15V 3L JA');
INSERT INTO obras.maestro_actividades VALUES (828, 'MTAL 15V 3L JI', 20, 6.4, 4.6, 11, 'MTAL 15V 3L JI');
INSERT INTO obras.maestro_actividades VALUES (829, 'MTAL 15V 3L JIA', 20, 6.1, 4.3, 10.4, 'MTAL 15V 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (830, 'MTAL 15V 3L JP', 20, 7.4, 5.4, 12.8, 'MTAL 15V 3L JP');
INSERT INTO obras.maestro_actividades VALUES (831, 'MTAL 15V 3L PC', 20, 2.7, 1.9, 4.6, 'MTAL 15V 3L PC');
INSERT INTO obras.maestro_actividades VALUES (832, 'MTAL 15V 3L PCD', 20, 4, 3, 7, 'MTAL 15V 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (833, 'MTAL 15V 3L PD', 20, 4, 3, 7, 'MTAL 15V 3L PD');
INSERT INTO obras.maestro_actividades VALUES (834, 'MTAL 15V 3L PS', 20, 2.7, 1.9, 4.6, 'MTAL 15V 3L PS');
INSERT INTO obras.maestro_actividades VALUES (835, 'MTAL 15V 3L RS', 20, 3.8, 2.7, 6.5, 'MTAL 15V 3L RS');
INSERT INTO obras.maestro_actividades VALUES (836, 'MTAL 15V 3L RT', 20, 2.4, 1.6, 4, 'MTAL 15V 3L RT');
INSERT INTO obras.maestro_actividades VALUES (837, 'MTAL 15V 3P A1TJ', 20, 8.5, 6, 14.5, 'MTAL 15V 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (838, 'MTAL 15V 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTAL 15V 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (839, 'MTAL 15V 3P A2PA', 20, 2.4, 1.6, 4, 'MTAL 15V 3P A2PA');
INSERT INTO obras.maestro_actividades VALUES (840, 'MTAL 15V 3P A2PAS', 20, 2.4, 1.6, 4, 'MTAL 15V 3P A2PAS');
INSERT INTO obras.maestro_actividades VALUES (841, 'MTAL 15V 3P A2PE', 20, 4.6, 3.3, 7.9, 'MTAL 15V 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (842, 'MTAL 15V 3P A2PES', 20, 4.6, 3.3, 7.9, 'MTAL 15V 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (843, 'MTAL 15V 3P A2RA', 20, 10, 7.1, 17.1, 'MTAL 15V 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (844, 'MTAL 15V 3P JA', 20, 8.7, 6.2, 14.9, 'MTAL 15V 3P JA');
INSERT INTO obras.maestro_actividades VALUES (845, 'MTAL 15V 3P JI', 20, 8.5, 6, 14.5, 'MTAL 15V 3P JI');
INSERT INTO obras.maestro_actividades VALUES (846, 'MTAL 15V 3P JIA', 20, 8.2, 5.7, 13.9, 'MTAL 15V 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (847, 'MTAL 15V 3P JP', 20, 7.4, 5.4, 12.8, 'MTAL 15V 3P JP');
INSERT INTO obras.maestro_actividades VALUES (848, 'MTAL 15V 3P PC', 20, 2.7, 1.9, 4.6, 'MTAL 15V 3P PC');
INSERT INTO obras.maestro_actividades VALUES (849, 'MTAL 15V 3P PCD', 20, 4, 3, 7, 'MTAL 15V 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (850, 'MTAL 15V 3P PD', 20, 4, 3, 7, 'MTAL 15V 3P PD');
INSERT INTO obras.maestro_actividades VALUES (851, 'MTAL 15V 3P PS', 20, 2.7, 1.9, 4.6, 'MTAL 15V 3P PS');
INSERT INTO obras.maestro_actividades VALUES (852, 'MTAL 15V 3P RS', 20, 5.9, 4.1, 10, 'MTAL 15V 3P RS');
INSERT INTO obras.maestro_actividades VALUES (853, 'MTAL 15V 3P RT', 20, 2.4, 1.6, 4, 'MTAL 15V 3P RT');
INSERT INTO obras.maestro_actividades VALUES (854, 'MTAL 23N 2/3L A1TE', 20, 4.7, 3.4, 8.1, 'MTAL 23N 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (855, 'MTAL 23N 2/3L A1TES', 20, 4.5, 3.2, 7.7, 'MTAL 23N 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (856, 'MTAL 23N 2L A1TE', 20, 4.2, 3, 7.2, 'MTAL 23N 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (857, 'MTAL 23N 2L A1TES', 20, 4, 2.8, 6.8, 'MTAL 23N 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (858, 'MTAL 23N 2L A1TJ', 20, 4.8, 3.4, 8.2, 'MTAL 23N 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (859, 'MTAL 23N 2L A1TJS', 20, 4.6, 3.2, 7.8, 'MTAL 23N 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (860, 'MTAL 23N 2L A2PA', 20, 2.3, 1.5, 3.8, 'MTAL 23N 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (861, 'MTAL 23N 2L A2PAS', 20, 2.3, 1.5, 3.8, 'MTAL 23N 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (862, 'MTAL 23N 2L A2PE', 20, 2.3, 1.5, 3.8, 'MTAL 23N 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (863, 'MTAL 23N 2L A2PEJ', 20, 3.8, 2.6, 6.4, 'MTAL 23N 2L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (864, 'MTAL 23N 2L A2PEJS', 20, 3.8, 2.6, 6.4, 'MTAL 23N 2L A2PEJS');
INSERT INTO obras.maestro_actividades VALUES (865, 'MTAL 23N 2L A2PES', 20, 2.6, 1.8, 4.4, 'MTAL 23N 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (866, 'MTAL 23N 2L A2RA', 20, 5.6, 3.8, 9.4, 'MTAL 23N 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (867, 'MTAL 23N 2L A2RE', 20, 6.5, 4.7, 11.2, 'MTAL 23N 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (868, 'MTAL 23N 2L JA', 20, 5.3, 3.7, 9, 'MTAL 23N 2L JA');
INSERT INTO obras.maestro_actividades VALUES (869, 'MTAL 23N 2L JI', 20, 4.8, 3.4, 8.2, 'MTAL 23N 2L JI');
INSERT INTO obras.maestro_actividades VALUES (870, 'MTAL 23N 2L JP', 20, 6.3, 4.5, 10.8, 'MTAL 23N 2L JP');
INSERT INTO obras.maestro_actividades VALUES (871, 'MTAL 23N 2L PC', 20, 2.3, 1.5, 3.8, 'MTAL 23N 2L PC');
INSERT INTO obras.maestro_actividades VALUES (872, 'MTAL 23N 2L PCD', 20, 3.4, 2.4, 5.8, 'MTAL 23N 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (873, 'MTAL 23N 2L PD', 20, 3.4, 2.4, 5.8, 'MTAL 23N 2L PD');
INSERT INTO obras.maestro_actividades VALUES (874, 'MTAL 23N 2L PS', 20, 2.3, 1.5, 3.8, 'MTAL 23N 2L PS');
INSERT INTO obras.maestro_actividades VALUES (875, 'MTAL 23N 2L RS', 20, 3.3, 2.3, 5.6, 'MTAL 23N 2L RS');
INSERT INTO obras.maestro_actividades VALUES (876, 'MTAL 23N 2L RT', 20, 2.1, 1.3, 3.4, 'MTAL 23N 2L RT');
INSERT INTO obras.maestro_actividades VALUES (877, 'MTAL 23N 3/2L A1TE', 20, 4.5, 3.3, 7.8, 'MTAL 23N 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (878, 'MTAL 23N 3/2L A1TES', 20, 4.3, 3.1, 7.4, 'MTAL 23N 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (879, 'MTAL 23N 3/2L A1TJ', 20, 5.3, 3.8, 9.1, 'MTAL 23N 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (880, 'MTAL 23N 3/2L A1TJS', 20, 5, 3.6, 8.6, 'MTAL 23N 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (881, 'MTAL 23N 3/2L A2RA', 20, 6.1, 4.2, 10.3, 'MTAL 23N 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (882, 'MTAL 23N 3/2L A2RE', 20, 7.1, 5.2, 12.3, 'MTAL 23N 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (883, 'MTAL 23N 3L A1TE', 20, 5.1, 3.8, 8.9, 'MTAL 23N 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (884, 'MTAL 23N 3L A1TES', 20, 4.8, 3.5, 8.3, 'MTAL 23N 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (885, 'MTAL 23N 3L A1TJ', 20, 6.4, 4.6, 11, 'MTAL 23N 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (886, 'MTAL 23N 3L A1TJS', 20, 6.1, 4.3, 10.4, 'MTAL 23N 3L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (887, 'MTAL 23N 3L A2PA', 20, 2.7, 1.9, 4.6, 'MTAL 23N 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (888, 'MTAL 23N 3L A2PAS', 20, 2.7, 1.9, 4.6, 'MTAL 23N 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (889, 'MTAL 23N 3L A2PE', 20, 2.7, 1.9, 4.6, 'MTAL 23N 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (890, 'MTAL 23N 3L A2PES', 20, 3, 2.2, 5.2, 'MTAL 23N 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (891, 'MTAL 23N 3L A2RA', 20, 6.5, 4.6, 11.1, 'MTAL 23N 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (892, 'MTAL 23N 3L A2RE', 20, 7.4, 5.5, 12.9, 'MTAL 23N 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (893, 'MTAL 23N 3L JA', 20, 6.6, 4.8, 11.4, 'MTAL 23N 3L JA');
INSERT INTO obras.maestro_actividades VALUES (894, 'MTAL 23N 3L JI', 20, 6.4, 4.6, 11, 'MTAL 23N 3L JI');
INSERT INTO obras.maestro_actividades VALUES (895, 'MTAL 23N 3L JIA', 20, 6.1, 4.3, 10.4, 'MTAL 23N 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (896, 'MTAL 23N 3L JP', 20, 7.4, 5.4, 12.8, 'MTAL 23N 3L JP');
INSERT INTO obras.maestro_actividades VALUES (897, 'MTAL 23N 3L PC', 20, 2.7, 1.9, 4.6, 'MTAL 23N 3L PC');
INSERT INTO obras.maestro_actividades VALUES (898, 'MTAL 23N 3L PCD', 20, 4, 3, 7, 'MTAL 23N 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (899, 'MTAL 23N 3L PD', 20, 4, 3, 7, 'MTAL 23N 3L PD');
INSERT INTO obras.maestro_actividades VALUES (900, 'MTAL 23N 3L PS', 20, 2.7, 1.9, 4.6, 'MTAL 23N 3L PS');
INSERT INTO obras.maestro_actividades VALUES (901, 'MTAL 23N 3L RS', 20, 3.8, 2.7, 6.5, 'MTAL 23N 3L RS');
INSERT INTO obras.maestro_actividades VALUES (902, 'MTAL 23N 3L RT', 20, 2.4, 1.6, 4, 'MTAL 23N 3L RT');
INSERT INTO obras.maestro_actividades VALUES (903, 'MTAL 23N 3P A1TJ', 20, 8.5, 6, 14.5, 'MTAL 23N 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (904, 'MTAL 23N 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTAL 23N 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (905, 'MTAL 23N 3P A2PA', 20, 2.4, 1.6, 4, 'MTAL 23N 3P A2PA');
INSERT INTO obras.maestro_actividades VALUES (906, 'MTAL 23N 3P A2PAS', 20, 2.4, 1.6, 4, 'MTAL 23N 3P A2PAS');
INSERT INTO obras.maestro_actividades VALUES (907, 'MTAL 23N 3P A2PE', 20, 4.6, 3.3, 7.9, 'MTAL 23N 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (908, 'MTAL 23N 3P A2PES', 20, 4.6, 3.3, 7.9, 'MTAL 23N 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (909, 'MTAL 23N 3P A2RA', 20, 10, 7.1, 17.1, 'MTAL 23N 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (910, 'MTAL 23N 3P JA', 20, 8.7, 6.2, 14.9, 'MTAL 23N 3P JA');
INSERT INTO obras.maestro_actividades VALUES (911, 'MTAL 23N 3P JI', 20, 8.5, 6, 14.5, 'MTAL 23N 3P JI');
INSERT INTO obras.maestro_actividades VALUES (912, 'MTAL 23N 3P JIA', 20, 8.2, 5.7, 13.9, 'MTAL 23N 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (913, 'MTAL 23N 3P JP', 20, 7.4, 5.4, 12.8, 'MTAL 23N 3P JP');
INSERT INTO obras.maestro_actividades VALUES (914, 'MTAL 23N 3P PC', 20, 2.7, 1.9, 4.6, 'MTAL 23N 3P PC');
INSERT INTO obras.maestro_actividades VALUES (915, 'MTAL 23N 3P PCD', 20, 4, 3, 7, 'MTAL 23N 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (916, 'MTAL 23N 3P PD', 20, 4, 3, 7, 'MTAL 23N 3P PD');
INSERT INTO obras.maestro_actividades VALUES (917, 'MTAL 23N 3P PS', 20, 2.7, 1.9, 4.6, 'MTAL 23N 3P PS');
INSERT INTO obras.maestro_actividades VALUES (918, 'MTAL 23N 3P RS', 20, 5.9, 4.1, 10, 'MTAL 23N 3P RS');
INSERT INTO obras.maestro_actividades VALUES (919, 'MTAL 23N 3P RT', 20, 2.4, 1.6, 4, 'MTAL 23N 3P RT');
INSERT INTO obras.maestro_actividades VALUES (920, 'MTAL 23V 2/3L A1TE', 20, 4.7, 3.4, 8.1, 'MTAL 23V 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (921, 'MTAL 23V 2/3L A1TES', 20, 4.5, 3.2, 7.7, 'MTAL 23V 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (922, 'MTAL 23V 2L A1TE', 20, 4.2, 3, 7.2, 'MTAL 23V 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (923, 'MTAL 23V 2L A1TES', 20, 4, 2.8, 6.8, 'MTAL 23V 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (924, 'MTAL 23V 2L A1TJ', 20, 4.8, 3.4, 8.2, 'MTAL 23V 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (925, 'MTAL 23V 2L A1TJS', 20, 4.6, 3.2, 7.8, 'MTAL 23V 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (926, 'MTAL 23V 2L A2PA', 20, 2.3, 1.5, 3.8, 'MTAL 23V 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (927, 'MTAL 23V 2L A2PAS', 20, 2.3, 1.5, 3.8, 'MTAL 23V 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (928, 'MTAL 23V 2L A2PE', 20, 2.3, 1.5, 3.8, 'MTAL 23V 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (929, 'MTAL 23V 2L A2PEJ', 20, 3.8, 2.6, 6.4, 'MTAL 23V 2L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (930, 'MTAL 23V 2L A2PEJS', 20, 3.8, 2.6, 6.4, 'MTAL 23V 2L A2PEJS');
INSERT INTO obras.maestro_actividades VALUES (931, 'MTAL 23V 2L A2PES', 20, 2.6, 1.8, 4.4, 'MTAL 23V 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (932, 'MTAL 23V 2L A2RA', 20, 5.6, 3.8, 9.4, 'MTAL 23V 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (933, 'MTAL 23V 2L A2RE', 20, 6.5, 4.7, 11.2, 'MTAL 23V 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (934, 'MTAL 23V 2L JA', 20, 5.3, 3.7, 9, 'MTAL 23V 2L JA');
INSERT INTO obras.maestro_actividades VALUES (935, 'MTAL 23V 2L', 20, 4.8, 3.4, 8.2, 'MTAL 23V 2L');
INSERT INTO obras.maestro_actividades VALUES (936, 'MTAL 23V 2L JP', 20, 6.3, 4.5, 10.8, 'MTAL 23V 2L JP');
INSERT INTO obras.maestro_actividades VALUES (937, 'MTAL 23V 2L PC', 20, 2.3, 1.5, 3.8, 'MTAL 23V 2L PC');
INSERT INTO obras.maestro_actividades VALUES (938, 'MTAL 23V 2L PCD', 20, 3.4, 2.4, 5.8, 'MTAL 23V 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (939, 'MTAL 23V 2L PD', 20, 3.4, 2.4, 5.8, 'MTAL 23V 2L PD');
INSERT INTO obras.maestro_actividades VALUES (940, 'MTAL 23V 2L PS', 20, 2.3, 1.5, 3.8, 'MTAL 23V 2L PS');
INSERT INTO obras.maestro_actividades VALUES (941, 'MTAL 23V 2L RS', 20, 3.3, 2.3, 5.6, 'MTAL 23V 2L RS');
INSERT INTO obras.maestro_actividades VALUES (942, 'MTAL 23V 2L RT', 20, 2.1, 1.3, 3.4, 'MTAL 23V 2L RT');
INSERT INTO obras.maestro_actividades VALUES (943, 'MTAL 23V 3/2L A1TE', 20, 4.5, 3.3, 7.8, 'MTAL 23V 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (944, 'MTAL 23V 3/2L A1TES', 20, 4.3, 3.1, 7.4, 'MTAL 23V 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (945, 'MTAL 23V 3/2L A1TJ', 20, 5.3, 3.8, 9.1, 'MTAL 23V 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (946, 'MTAL 23V 3/2L A1TJS', 20, 5.1, 3.6, 8.7, 'MTAL 23V 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (947, 'MTAL 23V 3/2L A2RA', 20, 6.1, 4.2, 10.3, 'MTAL 23V 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (948, 'MTAL 23V 3/2L A2RE', 20, 7.1, 5.2, 12.3, 'MTAL 23V 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (949, 'MTAL 23V 3L A1TE', 20, 5.1, 3.8, 8.9, 'MTAL 23V 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (950, 'MTAL 23V 3L A1TES', 20, 4.8, 3.5, 8.3, 'MTAL 23V 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (951, 'MTAL 23V 3L A1TJ', 20, 6.4, 4.6, 11, 'MTAL 23V 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (952, 'MTAL 23V 3L A1TJS', 20, 6.1, 4.3, 10.4, 'MTAL 23V 3L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (953, 'MTAL 23V 3L A2PA', 20, 2.7, 1.9, 4.6, 'MTAL 23V 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (954, 'MTAL 23V 3L A2PAS', 20, 2.7, 1.9, 4.6, 'MTAL 23V 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (955, 'MTAL 23V 3L A2PE', 20, 2.7, 1.9, 4.6, 'MTAL 23V 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (956, 'MTAL 23V 3L A2PES', 20, 3, 2.2, 5.2, 'MTAL 23V 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (957, 'MTAL 23V 3L A2RA', 20, 6.5, 4.6, 11.1, 'MTAL 23V 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (958, 'MTAL 23V 3L A2RE', 20, 7.4, 5.5, 12.9, 'MTAL 23V 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (959, 'MTAL 23V 3L JA', 20, 6.6, 4.8, 11.4, 'MTAL 23V 3L JA');
INSERT INTO obras.maestro_actividades VALUES (960, 'MTAL 23V 3L JI', 20, 6.4, 4.6, 11, 'MTAL 23V 3L JI');
INSERT INTO obras.maestro_actividades VALUES (961, 'MTAL 23V 3L JIA', 20, 6.1, 4.3, 10.4, 'MTAL 23V 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (962, 'MTAL 23V 3L JP', 20, 7.4, 5.4, 12.8, 'MTAL 23V 3L JP');
INSERT INTO obras.maestro_actividades VALUES (963, 'MTAL 23V 3L PC', 20, 2.7, 1.9, 4.6, 'MTAL 23V 3L PC');
INSERT INTO obras.maestro_actividades VALUES (964, 'MTAL 23V 3L PCD', 20, 4, 3, 7, 'MTAL 23V 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (965, 'MTAL 23V 3L PD', 20, 4, 3, 7, 'MTAL 23V 3L PD');
INSERT INTO obras.maestro_actividades VALUES (966, 'MTAL 23V 3L PS', 20, 2.7, 1.9, 4.6, 'MTAL 23V 3L PS');
INSERT INTO obras.maestro_actividades VALUES (967, 'MTAL 23V 3L RS', 20, 3.8, 2.7, 6.5, 'MTAL 23V 3L RS');
INSERT INTO obras.maestro_actividades VALUES (968, 'MTAL 23V 3L RT', 20, 2.4, 1.6, 4, 'MTAL 23V 3L RT');
INSERT INTO obras.maestro_actividades VALUES (969, 'MTAL 23V 3P A1TJ', 20, 8.5, 6, 14.5, 'MTAL 23V 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (970, 'MTAL 23V 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTAL 23V 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (971, 'MTAL 23V 3P A2PA', 20, 2.4, 1.6, 4, 'MTAL 23V 3P A2PA');
INSERT INTO obras.maestro_actividades VALUES (972, 'MTAL 23V 3P A2PAS', 20, 2.4, 1.6, 4, 'MTAL 23V 3P A2PAS');
INSERT INTO obras.maestro_actividades VALUES (973, 'MTAL 23V 3P A2PE', 20, 4.6, 3.3, 7.9, 'MTAL 23V 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (974, 'MTAL 23V 3P A2PES', 20, 4.6, 3.3, 7.9, 'MTAL 23V 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (975, 'MTAL 23V 3P A2RA', 20, 10, 7.1, 17.1, 'MTAL 23V 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (976, 'MTAL 23V 3P JA', 20, 8.7, 6.2, 14.9, 'MTAL 23V 3P JA');
INSERT INTO obras.maestro_actividades VALUES (977, 'MTAL 23V 3P JI', 20, 8.5, 6, 14.5, 'MTAL 23V 3P JI');
INSERT INTO obras.maestro_actividades VALUES (978, 'MTAL 23V 3P JIA', 20, 8.2, 5.7, 13.9, 'MTAL 23V 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (979, 'MTAL 23V 3P JP', 20, 7.4, 5.4, 12.8, 'MTAL 23V 3P JP');
INSERT INTO obras.maestro_actividades VALUES (980, 'MTAL 23V 3P PC', 20, 2.7, 1.9, 4.6, 'MTAL 23V 3P PC');
INSERT INTO obras.maestro_actividades VALUES (981, 'MTAL 23V 3P PCD', 20, 4, 3, 7, 'MTAL 23V 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (982, 'MTAL 23V 3P PD', 20, 4, 3, 7, 'MTAL 23V 3P PD');
INSERT INTO obras.maestro_actividades VALUES (983, 'MTAL 23V 3P PS', 20, 2.7, 1.9, 4.6, 'MTAL 23V 3P PS');
INSERT INTO obras.maestro_actividades VALUES (984, 'MTAL 23V 3P RS', 20, 5.9, 4.1, 10, 'MTAL 23V 3P RS');
INSERT INTO obras.maestro_actividades VALUES (985, 'MTAL 23V 3P RT', 20, 2.4, 1.6, 4, 'MTAL 23V 3P RT');
INSERT INTO obras.maestro_actividades VALUES (986, 'MTAL 3F Portal PD', 20, 5, 3, 8, 'MTAL 3F Portal PD');
INSERT INTO obras.maestro_actividades VALUES (987, 'MTCO 15N 2 A2PE', 20, 2.5, 1.7, 4.2, 'MTCO 15N 2 A2PE');
INSERT INTO obras.maestro_actividades VALUES (988, 'MTCO 15N 2 A2PES', 20, 2.9, 1.7, 4.6, 'MTCO 15N 2 A2PES');
INSERT INTO obras.maestro_actividades VALUES (989, 'MTCO 15N 2 JI', 20, 4, 3, 7, 'MTCO 15N 2 JI');
INSERT INTO obras.maestro_actividades VALUES (990, 'MTCO 15N 2 PA', 20, 2, 1.2, 3.2, 'MTCO 15N 2 PA');
INSERT INTO obras.maestro_actividades VALUES (991, 'MTCO 15N 2 PC', 20, 1.8, 1, 2.8, 'MTCO 15N 2 PC');
INSERT INTO obras.maestro_actividades VALUES (992, 'MTCO 15N 2 RS', 20, 2.9, 2.1, 5, 'MTCO 15N 2 RS');
INSERT INTO obras.maestro_actividades VALUES (993, 'MTCO 15N 3 A1TJ', 20, 5.5, 3.7, 9.2, 'MTCO 15N 3 A1TJ');
INSERT INTO obras.maestro_actividades VALUES (994, 'MTCO 15N 3 A2PE', 20, 2.9, 2.2, 5.1, 'MTCO 15N 3 A2PE');
INSERT INTO obras.maestro_actividades VALUES (995, 'MTCO 15N 3 A2PES', 20, 3.5, 2.6, 6.1, 'MTCO 15N 3 A2PES');
INSERT INTO obras.maestro_actividades VALUES (996, 'MTCO 15N 3 JI', 20, 5.5, 3.7, 9.2, 'MTCO 15N 3 JI');
INSERT INTO obras.maestro_actividades VALUES (997, 'MTCO 15N 3 PA', 20, 2.3, 1.5, 3.8, 'MTCO 15N 3 PA');
INSERT INTO obras.maestro_actividades VALUES (998, 'MTCO 15N 3 PC', 20, 2.1, 1.3, 3.4, 'MTCO 15N 3 PC');
INSERT INTO obras.maestro_actividades VALUES (999, 'MTCO 15N 3 PS', 20, 2.1, 1.4, 3.5, 'MTCO 15N 3 PS');
INSERT INTO obras.maestro_actividades VALUES (1000, 'MTCO 15N 3 RS', 20, 3.2, 2.4, 5.6, 'MTCO 15N 3 RS');
INSERT INTO obras.maestro_actividades VALUES (1001, 'MTCO 15V 2 A2PE', 20, 2.5, 1.7, 4.2, 'MTCO 15V 2 A2PE');
INSERT INTO obras.maestro_actividades VALUES (1002, 'MTCO 15V 2 A2PES', 20, 2.9, 1.7, 4.6, 'MTCO 15V 2 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1003, 'MTCO 15V 2 JI', 20, 4, 3, 7, 'MTCO 15V 2 JI');
INSERT INTO obras.maestro_actividades VALUES (1004, 'MTCO 15V 2 PA', 20, 2, 1.2, 3.2, 'MTCO 15V 2 PA');
INSERT INTO obras.maestro_actividades VALUES (1005, 'MTCO 15V 2 PC', 20, 1.8, 1.1, 2.9, 'MTCO 15V 2 PC');
INSERT INTO obras.maestro_actividades VALUES (1006, 'MTCO 15V 2 RS', 20, 2.9, 2.1, 5, 'MTCO 15V 2 RS');
INSERT INTO obras.maestro_actividades VALUES (1007, 'MTCO 15V 3 A2PE', 20, 2.9, 2.2, 5.1, 'MTCO 15V 3 A2PE');
INSERT INTO obras.maestro_actividades VALUES (1008, 'MTCO 15V 3 A2PES', 20, 3.5, 2.6, 6.1, 'MTCO 15V 3 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1009, 'MTCO 15V 3 JI', 20, 5.5, 3.7, 9.2, 'MTCO 15V 3 JI');
INSERT INTO obras.maestro_actividades VALUES (1010, 'MTCO 15V 3 PA', 20, 2.3, 1.5, 3.8, 'MTCO 15V 3 PA');
INSERT INTO obras.maestro_actividades VALUES (1011, 'MTCO 15V 3 PC', 20, 2.1, 1.3, 3.4, 'MTCO 15V 3 PC');
INSERT INTO obras.maestro_actividades VALUES (1012, 'MTCO 15V 3 RS', 20, 3.2, 2.4, 5.6, 'MTCO 15V 3 RS');
INSERT INTO obras.maestro_actividades VALUES (1013, 'MTCO 23N 2 A2PE', 20, 2.5, 1.7, 4.2, 'MTCO 23N 2 A2PE');
INSERT INTO obras.maestro_actividades VALUES (1014, 'MTCO 23N 2 A2PES', 20, 2.9, 1.7, 4.6, 'MTCO 23N 2 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1015, 'MTCO 23N 2 JI', 20, 4, 3, 7, 'MTCO 23N 2 JI');
INSERT INTO obras.maestro_actividades VALUES (1016, 'MTCO 23N 2 PA', 20, 2, 1.2, 3.2, 'MTCO 23N 2 PA');
INSERT INTO obras.maestro_actividades VALUES (1017, 'MTCO 23N 2 PC', 20, 1.8, 1, 2.8, 'MTCO 23N 2 PC');
INSERT INTO obras.maestro_actividades VALUES (1018, 'MTCO 23N 2 RS', 20, 2.9, 2.1, 5, 'MTCO 23N 2 RS');
INSERT INTO obras.maestro_actividades VALUES (1019, 'MTCO 23N 3 A1TJ', 20, 5.5, 3.7, 9.2, 'MTCO 23N 3 A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1020, 'MTCO 23N 3 A2PE', 20, 2.9, 2.2, 5.1, 'MTCO 23N 3 A2PE');
INSERT INTO obras.maestro_actividades VALUES (1021, 'MTCO 23N 3 A2PES', 20, 3.5, 2.6, 6.1, 'MTCO 23N 3 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1022, 'MTCO 23N 3 JI', 20, 5.5, 3.7, 9.2, 'MTCO 23N 3 JI');
INSERT INTO obras.maestro_actividades VALUES (1023, 'MTCO 23N 3 PA', 20, 2.3, 1.5, 3.8, 'MTCO 23N 3 PA');
INSERT INTO obras.maestro_actividades VALUES (1024, 'MTCO 23N 3 PC', 20, 2.1, 1.3, 3.4, 'MTCO 23N 3 PC');
INSERT INTO obras.maestro_actividades VALUES (1025, 'MTCO 23N 3 PS', 20, 2.1, 1.4, 3.5, 'MTCO 23N 3 PS');
INSERT INTO obras.maestro_actividades VALUES (1026, 'MTCO 23N 3 RS', 20, 3.2, 2.4, 5.6, 'MTCO 23N 3 RS');
INSERT INTO obras.maestro_actividades VALUES (1027, 'MTCO 23V 2 A2PE', 20, 2.5, 1.7, 4.2, 'MTCO 23V 2 A2PE');
INSERT INTO obras.maestro_actividades VALUES (1028, 'MTCO 23V 2 A2PES', 20, 2.9, 1.7, 4.6, 'MTCO 23V 2 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1029, 'MTCO 23V 2 JI', 20, 4, 3, 7, 'MTCO 23V 2 JI');
INSERT INTO obras.maestro_actividades VALUES (1030, 'MTCO 23V 2 PA', 20, 2, 1.2, 3.2, 'MTCO 23V 2 PA');
INSERT INTO obras.maestro_actividades VALUES (1031, 'MTCO 23V 2 PC', 20, 1.8, 1, 2.8, 'MTCO 23V 2 PC');
INSERT INTO obras.maestro_actividades VALUES (1032, 'MTCO 23V 2 RS', 20, 2.9, 2.1, 5, 'MTCO 23V 2 RS');
INSERT INTO obras.maestro_actividades VALUES (1033, 'MTCO 23V 3 A2 PE', 20, 2.9, 2.2, 5.1, 'MTCO 23V 3 A2 PE');
INSERT INTO obras.maestro_actividades VALUES (1034, 'MTCO 23V 3 A2PES', 20, 3.5, 2.6, 6.1, 'MTCO 23V 3 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1035, 'MTCO 23V 3 JI', 20, 5.5, 3.7, 9.2, 'MTCO 23V 3 JI');
INSERT INTO obras.maestro_actividades VALUES (1036, 'MTCO 23V 3 PA', 20, 2.3, 1.5, 3.8, 'MTCO 23V 3 PA');
INSERT INTO obras.maestro_actividades VALUES (1037, 'MTCO 23V 3 PC', 20, 2.1, 1.3, 3.4, 'MTCO 23V 3 PC');
INSERT INTO obras.maestro_actividades VALUES (1038, 'MTCO 23V 3 RS', 20, 3.2, 2.1, 5.3, 'MTCO 23V 3 RS');
INSERT INTO obras.maestro_actividades VALUES (1039, 'MTCO 23N 2 PAC', 20, 2, 1.2, 2.7, 'MTCO 23N 2 PAC');
INSERT INTO obras.maestro_actividades VALUES (1040, 'MTCO 23N 3 PAC', 20, 2.3, 1.5, 3.2, 'MTCO 23N 3 PAC');
INSERT INTO obras.maestro_actividades VALUES (1041, 'MTCO SE2PC 15N', 20, 4.2, 3, 7.2, 'MTCO SE2PC 15N');
INSERT INTO obras.maestro_actividades VALUES (1042, 'MTCO SE2PC 15V', 20, 4.2, 3, 7.2, 'MTCO SE2PC 15V');
INSERT INTO obras.maestro_actividades VALUES (1043, 'MTCO SE2PC 23N', 20, 4.2, 3, 7.2, 'MTCO SE2PC 23N');
INSERT INTO obras.maestro_actividades VALUES (1044, 'MTCO SE2PC 23V', 20, 4.2, 3, 7.2, 'MTCO SE2PC 23V');
INSERT INTO obras.maestro_actividades VALUES (1045, 'MTCU 15C 2/3L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 15C 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1046, 'MTCU 15C 2/3L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 15C 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1047, 'MTCU 15C 2/3M A1TE', 20, 5.8, 4.4, 10.2, 'MTCU 15C 2/3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1048, 'MTCU 15C 2/3M A1TES', 20, 6.8, 4.8, 11.6, 'MTCU 15C 2/3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1049, 'MTCU 15C 2L A1TE', 20, 4, 3, 7, 'MTCU 15C 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1050, 'MTCU 15C 2L A1TES', 20, 3.6, 2.6, 6.2, 'MTCU 15C 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1051, 'MTCU 15C 2L A1TJ', 20, 4.2, 3.2, 7.4, 'MTCU 15C 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1052, 'MTCU 15C 2L A1TJS', 20, 3.8, 2.8, 6.6, 'MTCU 15C 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1053, 'MTCU 15C 2L A2PA', 20, 2.5, 1.7, 4.2, 'MTCU 15C 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1054, 'MTCU 15C 2L A2PAS', 20, 2.5, 1.7, 4.2, 'MTCU 15C 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1055, 'MTCU 15C 2L A2PE', 20, 2.5, 1.7, 4.2, 'MTCU 15C 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1056, 'MTCU 15C 2L A2PES', 20, 2.8, 2, 4.8, 'MTCU 15C 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1057, 'MTCU 15C 2L A2RA', 20, 5.4, 3.8, 9.2, 'MTCU 15C 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1058, 'MTCU 15C 2L A2RE', 20, 6.3, 4.7, 11, 'MTCU 15C 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1059, 'MTCU 15C 2L JA', 20, 4.7, 3.5, 8.2, 'MTCU 15C 2L JA');
INSERT INTO obras.maestro_actividades VALUES (1060, 'MTCU 15C 2L JI', 20, 4.2, 3.2, 7.4, 'MTCU 15C 2L JI');
INSERT INTO obras.maestro_actividades VALUES (1061, 'MTCU 15C 2L JP', 20, 7.5, 5.3, 12.8, 'MTCU 15C 2L JP');
INSERT INTO obras.maestro_actividades VALUES (1062, 'MTCU 15C 2L PC', 20, 2.1, 1.3, 3.4, 'MTCU 15C 2L PC');
INSERT INTO obras.maestro_actividades VALUES (1063, 'MTCU 15C 2L PCD', 20, 3.4, 2.4, 5.8, 'MTCU 15C 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (1064, 'MTCU 15C 2L PD', 20, 3.4, 2.4, 5.8, 'MTCU 15C 2L PD');
INSERT INTO obras.maestro_actividades VALUES (1065, 'MTCU 15C 2L PS', 20, 2.1, 1.3, 3.4, 'MTCU 15C 2L PS');
INSERT INTO obras.maestro_actividades VALUES (1066, 'MTCU 15C 2L RS', 20, 2.9, 2.1, 5, 'MTCU 15C 2L RS');
INSERT INTO obras.maestro_actividades VALUES (1067, 'MTCU 15C 2L RT', 20, 2.1, 1.3, 3.4, 'MTCU 15C 2L RT');
INSERT INTO obras.maestro_actividades VALUES (1068, 'MTCU 15C 3/2L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 15C 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1069, 'MTCU 15C 3/2L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 15C 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1070, 'MTCU 15C 3/2L A1TJ', 20, 4.5, 3.5, 8, 'MTCU 15C 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1071, 'MTCU 15C 3/2L A1TJS', 20, 4.1, 3.1, 7.2, 'MTCU 15C 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1072, 'MTCU 15C 3/2L A2RA', 20, 5.7, 4.1, 9.8, 'MTCU 15C 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1073, 'MTCU 15C 3/2L A2RE', 20, 6.6, 5, 11.6, 'MTCU 15C 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1074, 'MTCU 15C 3L A1TE', 20, 4.8, 3.8, 8.6, 'MTCU 15C 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1075, 'MTCU 15C 3L A1TES', 20, 4.2, 3.2, 7.4, 'MTCU 15C 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1076, 'MTCU 15C 3L A1TJ', 20, 5.5, 4.3, 9.8, 'MTCU 15C 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1077, 'MTCU 15C 3L A1TJS', 20, 4.4, 3.4, 7.8, 'MTCU 15C 3L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1078, 'MTCU 15C 3L A2PA', 20, 3, 2.2, 5.2, 'MTCU 15C 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1079, 'MTCU 15C 3L A2PAS', 20, 3, 2.2, 5.2, 'MTCU 15C 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1080, 'MTCU 15C 3L A2PE', 20, 3, 2.2, 5.2, 'MTCU 15C 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1081, 'MTCU 15C 3L A2PES', 20, 3.3, 2.5, 5.8, 'MTCU 15C 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1082, 'MTCU 15C 3L A2RA', 20, 6.2, 4.6, 10.8, 'MTCU 15C 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1083, 'MTCU 15C 3L A2RE', 20, 7.1, 5.5, 12.6, 'MTCU 15C 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1084, 'MTCU 15C 3L JA', 20, 5.7, 4.5, 10.2, 'MTCU 15C 3L JA');
INSERT INTO obras.maestro_actividades VALUES (1085, 'MTCU 15C 3L JI', 20, 5.5, 4.3, 9.8, 'MTCU 15C 3L JI');
INSERT INTO obras.maestro_actividades VALUES (1086, 'MTCU 15C 3L JIA', 20, 4.4, 3.4, 7.8, 'MTCU 15C 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (1087, 'MTCU 15C 3L JP', 20, 6.5, 5.1, 11.6, 'MTCU 15C 3L JP');
INSERT INTO obras.maestro_actividades VALUES (1088, 'MTCU 15C 3L PC', 20, 2.4, 1.6, 4, 'MTCU 15C 3L PC');
INSERT INTO obras.maestro_actividades VALUES (1089, 'MTCU 15C 3L PCD', 20, 4, 3, 7, 'MTCU 15C 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (1090, 'MTCU 15C 3L PD', 20, 4, 3, 7, 'MTCU 15C 3L PD');
INSERT INTO obras.maestro_actividades VALUES (1091, 'MTCU 15C 3L PS', 20, 2.4, 1.6, 4, 'MTCU 15C 3L PS');
INSERT INTO obras.maestro_actividades VALUES (1092, 'MTCU 15C 3L RS', 20, 3.2, 2.4, 5.6, 'MTCU 15C 3L RS');
INSERT INTO obras.maestro_actividades VALUES (1093, 'MTCU 15C 3L RT', 20, 2.4, 1.6, 4, 'MTCU 15C 3L RT');
INSERT INTO obras.maestro_actividades VALUES (1094, 'MTCU 15C 3M A1TE', 20, 6.3, 4.9, 11.2, 'MTCU 15C 3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1095, 'MTCU 15C 3M A1TES', 20, 7.1, 5.1, 12.2, 'MTCU 15C 3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1096, 'MTCU 15C 3M A1TJ', 20, 7, 5.4, 12.4, 'MTCU 15C 3M A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1097, 'MTCU 15C 3M A1TJS', 20, 7.3, 5.3, 12.6, 'MTCU 15C 3M A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1098, 'MTCU 15C 3M A2PA', 20, 3, 2.2, 5.2, 'MTCU 15C 3M A2PA');
INSERT INTO obras.maestro_actividades VALUES (1099, 'MTCU 15C 3M A2PAS', 20, 3, 2.2, 5.2, 'MTCU 15C 3M A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1100, 'MTCU 15C 3M A2PE', 20, 4.3, 3.3, 7.6, 'MTCU 15C 3M A2PE');
INSERT INTO obras.maestro_actividades VALUES (1101, 'MTCU 15C 3M A2PES', 20, 4.3, 3.3, 7.6, 'MTCU 15C 3M A2PES');
INSERT INTO obras.maestro_actividades VALUES (1102, 'MTCU 15C 3M A2RA', 20, 7.7, 5.7, 13.4, 'MTCU 15C 3M A2RA');
INSERT INTO obras.maestro_actividades VALUES (1103, 'MTCU 15C 3M A2RE', 20, 8.6, 6.6, 15.2, 'MTCU 15C 3M A2RE');
INSERT INTO obras.maestro_actividades VALUES (1104, 'MTCU 15C 3M JA', 20, 7.2, 5.6, 12.8, 'MTCU 15C 3M JA');
INSERT INTO obras.maestro_actividades VALUES (1105, 'MTCU 15C 3M JI', 20, 7, 5.4, 12.4, 'MTCU 15C 3M JI');
INSERT INTO obras.maestro_actividades VALUES (1106, 'MTCU 15C 3M JIA', 20, 5.9, 4.5, 10.4, 'MTCU 15C 3M JIA');
INSERT INTO obras.maestro_actividades VALUES (1107, 'MTCU 15C 3M JP', 20, 6.5, 5.1, 11.6, 'MTCU 15C 3M JP');
INSERT INTO obras.maestro_actividades VALUES (1108, 'MTCU 15C 3M PC ', 20, 2.4, 1.6, 4, 'MTCU 15C 3M PC ');
INSERT INTO obras.maestro_actividades VALUES (1109, 'MTCU 15C 3M PCD', 20, 4, 3, 7, 'MTCU 15C 3M PCD');
INSERT INTO obras.maestro_actividades VALUES (1110, 'MTCU 15C 3M PD', 20, 4, 3, 7, 'MTCU 15C 3M PD');
INSERT INTO obras.maestro_actividades VALUES (1111, 'MTCU 15C 3M PS', 20, 2.4, 1.6, 4, 'MTCU 15C 3M PS');
INSERT INTO obras.maestro_actividades VALUES (1112, 'MTCU 15C 3M RS', 20, 4.7, 3.5, 8.2, 'MTCU 15C 3M RS');
INSERT INTO obras.maestro_actividades VALUES (1113, 'MTCU 15C 3M RT', 20, 2.4, 1.6, 4, 'MTCU 15C 3M RT');
INSERT INTO obras.maestro_actividades VALUES (1114, 'MTCU 15C 3P A1TJ', 20, 9.4, 6.3, 15.7, 'MTCU 15C 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1115, 'MTCU 15C 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTCU 15C 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1116, 'MTCU 15C 3P A2PE', 20, 5.5, 3.6, 9.1, 'MTCU 15C 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (1117, 'MTCU 15C 3P A2PES', 20, 5.5, 3.6, 9.1, 'MTCU 15C 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (1118, 'MTCU 15C 3P A2RA', 20, 10.9, 7.4, 18.3, 'MTCU 15C 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (1119, 'MTCU 15C 3P JA', 20, 9.6, 6.5, 16.1, 'MTCU 15C 3P JA');
INSERT INTO obras.maestro_actividades VALUES (1120, 'MTCU 15C 3P JI', 20, 9.4, 6.3, 15.7, 'MTCU 15C 3P JI');
INSERT INTO obras.maestro_actividades VALUES (1121, 'MTCU 15C 3P JIA', 20, 7.7, 5.4, 13.1, 'MTCU 15C 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (1122, 'MTCU 15C 3P JP', 20, 8.3, 5.7, 14, 'MTCU 15C 3P JP');
INSERT INTO obras.maestro_actividades VALUES (1123, 'MTCU 15C 3P PC', 20, 2.4, 1.6, 4, 'MTCU 15C 3P PC');
INSERT INTO obras.maestro_actividades VALUES (1124, 'MTCU 15C 3P PCD', 20, 4, 3, 7, 'MTCU 15C 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (1125, 'MTCU 15C 3P PD', 20, 4, 3, 7, 'MTCU 15C 3P PD');
INSERT INTO obras.maestro_actividades VALUES (1126, 'MTCU 15C 3P PS', 20, 2.4, 1.6, 4, 'MTCU 15C 3P PS');
INSERT INTO obras.maestro_actividades VALUES (1127, 'MTCU 15C 3P RS', 20, 5.9, 4.1, 10, 'MTCU 15C 3P RS');
INSERT INTO obras.maestro_actividades VALUES (1128, 'MTCU 15E 2/3L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 15E 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1129, 'MTCU 15E 2/3L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 15E 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1130, 'MTCU 15E 2/3M A1TE', 20, 5.8, 4.4, 10.2, 'MTCU 15E 2/3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1131, 'MTCU 15E 2/3M A1TES', 20, 6.8, 4.8, 11.6, 'MTCU 15E 2/3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1132, 'MTCU 15E 2L A1TE', 20, 4, 3, 7, 'MTCU 15E 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1133, 'MTCU 15E 2L A1TES', 20, 3.6, 2.6, 6.2, 'MTCU 15E 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1134, 'MTCU 15E 2L A1TJ', 20, 4.2, 3.2, 7.4, 'MTCU 15E 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1135, 'MTCU 15E 2L A1TJS', 20, 3.8, 2.8, 6.6, 'MTCU 15E 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1136, 'MTCU 15E 2L A2PA', 20, 2.5, 1.7, 4.2, 'MTCU 15E 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1137, 'MTCU 15E 2L A2PAS', 20, 2.5, 1.7, 4.2, 'MTCU 15E 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1138, 'MTCU 15E 2L A2PE', 20, 2.5, 1.7, 4.2, 'MTCU 15E 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1139, 'MTCU 15E 2L A2PES', 20, 2.8, 2, 4.8, 'MTCU 15E 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1140, 'MTCU 15E 2L A2RA', 20, 5.4, 3.8, 9.2, 'MTCU 15E 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1141, 'MTCU 15E 2L A2RE', 20, 6.3, 4.7, 11, 'MTCU 15E 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1142, 'MTCU 15E 2L JA', 20, 4.7, 3.5, 8.2, 'MTCU 15E 2L JA');
INSERT INTO obras.maestro_actividades VALUES (1143, 'MTCU 15E 2L JI', 20, 4.2, 3.2, 7.4, 'MTCU 15E 2L JI');
INSERT INTO obras.maestro_actividades VALUES (1144, 'MTCU 15E 2L JP', 20, 7.5, 5.3, 12.8, 'MTCU 15E 2L JP');
INSERT INTO obras.maestro_actividades VALUES (1145, 'MTCU 15E 2L PC', 20, 2.1, 1.3, 3.4, 'MTCU 15E 2L PC');
INSERT INTO obras.maestro_actividades VALUES (1146, 'MTCU 15E 2L PCD', 20, 3.4, 2.4, 5.8, 'MTCU 15E 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (1147, 'MTCU 15E 2L PD', 20, 3.4, 2.4, 5.8, 'MTCU 15E 2L PD');
INSERT INTO obras.maestro_actividades VALUES (1148, 'MTCU 15E 2L PS', 20, 2.1, 1.3, 3.4, 'MTCU 15E 2L PS');
INSERT INTO obras.maestro_actividades VALUES (1149, 'MTCU 15E 2L RS', 20, 2.9, 2.1, 5, 'MTCU 15E 2L RS');
INSERT INTO obras.maestro_actividades VALUES (1150, 'MTCU 15E 2L RT', 20, 2.1, 1.3, 3.4, 'MTCU 15E 2L RT');
INSERT INTO obras.maestro_actividades VALUES (1151, 'MTCU 15E 3/2L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 15E 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1152, 'MTCU 15E 3/2L A1TES ', 20, 3.9, 2.9, 6.8, 'MTCU 15E 3/2L A1TES ');
INSERT INTO obras.maestro_actividades VALUES (1153, 'MTCU 15E 3/2L A1TJ', 20, 4.5, 3.5, 8, 'MTCU 15E 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1154, 'MTCU 15E 3/2L A1TJS', 20, 4.1, 3.1, 7.2, 'MTCU 15E 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1155, 'MTCU 15E 3/2L A2RA', 20, 5.7, 4.1, 9.8, 'MTCU 15E 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1156, 'MTCU 15E 3/2L A2RE', 20, 6.6, 5, 11.6, 'MTCU 15E 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1157, 'MTCU 15E 3L A1TE', 20, 4.8, 3.8, 8.6, 'MTCU 15E 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1158, 'MTCU 15E 3L A1TES', 20, 4.2, 3.2, 7.4, 'MTCU 15E 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1159, 'MTCU 15E 3L A1TJ', 20, 5.5, 4.3, 9.8, 'MTCU 15E 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1160, 'MTCU 15E 3L A1TJS', 20, 4.4, 3.4, 7.8, 'MTCU 15E 3L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1161, 'MTCU 15E 3L A2PA', 20, 3, 2.2, 5.2, 'MTCU 15E 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1162, 'MTCU 15E 3L A2PAS', 20, 3, 2.2, 5.2, 'MTCU 15E 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1163, 'MTCU 15E 3L A2PE', 20, 3, 2.2, 5.2, 'MTCU 15E 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1164, 'MTCU 15E 3L A2PES ', 20, 3.3, 2.5, 5.8, 'MTCU 15E 3L A2PES ');
INSERT INTO obras.maestro_actividades VALUES (1165, 'MTCU 15E 3L A2RA', 20, 6.2, 4.6, 10.8, 'MTCU 15E 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1166, 'MTCU 15E 3L A2RE', 20, 7.1, 5.5, 12.6, 'MTCU 15E 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1167, 'MTCU 15E 3L JA', 20, 5.7, 4.5, 10.2, 'MTCU 15E 3L JA');
INSERT INTO obras.maestro_actividades VALUES (1168, 'MTCU 15E 3L JI', 20, 5.5, 4.3, 9.8, 'MTCU 15E 3L JI');
INSERT INTO obras.maestro_actividades VALUES (1169, 'MTCU 15E 3L JIA', 20, 4.4, 3.4, 7.8, 'MTCU 15E 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (1170, 'MTCU 15E 3L JP', 20, 6.5, 5.1, 11.6, 'MTCU 15E 3L JP');
INSERT INTO obras.maestro_actividades VALUES (1171, 'MTCU 15E 3L PC', 20, 2.4, 1.6, 4, 'MTCU 15E 3L PC');
INSERT INTO obras.maestro_actividades VALUES (1172, 'MTCU 15E 3L PCD', 20, 4, 3, 7, 'MTCU 15E 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (1173, 'MTCU 15E 3L PD', 20, 4, 3, 7, 'MTCU 15E 3L PD');
INSERT INTO obras.maestro_actividades VALUES (1174, 'MTCU 15E 3L PS', 20, 2.4, 1.6, 4, 'MTCU 15E 3L PS');
INSERT INTO obras.maestro_actividades VALUES (1175, 'MTCU 15E 3L RS', 20, 3.2, 2.4, 5.6, 'MTCU 15E 3L RS');
INSERT INTO obras.maestro_actividades VALUES (1176, 'MTCU 15E 3L RT', 20, 2.4, 1.6, 4, 'MTCU 15E 3L RT');
INSERT INTO obras.maestro_actividades VALUES (1177, 'MTCU 15E 3M A1TE', 20, 6.3, 4.9, 11.2, 'MTCU 15E 3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1178, 'MTCU 15E 3M A1TES', 20, 7.1, 5.1, 12.2, 'MTCU 15E 3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1179, 'MTCU 15E 3M A1TJ', 20, 7, 5.4, 12.4, 'MTCU 15E 3M A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1180, 'MTCU 15E 3M A1TJS', 20, 7.3, 5.3, 12.6, 'MTCU 15E 3M A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1181, 'MTCU 15E 3M A2PA', 20, 3, 2.2, 5.2, 'MTCU 15E 3M A2PA');
INSERT INTO obras.maestro_actividades VALUES (1182, 'MTCU 15E 3M A2PAS', 20, 3, 2.2, 5.2, 'MTCU 15E 3M A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1183, 'MTCU 15E 3M A2PE', 20, 4.3, 3.3, 7.6, 'MTCU 15E 3M A2PE');
INSERT INTO obras.maestro_actividades VALUES (1184, 'MTCU 15E 3M A2PES', 20, 4.3, 3.3, 7.6, 'MTCU 15E 3M A2PES');
INSERT INTO obras.maestro_actividades VALUES (1185, 'MTCU 15E 3M A2RA', 20, 7.7, 5.7, 13.4, 'MTCU 15E 3M A2RA');
INSERT INTO obras.maestro_actividades VALUES (1186, 'MTCU 15E 3M A2RE', 20, 8.6, 6.6, 15.2, 'MTCU 15E 3M A2RE');
INSERT INTO obras.maestro_actividades VALUES (1187, 'MTCU 15E 3M JA', 20, 7.2, 5.6, 12.8, 'MTCU 15E 3M JA');
INSERT INTO obras.maestro_actividades VALUES (1188, 'MTCU 15E 3M JI', 20, 7, 5.4, 12.4, 'MTCU 15E 3M JI');
INSERT INTO obras.maestro_actividades VALUES (1189, 'MTCU 15E 3M JIA', 20, 5.9, 4.5, 10.4, 'MTCU 15E 3M JIA');
INSERT INTO obras.maestro_actividades VALUES (1190, 'MTCU 15E 3M JP', 20, 6.5, 5.1, 11.6, 'MTCU 15E 3M JP');
INSERT INTO obras.maestro_actividades VALUES (1191, 'MTCU 15E 3M PC', 20, 2.4, 1.6, 4, 'MTCU 15E 3M PC');
INSERT INTO obras.maestro_actividades VALUES (1192, 'MTCU 15E 3M PCD', 20, 4, 3, 7, 'MTCU 15E 3M PCD');
INSERT INTO obras.maestro_actividades VALUES (1193, 'MTCU 15E 3M PD', 20, 4, 3, 7, 'MTCU 15E 3M PD');
INSERT INTO obras.maestro_actividades VALUES (1194, 'MTCU 15E 3M PS', 20, 2.4, 1.6, 4, 'MTCU 15E 3M PS');
INSERT INTO obras.maestro_actividades VALUES (1195, 'MTCU 15E 3M RS', 20, 4.7, 3.5, 8.2, 'MTCU 15E 3M RS');
INSERT INTO obras.maestro_actividades VALUES (1196, 'MTCU 15E 3M RT', 20, 2.4, 1.6, 4, 'MTCU 15E 3M RT');
INSERT INTO obras.maestro_actividades VALUES (1197, 'MTCU 15E 3P A1TJ', 20, 9.4, 6.3, 15.7, 'MTCU 15E 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1198, 'MTCU 15E 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTCU 15E 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1199, 'MTCU 15E 3P A2PE', 20, 5.5, 3.6, 9.1, 'MTCU 15E 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (1200, 'MTCU 15E 3P A2PES', 20, 5.5, 3.6, 9.1, 'MTCU 15E 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (1201, 'MTCU 15E 3P A2RA', 20, 10.9, 7.4, 18.3, 'MTCU 15E 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (1202, 'MTCU 15E 3P JA', 20, 9.6, 6.5, 16.1, 'MTCU 15E 3P JA');
INSERT INTO obras.maestro_actividades VALUES (1203, 'MTCU 15E 3P JI', 20, 9.4, 6.3, 15.7, 'MTCU 15E 3P JI');
INSERT INTO obras.maestro_actividades VALUES (1204, 'MTCU 15E 3P JIA', 20, 7.7, 5.4, 13.1, 'MTCU 15E 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (1205, 'MTCU 15E 3P JP', 20, 8.3, 5.7, 14, 'MTCU 15E 3P JP');
INSERT INTO obras.maestro_actividades VALUES (1206, 'MTCU 15E 3P PC', 20, 2.4, 1.6, 4, 'MTCU 15E 3P PC');
INSERT INTO obras.maestro_actividades VALUES (1207, 'MTCU 15E 3P PCD', 20, 4, 3, 7, 'MTCU 15E 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (1208, 'MTCU 15E 3P PD', 20, 4, 3, 7, 'MTCU 15E 3P PD');
INSERT INTO obras.maestro_actividades VALUES (1209, 'MTCU 15E 3P PS', 20, 2.4, 1.6, 4, 'MTCU 15E 3P PS');
INSERT INTO obras.maestro_actividades VALUES (1210, 'MTCU 15E 3P RS', 20, 5.9, 4.1, 10, 'MTCU 15E 3P RS');
INSERT INTO obras.maestro_actividades VALUES (1211, 'MTCU 15N 2/3L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 15N 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1212, 'MTCU 15N 2/3L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 15N 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1213, 'MTCU 15N 2/3M A1TE', 20, 5.8, 4.4, 10.2, 'MTCU 15N 2/3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1214, 'MTCU 15N 2/3M A1TES', 20, 6.8, 4.8, 11.6, 'MTCU 15N 2/3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1215, 'MTCU 15N 2L A1TE', 20, 4, 3, 7, 'MTCU 15N 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1216, 'MTCU 15N 2L A1TES', 20, 3.6, 2.6, 6.2, 'MTCU 15N 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1217, 'MTCU 15N 2L A1TJ', 20, 4.2, 3.2, 7.4, 'MTCU 15N 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1218, 'MTCU 15N 2L A1TJS', 20, 3.8, 2.8, 6.6, 'MTCU 15N 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1219, 'MTCU 15N 2L A2PA', 20, 2.5, 1.7, 4.2, 'MTCU 15N 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1220, 'MTCU 15N 2L A2PAS', 20, 2.5, 1.7, 4.2, 'MTCU 15N 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1221, 'MTCU 15N 2L A2PE', 20, 2.5, 1.7, 4.2, 'MTCU 15N 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1222, 'MTCU 15N 2L A2PES', 20, 2.8, 2, 4.8, 'MTCU 15N 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1223, 'MTCU 15N 2L A2RA', 20, 5.4, 3.8, 9.2, 'MTCU 15N 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1224, 'MTCU 15N 2L A2RE', 20, 6.3, 4.7, 11, 'MTCU 15N 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1225, 'MTCU 15N 2L JA', 20, 4.7, 3.5, 8.2, 'MTCU 15N 2L JA');
INSERT INTO obras.maestro_actividades VALUES (1226, 'MTCU 15N 2L JI', 20, 4.2, 3.2, 7.4, 'MTCU 15N 2L JI');
INSERT INTO obras.maestro_actividades VALUES (1227, 'MTCU 15N 2L JP', 20, 7.5, 5.3, 12.8, 'MTCU 15N 2L JP');
INSERT INTO obras.maestro_actividades VALUES (1228, 'MTCU 15N 2L PC', 20, 2.1, 1.3, 3.4, 'MTCU 15N 2L PC');
INSERT INTO obras.maestro_actividades VALUES (1229, 'MTCU 15N 2L PCD', 20, 3.4, 2.4, 5.8, 'MTCU 15N 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (1230, 'MTCU 15N 2L PD', 20, 3.4, 2.4, 5.8, 'MTCU 15N 2L PD');
INSERT INTO obras.maestro_actividades VALUES (1231, 'MTCU 15N 2L PS', 20, 2.1, 1.3, 3.4, 'MTCU 15N 2L PS');
INSERT INTO obras.maestro_actividades VALUES (1232, 'MTCU 15N 2L RS', 20, 2.9, 2.1, 5, 'MTCU 15N 2L RS');
INSERT INTO obras.maestro_actividades VALUES (1233, 'MTCU 15N 2L RT', 20, 2.1, 1.3, 3.4, 'MTCU 15N 2L RT');
INSERT INTO obras.maestro_actividades VALUES (1234, 'MTCU 15N 3/2L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 15N 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1235, 'MTCU 15N 3/2L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 15N 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1236, 'MTCU 15N 3/2L A1TJ', 20, 4.5, 3.5, 8, 'MTCU 15N 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1237, 'MTCU 15N 3/2L A1TJS', 20, 4.1, 3.1, 7.2, 'MTCU 15N 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1238, 'MTCU 15N 3/2L A2RA', 20, 5.7, 4.1, 9.8, 'MTCU 15N 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1239, 'MTCU 15N 3/2L A2RE', 20, 6.6, 5, 11.6, 'MTCU 15N 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1240, 'MTCU 15N 3/2M A1TJ', 20, 6, 4.6, 10.6, 'MTCU 15N 3/2M A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1241, 'MTCU 15N 3L A1TE', 20, 4.8, 3.8, 8.6, 'MTCU 15N 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1242, 'MTCU 15N 3L A1TES', 20, 4.2, 3.2, 7.4, 'MTCU 15N 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1243, 'MTCU 15N 3L A1TJ', 20, 5.5, 4.3, 9.8, 'MTCU 15N 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1244, 'MTCU 15N 3L A1TJS', 20, 4.4, 3.4, 7.8, 'MTCU 15N 3L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1245, 'MTCU 15N 3L A2PA', 20, 3, 2.2, 5.2, 'MTCU 15N 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1246, 'MTCU 15N 3L A2PAS', 20, 3, 2.2, 5.2, 'MTCU 15N 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1247, 'MTCU 15N 3L A2PE', 20, 3, 2.2, 5.2, 'MTCU 15N 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1248, 'MTCU 15N 3L A2PES', 20, 3.3, 2.5, 5.8, 'MTCU 15N 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1249, 'MTCU 15N 3L A2RA', 20, 6.2, 4.6, 10.8, 'MTCU 15N 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1250, 'MTCU 15N 3L A2RE', 20, 7.1, 5.5, 12.6, 'MTCU 15N 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1251, 'MTCU 15N 3L JA', 20, 5.7, 4.5, 10.2, 'MTCU 15N 3L JA');
INSERT INTO obras.maestro_actividades VALUES (1252, 'MTCU 15N 3L JI', 20, 5.5, 4.3, 9.8, 'MTCU 15N 3L JI');
INSERT INTO obras.maestro_actividades VALUES (1253, 'MTCU 15N 3L JIA', 20, 4.4, 3.4, 7.8, 'MTCU 15N 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (1254, 'MTCU 15N 3L JP', 20, 6.5, 5.1, 11.6, 'MTCU 15N 3L JP');
INSERT INTO obras.maestro_actividades VALUES (1255, 'MTCU 15N 3L PC', 20, 2.4, 1.6, 4, 'MTCU 15N 3L PC');
INSERT INTO obras.maestro_actividades VALUES (1256, 'MTCU 15N 3L PCD', 20, 4, 3, 7, 'MTCU 15N 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (1257, 'MTCU 15N 3L PD', 20, 4, 3, 7, 'MTCU 15N 3L PD');
INSERT INTO obras.maestro_actividades VALUES (1258, 'MTCU 15N 3L PS', 20, 2.4, 1.6, 4, 'MTCU 15N 3L PS');
INSERT INTO obras.maestro_actividades VALUES (1259, 'MTCU 15N 3L RS', 20, 3.2, 2.4, 5.6, 'MTCU 15N 3L RS');
INSERT INTO obras.maestro_actividades VALUES (1260, 'MTCU 15N 3L RT', 20, 2.4, 1.6, 4, 'MTCU 15N 3L RT');
INSERT INTO obras.maestro_actividades VALUES (1261, 'MTCU 15N 3M A1TE', 20, 6.3, 4.9, 11.2, 'MTCU 15N 3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1262, 'MTCU 15N 3M A1TES', 20, 7.1, 5.1, 12.2, 'MTCU 15N 3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1263, 'MTCU 15N 3M A1TJ', 20, 7, 5.4, 12.4, 'MTCU 15N 3M A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1264, 'MTCU 15N 3M A1TJS', 20, 7.3, 5.3, 12.6, 'MTCU 15N 3M A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1265, 'MTCU 15N 3M A2PA', 20, 3, 2.2, 5.2, 'MTCU 15N 3M A2PA');
INSERT INTO obras.maestro_actividades VALUES (1266, 'MTCU 15N 3M A2PAS', 20, 3, 2.2, 5.2, 'MTCU 15N 3M A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1267, 'MTCU 15N 3M A2PE', 20, 4.3, 3.3, 7.6, 'MTCU 15N 3M A2PE');
INSERT INTO obras.maestro_actividades VALUES (1268, 'MTCU 15N 3M A2PES', 20, 4.3, 3.3, 7.6, 'MTCU 15N 3M A2PES');
INSERT INTO obras.maestro_actividades VALUES (1269, 'MTCU 15N 3M A2RA', 20, 7.7, 5.7, 13.4, 'MTCU 15N 3M A2RA');
INSERT INTO obras.maestro_actividades VALUES (1270, 'MTCU 15N 3M A2RE', 20, 8.6, 6.6, 15.2, 'MTCU 15N 3M A2RE');
INSERT INTO obras.maestro_actividades VALUES (1271, 'MTCU 15N 3M JA', 20, 7.2, 5.6, 12.8, 'MTCU 15N 3M JA');
INSERT INTO obras.maestro_actividades VALUES (1272, 'MTCU 15N 3M JI', 20, 7, 5.4, 12.4, 'MTCU 15N 3M JI');
INSERT INTO obras.maestro_actividades VALUES (1273, 'MTCU 15N 3M JIA', 20, 5.9, 4.5, 10.4, 'MTCU 15N 3M JIA');
INSERT INTO obras.maestro_actividades VALUES (1274, 'MTCU 15N 3M JP', 20, 6.5, 5.1, 11.6, 'MTCU 15N 3M JP');
INSERT INTO obras.maestro_actividades VALUES (1275, 'MTCU 15N 3M PC', 20, 2.4, 1.6, 4, 'MTCU 15N 3M PC');
INSERT INTO obras.maestro_actividades VALUES (1276, 'MTCU 15N 3M PCD', 20, 4, 3, 7, 'MTCU 15N 3M PCD');
INSERT INTO obras.maestro_actividades VALUES (1277, 'MTCU 15N 3M PD', 20, 4, 3, 7, 'MTCU 15N 3M PD');
INSERT INTO obras.maestro_actividades VALUES (1278, 'MTCU 15N 3M PS', 20, 2.4, 1.6, 4, 'MTCU 15N 3M PS');
INSERT INTO obras.maestro_actividades VALUES (1279, 'MTCU 15N 3M RS', 20, 4.7, 3.5, 8.2, 'MTCU 15N 3M RS');
INSERT INTO obras.maestro_actividades VALUES (1280, 'MTCU 15N 3M RT', 20, 2.4, 1.6, 4, 'MTCU 15N 3M RT');
INSERT INTO obras.maestro_actividades VALUES (1281, 'MTCU 15N 3P A1TJ', 20, 9.4, 6.3, 15.7, 'MTCU 15N 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1282, 'MTCU 15N 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTCU 15N 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1283, 'MTCU 15N 3P A2PE', 20, 5.5, 3.6, 9.1, 'MTCU 15N 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (1284, 'MTCU 15N 3P A2PES', 20, 5.5, 3.6, 9.1, 'MTCU 15N 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (1285, 'MTCU 15N 3P A2RA', 20, 10.9, 7.4, 18.3, 'MTCU 15N 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (1286, 'MTCU 15N 3P JA', 20, 9.6, 6.5, 16.1, 'MTCU 15N 3P JA');
INSERT INTO obras.maestro_actividades VALUES (1287, 'MTCU 15N 3P JI', 20, 9.4, 6.3, 15.7, 'MTCU 15N 3P JI');
INSERT INTO obras.maestro_actividades VALUES (1288, 'MTCU 15N 3P JIA', 20, 7.7, 5.4, 13.1, 'MTCU 15N 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (1289, 'MTCU 15N 3P JP', 20, 8.3, 5.7, 14, 'MTCU 15N 3P JP');
INSERT INTO obras.maestro_actividades VALUES (1290, 'MTCU 15N 3P PC', 20, 2.4, 1.6, 4, 'MTCU 15N 3P PC');
INSERT INTO obras.maestro_actividades VALUES (1291, 'MTCU 15N 3P PCD', 20, 4, 3, 7, 'MTCU 15N 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (1292, 'MTCU 15N 3P PD', 20, 4, 3, 7, 'MTCU 15N 3P PD');
INSERT INTO obras.maestro_actividades VALUES (1293, 'MTCU 15N 3P PS', 20, 2.4, 1.6, 4, 'MTCU 15N 3P PS');
INSERT INTO obras.maestro_actividades VALUES (1294, 'MTCU 15N 3P RS', 20, 5.9, 4.1, 10, 'MTCU 15N 3P RS');
INSERT INTO obras.maestro_actividades VALUES (1295, 'MTCU 15V 2/3L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 15V 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1296, 'MTCU 15V 2/3L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 15V 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1297, 'MTCU 15V 2/3M A1TE', 20, 5.8, 4.4, 10.2, 'MTCU 15V 2/3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1298, 'MTCU 15V 2/3M A1TES', 20, 6.8, 4.8, 11.6, 'MTCU 15V 2/3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1299, 'MTCU 15V 2L A1TE', 20, 4, 3, 7, 'MTCU 15V 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1300, 'MTCU 15V 2L A1TES', 20, 3.6, 2.6, 6.2, 'MTCU 15V 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1301, 'MTCU 15V 2L A1TJ', 20, 4.2, 3.2, 7.4, 'MTCU 15V 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1302, 'MTCU 15V 2L A1TJS', 20, 3.8, 2.8, 6.6, 'MTCU 15V 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1303, 'MTCU 15V 2L A2PA', 20, 2.5, 1.7, 4.2, 'MTCU 15V 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1304, 'MTCU 15V 2L A2PAS', 20, 2.5, 1.7, 4.2, 'MTCU 15V 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1305, 'MTCU 15V 2L A2PE', 20, 2.5, 1.7, 4.2, 'MTCU 15V 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1306, 'MTCU 15V 2L A2PES', 20, 2.8, 2, 4.8, 'MTCU 15V 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1307, 'MTCU 15V 2L A2RA', 20, 5.4, 3.8, 9.2, 'MTCU 15V 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1308, 'MTCU 15V 2L A2RE', 20, 6.3, 4.7, 11, 'MTCU 15V 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1309, 'MTCU 15V 2L JA', 20, 4.7, 3.5, 8.2, 'MTCU 15V 2L JA');
INSERT INTO obras.maestro_actividades VALUES (1310, 'MTCU 15V 2L JI', 20, 4.2, 3.2, 7.4, 'MTCU 15V 2L JI');
INSERT INTO obras.maestro_actividades VALUES (1311, 'MTCU 15V 2L JP', 20, 7.5, 5.3, 12.8, 'MTCU 15V 2L JP');
INSERT INTO obras.maestro_actividades VALUES (1312, 'MTCU 15V 2L PC', 20, 2.1, 1.3, 3.4, 'MTCU 15V 2L PC');
INSERT INTO obras.maestro_actividades VALUES (1313, 'MTCU 15V 2L PCD', 20, 3.4, 2.4, 5.8, 'MTCU 15V 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (1314, 'MTCU 15V 2L PD', 20, 3.4, 2.4, 5.8, 'MTCU 15V 2L PD');
INSERT INTO obras.maestro_actividades VALUES (1315, 'MTCU 15V 2L PS', 20, 2.1, 1.3, 3.4, 'MTCU 15V 2L PS');
INSERT INTO obras.maestro_actividades VALUES (1316, 'MTCU 15V 2L RS', 20, 2.9, 2.1, 5, 'MTCU 15V 2L RS');
INSERT INTO obras.maestro_actividades VALUES (1317, 'MTCU 15V 2L RT', 20, 2.1, 1.3, 3.4, 'MTCU 15V 2L RT');
INSERT INTO obras.maestro_actividades VALUES (1318, 'MTCU 15V 3/2L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 15V 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1319, 'MTCU 15V 3/2L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 15V 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1320, 'MTCU 15V 3/2L A1TJ', 20, 4.5, 3.5, 8, 'MTCU 15V 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1321, 'MTCU 15V 3/2L A1TJS', 20, 4.1, 3.1, 7.2, 'MTCU 15V 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1322, 'MTCU 15V 3/2L A2RA', 20, 5.7, 4.1, 9.8, 'MTCU 15V 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1323, 'MTCU 15V 3/2L A2RE', 20, 6.6, 5, 11.6, 'MTCU 15V 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1324, 'MTCU 15V 3L A1TE', 20, 4.8, 3.8, 8.6, 'MTCU 15V 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1325, 'MTCU 15V 3L A1TES', 20, 4.2, 3.2, 7.4, 'MTCU 15V 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1326, 'MTCU 15V 3L A1TJ', 20, 5.5, 4.3, 9.8, 'MTCU 15V 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1327, 'MTCU 15V 3L A1TJS ', 20, 4.4, 3.4, 7.8, 'MTCU 15V 3L A1TJS ');
INSERT INTO obras.maestro_actividades VALUES (1328, 'MTCU 15V 3L A2PA', 20, 3, 2.2, 5.2, 'MTCU 15V 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1329, 'MTCU 15V 3L A2PAS', 20, 3, 2.2, 5.2, 'MTCU 15V 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1330, 'MTCU 15V 3L A2PE', 20, 3, 2.2, 5.2, 'MTCU 15V 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1331, 'MTCU 15V 3L A2PES', 20, 3.3, 2.5, 5.8, 'MTCU 15V 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1332, 'MTCU 15V 3L A2RA', 20, 6.2, 4.6, 10.8, 'MTCU 15V 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1333, 'MTCU 15V 3L A2RE', 20, 7.1, 5.5, 12.6, 'MTCU 15V 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1334, 'MTCU 15V 3L JA', 20, 5.7, 4.5, 10.2, 'MTCU 15V 3L JA');
INSERT INTO obras.maestro_actividades VALUES (1335, 'MTCU 15V 3L JI', 20, 5.5, 4.3, 9.8, 'MTCU 15V 3L JI');
INSERT INTO obras.maestro_actividades VALUES (1336, 'MTCU 15V 3L JIA', 20, 4.4, 3.4, 7.8, 'MTCU 15V 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (1337, 'MTCU 15V 3L JP', 20, 6.5, 5.1, 11.6, 'MTCU 15V 3L JP');
INSERT INTO obras.maestro_actividades VALUES (1338, 'MTCU 15V 3L PC', 20, 2.4, 1.6, 4, 'MTCU 15V 3L PC');
INSERT INTO obras.maestro_actividades VALUES (1339, 'MTCU 15V 3L PCD', 20, 4, 3, 7, 'MTCU 15V 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (1340, 'MTCU 15V 3L PD', 20, 4, 3, 7, 'MTCU 15V 3L PD');
INSERT INTO obras.maestro_actividades VALUES (1341, 'MTCU 15V 3L PS', 20, 2.4, 1.6, 4, 'MTCU 15V 3L PS');
INSERT INTO obras.maestro_actividades VALUES (1342, 'MTCU 15V 3L RS', 20, 3.2, 2.4, 5.6, 'MTCU 15V 3L RS');
INSERT INTO obras.maestro_actividades VALUES (1343, 'MTCU 15V 3L RT', 20, 2.4, 1.6, 4, 'MTCU 15V 3L RT');
INSERT INTO obras.maestro_actividades VALUES (1344, 'MTCU 15V 3M A1TE', 20, 6.3, 4.9, 11.2, 'MTCU 15V 3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1345, 'MTCU 15V 3M A1TES', 20, 7.1, 5.1, 12.2, 'MTCU 15V 3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1346, 'MTCU 15V 3M A1TJ', 20, 7, 5.4, 12.4, 'MTCU 15V 3M A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1347, 'MTCU 15V 3M A1TJS', 20, 7.3, 5.3, 12.6, 'MTCU 15V 3M A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1348, 'MTCU 15V 3M A2PA', 20, 3, 2.2, 5.2, 'MTCU 15V 3M A2PA');
INSERT INTO obras.maestro_actividades VALUES (1349, 'MTCU 15V 3M A2PAS', 20, 3, 2.2, 5.2, 'MTCU 15V 3M A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1350, 'MTCU 15V 3M A2PE', 20, 4.3, 3.3, 7.6, 'MTCU 15V 3M A2PE');
INSERT INTO obras.maestro_actividades VALUES (1351, 'MTCU 15V 3M A2PES', 20, 4.3, 3.3, 7.6, 'MTCU 15V 3M A2PES');
INSERT INTO obras.maestro_actividades VALUES (1352, 'MTCU 15V 3M A2RA', 20, 7.7, 5.7, 13.4, 'MTCU 15V 3M A2RA');
INSERT INTO obras.maestro_actividades VALUES (1353, 'MTCU 15V 3M A2RE', 20, 8.6, 6.6, 15.2, 'MTCU 15V 3M A2RE');
INSERT INTO obras.maestro_actividades VALUES (1354, 'MTCU 15V 3M JA', 20, 7.2, 5.6, 12.8, 'MTCU 15V 3M JA');
INSERT INTO obras.maestro_actividades VALUES (1355, 'MTCU 15V 3M JI', 20, 7, 5.4, 12.4, 'MTCU 15V 3M JI');
INSERT INTO obras.maestro_actividades VALUES (1356, 'MTCU 15V 3M JIA', 20, 5.9, 4.5, 10.4, 'MTCU 15V 3M JIA');
INSERT INTO obras.maestro_actividades VALUES (1357, 'MTCU 15V 3M JP', 20, 6.5, 5.1, 11.6, 'MTCU 15V 3M JP');
INSERT INTO obras.maestro_actividades VALUES (1358, 'MTCU 15V 3M PC', 20, 2.4, 1.6, 4, 'MTCU 15V 3M PC');
INSERT INTO obras.maestro_actividades VALUES (1359, 'MTCU 15V 3M PCD', 20, 4, 3, 7, 'MTCU 15V 3M PCD');
INSERT INTO obras.maestro_actividades VALUES (1360, 'MTCU 15V 3M PD', 20, 4, 3, 7, 'MTCU 15V 3M PD');
INSERT INTO obras.maestro_actividades VALUES (1361, 'MTCU 15V 3M PS', 20, 2.4, 1.6, 4, 'MTCU 15V 3M PS');
INSERT INTO obras.maestro_actividades VALUES (1362, 'MTCU 15V 3M RS', 20, 4.7, 3.5, 8.2, 'MTCU 15V 3M RS');
INSERT INTO obras.maestro_actividades VALUES (1363, 'MTCU 15V 3M RT', 20, 2.4, 1.6, 4, 'MTCU 15V 3M RT');
INSERT INTO obras.maestro_actividades VALUES (1364, 'MTCU 15V 3P A1TJ', 20, 9.4, 6.3, 15.7, 'MTCU 15V 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1365, 'MTCU 15V 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTCU 15V 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1366, 'MTCU 15V 3P A2PE', 20, 5.5, 3.6, 9.1, 'MTCU 15V 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (1367, 'MTCU 15V 3P A2PES', 20, 5.5, 3.6, 9.1, 'MTCU 15V 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (1368, 'MTCU 15V 3P A2RA', 20, 10.9, 7.4, 18.3, 'MTCU 15V 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (1369, 'MTCU 15V 3P JA', 20, 9.6, 6.5, 16.1, 'MTCU 15V 3P JA');
INSERT INTO obras.maestro_actividades VALUES (1370, 'MTCU 15V 3P JI', 20, 9.4, 6.3, 15.7, 'MTCU 15V 3P JI');
INSERT INTO obras.maestro_actividades VALUES (1371, 'MTCU 15V 3P JIA', 20, 7.7, 5.4, 13.1, 'MTCU 15V 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (1372, 'MTCU 15V 3P JP', 20, 8.3, 5.7, 14, 'MTCU 15V 3P JP');
INSERT INTO obras.maestro_actividades VALUES (1373, 'MTCU 15V 3P PC', 20, 2.4, 1.6, 4, 'MTCU 15V 3P PC');
INSERT INTO obras.maestro_actividades VALUES (1374, 'MTCU 15V 3P PCD', 20, 4, 3, 7, 'MTCU 15V 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (1375, 'MTCU 15V 3P PD', 20, 4, 3, 7, 'MTCU 15V 3P PD');
INSERT INTO obras.maestro_actividades VALUES (1376, 'MTCU 15V 3P PS', 20, 2.4, 1.6, 4, 'MTCU 15V 3P PS');
INSERT INTO obras.maestro_actividades VALUES (1377, 'MTCU 15V 3P RS', 20, 5.9, 4.1, 10, 'MTCU 15V 3P RS');
INSERT INTO obras.maestro_actividades VALUES (1378, 'MTCU 23N 2/3L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 23N 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1379, 'MTCU 23N 2/3L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 23N 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1380, 'MTCU 23N 2/3M A1TE', 20, 5.8, 4.4, 10.2, 'MTCU 23N 2/3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1381, 'MTCU 23N 2/3M A1TES', 20, 6.8, 4.8, 11.6, 'MTCU 23N 2/3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1382, 'MTCU 23N 2L A1TE', 20, 4, 3, 7, 'MTCU 23N 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1383, 'MTCU 23N 2L A1TES', 20, 3.6, 2.6, 6.2, 'MTCU 23N 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1384, 'MTCU 23N 2L A1TJ', 20, 4.2, 3.2, 7.4, 'MTCU 23N 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1385, 'MTCU 23N 2L A1TJS', 20, 3.8, 2.8, 6.6, 'MTCU 23N 2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1386, 'MTCU 23N 2L A2PA', 20, 2.5, 1.7, 4.2, 'MTCU 23N 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1387, 'MTCU 23N 2L A2PAS', 20, 2.5, 1.7, 4.2, 'MTCU 23N 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1388, 'MTCU 23N 2L A2PE', 20, 2.5, 1.7, 4.2, 'MTCU 23N 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1389, 'MTCU 23N 2L A2PES', 20, 2.8, 2, 4.8, 'MTCU 23N 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1390, 'MTCU 23N 2L A2RA', 20, 5.4, 3.8, 9.2, 'MTCU 23N 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1391, 'MTCU 23N 2L A2RE', 20, 6.3, 4.7, 11, 'MTCU 23N 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1392, 'MTCU 23N 2L JA', 20, 4.7, 3.5, 8.2, 'MTCU 23N 2L JA');
INSERT INTO obras.maestro_actividades VALUES (1393, 'MTCU 23N 2L JI', 20, 4.7, 3.5, 8.2, 'MTCU 23N 2L JI');
INSERT INTO obras.maestro_actividades VALUES (1394, 'MTCU 23N 2L JP', 20, 7.45, 5.55, 13, 'MTCU 23N 2L JP');
INSERT INTO obras.maestro_actividades VALUES (1395, 'MTCU 23N 2L PC', 20, 2.1, 1.3, 3.4, 'MTCU 23N 2L PC');
INSERT INTO obras.maestro_actividades VALUES (1396, 'MTCU 23N 2L PCD', 20, 4.2, 2.6, 6.8, 'MTCU 23N 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (1397, 'MTCU 23N 2L PD', 20, 3.4, 2.4, 5.8, 'MTCU 23N 2L PD');
INSERT INTO obras.maestro_actividades VALUES (1398, 'MTCU 23N 2L PS', 20, 2.1, 1.3, 3.4, 'MTCU 23N 2L PS');
INSERT INTO obras.maestro_actividades VALUES (1399, 'MTCU 23N 2L RS', 20, 2.9, 2.1, 5, 'MTCU 23N 2L RS');
INSERT INTO obras.maestro_actividades VALUES (1400, 'MTCU 23N 2L RT', 20, 2.1, 1.3, 3.4, 'MTCU 23N 2L RT');
INSERT INTO obras.maestro_actividades VALUES (1401, 'MTCU 23N 3/2L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 23N 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1402, 'MTCU 23N 3/2L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 23N 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1403, 'MTCU 23N 3/2L A1TJ', 20, 4.5, 3.5, 8, 'MTCU 23N 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1404, 'MTCU 23N 3/2L A1TJS', 20, 4.1, 3.1, 7.2, 'MTCU 23N 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1405, 'MTCU 23N 3/2L A2RA', 20, 5.7, 4.1, 9.8, 'MTCU 23N 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1406, 'MTCU 23N 3/2L A2RE', 20, 6.6, 5, 11.6, 'MTCU 23N 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1407, 'MTCU 23N 3L A1TE', 20, 4.8, 3.8, 8.6, 'MTCU 23N 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1408, 'MTCU 23N 3L A1TES', 20, 4.2, 3.2, 7.4, 'MTCU 23N 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1409, 'MTCU 23N 3L A1TJ', 20, 5.5, 4.3, 9.8, 'MTCU 23N 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1410, 'MTCU 23N 3L A1TJS', 20, 4.4, 3.4, 7.8, 'MTCU 23N 3L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1411, 'MTCU 23N 3L A2PA', 20, 3, 2.2, 5.2, 'MTCU 23N 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1412, 'MTCU 23N 3L A2PAS', 20, 3, 2.2, 5.2, 'MTCU 23N 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1413, 'MTCU 23N 3L A2PE', 20, 3, 2.2, 5.2, 'MTCU 23N 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1414, 'MTCU 23N 3L A2PES', 20, 3.3, 2.5, 5.8, 'MTCU 23N 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1415, 'MTCU 23N 3L A2RA', 20, 6.2, 4.6, 10.8, 'MTCU 23N 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1416, 'MTCU 23N 3L A2RE', 20, 7.1, 5.5, 12.6, 'MTCU 23N 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1417, 'MTCU 23N 3L JA', 20, 5.7, 4.5, 10.2, 'MTCU 23N 3L JA');
INSERT INTO obras.maestro_actividades VALUES (1418, 'MTCU 23N 3L JI', 20, 5.7, 4.5, 10.2, 'MTCU 23N 3L JI');
INSERT INTO obras.maestro_actividades VALUES (1419, 'MTCU 23N 3L JIA', 20, 4.4, 3.4, 7.8, 'MTCU 23N 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (1420, 'MTCU 23N 3L JP', 20, 8.25, 6.35, 14.6, 'MTCU 23N 3L JP');
INSERT INTO obras.maestro_actividades VALUES (1421, 'MTCU 23N 3L PC', 20, 2.4, 1.6, 4, 'MTCU 23N 3L PC');
INSERT INTO obras.maestro_actividades VALUES (1422, 'MTCU 23N 3L PCD', 20, 4.8, 3.2, 8, 'MTCU 23N 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (1423, 'MTCU 23N 3L PD', 20, 4, 3, 7, 'MTCU 23N 3L PD');
INSERT INTO obras.maestro_actividades VALUES (1424, 'MTCU 23N 3L PS', 20, 2.4, 1.6, 4, 'MTCU 23N 3L PS');
INSERT INTO obras.maestro_actividades VALUES (1425, 'MTCU 23N 3L RS', 20, 3.2, 2.4, 5.6, 'MTCU 23N 3L RS');
INSERT INTO obras.maestro_actividades VALUES (1426, 'MTCU 23N 3L RT', 20, 2.4, 1.6, 4, 'MTCU 23N 3L RT');
INSERT INTO obras.maestro_actividades VALUES (1427, 'MTCU 23N 3M A1TE', 20, 6.3, 4.9, 11.2, 'MTCU 23N 3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1428, 'MTCU 23N 3M A1TES', 20, 7.1, 5.1, 12.2, 'MTCU 23N 3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1429, 'MTCU 23N 3M A1TJ', 20, 7, 5.4, 12.4, 'MTCU 23N 3M A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1430, 'MTCU 23N 3M A1TJS', 20, 7.3, 5.3, 12.6, 'MTCU 23N 3M A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1431, 'MTCU 23N 3M A2PA', 20, 3, 2.2, 5.2, 'MTCU 23N 3M A2PA');
INSERT INTO obras.maestro_actividades VALUES (1432, 'MTCU 23N 3M A2PAS', 20, 3, 2.2, 5.2, 'MTCU 23N 3M A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1433, 'MTCU 23N 3M A2PE', 20, 4.3, 3.3, 7.6, 'MTCU 23N 3M A2PE');
INSERT INTO obras.maestro_actividades VALUES (1434, 'MTCU 23N 3M A2PES', 20, 4.3, 3.3, 7.6, 'MTCU 23N 3M A2PES');
INSERT INTO obras.maestro_actividades VALUES (1435, 'MTCU 23N 3M A2RA', 20, 7.7, 5.7, 13.4, 'MTCU 23N 3M A2RA');
INSERT INTO obras.maestro_actividades VALUES (1436, 'MTCU 23N 3M A2RE', 20, 8.6, 6.6, 15.2, 'MTCU 23N 3M A2RE');
INSERT INTO obras.maestro_actividades VALUES (1437, 'MTCU 23N 3M JA', 20, 7.2, 5.6, 12.8, 'MTCU 23N 3M JA');
INSERT INTO obras.maestro_actividades VALUES (1438, 'MTCU 23N 3M JI', 20, 7.2, 5.6, 12.8, 'MTCU 23N 3M JI');
INSERT INTO obras.maestro_actividades VALUES (1439, 'MTCU 23N 3M JIA', 20, 5.9, 4.5, 10.4, 'MTCU 23N 3M JIA');
INSERT INTO obras.maestro_actividades VALUES (1440, 'MTCU 23N 3M JP', 20, 8.25, 6.35, 14.6, 'MTCU 23N 3M JP');
INSERT INTO obras.maestro_actividades VALUES (1441, 'MTCU 23N 3M PC', 20, 2.4, 1.6, 4, 'MTCU 23N 3M PC');
INSERT INTO obras.maestro_actividades VALUES (1442, 'MTCU 23N 3M PCD', 20, 4.8, 3.2, 8, 'MTCU 23N 3M PCD');
INSERT INTO obras.maestro_actividades VALUES (1443, 'MTCU 23N 3M PD', 20, 3.7, 2.7, 6.4, 'MTCU 23N 3M PD');
INSERT INTO obras.maestro_actividades VALUES (1444, 'MTCU 23N 3M PS', 20, 2.4, 1.6, 4, 'MTCU 23N 3M PS');
INSERT INTO obras.maestro_actividades VALUES (1445, 'MTCU 23N 3M RS', 20, 4.7, 3.5, 8.2, 'MTCU 23N 3M RS');
INSERT INTO obras.maestro_actividades VALUES (1446, 'MTCU 23N 3M RT', 20, 2.4, 1.6, 4, 'MTCU 23N 3M RT');
INSERT INTO obras.maestro_actividades VALUES (1447, 'MTCU 23N 3P A1TJ', 20, 9.4, 6.3, 15.7, 'MTCU 23N 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1448, 'MTCU 23N 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTCU 23N 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1449, 'MTCU 23N 3P A2PE', 20, 5.5, 3.6, 9.1, 'MTCU 23N 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (1450, 'MTCU 23N 3P A2PES', 20, 5.5, 3.6, 9.1, 'MTCU 23N 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (1451, 'MTCU 23N 3P A2RA', 20, 10.9, 7.4, 18.3, 'MTCU 23N 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (1452, 'MTCU 23N 3P A2RE', 20, 10.9, 7.4, 18.3, 'MTCU 23N 3P A2RE');
INSERT INTO obras.maestro_actividades VALUES (1453, 'MTCU 23N 3P JA', 20, 9.6, 6.5, 16.1, 'MTCU 23N 3P JA');
INSERT INTO obras.maestro_actividades VALUES (1454, 'MTCU 23N 3P JI', 20, 9.4, 6.3, 15.7, 'MTCU 23N 3P JI');
INSERT INTO obras.maestro_actividades VALUES (1455, 'MTCU 23N 3P JIA', 20, 7.7, 5.2, 12.9, 'MTCU 23N 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (1456, 'MTCU 23N 3P JP', 20, 9.15, 6.25, 15.4, 'MTCU 23N 3P JP');
INSERT INTO obras.maestro_actividades VALUES (1457, 'MTCU 23N 3P PC', 20, 2.4, 1.6, 4, 'MTCU 23N 3P PC');
INSERT INTO obras.maestro_actividades VALUES (1458, 'MTCU 23N 3P PCD', 20, 4.8, 3.2, 8, 'MTCU 23N 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (1459, 'MTCU 23N 3P PD', 20, 4, 3, 7, 'MTCU 23N 3P PD');
INSERT INTO obras.maestro_actividades VALUES (1460, 'MTCU 23N 3P PS', 20, 2.4, 1.6, 4, 'MTCU 23N 3P PS');
INSERT INTO obras.maestro_actividades VALUES (1461, 'MTCU 23N 3P RS', 20, 5.9, 4.1, 10, 'MTCU 23N 3P RS');
INSERT INTO obras.maestro_actividades VALUES (1462, 'MTCU 23V 2/3L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 23V 2/3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1463, 'MTCU 23V 2/3L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 23V 2/3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1464, 'MTCU 23V 2/3M A1TE', 20, 5.8, 4.4, 10.2, 'MTCU 23V 2/3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1465, 'MTCU 23V 2/3M A1TES', 20, 6.8, 4.8, 11.6, 'MTCU 23V 2/3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1466, 'MTCU 23V 2L A1TE', 20, 4.4, 3.1, 7.5, 'MTCU 23V 2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1467, 'MTCU 23V 2L A1TES', 20, 3.6, 2.6, 6.2, 'MTCU 23V 2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1468, 'MTCU 23V 2L A1TJ', 20, 4.2, 3.2, 7.4, 'MTCU 23V 2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1469, 'MTCU 23V 2L A1TJS ', 20, 3.8, 2.8, 6.6, 'MTCU 23V 2L A1TJS ');
INSERT INTO obras.maestro_actividades VALUES (1470, 'MTCU 23V 2L A2PA', 20, 2.5, 1.7, 4.2, 'MTCU 23V 2L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1471, 'MTCU 23V 2L A2PAS', 20, 2.5, 1.7, 4.2, 'MTCU 23V 2L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1472, 'MTCU 23V 2L A2PE', 20, 2.5, 1.7, 4.2, 'MTCU 23V 2L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1473, 'MTCU 23V 2L A2PES', 20, 2.8, 2, 4.8, 'MTCU 23V 2L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1474, 'MTCU 23V 2L A2RA', 20, 5.4, 3.8, 9.2, 'MTCU 23V 2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1475, 'MTCU 23V 2L A2RE', 20, 6.3, 4.7, 11, 'MTCU 23V 2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1476, 'MTCU 23V 2L JA', 20, 4.7, 3.5, 8.2, 'MTCU 23V 2L JA');
INSERT INTO obras.maestro_actividades VALUES (1477, 'MTCU 23V 2L JI', 20, 4.7, 3.5, 8.2, 'MTCU 23V 2L JI');
INSERT INTO obras.maestro_actividades VALUES (1478, 'MTCU 23V 2L JP', 20, 7.45, 5.55, 13, 'MTCU 23V 2L JP');
INSERT INTO obras.maestro_actividades VALUES (1479, 'MTCU 23V 2L PC', 20, 2.1, 1.3, 3.4, 'MTCU 23V 2L PC');
INSERT INTO obras.maestro_actividades VALUES (1480, 'MTCU 23V 2L PCD', 20, 4.2, 2.6, 6.8, 'MTCU 23V 2L PCD');
INSERT INTO obras.maestro_actividades VALUES (1481, 'MTCU 23V 2L PD', 20, 3.4, 2.4, 5.8, 'MTCU 23V 2L PD');
INSERT INTO obras.maestro_actividades VALUES (1482, 'MTCU 23V 2L PS', 20, 2.1, 1.3, 3.4, 'MTCU 23V 2L PS');
INSERT INTO obras.maestro_actividades VALUES (1483, 'MTCU 23V 2L RS', 20, 2.9, 2.1, 5, 'MTCU 23V 2L RS');
INSERT INTO obras.maestro_actividades VALUES (1484, 'MTCU 23V 2L RT', 20, 2.1, 1.3, 3.4, 'MTCU 23V 2L RT');
INSERT INTO obras.maestro_actividades VALUES (1485, 'MTCU 23V 3/2L A1TE', 20, 4.3, 3.3, 7.6, 'MTCU 23V 3/2L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1486, 'MTCU 23V 3/2L A1TES', 20, 3.9, 2.9, 6.8, 'MTCU 23V 3/2L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1487, 'MTCU 23V 3/2L A1TJ', 20, 4.5, 3.5, 8, 'MTCU 23V 3/2L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1488, 'MTCU 23V 3/2L A1TJS', 20, 4.1, 3.1, 7.2, 'MTCU 23V 3/2L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1489, 'MTCU 23V 3/2L A2RA', 20, 5.7, 4.1, 9.8, 'MTCU 23V 3/2L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1490, 'MTCU 23V 3/2L A2RE', 20, 6.6, 5, 11.6, 'MTCU 23V 3/2L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1491, 'MTCU 23V 3L A1TE', 20, 4.8, 3.8, 8.6, 'MTCU 23V 3L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1492, 'MTCU 23V 3L A1TES', 20, 4.2, 3.2, 7.4, 'MTCU 23V 3L A1TES');
INSERT INTO obras.maestro_actividades VALUES (1493, 'MTCU 23V 3L A1TJ', 20, 5.5, 4.3, 9.8, 'MTCU 23V 3L A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1494, 'MTCU 23V 3L A1TJS', 20, 4.4, 3.4, 7.8, 'MTCU 23V 3L A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1495, 'MTCU 23V 3L A2PA', 20, 3, 2.2, 5.2, 'MTCU 23V 3L A2PA');
INSERT INTO obras.maestro_actividades VALUES (1496, 'MTCU 23V 3L A2PAS', 20, 3, 2.2, 5.2, 'MTCU 23V 3L A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1497, 'MTCU 23V 3L A2PE', 20, 3, 2.2, 5.2, 'MTCU 23V 3L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1498, 'MTCU 23V 3L A2PES', 20, 3.3, 2.5, 5.8, 'MTCU 23V 3L A2PES');
INSERT INTO obras.maestro_actividades VALUES (1499, 'MTCU 23V 3L A2RA', 20, 6.2, 4.6, 10.8, 'MTCU 23V 3L A2RA');
INSERT INTO obras.maestro_actividades VALUES (1500, 'MTCU 23V 3L A2RE', 20, 7.1, 5.5, 12.6, 'MTCU 23V 3L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1501, 'MTCU 23V 3L JA', 20, 5.7, 4.5, 10.2, 'MTCU 23V 3L JA');
INSERT INTO obras.maestro_actividades VALUES (1502, 'MTCU 23V 3L JI', 20, 5.5, 4.3, 9.8, 'MTCU 23V 3L JI');
INSERT INTO obras.maestro_actividades VALUES (1503, 'MTCU 23V 3L JIA', 20, 4.4, 3.4, 7.8, 'MTCU 23V 3L JIA');
INSERT INTO obras.maestro_actividades VALUES (1504, 'MTCU 23V 3L JP', 20, 7.35, 5.65, 13, 'MTCU 23V 3L JP');
INSERT INTO obras.maestro_actividades VALUES (1505, 'MTCU 23V 3L PC', 20, 2.4, 1.6, 4, 'MTCU 23V 3L PC');
INSERT INTO obras.maestro_actividades VALUES (1506, 'MTCU 23V 3L PCD', 20, 4.8, 3.2, 8, 'MTCU 23V 3L PCD');
INSERT INTO obras.maestro_actividades VALUES (1507, 'MTCU 23V 3L PD', 20, 4, 3, 7, 'MTCU 23V 3L PD');
INSERT INTO obras.maestro_actividades VALUES (1508, 'MTCU 23V 3L PS', 20, 2.4, 1.6, 4, 'MTCU 23V 3L PS');
INSERT INTO obras.maestro_actividades VALUES (1509, 'MTCU 23V 3L RS', 20, 3.2, 2.4, 5.6, 'MTCU 23V 3L RS');
INSERT INTO obras.maestro_actividades VALUES (1510, 'MTCU 23V 3L RT', 20, 2.4, 1.6, 4, 'MTCU 23V 3L RT');
INSERT INTO obras.maestro_actividades VALUES (1511, 'MTCU 23V 3M A1TE', 20, 6.3, 4.9, 11.2, 'MTCU 23V 3M A1TE');
INSERT INTO obras.maestro_actividades VALUES (1512, 'MTCU 23V 3M A1TES', 20, 7.1, 5.1, 12.2, 'MTCU 23V 3M A1TES');
INSERT INTO obras.maestro_actividades VALUES (1513, 'MTCU 23V 3M A1TJ', 20, 7, 5.4, 12.4, 'MTCU 23V 3M A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1514, 'MTCU 23V 3M A1TJS', 20, 7.3, 5.3, 12.6, 'MTCU 23V 3M A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1515, 'MTCU 23V 3M A2PA', 20, 3, 2.2, 5.2, 'MTCU 23V 3M A2PA');
INSERT INTO obras.maestro_actividades VALUES (1516, 'MTCU 23V 3M A2PAS', 20, 3, 2.2, 5.2, 'MTCU 23V 3M A2PAS');
INSERT INTO obras.maestro_actividades VALUES (1517, 'MTCU 23V 3M A2PE', 20, 4.3, 3.3, 7.6, 'MTCU 23V 3M A2PE');
INSERT INTO obras.maestro_actividades VALUES (1518, 'MTCU 23V 3M A2PES', 20, 4.3, 3.3, 7.6, 'MTCU 23V 3M A2PES');
INSERT INTO obras.maestro_actividades VALUES (1519, 'MTCU 23V 3M A2RA', 20, 7.7, 5.7, 13.4, 'MTCU 23V 3M A2RA');
INSERT INTO obras.maestro_actividades VALUES (1520, 'MTCU 23V 3M A2RE', 20, 8.6, 6.6, 15.2, 'MTCU 23V 3M A2RE');
INSERT INTO obras.maestro_actividades VALUES (1521, 'MTCU 23V 3M JA', 20, 7.2, 5.6, 12.8, 'MTCU 23V 3M JA');
INSERT INTO obras.maestro_actividades VALUES (1522, 'MTCU 23V 3M JI', 20, 7, 5.4, 12.4, 'MTCU 23V 3M JI');
INSERT INTO obras.maestro_actividades VALUES (1523, 'MTCU 23V 3M JIA', 20, 5.9, 4.5, 10.4, 'MTCU 23V 3M JIA');
INSERT INTO obras.maestro_actividades VALUES (1524, 'MTCU 23V 3M JP', 20, 7.35, 5.65, 13, 'MTCU 23V 3M JP');
INSERT INTO obras.maestro_actividades VALUES (1525, 'MTCU 23V 3M PC', 20, 2.4, 1.6, 4, 'MTCU 23V 3M PC');
INSERT INTO obras.maestro_actividades VALUES (1526, 'MTCU 23V 3M PCD', 20, 4.8, 3.2, 8, 'MTCU 23V 3M PCD');
INSERT INTO obras.maestro_actividades VALUES (1527, 'MTCU 23V 3M PD', 20, 4, 3, 7, 'MTCU 23V 3M PD');
INSERT INTO obras.maestro_actividades VALUES (1528, 'MTCU 23V 3M PS', 20, 2.4, 1.6, 4, 'MTCU 23V 3M PS');
INSERT INTO obras.maestro_actividades VALUES (1529, 'MTCU 23V 3M RS', 20, 4.7, 3.5, 8.2, 'MTCU 23V 3M RS');
INSERT INTO obras.maestro_actividades VALUES (1530, 'MTCU 23V 3M RT', 20, 2.4, 1.6, 4, 'MTCU 23V 3M RT');
INSERT INTO obras.maestro_actividades VALUES (1531, 'MTCU 23V 3P A1TJ', 20, 9.4, 6.3, 15.7, 'MTCU 23V 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1532, 'MTCU 23V 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTCU 23V 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1533, 'MTCU 23V 3P A2PE', 20, 5.5, 3.6, 9.1, 'MTCU 23V 3P A2PE');
INSERT INTO obras.maestro_actividades VALUES (1534, 'MTCU 23V 3P A2PES', 20, 5.5, 3.6, 9.1, 'MTCU 23V 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (1535, 'MTCU 23V 3P A2RA', 20, 10.9, 7.4, 18.3, 'MTCU 23V 3P A2RA');
INSERT INTO obras.maestro_actividades VALUES (1536, 'MTCU 23V 3P JA', 20, 9.6, 6.5, 16.1, 'MTCU 23V 3P JA');
INSERT INTO obras.maestro_actividades VALUES (1537, 'MTCU 23V 3P JI', 20, 9.4, 6.3, 15.7, 'MTCU 23V 3P JI');
INSERT INTO obras.maestro_actividades VALUES (1538, 'MTCU 23V 3P JIA', 20, 7.7, 5.4, 13.1, 'MTCU 23V 3P JIA');
INSERT INTO obras.maestro_actividades VALUES (1539, 'MTCU 23V 3P JP', 20, 9.15, 6.25, 15.4, 'MTCU 23V 3P JP');
INSERT INTO obras.maestro_actividades VALUES (1540, 'MTCU 23V 3P PC', 20, 2.4, 1.6, 4, 'MTCU 23V 3P PC');
INSERT INTO obras.maestro_actividades VALUES (1541, 'MTCU 23V 3P PCD', 20, 4.8, 3.2, 8, 'MTCU 23V 3P PCD');
INSERT INTO obras.maestro_actividades VALUES (1542, 'MTCU 23V 3P PD', 20, 4, 3, 7, 'MTCU 23V 3P PD');
INSERT INTO obras.maestro_actividades VALUES (1543, 'MTCU 23V 3P PS', 20, 2.4, 1.6, 4, 'MTCU 23V 3P PS');
INSERT INTO obras.maestro_actividades VALUES (1544, 'MTCU 23V 3P RS', 20, 5.9, 4.1, 10, 'MTCU 23V 3P RS');
INSERT INTO obras.maestro_actividades VALUES (1545, 'MTCU 3F Portal PD', 20, 5, 3, 8, 'MTCU 3F Portal PD');
INSERT INTO obras.maestro_actividades VALUES (1546, 'MTCU 3F Portal PS', 20, 3, 2, 5, 'MTCU 3F Portal PS');
INSERT INTO obras.maestro_actividades VALUES (1547, 'MTCU 3F Portal PS 6m', 20, 3, 2, 5, 'MTCU 3F Portal PS 6m');
INSERT INTO obras.maestro_actividades VALUES (1548, 'MTProt 15N 2 A1TJ ne', 20, 5, 3.3, 8.3, 'MTProt 15N 2 A1TJ ne');
INSERT INTO obras.maestro_actividades VALUES (1549, 'MTProt 15N 2 A2PEJ', 20, 4.6, 3.3, 7.9, 'MTProt 15N 2 A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1550, 'MTProt 15N 2 A2PES', 20, 2.4, 1.6, 4, 'MTProt 15N 2 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1551, 'MTProt 15N 2 JA', 20, 5.5, 3.6, 9.1, 'MTProt 15N 2 JA');
INSERT INTO obras.maestro_actividades VALUES (1552, 'MTProt 15N 2 JI', 20, 5.9, 3.7, 9.6, 'MTProt 15N 2 JI');
INSERT INTO obras.maestro_actividades VALUES (1553, 'MTProt 15N 2 PC', 20, 2.1, 1.3, 3.4, 'MTProt 15N 2 PC');
INSERT INTO obras.maestro_actividades VALUES (1554, 'MTProt 15N 2 PCD', 20, 3.6, 2.3, 5.9, 'MTProt 15N 2 PCD');
INSERT INTO obras.maestro_actividades VALUES (1555, 'MTProt 15N 2 PD', 20, 3.6, 2.3, 5.9, 'MTProt 15N 2 PD');
INSERT INTO obras.maestro_actividades VALUES (1556, 'MTProt 15N 2 PS', 20, 2.1, 1.3, 3.4, 'MTProt 15N 2 PS');
INSERT INTO obras.maestro_actividades VALUES (1557, 'MTProt 15N 2 RS', 20, 3.3, 2.2, 5.5, 'MTProt 15N 2 RS');
INSERT INTO obras.maestro_actividades VALUES (1558, 'MTProt 15N 3 A1TJ', 20, 6.5, 4.4, 10.9, 'MTProt 15N 3 A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1559, 'MTProt 15N 3 A2PEJ', 20, 4.6, 3.3, 7.9, 'MTProt 15N 3 A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1560, 'MTProt 15N 3 A2PES', 20, 2.7, 1.9, 4.6, 'MTProt 15N 3 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1561, 'MTProt 15N 3 JA', 20, 6.7, 4.6, 11.3, 'MTProt 15N 3 JA');
INSERT INTO obras.maestro_actividades VALUES (1562, 'MTProt 15N 3 JI', 20, 7.1, 4.7, 11.8, 'MTProt 15N 3 JI');
INSERT INTO obras.maestro_actividades VALUES (1563, 'MTProt 15N 3 PA', 20, 3.7, 2.8, 6.5, 'MTProt 15N 3 PA');
INSERT INTO obras.maestro_actividades VALUES (1564, 'MTProt 15N 3 PC', 20, 2.4, 1.6, 4, 'MTProt 15N 3 PC');
INSERT INTO obras.maestro_actividades VALUES (1565, 'MTProt 15N 3 PCD', 20, 3.7, 2.8, 6.5, 'MTProt 15N 3 PCD');
INSERT INTO obras.maestro_actividades VALUES (1566, 'MTProt 15N 3 PD', 20, 3.7, 2.8, 6.5, 'MTProt 15N 3 PD');
INSERT INTO obras.maestro_actividades VALUES (1567, 'MTProt 15N 3 PS', 20, 2.4, 1.6, 4, 'MTProt 15N 3 PS');
INSERT INTO obras.maestro_actividades VALUES (1568, 'MTProt 15N 3 RS', 20, 3.6, 2.5, 6.1, 'MTProt 15N 3 RS');
INSERT INTO obras.maestro_actividades VALUES (1569, 'MTProt 15N 3M A1TJ', 20, 7, 5.4, 12.4, 'MTProt 15N 3M A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1570, 'MTProt 15N 3P A1TJ', 20, 8.5, 6, 14.5, 'MTProt 15N 3P A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1571, 'MTProt 15N 3P A1TJS', 20, 9.1, 6.2, 15.3, 'MTProt 15N 3P A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1572, 'MTProt 15N 3P A2PES', 20, 4.6, 3.3, 7.9, 'MTProt 15N 3P A2PES');
INSERT INTO obras.maestro_actividades VALUES (1573, 'MTProt 15N 3P JI', 20, 8.5, 6, 14.5, 'MTProt 15N 3P JI');
INSERT INTO obras.maestro_actividades VALUES (1574, 'MTProt 15N 3P RS', 20, 8, 6, 14, 'MTProt 15N 3P RS');
INSERT INTO obras.maestro_actividades VALUES (1575, 'MTProt 15V 2 JI', 20, 5.9, 3.7, 9.6, 'MTProt 15V 2 JI');
INSERT INTO obras.maestro_actividades VALUES (1576, 'MTProt 15V 2 PC', 20, 2.1, 1.3, 3.4, 'MTProt 15V 2 PC');
INSERT INTO obras.maestro_actividades VALUES (1577, 'MTProt 15V 2 PCD', 20, 3.6, 2.3, 5.9, 'MTProt 15V 2 PCD');
INSERT INTO obras.maestro_actividades VALUES (1578, 'MTProt 15V 2 PD ', 20, 3.6, 2.3, 5.9, 'MTProt 15V 2 PD ');
INSERT INTO obras.maestro_actividades VALUES (1579, 'MTProt 15V 2 PS', 20, 2.1, 1.3, 3.4, 'MTProt 15V 2 PS');
INSERT INTO obras.maestro_actividades VALUES (1580, 'MTProt 15V 2 RS', 20, 3.3, 2.2, 5.5, 'MTProt 15V 2 RS');
INSERT INTO obras.maestro_actividades VALUES (1581, 'MTProt 15V 3 JI', 20, 7.1, 4.7, 11.8, 'MTProt 15V 3 JI');
INSERT INTO obras.maestro_actividades VALUES (1582, 'MTProt 15V 3 PC', 20, 2.4, 1.6, 4, 'MTProt 15V 3 PC');
INSERT INTO obras.maestro_actividades VALUES (1583, 'MTProt 15V 3 PCD', 20, 3.7, 2.8, 6.5, 'MTProt 15V 3 PCD');
INSERT INTO obras.maestro_actividades VALUES (1584, 'MTProt 15V 3 PD', 20, 3.7, 2.8, 6.5, 'MTProt 15V 3 PD');
INSERT INTO obras.maestro_actividades VALUES (1585, 'MTProt 15V 3 PS', 20, 2.4, 1.6, 4, 'MTProt 15V 3 PS');
INSERT INTO obras.maestro_actividades VALUES (1586, 'MTProt 15V 3 RS', 20, 3.6, 2.5, 6.1, 'MTProt 15V 3 RS');
INSERT INTO obras.maestro_actividades VALUES (1587, 'MTProt 23N 2 A1TJ', 20, 5, 3.3, 8.3, 'MTProt 23N 2 A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1588, 'MTProt 23N 2 A1TJS', 20, 7.3, 5.3, 12.6, 'MTProt 23N 2 A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1589, 'MTProt 23N 2 A2PEJ', 20, 4.6, 3.3, 7.9, 'MTProt 23N 2 A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1590, 'MTProt 23N 2 A2PES', 20, 2.4, 1.6, 4, 'MTProt 23N 2 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1591, 'MTProt 23N 2 A2RE', 20, 7.4, 5.5, 12.9, 'MTProt 23N 2 A2RE');
INSERT INTO obras.maestro_actividades VALUES (1592, 'MTProt 23N 2 JA', 20, 5.5, 3.6, 9.1, 'MTProt 23N 2 JA');
INSERT INTO obras.maestro_actividades VALUES (1593, 'MTProt 23N 2 JI', 20, 5.9, 3.7, 9.6, 'MTProt 23N 2 JI');
INSERT INTO obras.maestro_actividades VALUES (1594, 'MTProt 23N 2 PC', 20, 2.1, 1.3, 3.4, 'MTProt 23N 2 PC');
INSERT INTO obras.maestro_actividades VALUES (1595, 'MTProt 23N 2 PCD', 20, 3.6, 2.3, 5.9, 'MTProt 23N 2 PCD');
INSERT INTO obras.maestro_actividades VALUES (1596, 'MTProt 23N 2 PD', 20, 3.6, 2.3, 5.9, 'MTProt 23N 2 PD');
INSERT INTO obras.maestro_actividades VALUES (1597, 'MTProt 23N 2 PS', 20, 2.1, 1.3, 3.4, 'MTProt 23N 2 PS');
INSERT INTO obras.maestro_actividades VALUES (1598, 'MTProt 23N 2 RS', 20, 3.3, 2.2, 5.5, 'MTProt 23N 2 RS');
INSERT INTO obras.maestro_actividades VALUES (1599, 'MTProt 23N 3 A1TJ', 20, 6.5, 4.4, 10.9, 'MTProt 23N 3 A1TJ');
INSERT INTO obras.maestro_actividades VALUES (1600, 'MTProt 23V 3L A1TJ 1,2', 20, 6.5, 4.4, 10.9, 'MTProt 23V 3L A1TJ 1,2');
INSERT INTO obras.maestro_actividades VALUES (1601, 'MTProt 23N 3 A1TJS', 20, 7.3, 5.3, 12.6, 'MTProt 23N 3 A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1602, 'MTProt 23V 3 A1TJS', 20, 7.3, 5.3, 12.6, 'MTProt 23V 3 A1TJS');
INSERT INTO obras.maestro_actividades VALUES (1603, 'MTProt 23N 3 A2PEJ', 20, 4.6, 3.3, 7.9, 'MTProt 23N 3 A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1604, 'MTProt 23N 3 A2PES', 20, 2.7, 1.9, 4.6, 'MTProt 23N 3 A2PES');
INSERT INTO obras.maestro_actividades VALUES (1605, 'MTProt 23N 3 A2RE', 20, 7.4, 5.5, 12.9, 'MTProt 23N 3 A2RE');
INSERT INTO obras.maestro_actividades VALUES (1606, 'MTProt 23V 3L A2RE 1,2', 20, 7.4, 5.5, 12.9, 'MTProt 23V 3L A2RE 1,2');
INSERT INTO obras.maestro_actividades VALUES (1607, 'MTProt 23N 3 JA', 20, 6.7, 4.6, 11.3, 'MTProt 23N 3 JA');
INSERT INTO obras.maestro_actividades VALUES (1608, 'MTProt 23N 3 JI', 20, 7.1, 4.7, 11.8, 'MTProt 23N 3 JI');
INSERT INTO obras.maestro_actividades VALUES (1609, 'MTProt 23N 3 PC', 20, 2.4, 1.6, 4, 'MTProt 23N 3 PC');
INSERT INTO obras.maestro_actividades VALUES (1610, 'MTProt 23N 3 PCD', 20, 3.7, 2.8, 6.5, 'MTProt 23N 3 PCD');
INSERT INTO obras.maestro_actividades VALUES (1611, 'MTProt 23N 3 PD', 20, 3.7, 2.8, 6.5, 'MTProt 23N 3 PD');
INSERT INTO obras.maestro_actividades VALUES (1612, 'MTProt 23N 3 PS', 20, 2.4, 1.6, 4, 'MTProt 23N 3 PS');
INSERT INTO obras.maestro_actividades VALUES (1613, 'MTProt 23N 3 RS', 20, 3.6, 2.5, 6.1, 'MTProt 23N 3 RS');
INSERT INTO obras.maestro_actividades VALUES (1614, 'MTProt 23V 2 JI', 20, 5.9, 3.7, 9.6, 'MTProt 23V 2 JI');
INSERT INTO obras.maestro_actividades VALUES (1615, 'MTProt 23V 2 PC', 20, 2.1, 1.3, 3.4, 'MTProt 23V 2 PC');
INSERT INTO obras.maestro_actividades VALUES (1616, 'MTProt 23V 2 PCD', 20, 3.6, 2.3, 5.9, 'MTProt 23V 2 PCD');
INSERT INTO obras.maestro_actividades VALUES (1617, 'MTProt 23V 2 PD', 20, 3.6, 2.3, 5.9, 'MTProt 23V 2 PD');
INSERT INTO obras.maestro_actividades VALUES (1618, 'MTProt 23V 2 PS', 20, 2.1, 1.3, 3.4, 'MTProt 23V 2 PS');
INSERT INTO obras.maestro_actividades VALUES (1619, 'MTProt 23V 2 RS', 20, 3.3, 2.2, 5.5, 'MTProt 23V 2 RS');
INSERT INTO obras.maestro_actividades VALUES (1620, 'MTProt 23V 3 JI', 20, 7.1, 4.7, 11.8, 'MTProt 23V 3 JI');
INSERT INTO obras.maestro_actividades VALUES (1621, 'MTProt 23V 3l JI 1,2', 20, 7.1, 4.7, 11.8, 'MTProt 23V 3l JI 1,2');
INSERT INTO obras.maestro_actividades VALUES (1622, 'MTProt 23V 3 PC', 20, 2.4, 1.6, 4, 'MTProt 23V 3 PC');
INSERT INTO obras.maestro_actividades VALUES (1623, 'MTProt 23V 3 PCD', 20, 3.7, 2.8, 6.5, 'MTProt 23V 3 PCD');
INSERT INTO obras.maestro_actividades VALUES (1624, 'MTProt 23V 3 PD', 20, 3.7, 2.8, 6.5, 'MTProt 23V 3 PD');
INSERT INTO obras.maestro_actividades VALUES (1625, 'MTProt 23V 3 PS', 20, 2.4, 1.6, 4, 'MTProt 23V 3 PS');
INSERT INTO obras.maestro_actividades VALUES (1626, 'MTProt 23V 3L PS 1,2', 20, 2.4, 1.6, 4, 'MTProt 23V 3L PS 1,2');
INSERT INTO obras.maestro_actividades VALUES (1627, 'MTProt 23V 3 RS', 20, 3.6, 2.5, 6.1, 'MTProt 23V 3 RS');
INSERT INTO obras.maestro_actividades VALUES (1628, 'MTProt 23V 3L RS 1,2', 20, 3.6, 2.5, 6.1, 'MTProt 23V 3L RS 1,2');
INSERT INTO obras.maestro_actividades VALUES (1629, 'MTAL 15N 1L A1TE', 20, 1.2, 0.84, 2.04, 'MTAL 15N 1L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1630, 'MTAL 15N 1L A1TE N2', 20, 1.2, 0.84, 2.04, 'MTAL 15N 1L A1TE N2');
INSERT INTO obras.maestro_actividades VALUES (1631, 'MTAL 15N 1L A2PE', 20, 0.4, 0.28, 0.68, 'MTAL 15N 1L A2PE');
INSERT INTO obras.maestro_actividades VALUES (1632, 'MTAL 15N 1L A2PEJ', 20, 0.7, 0.49, 1.19, 'MTAL 15N 1L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1633, 'MTAL 15N 1L A2RE', 20, 1, 0.7, 1.7, 'MTAL 15N 1L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1634, 'MTAL 15N 1L JA', 20, 1.6, 1.12, 2.72, 'MTAL 15N 1L JA');
INSERT INTO obras.maestro_actividades VALUES (1635, 'MTAL 15N 1L JI', 20, 1.4, 0.98, 2.38, 'MTAL 15N 1L JI');
INSERT INTO obras.maestro_actividades VALUES (1636, 'MTAL 15N 1L JI', 20, 1.4, 0.98, 2.38, 'MTAL 15N 1L JI');
INSERT INTO obras.maestro_actividades VALUES (1637, 'MTAL 15N 1L PC N2', 20, 0.4, 0.28, 0.68, 'MTAL 15N 1L PC N2');
INSERT INTO obras.maestro_actividades VALUES (1638, 'MTAL 15N 1L PCD N2', 20, 1.1, 0.77, 1.87, 'MTAL 15N 1L PCD N2');
INSERT INTO obras.maestro_actividades VALUES (1639, 'MTAL 15N 1L PD N2', 20, 1.1, 0.77, 1.87, 'MTAL 15N 1L PD N2');
INSERT INTO obras.maestro_actividades VALUES (1640, 'MTAL 15N 1L PS N2', 20, 0.6, 0.42, 1.02, 'MTAL 15N 1L PS N2');
INSERT INTO obras.maestro_actividades VALUES (1641, 'MTAL 15N 1L PS PP N2', 20, 1, 0.7, 1.7, 'MTAL 15N 1L PS PP N2');
INSERT INTO obras.maestro_actividades VALUES (1642, 'MTAL 15N 1L RS', 20, 0.8, 0.56, 1.36, 'MTAL 15N 1L RS');
INSERT INTO obras.maestro_actividades VALUES (1643, 'MTAL 15N 1L RT', 20, 0.4, 0.28, 0.68, 'MTAL 15N 1L RT');
INSERT INTO obras.maestro_actividades VALUES (1644, 'MTAL 15V 1L A2PEJ', 20, 0.7, 0.49, 1.19, 'MTAL 15V 1L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1645, 'MTAL 15V 1L A2RE', 20, 1, 0.7, 1.7, 'MTAL 15V 1L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1646, 'MTAL 15V 1L JA', 20, 1.6, 1.12, 2.72, 'MTAL 15V 1L JA');
INSERT INTO obras.maestro_actividades VALUES (1647, 'MTAL 15V 1L PS', 20, 0.6, 0.42, 1.02, 'MTAL 15V 1L PS');
INSERT INTO obras.maestro_actividades VALUES (1648, 'MTAL 15V 1L RS', 20, 0.8, 0.56, 1.36, 'MTAL 15V 1L RS');
INSERT INTO obras.maestro_actividades VALUES (1649, 'MTAL 23N 1L A2PEJ', 20, 0.7, 0.49, 1.19, 'MTAL 23N 1L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1650, 'MTAL 23N 1L A2RE', 20, 1, 0.7, 1.7, 'MTAL 23N 1L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1651, 'MTAL 23N 1L JA', 20, 1.6, 1.12, 2.72, 'MTAL 23N 1L JA');
INSERT INTO obras.maestro_actividades VALUES (1652, 'MTAL 23N 1L JI', 20, 1.4, 0.98, 2.38, 'MTAL 23N 1L JI');
INSERT INTO obras.maestro_actividades VALUES (1653, 'MTAL 23N 1L PD', 20, 1.1, 0.77, 1.87, 'MTAL 23N 1L PD');
INSERT INTO obras.maestro_actividades VALUES (1654, 'MTAL 23N 1L PS', 20, 0.6, 0.42, 1.02, 'MTAL 23N 1L PS');
INSERT INTO obras.maestro_actividades VALUES (1655, 'MTAL 23N 1L RS', 20, 0.8, 0.56, 1.36, 'MTAL 23N 1L RS');
INSERT INTO obras.maestro_actividades VALUES (1656, 'MTAL 23V 1L A2PEJ', 20, 0.7, 0.49, 1.19, 'MTAL 23V 1L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1657, 'MTAL 23V 1L A2RE', 20, 1, 0.7, 1.7, 'MTAL 23V 1L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1658, 'MTAL 23V 1L JA', 20, 1.6, 1.12, 2.72, 'MTAL 23V 1L JA');
INSERT INTO obras.maestro_actividades VALUES (1659, 'MTAL 23V 1L PD', 20, 1.1, 0.77, 1.87, 'MTAL 23V 1L PD');
INSERT INTO obras.maestro_actividades VALUES (1660, 'MTAL 23V 1L PS', 20, 0.6, 0.42, 1.02, 'MTAL 23V 1L PS');
INSERT INTO obras.maestro_actividades VALUES (1661, 'MTAL 23V 1L RS', 20, 0.8, 0.56, 1.36, 'MTAL 23V 1L RS');
INSERT INTO obras.maestro_actividades VALUES (1662, 'MTCU 23N 1L A2PEJ', 20, 0.7, 0.49, 1.19, 'MTCU 23N 1L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1663, 'MTCU 23N 1L A2RE', 20, 1, 0.77, 1.77, 'MTCU 23N 1L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1664, 'MTCU 23N 1L JA', 20, 1.6, 1.12, 2.72, 'MTCU 23N 1L JA');
INSERT INTO obras.maestro_actividades VALUES (1665, 'MTCU 23N 1L JI', 20, 1.4, 0.98, 2.38, 'MTCU 23N 1L JI');
INSERT INTO obras.maestro_actividades VALUES (1666, 'MTCU 15N 1L A1TE', 20, 1.4, 0.98, 2.38, 'MTCU 15N 1L A1TE');
INSERT INTO obras.maestro_actividades VALUES (1667, 'MTCU 23N 1L PD', 20, 1.1, 0.77, 1.87, 'MTCU 23N 1L PD');
INSERT INTO obras.maestro_actividades VALUES (1668, 'MTCU 15N 1L PS', 20, 0.6, 0.42, 1.02, 'MTCU 15N 1L PS');
INSERT INTO obras.maestro_actividades VALUES (1669, 'MTCU 23N 1L PS', 20, 0.6, 0.42, 1.02, 'MTCU 23N 1L PS');
INSERT INTO obras.maestro_actividades VALUES (1670, 'MTCU 23N 1L RS', 20, 0.8, 0.56, 1.36, 'MTCU 23N 1L RS');
INSERT INTO obras.maestro_actividades VALUES (1671, 'MTCU 23V 1L A2PEJ', 20, 0.7, 0.49, 1.19, 'MTCU 23V 1L A2PEJ');
INSERT INTO obras.maestro_actividades VALUES (1672, 'MTCU 23V 1L A2RE', 20, 1, 0.77, 1.77, 'MTCU 23V 1L A2RE');
INSERT INTO obras.maestro_actividades VALUES (1673, 'MTCU 23V 1L JI', 20, 1.4, 0.98, 2.38, 'MTCU 23V 1L JI');
INSERT INTO obras.maestro_actividades VALUES (1674, 'MTCU 15N 1L PD', 20, 1.1, 0.77, 1.87, 'MTCU 15N 1L PD');
INSERT INTO obras.maestro_actividades VALUES (1675, 'MTCU 23V 1L PD', 20, 1.1, 0.77, 1.87, 'MTCU 23V 1L PD');
INSERT INTO obras.maestro_actividades VALUES (1676, 'MTProt 23N 1L PS', 20, 0.6, 0.42, 1.02, 'MTProt 23N 1L PS');
INSERT INTO obras.maestro_actividades VALUES (1677, 'MTCU 23V 1L PS', 20, 0.6, 0.42, 1.02, 'MTCU 23V 1L PS');
INSERT INTO obras.maestro_actividades VALUES (1678, 'MTCU 15N 1L RS', 20, 0.8, 0.56, 1.36, 'MTCU 15N 1L RS');
INSERT INTO obras.maestro_actividades VALUES (1679, 'MTCU 23V 1L RS', 20, 0.8, 0.56, 1.36, 'MTCU 23V 1L RS');
INSERT INTO obras.maestro_actividades VALUES (1680, 'MTProt 23V 1L RS', 20, 0.8, 0.56, 1.36, 'MTProt 23V 1L RS');
INSERT INTO obras.maestro_actividades VALUES (1681, 'Espaciador CO 15kv', 20, 1, 0.7, 1.7, 'Espaciador CO 15kv');
INSERT INTO obras.maestro_actividades VALUES (1682, 'Espaciador CO 25kv', 20, 1, 0.7, 1.7, 'Espaciador CO 25kv');
INSERT INTO obras.maestro_actividades VALUES (1683, 'Estribo TT 1Ø', 20, 1, 0.7, 1.7, 'Estribo TT 1Ø');
INSERT INTO obras.maestro_actividades VALUES (1684, 'Estribo TT 2Ø', 20, 2, 1.4, 3.4, 'Estribo TT 2Ø');
INSERT INTO obras.maestro_actividades VALUES (1685, 'Estribo TT 3Ø', 20, 3, 2.1, 5.1, 'Estribo TT 3Ø');
INSERT INTO obras.maestro_actividades VALUES (1686, 'Prensa 1489 2ø ', 20, 0.3, 0.3, 0.6, 'Prensa 1489 2ø ');
INSERT INTO obras.maestro_actividades VALUES (1687, ' Prensa 1489 3ø ', 20, 0.4, 0.4, 0.8, ' Prensa 1489 3ø ');
INSERT INTO obras.maestro_actividades VALUES (1688, ' Prensa 1506 2ø ', 20, 0.3, 0.3, 0.6, ' Prensa 1506 2ø ');
INSERT INTO obras.maestro_actividades VALUES (1689, ' Prensa 1506 3ø ', 20, 0.4, 0.4, 0.8, ' Prensa 1506 3ø ');
INSERT INTO obras.maestro_actividades VALUES (1690, ' Prensa 502 2ø', 20, 0.3, 0.3, 0.6, ' Prensa 502 2ø');
INSERT INTO obras.maestro_actividades VALUES (1691, ' Prensa 502 3ø', 20, 0.4, 0.4, 0.8, ' Prensa 502 3ø');
INSERT INTO obras.maestro_actividades VALUES (1692, ' MBT 1C  ', 21, 0.8, 0.5, 1.3, ' MBT 1C  ');
INSERT INTO obras.maestro_actividades VALUES (1693, ' Malla BT 1C MBT 2C ', 21, 1.2, 0.9, 2.1, ' Malla BT 1C MBT 2C ');
INSERT INTO obras.maestro_actividades VALUES (1694, ' Malla BT 2C MBT 3C ', 21, 2, 1.4, 3.4, ' Malla BT 2C MBT 3C ');
INSERT INTO obras.maestro_actividades VALUES (1695, ' Malla BT 3C MBT 4C ', 21, 2.7, 1.9, 4.6, ' Malla BT 3C MBT 4C ');
INSERT INTO obras.maestro_actividades VALUES (1696, ' Malla BT 4C MBT Abierta 1C ', 21, 1.6, 1.1, 2.7, ' Malla BT 4C MBT Abierta 1C ');
INSERT INTO obras.maestro_actividades VALUES (1697, ' Malla BT Abierta 1C MBT Abierta 2C ', 21, 2.2, 1.5, 3.7, ' Malla BT Abierta 1C MBT Abierta 2C ');
INSERT INTO obras.maestro_actividades VALUES (1698, ' Malla BT Abierta 2C MBT Abierta 3C ', 21, 2.7, 1.9, 4.6, ' Malla BT Abierta 2C MBT Abierta 3C ');
INSERT INTO obras.maestro_actividades VALUES (1699, ' Malla BT Abierta 3C MBT Abierta 4C ', 21, 3.2, 2.2, 5.4, ' Malla BT Abierta 3C MBT Abierta 4C ');
INSERT INTO obras.maestro_actividades VALUES (1700, ' Malla BT Abierta 4C MMT 2ø Al L ', 21, 3.6, 2.5, 6.1, ' Malla BT Abierta 4C MMT 2ø Al L ');
INSERT INTO obras.maestro_actividades VALUES (1701, ' MT 2ø Al Liviana MMT 2ø Cu L ', 21, 3.6, 2.5, 6.1, ' MT 2ø Al Liviana MMT 2ø Cu L ');
INSERT INTO obras.maestro_actividades VALUES (1702, ' MT 2ø Cu Liviana MMT 2ø Cu M ', 21, 3.6, 2.5, 6.1, ' MT 2ø Cu Liviana MMT 2ø Cu M ');
INSERT INTO obras.maestro_actividades VALUES (1703, ' MT 2ø Cu Mediana MMT 2ø Cu Al', 21, 3.6, 2.5, 6.1, ' MT 2ø Cu Mediana MMT 2ø Cu Al');
INSERT INTO obras.maestro_actividades VALUES (1704, ' MT 2ø CuAl MMT 3ø Al L ', 21, 5.4, 3.7, 9.1, ' MT 2ø CuAl MMT 3ø Al L ');
INSERT INTO obras.maestro_actividades VALUES (1705, ' MT 3ø Al Liviana MMT 3ø Co ', 21, 6, 4, 10, ' MT 3ø Al Liviana MMT 3ø Co ');
INSERT INTO obras.maestro_actividades VALUES (1706, ' MT 3ø para red compacta MMT 3ø Cu L ', 21, 5.4, 3.7, 9.1, ' MT 3ø para red compacta MMT 3ø Cu L ');
INSERT INTO obras.maestro_actividades VALUES (1707, ' MT 3ø Cu Liviana MMT 3ø Cu M ', 21, 5.4, 3.7, 9.1, ' MT 3ø Cu Liviana MMT 3ø Cu M ');
INSERT INTO obras.maestro_actividades VALUES (1708, ' MT 3ø Cu Mediana MMT 3ø Cu P ', 21, 5.4, 3.7, 9.1, ' MT 3ø Cu Mediana MMT 3ø Cu P ');
INSERT INTO obras.maestro_actividades VALUES (1709, ' MT 3ø Cu Pesada MMT 3ø CuAl ', 21, 5.4, 3.7, 9.1, ' MT 3ø Cu Pesada MMT 3ø CuAl ');
INSERT INTO obras.maestro_actividades VALUES (1710, ' MT 3ø CuAl MMT 3ø P Co ', 21, 6, 4, 10, ' MT 3ø CuAl MMT 3ø P Co ');
INSERT INTO obras.maestro_actividades VALUES (1711, 'P MOZO', 22, 8.4, 5.2, 13.6, 'P MOZO');
INSERT INTO obras.maestro_actividades VALUES (1712, 'PC  8.0 m', 22, 9.8, 6.1, 15.9, 'PC  8.0 m');
INSERT INTO obras.maestro_actividades VALUES (1713, 'PC  9.0 m', 22, 10.4, 6.6, 17, 'PC  9.0 m');
INSERT INTO obras.maestro_actividades VALUES (1714, 'PC  9.5 m', 22, 10.4, 6.6, 17, 'PC  9.5 m');
INSERT INTO obras.maestro_actividades VALUES (1715, 'PC 10.0 m', 22, 11.8, 7.6, 19.4, 'PC 10.0 m');
INSERT INTO obras.maestro_actividades VALUES (1716, 'PC 11.5 m', 22, 14.5, 9.4, 23.9, 'PC 11.5 m');
INSERT INTO obras.maestro_actividades VALUES (1717, 'PC 13.5 m', 22, 19.6, 13.7, 33.3, 'PC 13.5 m');
INSERT INTO obras.maestro_actividades VALUES (1718, 'PC 15.0 m', 22, 25.3, 17, 42.3, 'PC 15.0 m');
INSERT INTO obras.maestro_actividades VALUES (1719, 'PC 16.5 m', 22, 25.9, 18.3, 44.2, 'PC 16.5 m');
INSERT INTO obras.maestro_actividades VALUES (1720, 'PC 18.0 m', 22, 26.7, 18.7, 45.4, 'PC 18.0 m');
INSERT INTO obras.maestro_actividades VALUES (1721, 'PC 15.0 m C', 22, 18.7, 17, 35.7, 'PC 15.0 m C');
INSERT INTO obras.maestro_actividades VALUES (1722, 'PMadera 8m', 22, 12.5, 9.1, 21.6, 'PMadera 8m');
INSERT INTO obras.maestro_actividades VALUES (1723, 'PMadera 9m', 22, 13.5, 9.3, 22.8, 'PMadera 9m');
INSERT INTO obras.maestro_actividades VALUES (1724, 'PMadera 10m', 22, 14.5, 9.4, 23.9, 'PMadera 10m');
INSERT INTO obras.maestro_actividades VALUES (1725, 'TBT M', 23, 4.7, 3.4, 8.1, 'TBT M');
INSERT INTO obras.maestro_actividades VALUES (1726, 'TBT S', 23, 9.4, 2.5, 11.9, 'TBT S');
INSERT INTO obras.maestro_actividades VALUES (1727, 'TMT D', 23, 18, 5, 23, 'TMT D');
INSERT INTO obras.maestro_actividades VALUES (1728, 'TMT D2', 23, 37, 10, 47, 'TMT D2');
INSERT INTO obras.maestro_actividades VALUES (1729, 'TMT L', 23, 9, 2.5, 11.5, 'TMT L');
INSERT INTO obras.maestro_actividades VALUES (1730, 'TMT M', 23, 4.7, 3.4, 8.1, 'TMT M');
INSERT INTO obras.maestro_actividades VALUES (1731, 'TMT S', 23, 9.4, 2.5, 11.9, 'TMT S');
INSERT INTO obras.maestro_actividades VALUES (1732, 'TT 1E P', 24, 7.3, 5.11, 9.49, 'TT 1E P');
INSERT INTO obras.maestro_actividades VALUES (1733, 'TT para Caja Empalme', 24, 0.4, 0.3, 0.5, 'TT para Caja Empalme');
INSERT INTO obras.maestro_actividades VALUES (1734, 'PMount 23 desde 500k', 25, 28.3, 19.9, 48.2, 'PMount 23 desde 500k');
INSERT INTO obras.maestro_actividades VALUES (1735, 'PMount 23 hasta 500k', 25, 28.3, 19.9, 48.2, 'PMount 23 hasta 500k');
INSERT INTO obras.maestro_actividades VALUES (1736, 'PMount desde 500kVA', 25, 28.3, 19.9, 48.2, 'PMount desde 500kVA');
INSERT INTO obras.maestro_actividades VALUES (1737, 'PMount hasta 500kVA', 25, 28.3, 19.9, 48.2, 'PMount hasta 500kVA');
INSERT INTO obras.maestro_actividades VALUES (1738, 'TRS 15 300-', 25, 28.3, 19.9, 48.2, 'TRS 15 300-');
INSERT INTO obras.maestro_actividades VALUES (1739, 'TRS 23 300-', 25, 28.3, 19.9, 48.2, 'TRS 23 300-');
INSERT INTO obras.maestro_actividades VALUES (1740, 'TMC 2ø 15KV', 26, 13.5, 9.4, 22.9, 'TMC 2ø 15KV');
INSERT INTO obras.maestro_actividades VALUES (1741, 'TRA 15 2F 03-25KVA', 26, 13.5, 9.4, 22.9, 'TRA 15 2F 03-25KVA');
INSERT INTO obras.maestro_actividades VALUES (1742, 'TRA 15 3F 150-', 26, 28.3, 19.9, 48.2, 'TRA 15 3F 150-');
INSERT INTO obras.maestro_actividades VALUES (1743, 'TRA 15 3F 10-112KVA', 26, 13.5, 9.4, 22.9, 'TRA 15 3F 10-112KVA');
INSERT INTO obras.maestro_actividades VALUES (1744, 'TRA 23 2F 03-25KVA', 26, 13.5, 9.4, 22.9, 'TRA 23 2F 03-25KVA');
INSERT INTO obras.maestro_actividades VALUES (1745, 'TT 1E S', 24, 7.3, 0, 7.3, 'TT 1E S');
INSERT INTO obras.maestro_actividades VALUES (1746, 'TMC 3ø 15KV', 26, 13.5, 9.4, 22.9, 'TMC 3ø 15KV');
INSERT INTO obras.maestro_actividades VALUES (1747, 'TRA 23 3F 10-112KVA', 26, 13.5, 9.4, 22.9, 'TRA 23 3F 10-112KVA');
INSERT INTO obras.maestro_actividades VALUES (1748, 'TRA 23 3F 150-', 26, 28.3, 19.9, 48.2, 'TRA 23 3F 150-');
INSERT INTO obras.maestro_actividades VALUES (1749, 'TT 1E S Pre', 24, 7.3, 0, 7.3, 'TT 1E S Pre');
INSERT INTO obras.maestro_actividades VALUES (1750, 'TT 2E P', 24, 13.4, 0, 13.4, 'TT 2E P');
INSERT INTO obras.maestro_actividades VALUES (1751, 'TT 2E S', 24, 13.4, 0, 13.4, 'TT 2E S');
INSERT INTO obras.maestro_actividades VALUES (1752, 'TT 2E S Pre', 24, 13.4, 0, 13.4, 'TT 2E S Pre');
INSERT INTO obras.maestro_actividades VALUES (1753, 'TT 3E P', 24, 19.5, 0, 19.5, 'TT 3E P');
INSERT INTO obras.maestro_actividades VALUES (1754, 'TT 3E S', 24, 19.5, 0, 19.5, 'TT 3E S');
INSERT INTO obras.maestro_actividades VALUES (1755, 'TT 3E S Pre', 24, 19.5, 0, 19.5, 'TT 3E S Pre');
INSERT INTO obras.maestro_actividades VALUES (1756, 'TT M2E P', 24, 17.8, 0, 17.8, 'TT M2E P');
INSERT INTO obras.maestro_actividades VALUES (1757, 'TT M2E S', 24, 17.8, 0, 17.8, 'TT M2E S');
INSERT INTO obras.maestro_actividades VALUES (1758, 'TT M2E S Pre', 24, 17.8, 0, 17.8, 'TT M2E S Pre');
INSERT INTO obras.maestro_actividades VALUES (1759, 'TT MD P', 24, 14.2, 0, 14.2, 'TT MD P');
INSERT INTO obras.maestro_actividades VALUES (1760, 'TT MD S', 24, 14.2, 0, 14.2, 'TT MD S');
INSERT INTO obras.maestro_actividades VALUES (1761, 'TT MD S Pre', 24, 14.2, 0, 14.2, 'TT MD S Pre');
INSERT INTO obras.maestro_actividades VALUES (1762, 'TT MS P', 24, 9.2, 0, 9.2, 'TT MS P');
INSERT INTO obras.maestro_actividades VALUES (1763, 'TT MS S', 24, 9.2, 0, 9.2, 'TT MS S');
INSERT INTO obras.maestro_actividades VALUES (1764, 'TT MS S Pre', 24, 9.2, 0, 9.2, 'TT MS S Pre');
INSERT INTO obras.maestro_actividades VALUES (1765, ' MT 3ø Pesada p/red compacta', 21, 0, 0, 0, ' MT 3ø Pesada p/red compacta');


--
-- TOC entry 3852 (class 0 OID 386167)
-- Dependencies: 285
-- Data for Name: maestro_estructura; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.maestro_estructura VALUES (1, 'BARRA SE1PC 2*5C', 'BARRA SE1PC 2*5C');
INSERT INTO obras.maestro_estructura VALUES (2, 'BARRA SE1PC 3C', 'BARRA SE1PC 3C');
INSERT INTO obras.maestro_estructura VALUES (3, 'BARRA SE1PC 4C', 'BARRA SE1PC 4C');
INSERT INTO obras.maestro_estructura VALUES (4, 'BARRA SE1PC 5C', 'BARRA SE1PC 5C');
INSERT INTO obras.maestro_estructura VALUES (5, 'BARRA SE2PC', 'BARRA SE2PC');
INSERT INTO obras.maestro_estructura VALUES (6, 'MONT TRAF 1PC', 'MONT TRAF 1PC');
INSERT INTO obras.maestro_estructura VALUES (7, 'MONT TRAF 2PC', 'MONT TRAF 2PC');
INSERT INTO obras.maestro_estructura VALUES (8, 'MT SE1PC 2F', 'MT SE1PC 2F');
INSERT INTO obras.maestro_estructura VALUES (9, 'MT SE1PC 2F S1P', 'MT SE1PC 2F S1P');
INSERT INTO obras.maestro_estructura VALUES (10, 'MT SE1PC 2F S2P', 'MT SE1PC 2F S2P');
INSERT INTO obras.maestro_estructura VALUES (11, 'MT SE1PC 3F', 'MT SE1PC 3F');
INSERT INTO obras.maestro_estructura VALUES (12, 'MT SE1PC 3F S1P', 'MT SE1PC 3F S1P');
INSERT INTO obras.maestro_estructura VALUES (13, 'MT SE1PC 3F S2P', 'MT SE1PC 3F S2P');
INSERT INTO obras.maestro_estructura VALUES (14, 'MT SE2PC 15C', 'MT SE2PC 15C');
INSERT INTO obras.maestro_estructura VALUES (15, 'MT SE2PC 15C S', 'MT SE2PC 15C S');
INSERT INTO obras.maestro_estructura VALUES (16, 'MT SE2PC 15N', 'MT SE2PC 15N');
INSERT INTO obras.maestro_estructura VALUES (17, 'MT SE2PC 15N S', 'MT SE2PC 15N S');
INSERT INTO obras.maestro_estructura VALUES (18, 'MT SE2PC 23V', 'MT SE2PC 23V');
INSERT INTO obras.maestro_estructura VALUES (19, 'MT SE2PC 23V S', 'MT SE2PC 23V S');
INSERT INTO obras.maestro_estructura VALUES (20, 'MT SE2PC 23N', 'MT SE2PC 23N');
INSERT INTO obras.maestro_estructura VALUES (21, 'MT SE2PC 23N S', 'MT SE2PC 23N S');
INSERT INTO obras.maestro_estructura VALUES (22, 'MTAL 15N 2L A1TE', 'MTAL 15N 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (23, 'MTAL 15N 2L A1TES', 'MTAL 15N 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (24, 'MTAL 15N 2L A1TJ', 'MTAL 15N 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (25, 'MTAL 15N 2L A1TJS', 'MTAL 15N 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (26, 'MTAL 15N 2L A2PA', 'MTAL 15N 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (27, 'MTAL 15N 2L A2PAS', 'MTAL 15N 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (28, 'MTAL 15N 2L A2PE', 'MTAL 15N 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (29, 'MTAL 15N 2L A2PEJ', 'MTAL 15N 2L A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (30, 'MTAL 15N 2L A2PEJS', 'MTAL 15N 2L A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (31, 'MTAL 15N 2L A2PES', 'MTAL 15N 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (32, 'MTAL 15N 2L A2RA', 'MTAL 15N 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (33, 'MTAL 15N 2L A2RE', 'MTAL 15N 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (34, 'MTAL 15N 2L JA', 'MTAL 15N 2L JA');
INSERT INTO obras.maestro_estructura VALUES (35, 'MTAL 15N 2L JI', 'MTAL 15N 2L JI');
INSERT INTO obras.maestro_estructura VALUES (36, 'MTAL 15N 2L PD', 'MTAL 15N 2L PD');
INSERT INTO obras.maestro_estructura VALUES (37, 'MTAL 15N 2L PS', 'MTAL 15N 2L PS');
INSERT INTO obras.maestro_estructura VALUES (38, 'MTAL 15N 2L RS', 'MTAL 15N 2L RS');
INSERT INTO obras.maestro_estructura VALUES (39, 'MTAL 15N 2L RT', 'MTAL 15N 2L RT');
INSERT INTO obras.maestro_estructura VALUES (40, 'MTAL 15N 3L A1TE', 'MTAL 15N 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (41, 'MTAL 15N 3L A1TES', 'MTAL 15N 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (42, 'MTAL 15N 3L A1TJ', 'MTAL 15N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (43, 'MTAL 15N 3L A1TJS', 'MTAL 15N 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (44, 'MTAL 15N 3L A2PA', 'MTAL 15N 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (45, 'MTAL 15N 3L A2PAS', 'MTAL 15N 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (46, 'MTAL 15N 3L A2PE', 'MTAL 15N 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (47, 'MTAL 15N 3P A2PE', 'MTAL 15N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (48, 'MTAL 15N 3P A2PES', 'MTAL 15N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (49, 'MTAL 15N 3L A2PES', 'MTAL 15N 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (50, 'MTAL 15N 3L A2RA', 'MTAL 15N 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (51, 'MTAL 15N 3L A2RE', 'MTAL 15N 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (52, 'MTAL 15N 3L JA', 'MTAL 15N 3L JA');
INSERT INTO obras.maestro_estructura VALUES (53, 'MTAL 15N 3L JI', 'MTAL 15N 3L JI');
INSERT INTO obras.maestro_estructura VALUES (54, 'MTAL 15N 3L PD', 'MTAL 15N 3L PD');
INSERT INTO obras.maestro_estructura VALUES (55, 'MTAL 15N 3L PS', 'MTAL 15N 3L PS');
INSERT INTO obras.maestro_estructura VALUES (56, 'MTAL 15N 3L RS', 'MTAL 15N 3L RS');
INSERT INTO obras.maestro_estructura VALUES (57, 'MTAL 15N 3L RT', 'MTAL 15N 3L RT');
INSERT INTO obras.maestro_estructura VALUES (58, 'MTAL 15N 3P A1TJ', 'MTAL 15N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (59, 'MTAL 15N 3P A1TJS', 'MTAL 15N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (60, 'MTAL 15N 3P A2PA', 'MTAL 15N 3P A2PA');
INSERT INTO obras.maestro_estructura VALUES (61, 'MTAL 15N 3P A2PAS', 'MTAL 15N 3P A2PAS');
INSERT INTO obras.maestro_estructura VALUES (62, 'MTAL 15N 3P A2PE', 'MTAL 15N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (63, 'MTAL 15N 3P A2PES', 'MTAL 15N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (64, 'MTAL 15N 3P A2RA', 'MTAL 15N 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (65, 'MTAL 15N 3P JA', 'MTAL 15N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (66, 'MTAL 15N 3P JI', 'MTAL 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (67, 'MTAL 15N 3P PD', 'MTAL 15N 3P PD');
INSERT INTO obras.maestro_estructura VALUES (68, 'MTAL 15N 3P PS', 'MTAL 15N 3P PS');
INSERT INTO obras.maestro_estructura VALUES (69, 'MTAL 15N 3P RS', 'MTAL 15N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (70, 'MTAL 15N 3P RT', 'MTAL 15N 3P RT');
INSERT INTO obras.maestro_estructura VALUES (71, 'MTAL 15V 2L A1TE', 'MTAL 15V 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (72, 'MTAL 15V 2L A1TES', 'MTAL 15V 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (73, 'MTAL 15V 2L A1TJ', 'MTAL 15V 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (74, 'MTAL 15V 2L A1TJS', 'MTAL 15V 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (75, 'MTAL 15V 2L A2PA', 'MTAL 15V 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (76, 'MTAL 15V 2L A2PAS', 'MTAL 15V 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (77, 'MTAL 15V 2L A2PE', 'MTAL 15V 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (78, 'MTAL 15V 2L A2PEJ', 'MTAL 15V 2L A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (79, 'MTAL 15V 2L A2PEJS', 'MTAL 15V 2L A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (80, 'MTAL 15V 2L A2PES', 'MTAL 15V 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (81, 'MTAL 15V 2L A2RA', 'MTAL 15V 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (82, 'MTAL 15V 2L A2RE', 'MTAL 15V 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (83, 'MTAL 15V 2L JA', 'MTAL 15V 2L JA');
INSERT INTO obras.maestro_estructura VALUES (84, 'MTAL 15V 2L JI', 'MTAL 15V 2L JI');
INSERT INTO obras.maestro_estructura VALUES (85, 'MTAL 15V 2L PD', 'MTAL 15V 2L PD');
INSERT INTO obras.maestro_estructura VALUES (86, 'MTAL 15V 2L PS', 'MTAL 15V 2L PS');
INSERT INTO obras.maestro_estructura VALUES (87, 'MTAL 15V 2L RS', 'MTAL 15V 2L RS');
INSERT INTO obras.maestro_estructura VALUES (88, 'MTAL 15V 2L RT', 'MTAL 15V 2L RT');
INSERT INTO obras.maestro_estructura VALUES (89, 'MTAL 15V 3L A1TE', 'MTAL 15V 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (90, 'MTAL 15V 3L A1TES', 'MTAL 15V 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (91, 'MTAL 15V 3L A1TJ', 'MTAL 15V 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (92, 'MTAL 15V 3L A1TJS', 'MTAL 15V 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (93, 'MTAL 15V 3L A2PA', 'MTAL 15V 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (94, 'MTAL 15V 3L A2PAS', 'MTAL 15V 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (95, 'MTAL 15V 3L A2PE', 'MTAL 15V 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (96, 'MTAL 15V 3P A2PE', 'MTAL 15V 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (97, 'MTAL 15V 3P A2PES', 'MTAL 15V 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (98, 'MTAL 15V 3L A2PES', 'MTAL 15V 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (99, 'MTAL 15V 3L A2RA', 'MTAL 15V 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (100, 'MTAL 15V 3L A2RE', 'MTAL 15V 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (101, 'MTAL 15V 3L JA', 'MTAL 15V 3L JA');
INSERT INTO obras.maestro_estructura VALUES (102, 'MTAL 15V 3L JI', 'MTAL 15V 3L JI');
INSERT INTO obras.maestro_estructura VALUES (103, 'MTAL 15V 3L PD', 'MTAL 15V 3L PD');
INSERT INTO obras.maestro_estructura VALUES (104, 'MTAL 15V 3L PS', 'MTAL 15V 3L PS');
INSERT INTO obras.maestro_estructura VALUES (105, 'MTAL 15V 3L RS', 'MTAL 15V 3L RS');
INSERT INTO obras.maestro_estructura VALUES (106, 'MTAL 15V 3L RT', 'MTAL 15V 3L RT');
INSERT INTO obras.maestro_estructura VALUES (107, 'MTAL 15V 3P A1TJ', 'MTAL 15V 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (108, 'MTAL 15V 3P A1TJS', 'MTAL 15V 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (109, 'MTAL 15V 3P A2PA', 'MTAL 15V 3P A2PA');
INSERT INTO obras.maestro_estructura VALUES (110, 'MTAL 15V 3P A2PAS', 'MTAL 15V 3P A2PAS');
INSERT INTO obras.maestro_estructura VALUES (111, 'MTAL 15V 3P A2RA', 'MTAL 15V 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (112, 'MTAL 15V 3P JA', 'MTAL 15V 3P JA');
INSERT INTO obras.maestro_estructura VALUES (113, 'MTAL 15V 3P JI', 'MTAL 15V 3P JI');
INSERT INTO obras.maestro_estructura VALUES (114, 'MTAL 15V 3P PD', 'MTAL 15V 3P PD');
INSERT INTO obras.maestro_estructura VALUES (115, 'MTAL 15V 3P PS', 'MTAL 15V 3P PS');
INSERT INTO obras.maestro_estructura VALUES (116, 'MTAL 15V 3P RS', 'MTAL 15V 3P RS');
INSERT INTO obras.maestro_estructura VALUES (117, 'MTAL 15V 3P RT', 'MTAL 15V 3P RT');
INSERT INTO obras.maestro_estructura VALUES (118, 'MTAL 23N 2L A1TE', 'MTAL 23N 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (119, 'MTAL 23N 2L A1TES', 'MTAL 23N 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (120, 'MTAL 23N 2L A1TJ', 'MTAL 23N 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (121, 'MTAL 23N 2L A1TJS', 'MTAL 23N 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (122, 'MTAL 23N 2L A2PA', 'MTAL 23N 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (123, 'MTAL 23N 2L A2PAS', 'MTAL 23N 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (124, 'MTAL 23N 2L A2PE', 'MTAL 23N 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (125, 'MTAL 23N 2L A2PEJ', 'MTAL 23N 2L A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (126, 'MTAL 23N 2L A2PEJS', 'MTAL 23N 2L A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (127, 'MTAL 23N 2L A2PES', 'MTAL 23N 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (128, 'MTAL 23N 2L A2RA', 'MTAL 23N 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (129, 'MTAL 23N 2L A2RE', 'MTAL 23N 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (130, 'MTAL 23N 2L JA', 'MTAL 23N 2L JA');
INSERT INTO obras.maestro_estructura VALUES (131, 'MTAL 23N 2L JI', 'MTAL 23N 2L JI');
INSERT INTO obras.maestro_estructura VALUES (132, 'MTAL 23N 2L PD', 'MTAL 23N 2L PD');
INSERT INTO obras.maestro_estructura VALUES (133, 'MTAL 23N 2L PS', 'MTAL 23N 2L PS');
INSERT INTO obras.maestro_estructura VALUES (134, 'MTAL 23N 2L RS', 'MTAL 23N 2L RS');
INSERT INTO obras.maestro_estructura VALUES (135, 'MTAL 23N 2L RT', 'MTAL 23N 2L RT');
INSERT INTO obras.maestro_estructura VALUES (136, 'MTAL 23N 3L A1TE', 'MTAL 23N 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (137, 'MTAL 23N 3L A1TES', 'MTAL 23N 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (138, 'MTAL 23N 3L A1TJ', 'MTAL 23N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (139, 'MTAL 23N 3L A1TJS', 'MTAL 23N 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (140, 'MTAL 23N 3L A2PA', 'MTAL 23N 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (141, 'MTAL 23N 3L A2PAS', 'MTAL 23N 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (142, 'MTAL 23N 3L A2PE', 'MTAL 23N 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (143, 'MTAL 23N 3P A2PE', 'MTAL 23N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (144, 'MTAL 23N 3P A2PES', 'MTAL 23N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (145, 'MTAL 23N 3L A2PES', 'MTAL 23N 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (146, 'MTAL 23N 3L A2RA', 'MTAL 23N 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (147, 'MTAL 23N 3L A2RE', 'MTAL 23N 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (148, 'MTAL 23N 3L JA', 'MTAL 23N 3L JA');
INSERT INTO obras.maestro_estructura VALUES (149, 'MTAL 23N 3L JI', 'MTAL 23N 3L JI');
INSERT INTO obras.maestro_estructura VALUES (150, 'MTAL 23N 3L PD', 'MTAL 23N 3L PD');
INSERT INTO obras.maestro_estructura VALUES (151, 'MTAL 23N 3L PS', 'MTAL 23N 3L PS');
INSERT INTO obras.maestro_estructura VALUES (152, 'MTAL 23N 3L RS', 'MTAL 23N 3L RS');
INSERT INTO obras.maestro_estructura VALUES (153, 'MTAL 23N 3L RT', 'MTAL 23N 3L RT');
INSERT INTO obras.maestro_estructura VALUES (154, 'MTAL 23N 3P A1TJ', 'MTAL 23N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (155, 'MTAL 23N 3P A1TJS', 'MTAL 23N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (156, 'MTAL 23N 3P A2PA', 'MTAL 23N 3P A2PA');
INSERT INTO obras.maestro_estructura VALUES (157, 'MTAL 23N 3P A2PAS', 'MTAL 23N 3P A2PAS');
INSERT INTO obras.maestro_estructura VALUES (158, 'MTAL 23N 3P A2PES', 'MTAL 23N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (159, 'MTAL 23N 3P A2RA', 'MTAL 23N 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (160, 'MTAL 23N 3P JA', 'MTAL 23N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (161, 'MTAL 23N 3P JI', 'MTAL 23N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (162, 'MTAL 23N 3P PD', 'MTAL 23N 3P PD');
INSERT INTO obras.maestro_estructura VALUES (163, 'MTAL 23N 3P PS', 'MTAL 23N 3P PS');
INSERT INTO obras.maestro_estructura VALUES (164, 'MTAL 23N 3P RS', 'MTAL 23N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (165, 'MTAL 23N 3P RT', 'MTAL 23N 3P RT');
INSERT INTO obras.maestro_estructura VALUES (166, 'MTAL 23V 2L A1TE', 'MTAL 23V 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (167, 'MTAL 23V 2L A1TES', 'MTAL 23V 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (168, 'MTAL 23V 2L A1TJ', 'MTAL 23V 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (169, 'MTAL 23V 2L A1TJS', 'MTAL 23V 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (170, 'MTAL 23V 2L A2PA', 'MTAL 23V 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (171, 'MTAL 23V 2L A2PAS', 'MTAL 23V 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (172, 'MTAL 23V 2L A2PE', 'MTAL 23V 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (173, 'MTAL 23V 2L A2PEJ', 'MTAL 23V 2L A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (174, 'MTAL 23V 2L A2PEJS', 'MTAL 23V 2L A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (175, 'MTAL 23V 2L A2PES', 'MTAL 23V 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (176, 'MTAL 23V 2L A2RA', 'MTAL 23V 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (177, 'MTAL 23V 2L A2RE', 'MTAL 23V 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (178, 'MTAL 23V 2L JA', 'MTAL 23V 2L JA');
INSERT INTO obras.maestro_estructura VALUES (179, 'MTAL 23V 2L JI', 'MTAL 23V 2L JI');
INSERT INTO obras.maestro_estructura VALUES (180, 'MTAL 23V 2L PD', 'MTAL 23V 2L PD');
INSERT INTO obras.maestro_estructura VALUES (181, 'MTAL 23V 2L PS', 'MTAL 23V 2L PS');
INSERT INTO obras.maestro_estructura VALUES (182, 'MTAL 23V 2L RS', 'MTAL 23V 2L RS');
INSERT INTO obras.maestro_estructura VALUES (183, 'MTAL 23V 2L RT', 'MTAL 23V 2L RT');
INSERT INTO obras.maestro_estructura VALUES (184, 'MTAL 23V 3L A1TE', 'MTAL 23V 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (185, 'MTAL 23V 3L A1TES', 'MTAL 23V 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (186, 'MTAL 23V 3L A1TJ', 'MTAL 23V 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (187, 'MTAL 23V 3L A1TJS', 'MTAL 23V 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (188, 'MTAL 23V 3L A2PA', 'MTAL 23V 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (189, 'MTAL 23V 3L A2PAS', 'MTAL 23V 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (190, 'MTAL 23V 3L A2PE', 'MTAL 23V 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (191, 'MTAL 23V 3P A2PE', 'MTAL 23V 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (192, 'MTAL 23V 3P A2PES', 'MTAL 23V 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (193, 'MTAL 23V 3L A2PES', 'MTAL 23V 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (194, 'MTAL 23V 3L A2RA', 'MTAL 23V 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (195, 'MTAL 23V 3L A2RE', 'MTAL 23V 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (196, 'MTAL 23V 3L JA', 'MTAL 23V 3L JA');
INSERT INTO obras.maestro_estructura VALUES (197, 'MTAL 23V 3L JI', 'MTAL 23V 3L JI');
INSERT INTO obras.maestro_estructura VALUES (198, 'MTAL 23V 3L PD', 'MTAL 23V 3L PD');
INSERT INTO obras.maestro_estructura VALUES (199, 'MTAL 23V 3L PS', 'MTAL 23V 3L PS');
INSERT INTO obras.maestro_estructura VALUES (200, 'MTAL 23V 3L RS', 'MTAL 23V 3L RS');
INSERT INTO obras.maestro_estructura VALUES (201, 'MTAL 23V 3L RT', 'MTAL 23V 3L RT');
INSERT INTO obras.maestro_estructura VALUES (202, 'MTAL 23V 3P A1TJ', 'MTAL 23V 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (203, 'MTAL 23V 3P A1TJS', 'MTAL 23V 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (204, 'MTAL 23V 3P A2PA', 'MTAL 23V 3P A2PA');
INSERT INTO obras.maestro_estructura VALUES (205, 'MTAL 23V 3P A2PAS', 'MTAL 23V 3P A2PAS');
INSERT INTO obras.maestro_estructura VALUES (206, 'MTAL 23V 3P A2RA', 'MTAL 23V 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (207, 'MTAL 23V 3P JA', 'MTAL 23V 3P JA');
INSERT INTO obras.maestro_estructura VALUES (208, 'MTAL 23V 3P JI', 'MTAL 23V 3P JI');
INSERT INTO obras.maestro_estructura VALUES (209, 'MTAL 23V 3P PD', 'MTAL 23V 3P PD');
INSERT INTO obras.maestro_estructura VALUES (210, 'MTAL 23V 3P PS', 'MTAL 23V 3P PS');
INSERT INTO obras.maestro_estructura VALUES (211, 'MTAL 23V 3P RS', 'MTAL 23V 3P RS');
INSERT INTO obras.maestro_estructura VALUES (212, 'MTAL 23V 3P RT', 'MTAL 23V 3P RT');
INSERT INTO obras.maestro_estructura VALUES (213, 'MTCU 15C 2L A1TE', 'MTCU 15C 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (214, 'MTCU 15C 2L A1TES', 'MTCU 15C 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (215, 'MTCU 15C 2L A1TJ', 'MTCU 15C 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (216, 'MTCU 15C 2L A1TJS', 'MTCU 15C 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (217, 'MTCU 15C 2L A2PA', 'MTCU 15C 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (218, 'MTCU 15C 2L A2PAS', 'MTCU 15C 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (219, 'MTCU 15C 2L A2PE', 'MTCU 15C 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (220, 'MTCU 15C 2L A2PES', 'MTCU 15C 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (221, 'MTCU 15C 2L A2RA', 'MTCU 15C 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (222, 'MTCU 15C 2L A2RE', 'MTCU 15C 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (223, 'MTCU 15C 2L JA', 'MTCU 15C 2L JA');
INSERT INTO obras.maestro_estructura VALUES (224, 'MTCU 15C 2L JI', 'MTCU 15C 2L JI');
INSERT INTO obras.maestro_estructura VALUES (225, 'MTCU 15C 2L PD', 'MTCU 15C 2L PD');
INSERT INTO obras.maestro_estructura VALUES (226, 'MTCU 15C 2L PS', 'MTCU 15C 2L PS');
INSERT INTO obras.maestro_estructura VALUES (227, 'MTCU 15C 2L RS', 'MTCU 15C 2L RS');
INSERT INTO obras.maestro_estructura VALUES (228, 'MTCU 15C 2L RT', 'MTCU 15C 2L RT');
INSERT INTO obras.maestro_estructura VALUES (229, 'MTCU 15C 3L A1TE', 'MTCU 15C 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (230, 'MTCU 15C 3L A1TES', 'MTCU 15C 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (231, 'MTCU 15C 3L A1TJ', 'MTCU 15C 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (232, 'MTCU 15C 3L A1TJS', 'MTCU 15C 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (233, 'MTCU 15C 3L A2PA', 'MTCU 15C 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (234, 'MTCU 15C 3L A2PAS', 'MTCU 15C 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (235, 'MTCU 15C 3L A2PE', 'MTCU 15C 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (236, 'MTCU 15C 3L A2PES', 'MTCU 15C 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (237, 'MTCU 15C 3L A2RA', 'MTCU 15C 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (238, 'MTCU 15C 3L A2RE', 'MTCU 15C 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (239, 'MTCU 15C 3L JA', 'MTCU 15C 3L JA');
INSERT INTO obras.maestro_estructura VALUES (240, 'MTCU 15C 3L JI', 'MTCU 15C 3L JI');
INSERT INTO obras.maestro_estructura VALUES (241, 'MTCU 15C 3L PD', 'MTCU 15C 3L PD');
INSERT INTO obras.maestro_estructura VALUES (242, 'MTCU 15C 3L PS', 'MTCU 15C 3L PS');
INSERT INTO obras.maestro_estructura VALUES (243, 'MTCU 15C 3L RS', 'MTCU 15C 3L RS');
INSERT INTO obras.maestro_estructura VALUES (244, 'MTCU 15C 3L RT', 'MTCU 15C 3L RT');
INSERT INTO obras.maestro_estructura VALUES (245, 'MTCU 15C 3M A1TE', 'MTCU 15C 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (246, 'MTCU 15C 3M A1TES', 'MTCU 15C 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (247, 'MTCU 15C 3M A1TJ', 'MTCU 15C 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (248, 'MTCU 15C 3M A1TJS', 'MTCU 15C 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (249, 'MTCU 15C 3M A2PA', 'MTCU 15C 3M A2PA');
INSERT INTO obras.maestro_estructura VALUES (250, 'MTCU 15C 3M A2PAS', 'MTCU 15C 3M A2PAS');
INSERT INTO obras.maestro_estructura VALUES (251, 'MTCU 15C 3M A2PE', 'MTCU 15C 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (252, 'MTCU 15C 3M A2PES', 'MTCU 15C 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (253, 'MTCU 15C 3M A2RA', 'MTCU 15C 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (254, 'MTCU 15C 3M A2RE', 'MTCU 15C 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (255, 'MTCU 15C 3M JA', 'MTCU 15C 3M JA');
INSERT INTO obras.maestro_estructura VALUES (256, 'MTCU 15C 3M JI', 'MTCU 15C 3M JI');
INSERT INTO obras.maestro_estructura VALUES (257, 'MTCU 15C 3M PD', 'MTCU 15C 3M PD');
INSERT INTO obras.maestro_estructura VALUES (258, 'MTCU 15C 3M PS', 'MTCU 15C 3M PS');
INSERT INTO obras.maestro_estructura VALUES (259, 'MTCU 15C 3M RS', 'MTCU 15C 3M RS');
INSERT INTO obras.maestro_estructura VALUES (260, 'MTCU 15C 3M RT', 'MTCU 15C 3M RT');
INSERT INTO obras.maestro_estructura VALUES (261, 'MTCU 15C 3P A1TJ', 'MTCU 15C 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (262, 'MTCU 15C 3P A1TJS', 'MTCU 15C 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (263, 'MTCU 15C 3P A2PE', 'MTCU 15C 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (264, 'MTCU 15C 3P A2PES', 'MTCU 15C 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (265, 'MTCU 15C 3P A2RA', 'MTCU 15C 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (266, 'MTCU 15C 3P JA', 'MTCU 15C 3P JA');
INSERT INTO obras.maestro_estructura VALUES (267, 'MTCU 15C 3P JI', 'MTCU 15C 3P JI');
INSERT INTO obras.maestro_estructura VALUES (268, 'MTCU 15C 3P RS', 'MTCU 15C 3P RS');
INSERT INTO obras.maestro_estructura VALUES (269, 'MTCU 15E 2L A1TE', 'MTCU 15E 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (270, 'MTCU 15E 2L A1TES', 'MTCU 15E 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (271, 'MTCU 15E 2L A1TJ', 'MTCU 15E 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (272, 'MTCU 15E 2L A1TJS', 'MTCU 15E 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (273, 'MTCU 15E 2L A2PA', 'MTCU 15E 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (274, 'MTCU 15E 2L A2PAS', 'MTCU 15E 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (275, 'MTCU 15E 2L A2PE', 'MTCU 15E 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (276, 'MTCU 15E 2L A2PES', 'MTCU 15E 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (277, 'MTCU 15E 2L A2RA', 'MTCU 15E 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (278, 'MTCU 15E 2L A2RE', 'MTCU 15E 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (279, 'MTCU 15E 2L JA', 'MTCU 15E 2L JA');
INSERT INTO obras.maestro_estructura VALUES (280, 'MTCU 15E 2L JI', 'MTCU 15E 2L JI');
INSERT INTO obras.maestro_estructura VALUES (281, 'MTCU 15E 2L PD', 'MTCU 15E 2L PD');
INSERT INTO obras.maestro_estructura VALUES (282, 'MTCU 15E 2L PS', 'MTCU 15E 2L PS');
INSERT INTO obras.maestro_estructura VALUES (283, 'MTCU 15E 2L RS', 'MTCU 15E 2L RS');
INSERT INTO obras.maestro_estructura VALUES (284, 'MTCU 15E 2L RT', 'MTCU 15E 2L RT');
INSERT INTO obras.maestro_estructura VALUES (285, 'MTCU 15E 3L A1TE', 'MTCU 15E 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (286, 'MTCU 15E 3L A1TES', 'MTCU 15E 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (287, 'MTCU 15E 3L A1TJ', 'MTCU 15E 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (288, 'MTCU 15E 3L A1TJS', 'MTCU 15E 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (289, 'MTCU 15E 3L A2PA', 'MTCU 15E 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (290, 'MTCU 15E 3L A2PAS', 'MTCU 15E 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (291, 'MTCU 15E 3L A2PE', 'MTCU 15E 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (292, 'MTCU 15E 3L A2PES', 'MTCU 15E 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (293, 'MTCU 15E 3L A2RA', 'MTCU 15E 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (294, 'MTCU 15E 3L A2RE', 'MTCU 15E 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (295, 'MTCU 15E 3L JA', 'MTCU 15E 3L JA');
INSERT INTO obras.maestro_estructura VALUES (296, 'MTCU 15E 3L JI', 'MTCU 15E 3L JI');
INSERT INTO obras.maestro_estructura VALUES (297, 'MTCU 15E 3L PD', 'MTCU 15E 3L PD');
INSERT INTO obras.maestro_estructura VALUES (298, 'MTCU 15E 3L PS', 'MTCU 15E 3L PS');
INSERT INTO obras.maestro_estructura VALUES (299, 'MTCU 15E 3L RS', 'MTCU 15E 3L RS');
INSERT INTO obras.maestro_estructura VALUES (300, 'MTCU 15E 3L RT', 'MTCU 15E 3L RT');
INSERT INTO obras.maestro_estructura VALUES (301, 'MTCU 15E 3M A1TE', 'MTCU 15E 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (302, 'MTCU 15E 3M A1TES', 'MTCU 15E 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (303, 'MTCU 15E 3M A1TJ', 'MTCU 15E 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (304, 'MTCU 15E 3M A1TJS', 'MTCU 15E 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (305, 'MTCU 15E 3M A2PA', 'MTCU 15E 3M A2PA');
INSERT INTO obras.maestro_estructura VALUES (306, 'MTCU 15E 3M A2PAS', 'MTCU 15E 3M A2PAS');
INSERT INTO obras.maestro_estructura VALUES (307, 'MTCU 15E 3M A2PE', 'MTCU 15E 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (308, 'MTCU 15E 3M A2PES', 'MTCU 15E 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (309, 'MTCU 15E 3M A2RA', 'MTCU 15E 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (310, 'MTCU 15E 3M A2RE', 'MTCU 15E 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (311, 'MTCU 15E 3M JA', 'MTCU 15E 3M JA');
INSERT INTO obras.maestro_estructura VALUES (312, 'MTCU 15E 3M JI', 'MTCU 15E 3M JI');
INSERT INTO obras.maestro_estructura VALUES (313, 'MTCU 15E 3M PD', 'MTCU 15E 3M PD');
INSERT INTO obras.maestro_estructura VALUES (314, 'MTCU 15E 3M PS', 'MTCU 15E 3M PS');
INSERT INTO obras.maestro_estructura VALUES (315, 'MTCU 15E 3M RS', 'MTCU 15E 3M RS');
INSERT INTO obras.maestro_estructura VALUES (316, 'MTCU 15E 3M RT', 'MTCU 15E 3M RT');
INSERT INTO obras.maestro_estructura VALUES (317, 'MTCU 15E 3P A1TJ', 'MTCU 15E 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (318, 'MTCU 15E 3P A1TJS', 'MTCU 15E 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (319, 'MTCU 15E 3P A2PE', 'MTCU 15E 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (320, 'MTCU 15E 3P A2PES', 'MTCU 15E 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (321, 'MTCU 15E 3P A2RA', 'MTCU 15E 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (322, 'MTCU 15E 3P JA', 'MTCU 15E 3P JA');
INSERT INTO obras.maestro_estructura VALUES (323, 'MTCU 15E 3P JI', 'MTCU 15E 3P JI');
INSERT INTO obras.maestro_estructura VALUES (324, 'MTCU 15E 3P RS', 'MTCU 15E 3P RS');
INSERT INTO obras.maestro_estructura VALUES (325, 'MTCU 15N 2L A1TE', 'MTCU 15N 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (326, 'MTCU 15N 2L A1TES', 'MTCU 15N 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (327, 'MTCU 15N 2L A1TJ', 'MTCU 15N 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (328, 'MTCU 15N 2L A1TJS', 'MTCU 15N 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (329, 'MTCU 15N 2L A2PA', 'MTCU 15N 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (330, 'MTCU 15N 2L A2PAS', 'MTCU 15N 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (331, 'MTCU 15N 2L A2PE', 'MTCU 15N 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (332, 'MTCU 15N 2L A2PES', 'MTCU 15N 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (333, 'MTCU 15N 2L A2RA', 'MTCU 15N 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (334, 'MTCU 15N 2L A2RE', 'MTCU 15N 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (335, 'MTCU 15N 2L JA', 'MTCU 15N 2L JA');
INSERT INTO obras.maestro_estructura VALUES (336, 'MTCU 15N 2L JI', 'MTCU 15N 2L JI');
INSERT INTO obras.maestro_estructura VALUES (337, 'MTCU 15N 2L PD', 'MTCU 15N 2L PD');
INSERT INTO obras.maestro_estructura VALUES (338, 'MTCU 15N 2L PS', 'MTCU 15N 2L PS');
INSERT INTO obras.maestro_estructura VALUES (339, 'MTCU 15N 2L RS', 'MTCU 15N 2L RS');
INSERT INTO obras.maestro_estructura VALUES (340, 'MTCU 15N 2L RT', 'MTCU 15N 2L RT');
INSERT INTO obras.maestro_estructura VALUES (341, 'MTCU 15N 3L A1TE', 'MTCU 15N 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (342, 'MTCU 15N 3L A1TES', 'MTCU 15N 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (343, 'MTCU 15N 3L A1TJ', 'MTCU 15N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (344, 'MTCU 15N 3L A1TJS', 'MTCU 15N 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (345, 'MTCU 15N 3L A2PA', 'MTCU 15N 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (346, 'MTCU 15N 3L A2PAS', 'MTCU 15N 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (347, 'MTCU 15N 3L A2PE', 'MTCU 15N 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (348, 'MTCU 15N 3L A2PES', 'MTCU 15N 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (349, 'MTCU 15N 3L A2RA', 'MTCU 15N 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (350, 'MTCU 15N 3L A2RE', 'MTCU 15N 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (351, 'MTCU 15N 3L JA', 'MTCU 15N 3L JA');
INSERT INTO obras.maestro_estructura VALUES (352, 'MTCU 15N 3L JI', 'MTCU 15N 3L JI');
INSERT INTO obras.maestro_estructura VALUES (353, 'MTCU 15N 3L PD', 'MTCU 15N 3L PD');
INSERT INTO obras.maestro_estructura VALUES (354, 'MTCU 15N 3L PS', 'MTCU 15N 3L PS');
INSERT INTO obras.maestro_estructura VALUES (355, 'MTCU 15N 3L RS', 'MTCU 15N 3L RS');
INSERT INTO obras.maestro_estructura VALUES (356, 'MTCU 15N 3L RT', 'MTCU 15N 3L RT');
INSERT INTO obras.maestro_estructura VALUES (357, 'MTCU 15N 3M A1TE', 'MTCU 15N 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (358, 'MTCU 15N 3M A1TES', 'MTCU 15N 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (359, 'MTCU 15N 3M A1TJ', 'MTCU 15N 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (360, 'MTCU 15N 3M A1TJS', 'MTCU 15N 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (361, 'MTCU 15N 3M A2PA', 'MTCU 15N 3M A2PA');
INSERT INTO obras.maestro_estructura VALUES (362, 'MTCU 15N 3M A2PAS', 'MTCU 15N 3M A2PAS');
INSERT INTO obras.maestro_estructura VALUES (363, 'MTCU 15N 3M A2PE', 'MTCU 15N 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (364, 'MTCU 15N 3M A2PES', 'MTCU 15N 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (365, 'MTCU 15N 3M A2RA', 'MTCU 15N 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (366, 'MTCU 15N 3M A2RE', 'MTCU 15N 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (367, 'MTCU 15N 3M JA', 'MTCU 15N 3M JA');
INSERT INTO obras.maestro_estructura VALUES (368, 'MTCU 15N 3M JI', 'MTCU 15N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (369, 'MTCU 15N 3M PD', 'MTCU 15N 3M PD');
INSERT INTO obras.maestro_estructura VALUES (370, 'MTCU 15N 3M PS', 'MTCU 15N 3M PS');
INSERT INTO obras.maestro_estructura VALUES (371, 'MTCU 15N 3M RS', 'MTCU 15N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (372, 'MTCU 15N 3M RT', 'MTCU 15N 3M RT');
INSERT INTO obras.maestro_estructura VALUES (373, 'MTCU 15N 3P A1TJ', 'MTCU 15N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (374, 'MTCU 15N 3P A1TJS', 'MTCU 15N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (375, 'MTCU 15N 3P A2PE', 'MTCU 15N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (376, 'MTCU 15N 3P A2PES', 'MTCU 15N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (377, 'MTCU 15N 3P A2RA', 'MTCU 15N 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (378, 'MTCU 15N 3P JA', 'MTCU 15N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (379, 'MTCU 15N 3P JI', 'MTCU 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (380, 'MTCU 15N 3P RS', 'MTCU 15N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (381, 'MTCU 15V 2L A1TE', 'MTCU 15V 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (382, 'MTCU 15V 2L A1TES', 'MTCU 15V 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (383, 'MTCU 15V 2L A1TJ', 'MTCU 15V 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (384, 'MTCU 15V 2L A1TJS', 'MTCU 15V 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (385, 'MTCU 15V 2L A2PA', 'MTCU 15V 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (386, 'MTCU 15V 2L A2PAS', 'MTCU 15V 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (387, 'MTCU 15V 2L A2PE', 'MTCU 15V 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (388, 'MTCU 15V 2L A2PES', 'MTCU 15V 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (389, 'MTCU 15V 2L A2RA', 'MTCU 15V 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (390, 'MTCU 15V 2L A2RE', 'MTCU 15V 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (391, 'MTCU 15V 2L JA', 'MTCU 15V 2L JA');
INSERT INTO obras.maestro_estructura VALUES (392, 'MTCU 15V 2L JI', 'MTCU 15V 2L JI');
INSERT INTO obras.maestro_estructura VALUES (393, 'MTCU 15V 2L PD', 'MTCU 15V 2L PD');
INSERT INTO obras.maestro_estructura VALUES (394, 'MTCU 15V 2L PS', 'MTCU 15V 2L PS');
INSERT INTO obras.maestro_estructura VALUES (395, 'MTCU 15V 2L RS', 'MTCU 15V 2L RS');
INSERT INTO obras.maestro_estructura VALUES (396, 'MTCU 15V 2L RT', 'MTCU 15V 2L RT');
INSERT INTO obras.maestro_estructura VALUES (397, 'MTCU 15V 3L A1TE', 'MTCU 15V 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (398, 'MTCU 15V 3L A1TES', 'MTCU 15V 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (399, 'MTCU 15V 3L A1TJ', 'MTCU 15V 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (400, 'MTCU 15V 3L A1TJS', 'MTCU 15V 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (401, 'MTCU 15V 3L A2PA', 'MTCU 15V 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (402, 'MTCU 15V 3L A2PAS', 'MTCU 15V 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (403, 'MTCU 15V 3L A2PE', 'MTCU 15V 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (404, 'MTCU 15V 3L A2PES', 'MTCU 15V 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (405, 'MTCU 15V 3L A2RA', 'MTCU 15V 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (406, 'MTCU 15V 3L A2RE', 'MTCU 15V 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (407, 'MTCU 15V 3L JA', 'MTCU 15V 3L JA');
INSERT INTO obras.maestro_estructura VALUES (408, 'MTCU 15V 3L JI', 'MTCU 15V 3L JI');
INSERT INTO obras.maestro_estructura VALUES (409, 'MTCU 15V 3L PD', 'MTCU 15V 3L PD');
INSERT INTO obras.maestro_estructura VALUES (410, 'MTCU 15V 3L PS', 'MTCU 15V 3L PS');
INSERT INTO obras.maestro_estructura VALUES (411, 'MTCU 15V 3L RS', 'MTCU 15V 3L RS');
INSERT INTO obras.maestro_estructura VALUES (412, 'MTCU 15V 3L RT', 'MTCU 15V 3L RT');
INSERT INTO obras.maestro_estructura VALUES (413, 'MTCU 15V 3M A1TE', 'MTCU 15V 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (414, 'MTCU 15V 3M A1TES', 'MTCU 15V 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (415, 'MTCU 15V 3M A1TJ', 'MTCU 15V 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (416, 'MTCU 15V 3M A1TJS', 'MTCU 15V 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (417, 'MTCU 15V 3M A2PA', 'MTCU 15V 3M A2PA');
INSERT INTO obras.maestro_estructura VALUES (418, 'MTCU 15V 3M A2PAS', 'MTCU 15V 3M A2PAS');
INSERT INTO obras.maestro_estructura VALUES (419, 'MTCU 15V 3M A2PE', 'MTCU 15V 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (420, 'MTCU 15V 3M A2PES', 'MTCU 15V 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (421, 'MTCU 15V 3M A2RA', 'MTCU 15V 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (422, 'MTCU 15V 3M A2RE', 'MTCU 15V 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (423, 'MTCU 15V 3M JA', 'MTCU 15V 3M JA');
INSERT INTO obras.maestro_estructura VALUES (424, 'MTCU 15V 3M JI', 'MTCU 15V 3M JI');
INSERT INTO obras.maestro_estructura VALUES (425, 'MTCU 15V 3M PD', 'MTCU 15V 3M PD');
INSERT INTO obras.maestro_estructura VALUES (426, 'MTCU 15V 3M PS', 'MTCU 15V 3M PS');
INSERT INTO obras.maestro_estructura VALUES (427, 'MTCU 15V 3M RS', 'MTCU 15V 3M RS');
INSERT INTO obras.maestro_estructura VALUES (428, 'MTCU 15V 3M RT', 'MTCU 15V 3M RT');
INSERT INTO obras.maestro_estructura VALUES (429, 'MTCU 15V 3P A1TJ', 'MTCU 15V 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (430, 'MTCU 15V 3P A1TJS', 'MTCU 15V 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (431, 'MTCU 15V 3P A2PE', 'MTCU 15V 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (432, 'MTCU 15V 3P A2PES', 'MTCU 15V 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (433, 'MTCU 15V 3P A2RA', 'MTCU 15V 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (434, 'MTCU 15V 3P JA', 'MTCU 15V 3P JA');
INSERT INTO obras.maestro_estructura VALUES (435, 'MTCU 15V 3P JI', 'MTCU 15V 3P JI');
INSERT INTO obras.maestro_estructura VALUES (436, 'MTCU 15V 3P RS', 'MTCU 15V 3P RS');
INSERT INTO obras.maestro_estructura VALUES (437, 'MTCU 23N 2L A1TE', 'MTCU 23N 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (438, 'MTCU 23N 2L A1TES', 'MTCU 23N 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (439, 'MTCU 23N 2L A1TJ', 'MTCU 23N 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (440, 'MTCU 23N 2L A1TJS', 'MTCU 23N 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (441, 'MTCU 23N 2L A2PA', 'MTCU 23N 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (442, 'MTCU 23N 2L A2PAS', 'MTCU 23N 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (443, 'MTCU 23N 2L A2PE', 'MTCU 23N 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (444, 'MTCU 23N 2L A2PES', 'MTCU 23N 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (445, 'MTCU 23N 2L A2RA', 'MTCU 23N 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (446, 'MTCU 23N 2L A2RE', 'MTCU 23N 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (447, 'MTCU 23N 2L JA', 'MTCU 23N 2L JA');
INSERT INTO obras.maestro_estructura VALUES (448, 'MTCU 23N 2L JI', 'MTCU 23N 2L JI');
INSERT INTO obras.maestro_estructura VALUES (449, 'MTCU 23N 2L PD', 'MTCU 23N 2L PD');
INSERT INTO obras.maestro_estructura VALUES (450, 'MTCU 23N 2L PS', 'MTCU 23N 2L PS');
INSERT INTO obras.maestro_estructura VALUES (451, 'MTCU 23N 2L RS', 'MTCU 23N 2L RS');
INSERT INTO obras.maestro_estructura VALUES (452, 'MTCU 23N 2L RT', 'MTCU 23N 2L RT');
INSERT INTO obras.maestro_estructura VALUES (453, 'MTCU 23N 3L A1TE', 'MTCU 23N 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (454, 'MTCU 23N 3L A1TES', 'MTCU 23N 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (455, 'MTCU 23N 3L A1TJ', 'MTCU 23N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (456, 'MTCU 23N 3L A1TJS', 'MTCU 23N 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (457, 'MTCU 23N 3L A2PA', 'MTCU 23N 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (458, 'MTCU 23N 3L A2PAS', 'MTCU 23N 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (459, 'MTCU 23N 3L A2PE', 'MTCU 23N 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (460, 'MTCU 23N 3L A2PES', 'MTCU 23N 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (461, 'MTCU 23N 3L A2RA', 'MTCU 23N 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (462, 'MTCU 23N 3L A2RE', 'MTCU 23N 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (463, 'MTCU 23N 3L JA', 'MTCU 23N 3L JA');
INSERT INTO obras.maestro_estructura VALUES (464, 'MTCU 23N 3L JI', 'MTCU 23N 3L JI');
INSERT INTO obras.maestro_estructura VALUES (465, 'MTCU 23N 3L PD', 'MTCU 23N 3L PD');
INSERT INTO obras.maestro_estructura VALUES (466, 'MTCU 23N 3L PS', 'MTCU 23N 3L PS');
INSERT INTO obras.maestro_estructura VALUES (467, 'MTCU 23N 3L RS', 'MTCU 23N 3L RS');
INSERT INTO obras.maestro_estructura VALUES (468, 'MTCU 23N 3L RT', 'MTCU 23N 3L RT');
INSERT INTO obras.maestro_estructura VALUES (469, 'MTCU 23N 3M A1TE', 'MTCU 23N 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (470, 'MTCU 23N 3M A1TES', 'MTCU 23N 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (471, 'MTCU 23N 3M A1TJ', 'MTCU 23N 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (472, 'MTCU 23N 3M A1TJS', 'MTCU 23N 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (473, 'MTCU 23N 3M A2PA', 'MTCU 23N 3M A2PA');
INSERT INTO obras.maestro_estructura VALUES (474, 'MTCU 23N 3M A2PAS', 'MTCU 23N 3M A2PAS');
INSERT INTO obras.maestro_estructura VALUES (475, 'MTCU 23N 3M A2PE', 'MTCU 23N 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (476, 'MTCU 23N 3M A2PES', 'MTCU 23N 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (477, 'MTCU 23N 3M A2RA', 'MTCU 23N 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (478, 'MTCU 23N 3M A2RE', 'MTCU 23N 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (479, 'MTCU 23N 3M JA', 'MTCU 23N 3M JA');
INSERT INTO obras.maestro_estructura VALUES (480, 'MTCU 23N 3M JI', 'MTCU 23N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (481, 'MTCU 23N 3M PD', 'MTCU 23N 3M PD');
INSERT INTO obras.maestro_estructura VALUES (482, 'MTCU 23N 3M PS', 'MTCU 23N 3M PS');
INSERT INTO obras.maestro_estructura VALUES (483, 'MTCU 23N 3M RS', 'MTCU 23N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (484, 'MTCU 23N 3M RT', 'MTCU 23N 3M RT');
INSERT INTO obras.maestro_estructura VALUES (485, 'MTCU 23N 3P A1TJ', 'MTCU 23N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (486, 'MTCU 23N 3P A1TJS', 'MTCU 23N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (487, 'MTCU 23N 3P A2PE', 'MTCU 23N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (488, 'MTCU 23N 3P A2PES', 'MTCU 23N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (489, 'MTCU 23N 3P A2RA', 'MTCU 23N 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (490, 'MTCU 23N 3P JA', 'MTCU 23N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (491, 'MTCU 23N 3P JI', 'MTCU 23N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (492, 'MTCU 23N 3P RS', 'MTCU 23N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (493, 'MTCU 23V 2L A1TE', 'MTCU 23V 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (494, 'MTCU 23V 2L A1TES', 'MTCU 23V 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (495, 'MTCU 23V 2L A1TJ', 'MTCU 23V 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (496, 'MTCU 23V 2L A1TJS', 'MTCU 23V 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (497, 'MTCU 23V 2L A2PA', 'MTCU 23V 2L A2PA');
INSERT INTO obras.maestro_estructura VALUES (498, 'MTCU 23V 2L A2PAS', 'MTCU 23V 2L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (499, 'MTCU 23V 2L A2PE', 'MTCU 23V 2L A2PE');
INSERT INTO obras.maestro_estructura VALUES (500, 'MTCU 23V 2L A2PES', 'MTCU 23V 2L A2PES');
INSERT INTO obras.maestro_estructura VALUES (501, 'MTCU 23V 2L A2RA', 'MTCU 23V 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (502, 'MTCU 23V 2L A2RE', 'MTCU 23V 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (503, 'MTCU 23V 2L JA', 'MTCU 23V 2L JA');
INSERT INTO obras.maestro_estructura VALUES (504, 'MTCU 23V 2L JI', 'MTCU 23V 2L JI');
INSERT INTO obras.maestro_estructura VALUES (505, 'MTCU 23V 2L PD', 'MTCU 23V 2L PD');
INSERT INTO obras.maestro_estructura VALUES (506, 'MTCU 23V 2L PS', 'MTCU 23V 2L PS');
INSERT INTO obras.maestro_estructura VALUES (507, 'MTCU 23V 2L RS', 'MTCU 23V 2L RS');
INSERT INTO obras.maestro_estructura VALUES (508, 'MTCU 23V 2L RT', 'MTCU 23V 2L RT');
INSERT INTO obras.maestro_estructura VALUES (509, 'MTCU 23V 3L A1TE', 'MTCU 23V 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (510, 'MTCU 23V 3L A1TES', 'MTCU 23V 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (511, 'MTCU 23V 3L A1TJ', 'MTCU 23V 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (512, 'MTCU 23V 3L A1TJS', 'MTCU 23V 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (513, 'MTCU 23V 3L A2PA', 'MTCU 23V 3L A2PA');
INSERT INTO obras.maestro_estructura VALUES (514, 'MTCU 23V 3L A2PAS', 'MTCU 23V 3L A2PAS');
INSERT INTO obras.maestro_estructura VALUES (515, 'MTCU 23V 3L A2PE', 'MTCU 23V 3L A2PE');
INSERT INTO obras.maestro_estructura VALUES (516, 'MTCU 23V 3L A2PES', 'MTCU 23V 3L A2PES');
INSERT INTO obras.maestro_estructura VALUES (517, 'MTCU 23V 3L A2RA', 'MTCU 23V 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (518, 'MTCU 23V 3L A2RE', 'MTCU 23V 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (519, 'MTCU 23V 3L JA', 'MTCU 23V 3L JA');
INSERT INTO obras.maestro_estructura VALUES (520, 'MTCU 23V 3L JI', 'MTCU 23V 3L JI');
INSERT INTO obras.maestro_estructura VALUES (521, 'MTCU 23V 3L PD', 'MTCU 23V 3L PD');
INSERT INTO obras.maestro_estructura VALUES (522, 'MTCU 23V 3L PS', 'MTCU 23V 3L PS');
INSERT INTO obras.maestro_estructura VALUES (523, 'MTCU 23V 3L RS', 'MTCU 23V 3L RS');
INSERT INTO obras.maestro_estructura VALUES (524, 'MTCU 23V 3L RT', 'MTCU 23V 3L RT');
INSERT INTO obras.maestro_estructura VALUES (525, 'MTCU 23V 3M A1TE', 'MTCU 23V 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (526, 'MTCU 23V 3M A1TES', 'MTCU 23V 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (527, 'MTCU 23V 3M A1TJ', 'MTCU 23V 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (528, 'MTCU 23V 3M A1TJS', 'MTCU 23V 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (529, 'MTCU 23V 3M A2PA', 'MTCU 23V 3M A2PA');
INSERT INTO obras.maestro_estructura VALUES (530, 'MTCU 23V 3M A2PAS', 'MTCU 23V 3M A2PAS');
INSERT INTO obras.maestro_estructura VALUES (531, 'MTCU 23V 3M A2PE', 'MTCU 23V 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (532, 'MTCU 23V 3M A2PES', 'MTCU 23V 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (533, 'MTCU 23V 3M A2RA', 'MTCU 23V 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (534, 'MTCU 23V 3M A2RE', 'MTCU 23V 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (535, 'MTCU 23V 3M JA', 'MTCU 23V 3M JA');
INSERT INTO obras.maestro_estructura VALUES (536, 'MTCU 23V 3M JI', 'MTCU 23V 3M JI');
INSERT INTO obras.maestro_estructura VALUES (537, 'MTCU 23V 3M PD', 'MTCU 23V 3M PD');
INSERT INTO obras.maestro_estructura VALUES (538, 'MTCU 23V 3M PS', 'MTCU 23V 3M PS');
INSERT INTO obras.maestro_estructura VALUES (539, 'MTCU 23V 3M RS', 'MTCU 23V 3M RS');
INSERT INTO obras.maestro_estructura VALUES (540, 'MTCU 23V 3M RT', 'MTCU 23V 3M RT');
INSERT INTO obras.maestro_estructura VALUES (541, 'MTCU 23V 3P A1TJ', 'MTCU 23V 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (542, 'MTCU 23V 3P A1TJS', 'MTCU 23V 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (543, 'MTCU 23V 3P A2PE', 'MTCU 23V 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (544, 'MTCU 23V 3P A2PES', 'MTCU 23V 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (545, 'MTCU 23V 3P A2RA', 'MTCU 23V 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (546, 'MTCU 23V 3P JA', 'MTCU 23V 3P JA');
INSERT INTO obras.maestro_estructura VALUES (547, 'MTCU 23V 3P JI', 'MTCU 23V 3P JI');
INSERT INTO obras.maestro_estructura VALUES (548, 'MTCU 23V 3P RS', 'MTCU 23V 3P RS');
INSERT INTO obras.maestro_estructura VALUES (549, 'PC  6.8 m', 'PC  6.8 m');
INSERT INTO obras.maestro_estructura VALUES (550, 'PC  8.0 m', 'PC  8.0 m');
INSERT INTO obras.maestro_estructura VALUES (551, 'PC  9.0 m', 'PC  9.0 m');
INSERT INTO obras.maestro_estructura VALUES (552, 'PC 10.0 m', 'PC 10.0 m');
INSERT INTO obras.maestro_estructura VALUES (553, 'PC 11.5 m', 'PC 11.5 m');
INSERT INTO obras.maestro_estructura VALUES (554, 'PC 13.5 m (old)', 'PC 13.5 m (old)');
INSERT INTO obras.maestro_estructura VALUES (555, 'PC 15.0 m C', 'PC 15.0 m C');
INSERT INTO obras.maestro_estructura VALUES (556, 'TBT M', 'TBT M');
INSERT INTO obras.maestro_estructura VALUES (557, 'TBT S', 'TBT S');
INSERT INTO obras.maestro_estructura VALUES (558, 'TMT D', 'TMT D');
INSERT INTO obras.maestro_estructura VALUES (559, 'TMT D2', 'TMT D2');
INSERT INTO obras.maestro_estructura VALUES (560, 'TMT L', 'TMT L');
INSERT INTO obras.maestro_estructura VALUES (561, 'TMT M', 'TMT M');
INSERT INTO obras.maestro_estructura VALUES (562, 'TMT S', 'TMT S');
INSERT INTO obras.maestro_estructura VALUES (563, 'TT 3E P', 'TT 3E P');
INSERT INTO obras.maestro_estructura VALUES (564, 'TT 3E S', 'TT 3E S');
INSERT INTO obras.maestro_estructura VALUES (565, 'TT MS P', 'TT MS P');
INSERT INTO obras.maestro_estructura VALUES (566, 'TT MS S', 'TT MS S');
INSERT INTO obras.maestro_estructura VALUES (567, 'MTCU 15N 2L PC', 'MTCU 15N 2L PC');
INSERT INTO obras.maestro_estructura VALUES (568, 'MTCU 15N 3L PC', 'MTCU 15N 3L PC');
INSERT INTO obras.maestro_estructura VALUES (569, 'MTCU 15N 3M PC', 'MTCU 15N 3M PC');
INSERT INTO obras.maestro_estructura VALUES (570, 'MTCU 15N 3P PC', 'MTCU 15N 3P PC');
INSERT INTO obras.maestro_estructura VALUES (571, 'MTAL 15N 2L PC', 'MTAL 15N 2L PC');
INSERT INTO obras.maestro_estructura VALUES (572, 'MTAL 15N 3L PC', 'MTAL 15N 3L PC');
INSERT INTO obras.maestro_estructura VALUES (573, 'MTAL 15N 3P PC', 'MTAL 15N 3P PC');
INSERT INTO obras.maestro_estructura VALUES (574, 'MTCU 15N 2L PCD', 'MTCU 15N 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (575, 'MTCU 15N 3L PCD', 'MTCU 15N 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (576, 'MTCU 15N 3M PCD', 'MTCU 15N 3M PCD');
INSERT INTO obras.maestro_estructura VALUES (577, 'MTCU 15N 3P PCD', 'MTCU 15N 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (578, 'MTAL 15N 2L PCD', 'MTAL 15N 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (579, 'MTAL 15N 3L PCD', 'MTAL 15N 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (580, 'MTAL 15N 3P PCD', 'MTAL 15N 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (581, 'MTCU 15C 2L PC', 'MTCU 15C 2L PC');
INSERT INTO obras.maestro_estructura VALUES (582, 'MTCU 15C 3L PC', 'MTCU 15C 3L PC');
INSERT INTO obras.maestro_estructura VALUES (583, 'MTCU 15C 3M PC', 'MTCU 15C 3M PC');
INSERT INTO obras.maestro_estructura VALUES (584, 'MTCU 15C 3P PC', 'MTCU 15C 3P PC');
INSERT INTO obras.maestro_estructura VALUES (585, 'MTCU 15C 2L PCD', 'MTCU 15C 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (586, 'MTCU 15C 3L PCD', 'MTCU 15C 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (587, 'MTCU 15C 3M PCD', 'MTCU 15C 3M PCD');
INSERT INTO obras.maestro_estructura VALUES (588, 'MTCU 15C 3P PCD', 'MTCU 15C 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (589, 'MTCU 15V 2L PC', 'MTCU 15V 2L PC');
INSERT INTO obras.maestro_estructura VALUES (590, 'MTCU 15V 3L PC', 'MTCU 15V 3L PC');
INSERT INTO obras.maestro_estructura VALUES (591, 'MTCU 15V 3M PC', 'MTCU 15V 3M PC');
INSERT INTO obras.maestro_estructura VALUES (592, 'MTCU 15V 3P PC', 'MTCU 15V 3P PC');
INSERT INTO obras.maestro_estructura VALUES (593, 'MTAL 15V 2L PC', 'MTAL 15V 2L PC');
INSERT INTO obras.maestro_estructura VALUES (594, 'MTAL 15V 3L PC', 'MTAL 15V 3L PC');
INSERT INTO obras.maestro_estructura VALUES (595, 'MTAL 15V 3P PC', 'MTAL 15V 3P PC');
INSERT INTO obras.maestro_estructura VALUES (596, 'MTCU 15V 2L PCD', 'MTCU 15V 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (597, 'MTCU 15V 3L PCD', 'MTCU 15V 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (598, 'MTCU 15V 3M PCD', 'MTCU 15V 3M PCD');
INSERT INTO obras.maestro_estructura VALUES (599, 'MTCU 15V 3P PCD', 'MTCU 15V 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (600, 'MTAL 15V 2L PCD', 'MTAL 15V 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (601, 'MTAL 15V 3L PCD', 'MTAL 15V 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (602, 'MTAL 15V 3P PCD', 'MTAL 15V 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (603, 'MTCU 15E 2L PC', 'MTCU 15E 2L PC');
INSERT INTO obras.maestro_estructura VALUES (604, 'MTCU 15E 3L PC', 'MTCU 15E 3L PC');
INSERT INTO obras.maestro_estructura VALUES (605, 'MTCU 15E 3M PC', 'MTCU 15E 3M PC');
INSERT INTO obras.maestro_estructura VALUES (606, 'MTCU 15E 3P PC', 'MTCU 15E 3P PC');
INSERT INTO obras.maestro_estructura VALUES (607, 'MTCU 15E 2L PCD', 'MTCU 15E 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (608, 'MTCU 15E 3L PCD', 'MTCU 15E 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (609, 'MTCU 15E 3M PCD', 'MTCU 15E 3M PCD');
INSERT INTO obras.maestro_estructura VALUES (610, 'MTCU 15E 3P PCD', 'MTCU 15E 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (611, 'MTCU 23N 2L PC', 'MTCU 23N 2L PC');
INSERT INTO obras.maestro_estructura VALUES (612, 'MTCU 23N 3L PC', 'MTCU 23N 3L PC');
INSERT INTO obras.maestro_estructura VALUES (613, 'MTCU 23N 3M PC', 'MTCU 23N 3M PC');
INSERT INTO obras.maestro_estructura VALUES (614, 'MTCU 23N 3P PC', 'MTCU 23N 3P PC');
INSERT INTO obras.maestro_estructura VALUES (615, 'MTAL 23N 2L PC', 'MTAL 23N 2L PC');
INSERT INTO obras.maestro_estructura VALUES (616, 'MTAL 23N 3L PC', 'MTAL 23N 3L PC');
INSERT INTO obras.maestro_estructura VALUES (617, 'MTAL 23N 3P PC', 'MTAL 23N 3P PC');
INSERT INTO obras.maestro_estructura VALUES (618, 'MTCU 23N 3L PCD', 'MTCU 23N 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (619, 'MTCU 23N 3M PCD', 'MTCU 23N 3M PCD');
INSERT INTO obras.maestro_estructura VALUES (620, 'MTCU 23N 3P PCD', 'MTCU 23N 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (621, 'MTAL 23N 2L PCD', 'MTAL 23N 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (622, 'MTAL 23N 3L PCD', 'MTAL 23N 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (623, 'MTAL 23N 3P PCD', 'MTAL 23N 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (624, 'MTCU 23V 2L PC', 'MTCU 23V 2L PC');
INSERT INTO obras.maestro_estructura VALUES (625, 'MTCU 23V 3L PC', 'MTCU 23V 3L PC');
INSERT INTO obras.maestro_estructura VALUES (626, 'MTCU 23V 3M PC', 'MTCU 23V 3M PC');
INSERT INTO obras.maestro_estructura VALUES (627, 'MTCU 23V 3P PC', 'MTCU 23V 3P PC');
INSERT INTO obras.maestro_estructura VALUES (628, 'MTAL 23V 2L PC', 'MTAL 23V 2L PC');
INSERT INTO obras.maestro_estructura VALUES (629, 'MTAL 23V 3L PC', 'MTAL 23V 3L PC');
INSERT INTO obras.maestro_estructura VALUES (630, 'MTAL 23V 3P PC', 'MTAL 23V 3P PC');
INSERT INTO obras.maestro_estructura VALUES (631, 'MTCU 23V 2L PCD', 'MTCU 23V 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (632, 'MTCU 23V 3L PCD', 'MTCU 23V 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (633, 'MTCU 23V 3M PCD', 'MTCU 23V 3M PCD');
INSERT INTO obras.maestro_estructura VALUES (634, 'MTCU 23V 3P PCD', 'MTCU 23V 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (635, 'MTAL 23V 2L PCD', 'MTAL 23V 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (636, 'MTAL 23V 3L PCD', 'MTAL 23V 3L PCD');
INSERT INTO obras.maestro_estructura VALUES (637, 'MTAL 23V 3P PCD', 'MTAL 23V 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (638, 'BARRA SE1PC PR1ø', 'BARRA SE1PC PR1ø');
INSERT INTO obras.maestro_estructura VALUES (639, 'BARRA SE1PC PR3ø', 'BARRA SE1PC PR3ø');
INSERT INTO obras.maestro_estructura VALUES (640, 'BARRA SE2PC PR3ø', 'BARRA SE2PC PR3ø');
INSERT INTO obras.maestro_estructura VALUES (641, 'BARRA SE1PC PR3ø 2S', 'BARRA SE1PC PR3ø 2S');
INSERT INTO obras.maestro_estructura VALUES (642, 'BARRA SE1PC PR1ø 2S', 'BARRA SE1PC PR1ø 2S');
INSERT INTO obras.maestro_estructura VALUES (643, 'TT MS S Pre', 'TT MS S Pre');
INSERT INTO obras.maestro_estructura VALUES (644, 'TT 3E S Pre', 'TT 3E S Pre');
INSERT INTO obras.maestro_estructura VALUES (645, 'PMadera 9m', 'PMadera 9m');
INSERT INTO obras.maestro_estructura VALUES (646, 'PMadera 10m', 'PMadera 10m');
INSERT INTO obras.maestro_estructura VALUES (647, 'PRiel 9m', 'PRiel 9m');
INSERT INTO obras.maestro_estructura VALUES (648, 'PRiel 10m', 'PRiel 10m');
INSERT INTO obras.maestro_estructura VALUES (649, 'Torre 9m', 'Torre 9m');
INSERT INTO obras.maestro_estructura VALUES (650, 'Torre 10m', 'Torre 10m');
INSERT INTO obras.maestro_estructura VALUES (651, 'Torre 11m', 'Torre 11m');
INSERT INTO obras.maestro_estructura VALUES (652, 'Torre 15m', 'Torre 15m');
INSERT INTO obras.maestro_estructura VALUES (653, 'Manessm 9m', 'Manessm 9m');
INSERT INTO obras.maestro_estructura VALUES (654, 'Manessm 10m', 'Manessm 10m');
INSERT INTO obras.maestro_estructura VALUES (655, 'Poste acero curvo', 'Poste acero curvo');
INSERT INTO obras.maestro_estructura VALUES (656, 'Mont Reconect R 1PC', 'Mont Reconect R 1PC');
INSERT INTO obras.maestro_estructura VALUES (657, 'Mont Reconect 6H', 'Mont Reconect 6H');
INSERT INTO obras.maestro_estructura VALUES (658, 'Mont Recon 6H prot 2', 'Mont Recon 6H prot 2');
INSERT INTO obras.maestro_estructura VALUES (659, 'Mont Cuch Monop Hori', 'Mont Cuch Monop Hori');
INSERT INTO obras.maestro_estructura VALUES (660, 'Mont Recon Electroni', 'Mont Recon Electroni');
INSERT INTO obras.maestro_estructura VALUES (661, 'MTCU 15N 2L P p/DRP', 'MTCU 15N 2L P p/DRP');
INSERT INTO obras.maestro_estructura VALUES (662, 'MTCU 15C 2L P p/DRP', 'MTCU 15C 2L P p/DRP');
INSERT INTO obras.maestro_estructura VALUES (663, 'MTCU 15N 3L P p/DRP', 'MTCU 15N 3L P p/DRP');
INSERT INTO obras.maestro_estructura VALUES (664, 'BARRA SECO1PC 3C', 'BARRA SECO1PC 3C');
INSERT INTO obras.maestro_estructura VALUES (665, 'BARRA SECO1PC 4C', 'BARRA SECO1PC 4C');
INSERT INTO obras.maestro_estructura VALUES (666, 'BARRA SECO1PC 5C', 'BARRA SECO1PC 5C');
INSERT INTO obras.maestro_estructura VALUES (667, 'MTCO 15N 2 A2PE', 'MTCO 15N 2 A2PE');
INSERT INTO obras.maestro_estructura VALUES (668, 'MTCO 15N 2 A2PES', 'MTCO 15N 2 A2PES');
INSERT INTO obras.maestro_estructura VALUES (669, 'MTCO 15N 3 PC', 'MTCO 15N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (670, 'MTCO 15V 3 A2PE', 'MTCO 15V 3 A2PE');
INSERT INTO obras.maestro_estructura VALUES (671, 'MTCO 15V 3 A2PES', 'MTCO 15V 3 A2PES');
INSERT INTO obras.maestro_estructura VALUES (672, 'MTCO 15V 3 PA', 'MTCO 15V 3 PA');
INSERT INTO obras.maestro_estructura VALUES (673, 'MTCO 15V 3 PC', 'MTCO 15V 3 PC');
INSERT INTO obras.maestro_estructura VALUES (674, 'MTCO 23N 2 A2PES', 'MTCO 23N 2 A2PES');
INSERT INTO obras.maestro_estructura VALUES (675, 'MTCO 23N 3 A2PE', 'MTCO 23N 3 A2PE');
INSERT INTO obras.maestro_estructura VALUES (676, 'MTCO 23N 3 A2PES', 'MTCO 23N 3 A2PES');
INSERT INTO obras.maestro_estructura VALUES (677, 'MTCO 23N 3 PA', 'MTCO 23N 3 PA');
INSERT INTO obras.maestro_estructura VALUES (678, 'MTCO 23N 3 PC', 'MTCO 23N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (679, 'MTCO 23N 3 PS', 'MTCO 23N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (680, 'MTCO 23N 3 RS', 'MTCO 23N 3 RS');
INSERT INTO obras.maestro_estructura VALUES (681, 'MTCO 23V 3 PA', 'MTCO 23V 3 PA');
INSERT INTO obras.maestro_estructura VALUES (682, 'MTCO 23V 3 PC', 'MTCO 23V 3 PC');
INSERT INTO obras.maestro_estructura VALUES (683, 'MTCO SE2PC 15N', 'MTCO SE2PC 15N');
INSERT INTO obras.maestro_estructura VALUES (684, 'MTCO SE2PC 15V', 'MTCO SE2PC 15V');
INSERT INTO obras.maestro_estructura VALUES (685, 'MTCO SE2PC 23N', 'MTCO SE2PC 23N');
INSERT INTO obras.maestro_estructura VALUES (686, 'MTCO SE2PC 23V', 'MTCO SE2PC 23V');
INSERT INTO obras.maestro_estructura VALUES (687, 'DF 8kAR 2ø', 'DF 8kAR 2ø');
INSERT INTO obras.maestro_estructura VALUES (688, 'DF 12kAR 2ø', 'DF 12kAR 2ø');
INSERT INTO obras.maestro_estructura VALUES (689, 'DF 8kAR 3ø', 'DF 8kAR 3ø');
INSERT INTO obras.maestro_estructura VALUES (690, 'DF 12kAR 3ø', 'DF 12kAR 3ø');
INSERT INTO obras.maestro_estructura VALUES (691, 'SC 300A 2ø', 'SC 300A 2ø');
INSERT INTO obras.maestro_estructura VALUES (692, 'SC 900A 2ø', 'SC 900A 2ø');
INSERT INTO obras.maestro_estructura VALUES (693, 'SC 300A 3ø', 'SC 300A 3ø');
INSERT INTO obras.maestro_estructura VALUES (694, 'SC 900A 3ø', 'SC 900A 3ø');
INSERT INTO obras.maestro_estructura VALUES (695, 'PC 18.0 m', 'PC 18.0 m');
INSERT INTO obras.maestro_estructura VALUES (696, 'PC 16.5 m', 'PC 16.5 m');
INSERT INTO obras.maestro_estructura VALUES (697, 'EPC 1.15 m', 'EPC 1.15 m');
INSERT INTO obras.maestro_estructura VALUES (698, 'EPC 2.10 m', 'EPC 2.10 m');
INSERT INTO obras.maestro_estructura VALUES (699, 'EM 3ø AT c/TMC', 'EM 3ø AT c/TMC');
INSERT INTO obras.maestro_estructura VALUES (700, 'BC Prot.2doPlano', 'BC Prot.2doPlano');
INSERT INTO obras.maestro_estructura VALUES (701, 'BC Prot.1er.Plano', 'BC Prot.1er.Plano');
INSERT INTO obras.maestro_estructura VALUES (702, 'MMT 3ø Cu L', 'MMT 3ø Cu L');
INSERT INTO obras.maestro_estructura VALUES (703, 'MMT 2ø Cu L', 'MMT 2ø Cu L');
INSERT INTO obras.maestro_estructura VALUES (704, 'MMT 3ø Cu M', 'MMT 3ø Cu M');
INSERT INTO obras.maestro_estructura VALUES (705, 'MMT 2ø Cu M', 'MMT 2ø Cu M');
INSERT INTO obras.maestro_estructura VALUES (706, 'MMT 3ø Al L', 'MMT 3ø Al L');
INSERT INTO obras.maestro_estructura VALUES (707, 'MMT 2ø Al L', 'MMT 2ø Al L');
INSERT INTO obras.maestro_estructura VALUES (708, 'MTCU 15N 3L JP', 'MTCU 15N 3L JP');
INSERT INTO obras.maestro_estructura VALUES (709, 'MTCU 15N 3M JP', 'MTCU 15N 3M JP');
INSERT INTO obras.maestro_estructura VALUES (710, 'MTCU 15N 3P JP', 'MTCU 15N 3P JP');
INSERT INTO obras.maestro_estructura VALUES (711, 'MTCU 15V 3L JP', 'MTCU 15V 3L JP');
INSERT INTO obras.maestro_estructura VALUES (712, 'MTCU 15V 3M JP', 'MTCU 15V 3M JP');
INSERT INTO obras.maestro_estructura VALUES (713, 'MTCU 15V 3P JP', 'MTCU 15V 3P JP');
INSERT INTO obras.maestro_estructura VALUES (714, 'MTCU 15C 3L JP', 'MTCU 15C 3L JP');
INSERT INTO obras.maestro_estructura VALUES (715, 'MTCU 15C 3M JP', 'MTCU 15C 3M JP');
INSERT INTO obras.maestro_estructura VALUES (716, 'MTCU 15C 3P JP', 'MTCU 15C 3P JP');
INSERT INTO obras.maestro_estructura VALUES (717, 'MTCU 15E 3L JP', 'MTCU 15E 3L JP');
INSERT INTO obras.maestro_estructura VALUES (718, 'MTCU 15E 3M JP', 'MTCU 15E 3M JP');
INSERT INTO obras.maestro_estructura VALUES (719, 'MTCU 15E 3P JP', 'MTCU 15E 3P JP');
INSERT INTO obras.maestro_estructura VALUES (720, 'MTAL 15N 3L JP', 'MTAL 15N 3L JP');
INSERT INTO obras.maestro_estructura VALUES (721, 'MTAL 15N 3P JP', 'MTAL 15N 3P JP');
INSERT INTO obras.maestro_estructura VALUES (722, 'MTAL 15V 3L JP', 'MTAL 15V 3L JP');
INSERT INTO obras.maestro_estructura VALUES (723, 'MTAL 15V 3P JP', 'MTAL 15V 3P JP');
INSERT INTO obras.maestro_estructura VALUES (724, 'MTCU 23N 3L JP', 'MTCU 23N 3L JP');
INSERT INTO obras.maestro_estructura VALUES (725, 'MTCU 23N 3M JP', 'MTCU 23N 3M JP');
INSERT INTO obras.maestro_estructura VALUES (726, 'MTCU 23N 3P JP', 'MTCU 23N 3P JP');
INSERT INTO obras.maestro_estructura VALUES (727, 'MTCU 23V 3L JP', 'MTCU 23V 3L JP');
INSERT INTO obras.maestro_estructura VALUES (728, 'MTCU 23V 3M JP', 'MTCU 23V 3M JP');
INSERT INTO obras.maestro_estructura VALUES (729, 'MTCU 23V 3P JP', 'MTCU 23V 3P JP');
INSERT INTO obras.maestro_estructura VALUES (730, 'MTAL 23N 3L JP', 'MTAL 23N 3L JP');
INSERT INTO obras.maestro_estructura VALUES (731, 'MTAL 23N 3P JP', 'MTAL 23N 3P JP');
INSERT INTO obras.maestro_estructura VALUES (732, 'MTAL 23V 3L JP', 'MTAL 23V 3L JP');
INSERT INTO obras.maestro_estructura VALUES (733, 'MTAL 23V 3P JP', 'MTAL 23V 3P JP');
INSERT INTO obras.maestro_estructura VALUES (734, 'MTCU 15N 2L JP', 'MTCU 15N 2L JP');
INSERT INTO obras.maestro_estructura VALUES (735, 'MTCU 15V 2L JP', 'MTCU 15V 2L JP');
INSERT INTO obras.maestro_estructura VALUES (736, 'MTCU 15C 2L JP', 'MTCU 15C 2L JP');
INSERT INTO obras.maestro_estructura VALUES (737, 'MTCU 15E 2L JP', 'MTCU 15E 2L JP');
INSERT INTO obras.maestro_estructura VALUES (738, 'MTAL 15N 2L JP', 'MTAL 15N 2L JP');
INSERT INTO obras.maestro_estructura VALUES (739, 'MTAL 15V 2L JP', 'MTAL 15V 2L JP');
INSERT INTO obras.maestro_estructura VALUES (740, 'MTCU 23N 2L JP', 'MTCU 23N 2L JP');
INSERT INTO obras.maestro_estructura VALUES (741, 'MTCU 23V 2L JP', 'MTCU 23V 2L JP');
INSERT INTO obras.maestro_estructura VALUES (742, 'MTAL 23N 2L JP', 'MTAL 23N 2L JP');
INSERT INTO obras.maestro_estructura VALUES (743, 'MTAL 23V 2L JP', 'MTAL 23V 2L JP');
INSERT INTO obras.maestro_estructura VALUES (744, 'CPr 95 mm2 3ø 15 KV', 'CPr 95 mm2 3ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (745, 'MTCO 15N 3 A2PE', 'MTCO 15N 3 A2PE');
INSERT INTO obras.maestro_estructura VALUES (746, 'MTCO 15N 3 A2PES', 'MTCO 15N 3 A2PES');
INSERT INTO obras.maestro_estructura VALUES (747, 'MTCO 15N 3 PA', 'MTCO 15N 3 PA');
INSERT INTO obras.maestro_estructura VALUES (748, 'MTCO 15N 3 PS', 'MTCO 15N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (749, 'MTCO 15N 3 RS', 'MTCO 15N 3 RS');
INSERT INTO obras.maestro_estructura VALUES (750, 'SE 2F p/DRP', 'SE 2F p/DRP');
INSERT INTO obras.maestro_estructura VALUES (751, 'CCu 16 mm2  2ø', 'CCu 16 mm2  2ø');
INSERT INTO obras.maestro_estructura VALUES (752, 'CCu 16 mm2  3ø', 'CCu 16 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (753, 'CCu 25 mm2  2ø', 'CCu 25 mm2  2ø');
INSERT INTO obras.maestro_estructura VALUES (754, 'CCu 25 mm2  3ø', 'CCu 25 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (755, 'CCu 33,6 mm2  2ø', 'CCu 33,6 mm2  2ø');
INSERT INTO obras.maestro_estructura VALUES (756, 'CCu 33,6 mm2  3ø', 'CCu 33,6 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (757, 'CCu 53,5 mm2  2ø', 'CCu 53,5 mm2  2ø');
INSERT INTO obras.maestro_estructura VALUES (758, 'CCu 53,5 mm2  3ø', 'CCu 53,5 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (759, 'CCu 67,4 mm2  2ø', 'CCu 67,4 mm2  2ø');
INSERT INTO obras.maestro_estructura VALUES (760, 'CCu 67,4 mm2  3ø', 'CCu 67,4 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (761, 'CCu 85 mm2  3ø', 'CCu 85 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (762, 'CAl 2 AAAC 2ø', 'CAl 2 AAAC 2ø');
INSERT INTO obras.maestro_estructura VALUES (763, 'CAl 2 AAAC 3ø', 'CAl 2 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (764, 'CAl 1/0 AAAC 2ø OLD', 'CAl 1/0 AAAC 2ø OLD');
INSERT INTO obras.maestro_estructura VALUES (765, 'CAl 1/0 AAAC 3ø OLD', 'CAl 1/0 AAAC 3ø OLD');
INSERT INTO obras.maestro_estructura VALUES (766, 'CAl 3/0 AAAC 3ø', 'CAl 3/0 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (767, 'CCo 70 mm2 3ø 15 KV', 'CCo 70 mm2 3ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (768, 'CCo 95 mm2 3ø 15 KV', 'CCo 95 mm2 3ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (769, 'CCo 150 mm2 3ø 15KV', 'CCo 150 mm2 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (770, 'CCo 50 mm2 3ø 25 KV', 'CCo 50 mm2 3ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (771, 'MTCU 15N 3M JIA', 'MTCU 15N 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (772, 'MTCU 15N 3P JIA', 'MTCU 15N 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (773, 'MTCU 15C 3M JIA', 'MTCU 15C 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (774, 'MTCU 15C 3P JIA', 'MTCU 15C 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (775, 'MTCU 15V 3M JIA', 'MTCU 15V 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (776, 'MTCU 15V 3P JIA', 'MTCU 15V 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (777, 'MTCU 23N 3M JIA', 'MTCU 23N 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (778, 'MTCU 23N 3P JIA', 'MTCU 23N 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (779, 'MTAL 15N 3L JIA', 'MTAL 15N 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (780, 'MTAL 15N 3P JIA', 'MTAL 15N 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (781, 'MTAL 15V 3L JIA', 'MTAL 15V 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (782, 'MTAL 15V 3P JIA', 'MTAL 15V 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (783, 'MTAL 23N 3L JIA', 'MTAL 23N 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (784, 'MTAL 23N 3P JIA', 'MTAL 23N 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (785, 'MTCU 15E 3M JIA', 'MTCU 15E 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (786, 'MTCU 15E 3P JIA', 'MTCU 15E 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (787, 'MTCU 23V 3M JIA', 'MTCU 23V 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (788, 'MTCU 23V 3P JIA', 'MTCU 23V 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (789, 'MTAL 23V 3L JIA', 'MTAL 23V 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (790, 'MTAL 23V 3P JIA', 'MTAL 23V 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (791, 'MTCU 15C 3L JIA', 'MTCU 15C 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (792, 'MTCU 15N 3L JIA', 'MTCU 15N 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (793, 'MTCU 23N 3L JIA', 'MTCU 23N 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (794, 'MTCU 15V 3L JIA', 'MTCU 15V 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (795, 'MTCU 23V 3L JIA', 'MTCU 23V 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (796, 'MTCU 15E 3L JIA', 'MTCU 15E 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (797, 'TMC 3ø 15KV 80-160/5', 'TMC 3ø 15KV 80-160/5');
INSERT INTO obras.maestro_estructura VALUES (798, 'TMC 3ø 15KV 20-80/5A', 'TMC 3ø 15KV 20-80/5A');
INSERT INTO obras.maestro_estructura VALUES (799, 'TMC 3ø 25KV 40-80/5A', 'TMC 3ø 25KV 40-80/5A');
INSERT INTO obras.maestro_estructura VALUES (800, 'TMC 3ø 15KV 2,5-10/5', 'TMC 3ø 15KV 2,5-10/5');
INSERT INTO obras.maestro_estructura VALUES (801, 'TMC 3ø 25KV 10-20/5A', 'TMC 3ø 25KV 10-20/5A');
INSERT INTO obras.maestro_estructura VALUES (802, 'BC 750KVAR', 'BC 750KVAR');
INSERT INTO obras.maestro_estructura VALUES (803, 'PR 2ø 15KV', 'PR 2ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (804, 'PR 3ø 15KV', 'PR 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (805, 'PR 2ø 23KV', 'PR 2ø 23KV');
INSERT INTO obras.maestro_estructura VALUES (806, 'PR 3ø 23KV', 'PR 3ø 23KV');
INSERT INTO obras.maestro_estructura VALUES (807, 'TMC 3ø 15KV 200-400/', 'TMC 3ø 15KV 200-400/');
INSERT INTO obras.maestro_estructura VALUES (808, 'BC 150KVAR', 'BC 150KVAR');
INSERT INTO obras.maestro_estructura VALUES (809, 'BC 266KVAR', 'BC 266KVAR');
INSERT INTO obras.maestro_estructura VALUES (810, 'SE piso 6trf', 'SE piso 6trf');
INSERT INTO obras.maestro_estructura VALUES (811, 'SEpiso 1trf', 'SEpiso 1trf');
INSERT INTO obras.maestro_estructura VALUES (812, 'P MOZO', 'P MOZO');
INSERT INTO obras.maestro_estructura VALUES (813, 'CableCu #5AWG 3ø', 'CableCu #5AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (814, 'CableCu 5AWG 2ø', 'CableCu 5AWG 2ø');
INSERT INTO obras.maestro_estructura VALUES (815, 'AlambreCu 10mm 3ø', 'AlambreCu 10mm 3ø');
INSERT INTO obras.maestro_estructura VALUES (816, 'AlambreCu 10mm 2ø', 'AlambreCu 10mm 2ø');
INSERT INTO obras.maestro_estructura VALUES (817, 'CableCu 3AWG 3ø', 'CableCu 3AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (818, 'CableCu 3AWG 2ø', 'CableCu 3AWG 2ø');
INSERT INTO obras.maestro_estructura VALUES (819, 'AlambreCu 4AWG 3ø', 'AlambreCu 4AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (820, 'AlambreCu 4AWG 2ø', 'AlambreCu 4AWG 2ø');
INSERT INTO obras.maestro_estructura VALUES (821, 'AlACSR 1/0 3ø', 'AlACSR 1/0 3ø');
INSERT INTO obras.maestro_estructura VALUES (822, 'AlACSR 1/0 2ø', 'AlACSR 1/0 2ø');
INSERT INTO obras.maestro_estructura VALUES (823, 'AlACSR 3/0 3ø', 'AlACSR 3/0 3ø');
INSERT INTO obras.maestro_estructura VALUES (824, 'AlACSR 3/0 2ø', 'AlACSR 3/0 2ø');
INSERT INTO obras.maestro_estructura VALUES (825, 'AlambreCu 6AWG 3ø', 'AlambreCu 6AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (826, 'AlambreCu 6AWG 2ø', 'AlambreCu 6AWG 2ø');
INSERT INTO obras.maestro_estructura VALUES (827, 'AlACSR 2AWG 3ø', 'AlACSR 2AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (828, 'AlACSR 2AWG 2ø', 'AlACSR 2AWG 2ø');
INSERT INTO obras.maestro_estructura VALUES (829, 'Mont Cable Guardia', 'Mont Cable Guardia');
INSERT INTO obras.maestro_estructura VALUES (830, 'MTCU 23N 2L PCD', 'MTCU 23N 2L PCD');
INSERT INTO obras.maestro_estructura VALUES (831, 'MTCU 15C 3P PS', 'MTCU 15C 3P PS');
INSERT INTO obras.maestro_estructura VALUES (832, 'MTCU 15C 3P PD', 'MTCU 15C 3P PD');
INSERT INTO obras.maestro_estructura VALUES (833, 'MTCU 15E 3P PS', 'MTCU 15E 3P PS');
INSERT INTO obras.maestro_estructura VALUES (834, 'MTCU 15E 3P PD', 'MTCU 15E 3P PD');
INSERT INTO obras.maestro_estructura VALUES (835, 'MTCU 15N 3P PS', 'MTCU 15N 3P PS');
INSERT INTO obras.maestro_estructura VALUES (836, 'MTCU 15N 3P PD', 'MTCU 15N 3P PD');
INSERT INTO obras.maestro_estructura VALUES (837, 'MTCU 15V 3P PS', 'MTCU 15V 3P PS');
INSERT INTO obras.maestro_estructura VALUES (838, 'MTCU 15V 3P PD', 'MTCU 15V 3P PD');
INSERT INTO obras.maestro_estructura VALUES (839, 'MTCU 23N 3P PS', 'MTCU 23N 3P PS');
INSERT INTO obras.maestro_estructura VALUES (840, 'MTCU 23N 3P PD', 'MTCU 23N 3P PD');
INSERT INTO obras.maestro_estructura VALUES (841, 'MTCU 23V 3P PS', 'MTCU 23V 3P PS');
INSERT INTO obras.maestro_estructura VALUES (842, 'MTCU 23V 3P PD', 'MTCU 23V 3P PD');
INSERT INTO obras.maestro_estructura VALUES (843, 'MT BS 3ø', 'MT BS 3ø');
INSERT INTO obras.maestro_estructura VALUES (844, 'MT BS 2ø', 'MT BS 2ø');
INSERT INTO obras.maestro_estructura VALUES (845, 'Control BcoCond -OLD', 'Control BcoCond -OLD');
INSERT INTO obras.maestro_estructura VALUES (846, 'Emp. SE Portal 15N', 'Emp. SE Portal 15N');
INSERT INTO obras.maestro_estructura VALUES (847, 'Emp. SE Portal 15C', 'Emp. SE Portal 15C');
INSERT INTO obras.maestro_estructura VALUES (848, 'Emp. SE Portal 15V', 'Emp. SE Portal 15V');
INSERT INTO obras.maestro_estructura VALUES (849, 'Emp. SE Portal 23N', 'Emp. SE Portal 23N');
INSERT INTO obras.maestro_estructura VALUES (850, 'Emp. SE Portal 23V', 'Emp. SE Portal 23V');
INSERT INTO obras.maestro_estructura VALUES (851, 'MTCU 15E 3/2L A1TJS', 'MTCU 15E 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (852, 'MTCU 15E 3/2L A1TJ', 'MTCU 15E 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (853, 'MTCU 15E 3/2L A1TES', 'MTCU 15E 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (854, 'MTCU 15E 3/2L A1TE', 'MTCU 15E 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (855, 'MTAL 23N 3/2L A1TE', 'MTAL 23N 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (856, 'MTAL 23N 3/2L A1TES', 'MTAL 23N 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (857, 'MTAL 23N 3/2L A1TJ', 'MTAL 23N 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (858, 'MTAL 23N 3/2L A1TJS', 'MTAL 23N 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (859, 'MTAL 23V 3/2L A1TE', 'MTAL 23V 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (860, 'MTAL 23V 3/2L A1TES', 'MTAL 23V 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (861, 'MTAL 23V 3/2L A1TJ', 'MTAL 23V 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (862, 'MTAL 23V 3/2L A1TJS', 'MTAL 23V 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (863, 'MTCU 15C 3/2L A1TES', 'MTCU 15C 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (864, 'MTCU 15C 3/2L A1TJS', 'MTCU 15C 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (865, 'MTCU 15N 3/2L A1TES', 'MTCU 15N 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (866, 'MTCU 15N 3/2L A1TJS', 'MTCU 15N 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (867, 'MTCU 23N 3/2L A1TES', 'MTCU 23N 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (868, 'MTCU 23N 3/2L A1TJS', 'MTCU 23N 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (869, 'MTCU 15V 3/2L A1TES', 'MTCU 15V 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (870, 'MTCU 15V 3/2L A1TJS', 'MTCU 15V 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (871, 'MTCU 23V 3/2L A1TES', 'MTCU 23V 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (872, 'MTCU 23V 3/2L A1TJS', 'MTCU 23V 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (873, 'MTCU 15N 3/2L A1TE', 'MTCU 15N 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (874, 'MTCU 15N 3/2L A1TJ', 'MTCU 15N 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (875, 'MTCU 15N 3/2M A1TJ', 'MTCU 15N 3/2M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (876, 'MTCU 15C 3/2L A1TE', 'MTCU 15C 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (877, 'MTCU 15C 3/2L A1TJ', 'MTCU 15C 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (878, 'MTCU 15V 3/2L A1TE', 'MTCU 15V 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (879, 'MTCU 15V 3/2L A1TJ', 'MTCU 15V 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (880, 'MTCU 15V 3/2M A1TJ', 'MTCU 15V 3/2M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (881, 'MTCU 23N 3/2L A1TE', 'MTCU 23N 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (882, 'MTCU 23N 3/2L A1TJ', 'MTCU 23N 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (883, 'MTCU 23V 3/2L A1TE', 'MTCU 23V 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (884, 'MTCU 23V 3/2L A1TJ', 'MTCU 23V 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (885, 'MTAL 15N 3/2L A1TE', 'MTAL 15N 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (886, 'MTAL 15N 3/2L A1TES', 'MTAL 15N 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (887, 'MTAL 15N 3/2L A1TJ', 'MTAL 15N 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (888, 'MTAL 15N 3/2L A1TJS', 'MTAL 15N 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (889, 'MTAL 15V 3/2L A1TE', 'MTAL 15V 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (890, 'MTAL 15V 3/2L A1TES', 'MTAL 15V 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (891, 'MTAL 15V 3/2L A1TJ', 'MTAL 15V 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (892, 'MTAL 15V 3/2L A1TJS', 'MTAL 15V 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (893, 'MTCU 15E 3/2L A2RA', 'MTCU 15E 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (894, 'MTAL 23N 3/2L A2RA', 'MTAL 23N 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (895, 'MTAL 23V 3/2L A2RA', 'MTAL 23V 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (896, 'MTCU 15N 3/2L A2RA', 'MTCU 15N 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (897, 'MTCU 15C 3/2L A2RA', 'MTCU 15C 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (898, 'MTCU 15V 3/2L A2RA', 'MTCU 15V 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (899, 'MTCU 23N 3/2L A2RA', 'MTCU 23N 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (900, 'MTCU 23V 3/2L A2RA', 'MTCU 23V 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (901, 'MTAL 15N 3/2L A2RA', 'MTAL 15N 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (902, 'MTAL 15V 3/2L A2RA', 'MTAL 15V 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (903, 'MTCU 15E 3/2L A2RE', 'MTCU 15E 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (904, 'MTAL 23N 3/2L A2RE', 'MTAL 23N 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (905, 'MTAL 23V 3/2L A2RE', 'MTAL 23V 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (906, 'MTCU 15N 3/2L A2RE', 'MTCU 15N 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (907, 'MTCU 15C 3/2L A2RE', 'MTCU 15C 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (908, 'MTCU 15V 3/2L A2RE', 'MTCU 15V 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (909, 'MTCU 23N 3/2L A2RE', 'MTCU 23N 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (910, 'MTCU 23V 3/2L A2RE', 'MTCU 23V 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (911, 'MTAL 15N 3/2L A2RE', 'MTAL 15N 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (912, 'MTAL 15V 3/2L A2RE', 'MTAL 15V 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (913, 'MTCU 15E 2/3L A1TE', 'MTCU 15E 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (914, 'MTCU 15E 2/3M A1TE', 'MTCU 15E 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (915, 'MTAL 23N 2/3L A1TE', 'MTAL 23N 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (916, 'MTAL 23V 2/3L A1TE', 'MTAL 23V 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (917, 'MTCU 15N 2/3L A1TE', 'MTCU 15N 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (918, 'MTCU 15N 2/3M A1TE', 'MTCU 15N 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (919, 'MTCU 15C 2/3L A1TE', 'MTCU 15C 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (920, 'MTCU 15C 2/3M A1TE', 'MTCU 15C 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (921, 'MTCU 15V 2/3L A1TE', 'MTCU 15V 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (922, 'MTCU 15V 2/3M A1TE', 'MTCU 15V 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (923, 'MTCU 23N 2/3L A1TE', 'MTCU 23N 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (924, 'MTCU 23N 2/3M A1TE', 'MTCU 23N 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (925, 'MTCU 23V 2/3L A1TE', 'MTCU 23V 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (926, 'MTCU 23V 2/3M A1TE', 'MTCU 23V 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (927, 'MTAL 15N 2/3L A1TE', 'MTAL 15N 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (928, 'MTAL 15V 2/3L A1TE', 'MTAL 15V 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (929, 'MTAL 15N 2/3L A1TES', 'MTAL 15N 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (930, 'MTAL 15V 2/3L A1TES', 'MTAL 15V 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (931, 'MTAL 23N 2/3L A1TES', 'MTAL 23N 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (932, 'MTAL 23V 2/3L A1TES', 'MTAL 23V 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (933, 'MTCU 15C 2/3L A1TES', 'MTCU 15C 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (934, 'MTCU 15C 2/3M A1TES', 'MTCU 15C 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (935, 'MTCU 15E 2/3L A1TES', 'MTCU 15E 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (936, 'MTCU 15E 2/3M A1TES', 'MTCU 15E 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (937, 'MTCU 15N 2/3L A1TES', 'MTCU 15N 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (938, 'MTCU 15N 2/3M A1TES', 'MTCU 15N 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (939, 'MTCU 15V 2/3L A1TES', 'MTCU 15V 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (940, 'MTCU 15V 2/3M A1TES', 'MTCU 15V 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (941, 'MTCU 23N 2/3L A1TES', 'MTCU 23N 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (942, 'MTCU 23N 2/3M A1TES', 'MTCU 23N 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (943, 'MTCU 23V 2/3L A1TES', 'MTCU 23V 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (944, 'MTCU 23V 2/3M A1TES', 'MTCU 23V 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (945, 'MONT REC sin cuch', 'MONT REC sin cuch');
INSERT INTO obras.maestro_estructura VALUES (946, 'MONT REC S2PLANO', 'MONT REC S2PLANO');
INSERT INTO obras.maestro_estructura VALUES (947, 'MONT REGULADOR DE VO', 'MONT REGULADOR DE VO');
INSERT INTO obras.maestro_estructura VALUES (948, 'CableCuCW 2/0AWG 3ø', 'CableCuCW 2/0AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (949, 'CableCuCW 5AWG 3ø', 'CableCuCW 5AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (950, 'AAAC 312MCM 3F 15kV', 'AAAC 312MCM 3F 15kV');
INSERT INTO obras.maestro_estructura VALUES (951, 'CableCuCW 10AWG 3ø', 'CableCuCW 10AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (952, 'CableCuCW 7AWG 3ø', 'CableCuCW 7AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (953, 'Al ACSR 3AWG 3ø', 'Al ACSR 3AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (954, 'Al ACSR 4/0 AWG 3ø', 'Al ACSR 4/0 AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (955, 'CableCu 350 MCM 3ø', 'CableCu 350 MCM 3ø');
INSERT INTO obras.maestro_estructura VALUES (956, 'CableCuCW 5AWG 2ø', 'CableCuCW 5AWG 2ø');
INSERT INTO obras.maestro_estructura VALUES (957, 'Al ACSR 3AWG 2ø', 'Al ACSR 3AWG 2ø');
INSERT INTO obras.maestro_estructura VALUES (958, 'Cable Guardia', 'Cable Guardia');
INSERT INTO obras.maestro_estructura VALUES (959, 'Mont Omnirrupter', 'Mont Omnirrupter');
INSERT INTO obras.maestro_estructura VALUES (960, 'CCo 70 mm2 3ø 25 KV', 'CCo 70 mm2 3ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (961, 'CCo 70 mm2 2ø 25 KV', 'CCo 70 mm2 2ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (962, 'CCo 70 mm2 2ø 15 KV', 'CCo 70 mm2 2ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (963, 'CCo 95 mm2 2ø 15 KV', 'CCo 95 mm2 2ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (964, 'CCo 50 mm2 2ø 25 KV', 'CCo 50 mm2 2ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (965, 'CPr 70 mm2 3ø 25 KV', 'CPr 70 mm2 3ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (966, 'CPr 70 mm2 2ø 25 KV', 'CPr 70 mm2 2ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (967, 'CPr 70 mm2 2ø 15 KV', 'CPr 70 mm2 2ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (968, 'CPr 70 mm2 3ø 15 KV', 'CPr 70 mm2 3ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (969, 'MTProt 15N 3 PS', 'MTProt 15N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (970, 'MTProt 15V 3 PS', 'MTProt 15V 3 PS');
INSERT INTO obras.maestro_estructura VALUES (971, 'MTProt 23N 3 PS', 'MTProt 23N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (972, 'MTProt 23V 3 PS', 'MTProt 23V 3 PS');
INSERT INTO obras.maestro_estructura VALUES (973, 'MTProt 15N 2 PS', 'MTProt 15N 2 PS');
INSERT INTO obras.maestro_estructura VALUES (974, 'MTProt 15V 2 PS', 'MTProt 15V 2 PS');
INSERT INTO obras.maestro_estructura VALUES (975, 'MTProt 23N 2 PS', 'MTProt 23N 2 PS');
INSERT INTO obras.maestro_estructura VALUES (976, 'MTProt 23V 2 PS', 'MTProt 23V 2 PS');
INSERT INTO obras.maestro_estructura VALUES (977, 'MTProt 23V 2 RS', 'MTProt 23V 2 RS');
INSERT INTO obras.maestro_estructura VALUES (978, 'MTProt 23V 3 RS', 'MTProt 23V 3 RS');
INSERT INTO obras.maestro_estructura VALUES (979, 'MTProt 15V 2 RS', 'MTProt 15V 2 RS');
INSERT INTO obras.maestro_estructura VALUES (980, 'MTProt 15V 3 RS', 'MTProt 15V 3 RS');
INSERT INTO obras.maestro_estructura VALUES (981, 'MTProt 23N 2 RS', 'MTProt 23N 2 RS');
INSERT INTO obras.maestro_estructura VALUES (982, 'MTProt 23N 3 RS', 'MTProt 23N 3 RS');
INSERT INTO obras.maestro_estructura VALUES (983, 'MTProt 15N 2 RS', 'MTProt 15N 2 RS');
INSERT INTO obras.maestro_estructura VALUES (984, 'MTProt 15N 3 RS', 'MTProt 15N 3 RS');
INSERT INTO obras.maestro_estructura VALUES (985, 'MTCO 23N 2 RS', 'MTCO 23N 2 RS');
INSERT INTO obras.maestro_estructura VALUES (986, 'MTCO 15N 2 RS', 'MTCO 15N 2 RS');
INSERT INTO obras.maestro_estructura VALUES (987, 'MTCO 15N 2 PC', 'MTCO 15N 2 PC');
INSERT INTO obras.maestro_estructura VALUES (988, 'MTCO 15V 2 PC', 'MTCO 15V 2 PC');
INSERT INTO obras.maestro_estructura VALUES (989, 'MTCO 23N 2 PC', 'MTCO 23N 2 PC');
INSERT INTO obras.maestro_estructura VALUES (990, 'MTCO 23V 2 PC', 'MTCO 23V 2 PC');
INSERT INTO obras.maestro_estructura VALUES (991, 'MTCO 15V 2 PA', 'MTCO 15V 2 PA');
INSERT INTO obras.maestro_estructura VALUES (992, 'MTCO 23N 2 PA', 'MTCO 23N 2 PA');
INSERT INTO obras.maestro_estructura VALUES (993, 'MTCO 15N 2 PA', 'MTCO 15N 2 PA');
INSERT INTO obras.maestro_estructura VALUES (994, 'MTCO 23V 3 RS', 'MTCO 23V 3 RS');
INSERT INTO obras.maestro_estructura VALUES (995, 'MTCO 15V 3 RS', 'MTCO 15V 3 RS');
INSERT INTO obras.maestro_estructura VALUES (996, 'MTCO 23V 2 RS', 'MTCO 23V 2 RS');
INSERT INTO obras.maestro_estructura VALUES (997, 'MTCO 15V 2 RS', 'MTCO 15V 2 RS');
INSERT INTO obras.maestro_estructura VALUES (998, 'Apoyo 2º Plano 3ø 15', 'Apoyo 2º Plano 3ø 15');
INSERT INTO obras.maestro_estructura VALUES (999, 'Apoyo 2º Plano 3ø 23', 'Apoyo 2º Plano 3ø 23');
INSERT INTO obras.maestro_estructura VALUES (1000, 'CPr 70 mm2 3ø 15KV', 'CPr 70 mm2 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (1001, 'DUCTO PVC MT 4 X 63', 'DUCTO PVC MT 4 X 63');
INSERT INTO obras.maestro_estructura VALUES (1002, 'DUCTO PVC MT 4 X 90', 'DUCTO PVC MT 4 X 90');
INSERT INTO obras.maestro_estructura VALUES (1003, 'DUCTO PVC BT 1 X 110', 'DUCTO PVC BT 1 X 110');
INSERT INTO obras.maestro_estructura VALUES (1004, 'DUCTO CONCRETO MT', 'DUCTO CONCRETO MT');
INSERT INTO obras.maestro_estructura VALUES (1005, 'DUCTO CONCRETO BT', 'DUCTO CONCRETO BT');
INSERT INTO obras.maestro_estructura VALUES (1006, 'XLPE #2AWG 3ø 15KV', 'XLPE #2AWG 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (1007, 'XLPE #3/0AWG 3F 15KV', 'XLPE #3/0AWG 3F 15KV');
INSERT INTO obras.maestro_estructura VALUES (1008, 'XLPE 120 mm ²3F 15KV', 'XLPE 120 mm ²3F 15KV');
INSERT INTO obras.maestro_estructura VALUES (1009, ' XLPE # 1 AWG 3F 23K', ' XLPE # 1 AWG 3F 23K');
INSERT INTO obras.maestro_estructura VALUES (1010, 'Trip. Bicc 25mm2 3F', 'Trip. Bicc 25mm2 3F');
INSERT INTO obras.maestro_estructura VALUES (1011, 'Mono. BICC 240mm2 3F', 'Mono. BICC 240mm2 3F');
INSERT INTO obras.maestro_estructura VALUES (1012, 'Trip. BICC 150mm2 3ø', 'Trip. BICC 150mm2 3ø');
INSERT INTO obras.maestro_estructura VALUES (1013, 'Trip. BICC 50mm2 3ø', 'Trip. BICC 50mm2 3ø');
INSERT INTO obras.maestro_estructura VALUES (1014, 'Trip. BICC 95mm2 3ø', 'Trip. BICC 95mm2 3ø');
INSERT INTO obras.maestro_estructura VALUES (1015, 'XLPE  240 mm2 3F 15K', 'XLPE  240 mm2 3F 15K');
INSERT INTO obras.maestro_estructura VALUES (1016, 'Mono.Tipo ET # 2 AWG', 'Mono.Tipo ET # 2 AWG');
INSERT INTO obras.maestro_estructura VALUES (1017, 'Mufa Terminal Interi', 'Mufa Terminal Interi');
INSERT INTO obras.maestro_estructura VALUES (1018, 'Codo 200A 2 AWG 15 K', 'Codo 200A 2 AWG 15 K');
INSERT INTO obras.maestro_estructura VALUES (1019, 'Codo 200A 3/0 AWG 15', 'Codo 200A 3/0 AWG 15');
INSERT INTO obras.maestro_estructura VALUES (1020, 'Mufa Trans. 2 AWG Mo', 'Mufa Trans. 2 AWG Mo');
INSERT INTO obras.maestro_estructura VALUES (1021, 'Bota 90Gr 2AWG 600A', 'Bota 90Gr 2AWG 600A');
INSERT INTO obras.maestro_estructura VALUES (1022, 'PM 6.0m', 'PM 6.0m');
INSERT INTO obras.maestro_estructura VALUES (1023, 'BT P 57 M SB nrst', 'BT P 57 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1024, 'BT P 57 M B1  nrst', 'BT P 57 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1025, 'BT P 57 M B2  nrst', 'BT P 57 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1026, 'BT P 57 B SB nrst', 'BT P 57 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1027, 'BT P 57 B B1  nrst', 'BT P 57 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1028, 'BT P 57 B B2  nrst', 'BT P 57 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1029, 'BT P 57 M SB nrs', 'BT P 57 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1030, 'BT P 57 M SB nrt', 'BT P 57 M SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1031, 'BT P 57 M SB nst', 'BT P 57 M SB nst');
INSERT INTO obras.maestro_estructura VALUES (1032, 'BT P 57 M SB nr', 'BT P 57 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1033, 'BT P 57 M SB ns', 'BT P 57 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1034, 'BT P 57 M SB nt', 'BT P 57 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1035, 'BT P 57 M SB n', 'BT P 57 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1036, 'BT P 57 M B1  nrs', 'BT P 57 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1037, 'BT P 57 M B1  nrt', 'BT P 57 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1038, 'BT P 57 M B1  nst', 'BT P 57 M B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1039, 'BT P 57 M B1  nr', 'BT P 57 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1040, 'BT P 57 M B1  ns', 'BT P 57 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1041, 'BT P 57 M B1  nt', 'BT P 57 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1042, 'BT P 57 M B1  n', 'BT P 57 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1043, 'BT P 57 M B2  nrs', 'BT P 57 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1044, 'BT P 57 M B2  nrt', 'BT P 57 M B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1045, 'BT P 57 M B2  nst', 'BT P 57 M B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1046, 'BT P 57 M B2  nr', 'BT P 57 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1047, 'BT P 57 M B2  ns', 'BT P 57 M B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1048, 'BT P 57 M B2  nt', 'BT P 57 M B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1049, 'BT P 57 M B2  n', 'BT P 57 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1050, 'BT P 57 B SB nrs', 'BT P 57 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1051, 'BT P 57 B SB nrt', 'BT P 57 B SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1052, 'BT P 57 B SB nst', 'BT P 57 B SB nst');
INSERT INTO obras.maestro_estructura VALUES (1053, 'BT P 57 B SB nr', 'BT P 57 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1054, 'BT P 57 B SB ns', 'BT P 57 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1055, 'BT P 57 B SB nt', 'BT P 57 B SB nt');
INSERT INTO obras.maestro_estructura VALUES (1056, 'BT P 57 B SB n', 'BT P 57 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1057, 'BT P 57 B B1  nrs', 'BT P 57 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1058, 'BT P 57 B B1  nrt', 'BT P 57 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1059, 'BT P 57 B B1  nst', 'BT P 57 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1060, 'BT P 57 B B1  nr', 'BT P 57 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1061, 'BT P 57 B B1  ns', 'BT P 57 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1062, 'BT P 57 B B1  nt', 'BT P 57 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1063, 'BT P 57 B B1  n', 'BT P 57 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1064, 'BT P 57 B B2  nrs', 'BT P 57 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1065, 'BT P 57 B B2  nrt', 'BT P 57 B B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1066, 'BT P 57 B B2  nst', 'BT P 57 B B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1067, 'BT P 57 B B2  nr', 'BT P 57 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1068, 'BT P 57 B B2  ns', 'BT P 57 B B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1069, 'BT P 57 B B2  nt', 'BT P 57 B B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1070, 'BT P 57 B B2  n', 'BT P 57 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1071, 'BT P 76 M SB nrst', 'BT P 76 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1072, 'BT P 76 M B1  nrst', 'BT P 76 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1073, 'BT P 76 M B2  nrst', 'BT P 76 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1074, 'BT P 76 B SB nrst', 'BT P 76 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1075, 'BT P 76 B B1  nrst', 'BT P 76 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1076, 'BT P 76 B B2  nrst', 'BT P 76 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1077, 'BT P 76 M SB nrs', 'BT P 76 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1078, 'BT P 76 M SB nrt', 'BT P 76 M SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1079, 'BT P 76 M SB nst', 'BT P 76 M SB nst');
INSERT INTO obras.maestro_estructura VALUES (1080, 'BT P 76 M SB nr', 'BT P 76 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1081, 'BT P 76 M SB ns', 'BT P 76 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1082, 'BT P 76 M SB nt', 'BT P 76 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1083, 'BT P 76 M SB n', 'BT P 76 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1084, 'BT P 76 M B1  nrs', 'BT P 76 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1085, 'BT P 76 M B1  nrt', 'BT P 76 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1086, 'BT P 76 M B1  nst', 'BT P 76 M B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1087, 'BT P 76 M B1  nr', 'BT P 76 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1088, 'BT P 76 M B1  ns', 'BT P 76 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1089, 'BT P 76 M B1  nt', 'BT P 76 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1090, 'BT P 76 M B1  n', 'BT P 76 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1091, 'BT P 76 M B2  nrs', 'BT P 76 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1092, 'BT P 76 M B2  nrt', 'BT P 76 M B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1093, 'BT P 76 M B2  nst', 'BT P 76 M B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1094, 'BT P 76 M B2  nr', 'BT P 76 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1095, 'BT P 76 M B2  ns', 'BT P 76 M B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1096, 'BT P 76 M B2  nt', 'BT P 76 M B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1097, 'BT P 76 M B2  n', 'BT P 76 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1098, 'BT P 76 B SB nrs', 'BT P 76 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1099, 'BT P 76 B SB nrt', 'BT P 76 B SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1100, 'BT P 76 B SB nst', 'BT P 76 B SB nst');
INSERT INTO obras.maestro_estructura VALUES (1101, 'BT P 76 B SB nr', 'BT P 76 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1102, 'BT P 76 B SB ns', 'BT P 76 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1103, 'BT P 76 B SB nt', 'BT P 76 B SB nt');
INSERT INTO obras.maestro_estructura VALUES (1104, 'BT P 76 B SB n', 'BT P 76 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1105, 'BT P 76 B B1  nrs', 'BT P 76 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1106, 'BT P 76 B B1  nrt', 'BT P 76 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1107, 'BT P 76 B B1  nst', 'BT P 76 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1108, 'BT P 76 B B1  nr', 'BT P 76 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1109, 'BT P 76 B B1  ns', 'BT P 76 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1110, 'BT P 76 B B1  nt', 'BT P 76 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1111, 'BT P 76 B B1  n', 'BT P 76 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1112, 'BT P 76 B B2  nrs', 'BT P 76 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1113, 'BT P 76 B B2  nrt', 'BT P 76 B B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1114, 'BT P 76 B B2  nst', 'BT P 76 B B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1115, 'BT P 76 B B2  nr', 'BT P 76 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1116, 'BT P 76 B B2  ns', 'BT P 76 B B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1117, 'BT P 76 B B2  nt', 'BT P 76 B B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1118, 'BT P 76 B B2  n', 'BT P 76 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1119, 'BT RL 57 M SB nrst', 'BT RL 57 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1120, 'BT RL 57 M B1  nrst', 'BT RL 57 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1121, 'BT RL 57 M B2  nrst', 'BT RL 57 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1122, 'BT RL 57 B SB nrst', 'BT RL 57 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1123, 'BT RL 57 B B1  nrst', 'BT RL 57 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1124, 'BT RL 57 B B2  nrst', 'BT RL 57 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1125, 'BT RL 57 M SB nrs', 'BT RL 57 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1126, 'BT RL 57 M SB nrt', 'BT RL 57 M SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1127, 'BT RL 57 M SB nst', 'BT RL 57 M SB nst');
INSERT INTO obras.maestro_estructura VALUES (1128, 'BT RL 57 M SB nr', 'BT RL 57 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1129, 'BT RL 57 M SB ns', 'BT RL 57 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1130, 'BT RL 57 M SB nt', 'BT RL 57 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1131, 'BT RL 57 M SB n', 'BT RL 57 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1132, 'BT RL 57 M B1  nrs', 'BT RL 57 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1133, 'BT RL 57 M B1  nrt', 'BT RL 57 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1134, 'BT RL 57 M B1  nr', 'BT RL 57 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1135, 'BT RL 57 M B1  ns', 'BT RL 57 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1136, 'BT RL 57 M B1  nt', 'BT RL 57 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1137, 'BT RL 57 M B1  n', 'BT RL 57 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1138, 'BT RL 57 M B2  nrs', 'BT RL 57 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1139, 'BT RL 57 M B2  nr', 'BT RL 57 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1140, 'BT RL 57 M B2  n', 'BT RL 57 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1141, 'BT RL 57 B SB nrs', 'BT RL 57 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1142, 'BT RL 57 B SB nrt', 'BT RL 57 B SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1143, 'BT RL 57 B SB nr', 'BT RL 57 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1144, 'BT RL 57 B SB ns', 'BT RL 57 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1145, 'BT RL 57 B SB nt', 'BT RL 57 B SB nt');
INSERT INTO obras.maestro_estructura VALUES (1146, 'BT RL 57 B SB n', 'BT RL 57 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1147, 'BT RL 57 B B1  nrs', 'BT RL 57 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1148, 'BT RL 57 B B1  nrt', 'BT RL 57 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1149, 'BT RL 57 B B1  nst', 'BT RL 57 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1150, 'BT RL 57 B B1  nr', 'BT RL 57 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1151, 'BT RL 57 B B1  ns', 'BT RL 57 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1152, 'BT RL 57 B B1  nt', 'BT RL 57 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1153, 'BT RL 57 B B1  n', 'BT RL 57 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1154, 'BT RL 57 B B2  nrs', 'BT RL 57 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1155, 'BT RL 57 B B2  nr', 'BT RL 57 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1156, 'BT RL 57 B B2  n', 'BT RL 57 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1157, 'BT RL 76 M SB nrst', 'BT RL 76 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1158, 'BT RL 76 M B1  nrst', 'BT RL 76 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1159, 'BT RL 76 M B2  nrst', 'BT RL 76 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1160, 'BT RL 76 B SB nrst', 'BT RL 76 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1161, 'BT RL 76 B B1  nrst', 'BT RL 76 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1162, 'BT RL 76 B B2  nrst', 'BT RL 76 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1163, 'BT RL 76 M SB nrs', 'BT RL 76 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1164, 'BT RL 76 M SB nrt', 'BT RL 76 M SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1165, 'BT RL 76 M SB nst', 'BT RL 76 M SB nst');
INSERT INTO obras.maestro_estructura VALUES (1166, 'BT RL 76 M SB nr', 'BT RL 76 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1167, 'BT RL 76 M SB ns', 'BT RL 76 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1168, 'BT RL 76 M SB nt', 'BT RL 76 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1169, 'BT RL 76 M SB n', 'BT RL 76 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1170, 'BT RL 76 M B1  nrs', 'BT RL 76 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1171, 'BT RL 76 M B1  nrt', 'BT RL 76 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1172, 'BT RL 76 M B1  nst', 'BT RL 76 M B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1173, 'BT RL 76 M B1  nr', 'BT RL 76 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1174, 'BT RL 76 M B1  ns', 'BT RL 76 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1175, 'BT RL 76 M B1  nt', 'BT RL 76 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1176, 'BT RL 76 M B1  n', 'BT RL 76 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1177, 'BT RL 76 M B2  nrs', 'BT RL 76 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1178, 'BT RL 76 M B2  nrt', 'BT RL 76 M B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1179, 'BT RL 76 M B2  nst', 'BT RL 76 M B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1180, 'BT RL 76 M B2  nr', 'BT RL 76 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1181, 'BT RL 76 M B2  ns', 'BT RL 76 M B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1182, 'BT RL 76 M B2  nt', 'BT RL 76 M B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1183, 'BT RL 76 M B2  n', 'BT RL 76 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1184, 'BT RL 76 B SB nrs', 'BT RL 76 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1185, 'BT RL 76 B SB nrt', 'BT RL 76 B SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1186, 'BT RL 76 B SB nst', 'BT RL 76 B SB nst');
INSERT INTO obras.maestro_estructura VALUES (1187, 'BT RL 76 B SB nr', 'BT RL 76 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1188, 'BT RL 76 B SB ns', 'BT RL 76 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1189, 'BT RL 76 B SB nt', 'BT RL 76 B SB nt');
INSERT INTO obras.maestro_estructura VALUES (1190, 'BT RL 76 B SB n', 'BT RL 76 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1191, 'BT RL 76 B B1  nrs', 'BT RL 76 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1192, 'BT RL 76 B B1  nrt', 'BT RL 76 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1193, 'BT RL 76 B B1  nst', 'BT RL 76 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1194, 'BT RL 76 B B1  nr', 'BT RL 76 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1195, 'BT RL 76 B B1  ns', 'BT RL 76 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1196, 'BT RL 76 B B1  nt', 'BT RL 76 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1197, 'BT RL 76 B B1  n', 'BT RL 76 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1198, 'BT RL 76 B B2  nrs', 'BT RL 76 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1199, 'BT RL 76 B B2  nrt', 'BT RL 76 B B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1200, 'BT RL 76 B B2  nst', 'BT RL 76 B B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1201, 'BT RL 76 B B2  nr', 'BT RL 76 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1202, 'BT RL 76 B B2  ns', 'BT RL 76 B B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1203, 'BT RL 76 B B2  nt', 'BT RL 76 B B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1204, 'BT RL 76 B B2  n', 'BT RL 76 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1205, 'BT R 57 M SB nrst', 'BT R 57 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1206, 'BT R 57 M B1  nrst', 'BT R 57 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1207, 'BT R 57 M B2  nrst', 'BT R 57 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1208, 'BT R 57 M SB nrs', 'BT R 57 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1209, 'BT R 57 M SB nrt', 'BT R 57 M SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1210, 'BT R 57 M SB nst', 'BT R 57 M SB nst');
INSERT INTO obras.maestro_estructura VALUES (1211, 'BT R 57 M SB nr', 'BT R 57 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1212, 'BT R 57 M SB ns', 'BT R 57 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1213, 'BT R 57 M SB nt', 'BT R 57 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1214, 'BT R 57 M SB n', 'BT R 57 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1215, 'BT R 57 M B1  nrs', 'BT R 57 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1216, 'BT R 57 M B1  nrt', 'BT R 57 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1217, 'BT R 57 M B1  nr', 'BT R 57 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1218, 'BT R 57 M B1  ns', 'BT R 57 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1219, 'BT R 57 M B1  nt', 'BT R 57 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1220, 'BT R 57 M B1  n', 'BT R 57 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1221, 'BT R 57 M B2  nrs', 'BT R 57 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1222, 'BT R 57 M B2  nr', 'BT R 57 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1223, 'BT R 57 M B2  ns', 'BT R 57 M B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1224, 'BT R 57 M B2  n', 'BT R 57 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1225, 'BT R 57 B SB nrst', 'BT R 57 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1226, 'BT R 57 B B1  nrst', 'BT R 57 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1227, 'BT R 57 B B2  nrst', 'BT R 57 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1228, 'BT R 57 B SB nrs', 'BT R 57 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1229, 'BT R 57 B SB nst', 'BT R 57 B SB nst');
INSERT INTO obras.maestro_estructura VALUES (1230, 'BT R 57 B SB nr', 'BT R 57 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1231, 'BT R 57 B SB ns', 'BT R 57 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1232, 'BT R 57 B SB nt', 'BT R 57 B SB nt');
INSERT INTO obras.maestro_estructura VALUES (1233, 'BT R 57 B SB n', 'BT R 57 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1234, 'BT R 57 B B1  nrs', 'BT R 57 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1235, 'BT R 57 B B1  nrt', 'BT R 57 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1236, 'BT R 57 B B1  nst', 'BT R 57 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1237, 'BT R 57 B B1  nr', 'BT R 57 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1238, 'BT R 57 B B1  ns', 'BT R 57 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1239, 'BT R 57 B B1  nt', 'BT R 57 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1240, 'BT R 57 B B1  n', 'BT R 57 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1241, 'BT R 57 B B2  nrs', 'BT R 57 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1242, 'BT R 57 B B2  nr', 'BT R 57 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1243, 'BT R 57 B B2  ns', 'BT R 57 B B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1244, 'BT R 57 B B2  n', 'BT R 57 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1245, 'BT R 76 M SB nrst', 'BT R 76 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1246, 'BT R 76 M B1  nrst', 'BT R 76 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1247, 'BT R 76 M B2  nrst', 'BT R 76 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1248, 'BT R 76 M SB nrs', 'BT R 76 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1249, 'BT R 76 M SB nrt', 'BT R 76 M SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1250, 'BT R 76 M SB nst', 'BT R 76 M SB nst');
INSERT INTO obras.maestro_estructura VALUES (1251, 'BT R 76 M SB nr', 'BT R 76 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1252, 'BT R 76 M SB ns', 'BT R 76 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1253, 'BT R 76 M SB nt', 'BT R 76 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1254, 'BT R 76 M SB n', 'BT R 76 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1255, 'BT R 76 M B1  nrs', 'BT R 76 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1256, 'BT R 76 M B1  nrt', 'BT R 76 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1257, 'BT R 76 M B1  nst', 'BT R 76 M B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1258, 'BT R 76 M B1  nr', 'BT R 76 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1259, 'BT R 76 M B1  ns', 'BT R 76 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1260, 'BT R 76 M B1  nt', 'BT R 76 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1261, 'BT R 76 M B1  n', 'BT R 76 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1262, 'BT R 76 M B2  nrs', 'BT R 76 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1263, 'BT R 76 M B2  nrt', 'BT R 76 M B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1264, 'BT R 76 M B2  nst', 'BT R 76 M B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1265, 'BT R 76 M B2  nr', 'BT R 76 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1266, 'BT R 76 M B2  ns', 'BT R 76 M B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1267, 'BT R 76 M B2  nt', 'BT R 76 M B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1268, 'BT R 76 M B2  n', 'BT R 76 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1269, 'BT R 76 B SB nrst', 'BT R 76 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1270, 'BT R 76 B B1  nrst', 'BT R 76 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1271, 'BT R 76 B B2  nrst', 'BT R 76 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1272, 'BT R 76 B SB nrs', 'BT R 76 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1273, 'BT R 76 B SB nrt', 'BT R 76 B SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1274, 'BT R 76 B SB nst', 'BT R 76 B SB nst');
INSERT INTO obras.maestro_estructura VALUES (1275, 'BT R 76 B SB nr', 'BT R 76 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1276, 'BT R 76 B SB ns', 'BT R 76 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1277, 'BT R 76 B SB nt', 'BT R 76 B SB nt');
INSERT INTO obras.maestro_estructura VALUES (1278, 'BT R 76 B SB n', 'BT R 76 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1279, 'BT R 76 B B1  nrs', 'BT R 76 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1280, 'BT R 76 B B1  nrt', 'BT R 76 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1281, 'BT R 76 B B1  nst', 'BT R 76 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1282, 'BT R 76 B B1  nr', 'BT R 76 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1283, 'BT R 76 B B1  ns', 'BT R 76 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1284, 'BT R 76 B B1  nt', 'BT R 76 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1285, 'BT R 76 B B1  n', 'BT R 76 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1286, 'BT R 76 B B2  nrs', 'BT R 76 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1287, 'BT R 76 B B2  nrt', 'BT R 76 B B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1288, 'BT R 76 B B2  nst', 'BT R 76 B B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1289, 'BT R 76 B B2  nr', 'BT R 76 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1290, 'BT R 76 B B2  ns', 'BT R 76 B B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1291, 'BT R 76 B B2  nt', 'BT R 76 B B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1292, 'BT R 76 B B2  n', 'BT R 76 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1293, 'BT R2 57 M SB nrst', 'BT R2 57 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1294, 'BT R2 57 M B1  nrst', 'BT R2 57 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1295, 'BT R2 57 M B2  nrst', 'BT R2 57 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1296, 'BT R2 57 M SB nrs', 'BT R2 57 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1297, 'BT R2 57 M SB nr', 'BT R2 57 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1298, 'BT R2 57 M SB ns', 'BT R2 57 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1299, 'BT R2 57 M SB n', 'BT R2 57 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1300, 'BT R2 57 M B1  nrs', 'BT R2 57 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1301, 'BT R2 57 M B1  nrt', 'BT R2 57 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1302, 'BT R2 57 M B1  nst', 'BT R2 57 M B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1303, 'BT R2 57 M B1  nr', 'BT R2 57 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1304, 'BT R2 57 M B1  ns', 'BT R2 57 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1305, 'BT R2 57 M B1  nt', 'BT R2 57 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1306, 'BT R2 57 M B1  n', 'BT R2 57 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1307, 'BT R2 57 M B2  nrs', 'BT R2 57 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1308, 'BT R2 57 M B2  nr', 'BT R2 57 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1309, 'BT R2 57 M B2  n', 'BT R2 57 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1310, 'BT R2 57 B SB nrst', 'BT R2 57 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1311, 'BT R2 57 B B1  nrst', 'BT R2 57 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1312, 'BT R2 57 B B2  nrst', 'BT R2 57 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1313, 'BT R2 57 B SB nrs', 'BT R2 57 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1314, 'BT R2 57 B SB nst', 'BT R2 57 B SB nst');
INSERT INTO obras.maestro_estructura VALUES (1315, 'BT R2 57 B SB nr', 'BT R2 57 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1316, 'BT R2 57 B SB ns', 'BT R2 57 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1317, 'BT R2 57 B SB n', 'BT R2 57 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1318, 'BT R2 57 B B1  nrs', 'BT R2 57 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1319, 'BT R2 57 B B1  nrt', 'BT R2 57 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1320, 'BT R2 57 B B1  nst', 'BT R2 57 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1321, 'BT R2 57 B B1  nr', 'BT R2 57 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1322, 'BT R2 57 B B1  ns', 'BT R2 57 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1323, 'BT R2 57 B B1  nt', 'BT R2 57 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1324, 'BT R2 57 B B1  n', 'BT R2 57 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1325, 'BT R2 57 B B2  nrs', 'BT R2 57 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1326, 'BT R2 57 B B2  nr', 'BT R2 57 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1327, 'BT R2 57 B B2  n', 'BT R2 57 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1328, 'BT R2 76 M SB nrst', 'BT R2 76 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1329, 'BT R2 76 M B1 nrst', 'BT R2 76 M B1 nrst');
INSERT INTO obras.maestro_estructura VALUES (1330, 'BT R2 76 M B2  nrst', 'BT R2 76 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1331, 'BT R2 76 M SB nrs', 'BT R2 76 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1332, 'BT R2 76 M SB nrt', 'BT R2 76 M SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1333, 'BT R2 76 M SB nst', 'BT R2 76 M SB nst');
INSERT INTO obras.maestro_estructura VALUES (1334, 'BT R2 76 M SB nr', 'BT R2 76 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1335, 'BT R2 76 M SB ns', 'BT R2 76 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1336, 'BT R2 76 M SB nt', 'BT R2 76 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1337, 'BT R2 76 M SB n', 'BT R2 76 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1338, 'BT R2 76 M B1  nrs', 'BT R2 76 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1339, 'BT R2 76 M B1  nrt', 'BT R2 76 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1340, 'BT R2 76 M B1  nst', 'BT R2 76 M B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1341, 'BT R2 76 M B1  nr', 'BT R2 76 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1342, 'BT R2 76 M B1  ns', 'BT R2 76 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1343, 'BT R2 76 M B1  nt', 'BT R2 76 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1344, 'BT R2 76 M B1  n', 'BT R2 76 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1345, 'BT R2 76 M B2  nrs', 'BT R2 76 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1346, 'BT R2 76 M B2  nrt', 'BT R2 76 M B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1347, 'BT R2 76 M B2  nst', 'BT R2 76 M B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1348, 'BT R2 76 M B2  nr', 'BT R2 76 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1349, 'BT R2 76 M B2  ns', 'BT R2 76 M B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1350, 'BT R2 76 M B2  nt', 'BT R2 76 M B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1351, 'BT R2 76 M B2  n', 'BT R2 76 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1352, 'BT R2 76 B SB nrst', 'BT R2 76 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1353, 'BT R2 76 B B1  nrst', 'BT R2 76 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1354, 'BT R2 76 B B2  nrst', 'BT R2 76 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1355, 'BT R2 76 B SB nrs', 'BT R2 76 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1356, 'BT R2 76 B SB nrt', 'BT R2 76 B SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1357, 'BT R2 76 B SB nst', 'BT R2 76 B SB nst');
INSERT INTO obras.maestro_estructura VALUES (1358, 'BT R2 76 B SB nr', 'BT R2 76 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1359, 'BT R2 76 B SB ns', 'BT R2 76 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1360, 'BT R2 76 B SB nt', 'BT R2 76 B SB nt');
INSERT INTO obras.maestro_estructura VALUES (1361, 'BT R2 76 B SB n', 'BT R2 76 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1362, 'BT R2 76 B B1  nrs', 'BT R2 76 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1363, 'BT R2 76 B B1  nrt', 'BT R2 76 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1364, 'BT R2 76 B B1  nst', 'BT R2 76 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1365, 'BT R2 76 B B1  nr', 'BT R2 76 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1366, 'BT R2 76 B B1  ns', 'BT R2 76 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1367, 'BT R2 76 B B1  nt', 'BT R2 76 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1368, 'BT R2 76 B B1  n', 'BT R2 76 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1369, 'BT R2 76 B B2  nrs', 'BT R2 76 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1370, 'BT R2 76 B B2  nrt', 'BT R2 76 B B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1371, 'BT R2 76 B B2  nst', 'BT R2 76 B B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1372, 'BT R2 76 B B2  nr', 'BT R2 76 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1373, 'BT R2 76 B B2  ns', 'BT R2 76 B B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1374, 'BT R2 76 B B2  nt', 'BT R2 76 B B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1375, 'BT R2 76 B B2  n', 'BT R2 76 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1376, 'BT LZ 57 M SB nrst', 'BT LZ 57 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1377, 'BT LZ 57 M SB nrs', 'BT LZ 57 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1378, 'BT LZ 57 M SB nr', 'BT LZ 57 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1379, 'BT LZ 57 M SB nt', 'BT LZ 57 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1380, 'BT LZ 57 M SB n', 'BT LZ 57 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1381, 'BT LZ 57 M B1  nrst', 'BT LZ 57 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1382, 'BT LZ 57 M B1  nrs', 'BT LZ 57 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1383, 'BT LZ 57 M B1  nr', 'BT LZ 57 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1384, 'BT LZ 57 M B1  n', 'BT LZ 57 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1385, 'BT LZ 57 M B2  nrst', 'BT LZ 57 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1386, 'BT LZ 57 M B2  nrs', 'BT LZ 57 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1387, 'BT LZ 57 M B2  nr', 'BT LZ 57 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1388, 'BT LZ 57 M B2  n', 'BT LZ 57 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1389, 'BT LZ 76 M SB nrst', 'BT LZ 76 M SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1390, 'BT LZ 76 M SB nrs', 'BT LZ 76 M SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1391, 'BT LZ 76 M SB nrt', 'BT LZ 76 M SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1392, 'BT LZ 76 M SB nst', 'BT LZ 76 M SB nst');
INSERT INTO obras.maestro_estructura VALUES (1393, 'BT LZ 76 M SB nr', 'BT LZ 76 M SB nr');
INSERT INTO obras.maestro_estructura VALUES (1394, 'BT LZ 76 M SB ns', 'BT LZ 76 M SB ns');
INSERT INTO obras.maestro_estructura VALUES (1395, 'BT LZ 76 M SB nt', 'BT LZ 76 M SB nt');
INSERT INTO obras.maestro_estructura VALUES (1396, 'BT LZ 76 M SB n', 'BT LZ 76 M SB n');
INSERT INTO obras.maestro_estructura VALUES (1397, 'BT LZ 76 M B1  nrst', 'BT LZ 76 M B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1398, 'BT LZ 76 M B1  nrs', 'BT LZ 76 M B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1399, 'BT LZ 76 M B1  nrt', 'BT LZ 76 M B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1400, 'BT LZ 76 M B1  nst', 'BT LZ 76 M B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1401, 'BT LZ 76 M B1  nr', 'BT LZ 76 M B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1402, 'BT LZ 76 M B1  ns', 'BT LZ 76 M B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1403, 'BT LZ 76 M B1  nt', 'BT LZ 76 M B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1404, 'BT LZ 76 M B1  n', 'BT LZ 76 M B1  n');
INSERT INTO obras.maestro_estructura VALUES (1405, 'BT LZ 76 M B2  nrst', 'BT LZ 76 M B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1406, 'BT LZ 76 M B2  nrs', 'BT LZ 76 M B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1407, 'BT LZ 76 M B2  nrt', 'BT LZ 76 M B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1408, 'BT LZ 76 M B2  nst', 'BT LZ 76 M B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1409, 'BT LZ 76 M B2  nr', 'BT LZ 76 M B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1410, 'BT LZ 76 M B2  ns', 'BT LZ 76 M B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1411, 'BT LZ 76 M B2  nt', 'BT LZ 76 M B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1412, 'BT LZ 76 M B2  n', 'BT LZ 76 M B2  n');
INSERT INTO obras.maestro_estructura VALUES (1413, 'BT LZ 57 B SB nrst', 'BT LZ 57 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1414, 'BT LZ 57 B SB nrs', 'BT LZ 57 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1415, 'BT LZ 57 B SB nr', 'BT LZ 57 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1416, 'BT LZ 57 B SB n', 'BT LZ 57 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1417, 'BT LZ 57 B B1  nrst', 'BT LZ 57 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1418, 'BT LZ 57 B B1  nrs', 'BT LZ 57 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1419, 'BT LZ 57 B B1  nst', 'BT LZ 57 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1420, 'BT LZ 57 B B1  nr', 'BT LZ 57 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1421, 'BT LZ 57 B B1  ns', 'BT LZ 57 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1422, 'BT LZ 57 B B1  n', 'BT LZ 57 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1423, 'BT LZ 57 B B2  nrst', 'BT LZ 57 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1424, 'BT LZ 76 B SB nrst', 'BT LZ 76 B SB nrst');
INSERT INTO obras.maestro_estructura VALUES (1425, 'BT LZ 76 B SB nrs', 'BT LZ 76 B SB nrs');
INSERT INTO obras.maestro_estructura VALUES (1426, 'BT LZ 76 B SB nrt', 'BT LZ 76 B SB nrt');
INSERT INTO obras.maestro_estructura VALUES (1427, 'BT LZ 76 B SB nst', 'BT LZ 76 B SB nst');
INSERT INTO obras.maestro_estructura VALUES (1428, 'BT LZ 76 B SB nr', 'BT LZ 76 B SB nr');
INSERT INTO obras.maestro_estructura VALUES (1429, 'BT LZ 76 B SB ns', 'BT LZ 76 B SB ns');
INSERT INTO obras.maestro_estructura VALUES (1430, 'BT LZ 76 B SB nt', 'BT LZ 76 B SB nt');
INSERT INTO obras.maestro_estructura VALUES (1431, 'BT LZ 76 B SB n', 'BT LZ 76 B SB n');
INSERT INTO obras.maestro_estructura VALUES (1432, 'BT LZ 76 B B1  nrst', 'BT LZ 76 B B1  nrst');
INSERT INTO obras.maestro_estructura VALUES (1433, 'BT LZ 76 B B1  nrs', 'BT LZ 76 B B1  nrs');
INSERT INTO obras.maestro_estructura VALUES (1434, 'BT LZ 76 B B1  nrt', 'BT LZ 76 B B1  nrt');
INSERT INTO obras.maestro_estructura VALUES (1435, 'BT LZ 76 B B1  nst', 'BT LZ 76 B B1  nst');
INSERT INTO obras.maestro_estructura VALUES (1436, 'BT LZ 76 B B1  nr', 'BT LZ 76 B B1  nr');
INSERT INTO obras.maestro_estructura VALUES (1437, 'BT LZ 76 B B1  ns', 'BT LZ 76 B B1  ns');
INSERT INTO obras.maestro_estructura VALUES (1438, 'BT LZ 76 B B1  nt', 'BT LZ 76 B B1  nt');
INSERT INTO obras.maestro_estructura VALUES (1439, 'BT LZ 76 B B1  n', 'BT LZ 76 B B1  n');
INSERT INTO obras.maestro_estructura VALUES (1440, 'BT LZ 76 B B2  nrst', 'BT LZ 76 B B2  nrst');
INSERT INTO obras.maestro_estructura VALUES (1441, 'BT LZ 76 B B2  nrs', 'BT LZ 76 B B2  nrs');
INSERT INTO obras.maestro_estructura VALUES (1442, 'BT LZ 76 B B2  nrt', 'BT LZ 76 B B2  nrt');
INSERT INTO obras.maestro_estructura VALUES (1443, 'BT LZ 76 B B2  nst', 'BT LZ 76 B B2  nst');
INSERT INTO obras.maestro_estructura VALUES (1444, 'BT LZ 76 B B2  nr', 'BT LZ 76 B B2  nr');
INSERT INTO obras.maestro_estructura VALUES (1445, 'BT LZ 76 B B2  ns', 'BT LZ 76 B B2  ns');
INSERT INTO obras.maestro_estructura VALUES (1446, 'BT LZ 76 B B2  nt', 'BT LZ 76 B B2  nt');
INSERT INTO obras.maestro_estructura VALUES (1447, 'BT LZ 76 B B2  n', 'BT LZ 76 B B2  n');
INSERT INTO obras.maestro_estructura VALUES (1448, 'BTPre P 57 M 1F', 'BTPre P 57 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1449, 'BTPre P 57 B 1F', 'BTPre P 57 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1450, 'BTPre P 76 M 1F', 'BTPre P 76 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1451, 'BTPre P 76 B 1F', 'BTPre P 76 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1452, 'BTPre RL 57 M 1F', 'BTPre RL 57 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1453, 'BTPre RL 57 B 1F', 'BTPre RL 57 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1454, 'BTPre RL 76 M 1F', 'BTPre RL 76 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1455, 'BTPre RL 76 B 1F', 'BTPre RL 76 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1456, 'BTPre R 57 M 1F', 'BTPre R 57 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1457, 'BTPre R 57 B 1F', 'BTPre R 57 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1458, 'BTPre R 76 M 1F', 'BTPre R 76 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1459, 'BTPre R 76 B 1F', 'BTPre R 76 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1460, 'BTPre R2 57 M 1F', 'BTPre R2 57 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1461, 'BTPre R2 57 B 1F', 'BTPre R2 57 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1462, 'BTPre R2 76 M 1F', 'BTPre R2 76 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1463, 'BTPre R2 76 B 1F', 'BTPre R2 76 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1464, 'BTPre LZ 57 M 1F', 'BTPre LZ 57 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1465, 'BTPre LZ 76 M 1F', 'BTPre LZ 76 M 1F');
INSERT INTO obras.maestro_estructura VALUES (1466, 'BTPre LZ 57 B 1F', 'BTPre LZ 57 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1467, 'BTPre LZ 76 B 1F', 'BTPre LZ 76 B 1F');
INSERT INTO obras.maestro_estructura VALUES (1468, 'BTPre P B', 'BTPre P B');
INSERT INTO obras.maestro_estructura VALUES (1469, 'BTPre P M', 'BTPre P M');
INSERT INTO obras.maestro_estructura VALUES (1470, 'BTPre CE M 1ø', 'BTPre CE M 1ø');
INSERT INTO obras.maestro_estructura VALUES (1471, 'BTPre CE M 2ø', 'BTPre CE M 2ø');
INSERT INTO obras.maestro_estructura VALUES (1472, 'BTPre CE M 3ø', 'BTPre CE M 3ø');
INSERT INTO obras.maestro_estructura VALUES (1473, 'BTPre CE B 1ø', 'BTPre CE B 1ø');
INSERT INTO obras.maestro_estructura VALUES (1474, 'BTPre CE B 2ø', 'BTPre CE B 2ø');
INSERT INTO obras.maestro_estructura VALUES (1475, 'BTPre CE B 3ø', 'BTPre CE B 3ø');
INSERT INTO obras.maestro_estructura VALUES (1476, 'BARRA SE2PC', 'BARRA SE2PC');
INSERT INTO obras.maestro_estructura VALUES (1477, 'Cable Guardia', 'Cable Guardia');
INSERT INTO obras.maestro_estructura VALUES (1478, 'PP 4C(=<25 mm2)', 'PP 4C(=<25 mm2)');
INSERT INTO obras.maestro_estructura VALUES (1479, 'PP 3C (=<25mm 2)', 'PP 3C (=<25mm 2)');
INSERT INTO obras.maestro_estructura VALUES (1480, 'PP 2C (=<25 mm2)', 'PP 2C (=<25 mm2)');
INSERT INTO obras.maestro_estructura VALUES (1481, 'PP 1C (=<25mm2)', 'PP 1C (=<25mm2)');
INSERT INTO obras.maestro_estructura VALUES (1482, 'PP 4c (>=33 mm2)', 'PP 4c (>=33 mm2)');
INSERT INTO obras.maestro_estructura VALUES (1483, 'PP 3C (>=33 mm2)', 'PP 3C (>=33 mm2)');
INSERT INTO obras.maestro_estructura VALUES (1484, 'PP 2C (>=33 mm2)', 'PP 2C (>=33 mm2)');
INSERT INTO obras.maestro_estructura VALUES (1485, 'PP 1C (>=33 mm2)', 'PP 1C (>=33 mm2)');
INSERT INTO obras.maestro_estructura VALUES (1486, 'PP Pre 1F', 'PP Pre 1F');
INSERT INTO obras.maestro_estructura VALUES (1487, 'CPre 3x35/50', 'CPre 3x35/50');
INSERT INTO obras.maestro_estructura VALUES (1488, 'CPre 3x50/50', 'CPre 3x50/50');
INSERT INTO obras.maestro_estructura VALUES (1489, 'CPre 2x16 Neutro Des', 'CPre 2x16 Neutro Des');
INSERT INTO obras.maestro_estructura VALUES (1490, 'Cpre 2x16', 'Cpre 2x16');
INSERT INTO obras.maestro_estructura VALUES (1491, 'PP Pre 4C', 'PP Pre 4C');
INSERT INTO obras.maestro_estructura VALUES (1492, 'CCu 16/16 MM2 4C', 'CCu 16/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1493, 'CCu 16/16 MM2 3C', 'CCu 16/16 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1494, 'CCu 16/16 MM2 2C', 'CCu 16/16 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1495, 'CCu 16 MM2 1C', 'CCu 16 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1496, 'CCu 25/25 MM2 4C', 'CCu 25/25 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1497, 'CCu 25/25 MM2 3C', 'CCu 25/25 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1498, 'CCu 25/25 MM2 2C', 'CCu 25/25 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1499, 'CCu 25 MM2 1C', 'CCu 25 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1500, 'CCu 25/16 MM2 4C', 'CCu 25/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1501, 'CCu 25/16 MM2 3C', 'CCu 25/16 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1502, 'CCu 25/16 MM2 2C', 'CCu 25/16 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1503, 'CCu 33.6/33.6 MM2 4C', 'CCu 33.6/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1504, 'CCu 33.6/33.6 MM2 3C', 'CCu 33.6/33.6 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1505, 'CCu 33.6/33.6 MM2 2C', 'CCu 33.6/33.6 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1506, 'CCu 33.6 MM2 1C', 'CCu 33.6 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1507, 'CCu 33.6/16 MM2 4C', 'CCu 33.6/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1508, 'CCu 33.6/16 MM2 3C', 'CCu 33.6/16 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1509, 'CCu 33.6/16 MM2 2C', 'CCu 33.6/16 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1510, 'CCu 33.6/25 MM2 4C', 'CCu 33.6/25 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1511, 'CCu 33.6/25 MM2 3C', 'CCu 33.6/25 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1512, 'CCu 33.6/25 MM2 2C', 'CCu 33.6/25 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1513, 'CCu 53.5/53.5 MM2 4C', 'CCu 53.5/53.5 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1514, 'CCu 53.5/53.5 MM2 3C', 'CCu 53.5/53.5 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1515, 'CCu 53.5/53.5 MM2 2C', 'CCu 53.5/53.5 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1516, 'CCu 53.5 MM2 1C', 'CCu 53.5 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1517, 'CCu 53.5/16 MM2 4C', 'CCu 53.5/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1518, 'CCu 53.5/16 MM2 2C', 'CCu 53.5/16 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1519, 'CCu 53.5/25 MM2 4C', 'CCu 53.5/25 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1520, 'CCu 53.5/25 MM2 3C', 'CCu 53.5/25 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1521, 'CCu 53.5/25 MM2 2C', 'CCu 53.5/25 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1522, 'CCu 53.5/33.6 MM2 4C', 'CCu 53.5/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1523, 'CCu 53.5/33.6 MM2 3C', 'CCu 53.5/33.6 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1524, 'CCu 53.5/33.6 MM2 2C', 'CCu 53.5/33.6 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1525, 'CCu 67.4/67.4 MM2 4C', 'CCu 67.4/67.4 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1526, 'CCu 67.4/67.4 MM2 3C', 'CCu 67.4/67.4 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1527, 'CCu 67.4/67.4 MM2 2C', 'CCu 67.4/67.4 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1528, 'CCu 67.4 MM2 1C', 'CCu 67.4 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1529, 'CCu 67.4/16 MM2 4C', 'CCu 67.4/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1530, 'CCu 67.4/16 MM2 2C', 'CCu 67.4/16 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1531, 'CCu 67.4/25 MM2 4C', 'CCu 67.4/25 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1532, 'CCu 67.4/33.6 MM2 4C', 'CCu 67.4/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1533, 'CCu 67.4/33.6 MM2 3C', 'CCu 67.4/33.6 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1534, 'CCu 67.4/33.6 MM2 2C', 'CCu 67.4/33.6 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1535, 'CCu 67.4/53.5 MM2 4C', 'CCu 67.4/53.5 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1536, 'CCu 67.4/53.5 MM2 3C', 'CCu 67.4/53.5 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1537, 'CCu 67.4/53.5 MM2 2C', 'CCu 67.4/53.5 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1538, 'CAl 2/2 AAAC 4C', 'CAl 2/2 AAAC 4C');
INSERT INTO obras.maestro_estructura VALUES (1539, 'CAl 2/2 AAAC 3C', 'CAl 2/2 AAAC 3C');
INSERT INTO obras.maestro_estructura VALUES (1540, 'CAl 2/2 AAAC 2C', 'CAl 2/2 AAAC 2C');
INSERT INTO obras.maestro_estructura VALUES (1541, 'CAl 2 AAAC 1C', 'CAl 2 AAAC 1C');
INSERT INTO obras.maestro_estructura VALUES (1542, 'CAl 1/0-1/0 AAAC 4C', 'CAl 1/0-1/0 AAAC 4C');
INSERT INTO obras.maestro_estructura VALUES (1543, 'CAl 1/0-1/0 AAAC 3C', 'CAl 1/0-1/0 AAAC 3C');
INSERT INTO obras.maestro_estructura VALUES (1544, 'CAl 1/0-1/0 AAAC 2C', 'CAl 1/0-1/0 AAAC 2C');
INSERT INTO obras.maestro_estructura VALUES (1545, 'CAl 1/0 AAAC 1C', 'CAl 1/0 AAAC 1C');
INSERT INTO obras.maestro_estructura VALUES (1546, 'CAl 1/0-2 AAAC 4C', 'CAl 1/0-2 AAAC 4C');
INSERT INTO obras.maestro_estructura VALUES (1547, 'CAl 1/0-2 AAAC 2C', 'CAl 1/0-2 AAAC 2C');
INSERT INTO obras.maestro_estructura VALUES (1548, 'CAl 3/0-3/0 AAAC 4C', 'CAl 3/0-3/0 AAAC 4C');
INSERT INTO obras.maestro_estructura VALUES (1549, 'CAl 3/0-3/0 AAAC 3C', 'CAl 3/0-3/0 AAAC 3C');
INSERT INTO obras.maestro_estructura VALUES (1550, 'CAl 3/0-3/0 AAAC 2C', 'CAl 3/0-3/0 AAAC 2C');
INSERT INTO obras.maestro_estructura VALUES (1551, 'CAl 3/0 AAAC 1C', 'CAl 3/0 AAAC 1C');
INSERT INTO obras.maestro_estructura VALUES (1552, 'CAl 3/0-1/0 AAAC 4C', 'CAl 3/0-1/0 AAAC 4C');
INSERT INTO obras.maestro_estructura VALUES (1553, 'BTPre R M', 'BTPre R M');
INSERT INTO obras.maestro_estructura VALUES (1554, 'BTPre RD M', 'BTPre RD M');
INSERT INTO obras.maestro_estructura VALUES (1555, 'BTPre LZ M', 'BTPre LZ M');
INSERT INTO obras.maestro_estructura VALUES (1556, 'BTPre RL M', 'BTPre RL M');
INSERT INTO obras.maestro_estructura VALUES (1557, 'BTPre R B', 'BTPre R B');
INSERT INTO obras.maestro_estructura VALUES (1558, 'BTPre RD B', 'BTPre RD B');
INSERT INTO obras.maestro_estructura VALUES (1559, 'BTPre LZ B', 'BTPre LZ B');
INSERT INTO obras.maestro_estructura VALUES (1560, 'BTPre RL B', 'BTPre RL B');
INSERT INTO obras.maestro_estructura VALUES (1561, 'Soporte empalme DRP', 'Soporte empalme DRP');
INSERT INTO obras.maestro_estructura VALUES (1562, 'BTPre CMetalica M 1F', 'BTPre CMetalica M 1F');
INSERT INTO obras.maestro_estructura VALUES (1563, 'BTPre CMetálica M 2F', 'BTPre CMetálica M 2F');
INSERT INTO obras.maestro_estructura VALUES (1564, 'BTPre CMetálica M 3F', 'BTPre CMetálica M 3F');
INSERT INTO obras.maestro_estructura VALUES (1565, 'BTPre CMetalica B 1F', 'BTPre CMetalica B 1F');
INSERT INTO obras.maestro_estructura VALUES (1566, 'BTPre CMetálica B 2F', 'BTPre CMetálica B 2F');
INSERT INTO obras.maestro_estructura VALUES (1567, 'BTPre CMetalica B 3F', 'BTPre CMetalica B 3F');
INSERT INTO obras.maestro_estructura VALUES (1568, 'CCu 26.7 MM2 1C', 'CCu 26.7 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1569, 'CCu 26.7/26.7 MM2 3C', 'CCu 26.7/26.7 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1570, 'CCu 26.7/26.7 MM2 4C', 'CCu 26.7/26.7 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1571, 'CCu 26.7/16 MM2 2C', 'CCu 26.7/16 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1572, 'CCu 26.7/16 MM2 3C', 'CCu 26.7/16 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1573, 'CCu 26.7/16 MM2 4C', 'CCu 26.7/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1574, 'CCu 53.5/26.7 MM2 2C', 'CCu 53.5/26.7 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1575, 'CCu 53.5/26.7 MM2 4C', 'CCu 53.5/26.7 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1576, 'CCu 33.6/26.5 MM2 4C', 'CCu 33.6/26.5 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1577, 'CCu 10 MM2 1C', 'CCu 10 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1578, 'CCu 10/10 MM2 2C', 'CCu 10/10 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1579, 'CCu 10/10 MM2 3C', 'CCu 10/10 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1580, 'CCu 10/10 MM2 4C', 'CCu 10/10 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1581, 'CCu 16/10 MM2 2C', 'CCu 16/10 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1582, 'CCu 16/10 MM2 3C', 'CCu 16/10 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1583, 'CCu 16/10 MM2 4C', 'CCu 16/10 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1584, 'CCu 16 MM2 1C Cable', 'CCu 16 MM2 1C Cable');
INSERT INTO obras.maestro_estructura VALUES (1585, 'CCu 16/16 MM2 2C Cab', 'CCu 16/16 MM2 2C Cab');
INSERT INTO obras.maestro_estructura VALUES (1586, 'CCu 16/16 MM2 3C Cab', 'CCu 16/16 MM2 3C Cab');
INSERT INTO obras.maestro_estructura VALUES (1587, 'CCu 16/16 MM2 4C Cab', 'CCu 16/16 MM2 4C Cab');
INSERT INTO obras.maestro_estructura VALUES (1588, 'CCu 21 MM2 1C', 'CCu 21 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1589, 'CCu 21/21 MM2 2C', 'CCu 21/21 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1590, 'CCu 21/21 MM2 3C', 'CCu 21/21 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1591, 'CCu 21/21 MM2 4C', 'CCu 21/21 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1592, 'CCu 13 MM2 1C', 'CCu 13 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1593, 'CCu 13/13 MM2 2C', 'CCu 13/13 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1594, 'CCu 13/13 MM2 3C', 'CCu 13/13 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1595, 'CCu 13/13 MM2 4C', 'CCu 13/13 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1596, 'CCON 6 MM2 1C', 'CCON 6 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1597, 'Ccon 6 MM2 1C', 'Ccon 6 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1598, 'CCON 4 MM2 1C', 'CCON 4 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1599, 'Ccon 4 MM2 1C', 'Ccon 4 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1600, 'PSeg Ae 3ø', 'PSeg Ae 3ø');
INSERT INTO obras.maestro_estructura VALUES (1601, 'PSeg Ae 2ø', 'PSeg Ae 2ø');
INSERT INTO obras.maestro_estructura VALUES (1602, 'Cavanna 3ø', 'Cavanna 3ø');
INSERT INTO obras.maestro_estructura VALUES (1603, 'Pfisterer', 'Pfisterer');
INSERT INTO obras.maestro_estructura VALUES (1604, 'Cavanna 2ø', 'Cavanna 2ø');
INSERT INTO obras.maestro_estructura VALUES (1605, 'CPI 8/8 MM2 4C', 'CPI 8/8 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1606, 'CPI 8/8 MM2 3C', 'CPI 8/8 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1607, 'CPI 8/8 MM2 2C', 'CPI 8/8 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1608, 'CPI 8 MM2 1C', 'CPI 8 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1609, 'CPI 6/6 MM2 4C', 'CPI 6/6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1610, 'CPI 6/6 MM2 3C', 'CPI 6/6 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1611, 'CPI 6/6 MM2 2C', 'CPI 6/6 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1612, 'CPI 6 MM2 1C', 'CPI 6 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1613, 'CTHW 21/21 MM2 4C', 'CTHW 21/21 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1614, 'CTHW 21/21 MM2 3C', 'CTHW 21/21 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1615, 'CTHW 21/21 MM2 2C', 'CTHW 21/21 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1616, 'CTHW 21 MM2 1C', 'CTHW 21 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1617, 'Secc.Reja 3F', 'Secc.Reja 3F');
INSERT INTO obras.maestro_estructura VALUES (1618, 'BT BS', 'BT BS');
INSERT INTO obras.maestro_estructura VALUES (1619, 'MBT 4C', 'MBT 4C');
INSERT INTO obras.maestro_estructura VALUES (1620, 'MBT 3C', 'MBT 3C');
INSERT INTO obras.maestro_estructura VALUES (1621, 'MBT 2C', 'MBT 2C');
INSERT INTO obras.maestro_estructura VALUES (1622, 'MBT 1C', 'MBT 1C');
INSERT INTO obras.maestro_estructura VALUES (1623, 'MBT Abierta 4C', 'MBT Abierta 4C');
INSERT INTO obras.maestro_estructura VALUES (1624, 'MBT Abierta 3C', 'MBT Abierta 3C');
INSERT INTO obras.maestro_estructura VALUES (1625, 'MBT Abierta 2C', 'MBT Abierta 2C');
INSERT INTO obras.maestro_estructura VALUES (1626, 'MBT Abierta 1C', 'MBT Abierta 1C');
INSERT INTO obras.maestro_estructura VALUES (1627, 'Equipo de Medida BT', 'Equipo de Medida BT');
INSERT INTO obras.maestro_estructura VALUES (1628, 'Int. Automatico', 'Int. Automatico');
INSERT INTO obras.maestro_estructura VALUES (1629, 'TORRE TIPO R12-1', 'TORRE TIPO R12-1');
INSERT INTO obras.maestro_estructura VALUES (1630, 'TORRE TIPO R12-2', 'TORRE TIPO R12-2');
INSERT INTO obras.maestro_estructura VALUES (1631, 'TORRE TIPO P12-2', 'TORRE TIPO P12-2');
INSERT INTO obras.maestro_estructura VALUES (1632, 'CABLE CU 3/0 AWG', 'CABLE CU 3/0 AWG');
INSERT INTO obras.maestro_estructura VALUES (1633, 'CABLE AL AAAC 312.8', 'CABLE AL AAAC 312.8');
INSERT INTO obras.maestro_estructura VALUES (1634, 'D', 'D');
INSERT INTO obras.maestro_estructura VALUES (1635, 'D12-1R', 'D12-1R');
INSERT INTO obras.maestro_estructura VALUES (1636, 'D12-1R-1SW', 'D12-1R-1SW');
INSERT INTO obras.maestro_estructura VALUES (1637, 'D12-1R-2O3SW', 'D12-1R-2O3SW');
INSERT INTO obras.maestro_estructura VALUES (1638, 'EAX', 'EAX');
INSERT INTO obras.maestro_estructura VALUES (1639, 'Mufa Terminal Exteri', 'Mufa Terminal Exteri');
INSERT INTO obras.maestro_estructura VALUES (1640, 'C', 'C');
INSERT INTO obras.maestro_estructura VALUES (1641, 'C12-1P (N)', 'C12-1P (N)');
INSERT INTO obras.maestro_estructura VALUES (1642, 'A-2SW', 'A-2SW');
INSERT INTO obras.maestro_estructura VALUES (1643, 'A-3SW', 'A-3SW');
INSERT INTO obras.maestro_estructura VALUES (1644, 'V12-1R (V)', 'V12-1R (V)');
INSERT INTO obras.maestro_estructura VALUES (1645, 'V12-1RE (H)', 'V12-1RE (H)');
INSERT INTO obras.maestro_estructura VALUES (1646, 'V12-1RE (V)', 'V12-1RE (V)');
INSERT INTO obras.maestro_estructura VALUES (1647, 'V16-1R (H)', 'V16-1R (H)');
INSERT INTO obras.maestro_estructura VALUES (1648, 'V16-1RE', 'V16-1RE');
INSERT INTO obras.maestro_estructura VALUES (1649, 'V18-1R', 'V18-1R');
INSERT INTO obras.maestro_estructura VALUES (1650, 'V20-1R (V)', 'V20-1R (V)');
INSERT INTO obras.maestro_estructura VALUES (1651, 'V20-1R (H)', 'V20-1R (H)');
INSERT INTO obras.maestro_estructura VALUES (1652, 'V20-1RE', 'V20-1RE');
INSERT INTO obras.maestro_estructura VALUES (1653, 'V12-2R (H)', 'V12-2R (H)');
INSERT INTO obras.maestro_estructura VALUES (1654, 'V12-2P', 'V12-2P');
INSERT INTO obras.maestro_estructura VALUES (1655, 'V12-2RE (V)', 'V12-2RE (V)');
INSERT INTO obras.maestro_estructura VALUES (1656, 'V12-2RE (H)', 'V12-2RE (H)');
INSERT INTO obras.maestro_estructura VALUES (1657, 'V16-2R', 'V16-2R');
INSERT INTO obras.maestro_estructura VALUES (1658, 'V16-2RE', 'V16-2RE');
INSERT INTO obras.maestro_estructura VALUES (1659, 'TORRE TIPO R12-2M', 'TORRE TIPO R12-2M');
INSERT INTO obras.maestro_estructura VALUES (1660, 'TORRE TIPO R12-1A', 'TORRE TIPO R12-1A');
INSERT INTO obras.maestro_estructura VALUES (1661, 'TORRE TIPO R12-3', 'TORRE TIPO R12-3');
INSERT INTO obras.maestro_estructura VALUES (1662, 'TORRE TIPO P12-2M', 'TORRE TIPO P12-2M');
INSERT INTO obras.maestro_estructura VALUES (1663, 'TORRE TIPO P12-2M1', 'TORRE TIPO P12-2M1');
INSERT INTO obras.maestro_estructura VALUES (1664, 'TORRE TIPO P12-2M2', 'TORRE TIPO P12-2M2');
INSERT INTO obras.maestro_estructura VALUES (1665, 'TORRE TIPO P16-2', 'TORRE TIPO P16-2');
INSERT INTO obras.maestro_estructura VALUES (1666, 'TORRE TIPO TJ', 'TORRE TIPO TJ');
INSERT INTO obras.maestro_estructura VALUES (1667, 'EXTENSION 2M P16-2', 'EXTENSION 2M P16-2');
INSERT INTO obras.maestro_estructura VALUES (1668, 'EXTENSION 3M R12', 'EXTENSION 3M R12');
INSERT INTO obras.maestro_estructura VALUES (1669, 'EXTENSION 6M R12', 'EXTENSION 6M R12');
INSERT INTO obras.maestro_estructura VALUES (1670, 'CRUCETA 90º R12', 'CRUCETA 90º R12');
INSERT INTO obras.maestro_estructura VALUES (1671, 'CABLE CU 1/0 AWG', 'CABLE CU 1/0 AWG');
INSERT INTO obras.maestro_estructura VALUES (1672, 'CABLE CU 2/0 AWG', 'CABLE CU 2/0 AWG');
INSERT INTO obras.maestro_estructura VALUES (1673, 'CABLE CU 250 MCM', 'CABLE CU 250 MCM');
INSERT INTO obras.maestro_estructura VALUES (1674, 'CABLE AL AAAC 3/0 AW', 'CABLE AL AAAC 3/0 AW');
INSERT INTO obras.maestro_estructura VALUES (1675, 'CABLE AL AAAC 246.9', 'CABLE AL AAAC 246.9');
INSERT INTO obras.maestro_estructura VALUES (1676, 'CABLE AL AAAC 740.8', 'CABLE AL AAAC 740.8');
INSERT INTO obras.maestro_estructura VALUES (1677, 'BRAZO P/D12-1R-1SW', 'BRAZO P/D12-1R-1SW');
INSERT INTO obras.maestro_estructura VALUES (1678, '1 PLATAFORMA OPERACI', '1 PLATAFORMA OPERACI');
INSERT INTO obras.maestro_estructura VALUES (1679, '1 PORTA PELDAÑO POST', '1 PORTA PELDAÑO POST');
INSERT INTO obras.maestro_estructura VALUES (1680, 'CABLE AL AASC 250 MC', 'CABLE AL AASC 250 MC');
INSERT INTO obras.maestro_estructura VALUES (1681, 'CABLE CU 2 AWG', 'CABLE CU 2 AWG');
INSERT INTO obras.maestro_estructura VALUES (1682, 'CABLE CW 2/0 AWG', 'CABLE CW 2/0 AWG');
INSERT INTO obras.maestro_estructura VALUES (1683, 'CABLE CW 4/0 AWG', 'CABLE CW 4/0 AWG');
INSERT INTO obras.maestro_estructura VALUES (1684, 'CABLE CW 7Nº8 AWG', 'CABLE CW 7Nº8 AWG');
INSERT INTO obras.maestro_estructura VALUES (1685, 'EXTENSION E1 PARA TJ', 'EXTENSION E1 PARA TJ');
INSERT INTO obras.maestro_estructura VALUES (1686, 'EXTENSION E2 PARA TJ', 'EXTENSION E2 PARA TJ');
INSERT INTO obras.maestro_estructura VALUES (1687, 'EXTENSION E3 PARA TJ', 'EXTENSION E3 PARA TJ');
INSERT INTO obras.maestro_estructura VALUES (1688, '3 PEINETAS', '3 PEINETAS');
INSERT INTO obras.maestro_estructura VALUES (1689, '2 PEINETAS', '2 PEINETAS');
INSERT INTO obras.maestro_estructura VALUES (1690, 'AX-C3P', 'AX-C3P');
INSERT INTO obras.maestro_estructura VALUES (1691, 'AX-C5P', 'AX-C5P');
INSERT INTO obras.maestro_estructura VALUES (1692, 'AX-C6P', 'AX-C6P');
INSERT INTO obras.maestro_estructura VALUES (1693, 'AX-C7P', 'AX-C7P');
INSERT INTO obras.maestro_estructura VALUES (1694, 'AX-C2P', 'AX-C2P');
INSERT INTO obras.maestro_estructura VALUES (1695, 'HX-S3', 'HX-S3');
INSERT INTO obras.maestro_estructura VALUES (1696, 'HX-H3', 'HX-H3');
INSERT INTO obras.maestro_estructura VALUES (1697, 'BX', 'BX');
INSERT INTO obras.maestro_estructura VALUES (1698, 'EX', 'EX');
INSERT INTO obras.maestro_estructura VALUES (1699, 'FX', 'FX');
INSERT INTO obras.maestro_estructura VALUES (1700, 'HX-T2', 'HX-T2');
INSERT INTO obras.maestro_estructura VALUES (1701, 'AX-C3R', 'AX-C3R');
INSERT INTO obras.maestro_estructura VALUES (1702, 'AX-C5R', 'AX-C5R');
INSERT INTO obras.maestro_estructura VALUES (1703, 'AX-C6R', 'AX-C6R');
INSERT INTO obras.maestro_estructura VALUES (1704, 'AX-C7R', 'AX-C7R');
INSERT INTO obras.maestro_estructura VALUES (1705, 'AX-C2R', 'AX-C2R');
INSERT INTO obras.maestro_estructura VALUES (1706, '1 TIRANTE P/ANCLAJE', '1 TIRANTE P/ANCLAJE');
INSERT INTO obras.maestro_estructura VALUES (1707, 'LPV P P/AMARRA 45"', 'LPV P P/AMARRA 45"');
INSERT INTO obras.maestro_estructura VALUES (1708, 'LPV P P/AMARRA 53"', 'LPV P P/AMARRA 53"');
INSERT INTO obras.maestro_estructura VALUES (1709, 'LPV P P/GRAPA 45"', 'LPV P P/GRAPA 45"');
INSERT INTO obras.maestro_estructura VALUES (1710, 'LPV P P/GRAPA 53"', 'LPV P P/GRAPA 53"');
INSERT INTO obras.maestro_estructura VALUES (1711, 'LPV S P/GRAPA 2P 68"', 'LPV S P/GRAPA 2P 68"');
INSERT INTO obras.maestro_estructura VALUES (1712, 'LPV S P/GRAPA 4P 68"', 'LPV S P/GRAPA 4P 68"');
INSERT INTO obras.maestro_estructura VALUES (1713, 'LPV S P/GRAPA 1P 83"', 'LPV S P/GRAPA 1P 83"');
INSERT INTO obras.maestro_estructura VALUES (1714, 'LPH P P/GRAPA +B 53"', 'LPH P P/GRAPA +B 53"');
INSERT INTO obras.maestro_estructura VALUES (1715, 'LPV S P/GRAPA 68"', 'LPV S P/GRAPA 68"');
INSERT INTO obras.maestro_estructura VALUES (1716, 'TORRE TIPO TUD18-1R', 'TORRE TIPO TUD18-1R');
INSERT INTO obras.maestro_estructura VALUES (1717, 'TORRE TIPO TUD22-1R', 'TORRE TIPO TUD22-1R');
INSERT INTO obras.maestro_estructura VALUES (1718, 'TORRE TIPO TUB21-1P', 'TORRE TIPO TUB21-1P');
INSERT INTO obras.maestro_estructura VALUES (1719, 'TORRE TIPO TUC18-1P', 'TORRE TIPO TUC18-1P');
INSERT INTO obras.maestro_estructura VALUES (1720, 'PUESTA TIERRA PORTAL', 'PUESTA TIERRA PORTAL');
INSERT INTO obras.maestro_estructura VALUES (1721, 'GX', 'GX');
INSERT INTO obras.maestro_estructura VALUES (1722, 'LOSA TRAFO. AEREO', 'LOSA TRAFO. AEREO');
INSERT INTO obras.maestro_estructura VALUES (1723, 'LOSA TRAFO. PAD-MOUN', 'LOSA TRAFO. PAD-MOUN');
INSERT INTO obras.maestro_estructura VALUES (1724, 'CPre 3x70/50', 'CPre 3x70/50');
INSERT INTO obras.maestro_estructura VALUES (1725, 'CPR 50 MM2 3Ø 25 KV', 'CPR 50 MM2 3Ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (1726, 'CPr 50 mm2 2ø 25 KV', 'CPr 50 mm2 2ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (1727, 'CPr 150 mm2 3ø 25 KV', 'CPr 150 mm2 3ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (1728, 'TMC 3ø 25KV 80-160/5', 'TMC 3ø 25KV 80-160/5');
INSERT INTO obras.maestro_estructura VALUES (1729, 'THW 67.4/33.6 MM2 4C', 'THW 67.4/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1730, 'THW 33.6/33.6 MM2 4C', 'THW 33.6/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1731, 'THW 33.6/21.2 MM2 4C', 'THW 33.6/21.2 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1732, 'THW 21.2/21.2 MM2 4C', 'THW 21.2/21.2 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1733, 'USEoXTU 152/107 4C', 'USEoXTU 152/107 4C');
INSERT INTO obras.maestro_estructura VALUES (1734, 'USEoXTU 107/67.4 4C', 'USEoXTU 107/67.4 4C');
INSERT INTO obras.maestro_estructura VALUES (1735, 'USEoXTU 67.4/33.6 4C', 'USEoXTU 67.4/33.6 4C');
INSERT INTO obras.maestro_estructura VALUES (1736, 'USEoXTU 33.6/33.6 4C', 'USEoXTU 33.6/33.6 4C');
INSERT INTO obras.maestro_estructura VALUES (1737, 'USEoXTU 33.6/21.2 4C', 'USEoXTU 33.6/21.2 4C');
INSERT INTO obras.maestro_estructura VALUES (1738, 'USEoXTU 21.2/21.2 4C', 'USEoXTU 21.2/21.2 4C');
INSERT INTO obras.maestro_estructura VALUES (1739, 'USE 152/THW 107MM2 4', 'USE 152/THW 107MM2 4');
INSERT INTO obras.maestro_estructura VALUES (1740, 'USE 107/THW 67MM2 4C', 'USE 107/THW 67MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1741, 'USE 67/THW 33MM2 4C', 'USE 67/THW 33MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1742, 'USE 33/THW 33MM2 4C', 'USE 33/THW 33MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1743, 'USE 33/THW 21MM2 4C', 'USE 33/THW 21MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1744, 'USE 21/THW 21MM2 4C', 'USE 21/THW 21MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1745, 'CCo 150 mm2 3ø 25KV', 'CCo 150 mm2 3ø 25KV');
INSERT INTO obras.maestro_estructura VALUES (1746, 'CPr 150 mm2 3ø 15 KV', 'CPr 150 mm2 3ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (1747, 'Cuch.Pallares-Boveda', 'Cuch.Pallares-Boveda');
INSERT INTO obras.maestro_estructura VALUES (1748, 'MTProt 15N 2 PC', 'MTProt 15N 2 PC');
INSERT INTO obras.maestro_estructura VALUES (1749, 'MTProt 15N 3 PC', 'MTProt 15N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (1750, 'MTProt 15N 2 PCD', 'MTProt 15N 2 PCD');
INSERT INTO obras.maestro_estructura VALUES (1751, 'MTProt 15N 3 PCD old', 'MTProt 15N 3 PCD old');
INSERT INTO obras.maestro_estructura VALUES (1752, 'MTProt 15V 2 PC', 'MTProt 15V 2 PC');
INSERT INTO obras.maestro_estructura VALUES (1753, 'MTProt 15V 3 PC', 'MTProt 15V 3 PC');
INSERT INTO obras.maestro_estructura VALUES (1754, 'MTProt 15V 2 PCD', 'MTProt 15V 2 PCD');
INSERT INTO obras.maestro_estructura VALUES (1755, 'MTProt 15V 3 PCD', 'MTProt 15V 3 PCD');
INSERT INTO obras.maestro_estructura VALUES (1756, 'MTProt 15N 3 PD', 'MTProt 15N 3 PD');
INSERT INTO obras.maestro_estructura VALUES (1757, 'MTProt 15N 2 PD', 'MTProt 15N 2 PD');
INSERT INTO obras.maestro_estructura VALUES (1758, 'MTProt 15V 2 PD', 'MTProt 15V 2 PD');
INSERT INTO obras.maestro_estructura VALUES (1759, 'MTProt 15V 3 PD', 'MTProt 15V 3 PD');
INSERT INTO obras.maestro_estructura VALUES (1760, 'MTProt 15N 2 JI', 'MTProt 15N 2 JI');
INSERT INTO obras.maestro_estructura VALUES (1761, 'MTProt 15N 3 JI', 'MTProt 15N 3 JI');
INSERT INTO obras.maestro_estructura VALUES (1762, 'MTProt 15V 2 JI', 'MTProt 15V 2 JI');
INSERT INTO obras.maestro_estructura VALUES (1763, 'MTProt 15V 3 JI', 'MTProt 15V 3 JI');
INSERT INTO obras.maestro_estructura VALUES (1764, 'MMT 3ø Cu-Al', 'MMT 3ø Cu-Al');
INSERT INTO obras.maestro_estructura VALUES (1765, 'MMT 2ø Cu-Al', 'MMT 2ø Cu-Al');
INSERT INTO obras.maestro_estructura VALUES (1766, 'MTCO 15N 3 JI -OLD', 'MTCO 15N 3 JI -OLD');
INSERT INTO obras.maestro_estructura VALUES (1767, 'MTCO 15V 3 JI', 'MTCO 15V 3 JI');
INSERT INTO obras.maestro_estructura VALUES (1768, 'MTCO 23N 3 JI', 'MTCO 23N 3 JI');
INSERT INTO obras.maestro_estructura VALUES (1769, 'MTCO 23V 3 JI', 'MTCO 23V 3 JI');
INSERT INTO obras.maestro_estructura VALUES (1770, 'MTProt 23N 2 PC', 'MTProt 23N 2 PC');
INSERT INTO obras.maestro_estructura VALUES (1771, 'MTProt 23N 3 PC', 'MTProt 23N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (1772, 'MTProt 23N 3 PCD', 'MTProt 23N 3 PCD');
INSERT INTO obras.maestro_estructura VALUES (1773, 'MTProt 23N 2 PCD', 'MTProt 23N 2 PCD');
INSERT INTO obras.maestro_estructura VALUES (1774, 'MTProt 23V 2 PC', 'MTProt 23V 2 PC');
INSERT INTO obras.maestro_estructura VALUES (1775, 'MTProt 23V 3 PC', 'MTProt 23V 3 PC');
INSERT INTO obras.maestro_estructura VALUES (1776, 'MTProt 23V 2 PCD', 'MTProt 23V 2 PCD');
INSERT INTO obras.maestro_estructura VALUES (1777, 'MTProt 23V 3 PCD', 'MTProt 23V 3 PCD');
INSERT INTO obras.maestro_estructura VALUES (1778, 'MTProt 23N 2 PD', 'MTProt 23N 2 PD');
INSERT INTO obras.maestro_estructura VALUES (1779, 'MTProt 23N 3 PD', 'MTProt 23N 3 PD');
INSERT INTO obras.maestro_estructura VALUES (1780, 'MTProt 23V 2 PD', 'MTProt 23V 2 PD');
INSERT INTO obras.maestro_estructura VALUES (1781, 'MTProt 23V 3 PD', 'MTProt 23V 3 PD');
INSERT INTO obras.maestro_estructura VALUES (1782, 'MTProt 23N 2 JI', 'MTProt 23N 2 JI');
INSERT INTO obras.maestro_estructura VALUES (1783, 'MTProt 23N 3 JI', 'MTProt 23N 3 JI');
INSERT INTO obras.maestro_estructura VALUES (1784, 'MTProt 23V 2 JI', 'MTProt 23V 2 JI');
INSERT INTO obras.maestro_estructura VALUES (1785, 'MTProt 23V 3 JI', 'MTProt 23V 3 JI');
INSERT INTO obras.maestro_estructura VALUES (1786, 'USEoXTU 21.2/21.2 3C', 'USEoXTU 21.2/21.2 3C');
INSERT INTO obras.maestro_estructura VALUES (1787, 'USEoXTU 33.6/21.2 3C', 'USEoXTU 33.6/21.2 3C');
INSERT INTO obras.maestro_estructura VALUES (1788, 'USEoXTU 33.6/21.2 2C', 'USEoXTU 33.6/21.2 2C');
INSERT INTO obras.maestro_estructura VALUES (1789, 'USEoXTU 21.2/13.2 4C', 'USEoXTU 21.2/13.2 4C');
INSERT INTO obras.maestro_estructura VALUES (1790, 'THW 67.4/67.4MM2 4C', 'THW 67.4/67.4MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1791, 'USEoXTU 67/67.4 4C', 'USEoXTU 67/67.4 4C');
INSERT INTO obras.maestro_estructura VALUES (1792, 'USEoXTU 67.4/21.2 4C', 'USEoXTU 67.4/21.2 4C');
INSERT INTO obras.maestro_estructura VALUES (1793, 'Poste Octogonal TyT', 'Poste Octogonal TyT');
INSERT INTO obras.maestro_estructura VALUES (1794, 'PP Pre 1F', 'PP Pre 1F');
INSERT INTO obras.maestro_estructura VALUES (1795, 'MTCO 15N 3 A1TJ', 'MTCO 15N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (1796, 'MTCO 23N 3 A1TJ', 'MTCO 23N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (1797, 'PSeg Ae 1ø', 'PSeg Ae 1ø');
INSERT INTO obras.maestro_estructura VALUES (1798, 'MTProt 23N 3 JA', 'MTProt 23N 3 JA');
INSERT INTO obras.maestro_estructura VALUES (1799, 'MTProt 23N 2 JA', 'MTProt 23N 2 JA');
INSERT INTO obras.maestro_estructura VALUES (1800, 'MTProt 15N 3 JA', 'MTProt 15N 3 JA');
INSERT INTO obras.maestro_estructura VALUES (1801, 'MTProt 15N 2 JA', 'MTProt 15N 2 JA');
INSERT INTO obras.maestro_estructura VALUES (1802, 'MTProt 23N 3 A1TJ', 'MTProt 23N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (1803, 'MTProt 23N 2 A1TJ', 'MTProt 23N 2 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (1804, '(MTProt 15N 3 A1TJ)', '(MTProt 15N 3 A1TJ)');
INSERT INTO obras.maestro_estructura VALUES (1805, 'MTProt 15N 2 A1TJ', 'MTProt 15N 2 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (1806, 'MTProt 23N 3 A2PES', 'MTProt 23N 3 A2PES');
INSERT INTO obras.maestro_estructura VALUES (1807, 'MTProt 23N 2 A2PES', 'MTProt 23N 2 A2PES');
INSERT INTO obras.maestro_estructura VALUES (1808, 'MTProt 15N 3 A2PES', 'MTProt 15N 3 A2PES');
INSERT INTO obras.maestro_estructura VALUES (1809, 'MTProt 15N 2 A2PES', 'MTProt 15N 2 A2PES');
INSERT INTO obras.maestro_estructura VALUES (1810, 'USE 33/THW 21MM2 3C', 'USE 33/THW 21MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1811, 'USE 33/THW 21MM2 2C', 'USE 33/THW 21MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1812, 'USE 21/THW 21MM2 3C', 'USE 21/THW 21MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1813, 'THW 21.2mm2  1C', 'THW 21.2mm2  1C');
INSERT INTO obras.maestro_estructura VALUES (1814, 'THW 33.6MM2 1C', 'THW 33.6MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (1815, 'XAT Cocesa #1 23kV 3', 'XAT Cocesa #1 23kV 3');
INSERT INTO obras.maestro_estructura VALUES (1816, 'Ccon 6 MM2 2C', 'Ccon 6 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1817, 'Ccon 6 MM2 3C', 'Ccon 6 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1818, 'MONT REC S1PLANO', 'MONT REC S1PLANO');
INSERT INTO obras.maestro_estructura VALUES (1819, 'USEoXTU 107/107 4C', 'USEoXTU 107/107 4C');
INSERT INTO obras.maestro_estructura VALUES (1820, 'DF 8kAR 1ø', 'DF 8kAR 1ø');
INSERT INTO obras.maestro_estructura VALUES (1821, 'MT SE1PC 1F S2P', 'MT SE1PC 1F S2P');
INSERT INTO obras.maestro_estructura VALUES (1822, 'Cavanna 1ø', 'Cavanna 1ø');
INSERT INTO obras.maestro_estructura VALUES (1823, 'USE 67/THW 67MM2 4C', 'USE 67/THW 67MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1824, 'USE 13/8MM2 4C', 'USE 13/8MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1825, 'USE 21/THW 13MM2 3C', 'USE 21/THW 13MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1826, 'USE 21/THW 13MM2 4C', 'USE 21/THW 13MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1827, 'USE 107/THW 33MM2 4C', 'USE 107/THW 33MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1828, 'USE 107/THW 53MM2 4C', 'USE 107/THW 53MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1829, 'MTPROT 23N 3 A2PEJ', 'MTPROT 23N 3 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (1830, 'MTPROT 23N 2 A2PEJ', 'MTPROT 23N 2 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (1831, 'MTPROT 23N 3 A2RE', 'MTPROT 23N 3 A2RE');
INSERT INTO obras.maestro_estructura VALUES (1832, 'MTPROT 23N 2 A2RE', 'MTPROT 23N 2 A2RE');
INSERT INTO obras.maestro_estructura VALUES (1833, 'MTPROT 23N 3 A1TJS', 'MTPROT 23N 3 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (1834, 'MTPROT 23N 2 A1TJS', 'MTPROT 23N 2 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (1835, 'MTPROT 15N 3 A2PEJ', 'MTPROT 15N 3 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (1836, 'MTPROT 15N 2 A2PEJ', 'MTPROT 15N 2 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (1837, 'NH hasta 630A c/A', 'NH hasta 630A c/A');
INSERT INTO obras.maestro_estructura VALUES (1838, 'NH hasta 400A', 'NH hasta 400A');
INSERT INTO obras.maestro_estructura VALUES (1839, 'NH hasta 400A c/A', 'NH hasta 400A c/A');
INSERT INTO obras.maestro_estructura VALUES (1840, 'XLPE 120 mm ²3F 23KV', 'XLPE 120 mm ²3F 23KV');
INSERT INTO obras.maestro_estructura VALUES (1841, 'XLPE 70 mm ²3F 23KV', 'XLPE 70 mm ²3F 23KV');
INSERT INTO obras.maestro_estructura VALUES (1842, 'USE 13/8MM2 3C', 'USE 13/8MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1843, 'USE 21/ 21MM2 2C', 'USE 21/ 21MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1844, 'SECC. SCADA SERIE M', 'SECC. SCADA SERIE M');
INSERT INTO obras.maestro_estructura VALUES (1845, 'XLPE #2AWG 2ø 15KV', 'XLPE #2AWG 2ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (1846, 'USE 53/THW 21MM2 4C', 'USE 53/THW 21MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1847, 'Int. Automático', 'Int. Automático');
INSERT INTO obras.maestro_estructura VALUES (1848, 'NKBA TRIP 3*25/21', 'NKBA TRIP 3*25/21');
INSERT INTO obras.maestro_estructura VALUES (1849, 'NKBA TRIP 3*50/33', 'NKBA TRIP 3*50/33');
INSERT INTO obras.maestro_estructura VALUES (1850, 'BICC TRIP 3*50/THW33', 'BICC TRIP 3*50/THW33');
INSERT INTO obras.maestro_estructura VALUES (1851, 'EM 1ø BT', 'EM 1ø BT');
INSERT INTO obras.maestro_estructura VALUES (1852, 'EM 3ø BT Dir. 30kVA', 'EM 3ø BT Dir. 30kVA');
INSERT INTO obras.maestro_estructura VALUES (1853, 'EM 3ø BT Dir. 45kVA', 'EM 3ø BT Dir. 45kVA');
INSERT INTO obras.maestro_estructura VALUES (1854, 'EM 3ø BT Dir. 15kVA', 'EM 3ø BT Dir. 15kVA');
INSERT INTO obras.maestro_estructura VALUES (1855, 'EM 3Ø BT DIR. 75KVA', 'EM 3Ø BT DIR. 75KVA');
INSERT INTO obras.maestro_estructura VALUES (1856, 'EM 3ø BT Indir. c/TC', 'EM 3ø BT Indir. c/TC');
INSERT INTO obras.maestro_estructura VALUES (1857, 'MTCU 23N 3P A2RE', 'MTCU 23N 3P A2RE');
INSERT INTO obras.maestro_estructura VALUES (1858, 'CCu 21/16 MM2 4C', 'CCu 21/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1859, 'CCu 85/33.6 MM2 4C', 'CCu 85/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1860, 'CCu 107 mm2  3ø', 'CCu 107 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (1861, 'USE 85/THW 53MM2 4C', 'USE 85/THW 53MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1862, 'USE 33/THW 33MM2 3C', 'USE 33/THW 33MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1863, 'USE 21/THW 21MM2 2C', 'USE 21/THW 21MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1864, 'THW 13/8MM2 4C', 'THW 13/8MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1865, 'THW 53/33.6 MM2 4C', 'THW 53/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1866, 'THW 53/21 MM2 4C', 'THW 53/21 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1867, 'THW 21.2/13 MM2 4C', 'THW 21.2/13 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1868, 'THHN # 4/6AWG 4C', 'THHN # 4/6AWG 4C');
INSERT INTO obras.maestro_estructura VALUES (1869, 'THHN # 1/2 AWG 4C', 'THHN # 1/2 AWG 4C');
INSERT INTO obras.maestro_estructura VALUES (1870, 'Poste Octogonal 13 m', 'Poste Octogonal 13 m');
INSERT INTO obras.maestro_estructura VALUES (1871, 'CPre 2x25 Neutro Des', 'CPre 2x25 Neutro Des');
INSERT INTO obras.maestro_estructura VALUES (1872, 'DUCTO PVC BT 1 X 63', 'DUCTO PVC BT 1 X 63');
INSERT INTO obras.maestro_estructura VALUES (1873, 'USE 53/USE 33MM2 4C', 'USE 53/USE 33MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1874, 'USE 13/THW 13MM2 3C', 'USE 13/THW 13MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1875, 'USE 13/THW 13MM2 2C', 'USE 13/THW 13MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1876, 'DUCTO PVC MT 1 X 110', 'DUCTO PVC MT 1 X 110');
INSERT INTO obras.maestro_estructura VALUES (1877, 'SECC. SCADA ABB 23KV', 'SECC. SCADA ABB 23KV');
INSERT INTO obras.maestro_estructura VALUES (1878, 'SECC. SCADA NULEC 15', 'SECC. SCADA NULEC 15');
INSERT INTO obras.maestro_estructura VALUES (1879, 'MONT SCADA ABB', 'MONT SCADA ABB');
INSERT INTO obras.maestro_estructura VALUES (1880, 'SECC. SCADA NULEC 23', 'SECC. SCADA NULEC 23');
INSERT INTO obras.maestro_estructura VALUES (1881, 'BT 76 M 4C ES', 'BT 76 M 4C ES');
INSERT INTO obras.maestro_estructura VALUES (1882, 'BT 76 M 3C ES', 'BT 76 M 3C ES');
INSERT INTO obras.maestro_estructura VALUES (1883, 'BT 76 M 2C ES', 'BT 76 M 2C ES');
INSERT INTO obras.maestro_estructura VALUES (1884, 'USE 13/THW 13MM2 4C', 'USE 13/THW 13MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1885, 'USEOXTU 107/TH107 4C', 'USEOXTU 107/TH107 4C');
INSERT INTO obras.maestro_estructura VALUES (1886, 'USE 33/THW 33MM2 2C', 'USE 33/THW 33MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1887, 'Cavanna NH00 1Ø', 'Cavanna NH00 1Ø');
INSERT INTO obras.maestro_estructura VALUES (1888, 'Cavanna NH00 2Ø', 'Cavanna NH00 2Ø');
INSERT INTO obras.maestro_estructura VALUES (1889, 'Cavanna NH00 3Ø', 'Cavanna NH00 3Ø');
INSERT INTO obras.maestro_estructura VALUES (1890, 'CCo 185 mm2 3Ø 25KV', 'CCo 185 mm2 3Ø 25KV');
INSERT INTO obras.maestro_estructura VALUES (1891, 'TMT S', 'TMT S');
INSERT INTO obras.maestro_estructura VALUES (1892, 'TMT D', 'TMT D');
INSERT INTO obras.maestro_estructura VALUES (1893, 'TMT D2', 'TMT D2');
INSERT INTO obras.maestro_estructura VALUES (1894, 'TMT L', 'TMT L');
INSERT INTO obras.maestro_estructura VALUES (1895, 'TMT M', 'TMT M');
INSERT INTO obras.maestro_estructura VALUES (1896, 'TBT M', 'TBT M');
INSERT INTO obras.maestro_estructura VALUES (1897, 'TBT S', 'TBT S');
INSERT INTO obras.maestro_estructura VALUES (1898, 'XLPE #2/0AWG 3F 15KV', 'XLPE #2/0AWG 3F 15KV');
INSERT INTO obras.maestro_estructura VALUES (1899, 'BARRA SE2PC', 'BARRA SE2PC');
INSERT INTO obras.maestro_estructura VALUES (1900, 'Anclaje Scada', 'Anclaje Scada');
INSERT INTO obras.maestro_estructura VALUES (1901, 'USE 177/THW 107MM2 4', 'USE 177/THW 107MM2 4');
INSERT INTO obras.maestro_estructura VALUES (1902, 'THW 400/400 MCM 4C', 'THW 400/400 MCM 4C');
INSERT INTO obras.maestro_estructura VALUES (1903, 'USE 21/THW 13MM2 2C', 'USE 21/THW 13MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (1904, 'DUCTO PVC MT 4 X 110', 'DUCTO PVC MT 4 X 110');
INSERT INTO obras.maestro_estructura VALUES (1905, 'USE 300/THW 300MCM 4', 'USE 300/THW 300MCM 4');
INSERT INTO obras.maestro_estructura VALUES (1906, 'Cavanna 3ø en Boveda', 'Cavanna 3ø en Boveda');
INSERT INTO obras.maestro_estructura VALUES (1907, 'Portal 3PC s/cruceta', 'Portal 3PC s/cruceta');
INSERT INTO obras.maestro_estructura VALUES (1908, 'USEoXTU 33.6 1C', 'USEoXTU 33.6 1C');
INSERT INTO obras.maestro_estructura VALUES (1909, 'CPr 185 MM2 3Ø 25KV', 'CPr 185 MM2 3Ø 25KV');
INSERT INTO obras.maestro_estructura VALUES (1910, 'PP Pre/Des 4C', 'PP Pre/Des 4C');
INSERT INTO obras.maestro_estructura VALUES (1911, 'EM 1ø BT Old', 'EM 1ø BT Old');
INSERT INTO obras.maestro_estructura VALUES (1912, 'EM 3ø BT Dir. 30kVA', 'EM 3ø BT Dir. 30kVA');
INSERT INTO obras.maestro_estructura VALUES (1913, 'EM 3ø BT Dir. 45kVA', 'EM 3ø BT Dir. 45kVA');
INSERT INTO obras.maestro_estructura VALUES (1914, 'EM 3ø BT Dir. 15kVA', 'EM 3ø BT Dir. 15kVA');
INSERT INTO obras.maestro_estructura VALUES (1915, 'EM 3ø BT Dir. 75kVA', 'EM 3ø BT Dir. 75kVA');
INSERT INTO obras.maestro_estructura VALUES (1916, 'EM 3ø BT Indir. c/TC', 'EM 3ø BT Indir. c/TC');
INSERT INTO obras.maestro_estructura VALUES (1917, 'Ampac 403A 3ø', 'Ampac 403A 3ø');
INSERT INTO obras.maestro_estructura VALUES (1918, 'Ampac 446A 3ø', 'Ampac 446A 3ø');
INSERT INTO obras.maestro_estructura VALUES (1919, 'Ampac 458A 3ø', 'Ampac 458A 3ø');
INSERT INTO obras.maestro_estructura VALUES (1920, 'Ampac 459A 3ø', 'Ampac 459A 3ø');
INSERT INTO obras.maestro_estructura VALUES (1921, 'Ampac 528R 3ø', 'Ampac 528R 3ø');
INSERT INTO obras.maestro_estructura VALUES (1922, 'Ampac 529A 3ø', 'Ampac 529A 3ø');
INSERT INTO obras.maestro_estructura VALUES (1923, 'Ampac 046-6 3ø', 'Ampac 046-6 3ø');
INSERT INTO obras.maestro_estructura VALUES (1924, 'Ampac 046-7 3ø', 'Ampac 046-7 3ø');
INSERT INTO obras.maestro_estructura VALUES (1925, 'Ampac 046-9 3ø', 'Ampac 046-9 3ø');
INSERT INTO obras.maestro_estructura VALUES (1926, 'Prensa 502 3ø', 'Prensa 502 3ø');
INSERT INTO obras.maestro_estructura VALUES (1927, 'Prensa 1489 3ø', 'Prensa 1489 3ø');
INSERT INTO obras.maestro_estructura VALUES (1928, 'Prensa 1506 3ø', 'Prensa 1506 3ø');
INSERT INTO obras.maestro_estructura VALUES (1929, 'Ampac 403A 2ø', 'Ampac 403A 2ø');
INSERT INTO obras.maestro_estructura VALUES (1930, 'Ampac 446A 2ø', 'Ampac 446A 2ø');
INSERT INTO obras.maestro_estructura VALUES (1931, 'Ampac 458A 2ø', 'Ampac 458A 2ø');
INSERT INTO obras.maestro_estructura VALUES (1932, 'Ampac 459A 2ø', 'Ampac 459A 2ø');
INSERT INTO obras.maestro_estructura VALUES (1933, 'Ampac 528R 2ø', 'Ampac 528R 2ø');
INSERT INTO obras.maestro_estructura VALUES (1934, 'Ampac 529A 2ø', 'Ampac 529A 2ø');
INSERT INTO obras.maestro_estructura VALUES (1935, 'Ampac 046-9 2ø', 'Ampac 046-9 2ø');
INSERT INTO obras.maestro_estructura VALUES (1936, 'Ampac 046-7 2ø', 'Ampac 046-7 2ø');
INSERT INTO obras.maestro_estructura VALUES (1937, 'Ampac 046-6 2ø', 'Ampac 046-6 2ø');
INSERT INTO obras.maestro_estructura VALUES (1938, 'Prensa 502 2ø', 'Prensa 502 2ø');
INSERT INTO obras.maestro_estructura VALUES (1939, 'Prensa 1489 2ø', 'Prensa 1489 2ø');
INSERT INTO obras.maestro_estructura VALUES (1940, 'Prensa 1506 2ø', 'Prensa 1506 2ø');
INSERT INTO obras.maestro_estructura VALUES (1941, 'Prensa 502 4c', 'Prensa 502 4c');
INSERT INTO obras.maestro_estructura VALUES (1942, 'Prensa 502 3c', 'Prensa 502 3c');
INSERT INTO obras.maestro_estructura VALUES (1943, 'Prensa 502 2c', 'Prensa 502 2c');
INSERT INTO obras.maestro_estructura VALUES (1944, 'Prensa 502 1c', 'Prensa 502 1c');
INSERT INTO obras.maestro_estructura VALUES (1945, 'TT MD P', 'TT MD P');
INSERT INTO obras.maestro_estructura VALUES (1946, 'TT 2E P', 'TT 2E P');
INSERT INTO obras.maestro_estructura VALUES (1947, 'TT 1E P', 'TT 1E P');
INSERT INTO obras.maestro_estructura VALUES (1948, 'TT M2E P', 'TT M2E P');
INSERT INTO obras.maestro_estructura VALUES (1949, 'TT MD S', 'TT MD S');
INSERT INTO obras.maestro_estructura VALUES (1950, 'TT 2E S', 'TT 2E S');
INSERT INTO obras.maestro_estructura VALUES (1951, 'TT 1E S', 'TT 1E S');
INSERT INTO obras.maestro_estructura VALUES (1952, 'TT M2E S', 'TT M2E S');
INSERT INTO obras.maestro_estructura VALUES (1953, 'TT MD S Pre', 'TT MD S Pre');
INSERT INTO obras.maestro_estructura VALUES (1954, 'TT 2E S Pre', 'TT 2E S Pre');
INSERT INTO obras.maestro_estructura VALUES (1955, 'TT 1E S Pre', 'TT 1E S Pre');
INSERT INTO obras.maestro_estructura VALUES (1956, 'TT M2E S Pre', 'TT M2E S Pre');
INSERT INTO obras.maestro_estructura VALUES (1957, 'USE 53MM2 4C', 'USE 53MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1958, 'CableCuCW 2AWG 2ø', 'CableCuCW 2AWG 2ø');
INSERT INTO obras.maestro_estructura VALUES (1959, 'PP Pre/Des 3C', 'PP Pre/Des 3C');
INSERT INTO obras.maestro_estructura VALUES (1960, 'PP Pre/Des 2C', 'PP Pre/Des 2C');
INSERT INTO obras.maestro_estructura VALUES (1961, 'PP Pre/Des 1C', 'PP Pre/Des 1C');
INSERT INTO obras.maestro_estructura VALUES (1962, 'PP Pre 2C', 'PP Pre 2C');
INSERT INTO obras.maestro_estructura VALUES (1963, 'PP Pre solo neutro', 'PP Pre solo neutro');
INSERT INTO obras.maestro_estructura VALUES (1964, 'PP Pre monof. neutro', 'PP Pre monof. neutro');
INSERT INTO obras.maestro_estructura VALUES (1965, 'MTCU 3F Portal PS', 'MTCU 3F Portal PS');
INSERT INTO obras.maestro_estructura VALUES (1966, 'MTCU 3F Portal PD', 'MTCU 3F Portal PD');
INSERT INTO obras.maestro_estructura VALUES (1967, 'CPre 3x95/50', 'CPre 3x95/50');
INSERT INTO obras.maestro_estructura VALUES (1968, 'THW 107/107 MM2 4C', 'THW 107/107 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1969, 'THW 107/107 MM2 3C', 'THW 107/107 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (1970, 'THW 107/THW 33MM2 4C', 'THW 107/THW 33MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (1971, 'MBT 4C doble prensa', 'MBT 4C doble prensa');
INSERT INTO obras.maestro_estructura VALUES (1972, 'Estribo TT', 'Estribo TT');
INSERT INTO obras.maestro_estructura VALUES (1973, '2do plano s/aisl', '2do plano s/aisl');
INSERT INTO obras.maestro_estructura VALUES (1974, '2plano s/aisl cru FE', '2plano s/aisl cru FE');
INSERT INTO obras.maestro_estructura VALUES (1975, 'MT SE1PC 2F S2P PV', 'MT SE1PC 2F S2P PV');
INSERT INTO obras.maestro_estructura VALUES (1976, 'MT SE1PC 3F S2P PV', 'MT SE1PC 3F S2P PV');
INSERT INTO obras.maestro_estructura VALUES (1977, 'PC  9.0 m', 'PC  9.0 m');
INSERT INTO obras.maestro_estructura VALUES (1978, 'SC 300A 3ø', 'SC 300A 3ø');
INSERT INTO obras.maestro_estructura VALUES (1979, 'PC 18.0 m', 'PC 18.0 m');
INSERT INTO obras.maestro_estructura VALUES (1980, 'PR 3ø 15KV', 'PR 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (1981, 'TIR  S', 'TIR  S');
INSERT INTO obras.maestro_estructura VALUES (1982, 'Estribo TT', 'Estribo TT');
INSERT INTO obras.maestro_estructura VALUES (1983, '2do plano s/aisl', '2do plano s/aisl');
INSERT INTO obras.maestro_estructura VALUES (1984, '2plano s/aisl cru FE', '2plano s/aisl cru FE');
INSERT INTO obras.maestro_estructura VALUES (1985, 'Cavanna cuchillo LZ', 'Cavanna cuchillo LZ');
INSERT INTO obras.maestro_estructura VALUES (1986, 'MTAL 15N 3M PS 33MM2', 'MTAL 15N 3M PS 33MM2');
INSERT INTO obras.maestro_estructura VALUES (1987, 'MTAL 15N 3M PS 53MM2', 'MTAL 15N 3M PS 53MM2');
INSERT INTO obras.maestro_estructura VALUES (1988, 'MTAL 15N 3M PS 107MM', 'MTAL 15N 3M PS 107MM');
INSERT INTO obras.maestro_estructura VALUES (1989, 'MTAL 15N 3M PD 33MM2', 'MTAL 15N 3M PD 33MM2');
INSERT INTO obras.maestro_estructura VALUES (1990, 'MTAL 15N 3M PD 53MM2', 'MTAL 15N 3M PD 53MM2');
INSERT INTO obras.maestro_estructura VALUES (1991, 'MTAL 15N 3M PD 107MM', 'MTAL 15N 3M PD 107MM');
INSERT INTO obras.maestro_estructura VALUES (1992, 'MTAL 15N 3M PCD 33MM', 'MTAL 15N 3M PCD 33MM');
INSERT INTO obras.maestro_estructura VALUES (1993, 'MTAL 15N 3M PCD 107M', 'MTAL 15N 3M PCD 107M');
INSERT INTO obras.maestro_estructura VALUES (1994, 'MTAL 15N 3M PC 33MM', 'MTAL 15N 3M PC 33MM');
INSERT INTO obras.maestro_estructura VALUES (1995, 'MTAL 15N 3M PC 53MM', 'MTAL 15N 3M PC 53MM');
INSERT INTO obras.maestro_estructura VALUES (1996, 'MTAL 15N 3M PC 107MM', 'MTAL 15N 3M PC 107MM');
INSERT INTO obras.maestro_estructura VALUES (1997, 'MTAL 15N 3M JI 33MM', 'MTAL 15N 3M JI 33MM');
INSERT INTO obras.maestro_estructura VALUES (1998, 'MTAL 15N 3M JI 53MM', 'MTAL 15N 3M JI 53MM');
INSERT INTO obras.maestro_estructura VALUES (1999, 'MTAL 15N 3M JI 107MM', 'MTAL 15N 3M JI 107MM');
INSERT INTO obras.maestro_estructura VALUES (2000, 'MTAL 15N 3M PD', 'MTAL 15N 3M PD');
INSERT INTO obras.maestro_estructura VALUES (2001, 'Ext. Paso Compacto', 'Ext. Paso Compacto');
INSERT INTO obras.maestro_estructura VALUES (2002, 'MTAL 15N 3M JA 33MM2', 'MTAL 15N 3M JA 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2003, 'MTAL 15N 3M JA 53MM2', 'MTAL 15N 3M JA 53MM2');
INSERT INTO obras.maestro_estructura VALUES (2004, 'MTAL 15N 3M JA 107MM', 'MTAL 15N 3M JA 107MM');
INSERT INTO obras.maestro_estructura VALUES (2005, 'MTAL 15N 3M A2PE', 'MTAL 15N 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (2006, 'MTAL 15N 3M A2PE 33M', 'MTAL 15N 3M A2PE 33M');
INSERT INTO obras.maestro_estructura VALUES (2007, 'MTAL 15N 3M RP', 'MTAL 15N 3M RP');
INSERT INTO obras.maestro_estructura VALUES (2008, 'MTAL 15N 3M RS', 'MTAL 15N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (2009, 'MTAL 15N 3M RT', 'MTAL 15N 3M RT');
INSERT INTO obras.maestro_estructura VALUES (2010, 'MTAL 15N 3M RT 33MM2', 'MTAL 15N 3M RT 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2011, 'MTAL 15N 3M SJ 33MM2', 'MTAL 15N 3M SJ 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2012, 'MTAL 15N 2M JI', 'MTAL 15N 2M JI');
INSERT INTO obras.maestro_estructura VALUES (2013, 'MTAL 15N 2M SJ 33MM2', 'MTAL 15N 2M SJ 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2014, 'MTAL 15N 2M SJ 3/2 3', 'MTAL 15N 2M SJ 3/2 3');
INSERT INTO obras.maestro_estructura VALUES (2015, 'MTAL 15N 2M PC 33MM2', 'MTAL 15N 2M PC 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2016, 'MTPROT 15N 2M JI', 'MTPROT 15N 2M JI');
INSERT INTO obras.maestro_estructura VALUES (2017, 'MTPROT 15N 2M PD', 'MTPROT 15N 2M PD');
INSERT INTO obras.maestro_estructura VALUES (2018, 'MTPROT 15N 2M PS', 'MTPROT 15N 2M PS');
INSERT INTO obras.maestro_estructura VALUES (2019, 'MTPROT 15N 2M RS', 'MTPROT 15N 2M RS');
INSERT INTO obras.maestro_estructura VALUES (2020, 'MTPROT 15N 3M A2PE', 'MTPROT 15N 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (2021, 'MTPROT 15N 3M H', 'MTPROT 15N 3M H');
INSERT INTO obras.maestro_estructura VALUES (2022, 'MTPROT 15N 3M JI', 'MTPROT 15N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (2023, 'MTPROT 15N 3M PC', 'MTPROT 15N 3M PC');
INSERT INTO obras.maestro_estructura VALUES (2024, 'MTPROT 15N 3M PCD', 'MTPROT 15N 3M PCD');
INSERT INTO obras.maestro_estructura VALUES (2025, 'MTPROT 15N 3M PD', 'MTPROT 15N 3M PD');
INSERT INTO obras.maestro_estructura VALUES (2026, 'MTPROT 15N 3M PS', 'MTPROT 15N 3M PS');
INSERT INTO obras.maestro_estructura VALUES (2027, 'MTPROT 15N 3M RS', 'MTPROT 15N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (2028, 'MTPROT 23N 3M A2PE', 'MTPROT 23N 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (2029, 'MTPROT 23N 3M JI', 'MTPROT 23N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (2030, 'MTPROT 23N 3M PC', 'MTPROT 23N 3M PC');
INSERT INTO obras.maestro_estructura VALUES (2031, 'MTPROT 23N 3M PD', 'MTPROT 23N 3M PD');
INSERT INTO obras.maestro_estructura VALUES (2032, 'MTPROT 23N 3M PS', 'MTPROT 23N 3M PS');
INSERT INTO obras.maestro_estructura VALUES (2033, 'MTPROT 23N 3M RS', 'MTPROT 23N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (2034, 'MTAL 15N 2M RS', 'MTAL 15N 2M RS');
INSERT INTO obras.maestro_estructura VALUES (2035, 'MTAL 15N 2M A2PE', 'MTAL 15N 2M A2PE');
INSERT INTO obras.maestro_estructura VALUES (2036, 'MTAL 15N 2M A2PE 33M', 'MTAL 15N 2M A2PE 33M');
INSERT INTO obras.maestro_estructura VALUES (2037, 'MTAL 15N 2M PD 33MM2', 'MTAL 15N 2M PD 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2038, 'MTAL 15N 2M PS 33MM2', 'MTAL 15N 2M PS 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2039, 'MTAL 15N 2M RT', 'MTAL 15N 2M RT');
INSERT INTO obras.maestro_estructura VALUES (2040, 'MTAL 15N 2M RT 33MM2', 'MTAL 15N 2M RT 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2041, 'MTCU 15N 3M JI', 'MTCU 15N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (2042, 'MTCU 15N 3M RS', 'MTCU 15N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (2043, 'MTCU 15N 2M RS', 'MTCU 15N 2M RS');
INSERT INTO obras.maestro_estructura VALUES (2044, 'MTCU 15N 3P JI', 'MTCU 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (2045, 'MTCU 15N 3P JA', 'MTCU 15N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (2046, 'BT 76 B 4C ES', 'BT 76 B 4C ES');
INSERT INTO obras.maestro_estructura VALUES (2047, 'BT 76 B 3C ES', 'BT 76 B 3C ES');
INSERT INTO obras.maestro_estructura VALUES (2048, 'BT 76 B 2C ES', 'BT 76 B 2C ES');
INSERT INTO obras.maestro_estructura VALUES (2049, 'MTCU 15N 3M V', 'MTCU 15N 3M V');
INSERT INTO obras.maestro_estructura VALUES (2050, 'MTCU 15N 2M A2PE', 'MTCU 15N 2M A2PE');
INSERT INTO obras.maestro_estructura VALUES (2051, 'MTCU 15N 3M D', 'MTCU 15N 3M D');
INSERT INTO obras.maestro_estructura VALUES (2052, 'MTCU 15N 3M JP', 'MTCU 15N 3M JP');
INSERT INTO obras.maestro_estructura VALUES (2053, 'MTCU 15N 3M PD', 'MTCU 15N 3M PD');
INSERT INTO obras.maestro_estructura VALUES (2054, 'MTCU 15N 3M PS', 'MTCU 15N 3M PS');
INSERT INTO obras.maestro_estructura VALUES (2055, 'MTCU 15N 3M PCD', 'MTCU 15N 3M PCD');
INSERT INTO obras.maestro_estructura VALUES (2056, 'MTCU 15N 3M PC', 'MTCU 15N 3M PC');
INSERT INTO obras.maestro_estructura VALUES (2057, 'MTCU 15N 2M Semiancl', 'MTCU 15N 2M Semiancl');
INSERT INTO obras.maestro_estructura VALUES (2058, 'MTCU 15N 3M Semiancl', 'MTCU 15N 3M Semiancl');
INSERT INTO obras.maestro_estructura VALUES (2059, 'MTCU 15N 2M PS', 'MTCU 15N 2M PS');
INSERT INTO obras.maestro_estructura VALUES (2060, 'MTCU 15N 3M T', 'MTCU 15N 3M T');
INSERT INTO obras.maestro_estructura VALUES (2061, 'MTCU 15N 3M Montaje', 'MTCU 15N 3M Montaje');
INSERT INTO obras.maestro_estructura VALUES (2062, 'MTCU 15N 3M RT', 'MTCU 15N 3M RT');
INSERT INTO obras.maestro_estructura VALUES (2063, 'MTCU 15N 2M Montaje', 'MTCU 15N 2M Montaje');
INSERT INTO obras.maestro_estructura VALUES (2064, 'MTPROT 15C 3M JI', 'MTPROT 15C 3M JI');
INSERT INTO obras.maestro_estructura VALUES (2065, 'MTCO 15N 3M PS Angul', 'MTCO 15N 3M PS Angul');
INSERT INTO obras.maestro_estructura VALUES (2066, 'MTCO 15N 3M PS SB', 'MTCO 15N 3M PS SB');
INSERT INTO obras.maestro_estructura VALUES (2067, 'MTCO 15N 3M PS CB', 'MTCO 15N 3M PS CB');
INSERT INTO obras.maestro_estructura VALUES (2068, 'MTCO 15N 3M PD', 'MTCO 15N 3M PD');
INSERT INTO obras.maestro_estructura VALUES (2069, 'MTCO 15N 3M PC', 'MTCO 15N 3M PC');
INSERT INTO obras.maestro_estructura VALUES (2070, 'MTCO 15N 3M RS', 'MTCO 15N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (2071, 'MTCO 15N 3M RS 107MM', 'MTCO 15N 3M RS 107MM');
INSERT INTO obras.maestro_estructura VALUES (2072, 'MTCO 15N 3M RS 33MM2', 'MTCO 15N 3M RS 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2073, 'MTCO 15N 3M RS 53MM2', 'MTCO 15N 3M RS 53MM2');
INSERT INTO obras.maestro_estructura VALUES (2074, 'MTCO 15N 3M JI 33MM2', 'MTCO 15N 3M JI 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2075, 'MTCO 15N 3M JI 53MM2', 'MTCO 15N 3M JI 53MM2');
INSERT INTO obras.maestro_estructura VALUES (2076, 'MTCO 15N 3M JI 107MM', 'MTCO 15N 3M JI 107MM');
INSERT INTO obras.maestro_estructura VALUES (2077, 'MTCO 15N 3M H 33MM2', 'MTCO 15N 3M H 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2078, 'MTCO 15C 3M JI 53MM2', 'MTCO 15C 3M JI 53MM2');
INSERT INTO obras.maestro_estructura VALUES (2079, 'MTCO 15C 3M TRANSICI', 'MTCO 15C 3M TRANSICI');
INSERT INTO obras.maestro_estructura VALUES (2080, 'MTCO 15N 3M A2PE', 'MTCO 15N 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (2081, 'MTCO 15N 3M A2PE DF', 'MTCO 15N 3M A2PE DF');
INSERT INTO obras.maestro_estructura VALUES (2082, 'MTCO 15N 3M SED 1 PO', 'MTCO 15N 3M SED 1 PO');
INSERT INTO obras.maestro_estructura VALUES (2083, 'MTCO 15N 3M SED 2 PO', 'MTCO 15N 3M SED 2 PO');
INSERT INTO obras.maestro_estructura VALUES (2084, 'MTCO 15N 3M TRANSICI', 'MTCO 15N 3M TRANSICI');
INSERT INTO obras.maestro_estructura VALUES (2085, 'CAl 2 AAAC 3ø', 'CAl 2 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (2086, 'Prot 107.2 mm2 3Ø 25', 'Prot 107.2 mm2 3Ø 25');
INSERT INTO obras.maestro_estructura VALUES (2087, 'MTCO 23N 3M PS Angul', 'MTCO 23N 3M PS Angul');
INSERT INTO obras.maestro_estructura VALUES (2088, 'MTCO 23N 3M PS CB', 'MTCO 23N 3M PS CB');
INSERT INTO obras.maestro_estructura VALUES (2089, 'MTCO 23N 3M PC', 'MTCO 23N 3M PC');
INSERT INTO obras.maestro_estructura VALUES (2090, 'MTCO 23N 3M RS', 'MTCO 23N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (2091, 'MTCO 23N 3M RS 53MM2', 'MTCO 23N 3M RS 53MM2');
INSERT INTO obras.maestro_estructura VALUES (2092, 'MTCO 23N 3M RS 107MM', 'MTCO 23N 3M RS 107MM');
INSERT INTO obras.maestro_estructura VALUES (2093, 'MTCO 23N 3M H 53MM2', 'MTCO 23N 3M H 53MM2');
INSERT INTO obras.maestro_estructura VALUES (2094, 'MTCO 23N 3M JI 107MM', 'MTCO 23N 3M JI 107MM');
INSERT INTO obras.maestro_estructura VALUES (2095, 'MTCO 23N 3M TRANSICI', 'MTCO 23N 3M TRANSICI');
INSERT INTO obras.maestro_estructura VALUES (2096, 'MTCO 23N 3M A2PE DF', 'MTCO 23N 3M A2PE DF');
INSERT INTO obras.maestro_estructura VALUES (2097, 'MTAL 23N 2M SJ 33MM2', 'MTAL 23N 2M SJ 33MM2');
INSERT INTO obras.maestro_estructura VALUES (2098, 'CAl 33.63 AAAC 2ø', 'CAl 33.63 AAAC 2ø');
INSERT INTO obras.maestro_estructura VALUES (2099, 'CPre 3x70/50', 'CPre 3x70/50');
INSERT INTO obras.maestro_estructura VALUES (2100, 'MTCU 23N 3M PS', 'MTCU 23N 3M PS');
INSERT INTO obras.maestro_estructura VALUES (2101, 'Montaje DF 3F', 'Montaje DF 3F');
INSERT INTO obras.maestro_estructura VALUES (2102, 'MTCO 15N 2 JI', 'MTCO 15N 2 JI');
INSERT INTO obras.maestro_estructura VALUES (2103, 'MTCO 15V 2 JI', 'MTCO 15V 2 JI');
INSERT INTO obras.maestro_estructura VALUES (2104, 'MTCO 23N 2 JI', 'MTCO 23N 2 JI');
INSERT INTO obras.maestro_estructura VALUES (2105, 'MTCO 23V 2 JI', 'MTCO 23V 2 JI');
INSERT INTO obras.maestro_estructura VALUES (2106, 'Ampac 046-5 3ø', 'Ampac 046-5 3ø');
INSERT INTO obras.maestro_estructura VALUES (2107, 'Ampac 046-5 2ø', 'Ampac 046-5 2ø');
INSERT INTO obras.maestro_estructura VALUES (2108, 'CPre 3x95/50', 'CPre 3x95/50');
INSERT INTO obras.maestro_estructura VALUES (2109, 'CPre 3x50/50', 'CPre 3x50/50');
INSERT INTO obras.maestro_estructura VALUES (2110, 'Cpre 1x16/16 Neutro', 'Cpre 1x16/16 Neutro');
INSERT INTO obras.maestro_estructura VALUES (2111, 'DUCTO PVC BT 1 X 4', 'DUCTO PVC BT 1 X 4');
INSERT INTO obras.maestro_estructura VALUES (2112, 'DUCTO PVC MT 4 X 2', 'DUCTO PVC MT 4 X 2');
INSERT INTO obras.maestro_estructura VALUES (2113, 'CCu 85/53.5 MM2 4C', 'CCu 85/53.5 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2114, 'BTPre P M', 'BTPre P M');
INSERT INTO obras.maestro_estructura VALUES (2115, 'BTPre R M', 'BTPre R M');
INSERT INTO obras.maestro_estructura VALUES (2116, 'CCu 53,5 mm2  3ø', 'CCu 53,5 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (2117, 'CCu 53.5/53.5 MM2 4C', 'CCu 53.5/53.5 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2118, 'CPr 70 mm2 3ø 25 KV', 'CPr 70 mm2 3ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (2119, 'CPr 70 mm2 2ø 25 KV', 'CPr 70 mm2 2ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (2120, 'CCu 16/16 MM2 2C', 'CCu 16/16 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (2121, 'CCu 13/13 MM2 2C', 'CCu 13/13 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (2122, 'MT 15 3F PS', 'MT 15 3F PS');
INSERT INTO obras.maestro_estructura VALUES (2123, 'MT 15 3F T', 'MT 15 3F T');
INSERT INTO obras.maestro_estructura VALUES (2124, 'CAl 120mm2 3ø', 'CAl 120mm2 3ø');
INSERT INTO obras.maestro_estructura VALUES (2125, 'CAl 300mm2 3ø', 'CAl 300mm2 3ø');
INSERT INTO obras.maestro_estructura VALUES (2126, 'DF 10kAR 3ø', 'DF 10kAR 3ø');
INSERT INTO obras.maestro_estructura VALUES (2127, 'DF 10kAR 2ø', 'DF 10kAR 2ø');
INSERT INTO obras.maestro_estructura VALUES (2128, 'CCo 300 mm2 3Ø 25KV', 'CCo 300 mm2 3Ø 25KV');
INSERT INTO obras.maestro_estructura VALUES (2129, 'XLPE 240 mm ²3F 23KV', 'XLPE 240 mm ²3F 23KV');
INSERT INTO obras.maestro_estructura VALUES (2130, 'CCu 16mm2  3ø', 'CCu 16mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (2131, 'CCu 13.30 mm2  3ø', 'CCu 13.30 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (2132, 'CCu 53.5/53.5 MM2 4C', 'CCu 53.5/53.5 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2133, 'CCu 16/16 MM2 4C', 'CCu 16/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2134, 'CCu 25/25 MM2 4C', 'CCu 25/25 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2135, 'CCu 33.6/33.6 MM2 4C', 'CCu 33.6/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2136, 'Prot 33.59 mm2 3Ø 25', 'Prot 33.59 mm2 3Ø 25');
INSERT INTO obras.maestro_estructura VALUES (2137, 'USEoXTU 67/67.4 4C', 'USEoXTU 67/67.4 4C');
INSERT INTO obras.maestro_estructura VALUES (2138, 'CPre 1x25/25 Neutro', 'CPre 1x25/25 Neutro');
INSERT INTO obras.maestro_estructura VALUES (2139, 'CCu 13.2/13.2 MM2 4C', 'CCu 13.2/13.2 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2140, 'CCu 13.29/13.29 MM2', 'CCu 13.29/13.29 MM2');
INSERT INTO obras.maestro_estructura VALUES (2141, 'CCu 16/16 MM2 3C', 'CCu 16/16 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (2142, 'CCu 25/25 MM2 3C', 'CCu 25/25 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (2143, 'CCu 67.4/67.4 MM2 3C', 'CCu 67.4/67.4 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (2144, 'CCu 25/16 MM2 4C', 'CCu 25/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2145, 'CCu 33.6/16 MM2 4C', 'CCu 33.6/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2146, 'BTPre 76B1F R+Der', 'BTPre 76B1F R+Der');
INSERT INTO obras.maestro_estructura VALUES (2147, 'BTPreP76B1FP+Der-C-m', 'BTPreP76B1FP+Der-C-m');
INSERT INTO obras.maestro_estructura VALUES (2148, 'BTPre RL B', 'BTPre RL B');
INSERT INTO obras.maestro_estructura VALUES (2149, 'BTPre P 76B 1F', 'BTPre P 76B 1F');
INSERT INTO obras.maestro_estructura VALUES (2150, 'BTPre LZ B', 'BTPre LZ B');
INSERT INTO obras.maestro_estructura VALUES (2151, 'BTPre P M + Der', 'BTPre P M + Der');
INSERT INTO obras.maestro_estructura VALUES (2152, 'BTPre LZ M', 'BTPre LZ M');
INSERT INTO obras.maestro_estructura VALUES (2153, 'BTPre LZ M C/ Desc', 'BTPre LZ M C/ Desc');
INSERT INTO obras.maestro_estructura VALUES (2154, 'BTPre LZ 76 M 1F', 'BTPre LZ 76 M 1F');
INSERT INTO obras.maestro_estructura VALUES (2155, 'BTPre P 76B 1F Angul', 'BTPre P 76B 1F Angul');
INSERT INTO obras.maestro_estructura VALUES (2156, 'BTPre P 76B 1F Ang+D', 'BTPre P 76B 1F Ang+D');
INSERT INTO obras.maestro_estructura VALUES (2157, 'BTPre R 76B 1F', 'BTPre R 76B 1F');
INSERT INTO obras.maestro_estructura VALUES (2158, 'BTPre P 76M 1F', 'BTPre P 76M 1F');
INSERT INTO obras.maestro_estructura VALUES (2159, 'BTPre R B', 'BTPre R B');
INSERT INTO obras.maestro_estructura VALUES (2160, 'BTPre R M + Der<90', 'BTPre R M + Der<90');
INSERT INTO obras.maestro_estructura VALUES (2161, 'BTPre R M + Der>90', 'BTPre R M + Der>90');
INSERT INTO obras.maestro_estructura VALUES (2162, 'BTPre R 76M 1F + Der', 'BTPre R 76M 1F + Der');
INSERT INTO obras.maestro_estructura VALUES (2163, 'BTPreR 76M 1F+Der>90', 'BTPreR 76M 1F+Der>90');
INSERT INTO obras.maestro_estructura VALUES (2164, 'BTPre RL M', 'BTPre RL M');
INSERT INTO obras.maestro_estructura VALUES (2165, 'BTPre R B + Der', 'BTPre R B + Der');
INSERT INTO obras.maestro_estructura VALUES (2166, 'BTPre LZ B', 'BTPre LZ B');
INSERT INTO obras.maestro_estructura VALUES (2167, 'CAl 107.2 AAAC 3ø', 'CAl 107.2 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (2168, 'CAl 33.59 AAAC 3ø', 'CAl 33.59 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (2169, 'CAl 53.46 AAAC 3ø', 'CAl 53.46 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (2170, 'PC 10.0 m', 'PC 10.0 m');
INSERT INTO obras.maestro_estructura VALUES (2171, 'PC 11.5 m', 'PC 11.5 m');
INSERT INTO obras.maestro_estructura VALUES (2172, 'PC  9.0 m', 'PC  9.0 m');
INSERT INTO obras.maestro_estructura VALUES (2173, 'BT LZ 76 B SB NRST', 'BT LZ 76 B SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2174, 'BT P 76 B SB NRST', 'BT P 76 B SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2175, 'BT P 76 B SB NRST+De', 'BT P 76 B SB NRST+De');
INSERT INTO obras.maestro_estructura VALUES (2176, 'BT P 76B SB NRST +De', 'BT P 76B SB NRST +De');
INSERT INTO obras.maestro_estructura VALUES (2177, 'BT P 76 B SB NRST An', 'BT P 76 B SB NRST An');
INSERT INTO obras.maestro_estructura VALUES (2178, 'BT P 76 B SB NRST An', 'BT P 76 B SB NRST An');
INSERT INTO obras.maestro_estructura VALUES (2179, 'BT P 76B SB NRS', 'BT P 76B SB NRS');
INSERT INTO obras.maestro_estructura VALUES (2180, 'BT P 76B SB NRS angu', 'BT P 76B SB NRS angu');
INSERT INTO obras.maestro_estructura VALUES (2181, 'BT P 76B SB NR', 'BT P 76B SB NR');
INSERT INTO obras.maestro_estructura VALUES (2182, 'BT P 76B SB NR+Der2v', 'BT P 76B SB NR+Der2v');
INSERT INTO obras.maestro_estructura VALUES (2183, 'BT P 76B SB NR Angul', 'BT P 76B SB NR Angul');
INSERT INTO obras.maestro_estructura VALUES (2184, 'BT P 76B SB N', 'BT P 76B SB N');
INSERT INTO obras.maestro_estructura VALUES (2185, 'BT P 76B SB N Angulo', 'BT P 76B SB N Angulo');
INSERT INTO obras.maestro_estructura VALUES (2186, 'BT P 76M SB NRST', 'BT P 76M SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2187, 'BTPre P B', 'BTPre P B');
INSERT INTO obras.maestro_estructura VALUES (2188, 'BT P 76M SB NRST+Der', 'BT P 76M SB NRST+Der');
INSERT INTO obras.maestro_estructura VALUES (2189, 'BT P 76M SB NRST+Der', 'BT P 76M SB NRST+Der');
INSERT INTO obras.maestro_estructura VALUES (2190, 'BT P 76M SB NRST+Der', 'BT P 76M SB NRST+Der');
INSERT INTO obras.maestro_estructura VALUES (2191, 'BT P 76M SB NRST Ang', 'BT P 76M SB NRST Ang');
INSERT INTO obras.maestro_estructura VALUES (2192, 'BT P 76M SB NRS', 'BT P 76M SB NRS');
INSERT INTO obras.maestro_estructura VALUES (2193, 'PC 15.0 m C', 'PC 15.0 m C');
INSERT INTO obras.maestro_estructura VALUES (2194, 'Prot 53.46 mm2 3Ø 25', 'Prot 53.46 mm2 3Ø 25');
INSERT INTO obras.maestro_estructura VALUES (2195, 'CPre 3x35/50', 'CPre 3x35/50');
INSERT INTO obras.maestro_estructura VALUES (2196, 'CCu 33,6 mm2  3ø', 'CCu 33,6 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (2197, 'CCu 16 mm2  2ø', 'CCu 16 mm2  2ø');
INSERT INTO obras.maestro_estructura VALUES (2198, 'PC 13 m', 'PC 13 m');
INSERT INTO obras.maestro_estructura VALUES (2199, 'PM 11.5 m', 'PM 11.5 m');
INSERT INTO obras.maestro_estructura VALUES (2200, 'Cu PoleTop 900A', 'Cu PoleTop 900A');
INSERT INTO obras.maestro_estructura VALUES (2201, 'Cu 1x10', 'Cu 1x10');
INSERT INTO obras.maestro_estructura VALUES (2202, 'Cu 1x10/Nx10', 'Cu 1x10/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2203, 'Cu 1x10/Nx10', 'Cu 1x10/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2204, 'Cu 2x10/Nx10', 'Cu 2x10/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2205, 'Cu 3x10/Nx10', 'Cu 3x10/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2206, 'Cu 3x10/Nx16', 'Cu 3x10/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2207, 'Cu 2x10/Nx16', 'Cu 2x10/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2208, 'Cu 2x10/1x16/Nx10', 'Cu 2x10/1x16/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2209, 'Cu 2x13/1x10/Nx10', 'Cu 2x13/1x10/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2210, 'Cu 1x10/Nx16', 'Cu 1x10/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2211, 'Cu 1x16/1x10/Nx10', 'Cu 1x16/1x10/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2212, 'Cu 1x16/1x13/1x10/Nx', 'Cu 1x16/1x13/1x10/Nx');
INSERT INTO obras.maestro_estructura VALUES (2213, 'Cu 2x16/1x10/Nx10', 'Cu 2x16/1x10/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2214, 'Cu 1x13', 'Cu 1x13');
INSERT INTO obras.maestro_estructura VALUES (2215, 'Cu 1x13/Nx10', 'Cu 1x13/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2216, 'Cu 1x13/1x10/Nx16', 'Cu 1x13/1x10/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2217, 'Cu 1x13/Nx13', 'Cu 1x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2218, 'Cu 2x13/Nx10', 'Cu 2x13/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2219, 'Cu 2x13/1x10/Nx13', 'Cu 2x13/1x10/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2220, 'Cu 2x13/Nx13', 'Cu 2x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2221, 'Cu 3x13/Nx10', 'Cu 3x13/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2222, 'Cu 3x13/Nx13', 'Cu 3x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2223, 'Cu 3x13/Nx16', 'Cu 3x13/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2224, 'Cu 2x13/1x16/Nx10', 'Cu 2x13/1x16/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2225, 'Cu 2x13/1x16/Nx13', 'Cu 2x13/1x16/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2226, 'Cu 2x13/1x16/Nx16', 'Cu 2x13/1x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2227, 'Cu 2x13/1x26/Nx13', 'Cu 2x13/1x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2228, 'Cu 1x13/Nx16', 'Cu 1x13/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2229, 'Cu 1x16/1x13/1x10/Nx', 'Cu 1x16/1x13/1x10/Nx');
INSERT INTO obras.maestro_estructura VALUES (2230, 'Cu 1x16/1x13/Nx13', 'Cu 1x16/1x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2231, 'Cu 1x16/1x13/Nx16', 'Cu 1x16/1x13/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2232, 'Cu 2x16/1x13/Nx13', 'Cu 2x16/1x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2233, 'Cu 2x16/1x13/Nx16', 'Cu 2x16/1x13/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2234, 'Cu 2x21/1x13/Nx13', 'Cu 2x21/1x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2235, 'Cu 1x13/Nx13', 'Cu 1x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2236, 'Cu 1x16', 'Cu 1x16');
INSERT INTO obras.maestro_estructura VALUES (2237, 'Cu 1x16', 'Cu 1x16');
INSERT INTO obras.maestro_estructura VALUES (2238, 'Cu 1x16/Nx10', 'Cu 1x16/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2239, 'Cu 1x16/Nx13', 'Cu 1x16/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2240, 'Cu 2x13/1x16/Nx10', 'Cu 2x13/1x16/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2241, 'Cu 2x13/1x16/Nx13', 'Cu 2x13/1x16/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2242, 'Cu 2x16/1x13/Nx16', 'Cu 2x16/1x13/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2243, 'Cu 1x16/Nx16', 'Cu 1x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2244, 'Cu 1x16/Nx16', 'Cu 1x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2245, 'Cu 2x16/Nx10', 'Cu 2x16/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2246, 'Cu 2x16/1x10/Nx10', 'Cu 2x16/1x10/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2247, 'Cu 2x16/1x10/Nx16', 'Cu 2x16/1x10/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2248, 'Cu 2x16/Nx13', 'Cu 2x16/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2249, 'Cu 2x16/1x13/Nx13', 'Cu 2x16/1x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2250, 'Cu 2x16/Nx16', 'Cu 2x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2251, 'Cu 3x16/Nx10', 'Cu 3x16/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2252, 'Cu 3x16/Nx13', 'Cu 3x16/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2253, 'Cu 3x16/Nx16', 'Cu 3x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2254, 'Cu 3x16/Nx21', 'Cu 3x16/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2255, 'Cu 2x16/1x21/Nx10', 'Cu 2x16/1x21/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2256, 'Cu 2x16/1x21/Nx13', 'Cu 2x16/1x21/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2257, 'Cu 2x16/1x21/Nx16', 'Cu 2x16/1x21/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2258, 'Cu 1x16/Nx21', 'Cu 1x16/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2259, 'Cu 1x21/1x16/Nx16', 'Cu 1x21/1x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2260, 'Cu 2x21/1x16/Nx13', 'Cu 2x21/1x16/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2261, 'Cu 2x21/1x16/Nx16', 'Cu 2x21/1x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2262, 'Cu 2x26/1x16/Nx10', 'Cu 2x26/1x16/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2263, 'Cu 1x16/Nx8', 'Cu 1x16/Nx8');
INSERT INTO obras.maestro_estructura VALUES (2264, 'Cu 1x21', 'Cu 1x21');
INSERT INTO obras.maestro_estructura VALUES (2265, 'Cu 1x21/Nx13', 'Cu 1x21/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2266, 'Cu 1x21/Nx16', 'Cu 1x21/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2267, 'Cu 1x21/1x16/Nx10', 'Cu 1x21/1x16/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2268, 'Cu 2x16/1x21/Nx10', 'Cu 2x16/1x21/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2269, 'Cu 2x16/1x21/Nx13', 'Cu 2x16/1x21/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2270, 'Cu 2x16/1x21/Nx16', 'Cu 2x16/1x21/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2271, 'Cu 2x16/1x21/Nx13', 'Cu 2x16/1x21/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2272, 'Cu 1x21/Nx21', 'Cu 1x21/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2273, 'Cu 2x21/Nx10', 'Cu 2x21/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2274, 'Cu 2x21/1x13/Nx13', 'Cu 2x21/1x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2275, 'Cu 2x21/1x16/Nx16', 'Cu 2x21/1x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2276, 'Cu 2x21/1x16/Nx21', 'Cu 2x21/1x16/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2277, 'Cu 2x21/Nx21', 'Cu 2x21/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2278, 'Cu 3x21/Nx10', 'Cu 3x21/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2279, 'Cu 3x21/Nx13', 'Cu 3x21/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2280, 'Cu 3x21/Nx16', 'Cu 3x21/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2281, 'Cu 3x21/Nx21', 'Cu 3x21/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2282, 'Cu 2x26/1x21/Nx13', 'Cu 2x26/1x21/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2283, 'Cu 2x26/1x21/Nx21', 'Cu 2x26/1x21/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2284, 'Cu 1x26/Nx16', 'Cu 1x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2285, 'Cu 2x16/1x26/Nx10', 'Cu 2x16/1x26/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2286, 'Cu 2x21/1x26/Nx10', 'Cu 2x21/1x26/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2287, 'Cu 2x21/1x26/Nx21', 'Cu 2x21/1x26/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2288, 'Cu 2x26/1x21/Nx16', 'Cu 2x26/1x21/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2289, 'Cu 2x26/Nx16', 'Cu 2x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2290, 'Cu 2x26/1x21/Nx10', 'Cu 2x26/1x21/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2291, 'Cu 2x26/1x21/Nx13', 'Cu 2x26/1x21/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2292, 'Cu 2x26/1x21/Nx16', 'Cu 2x26/1x21/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2293, 'Cu 2x26/Nx26', 'Cu 2x26/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2294, 'Cu 3x26/Nx10', 'Cu 3x26/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2295, 'Cu 3x26/Nx13', 'Cu 3x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2296, 'Cu 3x26/Nx16', 'Cu 3x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2297, 'Cu 3x26/Nx21', 'Cu 3x26/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2298, 'Cu 3x26/Nx26', 'Cu 3x26/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2299, 'Cu 3x26/Nx26', 'Cu 3x26/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2300, 'Cu 3x26/Nx10', 'Cu 3x26/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2301, 'Cu 3x26/Nx13', 'Cu 3x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2302, 'Cu 3x26/Nx16', 'Cu 3x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2303, 'Cu 3x26/Nx26', 'Cu 3x26/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2304, 'Cu 2x26/1x33/Nx10', 'Cu 2x26/1x33/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2305, 'Cu 3x26/Nx13', 'Cu 3x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2306, 'Cu 3x26/Nx16', 'Cu 3x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2307, 'Cu 3x26/Nx13', 'Cu 3x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2308, 'Cu 3x26/Nx16', 'Cu 3x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2309, 'Cu 1x5', 'Cu 1x5');
INSERT INTO obras.maestro_estructura VALUES (2310, 'Cu 1x5/Nx5', 'Cu 1x5/Nx5');
INSERT INTO obras.maestro_estructura VALUES (2311, 'Cu 2x5/Nx5', 'Cu 2x5/Nx5');
INSERT INTO obras.maestro_estructura VALUES (2312, 'Cu 1x8/Nx8', 'Cu 1x8/Nx8');
INSERT INTO obras.maestro_estructura VALUES (2313, 'Cu 2x8/1x13/Nx5', 'Cu 2x8/1x13/Nx5');
INSERT INTO obras.maestro_estructura VALUES (2314, 'Cu 2x8/Nx8', 'Cu 2x8/Nx8');
INSERT INTO obras.maestro_estructura VALUES (2315, 'Cu 3x8/Nx8', 'Cu 3x8/Nx8');
INSERT INTO obras.maestro_estructura VALUES (2316, 'Cu 3x107/Nx21', 'Cu 3x107/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2317, 'Cu 3x107/Nx26', 'Cu 3x107/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2318, 'Cu 3x107/Nx26', 'Cu 3x107/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2319, 'Cu 3x107/Nx33', 'Cu 3x107/Nx33');
INSERT INTO obras.maestro_estructura VALUES (2320, 'Cu 3x107/Nx53', 'Cu 3x107/Nx53');
INSERT INTO obras.maestro_estructura VALUES (2321, 'Cu 3x107/Nx67', 'Cu 3x107/Nx67');
INSERT INTO obras.maestro_estructura VALUES (2322, 'Cu 3x26/Nx10', 'Cu 3x26/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2323, 'Cu 3x26/Nx13', 'Cu 3x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2324, 'Cu 3x26/Nx16', 'Cu 3x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2325, 'Cu 3x26/Nx13', 'Cu 3x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2326, 'Cu 1x26/Nx26', 'Cu 1x26/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2327, 'Cu 2x26/1x16/Nx16', 'Cu 2x26/1x16/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2328, 'Cu 3x26/Nx13', 'Cu 3x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2329, 'Cu 3x26/Nx16', 'Cu 3x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2330, 'Cu 3x26/Nx13', 'Cu 3x26/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2331, 'Cu 3x26/Nx16', 'Cu 3x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2332, 'Cu 3x26/Nx21', 'Cu 3x26/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2333, 'Cu 3x26/Nx26', 'Cu 3x26/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2334, 'Cu 1x33/Nx16', 'Cu 1x33/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2335, 'Cu 2x33/1x26/Nx16', 'Cu 2x33/1x26/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2336, 'Cu 3x33/Nx10', 'Cu 3x33/Nx10');
INSERT INTO obras.maestro_estructura VALUES (2337, 'Cu 3x33/Nx13', 'Cu 3x33/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2338, 'Cu 3x33/Nx16', 'Cu 3x33/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2339, 'Cu 3x33/Nx21', 'Cu 3x33/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2340, 'Cu 3x33/Nx26', 'Cu 3x33/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2341, 'Cu 3x33/Nx26', 'Cu 3x33/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2342, 'Cu 3x33/Nx33', 'Cu 3x33/Nx33');
INSERT INTO obras.maestro_estructura VALUES (2343, 'Cu 2x33/1x42/Nx16', 'Cu 2x33/1x42/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2344, 'Cu 3x42/Nx13', 'Cu 3x42/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2345, 'Cu 3x42/Nx16', 'Cu 3x42/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2346, 'Cu 3x42/Nx21', 'Cu 3x42/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2347, 'Cu 3x42/Nx26', 'Cu 3x42/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2348, 'Cu 3x53/Nx16', 'Cu 3x53/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2349, 'Cu 3x53/Nx21', 'Cu 3x53/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2350, 'Cu 3x53/Nx26', 'Cu 3x53/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2351, 'Cu 3x53/Nx26', 'Cu 3x53/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2352, 'Cu 3x53/Nx33', 'Cu 3x53/Nx33');
INSERT INTO obras.maestro_estructura VALUES (2353, 'Cu 3x53/Nx53', 'Cu 3x53/Nx53');
INSERT INTO obras.maestro_estructura VALUES (2354, 'Cu 2x67/1x53/Nx26', 'Cu 2x67/1x53/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2355, 'Cu 3x67/Nx16', 'Cu 3x67/Nx16');
INSERT INTO obras.maestro_estructura VALUES (2356, 'Cu 3x67/Nx21', 'Cu 3x67/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2357, 'Cu 3x67/Nx26', 'Cu 3x67/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2358, 'Cu 3x67/Nx26', 'Cu 3x67/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2359, 'Cu 3x67/Nx33', 'Cu 3x67/Nx33');
INSERT INTO obras.maestro_estructura VALUES (2360, 'Cu 3x67/Nx53', 'Cu 3x67/Nx53');
INSERT INTO obras.maestro_estructura VALUES (2361, 'Cu 3x67/Nx67', 'Cu 3x67/Nx67');
INSERT INTO obras.maestro_estructura VALUES (2362, 'Cu 3x67/NxAAAC 33', 'Cu 3x67/NxAAAC 33');
INSERT INTO obras.maestro_estructura VALUES (2363, 'Cu 3x85/Nx21', 'Cu 3x85/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2364, 'Cu 3x85/Nx26', 'Cu 3x85/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2365, 'Cu 3x85/Nx26', 'Cu 3x85/Nx26');
INSERT INTO obras.maestro_estructura VALUES (2366, 'Cu 3x85/Nx33', 'Cu 3x85/Nx33');
INSERT INTO obras.maestro_estructura VALUES (2367, 'Cu 3x85/Nx53', 'Cu 3x85/Nx53');
INSERT INTO obras.maestro_estructura VALUES (2368, 'AAAC 1x33', 'AAAC 1x33');
INSERT INTO obras.maestro_estructura VALUES (2369, 'AAAC 3x107/NxCu 16', 'AAAC 3x107/NxCu 16');
INSERT INTO obras.maestro_estructura VALUES (2370, 'Cu 1x13/Nx13', 'Cu 1x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2371, 'Cu 2x13/Nx13', 'Cu 2x13/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2372, 'Concen.3x4/Nx4', 'Concen.3x4/Nx4');
INSERT INTO obras.maestro_estructura VALUES (2373, 'Preens. 3x35/N50', 'Preens. 3x35/N50');
INSERT INTO obras.maestro_estructura VALUES (2374, 'Cu 1x53/2x67/Nx42', 'Cu 1x53/2x67/Nx42');
INSERT INTO obras.maestro_estructura VALUES (2375, 'Cu 1x16/Nx13', 'Cu 1x16/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2376, 'Preens. 3x50/N50', 'Preens. 3x50/N50');
INSERT INTO obras.maestro_estructura VALUES (2377, 'AAAC 1x33/33', 'AAAC 1x33/33');
INSERT INTO obras.maestro_estructura VALUES (2378, 'Preens. 3x70/N50', 'Preens. 3x70/N50');
INSERT INTO obras.maestro_estructura VALUES (2379, 'Preens. 1x25/25', 'Preens. 1x25/25');
INSERT INTO obras.maestro_estructura VALUES (2380, 'TTU 3x107/Nx67', 'TTU 3x107/Nx67');
INSERT INTO obras.maestro_estructura VALUES (2381, 'TTU 3x21/Nx13', 'TTU 3x21/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2382, 'TTU 3x21/Nx21', 'TTU 3x21/Nx21');
INSERT INTO obras.maestro_estructura VALUES (2383, 'TTU 3x33/Nx13', 'TTU 3x33/Nx13');
INSERT INTO obras.maestro_estructura VALUES (2384, 'TTU 3x33/Nx33', 'TTU 3x33/Nx33');
INSERT INTO obras.maestro_estructura VALUES (2385, 'TTU 3x67/Nx67', 'TTU 3x67/Nx67');
INSERT INTO obras.maestro_estructura VALUES (2386, 'TTU 1x13', 'TTU 1x13');
INSERT INTO obras.maestro_estructura VALUES (2387, 'TTU 3x107/Nx33', 'TTU 3x107/Nx33');
INSERT INTO obras.maestro_estructura VALUES (2388, 'PC10.00m', 'PC10.00m');
INSERT INTO obras.maestro_estructura VALUES (2389, 'PC10.00map', 'PC10.00map');
INSERT INTO obras.maestro_estructura VALUES (2390, 'PC11.50m', 'PC11.50m');
INSERT INTO obras.maestro_estructura VALUES (2391, 'PC15.00m', 'PC15.00m');
INSERT INTO obras.maestro_estructura VALUES (2392, 'PCPret18.00m', 'PCPret18.00m');
INSERT INTO obras.maestro_estructura VALUES (2393, 'PC8.70m', 'PC8.70m');
INSERT INTO obras.maestro_estructura VALUES (2394, 'PC8.70map', 'PC8.70map');
INSERT INTO obras.maestro_estructura VALUES (2395, 'PC9.00m', 'PC9.00m');
INSERT INTO obras.maestro_estructura VALUES (2396, 'PF10.00m', 'PF10.00m');
INSERT INTO obras.maestro_estructura VALUES (2397, 'PF10mtorreL.3', 'PF10mtorreL.3');
INSERT INTO obras.maestro_estructura VALUES (2398, 'PF9.00m', 'PF9.00m');
INSERT INTO obras.maestro_estructura VALUES (2399, 'PFTubular9.00m1Lumi', 'PFTubular9.00m1Lumi');
INSERT INTO obras.maestro_estructura VALUES (2400, 'PM10.00m', 'PM10.00m');
INSERT INTO obras.maestro_estructura VALUES (2401, 'PM8.00m', 'PM8.00m');
INSERT INTO obras.maestro_estructura VALUES (2402, 'PM9.00m', 'PM9.00m');
INSERT INTO obras.maestro_estructura VALUES (2403, 'PC16.5m', 'PC16.5m');
INSERT INTO obras.maestro_estructura VALUES (2404, 'CajaseccBT3x250A', 'CajaseccBT3x250A');
INSERT INTO obras.maestro_estructura VALUES (2405, 'LímitezonaDRP', 'LímitezonaDRP');
INSERT INTO obras.maestro_estructura VALUES (2406, 'PasoDRP', 'PasoDRP');
INSERT INTO obras.maestro_estructura VALUES (2407, 'PasoarranqueTMRDRP', 'PasoarranqueTMRDRP');
INSERT INTO obras.maestro_estructura VALUES (2408, 'RematearranTMR<90DRP', 'RematearranTMR<90DRP');
INSERT INTO obras.maestro_estructura VALUES (2409, 'RematearranTMR>90DRP', 'RematearranTMR>90DRP');
INSERT INTO obras.maestro_estructura VALUES (2410, 'Remarranmisail1veco', 'Remarranmisail1veco');
INSERT INTO obras.maestro_estructura VALUES (2411, 'Remarranmisail2veco', 'Remarranmisail2veco');
INSERT INTO obras.maestro_estructura VALUES (2412, 'Remarranmisail2vrac', 'Remarranmisail2vrac');
INSERT INTO obras.maestro_estructura VALUES (2413, 'Remarranmisail3viara', 'Remarranmisail3viara');
INSERT INTO obras.maestro_estructura VALUES (2414, 'Remarranmisail4viaec', 'Remarranmisail4viaec');
INSERT INTO obras.maestro_estructura VALUES (2415, 'Remarranmisail4viara', 'Remarranmisail4viara');
INSERT INTO obras.maestro_estructura VALUES (2416, 'Remarranmisail1viaec', 'Remarranmisail1viaec');
INSERT INTO obras.maestro_estructura VALUES (2417, 'Remarranmisail2viaec', 'Remarranmisail2viaec');
INSERT INTO obras.maestro_estructura VALUES (2418, 'Remarranmisail2viara', 'Remarranmisail2viara');
INSERT INTO obras.maestro_estructura VALUES (2419, 'Remarranmisail3viaec', 'Remarranmisail3viaec');
INSERT INTO obras.maestro_estructura VALUES (2420, 'Remarranmisail3viara', 'Remarranmisail3viara');
INSERT INTO obras.maestro_estructura VALUES (2421, 'Remarranmisail4viaec', 'Remarranmisail4viaec');
INSERT INTO obras.maestro_estructura VALUES (2422, 'Remarranmisail4viara', 'Remarranmisail4viara');
INSERT INTO obras.maestro_estructura VALUES (2423, 'Portangdermiais1veco', 'Portangdermiais1veco');
INSERT INTO obras.maestro_estructura VALUES (2424, 'Portangdermiais2veco', 'Portangdermiais2veco');
INSERT INTO obras.maestro_estructura VALUES (2425, 'Portangdermiais3vrac', 'Portangdermiais3vrac');
INSERT INTO obras.maestro_estructura VALUES (2426, 'Portangdermiais4veco', 'Portangdermiais4veco');
INSERT INTO obras.maestro_estructura VALUES (2427, 'Portangdermiais4vrac', 'Portangdermiais4vrac');
INSERT INTO obras.maestro_estructura VALUES (2428, 'Portangulan1vecono', 'Portangulan1vecono');
INSERT INTO obras.maestro_estructura VALUES (2429, 'Portangulan2vecono', 'Portangulan2vecono');
INSERT INTO obras.maestro_estructura VALUES (2430, 'Portangulan2vrack', 'Portangulan2vrack');
INSERT INTO obras.maestro_estructura VALUES (2431, 'Portangulan3vecono', 'Portangulan3vecono');
INSERT INTO obras.maestro_estructura VALUES (2432, 'Portangulan3vrack', 'Portangulan3vrack');
INSERT INTO obras.maestro_estructura VALUES (2433, 'Portangulan4vecono', 'Portangulan4vecono');
INSERT INTO obras.maestro_estructura VALUES (2434, 'Portangulan4vrack', 'Portangulan4vrack');
INSERT INTO obras.maestro_estructura VALUES (2435, 'Portante1veconomica', 'Portante1veconomica');
INSERT INTO obras.maestro_estructura VALUES (2436, 'Portante1vrack', 'Portante1vrack');
INSERT INTO obras.maestro_estructura VALUES (2437, 'Portante2veconomica', 'Portante2veconomica');
INSERT INTO obras.maestro_estructura VALUES (2438, 'Portante2vrack', 'Portante2vrack');
INSERT INTO obras.maestro_estructura VALUES (2439, 'Portante3veconomica', 'Portante3veconomica');
INSERT INTO obras.maestro_estructura VALUES (2440, 'Portante3vrack', 'Portante3vrack');
INSERT INTO obras.maestro_estructura VALUES (2441, 'Portante4veconomica', 'Portante4veconomica');
INSERT INTO obras.maestro_estructura VALUES (2442, 'Portante4vrack', 'Portante4vrack');
INSERT INTO obras.maestro_estructura VALUES (2443, 'limitezona1veconomic', 'limitezona1veconomic');
INSERT INTO obras.maestro_estructura VALUES (2444, 'limitezona2veconomic', 'limitezona2veconomic');
INSERT INTO obras.maestro_estructura VALUES (2445, 'limitezona2vrack', 'limitezona2vrack');
INSERT INTO obras.maestro_estructura VALUES (2446, 'limitezona3veconomic', 'limitezona3veconomic');
INSERT INTO obras.maestro_estructura VALUES (2447, 'limitezona3vrack', 'limitezona3vrack');
INSERT INTO obras.maestro_estructura VALUES (2448, 'limitezona4veconomic', 'limitezona4veconomic');
INSERT INTO obras.maestro_estructura VALUES (2449, 'limitezona4vrack', 'limitezona4vrack');
INSERT INTO obras.maestro_estructura VALUES (2450, 'Derivacion1veconomic', 'Derivacion1veconomic');
INSERT INTO obras.maestro_estructura VALUES (2451, 'Derivacion1vrack', 'Derivacion1vrack');
INSERT INTO obras.maestro_estructura VALUES (2452, 'Derivacion2veconomic', 'Derivacion2veconomic');
INSERT INTO obras.maestro_estructura VALUES (2453, 'Derivacion2vrack', 'Derivacion2vrack');
INSERT INTO obras.maestro_estructura VALUES (2454, 'Derivacion3veconomic', 'Derivacion3veconomic');
INSERT INTO obras.maestro_estructura VALUES (2455, 'Derivacion3vrack', 'Derivacion3vrack');
INSERT INTO obras.maestro_estructura VALUES (2456, 'Derivacion4veconomic', 'Derivacion4veconomic');
INSERT INTO obras.maestro_estructura VALUES (2457, 'Derivacion4vrack', 'Derivacion4vrack');
INSERT INTO obras.maestro_estructura VALUES (2458, 'Cambiosección2-2vias', 'Cambiosección2-2vias');
INSERT INTO obras.maestro_estructura VALUES (2459, 'Cambiosección3-2vias', 'Cambiosección3-2vias');
INSERT INTO obras.maestro_estructura VALUES (2460, 'Cambiosección4-2vias', 'Cambiosección4-2vias');
INSERT INTO obras.maestro_estructura VALUES (2461, 'Cambiosección4-3vias', 'Cambiosección4-3vias');
INSERT INTO obras.maestro_estructura VALUES (2462, 'Cambiosección4-4vias', 'Cambiosección4-4vias');
INSERT INTO obras.maestro_estructura VALUES (2463, 'Semianclaje2fcrfAAAC', 'Semianclaje2fcrfAAAC');
INSERT INTO obras.maestro_estructura VALUES (2464, 'Semianclaje2fcrf', 'Semianclaje2fcrf');
INSERT INTO obras.maestro_estructura VALUES (2465, 'Semianclaje2fcrmad', 'Semianclaje2fcrmad');
INSERT INTO obras.maestro_estructura VALUES (2466, 'Semianclaje1f', 'Semianclaje1f');
INSERT INTO obras.maestro_estructura VALUES (2467, 'Semianclaje3fcrfAAAC', 'Semianclaje3fcrfAAAC');
INSERT INTO obras.maestro_estructura VALUES (2468, 'Semianclaje3fcrf', 'Semianclaje3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2469, 'Semianclaje3fcrmad', 'Semianclaje3fcrmad');
INSERT INTO obras.maestro_estructura VALUES (2470, 'Semianclaje3-2fcrf', 'Semianclaje3-2fcrf');
INSERT INTO obras.maestro_estructura VALUES (2471, 'RemateTMR2fcrcon', 'RemateTMR2fcrcon');
INSERT INTO obras.maestro_estructura VALUES (2472, 'RemateTMR2fcrmad', 'RemateTMR2fcrmad');
INSERT INTO obras.maestro_estructura VALUES (2473, 'RemateTMR3fcrc', 'RemateTMR3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2474, 'RemateTMR3fcrf', 'RemateTMR3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2475, 'RemateTMR3fcrcAAAC', 'RemateTMR3fcrcAAAC');
INSERT INTO obras.maestro_estructura VALUES (2476, 'RemateTMR3fcrm', 'RemateTMR3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2477, 'Portantecruce2fcrc', 'Portantecruce2fcrc');
INSERT INTO obras.maestro_estructura VALUES (2478, 'Portantecruce3fcrc', 'Portantecruce3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2479, 'Portantecruce3fcrf', 'Portantecruce3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2480, 'Portancruce3fcrcAAAC', 'Portancruce3fcrcAAAC');
INSERT INTO obras.maestro_estructura VALUES (2481, 'Portantecruce3fcrm', 'Portantecruce3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2482, 'PCAAAC107', 'PCAAAC107');
INSERT INTO obras.maestro_estructura VALUES (2483, 'PCAAAC33', 'PCAAAC33');
INSERT INTO obras.maestro_estructura VALUES (2484, 'PCAAAC53', 'PCAAAC53');
INSERT INTO obras.maestro_estructura VALUES (2485, 'PC2fcrc', 'PC2fcrc');
INSERT INTO obras.maestro_estructura VALUES (2486, 'PC2fcrccond', 'PC2fcrccond');
INSERT INTO obras.maestro_estructura VALUES (2487, 'PC2fcrccond', 'PC2fcrccond');
INSERT INTO obras.maestro_estructura VALUES (2488, 'PC2fcrfAAAC', 'PC2fcrfAAAC');
INSERT INTO obras.maestro_estructura VALUES (2489, 'PC2fcrconAAAC', 'PC2fcrconAAAC');
INSERT INTO obras.maestro_estructura VALUES (2490, 'PC2fcrm', 'PC2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2491, 'PC3fcrc', 'PC3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2492, 'PC3fcrf', 'PC3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2493, 'PC3fcrm', 'PC3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2494, 'Portángcantile2fcrc', 'Portángcantile2fcrc');
INSERT INTO obras.maestro_estructura VALUES (2495, 'Portángcantile2fcrfe', 'Portángcantile2fcrfe');
INSERT INTO obras.maestro_estructura VALUES (2496, 'Portángcantile107', 'Portángcantile107');
INSERT INTO obras.maestro_estructura VALUES (2497, 'Portángcantile33', 'Portángcantile33');
INSERT INTO obras.maestro_estructura VALUES (2498, 'Portángcantile53', 'Portángcantile53');
INSERT INTO obras.maestro_estructura VALUES (2499, 'Portángcantile3fcrc', 'Portángcantile3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2500, 'Portángcantile3fcrf', 'Portángcantile3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2501, 'Portángcantile2fcrm', 'Portángcantile2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2502, 'Portáng2fcrc', 'Portáng2fcrc');
INSERT INTO obras.maestro_estructura VALUES (2503, 'Portáng2fcrf', 'Portáng2fcrf');
INSERT INTO obras.maestro_estructura VALUES (2504, 'Portáng2fcrm', 'Portáng2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2505, 'Portáng2fAAAC', 'Portáng2fAAAC');
INSERT INTO obras.maestro_estructura VALUES (2506, 'Portáng107', 'Portáng107');
INSERT INTO obras.maestro_estructura VALUES (2507, 'Portáng33', 'Portáng33');
INSERT INTO obras.maestro_estructura VALUES (2508, 'Portáng53', 'Portáng53');
INSERT INTO obras.maestro_estructura VALUES (2509, 'Portáng3fcrc', 'Portáng3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2510, 'Portáng3fcrfAAAC', 'Portáng3fcrfAAAC');
INSERT INTO obras.maestro_estructura VALUES (2511, 'Portáng3fcrf', 'Portáng3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2512, 'Portáng3fcrm', 'Portáng3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2513, 'Portante2fcrc', 'Portante2fcrc');
INSERT INTO obras.maestro_estructura VALUES (2514, 'Portante2fcrcAAAC', 'Portante2fcrcAAAC');
INSERT INTO obras.maestro_estructura VALUES (2515, 'Portante2fcrm', 'Portante2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2516, 'Portante1f', 'Portante1f');
INSERT INTO obras.maestro_estructura VALUES (2517, 'PAAAC107', 'PAAAC107');
INSERT INTO obras.maestro_estructura VALUES (2518, 'PAAAC33', 'PAAAC33');
INSERT INTO obras.maestro_estructura VALUES (2519, 'PAAAC53', 'PAAAC53');
INSERT INTO obras.maestro_estructura VALUES (2520, 'Portante3fcrc', 'Portante3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2521, 'Portante3fcrf', 'Portante3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2522, 'Portante2fcrm', 'Portante2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2523, 'Portalanclaje', 'Portalanclaje');
INSERT INTO obras.maestro_estructura VALUES (2524, 'Portaclintercr4AAAC', 'Portaclintercr4AAAC');
INSERT INTO obras.maestro_estructura VALUES (2525, 'Portaclrematcr4AAAC', 'Portaclrematcr4AAAC');
INSERT INTO obras.maestro_estructura VALUES (2526, 'Portalportante', 'Portalportante');
INSERT INTO obras.maestro_estructura VALUES (2527, 'Portalsemianclaje', 'Portalsemianclaje');
INSERT INTO obras.maestro_estructura VALUES (2528, 'DerivaciónTMR2fcrc', 'DerivaciónTMR2fcrc');
INSERT INTO obras.maestro_estructura VALUES (2529, 'DerivaciónTMR2fcrf', 'DerivaciónTMR2fcrf');
INSERT INTO obras.maestro_estructura VALUES (2530, 'DerivaciTMR2fcrcAAAC', 'DerivaciTMR2fcrcAAAC');
INSERT INTO obras.maestro_estructura VALUES (2531, 'DerivaciónTMR2fcrM', 'DerivaciónTMR2fcrM');
INSERT INTO obras.maestro_estructura VALUES (2532, 'DerivaciónTMR1f', 'DerivaciónTMR1f');
INSERT INTO obras.maestro_estructura VALUES (2533, 'DerivaciónTMR3fcrc', 'DerivaciónTMR3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2534, 'DerivaciónTMR3fcrf', 'DerivaciónTMR3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2535, 'DerivaciTMR3fcrcAAAC', 'DerivaciTMR3fcrcAAAC');
INSERT INTO obras.maestro_estructura VALUES (2536, 'DerivaciónTMR3fcrm', 'DerivaciónTMR3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2537, 'Arranquedisco2fcrc', 'Arranquedisco2fcrc');
INSERT INTO obras.maestro_estructura VALUES (2538, 'Arranqdisco2fcrfAAAC', 'Arranqdisco2fcrfAAAC');
INSERT INTO obras.maestro_estructura VALUES (2539, 'Arranquedisco2fcrf', 'Arranquedisco2fcrf');
INSERT INTO obras.maestro_estructura VALUES (2540, 'Arranquedisco2fcrm', 'Arranquedisco2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2541, 'Arranquedisco3fcrc', 'Arranquedisco3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2542, 'Arranqdisco3fcrfAAAC', 'Arranqdisco3fcrfAAAC');
INSERT INTO obras.maestro_estructura VALUES (2543, 'Arranquedisco3fcrf', 'Arranquedisco3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2544, 'Arranqdisco3fcrcAAAC', 'Arranqdisco3fcrcAAAC');
INSERT INTO obras.maestro_estructura VALUES (2545, 'Arranquedisco3fcrm', 'Arranquedisco3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2546, 'Ancleremángrect2fcrf', 'Ancleremángrect2fcrf');
INSERT INTO obras.maestro_estructura VALUES (2547, 'Ancleremángrect2fcrm', 'Ancleremángrect2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2548, 'Ancremángre2fAAAC107', 'Ancremángre2fAAAC107');
INSERT INTO obras.maestro_estructura VALUES (2549, 'Ancremángre2fAAAC33', 'Ancremángre2fAAAC33');
INSERT INTO obras.maestro_estructura VALUES (2550, 'Ancremángre1f', 'Ancremángre1f');
INSERT INTO obras.maestro_estructura VALUES (2551, 'AncremángreAAAC107', 'AncremángreAAAC107');
INSERT INTO obras.maestro_estructura VALUES (2552, 'AncremángreAAAC33', 'AncremángreAAAC33');
INSERT INTO obras.maestro_estructura VALUES (2553, 'Ancremángrec3fcrf', 'Ancremángrec3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2554, 'Ancremángrec3fcrm', 'Ancremángrec3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2555, 'Ancremá2fcrfAAAC', 'Ancremá2fcrfAAAC');
INSERT INTO obras.maestro_estructura VALUES (2556, 'Ancremá2fcrf', 'Ancremá2fcrf');
INSERT INTO obras.maestro_estructura VALUES (2557, 'Ancremá2fcrm', 'Ancremá2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2558, 'Anclajeremate1f', 'Anclajeremate1f');
INSERT INTO obras.maestro_estructura VALUES (2559, 'AnclajeremateAAAC', 'AnclajeremateAAAC');
INSERT INTO obras.maestro_estructura VALUES (2560, 'Anclajeremate3fcrf', 'Anclajeremate3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2561, 'Anclajeremate3fcrm', 'Anclajeremate3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2562, 'Anclajeintermed2fcrf', 'Anclajeintermed2fcrf');
INSERT INTO obras.maestro_estructura VALUES (2563, 'Anclajeintermed2fcrm', 'Anclajeintermed2fcrm');
INSERT INTO obras.maestro_estructura VALUES (2564, 'Anclajeintermed2fAAA', 'Anclajeintermed2fAAA');
INSERT INTO obras.maestro_estructura VALUES (2565, 'AnclaintermedAAAC107', 'AnclaintermedAAAC107');
INSERT INTO obras.maestro_estructura VALUES (2566, 'AnclaintermedAAAC33', 'AnclaintermedAAAC33');
INSERT INTO obras.maestro_estructura VALUES (2567, 'AnclaintermedAAAC53', 'AnclaintermedAAAC53');
INSERT INTO obras.maestro_estructura VALUES (2568, 'Anclinter3-2crfAAAC', 'Anclinter3-2crfAAAC');
INSERT INTO obras.maestro_estructura VALUES (2569, 'Anclajeinter3fcrf', 'Anclajeinter3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2570, 'Anclajeinter3fcrm', 'Anclajeinter3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2571, 'Anclajeinter3fcrmAAA', 'Anclajeinter3fcrmAAA');
INSERT INTO obras.maestro_estructura VALUES (2572, 'Anclinter3-2crf', 'Anclinter3-2crf');
INSERT INTO obras.maestro_estructura VALUES (2573, 'Anclinter3-2crm', 'Anclinter3-2crm');
INSERT INTO obras.maestro_estructura VALUES (2574, 'SElateralcrmadera', 'SElateralcrmadera');
INSERT INTO obras.maestro_estructura VALUES (2575, 'Selateralcrmccruccen', 'Selateralcrmccruccen');
INSERT INTO obras.maestro_estructura VALUES (2576, 'Selateralcrmscruccen', 'Selateralcrmscruccen');
INSERT INTO obras.maestro_estructura VALUES (2577, 'Selateralcrmetálica', 'Selateralcrmetálica');
INSERT INTO obras.maestro_estructura VALUES (2578, 'SEmochila2fcrc', 'SEmochila2fcrc');
INSERT INTO obras.maestro_estructura VALUES (2579, 'SEmochila2fcrmad', 'SEmochila2fcrmad');
INSERT INTO obras.maestro_estructura VALUES (2580, 'SEmochila2fcrmet', 'SEmochila2fcrmet');
INSERT INTO obras.maestro_estructura VALUES (2581, 'SEmochila2fsincrint', 'SEmochila2fsincrint');
INSERT INTO obras.maestro_estructura VALUES (2582, 'SEmochila3fcrc', 'SEmochila3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2583, 'SEmochila3fcrmad', 'SEmochila3fcrmad');
INSERT INTO obras.maestro_estructura VALUES (2584, 'SEmochila3fcrmet', 'SEmochila3fcrmet');
INSERT INTO obras.maestro_estructura VALUES (2585, 'SEmochila3fsincrint', 'SEmochila3fsincrint');
INSERT INTO obras.maestro_estructura VALUES (2586, 'SEpartidacrucconcre', 'SEpartidacrucconcre');
INSERT INTO obras.maestro_estructura VALUES (2587, 'Separtcrcons/mallaae', 'Separtcrcons/mallaae');
INSERT INTO obras.maestro_estructura VALUES (2588, 'SEpartidacrucmadera', 'SEpartidacrucmadera');
INSERT INTO obras.maestro_estructura VALUES (2589, 'Separtcrucmadcruceto', 'Separtcrucmadcruceto');
INSERT INTO obras.maestro_estructura VALUES (2590, 'Separtcrmads/mallaae', 'Separtcrmads/mallaae');
INSERT INTO obras.maestro_estructura VALUES (2591, 'Separtcrmetálica', 'Separtcrmetálica');
INSERT INTO obras.maestro_estructura VALUES (2592, 'Separtcrmets/mallaae', 'Separtcrmets/mallaae');
INSERT INTO obras.maestro_estructura VALUES (2593, 'Remate DRP', 'Remate DRP');
INSERT INTO obras.maestro_estructura VALUES (2594, 'Separador de linea', 'Separador de linea');
INSERT INTO obras.maestro_estructura VALUES (2595, 'Remate1víaEconómica', 'Remate1víaEconómica');
INSERT INTO obras.maestro_estructura VALUES (2596, 'Remate1víaRack', 'Remate1víaRack');
INSERT INTO obras.maestro_estructura VALUES (2597, 'Remate2víasEconómica', 'Remate2víasEconómica');
INSERT INTO obras.maestro_estructura VALUES (2598, 'Remate2víasRack', 'Remate2víasRack');
INSERT INTO obras.maestro_estructura VALUES (2599, 'Remate3víasEconómica', 'Remate3víasEconómica');
INSERT INTO obras.maestro_estructura VALUES (2600, 'Remate 3 vías Rack', 'Remate 3 vías Rack');
INSERT INTO obras.maestro_estructura VALUES (2601, 'Remate4víasEconómica', 'Remate4víasEconómica');
INSERT INTO obras.maestro_estructura VALUES (2602, 'Remate 4 vías Rack', 'Remate 4 vías Rack');
INSERT INTO obras.maestro_estructura VALUES (2603, 'Montdesconfusib3fcrc', 'Montdesconfusib3fcrc');
INSERT INTO obras.maestro_estructura VALUES (2604, 'Montdesconfusib3fcrf', 'Montdesconfusib3fcrf');
INSERT INTO obras.maestro_estructura VALUES (2605, 'Montdesconfusib3fcrm', 'Montdesconfusib3fcrm');
INSERT INTO obras.maestro_estructura VALUES (2606, 'Extensiónmetálica1.6', 'Extensiónmetálica1.6');
INSERT INTO obras.maestro_estructura VALUES (2607, 'Extensiónmetálica2.8', 'Extensiónmetálica2.8');
INSERT INTO obras.maestro_estructura VALUES (2608, 'DerivaciónVirtualBT', 'DerivaciónVirtualBT');
INSERT INTO obras.maestro_estructura VALUES (2609, 'AnclremangrecAAAC33', 'AnclremangrecAAAC33');
INSERT INTO obras.maestro_estructura VALUES (2610, 'AnclajerematAAACprot', 'AnclajerematAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2611, 'Anclaremat2fAAACprot', 'Anclaremat2fAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2612, 'AnclajeinterAAACprot', 'AnclajeinterAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2613, 'Anclainter2fAAACprot', 'Anclainter2fAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2614, 'PortanteAAACprotegid', 'PortanteAAACprotegid');
INSERT INTO obras.maestro_estructura VALUES (2615, 'Portante2fAAACprot', 'Portante2fAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2616, 'PCAAACprotegido', 'PCAAACprotegido');
INSERT INTO obras.maestro_estructura VALUES (2617, 'PC2fAAACprotegido', 'PC2fAAACprotegido');
INSERT INTO obras.maestro_estructura VALUES (2618, 'PortananguloAAACprot', 'PortananguloAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2619, 'Portanangu2fAAACprot', 'Portanangu2fAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2620, 'PortangCantAAACprot', 'PortangCantAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2621, 'AnclajeángulAAACprot', 'AnclajeángulAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2622, 'AncremángrecAAACprot', 'AncremángrecAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2623, 'Ancremángrec2fAAACpr', 'Ancremángrec2fAAACpr');
INSERT INTO obras.maestro_estructura VALUES (2624, 'ArrsegunplaAAACprot', 'ArrsegunplaAAACprot');
INSERT INTO obras.maestro_estructura VALUES (2625, 'ARR', 'ARR');
INSERT INTO obras.maestro_estructura VALUES (2626, 'ARR', 'ARR');
INSERT INTO obras.maestro_estructura VALUES (2627, 'ERR', 'ERR');
INSERT INTO obras.maestro_estructura VALUES (2628, 'PORT', 'PORT');
INSERT INTO obras.maestro_estructura VALUES (2629, 'PORT', 'PORT');
INSERT INTO obras.maestro_estructura VALUES (2630, 'PORT', 'PORT');
INSERT INTO obras.maestro_estructura VALUES (2631, 'PORT', 'PORT');
INSERT INTO obras.maestro_estructura VALUES (2632, 'REM', 'REM');
INSERT INTO obras.maestro_estructura VALUES (2633, 'SUB', 'SUB');
INSERT INTO obras.maestro_estructura VALUES (2634, 'PORT', 'PORT');
INSERT INTO obras.maestro_estructura VALUES (2635, 'ANCLAJE INTERMEDIO', 'ANCLAJE INTERMEDIO');
INSERT INTO obras.maestro_estructura VALUES (2636, 'Derivación, cable DR', 'Derivación, cable DR');
INSERT INTO obras.maestro_estructura VALUES (2637, 'Paso con angulo', 'Paso con angulo');
INSERT INTO obras.maestro_estructura VALUES (2638, 'Paso y arranque', 'Paso y arranque');
INSERT INTO obras.maestro_estructura VALUES (2639, 'Paso', 'Paso');
INSERT INTO obras.maestro_estructura VALUES (2640, 'Paso en poste MT', 'Paso en poste MT');
INSERT INTO obras.maestro_estructura VALUES (2641, 'TMR angulo menor 90', 'TMR angulo menor 90');
INSERT INTO obras.maestro_estructura VALUES (2642, 'Remate', 'Remate');
INSERT INTO obras.maestro_estructura VALUES (2643, 'Limite de zona', 'Limite de zona');
INSERT INTO obras.maestro_estructura VALUES (2644, 'TMR angulo mayor 90º', 'TMR angulo mayor 90º');
INSERT INTO obras.maestro_estructura VALUES (2645, 'Tirante cuerda BT', 'Tirante cuerda BT');
INSERT INTO obras.maestro_estructura VALUES (2646, 'Tirante cuerda MT', 'Tirante cuerda MT');
INSERT INTO obras.maestro_estructura VALUES (2647, 'TiramozocanclajeBT', 'TiramozocanclajeBT');
INSERT INTO obras.maestro_estructura VALUES (2648, 'TiramozocanclajeMT', 'TiramozocanclajeMT');
INSERT INTO obras.maestro_estructura VALUES (2649, 'TiramozocBT', 'TiramozocBT');
INSERT INTO obras.maestro_estructura VALUES (2650, 'TiramozocMT', 'TiramozocMT');
INSERT INTO obras.maestro_estructura VALUES (2651, 'TiramozomadanclajeBT', 'TiramozomadanclajeBT');
INSERT INTO obras.maestro_estructura VALUES (2652, 'TiramozomadanclajeMT', 'TiramozomadanclajeMT');
INSERT INTO obras.maestro_estructura VALUES (2653, 'TirantemozomadBT', 'TirantemozomadBT');
INSERT INTO obras.maestro_estructura VALUES (2654, 'TirantemozomadMT', 'TirantemozomadMT');
INSERT INTO obras.maestro_estructura VALUES (2655, 'TiramozorielanclajMT', 'TiramozorielanclajMT');
INSERT INTO obras.maestro_estructura VALUES (2656, 'Tirante mozo riel BT', 'Tirante mozo riel BT');
INSERT INTO obras.maestro_estructura VALUES (2657, 'Tirante simple BT', 'Tirante simple BT');
INSERT INTO obras.maestro_estructura VALUES (2658, 'Tirante simple MT', 'Tirante simple MT');
INSERT INTO obras.maestro_estructura VALUES (2659, 'Cable Guardia', 'Cable Guardia');
INSERT INTO obras.maestro_estructura VALUES (2660, 'TTmallaSubestacion', 'TTmallaSubestacion');
INSERT INTO obras.maestro_estructura VALUES (2661, 'TTProteccion', 'TTProteccion');
INSERT INTO obras.maestro_estructura VALUES (2662, 'TTServicio', 'TTServicio');
INSERT INTO obras.maestro_estructura VALUES (2663, 'baj11/2caBT3x21-1x21', 'baj11/2caBT3x21-1x21');
INSERT INTO obras.maestro_estructura VALUES (2664, 'baj21/2caBT3x33/1x33', 'baj21/2caBT3x33/1x33');
INSERT INTO obras.maestro_estructura VALUES (2665, 'baj2caBTarm3x25/1x25', 'baj2caBTarm3x25/1x25');
INSERT INTO obras.maestro_estructura VALUES (2666, 'baj3caBT3x53/1x33', 'baj3caBT3x53/1x33');
INSERT INTO obras.maestro_estructura VALUES (2667, 'baj3caBT3x33-1x21', 'baj3caBT3x33-1x21');
INSERT INTO obras.maestro_estructura VALUES (2668, 'baj3caMT3x35', 'baj3caMT3x35');
INSERT INTO obras.maestro_estructura VALUES (2669, 'baj4caBT6x67-1x67', 'baj4caBT6x67-1x67');
INSERT INTO obras.maestro_estructura VALUES (2670, 'baj4caMT3x95', 'baj4caMT3x95');
INSERT INTO obras.maestro_estructura VALUES (2671, 'baj4casecoMT3x107', 'baj4casecoMT3x107');
INSERT INTO obras.maestro_estructura VALUES (2672, 'baj4casecoMT3x33', 'baj4casecoMT3x33');
INSERT INTO obras.maestro_estructura VALUES (2673, 'baj4casecoMT3x67', 'baj4casecoMT3x67');
INSERT INTO obras.maestro_estructura VALUES (2674, 'MufaRAYCHEM', 'MufaRAYCHEM');
INSERT INTO obras.maestro_estructura VALUES (2675, 'MutermaéGWmodA15kV', 'MutermaéGWmodA15kV');
INSERT INTO obras.maestro_estructura VALUES (2676, 'MutermaérGWmodA-TA15', 'MutermaérGWmodA-TA15');
INSERT INTO obras.maestro_estructura VALUES (2677, 'MuRAY16-50-ext', 'MuRAY16-50-ext');
INSERT INTO obras.maestro_estructura VALUES (2678, 'MuRA85-ext', 'MuRA85-ext');
INSERT INTO obras.maestro_estructura VALUES (2679, 'MuRAY95-185-ext', 'MuRAY95-185-ext');
INSERT INTO obras.maestro_estructura VALUES (2680, 'MuRAYextfalda', 'MuRAYextfalda');
INSERT INTO obras.maestro_estructura VALUES (2681, 'MuRAYtranscable15kv', 'MuRAYtranscable15kv');
INSERT INTO obras.maestro_estructura VALUES (2682, 'Equpararr2f10kV-VL10', 'Equpararr2f10kV-VL10');
INSERT INTO obras.maestro_estructura VALUES (2683, 'Equpararr3f10kV-VL10', 'Equpararr3f10kV-VL10');
INSERT INTO obras.maestro_estructura VALUES (2684, 'baj4cablesecoMT3x120', 'baj4cablesecoMT3x120');
INSERT INTO obras.maestro_estructura VALUES (2685, 'Condautom3x150kVAr', 'Condautom3x150kVAr');
INSERT INTO obras.maestro_estructura VALUES (2686, 'Condautom3x200kVAr', 'Condautom3x200kVAr');
INSERT INTO obras.maestro_estructura VALUES (2687, 'Condfijo3x100kVAr', 'Condfijo3x100kVAr');
INSERT INTO obras.maestro_estructura VALUES (2688, 'Condfijo3x150kVAr', 'Condfijo3x150kVAr');
INSERT INTO obras.maestro_estructura VALUES (2689, 'Condfijo3x200kVAr', 'Condfijo3x200kVAr');
INSERT INTO obras.maestro_estructura VALUES (2690, 'Cruces conectados MT', 'Cruces conectados MT');
INSERT INTO obras.maestro_estructura VALUES (2691, 'Cruces conectados BT', 'Cruces conectados BT');
INSERT INTO obras.maestro_estructura VALUES (2692, 'ConeclíneasubterrMT', 'ConeclíneasubterrMT');
INSERT INTO obras.maestro_estructura VALUES (2693, 'ConectorlíneassubtBT', 'ConectorlíneassubtBT');
INSERT INTO obras.maestro_estructura VALUES (2694, 'Condautom3x100kVAr', 'Condautom3x100kVAr');
INSERT INTO obras.maestro_estructura VALUES (2695, 'Tirante cortopara re', 'Tirante cortopara re');
INSERT INTO obras.maestro_estructura VALUES (2696, 'Puesta a tierra', 'Puesta a tierra');
INSERT INTO obras.maestro_estructura VALUES (2697, 'Limite de zona DRP', 'Limite de zona DRP');
INSERT INTO obras.maestro_estructura VALUES (2698, 'Descfus2f15kV100A-XS', 'Descfus2f15kV100A-XS');
INSERT INTO obras.maestro_estructura VALUES (2699, 'Descfus1f15kV100A-XS', 'Descfus1f15kV100A-XS');
INSERT INTO obras.maestro_estructura VALUES (2700, 'Descfus3f15kV100A-XS', 'Descfus3f15kV100A-XS');
INSERT INTO obras.maestro_estructura VALUES (2701, 'Descuc3f15kV100AXS', 'Descuc3f15kV100AXS');
INSERT INTO obras.maestro_estructura VALUES (2702, 'Descu3fBrFe14.4k900A', 'Descu3fBrFe14.4k900A');
INSERT INTO obras.maestro_estructura VALUES (2703, 'Descfus2f15kV100AXS', 'Descfus2f15kV100AXS');
INSERT INTO obras.maestro_estructura VALUES (2704, 'Descfus3f15kV100AXS', 'Descfus3f15kV100AXS');
INSERT INTO obras.maestro_estructura VALUES (2705, 'SalSEmochi1fccontrol', 'SalSEmochi1fccontrol');
INSERT INTO obras.maestro_estructura VALUES (2706, 'Salida S/E mochila 1', 'Salida S/E mochila 1');
INSERT INTO obras.maestro_estructura VALUES (2707, 'SalidSEmoch1fplaérea', 'SalidSEmoch1fplaérea');
INSERT INTO obras.maestro_estructura VALUES (2708, 'SalSEmoch3fcajacontl', 'SalSEmoch3fcajacontl');
INSERT INTO obras.maestro_estructura VALUES (2709, 'SalSEmoch3fcajHy-Mag', 'SalSEmoch3fcajHy-Mag');
INSERT INTO obras.maestro_estructura VALUES (2710, 'SaliSEmoch3ftripolar', 'SaliSEmoch3ftripolar');
INSERT INTO obras.maestro_estructura VALUES (2711, 'SaliSEpart3fcacontro', 'SaliSEpart3fcacontro');
INSERT INTO obras.maestro_estructura VALUES (2712, 'SalSEpart3fcac>75kVA', 'SalSEpart3fcac>75kVA');
INSERT INTO obras.maestro_estructura VALUES (2713, 'SalSEpart3fcaHy-Mag', 'SalSEpart3fcaHy-Mag');
INSERT INTO obras.maestro_estructura VALUES (2714, 'SaSEpa3fcHyMag>75kVA', 'SaSEpa3fcHyMag>75kVA');
INSERT INTO obras.maestro_estructura VALUES (2715, 'SalSEpart3fplacaérea', 'SalSEpart3fplacaérea');
INSERT INTO obras.maestro_estructura VALUES (2716, 'SalSEpart3ftripolar', 'SalSEpart3ftripolar');
INSERT INTO obras.maestro_estructura VALUES (2717, 'SalSEpar3fSecBTFusNH', 'SalSEpar3fSecBTFusNH');
INSERT INTO obras.maestro_estructura VALUES (2718, 'DeCuSC3f900A14.4Po-T', 'DeCuSC3f900A14.4Po-T');
INSERT INTO obras.maestro_estructura VALUES (2719, 'Des. S&C O-R 14.4 kV', 'Des. S&C O-R 14.4 kV');
INSERT INTO obras.maestro_estructura VALUES (2720, 'Eq. Prot. By Pass', 'Eq. Prot. By Pass');
INSERT INTO obras.maestro_estructura VALUES (2721, 'SalSEmoch3fSeccfusNH', 'SalSEmoch3fSeccfusNH');
INSERT INTO obras.maestro_estructura VALUES (2722, 'CanalizaccañePVC11/2', 'CanalizaccañePVC11/2');
INSERT INTO obras.maestro_estructura VALUES (2723, 'CanalizacióncañePVC4', 'CanalizacióncañePVC4');
INSERT INTO obras.maestro_estructura VALUES (2724, 'CanalPVC2vías4', 'CanalPVC2vías4');
INSERT INTO obras.maestro_estructura VALUES (2725, 'CanalPVC4vías4', 'CanalPVC4vías4');
INSERT INTO obras.maestro_estructura VALUES (2726, 'Cu 1x10', 'Cu 1x10');
INSERT INTO obras.maestro_estructura VALUES (2727, 'Cu 2x10', 'Cu 2x10');
INSERT INTO obras.maestro_estructura VALUES (2728, 'Cu 3x10', 'Cu 3x10');
INSERT INTO obras.maestro_estructura VALUES (2729, 'Cu 2x13', 'Cu 2x13');
INSERT INTO obras.maestro_estructura VALUES (2730, 'Cu 3x13', 'Cu 3x13');
INSERT INTO obras.maestro_estructura VALUES (2731, 'Cu 1x16', 'Cu 1x16');
INSERT INTO obras.maestro_estructura VALUES (2732, 'Cu 2x16', 'Cu 2x16');
INSERT INTO obras.maestro_estructura VALUES (2733, 'Cu 3x16', 'Cu 3x16');
INSERT INTO obras.maestro_estructura VALUES (2734, 'Cu 3x21', 'Cu 3x21');
INSERT INTO obras.maestro_estructura VALUES (2735, 'Cu 3x26', 'Cu 3x26');
INSERT INTO obras.maestro_estructura VALUES (2736, 'Cu 2x33', 'Cu 2x33');
INSERT INTO obras.maestro_estructura VALUES (2737, 'Cu 3x33', 'Cu 3x33');
INSERT INTO obras.maestro_estructura VALUES (2738, 'Cu 3x53', 'Cu 3x53');
INSERT INTO obras.maestro_estructura VALUES (2739, 'Cu 3x67', 'Cu 3x67');
INSERT INTO obras.maestro_estructura VALUES (2740, 'Cu 3x85', 'Cu 3x85');
INSERT INTO obras.maestro_estructura VALUES (2741, 'Cu 3x107', 'Cu 3x107');
INSERT INTO obras.maestro_estructura VALUES (2742, 'AAAC 2x33', 'AAAC 2x33');
INSERT INTO obras.maestro_estructura VALUES (2743, 'AAAC 3x33', 'AAAC 3x33');
INSERT INTO obras.maestro_estructura VALUES (2744, 'AAAC 3x53', 'AAAC 3x53');
INSERT INTO obras.maestro_estructura VALUES (2745, 'AAAC 3x107', 'AAAC 3x107');
INSERT INTO obras.maestro_estructura VALUES (2746, 'Prot.3x107', 'Prot.3x107');
INSERT INTO obras.maestro_estructura VALUES (2747, 'Prot.3x33', 'Prot.3x33');
INSERT INTO obras.maestro_estructura VALUES (2748, 'Prot.3x53', 'Prot.3x53');
INSERT INTO obras.maestro_estructura VALUES (2749, 'Prot.2x33', 'Prot.2x33');
INSERT INTO obras.maestro_estructura VALUES (2750, 'XAT3x1x35', 'XAT3x1x35');
INSERT INTO obras.maestro_estructura VALUES (2751, 'ET3x1x33', 'ET3x1x33');
INSERT INTO obras.maestro_estructura VALUES (2752, 'ET3x1x67', 'ET3x1x67');
INSERT INTO obras.maestro_estructura VALUES (2753, 'XAT3x1x85', 'XAT3x1x85');
INSERT INTO obras.maestro_estructura VALUES (2754, 'XAT3x1x107', 'XAT3x1x107');
INSERT INTO obras.maestro_estructura VALUES (2755, 'PSWA3x16', 'PSWA3x16');
INSERT INTO obras.maestro_estructura VALUES (2756, 'XAT3x1x120', 'XAT3x1x120');
INSERT INTO obras.maestro_estructura VALUES (2757, 'XAT3x1x33', 'XAT3x1x33');
INSERT INTO obras.maestro_estructura VALUES (2758, 'XAT3x1x240', 'XAT3x1x240');
INSERT INTO obras.maestro_estructura VALUES (2759, 'Interruptor3f', 'Interruptor3f');
INSERT INTO obras.maestro_estructura VALUES (2760, 'BT P 76M SB NR', 'BT P 76M SB NR');
INSERT INTO obras.maestro_estructura VALUES (2761, 'BT P 76M SB NRAngulo', 'BT P 76M SB NRAngulo');
INSERT INTO obras.maestro_estructura VALUES (2762, 'BT P 76M SB N', 'BT P 76M SB N');
INSERT INTO obras.maestro_estructura VALUES (2763, 'BT P 76M SB N Angulo', 'BT P 76M SB N Angulo');
INSERT INTO obras.maestro_estructura VALUES (2764, 'BT LZ 76M SB NR', 'BT LZ 76M SB NR');
INSERT INTO obras.maestro_estructura VALUES (2765, 'BT LZ 76M SB NRST', 'BT LZ 76M SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2766, 'CCu 16 MM2 1C', 'CCu 16 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (2767, 'CCu 13.3 MM2 1C', 'CCu 13.3 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (2768, 'CAVANNA NH 3Ø', 'CAVANNA NH 3Ø');
INSERT INTO obras.maestro_estructura VALUES (2769, 'NH hasta 400A', 'NH hasta 400A');
INSERT INTO obras.maestro_estructura VALUES (2770, 'TRA 15 2F 0-15', 'TRA 15 2F 0-15');
INSERT INTO obras.maestro_estructura VALUES (2771, 'SF 8kA 2ø', 'SF 8kA 2ø');
INSERT INTO obras.maestro_estructura VALUES (2772, 'SF 12kA 2ø', 'SF 12kA 2ø');
INSERT INTO obras.maestro_estructura VALUES (2773, 'SF 8kA 3ø', 'SF 8kA 3ø');
INSERT INTO obras.maestro_estructura VALUES (2774, 'SF 12kA 3ø', 'SF 12kA 3ø');
INSERT INTO obras.maestro_estructura VALUES (2775, 'R ELECTRONICO 15KV', 'R ELECTRONICO 15KV');
INSERT INTO obras.maestro_estructura VALUES (2776, 'BTPre R TMR 76M 1F', 'BTPre R TMR 76M 1F');
INSERT INTO obras.maestro_estructura VALUES (2777, 'BT P 76M SB NRS ANGU', 'BT P 76M SB NRS ANGU');
INSERT INTO obras.maestro_estructura VALUES (2778, 'BT P 76M SB NRST Ang', 'BT P 76M SB NRST Ang');
INSERT INTO obras.maestro_estructura VALUES (2779, 'BT SEP 76M SB N', 'BT SEP 76M SB N');
INSERT INTO obras.maestro_estructura VALUES (2780, 'BT R2 76B SB N', 'BT R2 76B SB N');
INSERT INTO obras.maestro_estructura VALUES (2781, 'BT R 76B SB NR+Der2v', 'BT R 76B SB NR+Der2v');
INSERT INTO obras.maestro_estructura VALUES (2782, 'BT R 76B SB NR+Der1v', 'BT R 76B SB NR+Der1v');
INSERT INTO obras.maestro_estructura VALUES (2783, 'BT SEP 76M SB NR', 'BT SEP 76M SB NR');
INSERT INTO obras.maestro_estructura VALUES (2784, 'BT SEP 76B SB NR', 'BT SEP 76B SB NR');
INSERT INTO obras.maestro_estructura VALUES (2785, 'BT RL 76M SB NR', 'BT RL 76M SB NR');
INSERT INTO obras.maestro_estructura VALUES (2786, 'BT R 76M SB NR', 'BT R 76M SB NR');
INSERT INTO obras.maestro_estructura VALUES (2787, 'BT R2D2 76M SB NR', 'BT R2D2 76M SB NR');
INSERT INTO obras.maestro_estructura VALUES (2788, 'BT SEP 76M SB NRS', 'BT SEP 76M SB NRS');
INSERT INTO obras.maestro_estructura VALUES (2789, 'BT R2 76M SB NRS', 'BT R2 76M SB NRS');
INSERT INTO obras.maestro_estructura VALUES (2790, 'BT R2 76B SB NRS', 'BT R2 76B SB NRS');
INSERT INTO obras.maestro_estructura VALUES (2791, 'BT R 76M SB NRS', 'BT R 76M SB NRS');
INSERT INTO obras.maestro_estructura VALUES (2792, 'BT R 76 B SB NRST', 'BT R 76 B SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2793, 'BT R 76 B SB NRST', 'BT R 76 B SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2794, 'BT R 76 B SB NRST', 'BT R 76 B SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2795, 'BT R 76 B SB NRST', 'BT R 76 B SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2796, 'BT R 76M SB NRST', 'BT R 76M SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2797, 'BT R 76M SB NRST', 'BT R 76M SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2798, 'BT R 76M SB NRST', 'BT R 76M SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2799, 'BT R 76M SB NRST', 'BT R 76M SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2800, 'BT RL 76M SB NRST', 'BT RL 76M SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2801, 'BT SEP 76 B SB NRST', 'BT SEP 76 B SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2802, 'BT SEP 76M SB NRST', 'BT SEP 76M SB NRST');
INSERT INTO obras.maestro_estructura VALUES (2803, 'BT R Der 5Vias', 'BT R Der 5Vias');
INSERT INTO obras.maestro_estructura VALUES (2804, 'BT P  5 vias', 'BT P  5 vias');
INSERT INTO obras.maestro_estructura VALUES (2805, 'BT P 5 vias', 'BT P 5 vias');
INSERT INTO obras.maestro_estructura VALUES (2806, 'BT P 5 vias', 'BT P 5 vias');
INSERT INTO obras.maestro_estructura VALUES (2807, 'BT R 5 vias', 'BT R 5 vias');
INSERT INTO obras.maestro_estructura VALUES (2808, 'BT R y der 5 vias', 'BT R y der 5 vias');
INSERT INTO obras.maestro_estructura VALUES (2809, 'BT SEC 5 vias', 'BT SEC 5 vias');
INSERT INTO obras.maestro_estructura VALUES (2810, 'BT SEP 5 vias', 'BT SEP 5 vias');
INSERT INTO obras.maestro_estructura VALUES (2811, 'HI MAG BT1F 2S', 'HI MAG BT1F 2S');
INSERT INTO obras.maestro_estructura VALUES (2812, 'Ferr Portrafo 2p', 'Ferr Portrafo 2p');
INSERT INTO obras.maestro_estructura VALUES (2813, 'Pro HI MAG2 sect +75', 'Pro HI MAG2 sect +75');
INSERT INTO obras.maestro_estructura VALUES (2814, 'S/E 3F Moch FUS Y TI', 'S/E 3F Moch FUS Y TI');
INSERT INTO obras.maestro_estructura VALUES (2815, 'SAL  AHI MAG  PRO BT', 'SAL  AHI MAG  PRO BT');
INSERT INTO obras.maestro_estructura VALUES (2816, 'SAL SE 1SECT SECC NH', 'SAL SE 1SECT SECC NH');
INSERT INTO obras.maestro_estructura VALUES (2817, 'SAL S/E 2SECT SECC B', 'SAL S/E 2SECT SECC B');
INSERT INTO obras.maestro_estructura VALUES (2818, 'SAL S/E TRIP BT', 'SAL S/E TRIP BT');
INSERT INTO obras.maestro_estructura VALUES (2819, 'SAL  S/E 1TRIP BT', 'SAL  S/E 1TRIP BT');
INSERT INTO obras.maestro_estructura VALUES (2820, 'S/E BIFAS MO F', 'S/E BIFAS MO F');
INSERT INTO obras.maestro_estructura VALUES (2821, 'S/E BIFAS MO', 'S/E BIFAS MO');
INSERT INTO obras.maestro_estructura VALUES (2822, 'S/E 3F 2P DESC F', 'S/E 3F 2P DESC F');
INSERT INTO obras.maestro_estructura VALUES (2823, 'S/E 3F 2P', 'S/E 3F 2P');
INSERT INTO obras.maestro_estructura VALUES (2824, 'S/E 3F MOCHILA C/DF', 'S/E 3F MOCHILA C/DF');
INSERT INTO obras.maestro_estructura VALUES (2825, 'TIR S BT', 'TIR S BT');
INSERT INTO obras.maestro_estructura VALUES (2826, 'TIR SIM', 'TIR SIM');
INSERT INTO obras.maestro_estructura VALUES (2827, 'TIR SIM 1150', 'TIR SIM 1150');
INSERT INTO obras.maestro_estructura VALUES (2828, 'TIR SIM', 'TIR SIM');
INSERT INTO obras.maestro_estructura VALUES (2829, 'TIR POS MO', 'TIR POS MO');
INSERT INTO obras.maestro_estructura VALUES (2830, 'TIR POS MO', 'TIR POS MO');
INSERT INTO obras.maestro_estructura VALUES (2831, 'CPr 70 mm2 3ø 15 KV', 'CPr 70 mm2 3ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (2832, 'TIR POS MO S/ANCL', 'TIR POS MO S/ANCL');
INSERT INTO obras.maestro_estructura VALUES (2833, 'CCo 50 mm2 3ø 25 KV', 'CCo 50 mm2 3ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (2834, 'TIR PMO S/ANCL BT', 'TIR PMO S/ANCL BT');
INSERT INTO obras.maestro_estructura VALUES (2835, 'CCo 70 mm2 3ø 25 KV', 'CCo 70 mm2 3ø 25 KV');
INSERT INTO obras.maestro_estructura VALUES (2836, 'TIR PMO S/ANCL', 'TIR PMO S/ANCL');
INSERT INTO obras.maestro_estructura VALUES (2837, 'TRT CORT BT LIV', 'TRT CORT BT LIV');
INSERT INTO obras.maestro_estructura VALUES (2838, 'CCo 95 mm2 3ø 15 KV', 'CCo 95 mm2 3ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (2839, 'CCO 185 MM2 3Ø 25KV', 'CCO 185 MM2 3Ø 25KV');
INSERT INTO obras.maestro_estructura VALUES (2840, 'TT RED DIS (malla)', 'TT RED DIS (malla)');
INSERT INTO obras.maestro_estructura VALUES (2841, 'TT 3 BARR', 'TT 3 BARR');
INSERT INTO obras.maestro_estructura VALUES (2842, 'TT 1 BARR', 'TT 1 BARR');
INSERT INTO obras.maestro_estructura VALUES (2843, 'HI-MAG F-N', 'HI-MAG F-N');
INSERT INTO obras.maestro_estructura VALUES (2844, 'BT RL 76M SB N', 'BT RL 76M SB N');
INSERT INTO obras.maestro_estructura VALUES (2845, 'BT R 76M SB N', 'BT R 76M SB N');
INSERT INTO obras.maestro_estructura VALUES (2846, 'CCu 25 mm2  3ø', 'CCu 25 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (2847, 'CCu 85 mm2  3ø', 'CCu 85 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (2848, 'DUC PVC2 MT 4X063 CH', 'DUC PVC2 MT 4X063 CH');
INSERT INTO obras.maestro_estructura VALUES (2849, 'DUCTO PVC MT 4 X 110', 'DUCTO PVC MT 4 X 110');
INSERT INTO obras.maestro_estructura VALUES (2850, 'DUCTO PVC BT 1 X 110', 'DUCTO PVC BT 1 X 110');
INSERT INTO obras.maestro_estructura VALUES (2851, 'USE 53MM2 4C', 'USE 53MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2852, 'USE 67/THW 67MM2 4C', 'USE 67/THW 67MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2853, 'USE 53/USE 33MM2 4C', 'USE 53/USE 33MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2854, 'XLPE #2AWG 3ø 15KV', 'XLPE #2AWG 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (2855, 'XLPE #3/0AWG 3F 15KV', 'XLPE #3/0AWG 3F 15KV');
INSERT INTO obras.maestro_estructura VALUES (2856, 'XLPE  240 mm2 3F 15K', 'XLPE  240 mm2 3F 15K');
INSERT INTO obras.maestro_estructura VALUES (2857, 'PC  8.70 m', 'PC  8.70 m');
INSERT INTO obras.maestro_estructura VALUES (2858, 'MMT 3ø Cu-Al', 'MMT 3ø Cu-Al');
INSERT INTO obras.maestro_estructura VALUES (2859, 'MMT 3F 56mm', 'MMT 3F 56mm');
INSERT INTO obras.maestro_estructura VALUES (2860, 'MT BS 3ø', 'MT BS 3ø');
INSERT INTO obras.maestro_estructura VALUES (2861, 'BT BS', 'BT BS');
INSERT INTO obras.maestro_estructura VALUES (2862, 'XLPE 70 mm ²3F 23KV', 'XLPE 70 mm ²3F 23KV');
INSERT INTO obras.maestro_estructura VALUES (2863, 'MBT 4C', 'MBT 4C');
INSERT INTO obras.maestro_estructura VALUES (2864, 'MBT 2C', 'MBT 2C');
INSERT INTO obras.maestro_estructura VALUES (2865, 'MBT 4C doble prensa', 'MBT 4C doble prensa');
INSERT INTO obras.maestro_estructura VALUES (2866, 'PM 10 m', 'PM 10 m');
INSERT INTO obras.maestro_estructura VALUES (2867, 'CCo 53 mm2 3ø 15 KV', 'CCo 53 mm2 3ø 15 KV');
INSERT INTO obras.maestro_estructura VALUES (2868, 'S/E Tipo Mochila', 'S/E Tipo Mochila');
INSERT INTO obras.maestro_estructura VALUES (2869, 'TT Proteccion PExist', 'TT Proteccion PExist');
INSERT INTO obras.maestro_estructura VALUES (2870, 'TT Proteccion PNuevo', 'TT Proteccion PNuevo');
INSERT INTO obras.maestro_estructura VALUES (2871, 'PILC SWA 25mm2 3F', 'PILC SWA 25mm2 3F');
INSERT INTO obras.maestro_estructura VALUES (2872, 'CCu 67.4/67.4 MM2 4C', 'CCu 67.4/67.4 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2873, 'CCu 67.4/33.6 MM2 4C', 'CCu 67.4/33.6 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2874, 'CPr 33.6 mm2 3ø 15 K', 'CPr 33.6 mm2 3ø 15 K');
INSERT INTO obras.maestro_estructura VALUES (2875, 'CPr 53.5 mm2 3ø 15KV', 'CPr 53.5 mm2 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (2876, 'CPr 107.2 mm2 3Ø 15K', 'CPr 107.2 mm2 3Ø 15K');
INSERT INTO obras.maestro_estructura VALUES (2877, 'BT P y der 5 vias', 'BT P y der 5 vias');
INSERT INTO obras.maestro_estructura VALUES (2878, 'SAL SE 1SECT sin SEC', 'SAL SE 1SECT sin SEC');
INSERT INTO obras.maestro_estructura VALUES (2879, 'Equipo NH 3Ø', 'Equipo NH 3Ø');
INSERT INTO obras.maestro_estructura VALUES (2880, 'SAL S/E 2SECT sin SE', 'SAL S/E 2SECT sin SE');
INSERT INTO obras.maestro_estructura VALUES (2881, 'SAL  S/E 1TRIP BT', 'SAL  S/E 1TRIP BT');
INSERT INTO obras.maestro_estructura VALUES (2882, 'Equipo Tripolar', 'Equipo Tripolar');
INSERT INTO obras.maestro_estructura VALUES (2883, 'CAVANNA NH 3Ø Equipo', 'CAVANNA NH 3Ø Equipo');
INSERT INTO obras.maestro_estructura VALUES (2884, 'Equipo NH 1Ø', 'Equipo NH 1Ø');
INSERT INTO obras.maestro_estructura VALUES (2885, 'CCu 21.16 mm2  3ø', 'CCu 21.16 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (2886, 'Cpre 1x16/16 Neutro', 'Cpre 1x16/16 Neutro');
INSERT INTO obras.maestro_estructura VALUES (2887, 'SF Zona Normal', 'SF Zona Normal');
INSERT INTO obras.maestro_estructura VALUES (2888, 'LOSA TRAFO. AEREO', 'LOSA TRAFO. AEREO');
INSERT INTO obras.maestro_estructura VALUES (2889, 'LOSA TRAFO. PAD-MOUN', 'LOSA TRAFO. PAD-MOUN');
INSERT INTO obras.maestro_estructura VALUES (2890, 'Cabecera Alimentador', 'Cabecera Alimentador');
INSERT INTO obras.maestro_estructura VALUES (2891, 'MMT 3ø Al-Al 107mm', 'MMT 3ø Al-Al 107mm');
INSERT INTO obras.maestro_estructura VALUES (2892, 'MMT 3ø Al-Al 53mm', 'MMT 3ø Al-Al 53mm');
INSERT INTO obras.maestro_estructura VALUES (2893, 'MMT 3ø Al-Al 33mm', 'MMT 3ø Al-Al 33mm');
INSERT INTO obras.maestro_estructura VALUES (2894, 'MMT 3ø Cu-Cu 16mm', 'MMT 3ø Cu-Cu 16mm');
INSERT INTO obras.maestro_estructura VALUES (2895, 'S/E Tipo Mochila ECM', 'S/E Tipo Mochila ECM');
INSERT INTO obras.maestro_estructura VALUES (2896, 'DUCTO PVC BT 2 X 110', 'DUCTO PVC BT 2 X 110');
INSERT INTO obras.maestro_estructura VALUES (2897, 'CPr 33.6 mm2 2ø 25 K', 'CPr 33.6 mm2 2ø 25 K');
INSERT INTO obras.maestro_estructura VALUES (2898, 'BTPre R 76B 1F', 'BTPre R 76B 1F');
INSERT INTO obras.maestro_estructura VALUES (2899, 'XAT #1/0AWG 3ø 15KV', 'XAT #1/0AWG 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (2900, 'BT R 76B NR', 'BT R 76B NR');
INSERT INTO obras.maestro_estructura VALUES (2901, 'BT R 76B NRST', 'BT R 76B NRST');
INSERT INTO obras.maestro_estructura VALUES (2902, 'Montaje DDCC 2P', 'Montaje DDCC 2P');
INSERT INTO obras.maestro_estructura VALUES (2903, 'XT 350MCM 3ø 15KV', 'XT 350MCM 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (2904, 'S/E 3F MOCHILA S/DF', 'S/E 3F MOCHILA S/DF');
INSERT INTO obras.maestro_estructura VALUES (2905, 'S/E Tipo Mochila REC', 'S/E Tipo Mochila REC');
INSERT INTO obras.maestro_estructura VALUES (2906, 'DUCTO PVC BT 2X 90', 'DUCTO PVC BT 2X 90');
INSERT INTO obras.maestro_estructura VALUES (2907, 'MBT 4C PRE', 'MBT 4C PRE');
INSERT INTO obras.maestro_estructura VALUES (2908, 'DDFF en Boveda', 'DDFF en Boveda');
INSERT INTO obras.maestro_estructura VALUES (2909, 'MT SE1PC 3F S2P PROT', 'MT SE1PC 3F S2P PROT');
INSERT INTO obras.maestro_estructura VALUES (2910, 'MMT 3ø Cu P', 'MMT 3ø Cu P');
INSERT INTO obras.maestro_estructura VALUES (2911, 'CCu 10/10 MM2 4C', 'CCu 10/10 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2912, 'BT LZ  5 vias', 'BT LZ  5 vias');
INSERT INTO obras.maestro_estructura VALUES (2913, 'PMadera 70pies', 'PMadera 70pies');
INSERT INTO obras.maestro_estructura VALUES (2914, 'Montaje DF 2F', 'Montaje DF 2F');
INSERT INTO obras.maestro_estructura VALUES (2915, 'CCu 21/21 MM2 4C', 'CCu 21/21 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2916, 'CCu 21/16 MM2 4C', 'CCu 21/16 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2917, 'CCu 10/10 MM2 2C', 'CCu 10/10 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (2918, 'CComp 33.6 mm2 3ø 15', 'CComp 33.6 mm2 3ø 15');
INSERT INTO obras.maestro_estructura VALUES (2919, 'MMT 3ø Co', 'MMT 3ø Co');
INSERT INTO obras.maestro_estructura VALUES (2920, 'PROT. 1F 5KVA', 'PROT. 1F 5KVA');
INSERT INTO obras.maestro_estructura VALUES (2921, 'PROT. 1F 10KVA', 'PROT. 1F 10KVA');
INSERT INTO obras.maestro_estructura VALUES (2922, 'CableCuCW 2AWG 3ø', 'CableCuCW 2AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (2923, 'PROT. 3F 15KVA', 'PROT. 3F 15KVA');
INSERT INTO obras.maestro_estructura VALUES (2924, 'PROT. 3F 30KVA', 'PROT. 3F 30KVA');
INSERT INTO obras.maestro_estructura VALUES (2925, 'PROT. 3F 45KVA', 'PROT. 3F 45KVA');
INSERT INTO obras.maestro_estructura VALUES (2926, 'PROT. 3F 75KVA', 'PROT. 3F 75KVA');
INSERT INTO obras.maestro_estructura VALUES (2927, 'PROT. 3F 100KVA', 'PROT. 3F 100KVA');
INSERT INTO obras.maestro_estructura VALUES (2928, 'PROT. 3F 150KVA', 'PROT. 3F 150KVA');
INSERT INTO obras.maestro_estructura VALUES (2929, 'PROT. 3F 200KVA', 'PROT. 3F 200KVA');
INSERT INTO obras.maestro_estructura VALUES (2930, 'PROT. 3F 250KVA', 'PROT. 3F 250KVA');
INSERT INTO obras.maestro_estructura VALUES (2931, 'PROT. 3F 300KVA', 'PROT. 3F 300KVA');
INSERT INTO obras.maestro_estructura VALUES (2932, 'BT Control ECM', 'BT Control ECM');
INSERT INTO obras.maestro_estructura VALUES (2933, 'Ampac 031-6 3ø', 'Ampac 031-6 3ø');
INSERT INTO obras.maestro_estructura VALUES (2934, 'Ampac 031-2 3ø', 'Ampac 031-2 3ø');
INSERT INTO obras.maestro_estructura VALUES (2935, 'EPC 1.15 m', 'EPC 1.15 m');
INSERT INTO obras.maestro_estructura VALUES (2936, 'EPC 1.60 m', 'EPC 1.60 m');
INSERT INTO obras.maestro_estructura VALUES (2937, 'EPC 2.80 m', 'EPC 2.80 m');
INSERT INTO obras.maestro_estructura VALUES (2938, 'MTProt 15N 3P JA', 'MTProt 15N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (2939, 'CCu 13.30 mm2  2ø', 'CCu 13.30 mm2  2ø');
INSERT INTO obras.maestro_estructura VALUES (2940, 'Mufa derivacion 2F', 'Mufa derivacion 2F');
INSERT INTO obras.maestro_estructura VALUES (2941, 'Consola BCond', 'Consola BCond');
INSERT INTO obras.maestro_estructura VALUES (2942, 'Mufa derivacion 3F', 'Mufa derivacion 3F');
INSERT INTO obras.maestro_estructura VALUES (2943, 'CCo 95 mm2 3ø 25KV', 'CCo 95 mm2 3ø 25KV');
INSERT INTO obras.maestro_estructura VALUES (2944, 'CPr 95 mm2 3ø 25KV', 'CPr 95 mm2 3ø 25KV');
INSERT INTO obras.maestro_estructura VALUES (2945, 'BT R 5 vias', 'BT R 5 vias');
INSERT INTO obras.maestro_estructura VALUES (2946, 'AlambCu #6 2F+#5 1F', 'AlambCu #6 2F+#5 1F');
INSERT INTO obras.maestro_estructura VALUES (2947, 'XT 500/500 MCM 4C', 'XT 500/500 MCM 4C');
INSERT INTO obras.maestro_estructura VALUES (2948, 'Bota 3/0 AWG', 'Bota 3/0 AWG');
INSERT INTO obras.maestro_estructura VALUES (2949, 'TRA 15 2F 5 kVA', 'TRA 15 2F 5 kVA');
INSERT INTO obras.maestro_estructura VALUES (2950, 'TRA 15 2F 10 kVA', 'TRA 15 2F 10 kVA');
INSERT INTO obras.maestro_estructura VALUES (2951, 'TRA 15 2F 15 kVA', 'TRA 15 2F 15 kVA');
INSERT INTO obras.maestro_estructura VALUES (2952, 'TRA 15 3F 15 kVA', 'TRA 15 3F 15 kVA');
INSERT INTO obras.maestro_estructura VALUES (2953, 'TRA 15 3F 30 kVA', 'TRA 15 3F 30 kVA');
INSERT INTO obras.maestro_estructura VALUES (2954, 'TRA 15 3F 45 kVA', 'TRA 15 3F 45 kVA');
INSERT INTO obras.maestro_estructura VALUES (2955, 'TRA 15 3F 75 kVA', 'TRA 15 3F 75 kVA');
INSERT INTO obras.maestro_estructura VALUES (2956, 'TRA 15 3F 100 kVA', 'TRA 15 3F 100 kVA');
INSERT INTO obras.maestro_estructura VALUES (2957, 'TRA 15 3F 200 kVA', 'TRA 15 3F 200 kVA');
INSERT INTO obras.maestro_estructura VALUES (2958, 'TRA 15 3F 250 kVA', 'TRA 15 3F 250 kVA');
INSERT INTO obras.maestro_estructura VALUES (2959, 'TRA 15 3F 300 kVA', 'TRA 15 3F 300 kVA');
INSERT INTO obras.maestro_estructura VALUES (2960, 'TRA 15 3F 500 kVA', 'TRA 15 3F 500 kVA');
INSERT INTO obras.maestro_estructura VALUES (2961, 'TRA 15 3F 1250 kVA', 'TRA 15 3F 1250 kVA');
INSERT INTO obras.maestro_estructura VALUES (2962, 'TRA 15 3F 300 kVA', 'TRA 15 3F 300 kVA');
INSERT INTO obras.maestro_estructura VALUES (2963, 'TRA 15 3F 750 kVA', 'TRA 15 3F 750 kVA');
INSERT INTO obras.maestro_estructura VALUES (2964, 'MTProt 15N 3P RS', 'MTProt 15N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (2965, 'Indicador COCI poste', 'Indicador COCI poste');
INSERT INTO obras.maestro_estructura VALUES (2966, 'MTProt 15N 3P JI', 'MTProt 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (2967, 'CPr 300 mm2 3Ø 25KV', 'CPr 300 mm2 3Ø 25KV');
INSERT INTO obras.maestro_estructura VALUES (2968, 'BTPre R 76M 1F', 'BTPre R 76M 1F');
INSERT INTO obras.maestro_estructura VALUES (2969, 'MTCU 15N 3P AnclVert', 'MTCU 15N 3P AnclVert');
INSERT INTO obras.maestro_estructura VALUES (2970, 'Aisl paso volant OLD', 'Aisl paso volant OLD');
INSERT INTO obras.maestro_estructura VALUES (2971, 'Aisl remate volantin', 'Aisl remate volantin');
INSERT INTO obras.maestro_estructura VALUES (2972, 'Mufa Union 15 kV', 'Mufa Union 15 kV');
INSERT INTO obras.maestro_estructura VALUES (2973, 'Mufa Union 15 kV', 'Mufa Union 15 kV');
INSERT INTO obras.maestro_estructura VALUES (2974, 'CCO 107 MM2 3Ø 15KV', 'CCO 107 MM2 3Ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (2975, 'PC 10 usado_SF', 'PC 10 usado_SF');
INSERT INTO obras.maestro_estructura VALUES (2976, 'CableCuCW 1/0AWG 3ø', 'CableCuCW 1/0AWG 3ø');
INSERT INTO obras.maestro_estructura VALUES (2977, 'Cu 1x13.3/2x16/1x13.', 'Cu 1x13.3/2x16/1x13.');
INSERT INTO obras.maestro_estructura VALUES (2978, 'TT PROT (malla)', 'TT PROT (malla)');
INSERT INTO obras.maestro_estructura VALUES (2979, 'THHN 1/0AWG/THHN 1/0', 'THHN 1/0AWG/THHN 1/0');
INSERT INTO obras.maestro_estructura VALUES (2980, 'Control Bco Cond', 'Control Bco Cond');
INSERT INTO obras.maestro_estructura VALUES (2981, 'XAT #33 mm2 3ø 15KV', 'XAT #33 mm2 3ø 15KV');
INSERT INTO obras.maestro_estructura VALUES (2982, 'Codo Operable', 'Codo Operable');
INSERT INTO obras.maestro_estructura VALUES (2983, 'XTU 42.4/42.4 MM2 4C', 'XTU 42.4/42.4 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (2984, 'PC 18.0 m C', 'PC 18.0 m C');
INSERT INTO obras.maestro_estructura VALUES (2985, 'Aisl paso volantin', 'Aisl paso volantin');
INSERT INTO obras.maestro_estructura VALUES (2986, 'CCu 53.5/21.15 MM2 4', 'CCu 53.5/21.15 MM2 4');
INSERT INTO obras.maestro_estructura VALUES (2987, 'MTAL portal SF Cr_6M', 'MTAL portal SF Cr_6M');
INSERT INTO obras.maestro_estructura VALUES (2988, 'MTAL portal SF Cr_3M', 'MTAL portal SF Cr_3M');
INSERT INTO obras.maestro_estructura VALUES (2989, 'Cu PoleTop 600A', 'Cu PoleTop 600A');
INSERT INTO obras.maestro_estructura VALUES (2990, 'TRA 15 3F 112,5 kVA', 'TRA 15 3F 112,5 kVA');
INSERT INTO obras.maestro_estructura VALUES (2991, 'CCu 53.5/33.63 MM2 4', 'CCu 53.5/33.63 MM2 4');
INSERT INTO obras.maestro_estructura VALUES (2992, 'MTCO 23N 3M JI 53MM2', 'MTCO 23N 3M JI 53MM2');
INSERT INTO obras.maestro_estructura VALUES (2993, 'TRA 15 3F 150 kVA', 'TRA 15 3F 150 kVA');
INSERT INTO obras.maestro_estructura VALUES (2994, 'BTPre CDE B', 'BTPre CDE B');
INSERT INTO obras.maestro_estructura VALUES (2995, 'BTPre CDE M', 'BTPre CDE M');
INSERT INTO obras.maestro_estructura VALUES (2996, 'BTPRE R 76 M 1F', 'BTPRE R 76 M 1F');
INSERT INTO obras.maestro_estructura VALUES (2997, 'Cu PoleTop 25 kV 900', 'Cu PoleTop 25 kV 900');
INSERT INTO obras.maestro_estructura VALUES (2998, 'CAl 3/0 AAAC 3ø', 'CAl 3/0 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (2999, 'S/E 3F MOCHILA S/DF', 'S/E 3F MOCHILA S/DF');
INSERT INTO obras.maestro_estructura VALUES (3000, 'MTProt 15N 3 A1TJ', 'MTProt 15N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3001, 'THW 33.6/26.7 MM2 4C', 'THW 33.6/26.7 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (3002, 'THW 26.7/26.7 MM2 3C', 'THW 26.7/26.7 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (3003, 'MTProt 15N 3 A1TJ', 'MTProt 15N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3004, 'Mont Cable Guardia', 'Mont Cable Guardia');
INSERT INTO obras.maestro_estructura VALUES (3005, 'EM 1ø BT', 'EM 1ø BT');
INSERT INTO obras.maestro_estructura VALUES (3006, 'MTProt 15N 2 A1TJ ne', 'MTProt 15N 2 A1TJ ne');
INSERT INTO obras.maestro_estructura VALUES (3007, 'TIR S BT', 'TIR S BT');
INSERT INTO obras.maestro_estructura VALUES (3008, 'CAl 33.6 MM2 1C', 'CAl 33.6 MM2 1C');
INSERT INTO obras.maestro_estructura VALUES (3009, 'PC 13,5 m', 'PC 13,5 m');
INSERT INTO obras.maestro_estructura VALUES (3010, 'TRA 15 3F 50 kVA', 'TRA 15 3F 50 kVA');
INSERT INTO obras.maestro_estructura VALUES (3011, 'DF 8kAR 3ø', 'DF 8kAR 3ø');
INSERT INTO obras.maestro_estructura VALUES (3012, 'PC 9 usado_SF', 'PC 9 usado_SF');
INSERT INTO obras.maestro_estructura VALUES (3013, 'MTCU 15N 3P JP3PC', 'MTCU 15N 3P JP3PC');
INSERT INTO obras.maestro_estructura VALUES (3014, 'TMC 3ø 15KV 20-40/5', 'TMC 3ø 15KV 20-40/5');
INSERT INTO obras.maestro_estructura VALUES (3015, 'TMC 3ø 15KV 100-200/', 'TMC 3ø 15KV 100-200/');
INSERT INTO obras.maestro_estructura VALUES (3016, 'MONT REGULADOR DE VO', 'MONT REGULADOR DE VO');
INSERT INTO obras.maestro_estructura VALUES (3017, 'BT R 76B SB NRS', 'BT R 76B SB NRS');
INSERT INTO obras.maestro_estructura VALUES (3018, 'PM  8.0 m', 'PM  8.0 m');
INSERT INTO obras.maestro_estructura VALUES (3019, 'MTCU 3F Portal PS 6m', 'MTCU 3F Portal PS 6m');
INSERT INTO obras.maestro_estructura VALUES (3020, 'MTAL 3F Portal PD', 'MTAL 3F Portal PD');
INSERT INTO obras.maestro_estructura VALUES (3021, 'Ampac 046-5 3ø', 'Ampac 046-5 3ø');
INSERT INTO obras.maestro_estructura VALUES (3022, 'Ampac 046-5 2ø', 'Ampac 046-5 2ø');
INSERT INTO obras.maestro_estructura VALUES (3023, 'AlambreCu 8mm 3ø', 'AlambreCu 8mm 3ø');
INSERT INTO obras.maestro_estructura VALUES (3024, 'SC 600A 25 kV', 'SC 600A 25 kV');
INSERT INTO obras.maestro_estructura VALUES (3025, 'Mont Alarma Radial', 'Mont Alarma Radial');
INSERT INTO obras.maestro_estructura VALUES (3026, 'CPr 185 mm2 3Ø 15K', 'CPr 185 mm2 3Ø 15K');
INSERT INTO obras.maestro_estructura VALUES (3027, 'Equipo NH 1Ø', 'Equipo NH 1Ø');
INSERT INTO obras.maestro_estructura VALUES (3028, 'CAl 2 AAAC 3ø usado', 'CAl 2 AAAC 3ø usado');
INSERT INTO obras.maestro_estructura VALUES (3029, 'TRA 15 3F 1500 kVA', 'TRA 15 3F 1500 kVA');
INSERT INTO obras.maestro_estructura VALUES (3030, 'MTCO 15N 3 JI', 'MTCO 15N 3 JI');
INSERT INTO obras.maestro_estructura VALUES (3031, 'CAl 1/0 AAAC 2ø', 'CAl 1/0 AAAC 2ø');
INSERT INTO obras.maestro_estructura VALUES (3032, 'CAl 1/0 AAAC 3ø', 'CAl 1/0 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (3033, 'MTPROT 15N 3P A1TJS', 'MTPROT 15N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3034, 'MTPROT 15N 3P A1TJ', 'MTPROT 15N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3035, 'MTPROT 15N 3P A2PES', 'MTPROT 15N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (3036, 'MTPROT 15N 3P JI', 'MTPROT 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3037, 'MTPROT 15N 3M A1TJ', 'MTPROT 15N 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3038, 'MTProt 15N 3 PCD', 'MTProt 15N 3 PCD');
INSERT INTO obras.maestro_estructura VALUES (3039, 'USEoXTU 53.5MM2 3C', 'USEoXTU 53.5MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (3040, 'USEoXTU 53.5MM2 2C', 'USEoXTU 53.5MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (3041, 'MTProt 15N 3 PA', 'MTProt 15N 3 PA');
INSERT INTO obras.maestro_estructura VALUES (3042, 'MTProt 15N 3P RS', 'MTProt 15N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3043, 'CCu 85/85 MM2 4C', 'CCu 85/85 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (3044, 'MMT 3ø P Co', 'MMT 3ø P Co');
INSERT INTO obras.maestro_estructura VALUES (3045, 'CELDA MT', 'CELDA MT');
INSERT INTO obras.maestro_estructura VALUES (3046, 'TRA 15 3F 1000 kVA', 'TRA 15 3F 1000 kVA');
INSERT INTO obras.maestro_estructura VALUES (3047, 'TRA 15 3F 500 kVA', 'TRA 15 3F 500 kVA');
INSERT INTO obras.maestro_estructura VALUES (3048, 'TRA 15 3F 1500 kVA', 'TRA 15 3F 1500 kVA');
INSERT INTO obras.maestro_estructura VALUES (3049, 'TRA 15 3F 400 kVA', 'TRA 15 3F 400 kVA');
INSERT INTO obras.maestro_estructura VALUES (3050, 'PMet Distripole 11,5', 'PMet Distripole 11,5');
INSERT INTO obras.maestro_estructura VALUES (3051, 'PMet Distripole 15m', 'PMet Distripole 15m');
INSERT INTO obras.maestro_estructura VALUES (3052, 'AlambCu #4 2ø +#5 1ø', 'AlambCu #4 2ø +#5 1ø');
INSERT INTO obras.maestro_estructura VALUES (3053, 'MTCO 15C 3 RS', 'MTCO 15C 3 RS');
INSERT INTO obras.maestro_estructura VALUES (3054, 'RF 8kAR 2ø', 'RF 8kAR 2ø');
INSERT INTO obras.maestro_estructura VALUES (3055, 'RF 8kAR 3ø', 'RF 8kAR 3ø');
INSERT INTO obras.maestro_estructura VALUES (3056, 'DH 300A-8kAR 3ø', 'DH 300A-8kAR 3ø');
INSERT INTO obras.maestro_estructura VALUES (3057, 'MTProt 15N 3L A1TJ', 'MTProt 15N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3058, 'PC - Tusan 18.0 m', 'PC - Tusan 18.0 m');
INSERT INTO obras.maestro_estructura VALUES (3059, 'USEoXTU 33.6/26.7 4C', 'USEoXTU 33.6/26.7 4C');
INSERT INTO obras.maestro_estructura VALUES (3060, 'Ampac 031-3 3ø', 'Ampac 031-3 3ø');
INSERT INTO obras.maestro_estructura VALUES (3061, 'Ampac 031-4 3ø', 'Ampac 031-4 3ø');
INSERT INTO obras.maestro_estructura VALUES (3062, 'DUCTO ACERO MT', 'DUCTO ACERO MT');
INSERT INTO obras.maestro_estructura VALUES (3063, 'MONT REGULADOR DE VO', 'MONT REGULADOR DE VO');
INSERT INTO obras.maestro_estructura VALUES (3064, 'CAl 1/0 AAAC 3ø', 'CAl 1/0 AAAC 3ø');
INSERT INTO obras.maestro_estructura VALUES (3065, 'Mufa Terminal Exteri', 'Mufa Terminal Exteri');
INSERT INTO obras.maestro_estructura VALUES (3066, 'RCG lado aisl trac', 'RCG lado aisl trac');
INSERT INTO obras.maestro_estructura VALUES (3067, 'RCG lado tierra', 'RCG lado tierra');
INSERT INTO obras.maestro_estructura VALUES (3068, 'RCG lado aisl trac', 'RCG lado aisl trac');
INSERT INTO obras.maestro_estructura VALUES (3069, 'RCG lado tierra', 'RCG lado tierra');
INSERT INTO obras.maestro_estructura VALUES (3070, 'MMT 3ø Al Prot 70-Cu', 'MMT 3ø Al Prot 70-Cu');
INSERT INTO obras.maestro_estructura VALUES (3071, 'XLPE 120/70 MM2 4C B', 'XLPE 120/70 MM2 4C B');
INSERT INTO obras.maestro_estructura VALUES (3072, 'XLPE 70/35 MM2 4C BT', 'XLPE 70/35 MM2 4C BT');
INSERT INTO obras.maestro_estructura VALUES (3073, 'DUCTO PVC BT 1 X 75', 'DUCTO PVC BT 1 X 75');
INSERT INTO obras.maestro_estructura VALUES (3074, 'THW 21/XT 8 MM2 2C', 'THW 21/XT 8 MM2 2C');
INSERT INTO obras.maestro_estructura VALUES (3075, 'THW 21/XT 8 MM2 3C', 'THW 21/XT 8 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (3076, 'THW 21/XT 8 MM2 4C', 'THW 21/XT 8 MM2 4C');
INSERT INTO obras.maestro_estructura VALUES (3077, 'BARRA SE1PC PR3ø', 'BARRA SE1PC PR3ø');
INSERT INTO obras.maestro_estructura VALUES (3078, 'BARRA SE1PC PR3ø 2S', 'BARRA SE1PC PR3ø 2S');
INSERT INTO obras.maestro_estructura VALUES (3079, 'BARRA SE2PC PR3ø', 'BARRA SE2PC PR3ø');
INSERT INTO obras.maestro_estructura VALUES (3080, 'PC  9.5 m (11.5 rec)', 'PC  9.5 m (11.5 rec)');
INSERT INTO obras.maestro_estructura VALUES (3081, 'MT BS 3ø', 'MT BS 3ø');
INSERT INTO obras.maestro_estructura VALUES (3082, 'MTProt 15N 3P PS', 'MTProt 15N 3P PS');
INSERT INTO obras.maestro_estructura VALUES (3083, 'MTProt 15N 3P PCD', 'MTProt 15N 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (3084, 'BTPre ANTIHURTO M 3F', 'BTPre ANTIHURTO M 3F');
INSERT INTO obras.maestro_estructura VALUES (3085, 'BTPre ANTIHURTO B 3F', 'BTPre ANTIHURTO B 3F');
INSERT INTO obras.maestro_estructura VALUES (3086, 'MTProt 15N 2 A1TES', 'MTProt 15N 2 A1TES');
INSERT INTO obras.maestro_estructura VALUES (3087, 'MTProt 15N 3 A1TE', 'MTProt 15N 3 A1TE');
INSERT INTO obras.maestro_estructura VALUES (3088, 'MTCU 23N 3M PS cr Fe', 'MTCU 23N 3M PS cr Fe');
INSERT INTO obras.maestro_estructura VALUES (3089, 'PILAR SOPORTE DE BAR', 'PILAR SOPORTE DE BAR');
INSERT INTO obras.maestro_estructura VALUES (3090, 'BT 76 M 1C ES', 'BT 76 M 1C ES');
INSERT INTO obras.maestro_estructura VALUES (3091, 'BT 76 M 5C ES', 'BT 76 M 5C ES');
INSERT INTO obras.maestro_estructura VALUES (3092, 'MTProt 15N 3P PD', 'MTProt 15N 3P PD');
INSERT INTO obras.maestro_estructura VALUES (3093, 'MTProt 15N 3 PC', 'MTProt 15N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (3094, 'EM 3ø BT Dir. 45kVA', 'EM 3ø BT Dir. 45kVA');
INSERT INTO obras.maestro_estructura VALUES (3095, 'PC 10 usado_SanVic', 'PC 10 usado_SanVic');
INSERT INTO obras.maestro_estructura VALUES (3096, 'Trf. 100 kVA intempe', 'Trf. 100 kVA intempe');
INSERT INTO obras.maestro_estructura VALUES (3097, 'Ampac 031-6 2ø', 'Ampac 031-6 2ø');
INSERT INTO obras.maestro_estructura VALUES (3098, 'USE o XTU 67.4/67.4', 'USE o XTU 67.4/67.4');
INSERT INTO obras.maestro_estructura VALUES (3099, 'Soporte empalme DRP', 'Soporte empalme DRP');
INSERT INTO obras.maestro_estructura VALUES (3100, 'CCON 6 MM2 3C', 'CCON 6 MM2 3C');
INSERT INTO obras.maestro_estructura VALUES (3101, 'Interrupt.General MT', 'Interrupt.General MT');
INSERT INTO obras.maestro_estructura VALUES (3102, 'R ELECTRONICO 15KV c', 'R ELECTRONICO 15KV c');
INSERT INTO obras.maestro_estructura VALUES (3103, 'MTCO 23N 3 PA', 'MTCO 23N 3 PA');
INSERT INTO obras.maestro_estructura VALUES (3104, 'MTCO 23V 3 PA', 'MTCO 23V 3 PA');
INSERT INTO obras.maestro_estructura VALUES (3105, 'MTCO 15N 3 PA', 'MTCO 15N 3 PA');
INSERT INTO obras.maestro_estructura VALUES (3106, 'MTCO 23N 3 PC', 'MTCO 23N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (3107, 'MTCO 23V 3 PC', 'MTCO 23V 3 PC');
INSERT INTO obras.maestro_estructura VALUES (3108, 'USE 350/350 MCM 4C', 'USE 350/350 MCM 4C');
INSERT INTO obras.maestro_estructura VALUES (3109, 'MTProt 15N 2 A2PAS', 'MTProt 15N 2 A2PAS');
INSERT INTO obras.maestro_estructura VALUES (3110, 'PC  9.0 m (USADO)', 'PC  9.0 m (USADO)');
INSERT INTO obras.maestro_estructura VALUES (3111, 'MTCO 15N 2 A2PEJ', 'MTCO 15N 2 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3112, 'MTCO 15N 2 A2PEJS', 'MTCO 15N 2 A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3113, 'MTCO 15N 2 JI', 'MTCO 15N 2 JI');
INSERT INTO obras.maestro_estructura VALUES (3114, 'MTCO 15N 2 PAC', 'MTCO 15N 2 PAC');
INSERT INTO obras.maestro_estructura VALUES (3115, 'MTCO 15N 2 RS', 'MTCO 15N 2 RS');
INSERT INTO obras.maestro_estructura VALUES (3116, 'MTCO 15N 3 A2PEJ', 'MTCO 15N 3 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3117, 'MTCO 15N 3 PAC', 'MTCO 15N 3 PAC');
INSERT INTO obras.maestro_estructura VALUES (3118, 'MTCO 15N 3 PAC2C', 'MTCO 15N 3 PAC2C');
INSERT INTO obras.maestro_estructura VALUES (3119, 'MTCO 15N 3 PS2C', 'MTCO 15N 3 PS2C');
INSERT INTO obras.maestro_estructura VALUES (3120, 'MTCO 23N 2 A2PEJ', 'MTCO 23N 2 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3121, 'MTCO 23N 2 A2PEJS', 'MTCO 23N 2 A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3122, 'MTCO 23N 2 JI', 'MTCO 23N 2 JI');
INSERT INTO obras.maestro_estructura VALUES (3123, 'MTCO 23N 2 PAC', 'MTCO 23N 2 PAC');
INSERT INTO obras.maestro_estructura VALUES (3124, 'MTCO 23N 2 RS', 'MTCO 23N 2 RS');
INSERT INTO obras.maestro_estructura VALUES (3125, 'MTCO 23N 3 A2PEJ', 'MTCO 23N 3 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3126, 'MTCO 23N 3 A2PEJS', 'MTCO 23N 3 A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3127, 'MTCO 23N 3 JI', 'MTCO 23N 3 JI');
INSERT INTO obras.maestro_estructura VALUES (3128, 'MTCO 15N 3P JI', 'MTCO 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3129, 'MTCO 15N 3P RS', 'MTCO 15N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3130, 'MTCO 23N 3P JI', 'MTCO 23N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3131, 'MTCO 23N 3 PAC', 'MTCO 23N 3 PAC');
INSERT INTO obras.maestro_estructura VALUES (3132, 'MTCO 23N 3 PAC2C', 'MTCO 23N 3 PAC2C');
INSERT INTO obras.maestro_estructura VALUES (3133, 'MTCO 23N 3 RS', 'MTCO 23N 3 RS');
INSERT INTO obras.maestro_estructura VALUES (3134, 'MTCO 23N 3P RS', 'MTCO 23N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3135, 'MTCO 23N 3 RS2C', 'MTCO 23N 3 RS2C');
INSERT INTO obras.maestro_estructura VALUES (3136, 'MTCO 23N 3 PS', 'MTCO 23N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (3137, 'MTCO 23N 3 J2C', 'MTCO 23N 3 J2C');
INSERT INTO obras.maestro_estructura VALUES (3138, 'MTCO 15N 3 PS', 'MTCO 15N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (3139, 'MTCO 23N 3 PS2C', 'MTCO 23N 3 PS2C');
INSERT INTO obras.maestro_estructura VALUES (3140, 'MTProt 15N 2 JI', 'MTProt 15N 2 JI');
INSERT INTO obras.maestro_estructura VALUES (3141, 'MTProt 15N 2 RS', 'MTProt 15N 2 RS');
INSERT INTO obras.maestro_estructura VALUES (3142, 'MTProt 15N 3 A1TJ', 'MTProt 15N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3143, 'MTProt 15N 3 JA', 'MTProt 15N 3 JA');
INSERT INTO obras.maestro_estructura VALUES (3144, 'MTProt 15N 3 JI', 'MTProt 15N 3 JI');
INSERT INTO obras.maestro_estructura VALUES (3145, 'MTProt 15N 3M PA', 'MTProt 15N 3M PA');
INSERT INTO obras.maestro_estructura VALUES (3146, 'MTProt 15N 3 RS', 'MTProt 15N 3 RS');
INSERT INTO obras.maestro_estructura VALUES (3147, 'MTPROT 15N 3P A1TJ', 'MTPROT 15N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3148, 'MTPROT 15N 3P A1TJS', 'MTPROT 15N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3149, 'MTPROT 15N 3P JI', 'MTPROT 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3150, 'MTProt 15N 3P RS', 'MTProt 15N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3151, 'MTProt 15N 2 PC', 'MTProt 15N 2 PC');
INSERT INTO obras.maestro_estructura VALUES (3152, 'MTProt 15N 2 PD', 'MTProt 15N 2 PD');
INSERT INTO obras.maestro_estructura VALUES (3153, 'MTProt 15N 2 PS', 'MTProt 15N 2 PS');
INSERT INTO obras.maestro_estructura VALUES (3154, 'MTProt 15N 3 PC', 'MTProt 15N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (3155, 'MTProt 15N 3 PD', 'MTProt 15N 3 PD');
INSERT INTO obras.maestro_estructura VALUES (3156, 'MTProt 15N 3 PS', 'MTProt 15N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (3157, 'MTProt 23N 2 JA', 'MTProt 23N 2 JA');
INSERT INTO obras.maestro_estructura VALUES (3158, 'MTProt 23N 2 JI', 'MTProt 23N 2 JI');
INSERT INTO obras.maestro_estructura VALUES (3159, 'MTProt 23N 2 RS', 'MTProt 23N 2 RS');
INSERT INTO obras.maestro_estructura VALUES (3160, 'MTProt 23N 3 A1TJ', 'MTProt 23N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3161, 'MTPROT 23N 3 A1TJS', 'MTPROT 23N 3 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3162, 'MTProt 23N 3 JA', 'MTProt 23N 3 JA');
INSERT INTO obras.maestro_estructura VALUES (3163, 'MTProt 23N 3 JI', 'MTProt 23N 3 JI');
INSERT INTO obras.maestro_estructura VALUES (3164, 'MTProt 23N 3 RS', 'MTProt 23N 3 RS');
INSERT INTO obras.maestro_estructura VALUES (3165, 'MTProt 23N 3P A1TJ', 'MTProt 23N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3166, 'MTPROT 23N 3P A1TJS', 'MTPROT 23N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3167, 'MTProt 15N 3M A1TJ', 'MTProt 15N 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3168, 'MTProt 15N 3M JA', 'MTProt 15N 3M JA');
INSERT INTO obras.maestro_estructura VALUES (3169, 'MTProt 15N 3M JI', 'MTProt 15N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (3170, 'MTProt 15N 3M RS', 'MTProt 15N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (3171, 'MTProt 15N 3P JA', 'MTProt 15N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (3172, 'MTProt 15N 2 JA', 'MTProt 15N 2 JA');
INSERT INTO obras.maestro_estructura VALUES (3173, 'MTProt 15N 3P PCD', 'MTProt 15N 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (3174, 'MTProt 15N 3P PD', 'MTProt 15N 3P PD');
INSERT INTO obras.maestro_estructura VALUES (3175, 'MTProt 15N 3P PS', 'MTProt 15N 3P PS');
INSERT INTO obras.maestro_estructura VALUES (3176, 'MTPROT 23N 3M JA', 'MTPROT 23N 3M JA');
INSERT INTO obras.maestro_estructura VALUES (3177, 'MTProt 23N 3M JI', 'MTProt 23N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (3178, 'MTProt 23N 3M RS', 'MTProt 23N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (3179, 'MTProt 23N 3P JA', 'MTProt 23N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (3180, 'MTProt 23N 3P JI', 'MTProt 23N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3181, 'MTProt 23N 3P RS', 'MTProt 23N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3182, 'MTProt 23N 2 PC', 'MTProt 23N 2 PC');
INSERT INTO obras.maestro_estructura VALUES (3183, 'MTProt 23N 2 PD', 'MTProt 23N 2 PD');
INSERT INTO obras.maestro_estructura VALUES (3184, 'MTProt 23N 2 PS', 'MTProt 23N 2 PS');
INSERT INTO obras.maestro_estructura VALUES (3185, 'MTProt 23N 3 PC', 'MTProt 23N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (3186, 'MTProt 23N 3 PD', 'MTProt 23N 3 PD');
INSERT INTO obras.maestro_estructura VALUES (3187, 'MTProt 23N 3 PS', 'MTProt 23N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (3188, 'MTProt 23N 3P PCD', 'MTProt 23N 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (3189, 'MTProt 23N 3P PD', 'MTProt 23N 3P PD');
INSERT INTO obras.maestro_estructura VALUES (3190, 'MTProt 23N 3P PS', 'MTProt 23N 3P PS');
INSERT INTO obras.maestro_estructura VALUES (3191, 'USE o XTU 67.4', 'USE o XTU 67.4');
INSERT INTO obras.maestro_estructura VALUES (3192, 'Montaje DDCC 2P', 'Montaje DDCC 2P');
INSERT INTO obras.maestro_estructura VALUES (3193, 'MTCO 15N 2 A1TJ', 'MTCO 15N 2 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3194, 'MTCO 15N 2 A1TJS', 'MTCO 15N 2 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3195, 'MTCO 23N 2 A1TJ', 'MTCO 23N 2 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3196, 'MTCO 23N 2 A1TJS', 'MTCO 23N 2 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3197, 'MTCO 15N 3 A1TJS', 'MTCO 15N 3 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3198, 'MTCO 23N 3 A1TJS', 'MTCO 23N 3 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3199, 'MTProt 15N 2 A1TJ', 'MTProt 15N 2 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3200, 'MTProt 15N 2 A1TJS', 'MTProt 15N 2 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3201, 'MTProt 15N 3 PA', 'MTProt 15N 3 PA');
INSERT INTO obras.maestro_estructura VALUES (3202, 'MTProt 15N 3M PC', 'MTProt 15N 3M PC');
INSERT INTO obras.maestro_estructura VALUES (3203, 'MTProt 15N 3M PD', 'MTProt 15N 3M PD');
INSERT INTO obras.maestro_estructura VALUES (3204, 'MTProt 15N 3M PS', 'MTProt 15N 3M PS');
INSERT INTO obras.maestro_estructura VALUES (3205, 'MTProt 15N 2 A2PEJ', 'MTProt 15N 2 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3206, 'MTProt 15N 2 A2PEJS', 'MTProt 15N 2 A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3207, 'MTProt 23N 2 A2PEJ', 'MTProt 23N 2 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3208, 'MTProt 15N 3 A2PEJ', 'MTProt 15N 3 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3209, 'MTProt 15N 3 A2PEJS', 'MTProt 15N 3 A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3210, 'MTProt 23N 3 A2PEJ', 'MTProt 23N 3 A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3211, 'MTProt 23N 3 A2PEJS', 'MTProt 23N 3 A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3212, 'MTProt 23N 2 A2PEJS', 'MTProt 23N 2 A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3213, 'MTProt 15N 3M A2PEJ', 'MTProt 15N 3M A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3214, 'MTProt 15N 3M A2PEJS', 'MTProt 15N 3M A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3333, 'MTAL 23N 3L RS', 'MTAL 23N 3L RS');
INSERT INTO obras.maestro_estructura VALUES (3215, 'MTProt 15N 3P A2PEJ', 'MTProt 15N 3P A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3216, 'MTProt 15N 3P A2PEJS', 'MTProt 15N 3P A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3217, 'MTProt 23N 3M A2PEJS', 'MTProt 23N 3M A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3218, 'MTProt 23N 3P A2PEJS', 'MTProt 23N 3P A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3219, 'MTCO 15N 2 PS', 'MTCO 15N 2 PS');
INSERT INTO obras.maestro_estructura VALUES (3220, 'MTCO 23N 2 PS', 'MTCO 23N 2 PS');
INSERT INTO obras.maestro_estructura VALUES (3221, 'MTPROT 15N 2 A2RE', 'MTPROT 15N 2 A2RE');
INSERT INTO obras.maestro_estructura VALUES (3222, 'MTPROT 15N 3 A2RE', 'MTPROT 15N 3 A2RE');
INSERT INTO obras.maestro_estructura VALUES (3223, 'MTPROT 23N 2 A2RE', 'MTPROT 23N 2 A2RE');
INSERT INTO obras.maestro_estructura VALUES (3224, 'MTPROT 23N 3 A2RE', 'MTPROT 23N 3 A2RE');
INSERT INTO obras.maestro_estructura VALUES (3225, 'CAl 235.8 mm2 3ø', 'CAl 235.8 mm2 3ø');
INSERT INTO obras.maestro_estructura VALUES (3226, 'MTProt 23N 3 PC', 'MTProt 23N 3 PC');
INSERT INTO obras.maestro_estructura VALUES (3227, 'MTCO 15N 3 A1TJ', 'MTCO 15N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3228, 'MTCO 23N 3 A1TJ', 'MTCO 23N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3229, 'SCADA DAT-IP (para i', 'SCADA DAT-IP (para i');
INSERT INTO obras.maestro_estructura VALUES (3230, 'MTCO 15N 3 A2PEJS', 'MTCO 15N 3 A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3231, 'MTCO 15N 3 JI', 'MTCO 15N 3 JI');
INSERT INTO obras.maestro_estructura VALUES (3232, 'MTCO 15N 3 RS', 'MTCO 15N 3 RS');
INSERT INTO obras.maestro_estructura VALUES (3233, 'Espaciador CO 15kv', 'Espaciador CO 15kv');
INSERT INTO obras.maestro_estructura VALUES (3234, 'Espaciador CO 25kv', 'Espaciador CO 25kv');
INSERT INTO obras.maestro_estructura VALUES (3235, 'MTProt 15N 2 PCD', 'MTProt 15N 2 PCD');
INSERT INTO obras.maestro_estructura VALUES (3236, 'MTProt 23N 2 PCD', 'MTProt 23N 2 PCD');
INSERT INTO obras.maestro_estructura VALUES (3237, 'CAl 235.8 mm2 2ø', 'CAl 235.8 mm2 2ø');
INSERT INTO obras.maestro_estructura VALUES (3238, 'MTProt 23N 2 A1TJ', 'MTProt 23N 2 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3239, 'MTPROT 23N 2 A1TJS', 'MTPROT 23N 2 A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3240, 'soporte prueba', 'soporte prueba');
INSERT INTO obras.maestro_estructura VALUES (3241, 'Poste SAP', 'Poste SAP');
INSERT INTO obras.maestro_estructura VALUES (3242, 'adic_cond_sap', 'adic_cond_sap');
INSERT INTO obras.maestro_estructura VALUES (3243, 'adic_linea_prueba', 'adic_linea_prueba');
INSERT INTO obras.maestro_estructura VALUES (3244, 'adic_soporte_prueba', 'adic_soporte_prueba');
INSERT INTO obras.maestro_estructura VALUES (3245, 'PRUEBA-BORRAR-POSTE', 'PRUEBA-BORRAR-POSTE');
INSERT INTO obras.maestro_estructura VALUES (3246, 'BORRAR', 'BORRAR');
INSERT INTO obras.maestro_estructura VALUES (3247, 'Prueba SAP', 'Prueba SAP');
INSERT INTO obras.maestro_estructura VALUES (3248, 'prueba7 borrar', 'prueba7 borrar');
INSERT INTO obras.maestro_estructura VALUES (3249, 'E. Control AP 1ø 1s', 'E. Control AP 1ø 1s');
INSERT INTO obras.maestro_estructura VALUES (3250, 'Ferr Lum c/Br 4773', 'Ferr Lum c/Br 4773');
INSERT INTO obras.maestro_estructura VALUES (3251, 'Ferr Lum c/Br 2853', 'Ferr Lum c/Br 2853');
INSERT INTO obras.maestro_estructura VALUES (3252, 'E. Control AP 3ø', 'E. Control AP 3ø');
INSERT INTO obras.maestro_estructura VALUES (3253, 'Ferr Lum p/DRP PC  8', 'Ferr Lum p/DRP PC  8');
INSERT INTO obras.maestro_estructura VALUES (3254, 'Ferr Lum p/DRP PC  9', 'Ferr Lum p/DRP PC  9');
INSERT INTO obras.maestro_estructura VALUES (3255, 'Ferr Lum p/DRP PC 10', 'Ferr Lum p/DRP PC 10');
INSERT INTO obras.maestro_estructura VALUES (3256, 'Ferr Lum p/DRP PC 11', 'Ferr Lum p/DRP PC 11');
INSERT INTO obras.maestro_estructura VALUES (3257, 'E. Control AP 1ø 2s', 'E. Control AP 1ø 2s');
INSERT INTO obras.maestro_estructura VALUES (3258, 'Conect Ampactinho', 'Conect Ampactinho');
INSERT INTO obras.maestro_estructura VALUES (3259, 'Conect Empalme 1C', 'Conect Empalme 1C');
INSERT INTO obras.maestro_estructura VALUES (3260, 'Conect Empalme 2C', 'Conect Empalme 2C');
INSERT INTO obras.maestro_estructura VALUES (3261, 'Conect Empalme 3C', 'Conect Empalme 3C');
INSERT INTO obras.maestro_estructura VALUES (3262, 'Conect Empalme 4C', 'Conect Empalme 4C');
INSERT INTO obras.maestro_estructura VALUES (3263, 'Poste AP Subterraneo', 'Poste AP Subterraneo');
INSERT INTO obras.maestro_estructura VALUES (3264, 'BPea PC9/11.5 70-100', 'BPea PC9/11.5 70-100');
INSERT INTO obras.maestro_estructura VALUES (3265, 'BR 1.5" PC9 100-250', 'BR 1.5" PC9 100-250');
INSERT INTO obras.maestro_estructura VALUES (3266, 'BR 2" PC9 250-400', 'BR 2" PC9 250-400');
INSERT INTO obras.maestro_estructura VALUES (3267, 'BR 1.5" PC11 100-250', 'BR 1.5" PC11 100-250');
INSERT INTO obras.maestro_estructura VALUES (3268, 'BR 2" PC11 250-400', 'BR 2" PC11 250-400');
INSERT INTO obras.maestro_estructura VALUES (3269, 'PMadera 8m', 'PMadera 8m');
INSERT INTO obras.maestro_estructura VALUES (3270, 'TT SPC (C/FLEJE)', 'TT SPC (C/FLEJE)');
INSERT INTO obras.maestro_estructura VALUES (3271, 'TT P (C/FLEJE)', 'TT P (C/FLEJE)');
INSERT INTO obras.maestro_estructura VALUES (3272, 'TT para Caja Empalme', 'TT para Caja Empalme');
INSERT INTO obras.maestro_estructura VALUES (3273, 'TT SPC (C/FLEJE)', 'TT SPC (C/FLEJE)');
INSERT INTO obras.maestro_estructura VALUES (3274, 'TT P (C/FLEJE)', 'TT P (C/FLEJE)');
INSERT INTO obras.maestro_estructura VALUES (3275, 'TT BT PRE (C/FLEJE)', 'TT BT PRE (C/FLEJE)');
INSERT INTO obras.maestro_estructura VALUES (3276, 'TT BT TRAD (C/FLEJE)', 'TT BT TRAD (C/FLEJE)');
INSERT INTO obras.maestro_estructura VALUES (3277, 'TT SPC (C/FLEJE)', 'TT SPC (C/FLEJE)');
INSERT INTO obras.maestro_estructura VALUES (3278, 'CCu 107 mm2  3ø', 'CCu 107 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (3279, 'CCu 127 mm2  3ø', 'CCu 127 mm2  3ø');
INSERT INTO obras.maestro_estructura VALUES (3280, 'MTProt 15N 3 A1TJ', 'MTProt 15N 3 A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3281, 'MTProt 15N 3P PCD', 'MTProt 15N 3P PCD');
INSERT INTO obras.maestro_estructura VALUES (3282, 'TT 3E P', 'TT 3E P');
INSERT INTO obras.maestro_estructura VALUES (3283, 'MTCO 15N 3 PS', 'MTCO 15N 3 PS');
INSERT INTO obras.maestro_estructura VALUES (3284, 'MTAL 15N 2L A1TE', 'MTAL 15N 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3285, 'MTAL 15N 2L A1TES', 'MTAL 15N 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3286, 'MTAL 15N 2L A1TJ', 'MTAL 15N 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3287, 'MTAL 15N 2L A1TJS', 'MTAL 15N 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3288, 'MTAL 15N 2L A2PEJ', 'MTAL 15N 2L A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3289, 'MTAL 15N 2L A2PEJS', 'MTAL 15N 2L A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3290, 'MTAL 15N 2L A2RA', 'MTAL 15N 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3291, 'MTAL 15N 2L A2RE', 'MTAL 15N 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3292, 'MTAL 15N 2L JA', 'MTAL 15N 2L JA');
INSERT INTO obras.maestro_estructura VALUES (3293, 'MTAL 15N 2L JI', 'MTAL 15N 2L JI');
INSERT INTO obras.maestro_estructura VALUES (3294, 'MTAL 15N 2L RS', 'MTAL 15N 2L RS');
INSERT INTO obras.maestro_estructura VALUES (3295, 'MTAL 15N 3L A1TE', 'MTAL 15N 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3296, 'MTAL 15N 3L A1TES', 'MTAL 15N 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3297, 'MTAL 15N 3L A1TJ', 'MTAL 15N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3298, 'MTAL 15N 3L A1TJS', 'MTAL 15N 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3299, 'MTAL 15N 3P A2PE', 'MTAL 15N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (3300, 'MTAL 15N 3P A2PES', 'MTAL 15N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (3301, 'MTAL 15N 3L A2RA', 'MTAL 15N 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3302, 'MTAL 15N 3L A2RE', 'MTAL 15N 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3303, 'MTAL 15N 3L JA', 'MTAL 15N 3L JA');
INSERT INTO obras.maestro_estructura VALUES (3304, 'MTAL 15N 3L JI', 'MTAL 15N 3L JI');
INSERT INTO obras.maestro_estructura VALUES (3305, 'MTAL 15N 3L RS', 'MTAL 15N 3L RS');
INSERT INTO obras.maestro_estructura VALUES (3306, 'MTAL 15N 3P A1TJ', 'MTAL 15N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3307, 'MTAL 15N 3P A1TJS', 'MTAL 15N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3308, 'MTAL 15N 3P A2RA', 'MTAL 15N 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (3309, 'MTAL 15N 3P JA', 'MTAL 15N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (3310, 'MTAL 15N 3P JI', 'MTAL 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3311, 'MTAL 15N 3P RS', 'MTAL 15N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3312, 'MTAL 23N 2L A1TE', 'MTAL 23N 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3313, 'MTAL 23N 2L A1TES', 'MTAL 23N 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3314, 'MTAL 23N 2L A1TJ', 'MTAL 23N 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3315, 'MTAL 23N 2L A1TJS', 'MTAL 23N 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3316, 'MTAL 23N 2L A2PEJ', 'MTAL 23N 2L A2PEJ');
INSERT INTO obras.maestro_estructura VALUES (3317, 'MTAL 23N 2L A2PEJS', 'MTAL 23N 2L A2PEJS');
INSERT INTO obras.maestro_estructura VALUES (3318, 'MTAL 23N 2L A2RA', 'MTAL 23N 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3319, 'MTAL 23N 2L A2RE', 'MTAL 23N 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3320, 'MTAL 23N 2L JA', 'MTAL 23N 2L JA');
INSERT INTO obras.maestro_estructura VALUES (3321, 'MTAL 23N 2L JI', 'MTAL 23N 2L JI');
INSERT INTO obras.maestro_estructura VALUES (3322, 'MTAL 23N 2L RS', 'MTAL 23N 2L RS');
INSERT INTO obras.maestro_estructura VALUES (3323, 'MTAL 23N 3L A1TE', 'MTAL 23N 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3324, 'MTAL 23N 3L A1TES', 'MTAL 23N 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3325, 'MTAL 23N 3L A1TJ', 'MTAL 23N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3326, 'MTAL 23N 3L A1TJS', 'MTAL 23N 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3327, 'MTAL 23N 3P A2PE', 'MTAL 23N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (3328, 'MTAL 23N 3P A2PES', 'MTAL 23N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (3329, 'MTAL 23N 3L A2RA', 'MTAL 23N 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3330, 'MTAL 23N 3L A2RE', 'MTAL 23N 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3331, 'MTAL 23N 3L JA', 'MTAL 23N 3L JA');
INSERT INTO obras.maestro_estructura VALUES (3332, 'MTAL 23N 3L JI', 'MTAL 23N 3L JI');
INSERT INTO obras.maestro_estructura VALUES (3334, 'MTAL 23N 3P A1TJ', 'MTAL 23N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3335, 'MTAL 23N 3P A1TJS', 'MTAL 23N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3336, 'MTAL 23N 3P A2RA', 'MTAL 23N 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (3337, 'MTAL 23N 3P JA', 'MTAL 23N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (3338, 'MTAL 23N 3P JI', 'MTAL 23N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3339, 'MTAL 23N 3P RS', 'MTAL 23N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3340, 'MTCU 15C 2L A1TE', 'MTCU 15C 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3341, 'MTCU 15C 2L A1TES', 'MTCU 15C 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3342, 'MTCU 15C 2L A1TJ', 'MTCU 15C 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3343, 'MTCU 15C 2L A1TJS', 'MTCU 15C 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3344, 'MTCU 15C 2L A2RA', 'MTCU 15C 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3345, 'MTCU 15C 2L A2RE', 'MTCU 15C 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3346, 'MTCU 15C 2L JA', 'MTCU 15C 2L JA');
INSERT INTO obras.maestro_estructura VALUES (3347, 'MTCU 15C 2L JI', 'MTCU 15C 2L JI');
INSERT INTO obras.maestro_estructura VALUES (3348, 'MTCU 15C 2L RS', 'MTCU 15C 2L RS');
INSERT INTO obras.maestro_estructura VALUES (3349, 'MTCU 15C 3L A1TE', 'MTCU 15C 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3350, 'MTCU 15C 3L A1TES', 'MTCU 15C 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3351, 'MTCU 15C 3L A1TJ', 'MTCU 15C 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3352, 'MTCU 15C 3L A1TJS', 'MTCU 15C 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3353, 'MTCU 15C 3L A2RA', 'MTCU 15C 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3354, 'MTCU 15C 3L A2RE', 'MTCU 15C 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3355, 'MTCU 15C 3L JA', 'MTCU 15C 3L JA');
INSERT INTO obras.maestro_estructura VALUES (3356, 'MTCU 15C 3L JI', 'MTCU 15C 3L JI');
INSERT INTO obras.maestro_estructura VALUES (3357, 'MTCU 15C 3L RS', 'MTCU 15C 3L RS');
INSERT INTO obras.maestro_estructura VALUES (3358, 'MTCU 15C 3M A1TE', 'MTCU 15C 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (3359, 'MTCU 15C 3M A1TES', 'MTCU 15C 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (3360, 'MTCU 15C 3M A1TJ', 'MTCU 15C 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3361, 'MTCU 15C 3M A1TJS', 'MTCU 15C 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3362, 'MTCU 15C 3M A2PE', 'MTCU 15C 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (3363, 'MTCU 15C 3M A2PES', 'MTCU 15C 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (3364, 'MTCU 15C 3M A2RA', 'MTCU 15C 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (3365, 'MTCU 15C 3M A2RE', 'MTCU 15C 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (3366, 'MTCU 15C 3M JA', 'MTCU 15C 3M JA');
INSERT INTO obras.maestro_estructura VALUES (3367, 'MTCU 15C 3M JI', 'MTCU 15C 3M JI');
INSERT INTO obras.maestro_estructura VALUES (3368, 'MTCU 15C 3M RS', 'MTCU 15C 3M RS');
INSERT INTO obras.maestro_estructura VALUES (3369, 'MTCU 15C 3P A1TJ', 'MTCU 15C 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3370, 'MTCU 15C 3P A1TJS', 'MTCU 15C 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3371, 'MTCU 15C 3P A2PE', 'MTCU 15C 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (3372, 'MTCU 15C 3P A2PES', 'MTCU 15C 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (3373, 'MTCU 15C 3P A2RA', 'MTCU 15C 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (3374, 'MTCU 15C 3P JA', 'MTCU 15C 3P JA');
INSERT INTO obras.maestro_estructura VALUES (3375, 'MTCU 15C 3P JI', 'MTCU 15C 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3376, 'MTCU 15C 3P RS', 'MTCU 15C 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3377, 'MTCU 15E 2L A1TE', 'MTCU 15E 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3378, 'MTCU 15E 2L A1TES', 'MTCU 15E 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3379, 'MTCU 15E 2L A1TJ', 'MTCU 15E 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3380, 'MTCU 15E 2L A1TJS', 'MTCU 15E 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3381, 'MTCU 15E 2L A2RA', 'MTCU 15E 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3382, 'MTCU 15E 2L A2RE', 'MTCU 15E 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3383, 'MTCU 15E 2L JA', 'MTCU 15E 2L JA');
INSERT INTO obras.maestro_estructura VALUES (3384, 'MTCU 15E 2L JI', 'MTCU 15E 2L JI');
INSERT INTO obras.maestro_estructura VALUES (3385, 'MTCU 15E 2L RS', 'MTCU 15E 2L RS');
INSERT INTO obras.maestro_estructura VALUES (3386, 'MTCU 15E 3L A1TE', 'MTCU 15E 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3387, 'MTCU 15E 3L A1TES', 'MTCU 15E 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3388, 'MTCU 15E 3L A1TJ', 'MTCU 15E 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3389, 'MTCU 15E 3L A1TJS', 'MTCU 15E 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3390, 'MTCU 15E 3L A2RA', 'MTCU 15E 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3391, 'MTCU 15E 3L A2RE', 'MTCU 15E 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3392, 'MTCU 15E 3L JA', 'MTCU 15E 3L JA');
INSERT INTO obras.maestro_estructura VALUES (3393, 'MTCU 15E 3L JI', 'MTCU 15E 3L JI');
INSERT INTO obras.maestro_estructura VALUES (3394, 'MTCU 15E 3L RS', 'MTCU 15E 3L RS');
INSERT INTO obras.maestro_estructura VALUES (3395, 'MTCU 15E 3M A1TE', 'MTCU 15E 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (3396, 'MTCU 15E 3M A1TES', 'MTCU 15E 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (3397, 'MTCU 15E 3M A1TJ', 'MTCU 15E 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3398, 'MTCU 15E 3M A1TJS', 'MTCU 15E 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3399, 'MTCU 15E 3M A2PE', 'MTCU 15E 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (3400, 'MTCU 15E 3M A2PES', 'MTCU 15E 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (3401, 'MTCU 15E 3M A2RA', 'MTCU 15E 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (3402, 'MTCU 15E 3M A2RE', 'MTCU 15E 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (3403, 'MTCU 15E 3M JA', 'MTCU 15E 3M JA');
INSERT INTO obras.maestro_estructura VALUES (3404, 'MTCU 15E 3M JI', 'MTCU 15E 3M JI');
INSERT INTO obras.maestro_estructura VALUES (3405, 'MTCU 15E 3M RS', 'MTCU 15E 3M RS');
INSERT INTO obras.maestro_estructura VALUES (3406, 'MTCU 15E 3P A1TJ', 'MTCU 15E 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3407, 'MTCU 15E 3P A1TJS', 'MTCU 15E 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3408, 'MTCU 15E 3P A2PE', 'MTCU 15E 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (3409, 'MTCU 15E 3P A2PES', 'MTCU 15E 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (3410, 'MTCU 15E 3P A2RA', 'MTCU 15E 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (3411, 'MTCU 15E 3P JA', 'MTCU 15E 3P JA');
INSERT INTO obras.maestro_estructura VALUES (3412, 'MTCU 15E 3P JI', 'MTCU 15E 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3413, 'MTCU 15E 3P RS', 'MTCU 15E 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3414, 'MTCU 15N 2L A1TE', 'MTCU 15N 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3415, 'MTCU 15N 2L A1TES', 'MTCU 15N 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3416, 'MTCU 15N 2L A1TJ', 'MTCU 15N 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3417, 'MTCU 15N 2L A1TJS', 'MTCU 15N 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3418, 'MTCU 15N 2L A2RA', 'MTCU 15N 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3419, 'MTCU 15N 2L A2RE', 'MTCU 15N 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3420, 'MTCU 15N 2L JA', 'MTCU 15N 2L JA');
INSERT INTO obras.maestro_estructura VALUES (3421, 'MTCU 15N 2L JI', 'MTCU 15N 2L JI');
INSERT INTO obras.maestro_estructura VALUES (3422, 'MTCU 15N 2L RS', 'MTCU 15N 2L RS');
INSERT INTO obras.maestro_estructura VALUES (3423, 'MTCU 15N 3L A1TE', 'MTCU 15N 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3424, 'MTCU 15N 3L A1TES', 'MTCU 15N 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3425, 'MTCU 15N 3L A1TJ', 'MTCU 15N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3426, 'MTCU 15N 3L A1TJS', 'MTCU 15N 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3427, 'MTCU 15N 3L A2RA', 'MTCU 15N 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3428, 'MTCU 15N 3L A2RE', 'MTCU 15N 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3429, 'MTCU 15N 3L JA', 'MTCU 15N 3L JA');
INSERT INTO obras.maestro_estructura VALUES (3430, 'MTCU 15N 3L JI', 'MTCU 15N 3L JI');
INSERT INTO obras.maestro_estructura VALUES (3431, 'MTCU 15N 3L RS', 'MTCU 15N 3L RS');
INSERT INTO obras.maestro_estructura VALUES (3432, 'MTCU 15N 3M A1TE', 'MTCU 15N 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (3433, 'MTCU 15N 3M A1TES', 'MTCU 15N 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (3434, 'MTCU 15N 3M A1TJ', 'MTCU 15N 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3435, 'MTCU 15N 3M A1TJS', 'MTCU 15N 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3436, 'MTCU 15N 3M A2PE', 'MTCU 15N 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (3437, 'MTCU 15N 3M A2PES', 'MTCU 15N 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (3438, 'MTCU 15N 3M A2RA', 'MTCU 15N 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (3439, 'MTCU 15N 3M A2RE', 'MTCU 15N 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (3440, 'MTCU 15N 3M JA', 'MTCU 15N 3M JA');
INSERT INTO obras.maestro_estructura VALUES (3441, 'MTCU 15N 3M JI', 'MTCU 15N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (3442, 'MTCU 15N 3M RS', 'MTCU 15N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (3443, 'MTCU 15N 3P A1TJ', 'MTCU 15N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3444, 'MTCU 15N 3P A1TJS', 'MTCU 15N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3445, 'MTCU 15N 3P A2PE', 'MTCU 15N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (3446, 'MTCU 15N 3P A2PES', 'MTCU 15N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (3447, 'MTCU 15N 3P A2RA', 'MTCU 15N 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (3448, 'MTCU 15N 3P JA', 'MTCU 15N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (3449, 'MTCU 15N 3P JI', 'MTCU 15N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3450, 'MTCU 15N 3P RS', 'MTCU 15N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3451, 'MTCU 23N 2L A1TE', 'MTCU 23N 2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3452, 'MTCU 23N 2L A1TES', 'MTCU 23N 2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3453, 'MTCU 23N 2L A1TJ', 'MTCU 23N 2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3454, 'MTCU 23N 2L A1TJS', 'MTCU 23N 2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3455, 'MTCU 23N 2L A2RA', 'MTCU 23N 2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3456, 'MTCU 23N 2L A2RE', 'MTCU 23N 2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3457, 'MTCU 23N 2L JA', 'MTCU 23N 2L JA');
INSERT INTO obras.maestro_estructura VALUES (3458, 'MTCU 23N 2L JI', 'MTCU 23N 2L JI');
INSERT INTO obras.maestro_estructura VALUES (3459, 'MTCU 23N 2L RS', 'MTCU 23N 2L RS');
INSERT INTO obras.maestro_estructura VALUES (3460, 'MTCU 23N 3L A1TE', 'MTCU 23N 3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3461, 'MTCU 23N 3L A1TES', 'MTCU 23N 3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3462, 'MTCU 23N 3L A1TJ', 'MTCU 23N 3L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3463, 'MTCU 23N 3L A1TJS', 'MTCU 23N 3L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3464, 'MTCU 23N 3L A2RA', 'MTCU 23N 3L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3465, 'MTCU 23N 3L A2RE', 'MTCU 23N 3L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3466, 'MTCU 23N 3L JA', 'MTCU 23N 3L JA');
INSERT INTO obras.maestro_estructura VALUES (3467, 'MTCU 23N 3L JI', 'MTCU 23N 3L JI');
INSERT INTO obras.maestro_estructura VALUES (3468, 'MTCU 23N 3L RS', 'MTCU 23N 3L RS');
INSERT INTO obras.maestro_estructura VALUES (3469, 'MTCU 23N 3M A1TE', 'MTCU 23N 3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (3470, 'MTCU 23N 3M A1TES', 'MTCU 23N 3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (3471, 'MTCU 23N 3M A1TJ', 'MTCU 23N 3M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3472, 'MTCU 23N 3M A1TJS', 'MTCU 23N 3M A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3473, 'MTCU 23N 3M A2PE', 'MTCU 23N 3M A2PE');
INSERT INTO obras.maestro_estructura VALUES (3474, 'MTCU 23N 3M A2PES', 'MTCU 23N 3M A2PES');
INSERT INTO obras.maestro_estructura VALUES (3475, 'MTCU 23N 3M A2RA', 'MTCU 23N 3M A2RA');
INSERT INTO obras.maestro_estructura VALUES (3476, 'MTCU 23N 3M A2RE', 'MTCU 23N 3M A2RE');
INSERT INTO obras.maestro_estructura VALUES (3477, 'MTCU 23N 3M JA', 'MTCU 23N 3M JA');
INSERT INTO obras.maestro_estructura VALUES (3478, 'MTCU 23N 3M JI', 'MTCU 23N 3M JI');
INSERT INTO obras.maestro_estructura VALUES (3479, 'MTCU 23N 3M RS', 'MTCU 23N 3M RS');
INSERT INTO obras.maestro_estructura VALUES (3480, 'MTCU 23N 3P A1TJ', 'MTCU 23N 3P A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3481, 'MTCU 23N 3P A1TJS', 'MTCU 23N 3P A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3482, 'MTCU 23N 3P A2PE', 'MTCU 23N 3P A2PE');
INSERT INTO obras.maestro_estructura VALUES (3483, 'MTCU 23N 3P A2PES', 'MTCU 23N 3P A2PES');
INSERT INTO obras.maestro_estructura VALUES (3484, 'MTCU 23N 3P A2RA', 'MTCU 23N 3P A2RA');
INSERT INTO obras.maestro_estructura VALUES (3485, 'MTCU 23N 3P JA', 'MTCU 23N 3P JA');
INSERT INTO obras.maestro_estructura VALUES (3486, 'MTCU 23N 3P JI', 'MTCU 23N 3P JI');
INSERT INTO obras.maestro_estructura VALUES (3487, 'MTCU 23N 3P RS', 'MTCU 23N 3P RS');
INSERT INTO obras.maestro_estructura VALUES (3488, 'MTCU 15N 3L JP', 'MTCU 15N 3L JP');
INSERT INTO obras.maestro_estructura VALUES (3489, 'MTCU 15N 3M JP', 'MTCU 15N 3M JP');
INSERT INTO obras.maestro_estructura VALUES (3490, 'MTCU 15N 3P JP', 'MTCU 15N 3P JP');
INSERT INTO obras.maestro_estructura VALUES (3491, 'MTCU 15C 3L JP', 'MTCU 15C 3L JP');
INSERT INTO obras.maestro_estructura VALUES (3492, 'MTCU 15C 3M JP', 'MTCU 15C 3M JP');
INSERT INTO obras.maestro_estructura VALUES (3493, 'MTCU 15C 3P JP', 'MTCU 15C 3P JP');
INSERT INTO obras.maestro_estructura VALUES (3494, 'MTCU 15E 3L JP', 'MTCU 15E 3L JP');
INSERT INTO obras.maestro_estructura VALUES (3495, 'MTCU 15E 3M JP', 'MTCU 15E 3M JP');
INSERT INTO obras.maestro_estructura VALUES (3496, 'MTCU 15E 3P JP', 'MTCU 15E 3P JP');
INSERT INTO obras.maestro_estructura VALUES (3497, 'MTAL 15N 3L JP', 'MTAL 15N 3L JP');
INSERT INTO obras.maestro_estructura VALUES (3498, 'MTAL 15N 3P JP', 'MTAL 15N 3P JP');
INSERT INTO obras.maestro_estructura VALUES (3499, 'MTCU 23N 3L JP', 'MTCU 23N 3L JP');
INSERT INTO obras.maestro_estructura VALUES (3500, 'MTCU 23N 3M JP', 'MTCU 23N 3M JP');
INSERT INTO obras.maestro_estructura VALUES (3501, 'MTCU 23N 3P JP', 'MTCU 23N 3P JP');
INSERT INTO obras.maestro_estructura VALUES (3502, 'MTAL 23N 3L JP', 'MTAL 23N 3L JP');
INSERT INTO obras.maestro_estructura VALUES (3503, 'MTAL 23N 3P JP', 'MTAL 23N 3P JP');
INSERT INTO obras.maestro_estructura VALUES (3504, 'MTCU 15N 2L JP', 'MTCU 15N 2L JP');
INSERT INTO obras.maestro_estructura VALUES (3505, 'MTCU 15C 2L JP', 'MTCU 15C 2L JP');
INSERT INTO obras.maestro_estructura VALUES (3506, 'MTCU 15E 2L JP', 'MTCU 15E 2L JP');
INSERT INTO obras.maestro_estructura VALUES (3507, 'MTAL 15N 2L JP', 'MTAL 15N 2L JP');
INSERT INTO obras.maestro_estructura VALUES (3508, 'MTCU 23N 2L JP', 'MTCU 23N 2L JP');
INSERT INTO obras.maestro_estructura VALUES (3509, 'MTAL 23N 2L JP', 'MTAL 23N 2L JP');
INSERT INTO obras.maestro_estructura VALUES (3510, 'MTCU 15N 3M JIA', 'MTCU 15N 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (3511, 'MTCU 15N 3P JIA', 'MTCU 15N 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (3512, 'MTCU 15C 3M JIA', 'MTCU 15C 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (3513, 'MTCU 15C 3P JIA', 'MTCU 15C 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (3514, 'MTCU 23N 3M JIA', 'MTCU 23N 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (3515, 'MTCU 23N 3P JIA', 'MTCU 23N 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (3516, 'MTAL 15N 3L JIA', 'MTAL 15N 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (3517, 'MTAL 15N 3P JIA', 'MTAL 15N 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (3518, 'MTAL 23N 3L JIA', 'MTAL 23N 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (3519, 'MTAL 23N 3P JIA', 'MTAL 23N 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (3520, 'MTCU 15E 3M JIA', 'MTCU 15E 3M JIA');
INSERT INTO obras.maestro_estructura VALUES (3521, 'MTCU 15E 3P JIA', 'MTCU 15E 3P JIA');
INSERT INTO obras.maestro_estructura VALUES (3522, 'MTCU 15C 3L JIA', 'MTCU 15C 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (3523, 'MTCU 15N 3L JIA', 'MTCU 15N 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (3524, 'MTCU 23N 3L JIA', 'MTCU 23N 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (3525, 'MTCU 15E 3L JIA', 'MTCU 15E 3L JIA');
INSERT INTO obras.maestro_estructura VALUES (3526, 'MTCU 15E 3/2L A1TJS', 'MTCU 15E 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3527, 'MTCU 15E 3/2L A1TJ', 'MTCU 15E 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3528, 'MTCU 15E 3/2L A1TES', 'MTCU 15E 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3529, 'MTCU 15E 3/2L A1TE', 'MTCU 15E 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3530, 'MTAL 23N 3/2L A1TE', 'MTAL 23N 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3531, 'MTAL 23N 3/2L A1TES', 'MTAL 23N 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3532, 'MTAL 23N 3/2L A1TJ', 'MTAL 23N 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3533, 'MTAL 23N 3/2L A1TJS', 'MTAL 23N 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3534, 'MTCU 15C 3/2L A1TES', 'MTCU 15C 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3535, 'MTCU 15C 3/2L A1TJS', 'MTCU 15C 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3536, 'MTCU 15N 3/2L A1TES', 'MTCU 15N 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3537, 'MTCU 15N 3/2L A1TJS', 'MTCU 15N 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3538, 'MTCU 23N 3/2L A1TES', 'MTCU 23N 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3539, 'MTCU 23N 3/2L A1TJS', 'MTCU 23N 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3540, 'MTCU 15N 3/2L A1TE', 'MTCU 15N 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3541, 'MTCU 15N 3/2L A1TJ', 'MTCU 15N 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3542, 'MTCU 15N 3/2M A1TJ', 'MTCU 15N 3/2M A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3543, 'MTCU 15C 3/2L A1TE', 'MTCU 15C 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3544, 'MTCU 15C 3/2L A1TJ', 'MTCU 15C 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3545, 'MTCU 23N 3/2L A1TE', 'MTCU 23N 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3546, 'MTCU 23N 3/2L A1TJ', 'MTCU 23N 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3547, 'MTAL 15N 3/2L A1TE', 'MTAL 15N 3/2L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3548, 'MTAL 15N 3/2L A1TES', 'MTAL 15N 3/2L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3549, 'MTAL 15N 3/2L A1TJ', 'MTAL 15N 3/2L A1TJ');
INSERT INTO obras.maestro_estructura VALUES (3550, 'MTAL 15N 3/2L A1TJS', 'MTAL 15N 3/2L A1TJS');
INSERT INTO obras.maestro_estructura VALUES (3551, 'MTCU 15E 3/2L A2RA', 'MTCU 15E 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3552, 'MTAL 23N 3/2L A2RA', 'MTAL 23N 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3553, 'MTCU 15N 3/2L A2RA', 'MTCU 15N 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3554, 'MTCU 15C 3/2L A2RA', 'MTCU 15C 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3555, 'MTCU 23N 3/2L A2RA', 'MTCU 23N 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3556, 'MTAL 15N 3/2L A2RA', 'MTAL 15N 3/2L A2RA');
INSERT INTO obras.maestro_estructura VALUES (3557, 'MTCU 15E 3/2L A2RE', 'MTCU 15E 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3558, 'MTAL 23N 3/2L A2RE', 'MTAL 23N 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3559, 'MTCU 15N 3/2L A2RE', 'MTCU 15N 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3560, 'MTCU 15C 3/2L A2RE', 'MTCU 15C 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3561, 'MTCU 23N 3/2L A2RE', 'MTCU 23N 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3562, 'MTAL 15N 3/2L A2RE', 'MTAL 15N 3/2L A2RE');
INSERT INTO obras.maestro_estructura VALUES (3563, 'MTCU 15E 2/3L A1TE', 'MTCU 15E 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3564, 'MTCU 15E 2/3M A1TE', 'MTCU 15E 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (3565, 'MTAL 23N 2/3L A1TE', 'MTAL 23N 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3566, 'MTCU 15N 2/3L A1TE', 'MTCU 15N 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3567, 'MTCU 15N 2/3M A1TE', 'MTCU 15N 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (3568, 'MTCU 15C 2/3L A1TE', 'MTCU 15C 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3569, 'MTCU 15C 2/3M A1TE', 'MTCU 15C 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (3570, 'MTCU 23N 2/3L A1TE', 'MTCU 23N 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3571, 'MTCU 23N 2/3M A1TE', 'MTCU 23N 2/3M A1TE');
INSERT INTO obras.maestro_estructura VALUES (3572, 'MTAL 15N 2/3L A1TE', 'MTAL 15N 2/3L A1TE');
INSERT INTO obras.maestro_estructura VALUES (3573, 'MTAL 15N 2/3L A1TES', 'MTAL 15N 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3574, 'MTAL 23N 2/3L A1TES', 'MTAL 23N 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3575, 'MTCU 15C 2/3L A1TES', 'MTCU 15C 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3576, 'MTCU 15C 2/3M A1TES', 'MTCU 15C 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (3577, 'MTCU 15E 2/3L A1TES', 'MTCU 15E 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3578, 'MTCU 15E 2/3M A1TES', 'MTCU 15E 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (3579, 'MTCU 15N 2/3L A1TES', 'MTCU 15N 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3580, 'MTCU 15N 2/3M A1TES', 'MTCU 15N 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (3581, 'MTCU 23N 2/3L A1TES', 'MTCU 23N 2/3L A1TES');
INSERT INTO obras.maestro_estructura VALUES (3582, 'MTCU 23N 2/3M A1TES', 'MTCU 23N 2/3M A1TES');
INSERT INTO obras.maestro_estructura VALUES (3583, 'MTCU 23N 3P A2RE', 'MTCU 23N 3P A2RE');
INSERT INTO obras.maestro_estructura VALUES (3584, 'Anclaje Scada', 'Anclaje Scada');
INSERT INTO obras.maestro_estructura VALUES (3585, 'MTCU 15N 3P JP3PC', 'MTCU 15N 3P JP3PC');


--
-- TOC entry 3854 (class 0 OID 386175)
-- Dependencies: 287
-- Data for Name: maestro_materiales; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.maestro_materiales VALUES (40760, 'CABLE', 'CABLE 2AWG/33,63MM2 AL ALE 6201 AAAC', 4);
INSERT INTO obras.maestro_materiales VALUES (7562, 'EXTEN', 'EXTENSION 3 MT PARA TORRES TIPO R12', 5);
INSERT INTO obras.maestro_materiales VALUES (37373, 'CRUCE', 'CRUCETA ACERO GALVANIZADO L 80 X 80 X 8', 5);
INSERT INTO obras.maestro_materiales VALUES (18543, 'POSTE', 'POSTE MADERA 11.50 MT CLASE 5 F', 5);
INSERT INTO obras.maestro_materiales VALUES (26304, 'RECON', 'RECONEC 1F 13.2-25KV 100 A 125KVBIL FAMI', 5);
INSERT INTO obras.maestro_materiales VALUES (8830, 'CONSO', 'CONSOLA P/BANCO CONDENS MT FIJO-CONTROL', 5);
INSERT INTO obras.maestro_materiales VALUES (8090, 'POSTE', 'POSTE OCTOG REM FE GALV 10,2MT PLANO INF', 5);
INSERT INTO obras.maestro_materiales VALUES (10430, 'CABLE', 'CABLE AL AAAC 312,8 MCM 19 HEBRAS BUTTE', 6);
INSERT INTO obras.maestro_materiales VALUES (10458, 'POSTE', 'POSTE DODEC GALV DB CIR REM VAL V12-2RE1', 5);
INSERT INTO obras.maestro_materiales VALUES (14668, 'CABLE', 'CABLE CU DESN DURO 4 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (17635, 'PERNO', 'PERNO J FE 1/2X12" P/CAÑ 3" C/T-G-TC-MAD', 5);
INSERT INTO obras.maestro_materiales VALUES (10868, 'POSTE', 'POSTE FE MANNESMANN 10 ,0 METROS', 5);
INSERT INTO obras.maestro_materiales VALUES (16498, 'TUERC', 'TUERCA GALV. C/OJO 3/4 "', 5);
INSERT INTO obras.maestro_materiales VALUES (439, 'PERNO', 'PERNO FE GALV CAB HEX 5/8X6X3" C/T', 5);
INSERT INTO obras.maestro_materiales VALUES (61, 'ALAMB', 'ALAMBRE CU DESNUDO DURO 10 MM2', 6);
INSERT INTO obras.maestro_materiales VALUES (15924, 'AMARR', 'AMARRA ALUM DOBLE 4/0 AWG, DBST-1106', 5);
INSERT INTO obras.maestro_materiales VALUES (29924, 'DESCO', 'DESCONECT HIBRI B-PAS 1F S&C 25KV 100A', 5);
INSERT INTO obras.maestro_materiales VALUES (15183, 'SECC ', 'SECC B-CARGA RL 15KV/125KV SF6/SCADA/RTU', 5);
INSERT INTO obras.maestro_materiales VALUES (16089, 'CABLE', 'CABLE CU AISLADO XLP 1X33 MM2 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (23200, 'COMPA', 'COMPACTO MED 3F 15KV 100-200/5A 3 ELEM', 5);
INSERT INTO obras.maestro_materiales VALUES (20881, 'CABLE', 'CABLE PROTEGIDO AAAC 4/0 AWG 25KV HENDRI', 4);
INSERT INTO obras.maestro_materiales VALUES (294, 'GOLIL', 'GOLILLA PLANA FE GALV P/P 5/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (13784, 'PERNO', 'PERNO FE GALV CAB HEX 3/4X9X4" C/T', 5);
INSERT INTO obras.maestro_materiales VALUES (14448, 'TORRE', 'TORRE DE PASO TIPO TJ - CUERPO MEDIO P66', 5);
INSERT INTO obras.maestro_materiales VALUES (17624, 'TORNI', 'TORNILLO ROSCALATA 10 MM X 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (13394, 'SOPOR', 'SOPORTE PASO GALV P/RED COMPACTA, 15KV', 5);
INSERT INTO obras.maestro_materiales VALUES (13611, 'AISLA', 'AISLADOR DISCO 6" SUSPENS ANSI 52-1 CAFE', 5);
INSERT INTO obras.maestro_materiales VALUES (15936, 'PREFO', 'PREFORMADO ATC 17 MB', 5);
INSERT INTO obras.maestro_materiales VALUES (1471, 'SECC ', 'SECC FUS WEBER 3F 400A 500/660V INT /ACC', 5);
INSERT INTO obras.maestro_materiales VALUES (17630, 'GOLIL', 'GOLILLA FE GALV 50X50X5MM Ø22MM (3/4")', 5);
INSERT INTO obras.maestro_materiales VALUES (10859, 'BRAZO', 'BRAZO ANTIBALANCE 15KV', 5);
INSERT INTO obras.maestro_materiales VALUES (7560, 'TORRE', 'TORRE TIPO R12-1', 5);
INSERT INTO obras.maestro_materiales VALUES (14832, 'CABLE', 'CABLE AL PROTEG 1X150 MM2 L.AEREA 25KV', 4);
INSERT INTO obras.maestro_materiales VALUES (13866, 'S/E P', 'S/E PAD MOUNTED, 15KV, 750KVA', 5);
INSERT INTO obras.maestro_materiales VALUES (34045, 'CABLE', 'CABLE CU AISLADO XLPE 35 MM2', 4);
INSERT INTO obras.maestro_materiales VALUES (9570, 'PLACA', 'PLACA ADVERTENCIA "PELIGRO ALTA TENSION"', 5);
INSERT INTO obras.maestro_materiales VALUES (4588, 'CONDU', 'CONDULET P/CAÑERIA CONDUIT 3" TIPO LB', 5);
INSERT INTO obras.maestro_materiales VALUES (9593, 'CONJU', 'CONJUNTO BARRA F/N 20VIA P/CAJA METAL 1F', 8);
INSERT INTO obras.maestro_materiales VALUES (15925, 'AMARR', 'AMARRA ALUM DOBLE 2 AWG, DBST-1101', 5);
INSERT INTO obras.maestro_materiales VALUES (16625, 'DESCO', 'DESCONECT TRIPOLAR 400A.', 5);
INSERT INTO obras.maestro_materiales VALUES (5769, 'ADAPT', 'ADAPTAD ELAST 20MA-F15KV P/1F XLPE 2AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (9041, 'POSTE', 'POSTE HA 2,5MT C/BZO 500 P/CIERRO MALLA', 5);
INSERT INTO obras.maestro_materiales VALUES (16408, 'CONEC', 'CONECT ESTRIBO FARGO GH-282-AL', 5);
INSERT INTO obras.maestro_materiales VALUES (16113, 'CABLE', 'CABLE PROTEGIDO AAAC 2 AWG 15KV HENDRI', 4);
INSERT INTO obras.maestro_materiales VALUES (750, 'CABLE', 'CABLE CU CWELD DESN 7 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (23899, 'ESCUA', 'ESCUADRA SOP P/MOTAJE REG PLANO M-1694-N', 5);
INSERT INTO obras.maestro_materiales VALUES (7614, 'PEINE', 'PEINETA ESPANTAPAJAROS FE GALV', 5);
INSERT INTO obras.maestro_materiales VALUES (10862, 'POSTE', 'POSTE DODEC. ACERO GALV. CIRC. SIMPLE DE V16-1R (H)', 5);
INSERT INTO obras.maestro_materiales VALUES (3667, 'CABLE', 'CABLE AL C/ALMA ACERO ACSR 3/0AWG 7HEBRA', 6);
INSERT INTO obras.maestro_materiales VALUES (6437, 'CODO ', 'CODO ELASTIMOLD 166LRB-5250 15KV 3/0AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (13574, 'ALAMB', 'ALAMBRE CU DESNUDO DURO 10 AWG,5,27MM2', 6);
INSERT INTO obras.maestro_materiales VALUES (748, 'CABLE', 'CABLE CU CWELD DESN 2/0 AWG TIPO G', 6);
INSERT INTO obras.maestro_materiales VALUES (308, 'GRAPA', 'GRAPA ANCL UNIVERSAL P/4-3/0AWG 10000LB', 5);
INSERT INTO obras.maestro_materiales VALUES (14676, 'SECC ', 'SECC ABB SF6 25KV 630A EXT NXB/RTU 523', 5);
INSERT INTO obras.maestro_materiales VALUES (26892, 'POSTE', 'POSTE FE DISTRIPOLE 11,5M 9,5M UTIL 1PZA', 5);
INSERT INTO obras.maestro_materiales VALUES (10792, 'TRAFO', 'TRAFO MED COMP 15KV 8,4-224V 2,5-5-10/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (18349, 'CINTA', 'CINTA AL. BLANDO 7.75MM X 1', 6);
INSERT INTO obras.maestro_materiales VALUES (10459, 'POSTE', 'POSTE DODEC. ACERO GALV. CIRC. SIMPLE DE V18-1R', 5);
INSERT INTO obras.maestro_materiales VALUES (276, 'EXTEN', 'EXTENSION GALV 2,1M P/PTE HORMG 11,5M', 5);
INSERT INTO obras.maestro_materiales VALUES (10849, 'CONDE', 'CONDENSADOR 50KVAR 15KV', 5);
INSERT INTO obras.maestro_materiales VALUES (15967, 'EXTEN', 'EXTENSION FE GALV 1600 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (13896, 'CABLE', 'CABLE MONOP APANTA XLPE 2/0 AWG 25KV', 4);
INSERT INTO obras.maestro_materiales VALUES (17648, 'CABLE', 'CABLE CU AISLADO THHN 300 MCM', 4);
INSERT INTO obras.maestro_materiales VALUES (7629, 'MUERT', 'MUERTO HORMIGON 160KG P/TRACCION 3000KG', 5);
INSERT INTO obras.maestro_materiales VALUES (2314, 'CONEC', 'CONECT SOLDA TER CU-NI REMA ESTAM P/25MM', 5);
INSERT INTO obras.maestro_materiales VALUES (9108, 'CRUCE', 'CRUCETA FE GALV 100X100X10X3110MM', 5);
INSERT INTO obras.maestro_materiales VALUES (523, 'SEGUR', 'SEGURO AEREO LOZA P/EMP EXT 1F 250V 30A', 5);
INSERT INTO obras.maestro_materiales VALUES (14722, 'TRANS', 'TRANSFORMADOR DE POTENCIAL P/23KV, BIL 1', 5);
INSERT INTO obras.maestro_materiales VALUES (277, 'EXTEN', 'EXTENSION GALV 1,15M P/PTE HORMG 11,5M', 5);
INSERT INTO obras.maestro_materiales VALUES (10010, 'CABLE', 'CABLE MONOP APANT ET AISL EPR 2 AWG 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (17452, 'TORRE', 'TORRE DE PASO TIPO TJ CUERPO INFERIOR P6', 5);
INSERT INTO obras.maestro_materiales VALUES (16504, 'SOPOR', 'SOPORTE GALV.1/2 X 321 M/M.', 5);
INSERT INTO obras.maestro_materiales VALUES (4773, 'CRUCE', 'CRUCETA FE GALV 100X150X10X6000MM', 5);
INSERT INTO obras.maestro_materiales VALUES (17651, 'CABLE', 'CABLE CU AISLADO NSYA 16 MM', 4);
INSERT INTO obras.maestro_materiales VALUES (16469, 'DERIV', 'DERIV AL/CU BURNDY 1/0-4/0~6-2/0 YC28U26', 5);
INSERT INTO obras.maestro_materiales VALUES (9997, 'EXTEN', 'EXTENSION 6 MT PARA TORRES TIPO R12', 5);
INSERT INTO obras.maestro_materiales VALUES (16459, 'CONEC', 'CONECTOR TERMINAL PLUG YE25R25 1/0 AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (6560, 'CONJU', 'CONJUNTO AISLADO P/MONTAJE TT.CC TIPO TR', 5);
INSERT INTO obras.maestro_materiales VALUES (861, 'DIAGO', 'DIAGONAL PLANA FE GALV 40X6X900 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (6842, 'MUFA ', 'MUFA TERM BOTA 90° BUS/COR 600A 1F 3/0AW', 8);
INSERT INTO obras.maestro_materiales VALUES (13405, 'POSTE', 'POSTE OCTOG REM P/SECH TURNER 1VIA C/3BZ', 5);
INSERT INTO obras.maestro_materiales VALUES (944, 'INT A', 'INT AUT 3 X 250A 600V 18KA MITSUBISHI', 5);
INSERT INTO obras.maestro_materiales VALUES (13565, 'CABLE', 'CABLE CU AISLADO THHN 1/0 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (17636, 'PERNO', 'PERNO J FE 1/2X12" P/CAÑ 4" C/T-G-TC-MAD', 5);
INSERT INTO obras.maestro_materiales VALUES (12884, 'TORRE', 'TORRE DE ACERO GALVANIZADO TIPO R12-3', 5);
INSERT INTO obras.maestro_materiales VALUES (16489, 'TIRA ', 'TIRA NUM AUTOADHESIVO 0-9 NEGRO/AMARILLO', 7);
INSERT INTO obras.maestro_materiales VALUES (16159, 'MANIL', 'MANILLA P/CAJA INT HY-MAG', 5);
INSERT INTO obras.maestro_materiales VALUES (16369, 'CONEC', 'CONECT COMP T/REC 3M 30036 P/2/0AWG P3/8', 5);
INSERT INTO obras.maestro_materiales VALUES (7835, 'POSTE', 'POSTE HA 15MT REFORZADO C/PUESTA TIERRA', 5);
INSERT INTO obras.maestro_materiales VALUES (8860, 'CABLE', 'CABLE AL ALMA ACERO 2 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (13638, 'ESPIG', 'ESPIGA GALV 3/4 CAP 1" P/CRUCETA METALIC', 5);
INSERT INTO obras.maestro_materiales VALUES (13824, 'POSTE', 'POSTE OCTOG FE GALV 13MT 1410DAN', 5);
INSERT INTO obras.maestro_materiales VALUES (7566, 'SOPOR', 'SOPORTE PASO LARGO P/LUMS, 494MM', 5);
INSERT INTO obras.maestro_materiales VALUES (16503, 'PERNO', 'PERNO OJO 5/8X7"', 5);
INSERT INTO obras.maestro_materiales VALUES (17212, 'SOPOR', 'SOPORTE PASO P/CABLE PROTEGIDO', 5);
INSERT INTO obras.maestro_materiales VALUES (7552, 'CONEC', 'CONECTOR T BR CABLE 1/0-300~1/0-300MCM', 5);
INSERT INTO obras.maestro_materiales VALUES (15725, 'INT A', 'INT AUT LIMITADOR POTENCIA ICP 3 X 25A', 5);
INSERT INTO obras.maestro_materiales VALUES (17858, 'PLETI', 'PLETINA UNIÓN 300X76X6 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (7907, 'MALLA', 'MALLA ALAMBRE GALV #11 C/PLAST.VERDE 2M', 4);
INSERT INTO obras.maestro_materiales VALUES (7976, 'INT 1', 'INT 15KV 200A 240VCA VACIO EXT P/BANCOS', 5);
INSERT INTO obras.maestro_materiales VALUES (14429, 'POSTE', 'POSTE DE CONCRETO PRETENSADO DE 18,0 MT,', 5);
INSERT INTO obras.maestro_materiales VALUES (16361, 'CONEC', 'CONECTOR T BRONCE 4AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (6867, 'REGLE', 'REGLETA 1POL WIEL P/18-8AWG 750/900V 65A', 5);
INSERT INTO obras.maestro_materiales VALUES (4541, 'AISLA', 'AISLADOR DISCO 6" PSADOR CARRAS TE-1052', 5);
INSERT INTO obras.maestro_materiales VALUES (7699, 'PERNO', 'PERNO FE ZINC CAB RED 3/16X1" C/T', 5);
INSERT INTO obras.maestro_materiales VALUES (7085, 'INT A', 'INT AUT 3 X 150A 600V 35KA MITSUBISHI', 5);
INSERT INTO obras.maestro_materiales VALUES (17827, 'IMPUL', 'IMPULSOR AMPACT AMARILLO, CAT. 69338-4', 5);
INSERT INTO obras.maestro_materiales VALUES (20396, 'BRAZO', 'BRAZO ANTIBALANCE 25KV HENDRIX BAS 24F', 5);
INSERT INTO obras.maestro_materiales VALUES (23673, 'CONEC', 'CONECT COMP RECTO CU/SN P/EMPALMES 8 MM2', 5);
INSERT INTO obras.maestro_materiales VALUES (16152, 'CAJA ', 'CAJA EMPALME METALICA 3F C-3-1', 5);
INSERT INTO obras.maestro_materiales VALUES (6015, 'ABRAZ', 'ABRAZADERA MADERA P/SOP 3CBLE 15KV/2AWG', 8);
INSERT INTO obras.maestro_materiales VALUES (10586, 'CABLE', 'CABLE AL PROTEG 1X95 MM2 L.AEREA 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (13770, 'PERNO', 'PERNO J FE 1/2X12" P/CAÑ 2" C/T-G-TC-MAD', 5);
INSERT INTO obras.maestro_materiales VALUES (155, 'CABLE', 'CABLE CONTROL CTT/TCC 3X12 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (747, 'CABLE', 'CABLE CU CWELD DESN 1/0 AWG TIPO G', 6);
INSERT INTO obras.maestro_materiales VALUES (749, 'CABLE', 'CABLE CU CWELD DESN 10 AWG 3 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (16508, 'PORTA', 'PORTA VIGA FE GALV C 100X40X6X496MM', 5);
INSERT INTO obras.maestro_materiales VALUES (10867, 'POSTE', 'POSTE FE MANNESMANN 9 ,0 METROS', 5);
INSERT INTO obras.maestro_materiales VALUES (41885, 'EQUIP', 'EQUIPO DAT-IP C/CPU, MODEM GPRS1218', 5);
INSERT INTO obras.maestro_materiales VALUES (1049, 'PERNO', 'PERNO FE ZINC CAB RED 5X25MM', 5);
INSERT INTO obras.maestro_materiales VALUES (14673, 'CABLE', 'CABLE CU CWELD DESN 8 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (489, 'PRENS', 'PRENSA PARALELA GALVANIZADA PARA TIRANTE', 5);
INSERT INTO obras.maestro_materiales VALUES (13792, 'PERNO', 'PERNO OJO 3/4X17X3"', 5);
INSERT INTO obras.maestro_materiales VALUES (13417, 'ADAPT', 'ADAPTAD P/SEC DBLEVIA POSTE D12-IR-2/3SW', 5);
INSERT INTO obras.maestro_materiales VALUES (6538, 'SECC ', 'SECC FUS PFISTERE EXT 3F 500V 400A OP/1F', 5);
INSERT INTO obras.maestro_materiales VALUES (14698, 'SENSO', 'SENSOR VOLT VMI 15KV P/SCADA MT LINDSEY', 5);
INSERT INTO obras.maestro_materiales VALUES (16000, 'AMARR', 'AMARRA PLASTICA 250 X 4,8 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (105, 'BARRA', 'BARRA GALV P/TIRTE 5/8"X2000MM C/GOL-TUE', 5);
INSERT INTO obras.maestro_materiales VALUES (2, 'TRAFO', 'TRAFO DIST 2F AEREO, 15KV,  5KVA, 1X220V', 5);
INSERT INTO obras.maestro_materiales VALUES (163, 'CAJA ', 'CAJA METAL P/TT.CC Y MEDIDOR', 5);
INSERT INTO obras.maestro_materiales VALUES (17644, 'ALAMB', 'ALAMBRE CU AISLADO NSYA 2,5 MM2 NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (5334, 'PERNO', 'PERNO OJO FE GALV 5/8" P/L-POST HORZ T-A', 5);
INSERT INTO obras.maestro_materiales VALUES (7493, 'PRENS', 'PRENSA-ESTOP PLAS INT P21MM P/10-12MM TC', 5);
INSERT INTO obras.maestro_materiales VALUES (5159, 'CABLE', 'CABLE AL AASC 250 MCM 19 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (13395, 'SOPOR', 'SOPORTE REMATE GALV P/REDES COMPACTAS', 5);
INSERT INTO obras.maestro_materiales VALUES (17646, 'ALAMB', 'ALAMBRE CU AISLADO NYA  6 MM2', 4);
INSERT INTO obras.maestro_materiales VALUES (12914, 'CABLE', 'CABLE APANT NKBA ACEITE 3X25MM2 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (17459, 'CONDE', 'CONDENSAD 1F 100KVAR 8,3KV P/13,2KV CONT', 5);
INSERT INTO obras.maestro_materiales VALUES (19392, 'CONTR', 'CONTROLADOR DIG P/BBCC INTELLI IC-10-BP', 5);
INSERT INTO obras.maestro_materiales VALUES (5811, 'ESPIG', 'ESPIGA GALV BRASS 3/4X1 3/4" P/AIS LPOST', 5);
INSERT INTO obras.maestro_materiales VALUES (7517, 'POSTE', 'POSTE HA PRETEN 18MT TIPO ENDESA', 5);
INSERT INTO obras.maestro_materiales VALUES (15679, 'INT A', 'INT AUT LIMITADOR POTENCIA ICP 3 X 65A', 5);
INSERT INTO obras.maestro_materiales VALUES (10858, 'ESPAC', 'ESPACIADOR POLIMERICO 15KV C/4 AMARRA', 5);
INSERT INTO obras.maestro_materiales VALUES (17841, 'BARRA', 'BARRA 25KV 3 VÍAS', 5);
INSERT INTO obras.maestro_materiales VALUES (450, 'PERNO', 'PERNO FE GALV CAB HEX 5/8X20X3" C/T', 5);
INSERT INTO obras.maestro_materiales VALUES (20880, 'CABLE', 'CABLE PROTEGIDO AAAC 1/0 AWG 25KV HENDRI', 4);
INSERT INTO obras.maestro_materiales VALUES (9228, 'SECC ', 'SECC CUCH BYPASS 1F 25KV 600A ARCRUPTER', 5);
INSERT INTO obras.maestro_materiales VALUES (16724, 'MUFA ', 'MUFA UNION 15KV HVS-1522S-GP CL', 5);
INSERT INTO obras.maestro_materiales VALUES (20161, 'CABLE', 'CABLE CU AISLADO THW 400 MCM', 4);
INSERT INTO obras.maestro_materiales VALUES (9730, 'CONDE', 'CONDENSADOR  150KVAR 15KV COOPER POWER', 5);
INSERT INTO obras.maestro_materiales VALUES (14452, 'TORRE', 'TORRE DE PASO TIPO TJ - EXTENSION P66-E3', 5);
INSERT INTO obras.maestro_materiales VALUES (234, 'CRUCE', 'CRUCETA MADERA 4"X4"X2200MM', 5);
INSERT INTO obras.maestro_materiales VALUES (9019, 'CONTA', 'CONTACTOR HG TRIPOL 60A BOB 220V P/AP', 5);
INSERT INTO obras.maestro_materiales VALUES (17824, 'CONEC', 'CONECTOR UDC TIPO III 881785-1 ROJO', 5);
INSERT INTO obras.maestro_materiales VALUES (5768, 'CODO ', 'CODO ELASTIMOLD 166LRB-5220 15KV 2AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (13349, 'CABLE', 'CABLE AL PROTEG 1X150 MM2 L.AEREA 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (5335, 'PERNO', 'PERNO OJO FE GALV 5/8" P/L-POST HORZ T-B', 5);
INSERT INTO obras.maestro_materiales VALUES (3462, 'CABLE', 'CABLE CU AISLADO THW 300 MCM', 4);
INSERT INTO obras.maestro_materiales VALUES (12888, 'TORRE', 'TORRE DE ACERO GALVANIZADO TIPO TB1', 5);
INSERT INTO obras.maestro_materiales VALUES (13704, 'S/E U', 'S/E UNITARIA, 13.200/400 V, 1500KVA', 5);
INSERT INTO obras.maestro_materiales VALUES (6247, 'TUBO ', 'TUBO CONDUIT 75MM CLASE II', 4);
INSERT INTO obras.maestro_materiales VALUES (34044, 'CABLE', 'CABLE CU AISLADO XLPE 70 MM2', 4);
INSERT INTO obras.maestro_materiales VALUES (17749, 'CONDU', 'CONDULET P/CAÑERIA 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (21983, 'CABLE', 'CABLE CU CWELD DESN 2 AWG', 6);
INSERT INTO obras.maestro_materiales VALUES (14451, 'TORRE', 'TORRE DE PASO TIPO TJ - EXTENSION P66-E2', 5);
INSERT INTO obras.maestro_materiales VALUES (6087, 'MUFA ', 'MUFA TRANSICION 15KV 1F 2AWG/3F 16-25MM', 9);
INSERT INTO obras.maestro_materiales VALUES (13348, 'PLATA', 'PLATAFORMA OPERACION P/SECCH PTE OCTOG', 5);
INSERT INTO obras.maestro_materiales VALUES (10554, 'POSTE', 'POSTE OCTOGONAL REMATE DE ACERO GALV., D', 5);
INSERT INTO obras.maestro_materiales VALUES (19070, 'INT A', 'INT AUT 3 X 225A NF-250-CW MITSUBISHI', 5);
INSERT INTO obras.maestro_materiales VALUES (3153, 'HUINC', 'HUINCHA AISLADORA 3M 23 3/4X9100X0,76MM', 10);
INSERT INTO obras.maestro_materiales VALUES (13558, 'CABLE', 'CABLE CU AISLADO NSYA 70 MM2 NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (5599, 'CRUCE', 'CRUCETA MADERA 4"X5"X2200MM', 5);
INSERT INTO obras.maestro_materiales VALUES (7613, 'GRILL', 'GRILLETE RECTO 16 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (10432, 'TORRE', 'TORRE PORTANTE TIPO P12-2M1', 5);
INSERT INTO obras.maestro_materiales VALUES (16707, 'INT A', 'INT ACEITE G.F.3.', 5);
INSERT INTO obras.maestro_materiales VALUES (24082, 'ESPIG', 'ESPIGA GALV 3/4"X220MM CAP 1" P/C-METAL', 5);
INSERT INTO obras.maestro_materiales VALUES (13791, 'PERNO', 'PERNO OJO 3/4X15X12"', 5);
INSERT INTO obras.maestro_materiales VALUES (14786, 'CABLE', 'CABLE 10M C/CONEC ITT P/SENS CVMI LINDSE', 5);
INSERT INTO obras.maestro_materiales VALUES (5377, 'ALAMB', 'ALAMBRE CU AISLADO PI O PW 8 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (10871, 'POSTE', 'POSTE RIEL 9,0 METROS', 5);
INSERT INTO obras.maestro_materiales VALUES (10433, 'TORRE', 'TORRE TIPO R12-2M', 5);
INSERT INTO obras.maestro_materiales VALUES (7165, 'SOPOR', 'SOPORTE AISLADOR L-POST VERT 890MM', 5);
INSERT INTO obras.maestro_materiales VALUES (20979, 'POSTE', 'POSTE PINO RADIATA IMPREG 70 PIE CALSE 1', 5);
INSERT INTO obras.maestro_materiales VALUES (3659, 'CAJA ', 'CAJA METALICA GALV 600X300X400 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (945, 'INT A', 'INT AUT 3 X 400A 600V 35KA MITSUBISHI', 5);
INSERT INTO obras.maestro_materiales VALUES (9011, 'PORTA', 'PORTA-PELDAÑO P/POSTE DISPOSIC VERTICAL', 5);
INSERT INTO obras.maestro_materiales VALUES (17863, 'PERNO', 'PERNO OJO 3/4X17X13"', 5);
INSERT INTO obras.maestro_materiales VALUES (185, 'CAÑER', 'CAÑERIA GALV ASTM 1 1/2"', 4);
INSERT INTO obras.maestro_materiales VALUES (16497, 'ESLAB', 'ESLABON REMATE ATC 17 WE', 5);
INSERT INTO obras.maestro_materiales VALUES (5520, 'TRANS', 'TRANSFORMADOR DE MEDIDA COMPACTO TRIFASICO 25KV 10-20/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (10800, 'POSTE', 'POSTE DODEC GALV DB CIRC REM HYU V16-2RE', 5);
INSERT INTO obras.maestro_materiales VALUES (16091, 'CABLE', 'CABLE SECO 1 X 70, CLASE 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (10856, 'PERFI', 'PERFIL L 40X40X4MM ACERO A37-24ES', 5);
INSERT INTO obras.maestro_materiales VALUES (23054, 'MUFA ', 'MUFA DERV 2-1AWG HVSY-1521-SC 15KV', 5);
INSERT INTO obras.maestro_materiales VALUES (5582, 'BASE ', 'BASE METAL PORTA-INT-AUTO P/CAJ-EMP 7010', 5);
INSERT INTO obras.maestro_materiales VALUES (10524, 'PERNO', 'PERNO FE GALV CAB HEX 3/4X9X3" C/T', 5);
INSERT INTO obras.maestro_materiales VALUES (15923, 'AMARR', 'AMARRA ALUM DOBLE 1/0 AWG, DBST-1103', 5);
INSERT INTO obras.maestro_materiales VALUES (2002, 'RESIS', 'RESISTENCIA P/TRANSC MOTOROLA PT-200', 5);
INSERT INTO obras.maestro_materiales VALUES (7168, 'DIAGO', 'DIAGONAL PLANA FE GALV 40X6X810 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (13731, 'TORRE', 'TORRE PORTANTE TIPO P12-2M2', 5);
INSERT INTO obras.maestro_materiales VALUES (1, 'TRAFO', 'TRAFO DIST 2F AEREO, 15KV, 3KVA, 1X220V', 5);
INSERT INTO obras.maestro_materiales VALUES (771, 'CABLE', 'CABLE APANT BICC ACEITE 25 MM2 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (9729, 'CONDE', 'CONDENSADOR 100KVAR 125KVBIL 10KA COOPER', 5);
INSERT INTO obras.maestro_materiales VALUES (18, 'TRAFO', 'TRAFO DIST 3F AEREO, 15KV, 150KVA', 5);
INSERT INTO obras.maestro_materiales VALUES (3480, 'CABLE', 'CABLE APANT BICC ACEITE 95 MM2 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (7034, 'PERNO', 'PERNO COCHE FE GALV. 1/2"X8"', 5);
INSERT INTO obras.maestro_materiales VALUES (34043, 'CABLE', 'CABLE CU AISLADO XLPE 120 MM2', 4);
INSERT INTO obras.maestro_materiales VALUES (15903, 'DESCO', 'DESCONECTADOR BAJO CARGAOMNI-RUPTER', 5);
INSERT INTO obras.maestro_materiales VALUES (10440, 'CABLE', 'CABLE AL AAAC 2 AWG 7 HEBRAS AMES', 6);
INSERT INTO obras.maestro_materiales VALUES (12890, 'TORRE', 'TORRE DE ACERO GALVANIZADO TIPO TD', 5);
INSERT INTO obras.maestro_materiales VALUES (16148, 'PLETI', 'PLETINA PARA CAJA SPB1 TIPO "T"', 5);
INSERT INTO obras.maestro_materiales VALUES (16117, 'CAJA ', 'CAJA MONTAJE SPB1  HY-MAG', 5);
INSERT INTO obras.maestro_materiales VALUES (777, 'CABLE', 'CABLE APANT BICCACEITE 150 MM2 22KV', 4);
INSERT INTO obras.maestro_materiales VALUES (10850, 'CONDE', 'CONDENSADOR 88,7KVAR 15KV', 5);
INSERT INTO obras.maestro_materiales VALUES (6580, 'GOLIL', 'GOLILLA PLANA FE GALV 80X80X10 P/TTE 3/4', 5);
INSERT INTO obras.maestro_materiales VALUES (14430, 'SECC ', 'SECC CUCH S&C 34,5KV 900A POLE-TOP BC', 5);
INSERT INTO obras.maestro_materiales VALUES (10861, 'ALAMB', 'ALAMBRE CU DESNUDO DURO 8 MM2', 6);
INSERT INTO obras.maestro_materiales VALUES (15965, 'POSTE', 'POSTE HA 15MT', 5);
INSERT INTO obras.maestro_materiales VALUES (9937, 'CABLE', 'CABLE CU AISLADO THW 8 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (13767, 'ESPIG', 'ESPIGA GALV 3/4X250X1.3/8 P/CRUCE MADERA', 5);
INSERT INTO obras.maestro_materiales VALUES (18108, 'PREFO', 'PREFORMADA RETENCION MOD ND-0114, PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (7435, 'SOPOR', 'SOPORTE FE GALV P/LINE POST HORIZ 66KV R', 5);
INSERT INTO obras.maestro_materiales VALUES (10525, 'CABLE', 'CABLE MONOP APANT XLPE 120 MM2 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (14367, 'SOPOR', 'SOPORTE FE GALV P/AISL POST HOR C/EPIGA', 5);
INSERT INTO obras.maestro_materiales VALUES (14422, 'TORRE', 'TORRE TIPO R12-1A (SEGUN PLANO 9958-A1)', 5);
INSERT INTO obras.maestro_materiales VALUES (13352, 'RECON', 'RECONECTADOR ELECT. COOPER POWER SYSTEMS', 5);
INSERT INTO obras.maestro_materiales VALUES (10762, 'CABLE', 'CABLE CU AISLADO THW 3 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (19530, 'PAD 2', 'PAD 2230 P/DERV-UNION 15KV 200MMX3M 3M', 5);
INSERT INTO obras.maestro_materiales VALUES (10724, 'CONTR', 'CONTROLADOR DIG P/BCO COND JCC', 5);
INSERT INTO obras.maestro_materiales VALUES (10441, 'CABLE', 'CABLE AL AAAC1/0 AWG 7 HEBRAS AZUSA', 6);
INSERT INTO obras.maestro_materiales VALUES (13831, 'PORTA', 'PORTAFUSIBLE AEREO P/FUSIBLE NEOZED 35A', 5);
INSERT INTO obras.maestro_materiales VALUES (13964, 'ANTEN', 'ANTENA P/RDIOMODE 470-494MHZ YUGI 6 ELEM', 5);
INSERT INTO obras.maestro_materiales VALUES (10462, 'POSTE', 'POSTE DODEC. ACERO GALV. CIRC. SIMPLE DE V12-1RE (V)', 5);
INSERT INTO obras.maestro_materiales VALUES (8271, 'TRAFO', 'TRAFO DIST 3F AEREO 13,2KV 50KVA', 5);
INSERT INTO obras.maestro_materiales VALUES (19583, 'CONDE', 'CONDENSAD 13,2KV 200KVAR 2BUS  22446200K', 5);
INSERT INTO obras.maestro_materiales VALUES (31406, 'CABLE', 'CABLE CU AISLADO XT/XTU/XCS 3 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (15962, 'POSTE', 'POSTE FIERRO CILINDRICO 9,50 M', 5);
INSERT INTO obras.maestro_materiales VALUES (911, 'GOLIL', 'GOLILLA PLANA FE GALV 60X5X60MM P/P 3/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (17784, 'TERMI', 'TERMINAL P/CABLE 2/0 AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (24196, 'S/E P', 'S/E PADMOUN 15KV 1000KVA TAP12 A 15,18KV', 5);
INSERT INTO obras.maestro_materiales VALUES (19224, 'CABLE', 'CABLE CU AISLADO XT/XLPE 1X240 MM2 25KV', 4);
INSERT INTO obras.maestro_materiales VALUES (14956, 'INT 1', 'INT 15KV 200A 240VCA VACIO VCS-1 P/BCO', 5);
INSERT INTO obras.maestro_materiales VALUES (9847, 'ALAMB', 'ALAMBRE AL RECOCIDO P/ATAR # 8 AWG', 6);
INSERT INTO obras.maestro_materiales VALUES (17807, 'CONEC', 'CONECTOR AMP 300-240~185-120M 1-602031-4', 5);
INSERT INTO obras.maestro_materiales VALUES (12889, 'TORRE', 'TORRE DE ACERO GALVANIZADO TIPO TC', 5);
INSERT INTO obras.maestro_materiales VALUES (13943, 'CABLE', 'CABLE CU DESNUDO 1 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (13796, 'PERNO', 'PERNO OJO  5/8X17X3" 3 TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (24081, 'ESPIG', 'ESPIGA GALV 3/4"X220MM CAP 1" P/C-HORMIG', 5);
INSERT INTO obras.maestro_materiales VALUES (10508, 'TRANS', 'TRANSFORMADOR DE MEDIDA COMPACTO TRIFASICO 25KV 40-80/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (13999, 'ADITI', 'ADITIVO GEO GEL', 6);
INSERT INTO obras.maestro_materiales VALUES (6841, 'MUFA ', 'MUFA TERM BOTA 90° BUS/CORTO 600A 1F 2AW', 5);
INSERT INTO obras.maestro_materiales VALUES (5779, 'CONEC', 'CONECT INTERFAS ELASTIM 200A 15KV 1601A4', 5);
INSERT INTO obras.maestro_materiales VALUES (17211, 'SOPOR', 'SOPORTE PASO CON ANGULO', 5);
INSERT INTO obras.maestro_materiales VALUES (774, 'CABLE', 'CABLE APANT ACEITE BICC 1X240 MM2 22KV', 4);
INSERT INTO obras.maestro_materiales VALUES (13570, 'ALAMB', 'ALAMBRE CU DESNUDO DURO 4 AWG,21,2MM2', 6);
INSERT INTO obras.maestro_materiales VALUES (121, 'BRAZO', 'BRAZO CURVO GALV 1" P/LUMIN 70,100,150W', 5);
INSERT INTO obras.maestro_materiales VALUES (9719, 'CAJA ', 'CAJA DIST.EMP.MET. C/CIERRE SEG. P/D.R.P', 5);
INSERT INTO obras.maestro_materiales VALUES (12918, 'POSTE', 'POSTE OCTOG REM P/SEC CUCH TURNER 2/3VIA', 5);
INSERT INTO obras.maestro_materiales VALUES (19222, 'CABLE', 'CABLE AL DESNUDO 300 MM2 19 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (9709, 'CAJA ', 'CAJA ALUMB PUBLICO METAL P/MEDIDOR', 5);
INSERT INTO obras.maestro_materiales VALUES (16383, 'DERIV', 'DERIV AL/CU BURNDY 2~6-2AWG YC1U1', 5);
INSERT INTO obras.maestro_materiales VALUES (14560, 'COMPA', 'COMPACTO MED 3F 25KV 80-120-160/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (17738, 'COPLA', 'COPLA GALV REDUCCION 4"A 2"', 5);
INSERT INTO obras.maestro_materiales VALUES (17739, 'COPLA', 'COPLA GALV REDUCCION 4"A 3"', 5);
INSERT INTO obras.maestro_materiales VALUES (264, 'ESLAB', 'ESLABON ANGULAR GALVANIZADO P/PERNO 5/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (15184, 'SECC ', 'SECC B-CARGA RL 23KV/150KV SF6/SCADA/RTU', 5);
INSERT INTO obras.maestro_materiales VALUES (10464, 'SECC ', 'SECC FUS WEBER 3F 400A 500V INT T/C INC', 5);
INSERT INTO obras.maestro_materiales VALUES (23055, 'CONEC', 'CONECT DERIV T-Y RAYCHE 35-95MM MBRA011', 5);
INSERT INTO obras.maestro_materiales VALUES (13419, 'BRAZO', 'BRAZO PARA POSTE OCTOGONAL DE REMATE D12', 5);
INSERT INTO obras.maestro_materiales VALUES (13800, 'PLETI', 'PLETINA UNIÓN 335X120X6 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (47, 'AISLA', 'AISLADOR ESPIGA 7"/12"F R-1 3/8" O.BRAS', 5);
INSERT INTO obras.maestro_materiales VALUES (20678, 'SECC ', 'SECC CUCH 34,5KV 600A S&C CAT 14723-N', 5);
INSERT INTO obras.maestro_materiales VALUES (14763, 'CABLE', 'CABLE CU AISLADO USE 350 MCM', 4);
INSERT INTO obras.maestro_materiales VALUES (13870, 'MOTOO', 'MOTOOPERADOR RTU S&C SERIE M/BATERIA', 5);
INSERT INTO obras.maestro_materiales VALUES (19949, 'DIAGO', 'DIAGONAL PERFIL L GALV 40X40X5X1830MM', 5);
INSERT INTO obras.maestro_materiales VALUES (17647, 'ALAMB', 'ALAMBRE CU AISLADO NSYA 6 MM2 NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (6868, 'TAPA ', 'TAPA TERMINAL PARA REGLETA WIELAND', 5);
INSERT INTO obras.maestro_materiales VALUES (9849, 'POSTE', 'POSTE HA 18MT C/PUESTA TIERRA', 5);
INSERT INTO obras.maestro_materiales VALUES (19955, 'MARCO', 'MARCO METAL P/SCMARA 960X860 P-L 80X80X8', 5);
INSERT INTO obras.maestro_materiales VALUES (3464, 'CABLE', 'CABLE CU AISLADO XT/XTU/XCS 3/0 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (20395, 'ESPAC', 'ESPACIADOR POLI 25KV C/HEB HENDRIX RTL46', 5);
INSERT INTO obras.maestro_materiales VALUES (16029, 'CODIG', 'CODIGO REPETIDO CON 17635 PEDIR 17635', 5);
INSERT INTO obras.maestro_materiales VALUES (20377, 'AISLA', 'AISLADOR ESPIGA 35KV R-1" C-F HENDRIX', 5);
INSERT INTO obras.maestro_materiales VALUES (10873, 'TORRE', 'TORRE METALICA 9,0 METROS', 5);
INSERT INTO obras.maestro_materiales VALUES (126, 'CABLE', 'CABLE CU DESN DURO 5 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (20644, 'ADAPT', 'ADAPTAD ELASTIMOL 20MA-G25KV P/CBLE 2AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (16101, 'ALAMB', 'ALAMBRE AL Nº4 C/CUBIERTA BTPR P/AMARRAS', 4);
INSERT INTO obras.maestro_materiales VALUES (13644, 'CABLE', 'CABLE MONOP APANT XT 350 MCM 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (13761, 'DIAGO', 'DIAGONAL FE GALV 1.1/4X3/16 9MM P/CR2,4M', 5);
INSERT INTO obras.maestro_materiales VALUES (24197, 'CELDA', 'CELDA MT MM C/SS.CC.15KV 20-40-80/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (12891, 'TORRE', 'TORRE DE ACERO GALVANIZADO TIPO TD1', 5);
INSERT INTO obras.maestro_materiales VALUES (9454, 'CONEC', 'CONECTOR AMP 85~16MM AZUL 600446', 5);
INSERT INTO obras.maestro_materiales VALUES (282, 'FUSIB', 'FUSIBLE REJA TRIPOLAR 150A 112MM CGED', 5);
INSERT INTO obras.maestro_materiales VALUES (10421, 'CRUCE', 'CRUCETA FE GALV 80X80X6X1900', 5);
INSERT INTO obras.maestro_materiales VALUES (34478, 'POSTE', 'POSTE FE PETIT SEPALE ALIZE 10M LARGO', 5);
INSERT INTO obras.maestro_materiales VALUES (10801, 'POSTE', 'POSTE DODEC GALV DB CIRC REM HYU V12-2R', 5);
INSERT INTO obras.maestro_materiales VALUES (634, 'AISLA', 'AISLADOR CILINDRICO ANCLA EPOXICO P/15KV', 5);
INSERT INTO obras.maestro_materiales VALUES (9299, 'CABLE', 'CABLE AL AAAC 1/0 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (6877, 'RIEL ', 'RIEL MONTAJE DIN 46277, 15X9X32MM', 4);
INSERT INTO obras.maestro_materiales VALUES (18765, 'ESPAC', 'ESPACIADOR POLI 15KV C/HEB HENDRIX RTL15', 5);
INSERT INTO obras.maestro_materiales VALUES (9721, 'BRAZO', 'BRAZO PORTAESPIGA P/SISTEMA D.R.P.', 5);
INSERT INTO obras.maestro_materiales VALUES (9176, 'TORRE', 'TORRE PORTANTE TIPO P12-2M', 5);
INSERT INTO obras.maestro_materiales VALUES (7088, 'INT A', 'INT AUT 3 X 250A 500V 10KA SACE Z250', 5);
INSERT INTO obras.maestro_materiales VALUES (1246, 'POSTE', 'POSTE HA 8MT C/PLACA', 5);
INSERT INTO obras.maestro_materiales VALUES (15963, 'POSTE', 'POSTE HA MOZO 7,20M', 5);
INSERT INTO obras.maestro_materiales VALUES (16450, 'DERIV', 'DERIV AL/CU BUR 3/0-4/0~3/0-4/0 YCP28U28', 5);
INSERT INTO obras.maestro_materiales VALUES (17856, 'CRUCE', 'CRUCETA MADERA 3 1/2 X 4 1/2" L=1.8M', 5);
INSERT INTO obras.maestro_materiales VALUES (10865, 'POSTE', 'POSTE DODEC GALV CIR SIM REM HYU V20-1RE', 5);
INSERT INTO obras.maestro_materiales VALUES (3495, 'GOLIL', 'GOLILLA PLANA FE GALV 22X2MM P/P 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (10562, 'SECC ', 'SECC FUS WEBER 630A 500V P/NH C/AMPERMET', 5);
INSERT INTO obras.maestro_materiales VALUES (19950, 'DIAGO', 'DIAGONAL PLETINA FE GALV 32X6X900MM', 5);
INSERT INTO obras.maestro_materiales VALUES (10517, 'TRAFO', 'TRAFO DIST 3F AEREO, 15 KV, 112,5 KVA', 5);
INSERT INTO obras.maestro_materiales VALUES (8873, 'POSTE', 'POSTE HA 8,7M  TIPO CHILECTRA', 5);
INSERT INTO obras.maestro_materiales VALUES (19962, 'TAPA ', 'TAPA HA P/SEMI CAMARILLA VERED 938X837MM', 5);
INSERT INTO obras.maestro_materiales VALUES (237, 'CRUCE', 'CRUCETA FE GALV 100X100X10X3000MM', 5);
INSERT INTO obras.maestro_materiales VALUES (20344, 'BRAZO', 'BRAZO PEATONAL 1"X 800MM C/BASE/ABRA 1/2', 5);
INSERT INTO obras.maestro_materiales VALUES (19223, 'CABLE', 'CABLE AL DESNUDO 120 MM2 19 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (16124, 'SOPOR', 'SOPORTE SPB1 PARA CAJAS SPB1', 5);
INSERT INTO obras.maestro_materiales VALUES (13769, 'PERNO', 'PERNO J FE 1/2X12" P/CAÑ 1" C/T-G-TC-MAD', 5);
INSERT INTO obras.maestro_materiales VALUES (18338, 'BASES', 'BASES P/ITE 3F. CHICO', 5);
INSERT INTO obras.maestro_materiales VALUES (13793, 'PERNO', 'PERNO OJO 3/4X15X3"', 5);
INSERT INTO obras.maestro_materiales VALUES (19337, 'PERNO', 'PERNO 5/8"X3-1/2" C/TUERCA Y GOLILLA', 5);
INSERT INTO obras.maestro_materiales VALUES (15917, 'GRAPA', 'GRAPA ANCL RECTA P/AL 1-266,8MCM 3.800KG', 5);
INSERT INTO obras.maestro_materiales VALUES (16001, 'AMARR', 'AMARRA PLASTICA 350MM NEGRO', 5);
INSERT INTO obras.maestro_materiales VALUES (10857, 'CABLE', 'CABLE AL PROTEG 1X70 MM2 L.AEREA 25KV', 4);
INSERT INTO obras.maestro_materiales VALUES (10864, 'POSTE', 'POSTE DODEC. ACERO GALV. CIRC. SIMPLE DE V16-1RE', 5);
INSERT INTO obras.maestro_materiales VALUES (9302, 'ALAMB', 'ALAMBRE AL RECOCIDO P/ATAR # 4 AWG', 6);
INSERT INTO obras.maestro_materiales VALUES (13431, 'S/E P', 'S/E PADMOUN 15KV 500KVA AUT 800A 45KA', 5);
INSERT INTO obras.maestro_materiales VALUES (19968, 'SEPAR', 'SEPARADOR BT 6VIA 1500X400 GALV U 50X35', 5);
INSERT INTO obras.maestro_materiales VALUES (7207, 'BARRA', 'BARRA GALV P/TIRTE 3/4"X3200MM C/TUERCAS', 5);
INSERT INTO obras.maestro_materiales VALUES (14701, 'SENSO', 'SENSOR VOLT/CTE CVMI 15KV P/SCADA MT', 5);
INSERT INTO obras.maestro_materiales VALUES (13418, 'ADAPT', 'ADAPTAD P/SEC TRIPVIA POSTE D12-IR-2/3SW', 5);
INSERT INTO obras.maestro_materiales VALUES (4012, 'INT A', 'INT AUT 3 X 125A 600V 30KA MITSUBISHI', 5);
INSERT INTO obras.maestro_materiales VALUES (17806, 'CONEC', 'CONECTOR AMP 300-240~185-240M 1-602031-3', 5);
INSERT INTO obras.maestro_materiales VALUES (17655, 'CABLE', 'CABLE MONOCONDUCTOR XAT 1/0 AWG 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (6123, 'POSTE', 'POSTE FE TUBUL EMP 12M C/BZ DBLE/CJA REG', 5);
INSERT INTO obras.maestro_materiales VALUES (15685, 'INT A', 'INT AUT LIMITADOR POTENCIA ICP 1 X 25A', 5);
INSERT INTO obras.maestro_materiales VALUES (3666, 'CABLE', 'CABLE DE ALUMINIO CON ALMA DE ACERO (ACS', 6);
INSERT INTO obras.maestro_materiales VALUES (15686, 'INT A', 'INT AUT LIMITADOR POTENCIA ICP 1 X 45A', 5);
INSERT INTO obras.maestro_materiales VALUES (15918, 'AMARR', 'AMARRA ALUM 4/0 AWG CUELLO F, UTF-1208', 5);
INSERT INTO obras.maestro_materiales VALUES (1078, 'PROTE', 'PROTECTOR P/PASADA COND CJA MET C/EMPAQ', 5);
INSERT INTO obras.maestro_materiales VALUES (7904, 'TUERC', 'TUERCA HEX BRONCE-SILICIO P/PERNO 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (10483, 'CABLE', 'CABLE CU AISLADO XAT 1X1 AWG 35 MM2 25KV', 4);
INSERT INTO obras.maestro_materiales VALUES (13397, 'SOPOR', 'SOPORTE PASO 1 PLANO GALV P/RED COMPACTA', 5);
INSERT INTO obras.maestro_materiales VALUES (17453, 'TORRE', 'TORRE PASO TJ CPO SUP P66-S', 5);
INSERT INTO obras.maestro_materiales VALUES (15964, 'SEPAR', 'SEPARADOR PARA SOPORTE S.E.', 5);
INSERT INTO obras.maestro_materiales VALUES (17737, 'COPLA', 'COPLA GALV REDUCCION 4"A 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (16528, 'DIAGO', 'DIAGONAL FE GALV CANTILEV 50X50X5X1830MM', 5);
INSERT INTO obras.maestro_materiales VALUES (10398, 'INT A', 'INT AUT 1 X 63A TDC IP TERASAKI', 5);
INSERT INTO obras.maestro_materiales VALUES (7524, 'PERNO', 'PERNO "U" FE GALV 1/2", P/CAÑERIA 3"', 5);
INSERT INTO obras.maestro_materiales VALUES (12879, 'EXTEN', 'EXTENSION DE 2 MT PARA TORRE PORTANTE P1', 5);
INSERT INTO obras.maestro_materiales VALUES (1431, 'SECC ', 'SECC FUS S&C XS 1F 14,4/25KV 100A 12000A', 5);
INSERT INTO obras.maestro_materiales VALUES (6870, 'FIJAC', 'FIJACION PLAST. P/BORDES REGLETA WIELAND', 5);
INSERT INTO obras.maestro_materiales VALUES (8089, 'POSTE', 'POSTE OCTOGONAL ANGULO DE ACERO GALV, AL', 5);
INSERT INTO obras.maestro_materiales VALUES (16967, 'POSTE', 'POSTE MADERA 8MT', 5);
INSERT INTO obras.maestro_materiales VALUES (9953, 'PERNO', 'PERNO OJO 5/8X431MM C/T-G/PS-PL', 5);
INSERT INTO obras.maestro_materiales VALUES (9300, 'CABLE', 'CABLE AL AAAC 3/0 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (13660, 'GRAPA', 'GRAPA ANCL PISTOLA P/CU 2-2/0AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (20508, 'ESPIG', 'ESPIGA LARGA SOP CBLE PROTEC P/VOLANT', 5);
INSERT INTO obras.maestro_materiales VALUES (13803, 'SOPOR', 'SOPORTE REMATE ACERO GALV P/5 VIAS', 5);
INSERT INTO obras.maestro_materiales VALUES (9022, 'TRANS', 'TRANSFORMADOR DE MEDIDA COMPACTO TRIFASICO 15KV 80-160/5', 5);
INSERT INTO obras.maestro_materiales VALUES (7901, 'PERNO', 'PERNO BRONCE-SIL CAB.HEX 1/2X1-1/4", S/T', 5);
INSERT INTO obras.maestro_materiales VALUES (19192, 'CONEC', 'CONECTOR BURNDY 10-35 MM2 YGHC2C2', 5);
INSERT INTO obras.maestro_materiales VALUES (13945, 'SECC ', 'SECC FUS S&C XS 1F 25KVNC1 15KVNC3 100A', 5);
INSERT INTO obras.maestro_materiales VALUES (6902, 'CABLE', 'CABLE DE CONTROL, TIPO CTT O TCC, 4 X #', 4);
INSERT INTO obras.maestro_materiales VALUES (16443, 'PRENS', 'PRENSA DOSSERT P/CRUCE 1-4/0AWG GTX21-6', 5);
INSERT INTO obras.maestro_materiales VALUES (10872, 'POSTE', 'POSTE RIEL 10,0 METROS', 5);
INSERT INTO obras.maestro_materiales VALUES (5387, 'CABLE', 'CABLE CU AISLADO THW 1/0 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (17621, 'TORNI', 'TORNILLO ROSCALATA 4 MM X 3/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (13610, 'AISLA', 'AISLADOR ESPIGA 1032-C 15KV SANTANA CAFE', 5);
INSERT INTO obras.maestro_materiales VALUES (18687, 'CONEC', 'CONECTOR AMP 121-152~61-76MM AZ 602046-5', 5);
INSERT INTO obras.maestro_materiales VALUES (6326, 'CAPSU', 'CAPSULA SOLDADURA # 32', 5);
INSERT INTO obras.maestro_materiales VALUES (14450, 'TORRE', 'TORRE DE PASO TIPO TJ - EXTENSION P66-E1', 5);
INSERT INTO obras.maestro_materiales VALUES (15966, 'POSTE', 'POSTE HA MOZO 4,3MT', 5);
INSERT INTO obras.maestro_materiales VALUES (8272, 'CANDA', 'CANDADO ODIS #750 SERIE G GANCHO BRONCE', 5);
INSERT INTO obras.maestro_materiales VALUES (19336, 'PERNO', 'PERNO 5/8 " X 45 MM CON TUERCA Y GOLILLA', 5);
INSERT INTO obras.maestro_materiales VALUES (13434, 'POSTE', 'POSTE DODECAGONAL ANGULO DE FE GALV., TI', 5);
INSERT INTO obras.maestro_materiales VALUES (6567, 'PERNO', 'PERNO PRISIONERO FE GALV 5/8X10" 2T Y 2G', 5);
INSERT INTO obras.maestro_materiales VALUES (15968, 'EXTEN', 'EXTENSION FE GALV 2800 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (3461, 'CABLE', 'CABLE DE COBRE DESNUDO, DURO, # 250 MCM', 6);
INSERT INTO obras.maestro_materiales VALUES (15733, 'INT A', 'INT AUT LIMITADOR POTENCIA ICP 3 X 45A', 5);
INSERT INTO obras.maestro_materiales VALUES (10400, 'TRANS', 'TRANSFORMADOR DE MEDIDA COMPACTO TRIFASICO 15KV 200-400/', 5);
INSERT INTO obras.maestro_materiales VALUES (1294, 'DUCTO', 'DUCTO ASBESTO CEMENTO 125 MM X 4 MT', 5);
INSERT INTO obras.maestro_materiales VALUES (128, 'CABLE', 'CABLE CU DESN DURO 3 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (13433, 'CABLE', 'CABLE MONOP APANT XLPE 70 MM2 23KV', 4);
INSERT INTO obras.maestro_materiales VALUES (7230, 'GUARD', 'GUARDACABO GALV CABLE 3/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (14754, 'CRUCE', 'CRUCETA AUX 90º FE GALV P/TORRE R12-2', 5);
INSERT INTO obras.maestro_materiales VALUES (7866, 'POSTE', 'POSTE HA PRET 13,5M 15M REC 13,5M ENDESA', 5);
INSERT INTO obras.maestro_materiales VALUES (746, 'CABLE', 'CABLE CU CWELD DESN 2 AWG TIPO G', 6);
INSERT INTO obras.maestro_materiales VALUES (5812, 'ESPIG', 'ESPIGA GALV BRASS 7/8X2" P/AISL LPOST', 5);
INSERT INTO obras.maestro_materiales VALUES (10798, 'POSTE', 'POSTE DODEC. ACERO GALV. CIRC. SIMPLE DE V12-1RE (H)', 5);
INSERT INTO obras.maestro_materiales VALUES (4992, 'CONEC', 'CONECT SOLDA TER CU-NI REMA ESTAM P/16MM', 5);
INSERT INTO obras.maestro_materiales VALUES (14499, 'TRAFO', 'TRAFO DIST 3F AEREO 15KV 1500KVA', 5);
INSERT INTO obras.maestro_materiales VALUES (17724, 'INT H', 'INT HORARIO LEGRAND MOD. 03788', 5);
INSERT INTO obras.maestro_materiales VALUES (3488, 'CABLE', 'CABLE AL C/ALMA ACERO ACSR 3 AWG 7HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (17868, 'TAPON', 'TAPON MADERA P/TB FE PROT TTE 73.2MM INT', 5);
INSERT INTO obras.maestro_materiales VALUES (23199, 'COMPA', 'COMPACTO MED 3F 15KV 20-40/5A 3 ELEM', 5);
INSERT INTO obras.maestro_materiales VALUES (14679, 'KIT C', 'KIT CONEX P/INDR CCUITO FISHER PIERCE M', 9);
INSERT INTO obras.maestro_materiales VALUES (9559, 'HILO ', 'HILO FUS DBLE ARGOLLA 1A CURVA H P/TRAFO', 5);
INSERT INTO obras.maestro_materiales VALUES (6743, 'CANDA', 'CANDADO ODIS #750 SERIE C GANCHO BRONCE', 5);
INSERT INTO obras.maestro_materiales VALUES (14496, 'TRAFO', 'TRAFO DIST 3F AEREO 15KV 400KVA', 5);
INSERT INTO obras.maestro_materiales VALUES (17759, 'CONEC', 'CONECT DESMONTABLE AMP CAT.4449970-1', 5);
INSERT INTO obras.maestro_materiales VALUES (13763, 'ESLAB', 'ESLABÓN SIMPLE 12MM', 5);
INSERT INTO obras.maestro_materiales VALUES (12878, 'TORRE', 'TORRE PORTANTE TIPO P16-2', 5);
INSERT INTO obras.maestro_materiales VALUES (17207, 'CRUCE', 'CRUCETA MADERA 3 1/2 X 41/2 X 2,40 M', 5);
INSERT INTO obras.maestro_materiales VALUES (29874, 'SECC ', 'SECC CUCH BYPASS 1F 25KV 600A SNAPHORN', 5);
INSERT INTO obras.maestro_materiales VALUES (20327, 'INDIC', 'INDIC FALLA NORTROLL LINE TROLL111K', 5);
INSERT INTO obras.maestro_materiales VALUES (7906, 'GOLIL', 'GOLILLA PRESION CONVENC BR-SI P/P 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (7437, 'TUBO ', 'TUBO CONDUIT GALV 4" 3MT C/HIL NPT/COPLA', 7);
INSERT INTO obras.maestro_materiales VALUES (13979, 'CABLE', 'CABLE AL AAAC FLINT 740,8 MCM 37 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (16509, 'PORTA', 'PORTATRAFO FE GALV C 100X40X6X2320MM', 5);
INSERT INTO obras.maestro_materiales VALUES (14847, 'CABLE', 'CABLE CONTROL CTT/TCC 4X16 AWG', 4);
INSERT INTO obras.maestro_materiales VALUES (14710, 'CABLE', 'CABLE AL PREEN 3X70/50 MM2', 4);
INSERT INTO obras.maestro_materiales VALUES (16044, 'ALAMB', 'ALAMBRE INTEMPERIE 4 AWG,21,16', 4);
INSERT INTO obras.maestro_materiales VALUES (16573, 'CANDA', 'CANDADO ODIS #750 SERIE CONAFE', 5);
INSERT INTO obras.maestro_materiales VALUES (14912, 'CABLE', 'CABLE MONOP APANTA XLPE 120 MM2 23KV', 4);
INSERT INTO obras.maestro_materiales VALUES (16446, 'CONEC', 'CONECT EMPALME P/CBLE CU 6-50MM PETRI', 5);
INSERT INTO obras.maestro_materiales VALUES (10876, 'TORRE', 'TORRE METALICA 15,0 METROS', 5);
INSERT INTO obras.maestro_materiales VALUES (756, 'CABLE', 'CABLE CU AISLADO XT/XTU/XCS 300 MCM', 4);
INSERT INTO obras.maestro_materiales VALUES (1148, 'TUERC', 'TUERCA HEX FE GALV P/PERNO 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (9901, 'CABLE', 'CABLE MONOP APANT XLPE 240 MM2 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (19274, 'PREFO', 'PREFORMADA RETENCION MOD NDO115, PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (18292, 'AISLA', 'AISLADOR 1032-C SANTA TERESIÑA', 5);
INSERT INTO obras.maestro_materiales VALUES (16104, 'CABLE', 'CABLE PILC SWA 3 X 25', 4);
INSERT INTO obras.maestro_materiales VALUES (17607, 'POSTE', 'POSTE HA 13MTS 600K RUPT', 5);
INSERT INTO obras.maestro_materiales VALUES (7, 'TRAFO', 'TRAFO DIST 3F AEREO, 15KV, 15KVA', 5);
INSERT INTO obras.maestro_materiales VALUES (16391, 'CONEC', 'CONECT EMPALME P/CBLE CU 6-35MM PETRI', 5);
INSERT INTO obras.maestro_materiales VALUES (10875, 'TORRE', 'TORRE METALICA 11,5 METROS', 5);
INSERT INTO obras.maestro_materiales VALUES (20879, 'CABLE', 'CABLE PROTEGIDO AAAC 2 AWG 25KV HENDRI', 4);
INSERT INTO obras.maestro_materiales VALUES (13430, 'S/E P', 'S/E PADMOUN 15KV 300KVA AUT 500A 45 KA', 5);
INSERT INTO obras.maestro_materiales VALUES (260, 'TRAFO', 'TRAFO MED COMP 15KV 8,4-224V 20-40-80/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (16426, 'CONEC', 'CONECT COMPRESION RECTO 3M 10011 P/350MC', 5);
INSERT INTO obras.maestro_materiales VALUES (3473, 'CABLE', 'CABLE APANT BICC ACEITE 50 MM2 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (35595, 'SEPAR', 'SEPARADOR DE FASES B.T., MOD. DSF-4', 5);
INSERT INTO obras.maestro_materiales VALUES (19529, 'SOPOR', 'SOPORTE GALV P/BRAZO ANTIBALANCE', 5);
INSERT INTO obras.maestro_materiales VALUES (15955, 'ESTRI', 'ESTRIBO PARA BRAZO TIPO "L"', 5);
INSERT INTO obras.maestro_materiales VALUES (17653, 'CABLE', 'CABLE CU AISLADO NSYA 25 MM2 NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (16100, 'CABLE', 'CABLE PROTEGIDO AAAC 4/0 AWG 15KV HENDRI', 4);
INSERT INTO obras.maestro_materiales VALUES (38077, 'Perno', 'Perno de Acero Galvanizado con Ojo dia.', 5);
INSERT INTO obras.maestro_materiales VALUES (6778, 'CRUCE', 'CRUCETA HORMIGON PRETENSADO 75X75X1900MM', 5);
INSERT INTO obras.maestro_materiales VALUES (16127, 'CAJA ', 'CAJA CALOTA SAIME', 5);
INSERT INTO obras.maestro_materiales VALUES (7561, 'TORRE', 'TORRE TIPO R12-2', 5);
INSERT INTO obras.maestro_materiales VALUES (16440, 'PRENS', 'PRENSA DESMONTABLE BURNDY 2/0AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (14697, 'INDIC', 'INDIC CORTOCTO P/SCADA MT C/UND RECEPTOR', 5);
INSERT INTO obras.maestro_materiales VALUES (1418, 'SECC ', 'SECC FUS J.BAIER EXTERIOR 3F 400V 450A', 5);
INSERT INTO obras.maestro_materiales VALUES (506, 'PRENS', 'PRENSA VIVA BR-SN 8-2/0~8-2AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (16502, 'PERNO', 'PERNO OJO 5/8X2,40M C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (5585, 'CABLE', 'CABLE DE CONTROL, TIPO CTT O TCC, 2 X #', 4);
INSERT INTO obras.maestro_materiales VALUES (15914, 'AMARR', 'AMARRA ALUM 1/0 AWG CUELLO F, UTF-1205', 5);
INSERT INTO obras.maestro_materiales VALUES (1024, 'PERNO', 'PERNO FE GALV CAB HEX 1/2X12X3" C/T', 5);
INSERT INTO obras.maestro_materiales VALUES (17817, 'CONEC', 'CONECTOR AMP 121-152~61-76MM AZ 602046-5', 5);
INSERT INTO obras.maestro_materiales VALUES (7612, 'PLETI', 'PLETINA AMARRE FE GALV 110X12X540MM', 5);
INSERT INTO obras.maestro_materiales VALUES (26893, 'POSTE', 'POSTE FE DISTRIPOLE 15M 12M UTIL 2PZA', 5);
INSERT INTO obras.maestro_materiales VALUES (13795, 'PERNO', 'PERNO OJO 5/8X15X3" C/3TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (10874, 'TORRE', 'TORRE METALICA 10,0 METROS', 5);
INSERT INTO obras.maestro_materiales VALUES (20540, 'CUCHI', 'CUCHILLO P/SEC APR630 CAVANNA H800', 5);
INSERT INTO obras.maestro_materiales VALUES (10799, 'POSTE', 'POSTE DODEC GALV DB CIRC REM HYU V12-2RE', 5);
INSERT INTO obras.maestro_materiales VALUES (13396, 'SOPOR', 'SOPORTE PASO ANGULO GALV P/RED COMPACTA', 5);
INSERT INTO obras.maestro_materiales VALUES (10802, 'POSTE', 'POSTE DODEC GALV DB CIRC REM HYU V16-2R', 5);
INSERT INTO obras.maestro_materiales VALUES (10152, 'POSTE', 'POSTE DODEC. ACERO GALV. CIRC. SIMPLE DE V12-1R (V)', 5);
INSERT INTO obras.maestro_materiales VALUES (14672, 'CABLE', 'CABLE CU CWELD DESN 4/0 AWG TIPO E', 4);
INSERT INTO obras.maestro_materiales VALUES (10526, 'CABLE', 'CABLE AL PROTEG 1X70 MM2 L.AEREA 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (16975, 'AISLA', 'AISLADOR CARRETE 2 GARGANTAS', 5);
INSERT INTO obras.maestro_materiales VALUES (18631, 'PERNO', 'PERNO ANCLAJE HILTI 3/8 X 3 #0', 5);
INSERT INTO obras.maestro_materiales VALUES (744, 'CABLE', 'CABLE CU CWELD DESN 5 AWG TIPO A', 6);
INSERT INTO obras.maestro_materiales VALUES (1239, 'POSTE', 'POSTE PINO IMPREGNADO 6MT CLASE VI', 5);
INSERT INTO obras.maestro_materiales VALUES (19275, 'PREFO', 'PREFORMADA RETENCION MOD ND-0118, PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (18339, 'BASE ', 'BASE P/INTERRUPTOR 3F GRANDE', 5);
INSERT INTO obras.maestro_materiales VALUES (7623, 'TORRE', 'TORRE TIPO P12-2', 5);
INSERT INTO obras.maestro_materiales VALUES (15958, 'AISLA', 'AISLADOR 17" DIST FUGA P KNR', 5);
INSERT INTO obras.maestro_materiales VALUES (846, 'COPLA', 'COPLA GALV 4" P/CAÑERIA CON HILO BSP', 5);
INSERT INTO obras.maestro_materiales VALUES (10434, 'PERNO', 'PERNO FE GALV 1X3" C/2G.PRES. Y T, °5', 5);
INSERT INTO obras.maestro_materiales VALUES (1427, 'SECC ', 'SECC CUCH 1F 15KV 200A PALLARES', 5);
INSERT INTO obras.maestro_materiales VALUES (22486, 'SECC ', 'SECC CUCH BYPASS 25KV 600A S&C XL', 5);
INSERT INTO obras.maestro_materiales VALUES (7492, 'PRENS', 'PRENSA-ESTOP PLAS INT P23MM P/12-14MM TC', 5);
INSERT INTO obras.maestro_materiales VALUES (6033, 'CONEC', 'CONECT COMP TER/REC 3M 30024 P/2AWG P3/8', 5);
INSERT INTO obras.maestro_materiales VALUES (16797, 'BRAZO', 'BRAZO ANTIBALANCE 15KV HENDRIX BAS 14F', 5);
INSERT INTO obras.maestro_materiales VALUES (16945, 'TUERC', 'TUERCA GALV.3/4 "', 5);
INSERT INTO obras.maestro_materiales VALUES (16049, 'CABLE', 'CABLE PROTEGIDO AAAC 1/0 AWG 15KV HENDRI', 4);
INSERT INTO obras.maestro_materiales VALUES (8425, 'AISLA', 'AISLADOR ESPIGA 7"/12"F R-1"', 5);
INSERT INTO obras.maestro_materiales VALUES (10460, 'POSTE', 'POSTE DODEC. ACERO GALV. CIRC. SIMPLE DE V20-1R (V)', 5);
INSERT INTO obras.maestro_materiales VALUES (10765, 'CABLE', 'CABLE CU AISLADO XT 500 MCM', 4);
INSERT INTO obras.maestro_materiales VALUES (7836, 'CABLE', 'CABLE CU DESN BLANDO 350 MCM 37H A-214', 6);
INSERT INTO obras.maestro_materiales VALUES (10863, 'POSTE', 'POSTE DODEC. ACERO GALV. CIRC. SIMPLE DE V20-1R (H)', 5);
INSERT INTO obras.maestro_materiales VALUES (7234, 'CRUCE', 'CRUCETA FE GALV L 100X100X10X3000 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (17864, 'PERNO', 'PERNO OJO 5/8X11X3" C/2T-G/PL-PS', 5);
INSERT INTO obras.maestro_materiales VALUES (9708, 'CAJA ', 'CAJA ALUMB PUBLICO METAL P/CONTROL', 5);
INSERT INTO obras.maestro_materiales VALUES (134, 'CABLE', 'CABLE CU DESN DURO 2/0 AWG 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (510, 'CONEC', 'CONECTOR MUELA BR P/CW/CU 2-2/0~6-2/0AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (16484, 'REGLE', 'REGLETA PARA CONEXION LANDIS&GIR TVS14', 5);
INSERT INTO obras.maestro_materiales VALUES (19046, 'ESPIG', 'ESPIGA 5/8"X150 CAP 1.3/8" P/CRUCE METAL', 5);
INSERT INTO obras.maestro_materiales VALUES (17641, 'CABLE', 'CABLE AL AAAC 465,4 MCM 19 HEBRAS CAIRO', 6);
INSERT INTO obras.maestro_materiales VALUES (5770, 'ADAPT', 'ADAPTAD ELAST 20MA-G15KV P/1F XLPE3/0AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (898, 'CONSO', 'CONSOLA P/REC. KYLE TIPO 6H 1 POSTE', 5);
INSERT INTO obras.maestro_materiales VALUES (20871, 'S/E P', 'S/E PAD MOUNTED 13200/400V, 1250KVA ONAN', 5);
INSERT INTO obras.maestro_materiales VALUES (6614, 'DIODO', 'DIODO BLOQ P/CARG AIR A15125VM 14CTO POT', 5);
INSERT INTO obras.maestro_materiales VALUES (13557, 'CABLE', 'CABLE CU AISLADO NSYA 35 MM2 NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (17650, 'CABLE', 'CABLE CU AISLADO THHN 500 MCM', 4);
INSERT INTO obras.maestro_materiales VALUES (13797, 'TUBO ', 'TUBO METAL PROT P/TTE 73.2/76.2 2500MM', 5);
INSERT INTO obras.maestro_materiales VALUES (15956, 'AISLA', 'AISLADOR POLIMERO RETENCION 15KV 1515SS', 5);
INSERT INTO obras.maestro_materiales VALUES (17461, 'INT 1', 'INT 1F 15KV 200A 125KVBIL ACEITE INEPAR', 5);
INSERT INTO obras.maestro_materiales VALUES (10368, 'POSTE', 'POSTE HA PRETEN 16,5MT REFORZADO', 5);
INSERT INTO obras.maestro_materiales VALUES (17144, 'TUERC', 'TUERCA GALV. C/OJO 5/8 "', 5);
INSERT INTO obras.maestro_materiales VALUES (29, 'AMARR', 'AMARRA PLASTICA 3M #760', 5);
INSERT INTO obras.maestro_materiales VALUES (228, 'CONSO', 'CONSOLA P/REC. KYLE TIPO R, EN 1 POSTE', 5);
INSERT INTO obras.maestro_materiales VALUES (3668, 'CABLE', 'CABLE AL C/ALMA ACERO ACSR 4/0AWG 7HEBRA', 6);
INSERT INTO obras.maestro_materiales VALUES (10291, 'POSTE', 'POSTE DODEC GALV DB CIRC PASO VAL V12-2P', 5);
INSERT INTO obras.maestro_materiales VALUES (5, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 25KVA, 15KV, 1X220 V.', 5);
INSERT INTO obras.maestro_materiales VALUES (73, 'ALAMB', 'ALAMBRE DE COBRE AISLADO, TIPO XT, XTU O XCS, 10 AWG (5,26MM2) PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (178, 'CANCA', 'CANCAMO DE FIERRO GALVANIZADO ABIERTO CON HILO PARA MADERA 7,9 MM x110 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (213, 'CODO ', 'CODO GALVANIZADO 1" PARA CAÑERIA', 5);
INSERT INTO obras.maestro_materiales VALUES (216, 'CODO ', 'CODO GALVANIZADO 2" PARA CAÑERIA', 5);
INSERT INTO obras.maestro_materiales VALUES (334, 'HILO ', 'HILO FUSIBLE 1A, CURVA T, PARA SECCIONADOR  FUSIBLE A.T. EXTERIOR, CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (336, 'HILO ', 'HILO FUSIBLE 2A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (338, 'HILO ', 'HILO FUSIBLE 3A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (341, 'HILO ', 'HILO FUSIBLE 6A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (342, 'HILO ', 'HILO FUSIBLE 8A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA FIJA', 5);
INSERT INTO obras.maestro_materiales VALUES (343, 'HILO ', 'HILO FUSIBLE 10A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (344, 'HILO ', 'HILO FUSIBLE 12A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (346, 'HILO ', 'HILO FUSIBLE 15A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (348, 'HILO ', 'HILO FUSIBLE 20A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOBIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (349, 'HILO ', 'HILO FUSIBLE 25A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOBIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (353, 'HILO ', 'HILO FUSIBLE 40A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (369, 'HUINC', 'HUINCHA DE GOMA DE 3/4" ANCHO', 10);
INSERT INTO obras.maestro_materiales VALUES (375, 'INTER', 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 1F 220 V, 1X15A, 6KA RUPTURA, RIEL AMERICANO, SAIME', 5);
INSERT INTO obras.maestro_materiales VALUES (413, 'LAMPA', 'LAMPARA VAPOR DE NA ALTA PRESION DE 150W, ROSCA E-40, 100V ARCO, 14500 LUMENES', 5);
INSERT INTO obras.maestro_materiales VALUES (844, 'COPLA', 'COPLA GALVANIZADA 2" PARA CAÑERIA', 5);
INSERT INTO obras.maestro_materiales VALUES (20559, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL GRADO 2 DE 5/8"X2 1/2"X2" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (1765, 'FAROL', 'FAROL HORNAMENTAL STELLA', 5);
INSERT INTO obras.maestro_materiales VALUES (1900, 'LUMIN', 'LUMINARIA LED 50W MASON GOLD CLEVER', 5);
INSERT INTO obras.maestro_materiales VALUES (2121, 'LUMIN', 'LUMINARIA LED 90W MASON GOLD CLEVER BF BLANCO IP66 IK 08, CREE IP 66, CUERPO DE ALUMINIO INYECTADO CONEXIONADO LED INDEPENDIENTE', 5);
INSERT INTO obras.maestro_materiales VALUES (2483, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X 14"X 3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (2677, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 80A, TAMAÑO 1, MARCA ELETROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (2678, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 100A, TAMAÑO 1, MARCA ELETROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (2679, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 125A, TAMAÑO 1, MARCA ELETROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (2680, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 160A, TAMAÑO 1, MARCA ELETROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (2681, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 200A, TAMAÑO 1, MARCA ELETROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (2682, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 250A, TAMAÑO 2, MARCA ELETROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (2683, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 400A, TAMAÑO 2, MARCA ELETROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (3144, 'MUFA ', 'MUFA TERMINAL 3M TIPO QTM, EXTERIOR 15KV P3/CABLES MONOPOLAR 2 -3/0 AWG AISLACIÓN XLPE', 12);
INSERT INTO obras.maestro_materiales VALUES (3414, 'TEST ', 'TEST BLOCK (REGLETA) PARA MEDIDORES INDIRECTOS DE 3 ELEMENTOS, LANDIS&GIR TVS14 ', 5);
INSERT INTO obras.maestro_materiales VALUES (3509, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 10KVA, 23KV, 1X231V., TAPS 24150/23000/21850/20700/19550', 5);
INSERT INTO obras.maestro_materiales VALUES (3510, 'FN US', 'FN USAR COD. 38432, TRANSFORMADOR DE DISTRIBUCIÓN 2F AEREO, 15KVA, 23KV, 1X231V., TAPS 24150/23000/21850/20700/19550', 5);
INSERT INTO obras.maestro_materiales VALUES (3521, 'FN US', 'FN USAR COD. 38497, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 75KVA, 23KV, 400-231V, TAPS 24150/23000/21850/20700/19550', 5);
INSERT INTO obras.maestro_materiales VALUES (3647, 'PARAR', 'PARARRAYOS EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (3665, 'BRONC', 'BRONCE DISPONIBLE PARA ENAJENACION', 6);
INSERT INTO obras.maestro_materiales VALUES (3671, 'CABLE', 'CABLE DE ACERO PARA TIRANTE EN MAL ESTADO', 6);
INSERT INTO obras.maestro_materiales VALUES (3676, 'CONDU', 'CONDUCTOR DE COBRE DESNUDO DISPONIBLE PARA ENAJENACION (SOLO CABLES Y ALAMBRES)', 6);
INSERT INTO obras.maestro_materiales VALUES (3677, 'CONDU', 'CONDUCTOR DE COBRE AISLADO DISPONIBLE PARA ENAJENACION (SOLO CABLES Y ALAMBRES)', 6);
INSERT INTO obras.maestro_materiales VALUES (3686, 'ELEME', 'ELEMENTOS Y PIEZAS DE FIERRO DIPONIBLES PARA ENAJENACION', 6);
INSERT INTO obras.maestro_materiales VALUES (4014, 'INTER', 'INTERRUPTORES AUTOMATICOS TERMOMAGNETICOS EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (4417, 'ELEME', 'ELEMENTO FUSIBLE CURVA GL 63A TIPO NH TAMAÑO 00, PARA SECCIONADOR O BASE PORTAFUSIBLE BT, MARCA ELECTROMEC.', 5);
INSERT INTO obras.maestro_materiales VALUES (4525, 'ELEME', 'ELEMENTO FUSIBLE CURVA GL 630A TIPO NH TAMANO 3, PARA SECCIONADOR O BASE PORTA FUSIBLE B.T.', 5);
INSERT INTO obras.maestro_materiales VALUES (5271, 'AISLA', 'AISLADORES Y SUS ACCESORIOS EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (5273, 'SECCI', 'SECCIONADOR FUSIBLE EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (5282, 'POSTE', 'POSTE DE CONCRETO EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (5285, 'POSTE', 'POSTE DE FIERRO GALVANIZADO COMPAC CURVO DE 8.20 MT C/BRAZO DOBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (5381, 'TUBO ', 'TUBO CONDUIT RIGIDO DE 32 MM2 X 6 MTS CLASE III, NARANJA', 4);
INSERT INTO obras.maestro_materiales VALUES (5521, 'SECCI', 'SECCIONADOR CUCHILLO EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (5931, 'CAPSU', 'CAPSULA DE SOLDADURA CADWELD N° 115', 5);
INSERT INTO obras.maestro_materiales VALUES (6076, 'MUFA ', 'MUFA EMPALME RECTO RAYCHEM B.T. PARA CABLES 6-2 AWG C/DERIVACION 14-2 AWG, CRSM-CT34/10-150', 5);
INSERT INTO obras.maestro_materiales VALUES (6077, 'MUFA ', 'MUFA EMPALME RECTO RAYCHEM B.T. PARA CABLES 2-4/0 AWG C/DERIVACION 10-4/0 AWG, CRSM-CT53/13/200', 5);
INSERT INTO obras.maestro_materiales VALUES (6085, 'MUFA ', 'MUFA DE UNION RECTA RAYCHEM 15KV PARA CABLE MONOPOLAR AISLACION SOLIDA, 2-4/0 AWG HVS-1521S', 9);
INSERT INTO obras.maestro_materiales VALUES (6135, 'BASE ', 'BASE DE SUJECION ATORNILLADA, PARA ABRAZADERA DE PLASTICO TIPO HEBILLA, INTEMPERIE', 5);
INSERT INTO obras.maestro_materiales VALUES (6242, 'CONEC', 'CONECTOR DE COMPRESIÓN TERMINAL RECTO 3M, CATEGORIA 30016, PARA CABLE 6 AWG, PERFORACION 5/16"', 5);
INSERT INTO obras.maestro_materiales VALUES (6428, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 315A, TAMAÑO 2, MARCA ELETROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (6561, 'LAMPA', 'LAMPARA VAPOR DE NA ALTA PRESION DE 70 W, ROSCA E-27, 90 V ARCO, 5900 LUMENES, SON/E SIN IGNITOR', 5);
INSERT INTO obras.maestro_materiales VALUES (6910, 'BOQUI', 'BOQUILLA PARA DUCTO DE PVC DENSO DE 32 MM PARA ENTRADA A CAMARA', 5);
INSERT INTO obras.maestro_materiales VALUES (6912, 'BOQUI', 'BOQUILLA PARA DUCTO DE PVC DENSO DE 110 MM, PARA ENTRADA A CAMARAS, NARANJA', 5);
INSERT INTO obras.maestro_materiales VALUES (6944, 'ELEME', 'ELEMENTO FUSIBLE CURVA GL 16A TIPO NH TAMAÑO 00, PARA SECCIONADOR O BASE PORTA FUSIBLE B.T. MARCA ELECTROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (7147, 'DUCTO', 'DUCTOS DE PLASTICO INUTILIZABLES (DIFERENTES MEDIDAS) EN MAL ESTADO', 4);
INSERT INTO obras.maestro_materiales VALUES (7206, 'ESLAB', 'ESLABON ANGULAR ESTAMPADO GALVANIZADO PARA PERFORADA PARA PERNO 3/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (7641, 'HILO ', 'HILO FUSIBLE 15A CURVA T PARASEC.FUS. A.T. EXTERIOR CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (9063, 'POSTE', 'POSTE DE HORMIGON ARMADO 13,5 MTS CON DUCTO BAJADA PUESTA A TIERRA, 700 KG CAPACIDAD DE RUPTURA', 5);
INSERT INTO obras.maestro_materiales VALUES (9443, 'PROTE', 'PROTECCIÓN PREFORMADA DE ALUMINIO PARA CABLE AAAC Nº 2 AWG, SIMPRE APOYO (533 MM), COLOR MORADO, CATALOGO MG-0130, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (9444, 'PROTE', 'PROTECCIÓN PREFORMADA DE ALUMINIO PARA CABLE AAAC Nº 2 AWG, DOBLE APOYO (838 MM), COLOR MORADO, CATALOGO MG-0313, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (9445, 'PROTE', 'PROTECCIÓN PREFORMADA DE ALUMINIO PARA CABLE AAAC Nº 1/0 AWG, SIMPLE APOYO (584 MM), COLOR NEGRO, CATALOGO MG-0134, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (10044, 'ELEME', 'ELEMENTO PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 63A, TAMAÑO 1, MARCA ELECTROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (10104, 'LUMIN', 'LUMINARIA 70W SODIO, C/POLICARBONATO S/BASE, C/REACT. COMPEN. E IGNITOR INT. CAT: SRS 203 PHILIPS', 5);
INSERT INTO obras.maestro_materiales VALUES (10317, 'LUMIN', 'LUMINARIA 100W SODIO C/POLICARBONATO SRS-204, C/REACTANCIA COMP. E IGNITOR INTERIOR', 5);
INSERT INTO obras.maestro_materiales VALUES (10318, 'LAMPA', 'LAMPARA VAPOR DE NA ALTA PRESION DE 100W, ROSCA E-40, 100 V ARCO, TUBULAR', 5);
INSERT INTO obras.maestro_materiales VALUES (10493, 'CAJA ', 'CAJA METALICA PARA MEDIDOR 3F ELECTRPNICO ACTIVO - REACTIVO, DIRECTO', 5);
INSERT INTO obras.maestro_materiales VALUES (10504, 'PLACA', 'PLACA DE IDENTIFICACION DE POSTES', 5);
INSERT INTO obras.maestro_materiales VALUES (10530, 'RETEN', 'RETENCION PREFORMADA PARA CABLE PROTEGIDO DE 95MM, CATALOGO ND-0117, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (10563, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 500A,TAMAÑO 3, MARCA ELETROMEC.', 5);
INSERT INTO obras.maestro_materiales VALUES (13548, 'ELEME', 'ELEMENTO FUSIBLE EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (13559, 'CABLE', 'CABLE DE COBRE AISLADO THHN, N° 10 AWG/5,26MM2, COLOR NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (13579, 'CABLE', 'CABLE DE COBRE AISLADO THHN 4/0 AWG/107MM2 NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (13592, 'UNIÓN', 'UNIÓN DE COMPRESIÓN PARA ALAMBRE, # 6 AWG, TIPO NICOPRESS', 5);
INSERT INTO obras.maestro_materiales VALUES (13613, 'ELEME', 'ELEMENTO FUSIBLE CURVA GL 25A TIPO NH TAMAÑO 1, PARA SECCIONADOR O BASE PORTA FUSBLE B.T.', 5);
INSERT INTO obras.maestro_materiales VALUES (13614, 'FUSIB', 'FUSIBLE PARA SECCIONADOR O BASE PORTA FUSIBLE BT, TIPO NH, CURVA GL 40A, TAMAÑO 1, MARCA ELECTROMEC', 5);
INSERT INTO obras.maestro_materiales VALUES (13738, 'CRUCE', 'CRUCETA DE HORMIGON EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (13758, 'FN US', 'FN USAR COD. 6920, CRUCETA DE FIERRO GALVANIZADO 80X80X8 MM L = 1.8M', 5);
INSERT INTO obras.maestro_materiales VALUES (13885, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO THHN, Nº 12 AWG/3,31MM2, PARA B.T., NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (13897, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO THHN, 2/0 AWG, NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (14366, 'ESPIG', 'ESPIGA DE ACERO GALVANIZADO DE 3/4" X 250 MM PARA CAPSULA POLIAMIDA DE 13/8" PARA CRUCETA METALICA', 5);
INSERT INTO obras.maestro_materiales VALUES (14504, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 23KV,  250KVA TAPS 24150/23000/21850/20700/19550', 5);
INSERT INTO obras.maestro_materiales VALUES (14633, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS # 10 AWG (5,26 MM2), PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (14648, 'LAMPA', 'LAMPARA VAPOR DE NA ALTA PRESION 100W, ROSCA E-40, 100V ARCO, PLUS O SUPER, 10.500 LUMENES', 5);
INSERT INTO obras.maestro_materiales VALUES (14664, 'INTER', 'INTERRUPTOR DIFERENCIAL BIPOLAR 2X25A 30MA BVWT-2P-25A-30 RIEL DIN', 5);
INSERT INTO obras.maestro_materiales VALUES (14691, 'TRANS', 'TRANSFORMADOR DE MEDIDA COMPACTO 1F 15KV 15400-220 V, 0,5-1/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (14922, 'CAJA ', 'CAJA EN POLICARBONATO DE DISTRIBUCIÓN DE EMPALMES PARA SIST. DRP, EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (15173, 'LAMPA', 'LAMPARA  VAPOR DE NA ALTA PRESION 150W, ROSCA E-40, 100V ARCO, PLUS O SUPER, 17.500 LUMENES', 5);
INSERT INTO obras.maestro_materiales VALUES (15185, 'CONEC', 'CONECTOR ESTRIBO PUESTA TIERRA AMPAC, PARA CABLE 50 MM2, CON CUBIERTA 444752-3', 5);
INSERT INTO obras.maestro_materiales VALUES (15187, 'CONEC', 'CONECTOR ESTRIBO PUESTA TIERRA AMPAC CABLE 150 MM2 CON CUBIERTA', 5);
INSERT INTO obras.maestro_materiales VALUES (15655, 'TRANS', 'TRANSFORMADOR DE MEDIDA COMPACTO 3F 15KV, 8400-224 V, 5-10-20/5A.', 5);
INSERT INTO obras.maestro_materiales VALUES (15900, 'HILO ', 'HILO FUSIBLE 3A CURVA T PARA SEC.FUS. A.T. EXTERIOR CABEZA REMOVIBLE', 5);
INSERT INTO obras.maestro_materiales VALUES (16036, 'FIJAC', 'FIJACION GALVANIZADA TIPO T C/ABRAZADERA PARA CAÑERIA DE 4"', 5);
INSERT INTO obras.maestro_materiales VALUES (16052, 'ALAMB', 'ALAMBRE DE COBRE AISLADO H07V-U, TIPO NYA, 4 MM2, ROJO', 4);
INSERT INTO obras.maestro_materiales VALUES (16382, 'CONEC', 'CONECTOR AL-CU, DE ALUMNIO Y ACERO GALVANIZADO, PARA ALUMINIO 16-120 mm2 Y DE COBRE 6-35 mm2, CATÁLOGO Nº SM 2.25, MARCA ENSTO SEKKO OY.', 5);
INSERT INTO obras.maestro_materiales VALUES (16456, 'CAPUC', 'CAPUCHON TERMOCONTRAIBLE 1000V RAYCHEM PARA CABLE PREENSAMBLADO 380 -760 MM, 27/50MM, CAT. ESC-4/A', 5);
INSERT INTO obras.maestro_materiales VALUES (16513, 'DIAGO', 'DIAGONAL DE FIERRO GALVANIZADO 0.80 M', 5);
INSERT INTO obras.maestro_materiales VALUES (16536, 'HUINC', 'HUINCHA PLASTICA NEGRA 3M SUPER 33 + Nº 06133', 10);
INSERT INTO obras.maestro_materiales VALUES (16958, 'TUERC', 'TUERCA CONTRATUERCA GALVANIZADA 2"', 5);
INSERT INTO obras.maestro_materiales VALUES (17168, 'FN US', 'FN USAR COD. 6003, PERNO J FIERRO GALVANIZADO DE 1/2" x 5 1/2"  S/PLETINA PARA CAÑERIA DE 1/2" CON TUERCA, GOLILLAS PRESION Y PLANA', 5);
INSERT INTO obras.maestro_materiales VALUES (17679, 'TABLE', 'TABLERO MODULAR 6041 6 CIRCUITO TAPA METALICA', 5);
INSERT INTO obras.maestro_materiales VALUES (17754, 'CAMAR', 'CAMARA CON TAPA DE CONCRETO Ø 300X400 MM TRANSITO LIVIANO', 5);
INSERT INTO obras.maestro_materiales VALUES (17761, 'CONEC', 'CONECTOR MUELA DE BRONCE PARA CONDUCTOR DE COBRE 35 A 70 MM2 CON PERNOSY GOLILLAS DE BRONCE (2-2/0 AWG)', 5);
INSERT INTO obras.maestro_materiales VALUES (18365, 'CONEC', 'CONECTOR BRONCE PARA BARRA TOMA TIERRA  3/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (18661, 'FN US', 'FN USAR COD. 373, INTERRUPTOR AUTOMATICO 1F 10A, 220V CURVA ?? RIEL', 5);
INSERT INTO obras.maestro_materiales VALUES (18711, 'CABLE', 'CABLE DE COBRE AISLADO, SUPERFLEX, MULTIFLEX O COVIFLEX # 10 AWG/5,26MM2, CON AISLACION XTU, PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (18724, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 150KVA, 15KV, NIVEL PERDIDA REDUCIDA, TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (18919, 'ELEME', 'ELEMENTO FUSIBLE CURVA GL 25A TIPO NH TAMAÑO 00, PARA SECCIONADOR O BASE PORTA FUSIBLE B.T, MARCA ELECTROMEC.', 5);
INSERT INTO obras.maestro_materiales VALUES (18921, 'ELEME', 'ELEMENTO FUSIBLE CURVA GL 40A TIPO NH TAMAÑO 00, PARA SECCIONADOR O BASE PORTA FUSIBLE B.T,MARCA ELECTROMEC.', 5);
INSERT INTO obras.maestro_materiales VALUES (19850, 'CONEC', 'CONECTOR AMPACT CUNA AL/CU PARA 70-240 MM2, CATALOGO 1-602031-8, INPULSOR AMARILLO', 5);
INSERT INTO obras.maestro_materiales VALUES (19852, 'CONEC', 'CONECTOR ESTRIBO C/DERIVACION 185 MM2 -1/0 AWG CATEGORIA. 602047-0 AMPACT ', 5);
INSERT INTO obras.maestro_materiales VALUES (19860, 'CUBIE', 'CUBIERTA DE PROTECCIÓN PARA CONECTOR ESTRIBO 300 MM2, SERIE AMARILLA, CAT. 0-602107 AMPACT', 5);
INSERT INTO obras.maestro_materiales VALUES (20057, 'AMARR', 'AMARRA DE COBRE PARA MT SENCILLA DE 800 MM LARGO RECOCIDO', 5);
INSERT INTO obras.maestro_materiales VALUES (20916, 'FN IN', 'FN INTERRUPTOR AUTOMATICO SAIME, 1X30A, 10 KA RUPTURA, CURVA C, ENGANCHE AMERICANO', 5);
INSERT INTO obras.maestro_materiales VALUES (23365, 'FN US', 'FN USAR COD. 44523, RECONECTADOR, SERIE U, MODELO ACO-AUTO CHANGE OVER, 15 kV, 630A, 12,5 kA RUPTURA, CON CONTROL PTCC-TEMPERATE-240-7, CATALOGO U27-ACR-15-12', 5);
INSERT INTO obras.maestro_materiales VALUES (23770, 'TRANS', 'TRANSFORMADOR COMPACTO DE MEDIDA 3F 15KV 8400-224V, 300-600/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (23955, 'SOPOR', 'SOPORTE METALICO PARA MEDIDOR ELECTRONICO ACTARIS ACE 1000 SMO', 5);
INSERT INTO obras.maestro_materiales VALUES (26041, 'POSTE', 'POSTE DE FIERRO GALVANIZADO PETITJEAN MOD. OMEGA 2360; 7 M DE LARGO, CIRCULAR CONICO C/BRAZO RECTO DOBLE LARGO TOTAL 2 M (LARGO POR BRAZO 1 M)', 5);
INSERT INTO obras.maestro_materiales VALUES (26674, 'CONEC', 'CONECTOR SATELITE, CORTO CIRCUITO PARA CONDUCTOR PREENSAMBLADO DE 35 A 95 MM2, CU-AL MODELO TTD-2', 5);
INSERT INTO obras.maestro_materiales VALUES (26706, 'CONEC', 'CONECTOR EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (26935, 'INTER', 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO SAIME, 6 KA RUPTURA, RIEL AMERICANO, CURVA C, 1X10A', 5);
INSERT INTO obras.maestro_materiales VALUES (28521, 'LUMIN', 'LUMINARIA 150W SCHREDER, MOD. ONYX 1, C/KIT DE 150 W SODIO, C/VIDRIO TEMPLADO, C/BALLAST DOBLE POTENCIA, C/PINTURA COLOR AZUL RAL 5010', 5);
INSERT INTO obras.maestro_materiales VALUES (35737, 'ALUMI', 'ALUMINIO PROTEGIDO DISPONIBLE PARA ENAJENACION', 6);
INSERT INTO obras.maestro_materiales VALUES (36128, 'ALUMI', 'ALUMINIO PREENSAMBLADO DIPONIBLE PARA ENAJENACION', 6);
INSERT INTO obras.maestro_materiales VALUES (36292, 'POSTE', 'POSTE DE FIERRO GALVANIZADO TUBULAR DE 3" X 6 M, C/2 VASTAGOS DE 1 1/2"X200MM, C/PLACA Y CANASTILLO', 5);
INSERT INTO obras.maestro_materiales VALUES (36546, 'MUFA ', 'MUFA TERMINAL 3M QT-28A0-S EXTERIOR 15KV C/3 PUNTAS PARA CABLE MONOPLAR AIS. SOL. 35MM2', 5);
INSERT INTO obras.maestro_materiales VALUES (36547, 'MUFA ', 'MUFA TERMINAL 3M QT-28A-S EXTERIOR 15KV C/3 PUNTAS PARA CABLE MONOPOLAR AIS. SOL. 85-120MM2', 5);
INSERT INTO obras.maestro_materiales VALUES (36551, 'MUFA ', 'MUFA TERMINAL 3M QT-15A INTERIOR 15KV C/3 PUNTAS PARA CABLE MONOPOLAR AIS. SOL. 35MM2', 5);
INSERT INTO obras.maestro_materiales VALUES (36779, 'AISLA', 'AISLADOR CERÁMICO SEPARADOR PARA DESCONECTADOR FUSIBLE MOD. PSU-047 MARCA SANTANA', 5);
INSERT INTO obras.maestro_materiales VALUES (36805, 'AISLA', 'AISLADOR PORCELANA TIPO TENSOR, 86 MM DE DIAMETRO, 136 MM DE ALTO, CLASE ANSI 54-3, 9000 KILOS DE RUPTURA', 5);
INSERT INTO obras.maestro_materiales VALUES (36810, 'ALAMB', 'ALAMBRE DE COBRE DESNUDO, DURO, # 4 AWG21,2MM2', 6);
INSERT INTO obras.maestro_materiales VALUES (36892, 'BARRA', 'BARRA ACERO GALVANIZADO CON OJO 3/4" X 2400 MM CON 2 TUERCAS NORMA ENDESA PLANO TM-G102-1', 5);
INSERT INTO obras.maestro_materiales VALUES (36977, 'BUSHI', 'BUSHING ACERO BICROMATADO PARA CAÑERIA 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (36987, 'CABLE', 'CABLE DE ALUMINIO PREENSAMBLADO 2x25 MM2, CON FASE Y NEUTRO AISLADO', 4);
INSERT INTO obras.maestro_materiales VALUES (37346, 'CONTR', 'CONTRATUERCA ACERO ELECTRO GALVANIZADO BICROMATADO PARA CAÑERIA 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (37973, 'MUERT', 'MUERTO CONICO DE CONCRETO PINTADO NORMA ENDESA', 5);
INSERT INTO obras.maestro_materiales VALUES (38072, 'PERNO', 'PERNO DE ACERO GALVANIZADO CON OJO DE 3/4" X 9" X 3" HILO CON TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (38099, 'PERNO', 'PERNO HEXAGONAL ACERO GALVANIZADO GRADO 2, 5/8" X 10" X 5" HILO CON TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (38106, 'PERNO', 'PERNO HEXAGONAL ACERO GALVANIZADO GRADO 2, 5/8" X 2" X 2" HILO CON TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (38143, 'PLACA', 'PLACA DE ACERO GALVANIZADA 300X200X3 MM C/PREFORACION CENTRADAS DE 5/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (38239, 'PRENS', 'PRENSA PARALELA BRONCE PARA CONDUCTOR DE COBRE 8 A 2 AWG CON 1PERNO COCHE 5/16" X 13/4" DE COBRE, 1 TUERCA DE BRONCE Y 1 GOLILLA DEPRESION ESTAÑADA', 5);
INSERT INTO obras.maestro_materiales VALUES (38404, 'TORNI', 'TORNILLO ROSCA LATA N° 8 1 1/4" LARGO', 5);
INSERT INTO obras.maestro_materiales VALUES (38426, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 10KVA, 13200/231V. TAPS 13860/13530/13200/12540/11880', 5);
INSERT INTO obras.maestro_materiales VALUES (38427, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 15KVA, 13200/231V. TAPS 13860/13530/13200/12540/11880', 5);
INSERT INTO obras.maestro_materiales VALUES (38429, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 25KVA, 13200/231V. TAPS 13860/13530/13200/12540/11880, CON BUSHUING', 5);
INSERT INTO obras.maestro_materiales VALUES (38430, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 25KVA, 13200/231V. TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (38432, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 25KVA, 23000/231V. TAPS 24150/23000/21850/20700/19550', 5);
INSERT INTO obras.maestro_materiales VALUES (38436, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F AEREO, 5KVA, 13200/231V. TAPS 13860/13530/13200/12540/11880', 5);
INSERT INTO obras.maestro_materiales VALUES (38463, 'FN US', 'FN USAR COD. 38462, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 150KVA, 13200/400-231V. TAPS 13860/13530/13200/12540/11880', 5);
INSERT INTO obras.maestro_materiales VALUES (38466, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 200KVA, 13200/400-231V. TAPS 13530/13200/12540/11880/11550', 5);
INSERT INTO obras.maestro_materiales VALUES (38478, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 30KVA, 13200/400-231V. TAPS 13530/13200/12540/11880/11550', 5);
INSERT INTO obras.maestro_materiales VALUES (38480, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 30KVA, 23000/400-231V, CON BUSHING CLASE 34,5 KV., TAPS 24150/23000/21850/20700/19550', 5);
INSERT INTO obras.maestro_materiales VALUES (38482, 'FN US', 'FN USAR COD. 38481, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 300KVA, 13200/400-231V. TAPS 13860/13530/13200/12540/11880   ', 5);
INSERT INTO obras.maestro_materiales VALUES (38489, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 45KVA, 13200/400-231V. TAPS 13530/13200/12540/11880/11550                                                                                                                                                      ', 5);
INSERT INTO obras.maestro_materiales VALUES (38490, 'FN US', 'FN USAR COD. 38489, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 45KVA, 13200/400-231V. TAPS 13860/13530/13200/12540/11880                                                                                                                                                                 ', 5);
INSERT INTO obras.maestro_materiales VALUES (38495, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 75KVA, 13200/400-231V., TAPS 13530/13200/12540/11880/11550', 5);
INSERT INTO obras.maestro_materiales VALUES (38496, 'FN US', 'FN USAR COD. 38495, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 75KVA, 13200/400-231V., TAPS 13860/13530/13200/12540/11880                                                                                                                                                                  ', 5);
INSERT INTO obras.maestro_materiales VALUES (38512, 'TUBO ', 'TUBO DE ACERO LAMINADO GALVANIZADO PARA TIRANTE DIA. 90X2500 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (38590, 'TRANS', 'TRANSFORMADOR DE MEDIDA COMPACTO 3F 15KV 8400-224V RAZON 1-3-5/5A', 5);
INSERT INTO obras.maestro_materiales VALUES (40577, 'PERNO', 'PERNO HEXAGONAL ACERO GALVANIZADO DE 1/2" X 1 1/2" X 1 1/2" DE HILO CON TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (40764, 'CAÑER', 'CAÑERIA ISO R II LIVIANA GALVANIZADA 1" x 6 METROS CON HILO SIN COPLA', 7);
INSERT INTO obras.maestro_materiales VALUES (40765, 'CAÑER', 'CAÑERIA ISO R II LIVIANA GALVANIZADA 1/2" x 3 METROS, C/HILO POR UN EXTREMO SIN COPLA', 7);
INSERT INTO obras.maestro_materiales VALUES (40766, 'CAÑER', 'CAÑERIA ISO R II LIVIANA GALVANIZADA 1/2" x 6 METROS CON HILO SIN COPLA', 7);
INSERT INTO obras.maestro_materiales VALUES (40777, 'SAL G', 'SAL GEOELÉCT GEO GEL 8+ PARA MEJORAMIENTO TIERRA BOLSA 7 KG', 11);
INSERT INTO obras.maestro_materiales VALUES (40958, 'FUSIB', 'FUSIBLE CABEZA REMOVIBLE 25KV CURVA S 1A .CAT. 1S-FC', 5);
INSERT INTO obras.maestro_materiales VALUES (40998, 'LUMIN', 'LUMINARIA 70W SODIO, MARCA BRISA VIDRIO LENTICULAR IP OPTICO 65, IP ELECTRICO 64 COLOR GIS STANDARD, SIN BASE, BALLAST LAYRTON NORMAL', 5);
INSERT INTO obras.maestro_materiales VALUES (40999, 'LUMIN', 'LUMINARIA 100W SODIO MARCA BRISA VIDRIO LENTICULAR IP OPTICO 65, IP ELECTRICO 64 COLOR GIS STANDARD, SIN BASE, BALLAST LAYRTON NORMAL', 5);
INSERT INTO obras.maestro_materiales VALUES (41294, 'ACCES', 'ACCESORIOS EN GENERAL EN MAL ESTADO', 5);
INSERT INTO obras.maestro_materiales VALUES (41797, 'RIEL ', 'RIEL DIN SIMETRICO 75 MM T 2 MT', 4);
INSERT INTO obras.maestro_materiales VALUES (43453, 'LISTA', 'LISTA MATERIALES NO RECUPERABLE', 5);
INSERT INTO obras.maestro_materiales VALUES (44523, 'RECON', 'RECONECTADOR ELECTRONICO, 27 KV, 630A, 12,5 KA DE RUPTURA, MARCA NOJA POWER, Nº CATALOGO OSM-27-12-630 SIN MODULO I/O', 5);
INSERT INTO obras.maestro_materiales VALUES (45016, 'LUMIN', 'LUMINARIA LED 36W TECEO1 5119 FH VP 16LED 36W NW BACKLIGHT (70W SODIO)', 5);
INSERT INTO obras.maestro_materiales VALUES (45601, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 112,5KVA, 15KV CON PERDIDA REDUCIDAS, TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (45989, 'PERNO', 'PERNO DE ACERO INOXIDABLE CABEZA HEXAGONAL DE 1/2"X1 1/4" SIN TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (45990, 'TUERC', 'TUERCA HEXAGONAL DE ACERO INOXIDABLE PARA PERNO 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (45991, 'GOLIL', 'GOLILLA PRESION DE ACERO INOXIDABLE PARA PERNO DE 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (48775, 'MEDID', 'MEDIDOR ELECTRONICO 1F 5(60) A 220V 50 HZ 1600 PULS/KWH TIPO SC-MR MARCA SCORPION', 5);
INSERT INTO obras.maestro_materiales VALUES (48972, 'TARUG', 'TARUGO DE PLASTICO S-8', 5);
INSERT INTO obras.maestro_materiales VALUES (49217, 'AMARR', 'AMARRA DE PASADA PREFORMADA PLÁSTICA PARA CABLE PROTEGIDO 50MM2, LARGO MÍNIMO 483 MM, DIÁMETRO 18,25MM. RANGO DIAMETRO MM 13,74 A 18,54', 5);
INSERT INTO obras.maestro_materiales VALUES (51156, 'FN US', 'FN USAR COD. 40998, LUMINARIA 70W SODIO, PHILIPS C/POLICARBONATO IC 220V 50HZ S/BASE, P-P 1X2, SRS-303', 5);
INSERT INTO obras.maestro_materiales VALUES (51157, 'FN US', 'FN USAR COD. 40999, LUMINARIA 100W SODIO PHILIPS C/POLICARBONATO IC 220V 50HZ S/BASE, P-P 1X2, SRS-303', 5);
INSERT INTO obras.maestro_materiales VALUES (51479, 'CONJU', 'CONJUNTO SEGURIDAD PERNO TORQUE RADIAL, INCLUYE; 1 PERNO ACERO TEMPLADO Y ZINCADO, 1 TAPÓN ACERO ZINCADO Y 1 GOLILLA DENTADA DE ACERO TEMPLADO Y ZINCADA ', 5);
INSERT INTO obras.maestro_materiales VALUES (51554, 'KIT M', 'KIT MODEM DIGI 3G, CATÁLOGO WAM-DIGI3G-KIT-001, INCLUYE ADAPTADOR PARARIEL DIN, CABLE DE PODER Y ANTENA OMNI 7.', 5);
INSERT INTO obras.maestro_materiales VALUES (52364, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCIÓN 1F, 25KVA, 7620/231V. CON 2 BUSHINGTAPS 7620/7240/6860', 5);
INSERT INTO obras.maestro_materiales VALUES (52460, 'FN US', 'FN USAR COD. 62393, TRANSFORMADOR DE POTENCIAL 1F, 15/0,22 KV, 200VA, TIPO SECO, MARCA NOJA POWER(PARA RECONECTADORES)', 5);
INSERT INTO obras.maestro_materiales VALUES (52924, 'BUSHI', 'BUSHING GALVANIZADO PARA CONDUIT 2"', 5);
INSERT INTO obras.maestro_materiales VALUES (53481, 'CONEC', 'CONECTOR SATELITE TTD2CC 35-95MM2, MARCA SICAME, CAT:TTD2', 5);
INSERT INTO obras.maestro_materiales VALUES (55355, 'LUMIN', 'LUMINARIA LED 55W MODELO TECEO1 5102 FHV VP 24 LED (55 W) NW CL 1 CNS, SCHREDER (100 W SODIO)', 5);
INSERT INTO obras.maestro_materiales VALUES (55358, 'LUMIN', 'LUMINARIA LED 90W MODELO TECEO1 5102 FHV VP 40 LED (90 W) NW CL 1 CNS, SCHREDER (150 W SODIO)', 5);
INSERT INTO obras.maestro_materiales VALUES (55429, 'FN US', 'FN USAR COD. 44523, RECONCTADOR MODELO REC27, 27 kV, 630A, 12,5 kA RUPURA, CON CONTROL CC/TEL-01-07, 125 kV, INCLUYE ENTRADAS I/O, 6 SENSORES DE CORRIENTES 6 SENSORES DE VOLTAJE, MARCA TAVRIDA', 5);
INSERT INTO obras.maestro_materiales VALUES (56075, 'KIT D', 'KIT DE CELDAS SM6 MODELO GAM2 DE ENTRADA DE CABLES C/SECCIONADOR. CLASE24KV 630A 25KA AFL 12,5KA', 5);
INSERT INTO obras.maestro_materiales VALUES (56076, 'KIT D', 'KIT DE CELDAS DE SM6 MODELO GBC-B DE MEDICION, CLASE 24KV 630A 25KA AFL12,5KA + 3TI''S+3TT''S', 5);
INSERT INTO obras.maestro_materiales VALUES (56427, 'KIT D', 'KIT DE CELDAS SM6 MODELO QM DE PROTECCIÓN, SECCIONADOR-FUSIBLE CLASE24KV 630A 25KA AFL 12.5 KA', 5);
INSERT INTO obras.maestro_materiales VALUES (57075, 'BARRA', 'BARRA TOMA TIERRA 3/4 3MT T/2 400 MICAS', 5);
INSERT INTO obras.maestro_materiales VALUES (57315, 'MEDID', 'MEDIDOR DIRECTO CL/1 NXT4 3X230/400V 5(120)A', 5);
INSERT INTO obras.maestro_materiales VALUES (57316, 'MEDID', 'MEDIDOR 3F INDIRECTO CL/1 NXT4 3X230/400V 1(6)A', 5);
INSERT INTO obras.maestro_materiales VALUES (57365, 'TRANS', 'TRANSFORMADOR MEDIDA COMPACTO 15KV 100-200-300/5A 8400-224V', 5);
INSERT INTO obras.maestro_materiales VALUES (62393, 'TRANS', 'TRANSFORMADOR POTENCIAL SECO PARA INTEMPERIE 23-15-12/0,220 KV 200 VA, PARA RECONECTADORES, DISTANCIA DE FUGA MÍNIMA 625 MM., IP 67.', 5);
INSERT INTO obras.maestro_materiales VALUES (63153, 'KIT S', 'KIT SAE MATERIALES', 5);
INSERT INTO obras.maestro_materiales VALUES (63241, 'CARBO', 'CARBONCILLO PUESTAS TIERRA SACO 25KG', 13);
INSERT INTO obras.maestro_materiales VALUES (63934, 'LUMIN', 'LUMINARIA LED 90W VIAL CLASE P2', 5);
INSERT INTO obras.maestro_materiales VALUES (65340, 'LUMIN', 'LUMINARIA LED 50W CLEVER GOLD BF BLANCO IK 08, CREE IP 66, CUERPO DE ALUMINIO INYECTADO CONEXIONADO LED INDEPENDIENTE (EQUIVALENTE 100 W NORMAL', 5);
INSERT INTO obras.maestro_materiales VALUES (65351, 'LUMIN', 'LUMINARIA LED 30W BF CLEVER GOLD BLANCO IP66 IK 08, CREE IP 66, CUERPO DE ALUMINIO INYECTADO CONEXIONADO LED INDEPENDIENTE (EQUIVALENTE 60 W NORMAL)', 5);
INSERT INTO obras.maestro_materiales VALUES (65422, 'LUMIN', 'LUMINARIA LED 55W MODELO TECEO1 5136 FHV VP 24 LED (55 W) NW CL 1 CNS, SCHREDER  7PIN(100 W SODIO)', 5);
INSERT INTO obras.maestro_materiales VALUES (65424, 'LUMIN', 'LUMINARIA LED 90W MODELO TECEO1 5136 FHV VP 40 LED (90 W) NW CL 1 CNS, SCHREDER  7PIN(150 W SODIO)', 5);
INSERT INTO obras.maestro_materiales VALUES (65481, 'POSTE', 'POSTE CONICO 6M CON BRAZO DOBLE 100CM', 5);
INSERT INTO obras.maestro_materiales VALUES (65517, 'TRANS', 'TRANSFORMADOR DE DISTRIBUCION 3F, TIPO SECO 250KVA 15/0,4-0,23KV TRIHAL', 5);
INSERT INTO obras.maestro_materiales VALUES (65519, 'TRANS', 'TRANSFORMADOR COMPACTO DE MEDIDA 5-10-20/5 8400/240V', 5);
INSERT INTO obras.maestro_materiales VALUES (66300, 'POSTE', 'POSTE TUBULAR 6 M CON BRAZO DOBLE RECTO 1 M', 5);
INSERT INTO obras.maestro_materiales VALUES (66311, 'POSTE', 'POSTE TUBULAR 6 M CON 1 BRAZO RECTO 1 M', 5);
INSERT INTO obras.maestro_materiales VALUES (10752, 'SOPOR', 'SOPORTE GALVANIZADO PARA 3 SECCIONADORES EXTERIORES FUSIBLES NH APR 630', 5);
INSERT INTO obras.maestro_materiales VALUES (6897, 'HUINC', 'HUINCHA AISLADORA 3M, 3/4" X 20 MTS X 0,18 MM ESPESOR, SCOTCH SUPER 33+, CAT: 80-6112-0701-2, COLOR NEGRO', 10);
INSERT INTO obras.maestro_materiales VALUES (447, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X15"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (437, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X3"X1 1/2" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (1020, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X1 1/2"X1" DE HILO CON TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (7475, 'PARAR', 'PARARRAYO CLASE DISTRIBUCIÓN, 23KV, TIPO VARISTAR 19,5 KV, CUERPO DE GOMA SILICONADA, INCLUYE ESTR. SOPORTE DE MONTAGE, MARCA COOPER POWER', 5);
INSERT INTO obras.maestro_materiales VALUES (19951, 'DIAGO', 'DIAGONAL PLETINA FIERRO GALVANIZADO 32X6X800 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (71, 'ALAMB', 'FN USAR COD. 13559, ALAMBRE DE COBRE AISLADO, TIPO THW, # 10 AWG (5,26 MM2) PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (19843, 'CONEC', 'CONECTOR AMPACT CUNA Al/CU PASO-DERIVACION (300-240 MM2), CAT. 1-602031-2, IMPULSOR AMARILLO', 5);
INSERT INTO obras.maestro_materiales VALUES (438, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X5"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (9963, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 3X50/50MM2, FASE Y NEUTRO AISLADOS, AISLACION DE POLIETILENO RETICULADO (XLPE), CAPA PROTECTORA', 4);
INSERT INTO obras.maestro_materiales VALUES (255, 'GOLIL', 'GOLILLA DE NEOPLENE DE 3 MM ESPESOR Y 2,7 X 4,0 CM DIAMETRO INTERIOR Y EXTERIOR RESPECTIVAMENTE', 5);
INSERT INTO obras.maestro_materiales VALUES (594, 'TUERC', 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA PERNO DE 5/8" HILO GRUESO BSW', 5);
INSERT INTO obras.maestro_materiales VALUES (59, 'ALAMB', 'ALAMBRE DE COBRE DESNUDO, DURO, # 5 AWG 16 MM2', 6);
INSERT INTO obras.maestro_materiales VALUES (14743, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CON OJO DE 5/8"X15"X12" DE HILO C/TUERCA , GOLILLA PLANA Y DE PRESION', 5);
INSERT INTO obras.maestro_materiales VALUES (9453, 'CONEC', 'CONECTOR AMPACT, 33-85 MM2, PASO, 25-67 MM2 DERIVACION, INPULSOR AZUL, 600403', 5);
INSERT INTO obras.maestro_materiales VALUES (5597, 'CONDU', 'CONDULET (CABEZA DE SERVICIO) PARA CAÑERIA 4" CON SALIDAS PARA 7 CONDUCTORES', 5);
INSERT INTO obras.maestro_materiales VALUES (22191, 'CAJA ', 'CAJA METALICA ANTI-HURTO PINTADA CIERRE POR IMPACTO, 49X24X15 CM (ALTO X ANCHO X FONDO) C/PERNO DE 7 RANURAS', 5);
INSERT INTO obras.maestro_materiales VALUES (13, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 45KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (9955, 'SOPOR', 'SOPORTE DE SUSPENSION PARA CABLE PREENSAMBLADO', 5);
INSERT INTO obras.maestro_materiales VALUES (22284, 'BRAZO', 'BRAZO RECTO DE ACERO GALVANIZADO DE CAÑERIA ISO R65 DE  2", TIPO L- 400 PARA LUMINARIA DE 250 Y 400 W.', 5);
INSERT INTO obras.maestro_materiales VALUES (44, 'AISLA', 'AISLADOR ESPIGA DE PORCELANA 5 1/2" DE DIAMETRO, 9" DISTANCIA DE FUGA, ROSCA 1", CLASE ANSI 55-4, COLOR GRIS, REFERENCIA SANTANA PI23152-RT', 5);
INSERT INTO obras.maestro_materiales VALUES (5154, 'BRAZO', 'BRAZO DE MONTAJE 3M TIPO MB-3, PARA CABLE SUBTERRANEO MONOPOLAR ENTRE 20 Y 32 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (17285, 'GRILL', 'GRILLETE GALVANIZADO C/GUARDACABO, PASADOR Y CHAVETA', 5);
INSERT INTO obras.maestro_materiales VALUES (19220, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO PURO 1350 PROTEGIDO, 1X185 MM2, PARA LINEAS AEREAS 25 KV, AISLACION XLPE', 4);
INSERT INTO obras.maestro_materiales VALUES (20, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 300KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (10035, 'CONEC', 'CONECTOR TIPO CUNA AMPACTINHO MODELO UDC TIPO II, CAT. 8817831-1 (16 CON 16)', 5);
INSERT INTO obras.maestro_materiales VALUES (72, 'ALAMB', 'FN USAR COD. 13560, ALAMBRE DE COBRE AISLADO, TIPO THW, # 8 AWG (8,37 MM2), PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (14734, 'CONEC', 'CONECTOR AMPACT, 185 MM2 PASO, 185 MM2 DERIVACION, INPULSOR AZUL, 602046-9', 5);
INSERT INTO obras.maestro_materiales VALUES (433, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X5"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (51, 'AISLA', 'AISLADOR DE TENSION DE PORCELANA, 73 MM DE DIAMETRO, 108 MM DE ALTO, CLASE ANSI 54-2, COLOR GRIS, REFERENCIA SANTANA CA12014, PLANO CGE M-1833-N', 5);
INSERT INTO obras.maestro_materiales VALUES (10529, 'AMARR', 'AMARRA DE PASADA PREFORMADA PLASTICA PARA CABLE PROTEGIDO 70/185MM, CATALOGO TTF-1202, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (1022, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X2"X11/2" DE HILO CON TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (19221, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO PURO 1350 PROTEGIDO, 1X300 MM2, PARA LINEAS AEREAS 25 KV MONOCAPA', 4);
INSERT INTO obras.maestro_materiales VALUES (10036, 'CUBIE', 'CUBIERTA DE POLIETILENO AMPACTINHO TIPO I, PARA CONECTOR TIPO CUNA MOD. UDC TIPO I', 5);
INSERT INTO obras.maestro_materiales VALUES (19278, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 200KVA, 15/400-231V. TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (19845, 'CRUCE', 'CRUCETILLA DE FIERRO GALVANIZADA DE 65X65X1200 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (13932, 'PLACA', 'PLACA DE IDENTIFICACION DE SUBESTACIONES EN TERRENO (VERTICAL), PLANO 9689-A3', 5);
INSERT INTO obras.maestro_materiales VALUES (6234, 'ALAMB', 'ALAMBRE DE COBRE AISLADO, TIPO THHN, # 14 AWG (2,08 MM2), PARA A.P. COLOR NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (181, 'CAÑER', 'CAÑERIA GALVANIZADA, TIPO ISO R II 1/2", CON HILO SIN COPLA', 4);
INSERT INTO obras.maestro_materiales VALUES (13379, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 2X16 MM2, PARA ACOMETIDAS, FASE Y NEUTRO AISLADOS, AISLACION DE POLIETILENO RETICULADO (XLPE)', 4);
INSERT INTO obras.maestro_materiales VALUES (10531, 'AMARR', 'AMARRA DE PASADA CON ANGULO PREFORMADA PLASTICA PARA CABLE PROTEGIDO 95MM, CATALOGO SSF-2253, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (446, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X14"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (9957, 'CONEC', 'CONECTOR DE EMPALME PARA CABLES PREENSAMBLADO A PERFORACION, UNA DERIVACION, RED ALUMINIO 35/95 MM2, PI-71 MARCA NILED', 5);
INSERT INTO obras.maestro_materiales VALUES (13595, 'UNION', 'UNIÓN DE COMPRESIÓN PARA ALAMBRE, # 5 AWG, TIPO NICOPRESS', 5);
INSERT INTO obras.maestro_materiales VALUES (14733, 'CONEC', 'CONECTOR AMPACT, 150 MM2 PASO, 95 MM2 DERIVACION, 602046-7, INPULSOR AZUL', 5);
INSERT INTO obras.maestro_materiales VALUES (4013, 'INT A', 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 3F MITSUBISHI, 600V, 3X300A., 35KA RUPTURA, NF-400-CW, CAT. 210257', 5);
INSERT INTO obras.maestro_materiales VALUES (618, 'VIGUE', 'VIGUETA U PORTA VIGA GALVANIZADA DE 125 X 60 X 5 X 500 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (9956, 'GRAPA', 'GRAPA DE SUSPENSION PLASTICA PARA CABLE PREENSAMBLADO, SIMILAR A CAVANNA MODELO DSP-500', 5);
INSERT INTO obras.maestro_materiales VALUES (13847, 'AMARR', 'RETENCION PREFORMADA DE ALUMNIO PARA CABLE PROTEGIDO DE 50 y 70mm2, CATALOGO ND-0115, MARCA PLP., D=18,25MM', 5);
INSERT INTO obras.maestro_materiales VALUES (445, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X12"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (1145, 'TUBO ', 'TUBO CONDUIT 63 MM X 6 MT PVC ALTA DENSIDAD CLASE II TIPO ANGER (NARANJA)', 4);
INSERT INTO obras.maestro_materiales VALUES (14741, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CON OJO DE 5/8"X7"X3" DE HILO C/TUERCA , GOLILLA PLANA Y DE PRESION', 5);
INSERT INTO obras.maestro_materiales VALUES (50, 'AISLA', 'AISLADOR DE CARRETE DE PORCELANA, 79 MM DE DIAMETRO, 76 MM DE ALTO, ANSI53-2, TE-1011', 5);
INSERT INTO obras.maestro_materiales VALUES (249, 'DIAGO', 'DIAGONAL DE FIERRO GALVANIZADO PLANO DE 32X6X935 MM, CON UNA AGUJEREDURADE 1/2" EN UN EXTREMO Y 2 AGUJEREADURAS DE 5/8" EN EL OTRO EXTREMO', 5);
INSERT INTO obras.maestro_materiales VALUES (13639, 'CRUCE', 'CRUCETA DE FIERRO GALVANIZADO 80X80X8X2400 MM, NORMA CGE, PL M2360-N', 5);
INSERT INTO obras.maestro_materiales VALUES (23063, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO PROTEGIDO, 1X95 MM2, PARA LINEA SAEREAS 25 KV, AISLACION XLPE', 4);
INSERT INTO obras.maestro_materiales VALUES (33870, 'GRILL', 'GRILLETE GALVANIZADO CON GUARDACABO PASADOR Y CHAVETA TIPO 2 PARA CABLE 300 MM2', 5);
INSERT INTO obras.maestro_materiales VALUES (616, 'VIGA ', 'VIGA U PORTA TRANSFORMADOR GALVANIZADA DE 125X60X5X2320 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (635, 'AISLA', 'AISLADOR POLIMERICO DE SILICONA SUSPENSION CLASE 28KV, MARCA SILPAK', 5);
INSERT INTO obras.maestro_materiales VALUES (17804, 'CONEC', 'CONECTOR RECTO PARA TUBO FLEXIBLE 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (17, 'TRAFO', 'USAR COD. 45601, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 100KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (545, 'SOPOR', 'SOPORTE DE REMATE GALVANIZADO DE 1 VIA, PARA B.T., PARA AISLADOR CARRETE DE 57MM, ORIFICIO CENTRAL 14MM.', 5);
INSERT INTO obras.maestro_materiales VALUES (13768, 'FIJAC', 'FN USAR COD. 6003, PERNO "J" DE FIERRO GALVANIZADO DE 1/2" X 5 1/2" CON PLETINA PARA CAÑERIA 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (13563, 'CABLE', 'CABLE DE COBRE AISLADO THHN, Nº 2 AWG/33,63MM2, NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (6083, 'MUFA ', 'MUFA TERMINAL EXTERIOR RAYCHEM 15KV C/3 PUNTAS PARA CABLE MONOPOLAR AISLACION SOLIDA 4-3/0 AWG, HVT-151-S-GP-CL', 9);
INSERT INTO obras.maestro_materiales VALUES (160, 'CAJA ', 'CAJA METALICA PARA MEDIDOR 1F 400X200 MM, TIPO INTEMPERIE CON VISOR', 5);
INSERT INTO obras.maestro_materiales VALUES (560, 'CONEC', 'CONECTOR SOLDABLE TERMINAL DE CU-NI REMA TIPO ESTAMPADO, PARA CABLE 35 MM2 (2 AWG)', 5);
INSERT INTO obras.maestro_materiales VALUES (9456, 'CONEC', 'CONECTOR AMPACT, 85-95 MM2, PASO, 85-95 MM2 DERIVACION, INPULSOR AZUL, 600459  ', 5);
INSERT INTO obras.maestro_materiales VALUES (5756, 'CABLE', 'CABLE DE COBRE MONOPOLAR APANTALLADO, CON AISLACION SOLIDA XLPE, # 3/0 AWG (85 MM2) 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (7564, 'SOPOR', 'SOPORTE DE PASADA LARGO PARA UNA VIA, LARGO TOTAL 374 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (251, 'DIAGO', 'DIAGONAL DE FIERRO GALVANIZADO L 50X50X6X935 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (10, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 30KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (183, 'CAÑER', 'CAÑERIA GALVANIZADA, TIPO ISO R II, 1", CON HILO SIN COPLA', 4);
INSERT INTO obras.maestro_materiales VALUES (14732, 'CONEC', 'CONECTOR AMPACT, 150 MM2 PASO, 70-85 MM2, DERIVACION, 602046-6, INPULSOR AZUL  ', 5);
INSERT INTO obras.maestro_materiales VALUES (10037, 'CUBIE', 'CUBIERTA DE POLIETILENO AMPACTINHO TIPO II, PARA CONECTOR TIPO CUNA MOD. UDC TIPO II, 881225-1', 5);
INSERT INTO obras.maestro_materiales VALUES (484, 'PLETI', 'PLETINA GALVANIZADA LARGA DE 75X10X475 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (763, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 1/0 AWG (53,5 MM2), PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (9936, 'CAÑER', 'CAÑERIA GALVANIZADA TIPO ISO R II LIVIANA 4" X 6 MTS CON HILO SIN COPLA', 4);
INSERT INTO obras.maestro_materiales VALUES (13576, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS # 8 AWG (8,37 MM2), PARA B.T. COLOR NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (6334, 'CABLE', 'CABLE DE ACERO GALVANIZADO DE 3/8" PARA TIRANTE Y MENSAJERO, TIPO EXTRA ALTA RESISTENCIA, KDURA, NORMA ASTM A-475', 4);
INSERT INTO obras.maestro_materiales VALUES (136, 'CABLE', 'CABLE DE COBRE DESNUDO, DURO, # 3/0 AWG (85,0MM2) 7 HEBRAS, ESP.29 A-124', 6);
INSERT INTO obras.maestro_materiales VALUES (14914, 'CONEC', 'CONECTOR A PERFORACION PARA RED PREENSAMBLADA 35-95 MM2 C/RED DESNUDA AL/CU 7-95 MM2 CATEGORIA NTD301EF, MARCA SICAME', 5);
INSERT INTO obras.maestro_materiales VALUES (762, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 4 AWG (21,2 MM2), PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (16, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 75KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (295, 'GOLIL', 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA DE 50X50X2 MM, PARA CAÑERIA DE 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (13561, 'CABLE', 'CABLE DE COBRE AISLADO THHN, Nº 6 AWG/13,3MM2 NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (17594, 'GRAMP', 'GRAMPA ANCLAJE DE ACERO PARA CONDUCTOR DE COBRE 6 a 2 AWG (13-35 MM2)', 5);
INSERT INTO obras.maestro_materiales VALUES (569, 'BARRA', 'BARRA TOMA TIERRA COPPERWELD DE 5/8" X 3 MTS, 400 MICRONES', 5);
INSERT INTO obras.maestro_materiales VALUES (19376, 'AMARR', 'AMARRA DE PASADA PREFORMADA PLASTICA PARA CABLE PROTEGIDO 300 MM2 CAT. TTF-1203, MARCA PLP.LARGOMÍNIMO 610 MM, DIÁMETRO 30,80MM.', 5);
INSERT INTO obras.maestro_materiales VALUES (1248, 'POSTE', 'POSTE DE CONCRETO ARMADO DE 9 MTS, C/PLACA DE IDENTIFICACION', 5);
INSERT INTO obras.maestro_materiales VALUES (1146, 'TUBO ', 'TUBO CONDUIT 90MM X 6 MT PVC ALTA DENSIDAD CLASE II TIPO ANGER (NARANJA)', 4);
INSERT INTO obras.maestro_materiales VALUES (235, 'CRUCE', 'CRUCETA DE FIERRO GALVANIZADA L 80X80X10X2000MM', 5);
INSERT INTO obras.maestro_materiales VALUES (118, 'BOQUI', 'BOQUILLA DE BAKELITA CON TUERCA PARA CALECO', 5);
INSERT INTO obras.maestro_materiales VALUES (434, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X9"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (9452, 'CONEC', 'CONECTOR AMPACT, 33-53 MM2, PASO, 25-33 MM2 DERIVACION, INPULSOR ROJO, 600529  ', 5);
INSERT INTO obras.maestro_materiales VALUES (6005, 'HEBIL', 'HEBILLA DE ACERO INOXIDABLE TIPO 201 DE 5/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (9448, 'PROTE', 'PROTECCIÓN PREFORMADA DE ALUMINIO PARA CABLE AAAC Nº 3/0 AWG, DOBLE APOYO (991 MM), COLOR VERDE, CATALOGO MG-0321, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (10589, 'SECC ', 'SECCIONADOR CUCHILLO S&C, 25 KV, 900A. TIPO OVERHEAD POLE-TOP LOADBUSTER, 150KV BIL, CAT. 18933-AB, CON CONECTOR DE ALUMINIO ', 5);
INSERT INTO obras.maestro_materiales VALUES (7618, 'ESPIG', 'ESPIGA GALVANIZADA 3/4"X150MM UTILES, 210MM TOTALES, CAPSULA 1 3/8", PARA CRUCETA METALICA', 5);
INSERT INTO obras.maestro_materiales VALUES (145, 'CABLE', 'FN USAR COD. 13579, CABLE DE COBRE AISLADO, TIPO THW, # 4/0 AWG (107 MM2) PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (13564, 'CABLE', 'CABLE DE COBRE AISLADO THHN, Nº 1 AWG/42MM2 NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (9954, 'TUERC', 'TUERCA DE ACERO GALVANIZADO CON OJO PARA PERNO OJO DE 5/8", HILO GRUESO BSW', 5);
INSERT INTO obras.maestro_materiales VALUES (10007, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 2X16 MM2. (NEUTRO DESNUDO),AISLACION DE POLIETILENO RETICULADO (XLPE), TENSION NOMINAL 1.100 VOLT', 4);
INSERT INTO obras.maestro_materiales VALUES (14735, 'CUBIE', 'CUBIERTA DE PROTECCIÓN PARA CONECTOR AMPACT, 15KV PARA N 444423-1', 5);
INSERT INTO obras.maestro_materiales VALUES (13764, 'ESPIG', 'ESPIGA GALVANIZADA CANAL PUNTA DE POSTE 506X125X350 CAPSULA 1 3/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (646, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 15KVA, 15KV, 2X220V., 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (26574, 'POSTE', 'POSTE DE HORMIGON ARMADO 9,5 MTS (POSTE DE 11,5 MTS RECORTADO A 9.5 EN EL EXTREMO SUPERIOR) C/PLACA DE IDENTIFICACION', 5);
INSERT INTO obras.maestro_materiales VALUES (14742, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CON OJO DE 5/8"X9"X3" DE HILO C/TUERCA , GOLILLA PLANA Y DE PRESION', 5);
INSERT INTO obras.maestro_materiales VALUES (13789, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X17"X14" DE HILO CON 3 TUERCAS', 5);
INSERT INTO obras.maestro_materiales VALUES (36166, 'SOPOR', 'SOPORTE GALVANIZADO DE PASO EN ANGULO Y CANTILEVER PARAREDES COMPACTAS C/PRENSA', 5);
INSERT INTO obras.maestro_materiales VALUES (269, 'ESPAC', 'ESPACIADOR GALVANIZADO PARA B.T. PARA 5 SOPORTES DE 1 VIA', 5);
INSERT INTO obras.maestro_materiales VALUES (442, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X9"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (85, 'RETEN', 'RETENCION PREFORMADA DE ACERO GALVANIZADO PARA TIRANTE DE ACERO GALVANIZADO DE 3/8" DIAMETRO, CATALOGO GDE-1107HB, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (743, 'CABLE', 'CABLE DE COBRE DESNUDO, DURO, # 4/0 AWG (107 MM2) 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (2778, 'CONEC', 'CONECTOR DE COMPRESIÓN RECTO 3M, CATEGORIA 10003, PARA CABLE STANDARD 2 AWG O COMPACTO 1 AWG', 5);
INSERT INTO obras.maestro_materiales VALUES (1241, 'POSTE', 'POSTE DE PINO IMPREGNADO EN SALES 9.00 MTS CLASE V', 5);
INSERT INTO obras.maestro_materiales VALUES (6644, 'SELLO', 'SELLO TERMOCONTRACTIL RAYCHEM, BAJADA 3 CABLES MONOPOLAR AT HASTA 500 MCM, EN DUCTO 3", MODELO 402-W-439', 5);
INSERT INTO obras.maestro_materiales VALUES (9308, 'CAÑER', 'CAÑERIA GALVANIZADA TIPO ISO R II LIVIANA 2" X 6 METROS CON HILO SIN COPLA', 4);
INSERT INTO obras.maestro_materiales VALUES (840, 'COPLA', 'COPLA GALVANIZADA 1" PARA CAÑERIA', 5);
INSERT INTO obras.maestro_materiales VALUES (13370, 'AMARR', 'RETENCIÓN PREFORMADA PARA CABLE PROTEGIDO DE 185 MM2, LARGO MÍNIMO 1143MM, DIÁMETRO 26,25MM. MM 25,55 A 27,18, ND-0120, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (9591, 'MORDA', 'MORDAZA DE ACOMETIDA PARA ALAMBRES CONCENTRICO DE REDES, PARA SISTEMA D.R.P.', 5);
INSERT INTO obras.maestro_materiales VALUES (10034, 'CONEC', 'CONECTOR TIPO CUNA AMPACTINHO MODELO UDC TIPO I, CAT. 881781-1, (25 CON 25)', 5);
INSERT INTO obras.maestro_materiales VALUES (7991, 'BASE ', 'BASE DE MONTAJE DE CONTROL FOTOELECTRICO PARA USO EN A.P., C/BRAZO DE SUJECION', 5);
INSERT INTO obras.maestro_materiales VALUES (182, 'CAÑER', 'CAÑERIA GALVANIZADA, TIPO ISO R II 3/4", CON HILO SIN COPLA', 4);
INSERT INTO obras.maestro_materiales VALUES (6903, 'CABLE', 'CABLE DE CONTROL, TIPO CTT O TCC, 7 X # 12 AWG (7 X 3,31 MM2), ESP.29 B-613 (Colores: Rojo-Blanco-Verde-Negro-Azul-Naranja-Gris)', 4);
INSERT INTO obras.maestro_materiales VALUES (6134, 'AMARR', 'ABRAZADERA DE PLASTICO TIPO HEBILLA 140/160X3,6 MM, INTEMPERIE COLOR NEGRO', 5);
INSERT INTO obras.maestro_materiales VALUES (31880, 'JUEGO', 'JUEGO DE 3 SENSORES DE VOLTAJE CVT EXTERNOS, 15 KV, PARA RECONECTADOR SERIE U, MARCA MERLIN GERIN', 5);
INSERT INTO obras.maestro_materiales VALUES (448, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X16"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (5577, 'AISLA', 'AISLADOR ESPIGA DE PORCELANA 7 1/2" DE 13" DE FUGA, ROSCA 1 3/8", CLASE ANSI 56-1, COLOR GRIS, 1031, PLANO CGE. M-5920-N, MARCA SANTANA', 5);
INSERT INTO obras.maestro_materiales VALUES (19373, 'RETEN', 'RETENCION PREFORMADA PARA CABLE PROTEGIDO DE 300 MM2, CAT. ND-0122, MARCA PLP. LARGO MÍNIMO 1219MM, DIÁMETRO 30,80MM', 5);
INSERT INTO obras.maestro_materiales VALUES (1244, 'POSTE', 'POSTE DE CONCRETO ARMADO TIPO MOZO DE 6,8 M, C/PLACA DE IDENTIFICACION', 5);
INSERT INTO obras.maestro_materiales VALUES (129, 'CABLE', 'CABLE DE COBRE DESNUDO, DURO, # 2 AWG (33,6 MM2) 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (292, 'GOLIL', 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA DE 40X40X5 MM, PARA PERNO DE 5/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (18875, 'SECC ', 'SECCIONADOR FUSIBLE UNIPOLAR, EXTERIOR, CAPACIDAD HASTA 160A, 500V,PARA FUSIBLES NH TAMAÑO 00, SIMILAR A CAVANNA MODELO APR 1', 5);
INSERT INTO obras.maestro_materiales VALUES (13778, 'GRILL', 'GRILLETE DE ACERO GALVANIZADO DE ANCLAJE RECTO, 14 MM, PARA PERNO DE 3/4"" ', 5);
INSERT INTO obras.maestro_materiales VALUES (6004, 'HEBIL', 'HEBILLA DE ACERO INOXIDABLE TIPO 201 DE 1/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (1252, 'POSTE', 'POSTE DE CONCRETO ARMADO DE 11,5 MTS, C/PLACA DE IDENTIFICACION', 5);
INSERT INTO obras.maestro_materiales VALUES (440, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X7"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (7617, 'ESPIG', 'ESPIGA GALVANIZADA 3/4"X150MM UTILES, 295MM TOTALES, CAPSULA 1 3/8", PARA CRUCETA DE HORMIGON ', 5);
INSERT INTO obras.maestro_materiales VALUES (13960, 'ESPAC', 'ESPACIADOR POLIMERICO PARA 3 CONDUCTORES EN DISPOSICION TRIANGULAR, PARA REDES COMPACTAS 25KV, MEDIANTE PRENSAS INTEGRALES, MARCA HENDRIX', 5);
INSERT INTO obras.maestro_materiales VALUES (3460, 'BARRA', 'FN BARRA DE FIERRO ANGULO RANURADO DE 38X38X2X530 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (2222, 'TUERC', 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA CAÑERIA DE 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (9305, 'GRAPA', 'GRAPA DE ANCLAJE DE ALUMINIO PARA CONDUCTOR AAAC Nº 4-3/0AWG, 10.000LIBRAS DE RUPTURA,  SIN CONECTOR SOCKET, CATALOGO PG-57-N, MARCA HUBBELL', 5);
INSERT INTO obras.maestro_materiales VALUES (20688, 'EXTEN', 'EXTENSION PARA SOPORTE PASO 15 y 23 KV, RED COMPACTA', 5);
INSERT INTO obras.maestro_materiales VALUES (13805, 'SOPOR', 'SOPORTE ACERO GALVANIZADO PORTANTE DE LINEAS 5 VIAS( O DE PASO )', 5);
INSERT INTO obras.maestro_materiales VALUES (9461, 'IMPUL', 'IMPULSOR ROJO PARA INSTALAR Y DESMONTAR CONECTORES AMPACT, 69338-2', 5);
INSERT INTO obras.maestro_materiales VALUES (9589, 'CABLE', 'CABLE CONCENTRICO DE 4 MM2, (2,26 MM) PARA SISTEMA D.R.P. B-540', 4);
INSERT INTO obras.maestro_materiales VALUES (317, 'GRAPA', 'GRAPA DE ANCLAJE DE HIERRO MALEABLE PARA CONDUCTOR DE COBRE # 4 - 4/0 AWG, 15000 LIBRAS DE RUPTURA MECANICA, CATALOGO FQD 58-3, MARCA MACLEAN', 5);
INSERT INTO obras.maestro_materiales VALUES (15920, 'AMARR', 'AMARRA DE ALUMINIO PARA CONDUCTOR 2 AWG, CUELLO F, MODELO UTF 1203, MARCA PLP', 5);
INSERT INTO obras.maestro_materiales VALUES (485, 'PLETI', 'PLETINA GALVANIZADA CORTA DE 75X10X365 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (373, 'INT A', 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 1F 220 V, 1X10A, 6KA RUPTURA, RIEL AMERICANO, SAIME', 5);
INSERT INTO obras.maestro_materiales VALUES (16380, 'CONEC', 'CONECTOR AL-CU, DE ALUMNIO Y ACERO GALVANIZADO, PARA ALUMINIO 50-240 mm2 Y DE COBRE 10-95 mm2, CATÁLOGO Nº SM 4.21, MARCA ENSTO SEKKO', 5);
INSERT INTO obras.maestro_materiales VALUES (22193, 'SOPOR', 'SOPORTE METALICO TIPO L, 75,5X50X15 CM PARA CAJA METALICA ANTI-HURTO', 5);
INSERT INTO obras.maestro_materiales VALUES (491, 'PRENS', 'PRENSA PARALELA DE BRONCE PARA CONDUCTOR 180-1 # 6-1/0 AWG CON CUERPO DE BRONCE, UN PERNO DE COBRE DE 5/16" X 1 3/4" Y 2 TUERCAS DE BRONCE', 5);
INSERT INTO obras.maestro_materiales VALUES (25343, 'ANTEN', 'ANTENA UHF PARA RADIO MODEM 470-490 MHZ, 5 ELEMENTOS, TIPO YUGI, ANTENEX, MOD. Y4705', 5);
INSERT INTO obras.maestro_materiales VALUES (291, 'GOLIL', 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA DE 40X40X5 MM, PARA PERNO DE 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (9952, 'GRAPA', 'GRAPA DE RETENCION DE ALUMINIO PARA CABLE PREENSAMBLADO, PINZA DE ANCLAJE CON NEUTRO PORTANTE AISLADO DE 54,6 MM2  DE SECCION, SIMILAR A CAVANNA', 5);
INSERT INTO obras.maestro_materiales VALUES (444, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X11"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (436, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X2"X1 1/2" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (525, 'SEGUR', 'SEGURO AEREO DE PORCELANA PARA EMPALME, EXTERIOR, 250V, 100A, MONOPOLAR ', 5);
INSERT INTO obras.maestro_materiales VALUES (13780, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X8"X3" DE HILO CON TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (1463, 'SECC ', 'SECCIONADOR FUSIBLE TIPO XS, 14,4/25 KV, 100A, 8000A, RUPTURA, EXTERIOR, MONOPOLAR, CATALOGO 89022R10-CD, MARCA S&C', 5);
INSERT INTO obras.maestro_materiales VALUES (18895, 'SOPOR', 'SOPORTE GALVANIZADO PARA 3 SECCIONADORES EXTERIORES FUSIBLES NH APR 160 ', 5);
INSERT INTO obras.maestro_materiales VALUES (13962, 'RADIO', 'RADIO MODEM UHF, MODELO 4710-A/DIAG, PARA FRECUENCIA DE 330-512 MHZ, SISTEMA SCADA, AJUSTADO PARA RANGO DE FRCUENCIA 450-480 MHZ, CON OPCION', 5);
INSERT INTO obras.maestro_materiales VALUES (144, 'CABLE', 'FN USAR COD. 13897, CABLE DE COBRE AISLADO, TIPO THW, # 2/0 AWG ( 67,4 MM2), PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (250, 'DIAGO', 'DIAGONAL DE FIERRO GALVANIZADO L 50X50X6X1455 MM PARA CRUCETA CANTILEVER, C/SOPORTE, PERNO DE 5/8 X 1 1/2" Y GOLILLA DE PRESION', 5);
INSERT INTO obras.maestro_materiales VALUES (18646, 'BRAZO', 'BRAZO RECTO DE ACERO GALVANIZADO DE CAÑERIA ISO R65 DE 1 1/2", TIPO L-150, PARA LUMINARIA DE 250 W', 5);
INSERT INTO obras.maestro_materiales VALUES (5755, 'CABLE', 'CABLE DE COBRE MONOPOLAR APANTALLADO, CON AISLACION SOLIDA XLPE, # 2 AWG O 33,63 MM2, 15KV', 4);
INSERT INTO obras.maestro_materiales VALUES (9769, 'SOPOR', 'SOPORTE PARA REDES DE B.T. Y EMPALMES EN SISTEMA D.R.P', 5);
INSERT INTO obras.maestro_materiales VALUES (13661, 'GOLIL', 'GOLILLA DE FIERRO GALVANIZADA CUADRADA DE 100X100X5 MM PARA PERNO DE 3/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (9590, 'CABLE', 'CABLE CONCENTRICO DE 6 MM2, (2,76 MM) PARA SISTEMA D.R.P., B-541 ', 4);
INSERT INTO obras.maestro_materiales VALUES (14904, 'BARRA', 'BARRA CON OJO GUARDACABO DOBLE DE 5/8"X2000 MM C/GOLILLA DE 50X50X5 Y TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (9588, 'BOQUI', 'BOQUILLA RECTA PARA CABLE CONCENTRICO, PARA SISTEMA D.R.P.', 5);
INSERT INTO obras.maestro_materiales VALUES (6107, 'MUERT', 'MUERTO DE CONCRETO SIN ARMADURA DE 75 KG PARA AT, PARA TRACCION MAX. 2500 KG', 5);
INSERT INTO obras.maestro_materiales VALUES (301, 'GOLIL', 'GOLILLA DE PRESION DE FIERRO GALVANIZADO PARA PERNO DE 5/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (9451, 'CONEC', 'CONECTOR AMPACT, 33-53 MM2, PASO 16 MM2, DERIVACION, IMPULSOR ROJO, 600528', 5);
INSERT INTO obras.maestro_materiales VALUES (3, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 10KVA, 15KV, 1X220 V. TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (13783, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X10"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (544, 'SOPOR', 'SOPORTE DE REMATE GALVANIZADO DE 1 VIA, PARA B.T., PARA AISLADOR CARRETE DE 76MM, ORIFICIO CENTRAL 18MM', 5);
INSERT INTO obras.maestro_materiales VALUES (15186, 'CONEC', 'CONECTOR ESTRIBO PUESTA TIERRA AMPAC CABLE 70 Y 90 MM2 CON CUBIERTA', 5);
INSERT INTO obras.maestro_materiales VALUES (378, 'INT A', 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 1F 220 V, 1X40A, 6KA RUPTURA, RIEL AMERICANO, SAIME', 5);
INSERT INTO obras.maestro_materiales VALUES (13804, 'SEPAR', 'SEPARADOR PARA SOPORTE 5 VÍAS TIPO C', 5);
INSERT INTO obras.maestro_materiales VALUES (9298, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO AAAC DESNUDO 2AWG (33,63MM2), 7 HEBRAS DE 2,47 MM POR HEBRA, PESO LINIAL 92,1 KG/KM, TAMAÑO NOMINAL KCM 66,2 ', 6);
INSERT INTO obras.maestro_materiales VALUES (9462, 'IMPUL', 'IMPULSOR AZUL PARA INSTALAR CONECTORES AMPACT, 69338-1', 5);
INSERT INTO obras.maestro_materiales VALUES (9572, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 500KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (10494, 'CAJA ', 'CAJA METALICA PARA MEDIDOR 3F ELECTRONICO ACTIVO - REACTIVO, INDIRECTO', 5);
INSERT INTO obras.maestro_materiales VALUES (5840, 'PARAR', 'PARARRAYO CLASE DISTRIBUCIÓN, 12A 15KV, TIPO VARISTAR DE 10,2KV, CUERPO DE GOMA SILICONADA, INC. ESTRUCTURA SOPORTE DE MONTAGE, COOPER POWER', 5);
INSERT INTO obras.maestro_materiales VALUES (150, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 6 AWG (13,3 MM2) PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (13347, 'CONEC', 'CONECTOR DENTADO CON PORTAFUSIBLE INCORPORADO, AISLADO, PARA CABLE PREENSAMBLADO, SIMILAR A CAVANNA MODELO DCPA-EE', 5);
INSERT INTO obras.maestro_materiales VALUES (915, 'GOLIL', 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA, 60X2MM PARA CAÑERIA DE 1 1/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (1240, 'POSTE', 'POSTE DE PINO IMPREGNADO EN SALES 8.00 MTS CLASE V', 5);
INSERT INTO obras.maestro_materiales VALUES (13961, 'BRAZO', 'BRAZO ANTIBALANCE 25 KV, HENDRIX, CAT. BAS 24F', 5);
INSERT INTO obras.maestro_materiales VALUES (3959, 'MUERT', 'MUERTO DE CONCRETO CONICO DE 35 KG, PARA TRACCION MAX. 1500 KG PARA BT', 5);
INSERT INTO obras.maestro_materiales VALUES (6038, 'CONEC', 'CONECTOR DE COMPRESIÓN TERMINAL RECTO 3M, CATEGORIA 30021, BORNE 1000, PARA CABLE STD 4 AWG O COMP. 2 AWG, PERFORACION 3/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (256, 'GOLIL', 'GOLILLA DE NEOPLENE DE 3 MM ESPESOR Y 3,5 X 4,7 CM DIAMETRO INTERIOR Y EXTERIOR RESPECTIVAMENTE', 5);
INSERT INTO obras.maestro_materiales VALUES (70, 'ALAMB', 'ALAMBRE DE COBRE AISLADO, TIPO PI Ó PW, 6 MM2, (2,76 MM) PARA ACOMETIDA EMPALMES AEREOS ', 4);
INSERT INTO obras.maestro_materiales VALUES (153, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 4/0 AWG, ( 107 MM2), PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (7990, 'CONTR', 'CONTROLADOR FOTOELECTRICO PARA USO EN A. P., S/BASE MONTAJE, 220V, 1800VA, 1000 W', 5);
INSERT INTO obras.maestro_materiales VALUES (1149, 'TUERC', 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA PERNO DE 3/4" HILO GRUESO BSW', 5);
INSERT INTO obras.maestro_materiales VALUES (6831, 'ALAMB', 'ALAMBRE DE COBRE DESNUDO, DURO, # 6 AWG (13,3 MM2)', 6);
INSERT INTO obras.maestro_materiales VALUES (49, 'AISLA', 'AISLADOR DE CARRETE DE PORCELANA, 57 MM DE DIAMETRO, 54 MM DE ALTO, ANSI 53-1, TE-1012', 5);
INSERT INTO obras.maestro_materiales VALUES (7567, 'SOPOR', 'SOPORTE DE PASADA CORTO PARA INSTALACION DE LUMINARIAS, LARGO TOTAL 437 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (13432, 'FUSIB', 'FUSIBLE 50 A NEOZED,  PARA CONECTOR DENTADO USO REDES PREENSAMBLADAS, SIMILAR A CAVANNA MODELO INF 50', 5);
INSERT INTO obras.maestro_materiales VALUES (1433, 'SECC ', 'SECCIONADOR CUCHILLO S&C, XS, 14,4/25KV, 300A, EXTERIOR, 1F', 5);
INSERT INTO obras.maestro_materiales VALUES (376, 'INT A', 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 1F 220 V, 1X20A, 6KA RUPTURA, RIEL AMERICANO, SAIME', 5);
INSERT INTO obras.maestro_materiales VALUES (252, 'DIAGO', 'DIAGONAL DE FIERRO GALVANIZADO PLANO 50X8X1035 MM, PARA REFUERZO DE CRUCETA', 5);
INSERT INTO obras.maestro_materiales VALUES (10030, 'CONEC', 'CONECTOR AMPACTINHO, UDC TIPO IV, PARA UNION 16 MM2 AL-2,08 MM2 CU, CON CUBIERTA, CATEGORIA 493458-1', 5);
INSERT INTO obras.maestro_materiales VALUES (141, 'CABLE', 'FN USAR COD. 13562, CABLE DE COBRE AISLADO, TIPO THW, # 4 AWG (21,2 MM2), PARA  B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (6002, 'FLEJE', 'FLEJE DE ACERO INOXIDABLE TIPO 201 DE 1/4"', 4);
INSERT INTO obras.maestro_materiales VALUES (240, 'CURVA', 'CURVA DE REDUCCION PLASTICA PARA CAÑERIA DE 1 1/4" A 1"', 5);
INSERT INTO obras.maestro_materiales VALUES (914, 'GOLIL', 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA, 50X50X2 MM, PARA CAÑERIA DE 3/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (14905, 'ESLAB', 'ESLABON ANGULAR ESTAMPADO GALVANIZADO PARA PERNO DE 5/8" CON GUARDACABO INCLUIDO', 5);
INSERT INTO obras.maestro_materiales VALUES (9455, 'CONEC', 'CONECTOR AMPACT, 70-95 MM2, PASO, 53-70 MM2 DERIVACION, INPULSOR AZUL, 600458', 5);
INSERT INTO obras.maestro_materiales VALUES (13353, 'CAJA ', 'CAJA PARA DISTRIBUCIÓN DE EMPALMES, FABRICADA EN POLICARBONATO COLOR NEGRO Y TAPA DEL MISMO MATERIAL', 5);
INSERT INTO obras.maestro_materiales VALUES (1147, 'TUBO ', 'TUBO CONDUIT 110 MM X 6 MT PVC ALTA DENCIDAD CLASE II TIPO ANGER (NARANJO)', 4);
INSERT INTO obras.maestro_materiales VALUES (389, 'MEDIA', 'MEDIA CAÑA GALVANIZADA DE PROTECCIÓN PARA TIRANTE', 5);
INSERT INTO obras.maestro_materiales VALUES (6031, 'HUINC', 'HUINCHA DE CONEXIÓN A TIERRA 3M SCOTCH 25 DE 1/2"x 4,6 MTS Y 2,4 MM ESPESOR, 6AWG EQ', 10);
INSERT INTO obras.maestro_materiales VALUES (14378, 'CABLE', 'CABLE DE COBRE DESNUDO, DURO, 25 MM2, 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (637, 'AISLA', 'AISLADOR ESPIGA DE PLASTICO, ALTO IMPACTO, 25 KV, ROSCA 1 3/8", DISTANCIA DE FUGA 13", CATALOGO HPI-25-02, MARCA HENDRIX', 5);
INSERT INTO obras.maestro_materiales VALUES (37379, 'CRUCE', 'CRUCETA DE HORMIGON PRETENSADO 75X75X2220 MM, PL. M- 5485-A4, 31 KG, NORMA CGE', 5);
INSERT INTO obras.maestro_materiales VALUES (16448, 'CONEC', 'CONECTOR DE EMPALME Y CONEXION PARA CABLE DE COBRE 2,5-25 MM2, MARCA GPH, PETRI, CATALOGO 0425/2 KU6', 5);
INSERT INTO obras.maestro_materiales VALUES (796, 'CAPSU', 'CAPSULA DE SOLDADURA CADWUELD DE # 90', 5);
INSERT INTO obras.maestro_materiales VALUES (14460, 'SOPOR', 'SOPORTE DE PASO GALVANIZADO PARA REDES COMPACTAS EN 23KV', 5);
INSERT INTO obras.maestro_materiales VALUES (321, 'GRILL', 'GRILLETE GALVANIZADO CON PASADOR Y CHAVETA, DIAMETRO 12 MM, PERFORACION 18 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (8448, 'CAÑER', 'CAÑERIA GALVANIZADA TIPO ISO R II LIVIANA 3" X 6 METROS CON HILO SIN COPLA', 4);
INSERT INTO obras.maestro_materiales VALUES (13696, 'CABLE', 'FN USAR COD. 40761, CABLE DE ALEACION DE ALUMINIO AAAC 4/0 (107MM2) 7 HEBRAS 296KG/KM', 6);
INSERT INTO obras.maestro_materiales VALUES (435, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X1 1/2"X1" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (332, 'GUARD', 'GUARDACABO ACERO GALVANIZADO DE 1/2" PARA CABLE 3/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (38, 'AFIAN', 'AFIANZA DE ACERO ANGULO GALVANIZADO DE 65X65X7X630 MM PARA TRANSFORMADOR DE NORMA NACIONAL', 5);
INSERT INTO obras.maestro_materiales VALUES (13562, 'CABLE', 'CABLE DE COBRE AISLADO THHN, Nº 4 AWG/21,2MM2, NEGRO', 4);
INSERT INTO obras.maestro_materiales VALUES (522, 'SEGUR', 'SEGURO AEREO DE PORCELANA PARA EMPALME, EXTERIOR, 250V, 10A, MONOPOLAR ', 5);
INSERT INTO obras.maestro_materiales VALUES (23180, 'CONJU', 'CONJUNTO BARRA FASE Y NEUTRO 15 VIAS PARA CAJA METALICA 8 REGLETA TRIFASICA', 5);
INSERT INTO obras.maestro_materiales VALUES (20571, 'TRAFO', 'TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 250KVA, 15 KV 400-231V. TAPS 15180/14520/13860/13530/13200', 5);
INSERT INTO obras.maestro_materiales VALUES (10173, 'CONEC', 'CONECTOR DENTADO DIENTE DE COBRE ESTAÑADO A PERFORACION AISLANTE, ALUMINIO 25/120MM2 (RED), DERIVACION AL-CU 25-120MM2, SIMILAR A CAVANNA', 5);
INSERT INTO obras.maestro_materiales VALUES (13584, 'CABLE', 'CABLE DE ALUMINIO PURO 1350, PROTEGIDO, SECCION 1X50 MM2, PARA LINEAS AEREAS 25 KV, AISLACION XLPE', 4);
INSERT INTO obras.maestro_materiales VALUES (10756, 'SECC ', 'SECCIONADOR FUSIBLE UNIPOLAR, EXTERIOR, CAPACIDAD HASTA 630A, 500V, PARA FUSIBLES NH TAMAÑO 1, 2 Y 3, SIMILAR A CAVANNA MODELO APR630 HASTA 95MM', 5);
INSERT INTO obras.maestro_materiales VALUES (1242, 'POSTE', 'POSTE DE PINO IMPREGNADO EN SALES 10.00 MTS CLASE V', 5);
INSERT INTO obras.maestro_materiales VALUES (239, 'CURVA', 'CURVA DE REDUCCION PLASTICA EN U PARA CAÑERIA DE 3/4" A 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (443, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X10"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (7231, 'CRUCE', 'FN CRUCETA DE FIERRO ANGULO GALVANIZADO DE 100X100X10X2200 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (5404, 'PERNO', 'PERNO DE FIERRO ZINCADO CABEZA REDONDA DE 5/32" X 1/2" CON TUERCA HEXAGONAL 5/32"', 5);
INSERT INTO obras.maestro_materiales VALUES (9048, 'PLETI', 'PLETINA DE FIJACION DE 140X3X30 MM PARA CAJA METALICA PARA MEDIDOR 1F', 5);
INSERT INTO obras.maestro_materiales VALUES (254, 'GOLIL', 'GOLILLA DE NEOPLENE DE 3 MM ESPESOR Y 2,1 X 3,5 CM DIAMETRO INTERIOR Y EXTERIOR RESPECTIVAMENTE', 5);
INSERT INTO obras.maestro_materiales VALUES (1250, 'POSTE', 'POSTE DE CONCRETO ARMADO DE 10 MTS, C/PLACA DE IDENTIFICACION', 5);
INSERT INTO obras.maestro_materiales VALUES (16041, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X11"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (9951, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 3X35/50MM2, FASE Y NEUTRO AISLADOS, AISLACION DE POLIETILENO RETICULADO (XLPE), CAPA PROTECTORA ', 4);
INSERT INTO obras.maestro_materiales VALUES (1028, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X13"X3" DE HILO CON TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (20234, 'CABLE', 'CABLE DE ALUMINIO PREENSAMBLADO 3X95/50 MM2, FASE Y NEUTRO AISLADOS, AISLACION DE POLIETILENO RETICULADO (XLPE), CAPA PROTECTORA AL SOL, TENSION NOMINAL 1.100V.', 4);
INSERT INTO obras.maestro_materiales VALUES (4586, 'CONDU', 'CONDULET (CABEZA DE SERVICIO) PARA CAÑERIA 2" CON SALIDAS PARA 7 CONDUCTORES', 5);
INSERT INTO obras.maestro_materiales VALUES (19448, 'SECC ', 'SECCIONADOR FUSIBLE XS, 15KV, 100A, 10000A RUPT., 95KV BIL, EXT. MONOPOLAR, CAT.89021R10-CD, MARCA S&C, CON FERRETERIA PARA MONTAJE EN CRUCETA', 5);
INSERT INTO obras.maestro_materiales VALUES (40, 'AISLA', 'AISLADOR DE DISCO DE PORCELANA 6 ½" DE DIAMETRO, 7" DE DISTANCIA DE FUGA, CON PASADOR, CLASE ANSI 52-1, COLOR GRIS CLARO, REFERENCIA SANTANA', 5);
INSERT INTO obras.maestro_materiales VALUES (17320, 'CINTA', 'CINTA SCOTCH 130-C SIN LINER, 3M NEGRA, 3/4"x 9,2 MTS', 10);
INSERT INTO obras.maestro_materiales VALUES (9020, 'CONTA', 'CONTACTOR DE MERCURIO MONOPOLAR, 30 -35 A, BOBINA DE 220V, PARA USO EN ALUMBRADO PUBLICO, CATALOGO MDI 35NO-220AH, MARCA MDIPARAUSO EN A.P.', 5);
INSERT INTO obras.maestro_materiales VALUES (7700, 'PERNO', 'PERNO DE FIERRO ZINCADO CABEZA REDONDA DE 3/16" x 1/4" CON TUERCA  DE 3/16"', 5);
INSERT INTO obras.maestro_materiales VALUES (636, 'AISLA', 'FN USAR COD. 637, AISLADOR ESPIGA DE PLASTICO, ALTO IMPACTO, 15KV, ROSCA 1", DISTANCIA DE FUGA 12", CATALOGO HPI-15, MARACA HENDRIX', 5);
INSERT INTO obras.maestro_materiales VALUES (8505, 'PRENS', 'PRENSA PARALELA DE BRONCE PARA CONDUCTOR 3-4/0 AWG CON CUERPO DE BRONCE SAE 40, DOS PERNOS DE COBRE DE 3/8" X 2 1/2" Y 4 TUERCAS DE BRONCE', 5);
INSERT INTO obras.maestro_materiales VALUES (8854, 'CAÑER', 'CAÑERIA GALVANIZADA TIPO ISO 1 1/4", CON HILO SIN COPLA', 4);
INSERT INTO obras.maestro_materiales VALUES (27344, 'BARRA', 'BARRA LISA TOMATIERRA DE FIERRO GALVANIZADA DE 1/2" X 7000 MM (TRAMOS RECTOS DE 3000 X 2000 X 1800 MM)', 5);
INSERT INTO obras.maestro_materiales VALUES (16468, 'CONEC', 'CONECTOR AL - AL ,DE ALUMNIO Y ALUMINIO, PARA CONDUCTORES DE ALUMNIO 16-120 MM2, CATÁLOGO Nº SL 4.25, MARCA ENSTO SEKKO OY.', 5);
INSERT INTO obras.maestro_materiales VALUES (152, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 2/0 AWG, (67,4 MM2), PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (441, 'PERNO', 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X8"X3" DE HILO C/TUERCA', 5);
INSERT INTO obras.maestro_materiales VALUES (17633, 'FIJAC', 'PERNO J FIJACION ACERO GALVANIZADO 1/2"x9" C/PLETINA CAÑERIA 1/2" ', 5);
INSERT INTO obras.maestro_materiales VALUES (142, 'CABLE', 'FN USAR COD. 13563, CABLE DE COBRE AISLADO, TIPO THW, # 2 AWG (33,6 MM2), PARA  B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (302, 'GOLIL', 'GOLILLA DE PRESION DE FIERRO GALVANIZADO PARA PERNO DE 3/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (132, 'CABLE', 'CABLE DE COBRE DESNUDO, DURO, # 1/0 AWG (53,5 MM2) 7 HEBRAS', 6);
INSERT INTO obras.maestro_materiales VALUES (16447, 'CONEC', 'CONECTOR DE EMPALME Y CONEXION PARA CABLE DE COBRE 10-95 MM2, MARCA GPH, PETRI, CATALOGO 01095/2KU', 5);
INSERT INTO obras.maestro_materiales VALUES (6003, 'FLEJE', 'FLEJE DE ACERO INOXIDABLE TIPO 201 DE 5/8"', 4);
INSERT INTO obras.maestro_materiales VALUES (6119, 'BARRA', 'BARRA TOMA TIERRA COPPERWELD DE 5/8" X 1,5 MTS, 400 MICRONES', 5);
INSERT INTO obras.maestro_materiales VALUES (15886, 'SEPAR', 'SEPARADOR MONTAJE PARA DESCONECTADOR FUSIBLE 1F', 5);
INSERT INTO obras.maestro_materiales VALUES (22192, 'PERNO', 'PERNO DE FIERRO 1/2" X12 HILOS X 2 1/2" PARA AFIANCE DE CAJA ANTI-HURTO A SOPORTE METALICO TIPO L', 5);
INSERT INTO obras.maestro_materiales VALUES (524, 'SEGUR', 'SEGURO AEREO DE PORCELANA PARA EMPALME, EXTERIOR, 250V, 60A, MONOPOLAR', 5);
INSERT INTO obras.maestro_materiales VALUES (17656, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XTU, # 1AWG, PARA B.T./35MM2', 4);
INSERT INTO obras.maestro_materiales VALUES (6920, 'CRUCE', 'CRUCETA DE FIERRO GALVANIZADO L 80X80X8X2000 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (502, 'CONEC', 'CONECTOR MUELA BIMETALICO BRONCE ESTAÑADO AL/CU: PASO. 2-4/0, DERIVACION 6-4/0 CON 1 PERNO DE ACERO ZINCADO 3/8 X 1 3/4" Y 1 DE ACERO ZINCADO 3/8"', 5);
INSERT INTO obras.maestro_materiales VALUES (14851, 'CABLE', 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 2X25 MM2 (NEUTRO DESNUDO),AISLACION DE POLIETILENO RETICULADO (XLPE), TENSION NOMINAL 1.100 VOLT', 4);
INSERT INTO obras.maestro_materiales VALUES (599, 'TUERC', 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA CAÑERIA DE 1 1/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (300, 'GOLIL', 'GOLILLA DE PRESION DE FIERRO GALVANIZADO PARA PERNO DE 1/2"', 5);
INSERT INTO obras.maestro_materiales VALUES (140, 'CABLE', 'FN USAR COD. 13561, CABLE DE COBRE AISLADO, TIPO THW, # 6 AWG (13,3 MM2), PARA  B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (19844, 'CONEC', 'CONECTOR AMPACT CUNA AL/CU PASO (300-185 MM2), DERIVACION 185-70 MM2), CAT:1-602031-6, IMPULSOR AMARILLO', 5);
INSERT INTO obras.maestro_materiales VALUES (7615, 'ESPIG', 'ESPIGA GALVANIZADA 3/4"X150MM UTILES, 295MM TOTALES, CAPSULA 1", PARA CRUCETA DE HORMIGON', 5);
INSERT INTO obras.maestro_materiales VALUES (7565, 'SOPOR', 'SOPORTE DE PASADA CORTO PARA UNA VIA, LARGO TOTAL 317 MM', 5);
INSERT INTO obras.maestro_materiales VALUES (151, 'CABLE', 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 2 AWG (33,63 MM2) PARA B.T.', 4);
INSERT INTO obras.maestro_materiales VALUES (597, 'TUERC', 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA CAÑERIA DE 3/4"', 5);
INSERT INTO obras.maestro_materiales VALUES (7616, 'ESPIG', 'ESPIGA GALVANIZADA 3/4"X150MM UTILES, 210MM TOTALES, CAPSULA 1", PARA CRUCETA METALICA', 5);
INSERT INTO obras.maestro_materiales VALUES (7948, 'TUBO ', 'TUBO FLEXIBLE DE ACERO GALVANIZADO REVESTIDO CON PVC COLOR GRIS 1" USO INTEMPERIE', 4);


--
-- TOC entry 3855 (class 0 OID 386181)
-- Dependencies: 288
-- Data for Name: maestro_unidades; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.maestro_unidades VALUES (1, 'CU', 'CU');
INSERT INTO obras.maestro_unidades VALUES (2, 'GL', 'GL');
INSERT INTO obras.maestro_unidades VALUES (3, 'HORA HOMBRE', 'HH');
INSERT INTO obras.maestro_unidades VALUES (4, 'METROS', 'M');
INSERT INTO obras.maestro_unidades VALUES (5, 'UNIDAD', 'UN');
INSERT INTO obras.maestro_unidades VALUES (6, 'KILOGRAMO', 'KG');
INSERT INTO obras.maestro_unidades VALUES (7, 'TIRA', 'TI');
INSERT INTO obras.maestro_unidades VALUES (8, 'CONJUNTO', 'CJN');
INSERT INTO obras.maestro_unidades VALUES (9, 'KIT', 'KIT');
INSERT INTO obras.maestro_unidades VALUES (10, 'ROLLOS', 'ROL');
INSERT INTO obras.maestro_unidades VALUES (11, 'BOLSA', 'BOL');
INSERT INTO obras.maestro_unidades VALUES (12, 'JUEGO', 'JGO');
INSERT INTO obras.maestro_unidades VALUES (13, 'SACO', 'SA');


--
-- TOC entry 3857 (class 0 OID 386189)
-- Dependencies: 290
-- Data for Name: obras; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.obras VALUES (1, 'CGED-001', '555444', 'Obra de prueba', 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, false);


--
-- TOC entry 3859 (class 0 OID 386197)
-- Dependencies: 292
-- Data for Name: otros_cargos_edp; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3861 (class 0 OID 386205)
-- Dependencies: 294
-- Data for Name: otros_cargos_obra; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3862 (class 0 OID 386211)
-- Dependencies: 295
-- Data for Name: recibido_bodega_pelom; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3886 (class 0 OID 442524)
-- Dependencies: 319
-- Data for Name: reservas_obras; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.reservas_obras VALUES (123, 1);
INSERT INTO obras.reservas_obras VALUES (124, 1);


--
-- TOC entry 3864 (class 0 OID 386219)
-- Dependencies: 297
-- Data for Name: segmento; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.segmento VALUES (1, 'CAPEX', '');
INSERT INTO obras.segmento VALUES (2, 'OPEX', '');
INSERT INTO obras.segmento VALUES (3, 'INVERSIÓN', '');
INSERT INTO obras.segmento VALUES (4, 'VENTA', '');
INSERT INTO obras.segmento VALUES (5, 'FTR', '');
INSERT INTO obras.segmento VALUES (6, 'OPEX BAJA', '');
INSERT INTO obras.segmento VALUES (7, 'OPEX MEDIA', '');
INSERT INTO obras.segmento VALUES (8, 'OPEX ALTA', '');
INSERT INTO obras.segmento VALUES (9, 'CAPEX BAJA ', '');
INSERT INTO obras.segmento VALUES (10, 'CAPEX MEDIA', '');
INSERT INTO obras.segmento VALUES (11, 'CAPEX ALTA', '');


--
-- TOC entry 3866 (class 0 OID 386227)
-- Dependencies: 299
-- Data for Name: solicitantes; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.solicitantes VALUES (1, 'Alfonso Villagra', 2);
INSERT INTO obras.solicitantes VALUES (2, 'Carlos Nuñez', 2);
INSERT INTO obras.solicitantes VALUES (3, 'Fernando Vargas', 2);
INSERT INTO obras.solicitantes VALUES (4, 'Guillermo Gutierrez', 2);
INSERT INTO obras.solicitantes VALUES (5, 'Juan Farias', 2);
INSERT INTO obras.solicitantes VALUES (6, 'Oscar Urzua', 2);
INSERT INTO obras.solicitantes VALUES (7, 'Victor Navarro', 2);
INSERT INTO obras.solicitantes VALUES (8, 'Benjamin Gutierrez', 5);
INSERT INTO obras.solicitantes VALUES (9, 'Claudio Navarro', 5);
INSERT INTO obras.solicitantes VALUES (10, 'Erick Moscoso', 5);
INSERT INTO obras.solicitantes VALUES (11, 'Luis Valladares', 5);
INSERT INTO obras.solicitantes VALUES (12, 'Oscar Muñoz', 5);
INSERT INTO obras.solicitantes VALUES (13, 'Pedro Morales', 5);
INSERT INTO obras.solicitantes VALUES (14, 'Juan Diaz', 1);
INSERT INTO obras.solicitantes VALUES (15, 'Juan Lazo', 1);
INSERT INTO obras.solicitantes VALUES (16, 'Luis Soto', 1);
INSERT INTO obras.solicitantes VALUES (17, 'Patricio Soto', 1);
INSERT INTO obras.solicitantes VALUES (18, 'Rodolfo Gutierrez', 1);
INSERT INTO obras.solicitantes VALUES (19, 'Samuel Salazar', 1);
INSERT INTO obras.solicitantes VALUES (20, 'Victor Piña', 1);
INSERT INTO obras.solicitantes VALUES (21, 'Victor Poblete', 1);
INSERT INTO obras.solicitantes VALUES (22, 'Viviana Briso', 1);


--
-- TOC entry 3868 (class 0 OID 386235)
-- Dependencies: 301
-- Data for Name: tipo_actividad; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.tipo_actividad VALUES (1, 'Recargos_x_dist_desde_base_de_CONTRATANTE');
INSERT INTO obras.tipo_actividad VALUES (2, 'Recargos_por_trabajos_menores_a_50_UC');
INSERT INTO obras.tipo_actividad VALUES (3, 'Capex_Baja');
INSERT INTO obras.tipo_actividad VALUES (4, 'Capex_Media');
INSERT INTO obras.tipo_actividad VALUES (5, 'Capex_Alta');
INSERT INTO obras.tipo_actividad VALUES (6, 'Opex_Baja');
INSERT INTO obras.tipo_actividad VALUES (7, 'Opex_Media');
INSERT INTO obras.tipo_actividad VALUES (8, 'Opex_Alta');
INSERT INTO obras.tipo_actividad VALUES (9, 'Adicionales');
INSERT INTO obras.tipo_actividad VALUES (10, 'Factores_de_recargo_a_UC_horarios_extraordinarios');
INSERT INTO obras.tipo_actividad VALUES (11, 'Conductor_BT');
INSERT INTO obras.tipo_actividad VALUES (12, 'Conductor_MT');
INSERT INTO obras.tipo_actividad VALUES (13, 'Conductor_subterráneo_BT');
INSERT INTO obras.tipo_actividad VALUES (14, 'Conductor_subterráneo_MT');
INSERT INTO obras.tipo_actividad VALUES (15, 'Equipo_BT');
INSERT INTO obras.tipo_actividad VALUES (16, 'Equipo_MT');
INSERT INTO obras.tipo_actividad VALUES (17, 'Equipo_subterráneo_BT');
INSERT INTO obras.tipo_actividad VALUES (18, 'Equipo_subterráneo_MT');
INSERT INTO obras.tipo_actividad VALUES (19, 'Estructuras_BT');
INSERT INTO obras.tipo_actividad VALUES (20, 'Estructuras_MT');
INSERT INTO obras.tipo_actividad VALUES (21, 'Mallas');
INSERT INTO obras.tipo_actividad VALUES (22, 'Postes');
INSERT INTO obras.tipo_actividad VALUES (23, 'Tirantes');
INSERT INTO obras.tipo_actividad VALUES (24, 'Tomatierras');
INSERT INTO obras.tipo_actividad VALUES (25, 'Transformador_Subterráneo');
INSERT INTO obras.tipo_actividad VALUES (26, 'Transformadores');


--
-- TOC entry 3870 (class 0 OID 386243)
-- Dependencies: 303
-- Data for Name: tipo_obra; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.tipo_obra VALUES (1, 'VENTA');
INSERT INTO obras.tipo_obra VALUES (2, 'INVERSIÓN');
INSERT INTO obras.tipo_obra VALUES (3, 'NT 20');
INSERT INTO obras.tipo_obra VALUES (4, 'NT 90');
INSERT INTO obras.tipo_obra VALUES (5, 'NT 180');
INSERT INTO obras.tipo_obra VALUES (6, 'HALLAZGO');
INSERT INTO obras.tipo_obra VALUES (7, 'EMERGENCIA');


--
-- TOC entry 3890 (class 0 OID 467102)
-- Dependencies: 323
-- Data for Name: tipo_operacion; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.tipo_operacion VALUES (1, 'INSTALACIÓN');
INSERT INTO obras.tipo_operacion VALUES (2, 'RETIRO');
INSERT INTO obras.tipo_operacion VALUES (3, 'TRASLADO');


--
-- TOC entry 3872 (class 0 OID 386251)
-- Dependencies: 305
-- Data for Name: tipo_trabajo; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.tipo_trabajo VALUES (1, 'CONSTRUCCIÓN');
INSERT INTO obras.tipo_trabajo VALUES (2, 'MANTENIMIENTO');
INSERT INTO obras.tipo_trabajo VALUES (3, 'COVID');
INSERT INTO obras.tipo_trabajo VALUES (4, 'EMERGENCIA');
INSERT INTO obras.tipo_trabajo VALUES (5, 'PODA');


--
-- TOC entry 3874 (class 0 OID 386259)
-- Dependencies: 307
-- Data for Name: valor_uc; Type: TABLE DATA; Schema: obras; Owner: postgres
--



--
-- TOC entry 3876 (class 0 OID 386267)
-- Dependencies: 309
-- Data for Name: visitas_terreno; Type: TABLE DATA; Schema: obras; Owner: postgres
--

INSERT INTO obras.visitas_terreno VALUES (3, 1, '2023-10-20', 'parcela 29, camino interior, rauco', 'Juan Soto', 'Coordinador', 'Germán Carreño', 'Coordinador', 'Revisión de trabajos en postes', 3, '2023-10-19');


--
-- TOC entry 3882 (class 0 OID 393393)
-- Dependencies: 315
-- Data for Name: _oficinas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3788 (class 0 OID 385683)
-- Dependencies: 221
-- Data for Name: cargo_fijo; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.cargo_fijo VALUES (1, 1, 1, 1, 1467585, NULL, 3);
INSERT INTO sae.cargo_fijo VALUES (2, 1, 1, 2, 1467585, NULL, 3);
INSERT INTO sae.cargo_fijo VALUES (3, 1, 1, 3, 1467585, NULL, 3);
INSERT INTO sae.cargo_fijo VALUES (4, 1, 1, 4, 1467585, NULL, 2);
INSERT INTO sae.cargo_fijo VALUES (5, 1, 2, 1, 1390344, NULL, 1);
INSERT INTO sae.cargo_fijo VALUES (6, 1, 2, 2, 1390344, NULL, 1);
INSERT INTO sae.cargo_fijo VALUES (7, 1, 2, 3, 1390344, NULL, 1);
INSERT INTO sae.cargo_fijo VALUES (8, 1, 2, 4, 1390344, NULL, 1);
INSERT INTO sae.cargo_fijo VALUES (9, 1, 3, 1, 1509516, NULL, 0);
INSERT INTO sae.cargo_fijo VALUES (10, 1, 3, 2, 1509516, NULL, 0);
INSERT INTO sae.cargo_fijo VALUES (11, 1, 3, 3, 1509516, NULL, 1);
INSERT INTO sae.cargo_fijo VALUES (12, 1, 3, 4, 1509516, NULL, 1);
INSERT INTO sae.cargo_fijo VALUES (13, 1, 4, 1, 1551447, NULL, 0);
INSERT INTO sae.cargo_fijo VALUES (14, 1, 4, 2, 1551447, NULL, 0);
INSERT INTO sae.cargo_fijo VALUES (15, 1, 4, 3, 1551447, NULL, 0);
INSERT INTO sae.cargo_fijo VALUES (16, 1, 4, 4, 1551447, NULL, 1);


--
-- TOC entry 3802 (class 0 OID 385861)
-- Dependencies: 235
-- Data for Name: movil_eventos; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.movil_eventos VALUES (2, 4, '{"_id":"64e4d47c02940ef28a773f3f","num_ot":"12563365","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"2","codigo_oficina":"1","requerimiento":"Cambio de Puertas en Tabas ","direccion":"PANGA LOLOL #456","fecha_hora_ejecucion":"22/08/2023 11:19","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-22T15:30:04.600Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (3, 4, '{"_id":"64e4d80802940ef28a773f42","num_ot":"12563365","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"2","codigo_oficina":"1","requerimiento":"Cambio de Puertas en Tabas ","direccion":"PANGA LOLOL #456","fecha_hora_ejecucion":"22/08/2023 11:19","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-22T15:45:12.088Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (4, 4, '{"_id":"64e4daf302940ef28a773f46","num_ot":"12563365","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"2","codigo_oficina":"1","requerimiento":"Cambio de Puertas en Tabas ","direccion":"PANGA LOLOL #456","fecha_hora_ejecucion":"22/08/2023 11:19","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-22T15:57:39.196Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (5, 4, '{"_id":"64e51cfb266525d046801838","num_ot":"112233","tipo_evento":"4","rut_maestro":"12.545.678-9","rut_ayudante":"12.345.678-9","codigo_turno":"5","codigo_oficina":"6","requerimiento":"HOLA PATO","direccion":"HOLA","fecha_hora_ejecucion":"22-08-2023","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-22T16:39:23.049Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (6, 4, '{"_id":"64e605cae7e40b3365853fc7","num_ot":"10020032","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"mas colores","direccion":"colores","fecha_hora_ejecucion":"23/08/2023 09:12","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T09:12:42.972Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (7, 4, '{"_id":"64e60b96e7e40b3365853fd5","num_ot":"102030","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"colores 456 443###$444&&777","direccion":"colores 4567","fecha_hora_ejecucion":"23/08/2023 09:32","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T09:37:26.127Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (8, 4, '{"_id":"64e60d16e7e40b3365853fd8","num_ot":"1200233","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"casa sin energia ","direccion":"las parcelas #357","fecha_hora_ejecucion":"23/08/2023 09:42","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T09:43:50.081Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (9, 4, '{"_id":"64e61f8be7e40b3365853fdb","num_ot":"1256330","tipo_evento":"2","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"Sector sin energia","direccion":"pajaritos #45","fecha_hora_ejecucion":"23/08/2023 09:42","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T11:02:35.930Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (10, 4, '{"_id":"64e6262ce7e40b3365853fde","num_ot":"145263","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"colores","direccion":"pajaritos","fecha_hora_ejecucion":"23/08/2023 11:03","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T11:30:52.299Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (11, 4, '{"_id":"64e62648e7e40b3365853fe1","num_ot":"101010","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"TETET","direccion":"TETET","fecha_hora_ejecucion":"23/08/2023 11:31","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T11:31:20.627Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (12, 4, '{"_id":"64e62c0ce7e40b3365853ff0","num_ot":"1200023000","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"11.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"EWEWEWE","direccion":"EWEWE","fecha_hora_ejecucion":"23/08/2023 11:54","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T11:55:56.536Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (13, 4, '{"_id":"64e62daae7e40b3365854000","num_ot":"1233","tipo_evento":"2","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"2","codigo_oficina":"1","requerimiento":"qqqq","direccion":"qqqq","fecha_hora_ejecucion":"23/08/2023 12:02","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T12:02:50.229Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (14, 4, '{"_id":"64e63023e7e40b3365854003","num_ot":"11111","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"2","codigo_oficina":"1","requerimiento":"wwwwww","direccion":"weeweww","fecha_hora_ejecucion":"23/08/2023 12:12","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T12:13:23.928Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (15, 4, '{"_id":"64e632f0e7e40b3365854006","num_ot":"1223333","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"2","codigo_oficina":"1","requerimiento":"errrrrr","direccion":"eereee","fecha_hora_ejecucion":"23/08/2023 12:12","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T12:25:20.797Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (16, 4, '{"_id":"64e634bce7e40b3365854009","num_ot":"123123","tipo_evento":"2","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"2","codigo_oficina":"1","requerimiento":"erere","direccion":"erere","fecha_hora_ejecucion":"23/08/2023 12:32","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T12:33:00.542Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (17, 4, '{"_id":"64e63c43e7e40b3365854028","num_ot":"1212121","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"11.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"sin energia","direccion":"pajaritos #345","fecha_hora_ejecucion":"23/08/2023 13:01","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T13:05:07.668Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (18, 4, '{"_id":"64e65dc1e7e40b3365854048","num_ot":"112233","tipo_evento":"4","rut_maestro":"12.545.678-9","rut_ayudante":"12.345.678-9","codigo_turno":"5","codigo_oficina":"6","requerimiento":"HOLA PATO","direccion":"HOLA","fecha_hora_ejecucion":"22-08-2023","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T15:28:01.752Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (19, 4, '{"_id":"64e65e41e7e40b336585405a","num_ot":"1230002020","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"COLORES","direccion":"COLORES","fecha_hora_ejecucion":"23/08/2023 15:30","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T15:30:09.915Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (21, 4, '{"_id":"64e66109e7e40b3365854060","num_ot":"123456","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"123456","direccion":"123456","fecha_hora_ejecucion":"23/08/2023 15:40","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T15:42:01.796Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (22, 4, '{"_id":"64e66133e7e40b3365854063","num_ot":"12345689","tipo_evento":"2","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"123652244","direccion":"4556322","fecha_hora_ejecucion":"23/08/2023 15:42","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T15:42:43.400Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (23, 4, '{"_id":"64e663a1e7e40b3365854066","num_ot":"123456","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"456985477","direccion":"123245655","fecha_hora_ejecucion":"23/08/2023 15:51","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T15:53:05.238Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (24, 4, '{"_id":"64e66c11e7e40b3365854069","num_ot":"1245222","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"12365244","direccion":"12365244","fecha_hora_ejecucion":"23/08/2023 15:51","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T16:29:05.704Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (25, 4, '{"_id":"64e66c51e7e40b336585406c","num_ot":"123333","tipo_evento":"2","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"2233322","direccion":"332222","fecha_hora_ejecucion":"23/08/2023 16:30","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T16:30:09.981Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (26, 4, '{"_id":"64e66c6ee7e40b336585406f","num_ot":"12233444","tipo_evento":"3","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"2333222","direccion":"233332","fecha_hora_ejecucion":"23/08/2023 16:30","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T16:30:38.216Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (27, 4, '{"_id":"64e66d4ce7e40b3365854072","num_ot":"12233333","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"3344443333","direccion":"33432344","fecha_hora_ejecucion":"23/08/2023 16:32","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T16:34:20.044Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (28, 4, '{"_id":"64e66ecde7e40b3365854075","num_ot":"3333","tipo_evento":"2","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"333","direccion":"33333","fecha_hora_ejecucion":"23/08/2023 16:35","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T16:40:45.545Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (29, 4, '{"_id":"64e66f16e7e40b3365854078","num_ot":"12222","tipo_evento":"2","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"22222","direccion":"22222","fecha_hora_ejecucion":"23/08/2023 16:39","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T16:41:58.671Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (30, 4, '{"_id":"64e67436e7e40b336585407b","num_ot":"1452111","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"4588777","direccion":"145554","fecha_hora_ejecucion":"23/08/2023 17:02","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T17:03:50.562Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (31, 4, '{"_id":"64e67489e7e40b336585407e","num_ot":"1455222","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"47854444","direccion":"45785855","fecha_hora_ejecucion":"23/08/2023 17:04","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T17:05:13.252Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (32, 4, '{"_id":"64e67515e7e40b3365854081","num_ot":"144111","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"14544444","direccion":"11444111","fecha_hora_ejecucion":"23/08/2023 17:07","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T17:07:33.275Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (33, 4, '{"_id":"64e68ae8e7e40b3365854084","num_ot":"14525252","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"1122222","direccion":"12232222","fecha_hora_ejecucion":"23/08/2023 18:40","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T18:40:40.006Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (34, 4, '{"_id":"64e68ccfe7e40b3365854087","num_ot":"11222","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"33333","direccion":"22333","fecha_hora_ejecucion":"23/08/2023 18:48","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T18:48:47.839Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (35, 4, '{"_id":"64e6d5885c66cbeec250d9d7","num_ot":"112233","tipo_evento":"4","rut_maestro":"12.545.678-9","rut_ayudante":"12.345.678-9","codigo_turno":"5","codigo_oficina":"6","requerimiento":"HOLA PATO","direccion":"HOLA","fecha_hora_ejecucion":"22-08-2023","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T23:59:04.101Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (36, 3, '{"_id":"64e757a85c66cbeec250d9f5","num_ot":"10200200200","tipo_evento":"SSEEB","rut_maestro":"12345234-7","rut_ayudante":"12345234-7","codigo_turno":"1","codigo_oficina":"1","requerimiento":"WEWEWEW","direccion":"EWEWEWE","fecha_hora_ejecucion":"24/08/2023 09:12","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T09:14:16.974Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (37, 3, '{"_id":"64e75c095c66cbeec250da03","num_ot":"12000300012","tipo_evento":"SSEEB","rut_maestro":"12345234-7","rut_ayudante":"12345234-7","codigo_turno":"2","codigo_oficina":"1","requerimiento":"cables cortados en el poste","direccion":"pajaritos 2555","fecha_hora_ejecucion":"24/08/2023 09:32","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T09:32:57.625Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (38, 3, '{"_id":"64e7872bb93641538678bd5b","num_ot":"1233600","tipo_evento":"DOMIC","rut_maestro":"12345234-7","rut_ayudante":"12345234-7","codigo_turno":"2","codigo_oficina":"1","requerimiento":"cambio de cables ","direccion":"pajaritos 3652","fecha_hora_ejecucion":"24/08/2023 12:36","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T12:36:59.004Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (1, 4, '{"_id":"64e4d22f02940ef28a773f3a","num_ot":"12563365","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"14.620.209-8","codigo_turno":"2","codigo_oficina":"1","requerimiento":"Cambio de Puertas en Tabas ","direccion":"PANGA LOLOL #456","fecha_hora_ejecucion":"22/08/2023 11:19","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-22T15:20:15.042Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (20, 4, '{"_id":"64e6603be7e40b336585405d","num_ot":"1233222","tipo_evento":"1","rut_maestro":"14.620.209-8","rut_ayudante":"16.620.209-8","codigo_turno":"1","codigo_oficina":"1","requerimiento":"9898989898","direccion":"9898989","fecha_hora_ejecucion":"23/08/2023 15:38","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-23T15:38:35.753Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (39, 3, '{"_id":"64e7bb54b93641538678bd8e","num_ot":"130009000","tipo_evento":"DOMIC","rut_maestro":"12345234-7","rut_ayudante":"12345234-7","codigo_turno":"2","codigo_oficina":"1","requerimiento":"WERWERWER","direccion":"WERWER","fecha_hora_ejecucion":"24/08/2023 15:59","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T16:19:32.174Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (40, 3, '{"_id":"64e7be1fb93641538678bd9c","num_ot":"120003","tipo_evento":"LINMT","rut_maestro":"12345234-7","rut_ayudante":"12345234-7","codigo_turno":"3","codigo_oficina":"2","requerimiento":"zona sin energia","direccion":"pajaritos 445","fecha_hora_ejecucion":"24/08/2023 16:30","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T16:31:27.039Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_eventos VALUES (41, 3, '{"_id":"64e7cf12b93641538678bdf5","num_ot":"10020","tipo_evento":"LINMT","rut_maestro":"12345234-7","rut_ayudante":"12345234-7","codigo_turno":"2","codigo_oficina":"3","requerimiento":"zona sin energia ","direccion":"pajaritos 456","fecha_hora_ejecucion":"24/08/2023 17:41","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T17:43:46.581Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');


--
-- TOC entry 3804 (class 0 OID 385872)
-- Dependencies: 237
-- Data for Name: movil_jornadas; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.movil_jornadas VALUES (1, 3, '{"_id":"64e78459b93641538678bd3f","rut_maestro":"12345234-7","codigo_turno":"2","rut_ayudante":"12345234-7","patente_vehiculo":"AABB-00","km_inicia":"120000","km_final":"1200603","codigo_oficina":"1","fecha_hora_inicio":"2023-08-24T14:34:41.948Z","fecha_hora_final":"2023-08-24T16:05:39.733Z","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T12:24:57.655Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_jornadas VALUES (2, 4, '{"_id":"64e785d9b93641538678bd42","rut_maestro":"12345234-7","codigo_turno":"2","rut_ayudante":"12345234-7","patente_vehiculo":"AABB-00","km_inicia":"120000","km_final":"1200603","codigo_oficina":"1","fecha_hora_inicio":"2023-08-24T14:34:41.948Z","fecha_hora_final":"2023-08-24T16:05:39.733Z","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T12:31:21.750Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_jornadas VALUES (3, 4, '{"_id":"64e78775b93641538678bd5f","rut_maestro":"12345234-7","codigo_turno":"2","rut_ayudante":"12345234-7","patente_vehiculo":"AABB-00","km_inicia":"12300600","km_final":"123334555","codigo_oficina":"1","fecha_hora_inicio":"2023-08-24T16:36:16.452Z","fecha_hora_final":"2023-08-24T16:38:05.849Z","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T12:38:13.227Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_jornadas VALUES (4, 4, '{"_id":"64e7be4bb93641538678bd9f","rut_maestro":"12345234-7","codigo_turno":"3","rut_ayudante":"12345234-7","patente_vehiculo":"AABB-00","km_inicia":"1200120","km_final":"12333360","codigo_oficina":"2","fecha_hora_inicio":"2023-08-24T20:29:08.510Z","fecha_hora_final":"2023-08-24T20:31:08.468Z","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T16:32:11.962Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_jornadas VALUES (5, 4, '{"_id":"64e7bf60b93641538678bdb8","rut_maestro":"12345234-7","codigo_turno":"2","rut_ayudante":"12345234-7","patente_vehiculo":"AABB-00","km_inicia":"10201020","km_final":"120120120","codigo_oficina":"1","fecha_hora_inicio":"2023-08-24T20:36:11.089Z","fecha_hora_final":"2023-08-24T20:36:37.860Z","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T16:36:48.130Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_jornadas VALUES (6, 4, '{"_id":"64e7c0dbb93641538678bdd1","rut_maestro":"12345234-7","codigo_turno":"2","rut_ayudante":"12345234-7","patente_vehiculo":"AABB-00","km_inicia":"12001200","km_final":"1250000","codigo_oficina":"1","fecha_hora_inicio":"2023-08-24T20:41:50.884Z","fecha_hora_final":"2023-08-24T20:43:06.446Z","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T16:43:07.908Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');
INSERT INTO sae.movil_jornadas VALUES (7, 4, '{"_id":"64e7cfa0b93641538678bdf8","rut_maestro":"12345234-7","codigo_turno":"2","rut_ayudante":"12345234-7","patente_vehiculo":"AABB-00","km_inicia":"122230000","km_final":"123000","codigo_oficina":"3","fecha_hora_inicio":"2023-08-24T21:40:29.724Z","fecha_hora_final":"2023-08-24T21:45:56.838Z","isActive":true,"estado_envio":1,"fecha_hora_recepcion":"2023-08-24T17:46:08.308Z","__v":0}', '2023-08-25 14:36:04', '2023-08-25 14:36:04');


--
-- TOC entry 3793 (class 0 OID 385750)
-- Dependencies: 226
-- Data for Name: precios_base; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.precios_base VALUES (1, 1, 1, 1, 1, 22009, NULL);
INSERT INTO sae.precios_base VALUES (2, 1, 1, 1, 2, 22009, NULL);
INSERT INTO sae.precios_base VALUES (3, 1, 1, 1, 3, 22009, NULL);
INSERT INTO sae.precios_base VALUES (4, 1, 1, 1, 4, 22009, NULL);
INSERT INTO sae.precios_base VALUES (5, 1, 1, 2, 1, 27508, NULL);
INSERT INTO sae.precios_base VALUES (6, 1, 1, 2, 2, 27508, NULL);
INSERT INTO sae.precios_base VALUES (7, 1, 1, 2, 3, 27508, NULL);
INSERT INTO sae.precios_base VALUES (8, 1, 1, 2, 4, 27508, NULL);
INSERT INTO sae.precios_base VALUES (9, 1, 1, 3, 1, 29344, NULL);
INSERT INTO sae.precios_base VALUES (10, 1, 1, 3, 2, 29344, NULL);
INSERT INTO sae.precios_base VALUES (11, 1, 1, 3, 3, 29344, NULL);
INSERT INTO sae.precios_base VALUES (12, 1, 1, 3, 4, 29344, NULL);
INSERT INTO sae.precios_base VALUES (13, 1, 1, 4, 1, 33009, NULL);
INSERT INTO sae.precios_base VALUES (14, 1, 1, 4, 2, 33009, NULL);
INSERT INTO sae.precios_base VALUES (15, 1, 1, 4, 3, 33009, NULL);
INSERT INTO sae.precios_base VALUES (16, 1, 1, 4, 4, 33009, NULL);
INSERT INTO sae.precios_base VALUES (17, 1, 1, 5, 1, 0, NULL);
INSERT INTO sae.precios_base VALUES (18, 1, 1, 5, 2, 0, NULL);
INSERT INTO sae.precios_base VALUES (19, 1, 1, 5, 3, 0, NULL);
INSERT INTO sae.precios_base VALUES (20, 1, 1, 5, 4, 0, NULL);
INSERT INTO sae.precios_base VALUES (21, 1, 2, 1, 1, 22323, NULL);
INSERT INTO sae.precios_base VALUES (22, 1, 2, 1, 2, 22323, NULL);
INSERT INTO sae.precios_base VALUES (23, 1, 2, 1, 3, 22323, NULL);
INSERT INTO sae.precios_base VALUES (24, 1, 2, 1, 4, 22323, NULL);
INSERT INTO sae.precios_base VALUES (25, 1, 2, 2, 1, 27901, NULL);
INSERT INTO sae.precios_base VALUES (26, 1, 2, 2, 2, 27901, NULL);
INSERT INTO sae.precios_base VALUES (27, 1, 2, 2, 3, 27901, NULL);
INSERT INTO sae.precios_base VALUES (28, 1, 2, 2, 4, 27901, NULL);
INSERT INTO sae.precios_base VALUES (29, 1, 2, 3, 1, 29763, NULL);
INSERT INTO sae.precios_base VALUES (30, 1, 2, 3, 2, 29763, NULL);
INSERT INTO sae.precios_base VALUES (31, 1, 2, 3, 3, 29763, NULL);
INSERT INTO sae.precios_base VALUES (32, 1, 2, 3, 4, 29763, NULL);
INSERT INTO sae.precios_base VALUES (33, 1, 2, 4, 1, 33481, NULL);
INSERT INTO sae.precios_base VALUES (34, 1, 2, 4, 2, 33481, NULL);
INSERT INTO sae.precios_base VALUES (35, 1, 2, 4, 3, 33481, NULL);
INSERT INTO sae.precios_base VALUES (36, 1, 2, 4, 4, 33481, NULL);
INSERT INTO sae.precios_base VALUES (37, 1, 2, 5, 1, 0, NULL);
INSERT INTO sae.precios_base VALUES (38, 1, 2, 5, 2, 0, NULL);
INSERT INTO sae.precios_base VALUES (39, 1, 2, 5, 3, 0, NULL);
INSERT INTO sae.precios_base VALUES (40, 1, 2, 5, 4, 0, NULL);
INSERT INTO sae.precios_base VALUES (41, 1, 3, 1, 1, 22795, NULL);
INSERT INTO sae.precios_base VALUES (42, 1, 3, 1, 2, 22795, NULL);
INSERT INTO sae.precios_base VALUES (43, 1, 3, 1, 3, 22795, NULL);
INSERT INTO sae.precios_base VALUES (44, 1, 3, 1, 4, 22795, NULL);
INSERT INTO sae.precios_base VALUES (45, 1, 3, 2, 1, 28491, NULL);
INSERT INTO sae.precios_base VALUES (46, 1, 3, 2, 2, 28491, NULL);
INSERT INTO sae.precios_base VALUES (47, 1, 3, 2, 3, 28491, NULL);
INSERT INTO sae.precios_base VALUES (48, 1, 3, 2, 4, 28491, NULL);
INSERT INTO sae.precios_base VALUES (49, 1, 3, 3, 1, 30392, NULL);
INSERT INTO sae.precios_base VALUES (50, 1, 3, 3, 2, 30392, NULL);
INSERT INTO sae.precios_base VALUES (51, 1, 3, 3, 3, 30392, NULL);
INSERT INTO sae.precios_base VALUES (52, 1, 3, 3, 4, 30392, NULL);
INSERT INTO sae.precios_base VALUES (53, 1, 3, 4, 1, 34188, NULL);
INSERT INTO sae.precios_base VALUES (54, 1, 3, 4, 2, 34188, NULL);
INSERT INTO sae.precios_base VALUES (55, 1, 3, 4, 3, 34188, NULL);
INSERT INTO sae.precios_base VALUES (56, 1, 3, 4, 4, 34188, NULL);
INSERT INTO sae.precios_base VALUES (57, 1, 3, 5, 1, 0, NULL);
INSERT INTO sae.precios_base VALUES (58, 1, 3, 5, 2, 0, NULL);
INSERT INTO sae.precios_base VALUES (59, 1, 3, 5, 3, 0, NULL);
INSERT INTO sae.precios_base VALUES (60, 1, 3, 5, 4, 0, NULL);
INSERT INTO sae.precios_base VALUES (61, 1, 4, 1, 1, 31441, NULL);
INSERT INTO sae.precios_base VALUES (62, 1, 4, 1, 2, 31441, NULL);
INSERT INTO sae.precios_base VALUES (63, 1, 4, 1, 3, 31441, NULL);
INSERT INTO sae.precios_base VALUES (64, 1, 4, 1, 4, 31441, NULL);
INSERT INTO sae.precios_base VALUES (65, 1, 4, 2, 1, 39298, NULL);
INSERT INTO sae.precios_base VALUES (66, 1, 4, 2, 2, 39298, NULL);
INSERT INTO sae.precios_base VALUES (67, 1, 4, 2, 3, 39298, NULL);
INSERT INTO sae.precios_base VALUES (68, 1, 4, 2, 4, 39298, NULL);
INSERT INTO sae.precios_base VALUES (69, 1, 4, 3, 1, 41920, NULL);
INSERT INTO sae.precios_base VALUES (70, 1, 4, 3, 2, 41920, NULL);
INSERT INTO sae.precios_base VALUES (71, 1, 4, 3, 3, 41920, NULL);
INSERT INTO sae.precios_base VALUES (72, 1, 4, 3, 4, 41920, NULL);
INSERT INTO sae.precios_base VALUES (73, 1, 4, 4, 1, 47156, NULL);
INSERT INTO sae.precios_base VALUES (74, 1, 4, 4, 2, 47156, NULL);
INSERT INTO sae.precios_base VALUES (75, 1, 4, 4, 3, 47156, NULL);
INSERT INTO sae.precios_base VALUES (76, 1, 4, 4, 4, 47156, NULL);
INSERT INTO sae.precios_base VALUES (77, 1, 4, 5, 1, 0, NULL);
INSERT INTO sae.precios_base VALUES (78, 1, 4, 5, 2, 0, NULL);
INSERT INTO sae.precios_base VALUES (79, 1, 4, 5, 3, 0, NULL);
INSERT INTO sae.precios_base VALUES (80, 1, 4, 5, 4, 0, NULL);


--
-- TOC entry 3806 (class 0 OID 385883)
-- Dependencies: 239
-- Data for Name: reporte_detalle_estado_resultado; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.reporte_detalle_estado_resultado VALUES (1, 6, 1);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (2, 6, 2);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (3, 6, 3);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (4, 6, 4);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (5, 6, 5);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (6, 7, 10);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (7, 7, 20);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (8, 7, 30);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (9, 7, 40);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (10, 7, 50);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (11, 8, 10);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (12, 8, 20);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (13, 8, 30);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (14, 8, 40);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (15, 8, 50);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (16, 9, 10);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (17, 9, 20);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (18, 9, 30);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (19, 9, 40);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (20, 9, 50);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (21, 10, 10);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (22, 10, 20);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (23, 10, 30);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (24, 10, 40);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (25, 10, 50);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (26, 11, 1);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (27, 11, 2);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (28, 11, 3);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (29, 11, 4);
INSERT INTO sae.reporte_detalle_estado_resultado VALUES (30, 11, 5);


--
-- TOC entry 3808 (class 0 OID 385891)
-- Dependencies: 241
-- Data for Name: reporte_errores; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.reporte_errores VALUES (1, 'jor', 2, 'SequelizeUniqueConstraintError: Validation error');
INSERT INTO sae.reporte_errores VALUES (2, 'jor', 3, 'SequelizeUniqueConstraintError: Validation error');
INSERT INTO sae.reporte_errores VALUES (3, 'jor', 4, 'SequelizeUniqueConstraintError: Validation error');
INSERT INTO sae.reporte_errores VALUES (4, 'jor', 5, 'SequelizeUniqueConstraintError: Validation error');
INSERT INTO sae.reporte_errores VALUES (5, 'jor', 6, 'SequelizeUniqueConstraintError: Validation error');
INSERT INTO sae.reporte_errores VALUES (6, 'jor', 7, 'SequelizeUniqueConstraintError: Validation error');


--
-- TOC entry 3810 (class 0 OID 385902)
-- Dependencies: 243
-- Data for Name: reporte_estado_resultado; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.reporte_estado_resultado VALUES (3, 7, 1, 1, 1, '2023-09-07 00:00:00', '2023-09-07 00:00:00', 'nombre_doc', 'url_doc', '2023-09-07 00:00:00', '2023-09-07 00:00:00', 1, 1);
INSERT INTO sae.reporte_estado_resultado VALUES (4, 7, 1, 1, 1, '2023-09-07 00:00:00', '2023-09-07 00:00:00', 'nombre_doc', 'url_doc', '2023-09-07 00:00:00', '2023-09-07 00:00:00', 1, 1);
INSERT INTO sae.reporte_estado_resultado VALUES (5, 7, 1, 1, 1, '2023-09-07 00:00:00', '2023-09-07 00:00:00', 'nombre_doc', 'url_doc', '2023-09-07 00:00:00', '2023-09-07 00:00:00', 1, 1);
INSERT INTO sae.reporte_estado_resultado VALUES (6, 7, 1, 1, 1, '2023-09-07 00:00:00', '2023-09-07 00:00:00', 'nombre_doc', 'url_doc', '2023-09-07 00:00:00', '2023-09-07 00:00:00', 1, 1);
INSERT INTO sae.reporte_estado_resultado VALUES (7, 7, 1, 1, 1, '2023-09-08 00:00:00', '2023-09-08 00:00:00', 'nombre_doc', 'url_doc', '2023-09-08 00:00:00', '2023-09-08 00:00:00', 1, 1);
INSERT INTO sae.reporte_estado_resultado VALUES (8, 7, 1, 1, 1, '2023-09-08 00:00:00', '2023-09-08 00:00:00', 'nombre_doc', 'url_doc', '2023-09-08 00:00:00', '2023-09-08 00:00:00', 1, 1);
INSERT INTO sae.reporte_estado_resultado VALUES (9, 7, 1, 1, 1, '2023-09-08 00:00:00', '2023-09-08 00:00:00', 'nombre_doc', 'url_doc', '2023-09-08 00:00:00', '2023-09-08 00:00:00', 1, 1);
INSERT INTO sae.reporte_estado_resultado VALUES (10, 7, 1, 1, 1, '2023-09-08 00:00:00', '2023-09-08 00:00:00', 'nombre_doc', 'url_doc', '2023-09-08 00:00:00', '2023-09-08 00:00:00', 1, 1);
INSERT INTO sae.reporte_estado_resultado VALUES (11, 7, 1, 1, 9, '2023-09-01 00:00:00', '2023-09-30 00:00:00', 'nombre de documento', 'url de documento', '2023-09-30 00:00:00', '2023-09-30 00:00:00', 1, 1);


--
-- TOC entry 3812 (class 0 OID 385931)
-- Dependencies: 245
-- Data for Name: reporte_estados; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.reporte_estados VALUES (1, 'INGRESADO');
INSERT INTO sae.reporte_estados VALUES (2, 'LEIDO');
INSERT INTO sae.reporte_estados VALUES (3, 'PROCESADO');
INSERT INTO sae.reporte_estados VALUES (4, 'ERROR');
INSERT INTO sae.reporte_estados VALUES (5, 'test0');


--
-- TOC entry 3814 (class 0 OID 385939)
-- Dependencies: 247
-- Data for Name: reporte_eventos; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.reporte_eventos VALUES (135, '400', 'DOMIC', '12345234-7', '12345678-0', 2, 2, 'leones', 'leones', '2023-08-30 12:57:00', 1, '64ef74e928c77ffe2d1e146e', '{"latitude":"-33.41999039057029","longitude":"-70.6056387071224"}');
INSERT INTO sae.reporte_eventos VALUES (136, '424', 'SSEEB', '12345234-7', '12345678-0', 2, 2, 'test1', 'luis tayer ojeda', '2023-08-30 12:45:00', 1, '64ef722c28c77ffe2d1e1431', '{"latitude":"-33.422294430756395","longitude":"-70.60089563883146"}');
INSERT INTO sae.reporte_eventos VALUES (137, '358', 'DOMIC', '12345234-7', '12345678-0', 2, 2, 'holanda', 'holanda', '2023-08-30 12:48:00', 1, '64ef74c928c77ffe2d1e1468', '{"latitude":"-33.42266484632476","longitude":"-70.60263488448281"}');
INSERT INTO sae.reporte_eventos VALUES (138, '1301230', 'DOMIC', '12345234-7', '12345678-0', 2, 2, 'holanda', '100300', '2023-08-30 12:48:00', 1, '64ef74cc28c77ffe2d1e146b', '{"latitude":"-33.422708599859405","longitude":"-70.602630106798"}');
INSERT INTO sae.reporte_eventos VALUES (139, '101010', 'DOMIC', '12345234-7', '12345678-0', 2, 2, 'werwer', 'lota', '2023-08-30 12:44:00', 1, '64ef720428c77ffe2d1e142e', '{"latitude":"-33.422296246211914","longitude":"-70.60089501817588"}');
INSERT INTO sae.reporte_eventos VALUES (140, '120120', 'DOMIC', '12345234-7', '12345234-7', 1, 2, '120120', '120120', '2023-08-30 11:17:00', 1, '64ef5d96084a1d3882800204', '{"latitude":"-33.4186977","longitude":"-70.6019628"}');
INSERT INTO sae.reporte_eventos VALUES (141, '123', 'DOMIC', '12345234-7', '12345678-0', 2, 2, '123', '123', '2023-08-30 12:15:00', 1, '64ef6b1228c77ffe2d1e1428', '{"latitude":"-33.4186163659872","longitude":"-70.60187450242209"}');
INSERT INTO sae.reporte_eventos VALUES (95, '10200200200', 'SSEEB', '12345234-7', '12345234-7', 1, 1, 'WEWEWEW', 'EWEWEWE', '2023-08-24 09:12:00', 1, '64e757a85c66cbeec250d9f5', '{"latitude":"undefined","longitude":"undefined"}');
INSERT INTO sae.reporte_eventos VALUES (96, '12000300012', 'SSEEB', '12345234-7', '12345234-7', 2, 1, 'cables cortados en el poste', 'pajaritos 2555', '2023-08-24 09:32:00', 1, '64e75c095c66cbeec250da03', '{"latitude":"undefined","longitude":"undefined"}');
INSERT INTO sae.reporte_eventos VALUES (97, '1233600', 'DOMIC', '12345234-7', '12345234-7', 2, 1, 'cambio de cables ', 'pajaritos 3652', '2023-08-24 12:36:00', 1, '64e7872bb93641538678bd5b', '{"latitude":"undefined","longitude":"undefined"}');
INSERT INTO sae.reporte_eventos VALUES (98, '130009000', 'DOMIC', '12345234-7', '12345234-7', 2, 1, 'WERWERWER', 'WERWER', '2023-08-24 15:59:00', 1, '64e7bb54b93641538678bd8e', '{"latitude":"undefined","longitude":"undefined"}');
INSERT INTO sae.reporte_eventos VALUES (99, '120003', 'LINMT', '12345234-7', '12345234-7', 3, 2, 'zona sin energia', 'pajaritos 445', '2023-08-24 16:30:00', 1, '64e7be1fb93641538678bd9c', '{"latitude":"undefined","longitude":"undefined"}');
INSERT INTO sae.reporte_eventos VALUES (100, '10020', 'LINMT', '12345234-7', '12345234-7', 2, 3, 'zona sin energia ', 'pajaritos 456', '2023-08-24 17:41:00', 1, '64e7cf12b93641538678bdf5', '{"latitude":"undefined","longitude":"undefined"}');


--
-- TOC entry 3816 (class 0 OID 385985)
-- Dependencies: 249
-- Data for Name: reporte_jornada; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.reporte_jornada VALUES (1, '12345234-7', '12345678-0', 2, 'AABB-00', 2, 123456, 123456, '2023-08-30 12:57:30', '2023-08-30 13:28:01', 1, '64ef7c2928c77ffe2d1e14ab', '{"latitude":"-33.420023540997335","longitude":"-70.60561213648934"}');
INSERT INTO sae.reporte_jornada VALUES (2, '12345234-7', '12345678-9', 2, 'AABB-00', 4, 1, 2, '2023-08-31 12:18:21', '2023-08-31 12:18:28', 1, '64f0bd5728c77ffe2d1e170b', '{"latitude":"-33.4186878","longitude":"-70.6019551"}');
INSERT INTO sae.reporte_jornada VALUES (3, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 123123, 120120, '2023-08-30 11:48:47', '2023-08-30 11:49:12', 1, '64ef650f28c77ffe2d1e1418', '{"latitude":"-33.4186932","longitude":"-70.6019441"}');
INSERT INTO sae.reporte_jornada VALUES (4, '12345234-7', '12345678-0', 1, 'AABB-00', 2, 12, 123, '2023-08-30 15:52:48', '2023-08-30 15:54:30', 1, '64ef9e9028c77ffe2d1e150f', '{"latitude":"-33.4186837","longitude":"-70.6019112"}');
INSERT INTO sae.reporte_jornada VALUES (5, '12345234-7', '12345678-0', 2, 'AABB-00', 2, 120120, 1201200, '2023-08-30 16:54:54', '2023-08-30 17:03:03', 1, '64efae9c28c77ffe2d1e1553', '{"latitude":"-33.4186886","longitude":"-70.6019223"}');
INSERT INTO sae.reporte_jornada VALUES (6, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 120120, 120120, '2023-08-30 17:50:37', '2023-08-30 17:51:30', 1, '64efb9ed28c77ffe2d1e1569', '{"latitude":"-33.4186754","longitude":"-70.6019463"}');
INSERT INTO sae.reporte_jornada VALUES (7, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 600, 650, '2023-08-30 22:00:33', '2023-08-30 22:01:02', 1, '64eff46428c77ffe2d1e1589', '{"latitude":"-33.3926489","longitude":"-70.6336982"}');
INSERT INTO sae.reporte_jornada VALUES (8, '12345234-7', '12345678-0', 2, 'AABB-00', 2, 125125, 12001200, '2023-08-31 09:02:25', '2023-08-31 09:05:15', 1, '64f0901428c77ffe2d1e15ac', '{"latitude":"-33.4187061","longitude":"-70.6019056"}');
INSERT INTO sae.reporte_jornada VALUES (9, '12345234-7', '12345678-0', 2, 'AABB-00', 2, 12120, 120120, '2023-08-31 09:44:29', '2023-08-31 09:44:37', 1, '64f0994b28c77ffe2d1e15c9', '{"latitude":"-33.4186208","longitude":"-70.6017988"}');
INSERT INTO sae.reporte_jornada VALUES (10, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 12000, 412000, '2023-08-31 09:49:03', '2023-08-31 09:49:15', 1, '64f09a5f28c77ffe2d1e15e6', '{"latitude":"-33.4186208","longitude":"-70.6017988"}');
INSERT INTO sae.reporte_jornada VALUES (11, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 120300, 120001200, '2023-08-31 09:53:17', '2023-08-31 09:54:24', 1, '64f09ba728c77ffe2d1e1616', '{"latitude":"-33.4186208","longitude":"-70.6017988"}');
INSERT INTO sae.reporte_jornada VALUES (12, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 120120120, 11111, '2023-08-31 10:07:35', '2023-08-31 10:11:18', 1, '64f09f8a28c77ffe2d1e1640', '{"latitude":"-33.4185544","longitude":"-70.60195"}');
INSERT INTO sae.reporte_jornada VALUES (13, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 120120120, 12012012, '2023-08-31 10:14:29', '2023-08-31 10:21:53', 1, '64f0a20628c77ffe2d1e165d', '{"latitude":"-33.418696","longitude":"-70.6019548"}');
INSERT INTO sae.reporte_jornada VALUES (14, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 12001200, 1201200, '2023-08-31 10:33:57', '2023-08-31 10:33:57', 1, '64f0a4de28c77ffe2d1e167a', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (15, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 12012000, 1200015, '2023-08-31 10:53:15', '2023-08-31 10:53:24', 1, '64f0a96828c77ffe2d1e1697', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (16, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 2012000, 1201200300, '2023-08-31 11:05:48', '2023-08-31 11:09:10', 1, '64f0ad3028c77ffe2d1e16b4', '{"latitude":"-33.4187152","longitude":"-70.6019306"}');
INSERT INTO sae.reporte_jornada VALUES (17, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 120001200, 12001203030, '2023-08-31 11:47:38', '2023-08-31 11:47:51', 1, '64f0b64228c77ffe2d1e16d1', '{"latitude":"-33.41869","longitude":"-70.6019134"}');
INSERT INTO sae.reporte_jornada VALUES (18, '12345234-7', '12345678-0', 2, 'AABB-00', 2, 1, 2, '2023-08-31 12:28:13', '2023-08-31 12:28:21', 1, '64f0bfb628c77ffe2d1e172b', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (19, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 1, 2, '2023-08-31 12:34:49', '2023-08-31 12:34:56', 1, '64f0c13d28c77ffe2d1e173b', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (20, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 1, 2, '2023-08-31 12:38:37', '2023-08-31 12:38:45', 1, '64f0c21828c77ffe2d1e174b', '{"latitude":"-33.418676","longitude":"-70.6019378"}');
INSERT INTO sae.reporte_jornada VALUES (21, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 12, 13, '2023-08-31 12:43:21', '2023-08-31 12:43:40', 1, '64f0c34228c77ffe2d1e175b', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (22, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 12, 1, '2023-08-31 12:44:37', '2023-08-31 12:45:33', 1, '64f0c3af28c77ffe2d1e176b', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (23, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 12, 13, '2023-08-31 12:46:05', '2023-08-31 12:46:14', 1, '64f0c41928c77ffe2d1e1781', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (24, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 111, 222, '2023-08-31 14:43:43', '2023-08-31 14:44:05', 1, '64f0df7c28c77ffe2d1e1791', '{"latitude":"-33.4186963","longitude":"-70.6019082"}');
INSERT INTO sae.reporte_jornada VALUES (25, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 111222333, 111222333, '2023-08-31 14:54:16', '2023-08-31 14:54:27', 1, '64f0e1e528c77ffe2d1e17a1', '{"latitude":"-33.4187001","longitude":"-70.6019589"}');
INSERT INTO sae.reporte_jornada VALUES (26, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 123123, 123123, '2023-08-31 14:55:02', '2023-08-31 14:55:10', 1, '64f0e25f28c77ffe2d1e17b1', '{"latitude":"-33.4187001","longitude":"-70.6019589"}');
INSERT INTO sae.reporte_jornada VALUES (27, '12345234-7', '12345678-0', 2, 'AABB-00', 3, 111, 1111, '2023-08-31 15:03:33', '2023-08-31 15:03:45', 1, '64f0e42328c77ffe2d1e17ce', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (28, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 123123, 3333, '2023-08-31 15:08:39', '2023-08-31 15:08:50', 1, '64f0e54328c77ffe2d1e17de', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (29, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 120120, 12000, '2023-08-31 16:06:49', '2023-08-31 16:07:20', 1, '64f0f2fd28c77ffe2d1e181e', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (30, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 12300300, 10, '2023-08-31 16:39:11', '2023-08-31 16:39:25', 1, '64f0fb9a28c77ffe2d1e184b', '{"latitude":"-33.4186827","longitude":"-70.6019138"}');
INSERT INTO sae.reporte_jornada VALUES (31, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 1200300, 1230001111, '2023-08-31 16:56:36', '2023-08-31 16:57:09', 1, '64f0feb028c77ffe2d1e185e', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (32, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 1, 2, '2023-08-31 12:17:22', '2023-08-31 12:17:22', 1, '64f0bd1a28c77ffe2d1e16fb', '{"latitude":"-33.4186878","longitude":"-70.6019551"}');
INSERT INTO sae.reporte_jornada VALUES (33, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 1205500, 12333, '2023-08-31 17:39:18', '2023-08-31 17:41:55', 1, '64f109bb28c77ffe2d1e189c', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (34, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 1203000, 12000, '2023-08-31 17:44:54', '2023-08-31 17:59:47', 1, '64f10d5728c77ffe2d1e18af', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (35, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 10, 10, '2023-08-31 18:22:52', '2023-08-31 18:23:03', 1, '64f112e728c77ffe2d1e18c2', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (36, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 120001200, 12000360, '2023-08-31 18:24:00', '2023-08-31 18:24:48', 1, '64f1133d28c77ffe2d1e18d8', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (37, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 120001, 122, '2023-08-31 18:26:15', '2023-08-31 18:26:42', 1, '64f113ad28c77ffe2d1e18eb', '{"latitude":"-33.4185981","longitude":"-70.6019232"}');
INSERT INTO sae.reporte_jornada VALUES (38, '12345234-7', '12345678-0', 2, 'AABB-00', 3, 123000, 123000, '2023-08-31 18:28:08', '2023-08-31 18:28:39', 1, '64f1142428c77ffe2d1e18fe', '{"latitude":"-33.4185981","longitude":"-70.6019232"}');
INSERT INTO sae.reporte_jornada VALUES (39, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 1200002020, 120000, '2023-08-31 18:31:35', '2023-08-31 18:31:35', 1, '64f114f828c77ffe2d1e1914', '{"latitude":"-33.4185981","longitude":"-70.6019232"}');
INSERT INTO sae.reporte_jornada VALUES (40, '12345234-7', '12345678-9', 2, 'AABB-00', 4, 12300090, 123444, '2023-08-31 19:52:42', '2023-08-31 19:53:21', 1, '64f1280028c77ffe2d1e1941', '{"latitude":"-33.45040622216772","longitude":"-70.65082394351523"}');
INSERT INTO sae.reporte_jornada VALUES (41, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 12000, 1200, '2023-09-01 12:31:26', '2023-09-01 12:33:58', 1, '64f2127728c77ffe2d1e197d', '{"latitude":"-33.4187022","longitude":"-70.601945"}');
INSERT INTO sae.reporte_jornada VALUES (42, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 12300, 12333, '2023-09-01 12:39:22', '2023-09-01 13:16:01', 1, '64f21c5428c77ffe2d1e198d', '{"latitude":"-33.4284796","longitude":"-70.6097705"}');
INSERT INTO sae.reporte_jornada VALUES (43, '12345234-7', '12345678-0', 2, 'AABB-00', 2, 122888, 122999, '2023-09-01 15:21:11', '2023-09-01 15:22:34', 1, '64f239fd28c77ffe2d1e19a0', '{"latitude":"-33.4187763","longitude":"-70.6019282"}');
INSERT INTO sae.reporte_jornada VALUES (44, '12345234-7', '12345678-9', 2, 'AABB-00', 2, 3456, 123344555, '2023-09-01 15:25:05', '2023-09-01 15:26:04', 1, '64f23ace28c77ffe2d1e19b3', '{"latitude":"-33.418545128648454","longitude":"-70.60178254001387"}');
INSERT INTO sae.reporte_jornada VALUES (45, '12345234-7', '12345678-0', 2, 'AABB-00', 2, 123444, 1233455, '2023-09-01 15:29:21', '2023-09-01 15:29:59', 1, '64f23bba28c77ffe2d1e19c6', '{"latitude":"-33.4186163659872","longitude":"-70.60187450242209"}');
INSERT INTO sae.reporte_jornada VALUES (46, '12345234-7', '12345678-9', 2, 'AABB-00', 3, 1010, 12, '2023-08-31 17:31:40', '2023-08-31 17:31:40', 1, '64f1081828c77ffe2d1e1883', '{"latitude":"-33.418661","longitude":"-70.601944"}');


--
-- TOC entry 3881 (class 0 OID 393384)
-- Dependencies: 314
-- Data for Name: resultado_estado_resultado; Type: TABLE DATA; Schema: sae; Owner: postgres
--



--
-- TOC entry 3879 (class 0 OID 393374)
-- Dependencies: 312
-- Data for Name: resultado_estados; Type: TABLE DATA; Schema: sae; Owner: postgres
--

INSERT INTO sae.resultado_estados VALUES (1, 'test');


--
-- TOC entry 3885 (class 0 OID 426155)
-- Dependencies: 318
-- Data for Name: rendimiento; Type: TABLE DATA; Schema: temp; Owner: postgres
--

INSERT INTO temp.rendimiento VALUES (118, 'BOQUILLA DE BAKELITA CON TUERCA PARA CALECO', 'UN');
INSERT INTO temp.rendimiento VALUES (3, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 10KVA, 15KV, 1X220 V. TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (5, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 25KVA, 15KV, 1X220 V.', 'UN');
INSERT INTO temp.rendimiento VALUES (10, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 30KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (13, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 45KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (16, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 75KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (17, 'USAR COD. 45601, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 100KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (9954, 'TUERCA OJO 5/8IN PERNO OJO', 'UN');
INSERT INTO temp.rendimiento VALUES (9955, 'SOPORTE DE SUSPENSION PARA CABLE PREENSAMBLADO', 'UN');
INSERT INTO temp.rendimiento VALUES (20, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 300KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (38, 'AFIANZA DE ACERO ANGULO GALVANIZADO DE 65X65X7X630 MM PARA TRANSFORMADOR DE NORMA NACIONAL', 'UN');
INSERT INTO temp.rendimiento VALUES (40, 'AISLADOR DE DISCO DE PORCELANA 6 ½" DE DIAMETRO, 7" DE DISTANCIA DE FUGA, CON PASADOR, CLASE ANSI 52-1, COLOR GRIS CLARO, REFERENCIA SANTANA', 'UN');
INSERT INTO temp.rendimiento VALUES (44, 'AISLADOR ESPIGA DE PORCELANA 5 1/2" DE DIAMETRO, 9" DISTANCIA DE FUGA, ROSCA 1", CLASE ANSI 55-4, COLOR GRIS, REFERENCIA SANTANA PI23152-RT', 'UN');
INSERT INTO temp.rendimiento VALUES (49, 'AISLADOR DE CARRETE DE PORCELANA, 57 MM DE DIAMETRO, 54 MM DE ALTO, ANSI 53-1, TE-1012', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISLADOR DE CARRETE DE PORCELANA, 79 MM DE DIAMETRO, 76 MM DE ALTO, ANSI53-2, TE-1011', 'UN');
INSERT INTO temp.rendimiento VALUES (51, 'AISLADOR DE TENSION DE PORCELANA, 73 MM DE DIAMETRO, 108 MM DE ALTO, CLASE ANSI 54-2, COLOR GRIS, REFERENCIA SANTANA CA12014, PLANO CGE M-1833-N', 'UN');
INSERT INTO temp.rendimiento VALUES (59, 'ALAMBRE DE COBRE DESNUDO, DURO, # 5 AWG 16 MM2', 'KG');
INSERT INTO temp.rendimiento VALUES (70, 'ALAMBRE DE COBRE AISLADO, TIPO PI Ó PW, 6 MM2, (2,76 MM) PARA ACOMETIDA EMPALMES AEREOS', 'M');
INSERT INTO temp.rendimiento VALUES (71, 'FN USAR COD. 13559, ALAMBRE DE COBRE AISLADO, TIPO THW, # 10 AWG (5,26 MM2) PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (72, 'FN USAR COD. 13560, ALAMBRE DE COBRE AISLADO, TIPO THW, # 8 AWG (8,37 MM2), PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (73, 'ALAMBRE DE COBRE AISLADO, TIPO XT, XTU O XCS, 10 AWG (5,26MM2) PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (85, 'RETENCION PREFORMADA DE ACERO GALVANIZADO PARA TIRANTE DE ACERO GALVANIZADO DE 3/8" DIAMETRO, CATALOGO GDE-1107HB, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (129, 'CABLE DE COBRE DESNUDO, DURO, # 2 AWG (33,6 MM2) 7 HEBRAS', 'KG');
INSERT INTO temp.rendimiento VALUES (132, 'CABLE DE COBRE DESNUDO, DURO, # 1/0 AWG (53,5 MM2) 7 HEBRAS', 'KG');
INSERT INTO temp.rendimiento VALUES (136, 'CABLE DE COBRE DESNUDO, DURO, # 3/0 AWG (85,0MM2) 7 HEBRAS, ESP.29 A-124', 'KG');
INSERT INTO temp.rendimiento VALUES (140, 'FN USAR COD. 13561, CABLE DE COBRE AISLADO, TIPO THW, # 6 AWG (13,3 MM2), PARA  B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (141, 'FN USAR COD. 13562, CABLE DE COBRE AISLADO, TIPO THW, # 4 AWG (21,2 MM2), PARA  B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (142, 'FN USAR COD. 13563, CABLE DE COBRE AISLADO, TIPO THW, # 2 AWG (33,6 MM2), PARA  B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (144, 'FN USAR COD. 13897, CABLE DE COBRE AISLADO, TIPO THW, # 2/0 AWG ( 67,4 MM2), PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (145, 'FN USAR COD. 13579, CABLE DE COBRE AISLADO, TIPO THW, # 4/0 AWG (107 MM2) PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (150, 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 6 AWG (13,3 MM2) PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (151, 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 2 AWG (33,63 MM2) PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (152, 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 2/0 AWG, (67,4 MM2), PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (153, 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 4/0 AWG, ( 107 MM2), PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (160, 'CAJA METALICA PARA MEDIDOR 1F 400X200 MM, TIPO INTEMPERIE CON VISOR', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (178, 'CANCAMO DE FIERRO GALVANIZADO ABIERTO CON HILO PARA MADERA 7,9 MM x110 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (181, 'CAÑERIA GALVANIZADA, TIPO ISO R II 1/2", CON HILO SIN COPLA', 'M');
INSERT INTO temp.rendimiento VALUES (182, 'CAÑERIA GALVANIZADA, TIPO ISO R II 3/4", CON HILO SIN COPLA', 'M');
INSERT INTO temp.rendimiento VALUES (183, 'CAÑERIA GALVANIZADA, TIPO ISO R II, 1", CON HILO SIN COPLA', 'M');
INSERT INTO temp.rendimiento VALUES (213, 'CODO GALVANIZADO 1" PARA CAÑERIA', 'UN');
INSERT INTO temp.rendimiento VALUES (216, 'CODO GALVANIZADO 2" PARA CAÑERIA', 'UN');
INSERT INTO temp.rendimiento VALUES (235, 'CRUCETA DE FIERRO GALVANIZADA L 80X80X10X2000MM', 'UN');
INSERT INTO temp.rendimiento VALUES (239, 'CURVA DE REDUCCION PLASTICA EN U PARA CAÑERIA DE 3/4" A 1/2"', 'UN');
INSERT INTO temp.rendimiento VALUES (240, 'CURVA DE REDUCCION PLASTICA PARA CAÑERIA DE 1 1/4" A 1"', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL DE FIERRO GALVANIZADO PLANO DE 32X6X935 MM, CON UNA AGUJEREDURADE 1/2" EN UN EXTREMO Y 2 AGUJEREADURAS DE 5/8" EN EL OTRO EXTREMO', 'UN');
INSERT INTO temp.rendimiento VALUES (250, 'DIAGONAL DE FIERRO GALVANIZADO L 50X50X6X1455 MM PARA CRUCETA CANTILEVER, C/SOPORTE, PERNO DE 5/8 X 1 1/2" Y GOLILLA DE PRESION', 'UN');
INSERT INTO temp.rendimiento VALUES (251, 'DIAGONAL DE FIERRO GALVANIZADO L 50X50X6X935 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (252, 'DIAGONAL DE FIERRO GALVANIZADO PLANO 50X8X1035 MM, PARA REFUERZO DE CRUCETA', 'UN');
INSERT INTO temp.rendimiento VALUES (254, 'GOLILLA DE NEOPLENE DE 3 MM ESPESOR Y 2,1 X 3,5 CM DIAMETRO INTERIOR Y EXTERIOR RESPECTIVAMENTE', 'UN');
INSERT INTO temp.rendimiento VALUES (255, 'GOLILLA DE NEOPLENE DE 3 MM ESPESOR Y 2,7 X 4,0 CM DIAMETRO INTERIOR Y EXTERIOR RESPECTIVAMENTE', 'UN');
INSERT INTO temp.rendimiento VALUES (256, 'GOLILLA DE NEOPLENE DE 3 MM ESPESOR Y 3,5 X 4,7 CM DIAMETRO INTERIOR Y EXTERIOR RESPECTIVAMENTE', 'UN');
INSERT INTO temp.rendimiento VALUES (269, 'ESPACIADOR GALVANIZADO PARA B.T. PARA 5 SOPORTES DE 1 VIA', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA DE 40X40X5 MM, PARA PERNO DE 1/2"', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA DE 40X40X5 MM, PARA PERNO DE 5/8"', 'UN');
INSERT INTO temp.rendimiento VALUES (295, 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA DE 50X50X2 MM, PARA CAÑERIA DE 1"', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA DE PRESION DE FIERRO GALVANIZADO PARA PERNO DE 1/2"', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA DE PRESION DE FIERRO GALVANIZADO PARA PERNO DE 5/8"', 'UN');
INSERT INTO temp.rendimiento VALUES (302, 'GOLILLA DE PRESION DE FIERRO GALVANIZADO PARA PERNO DE 3/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (317, 'GRAPA DE ANCLAJE DE HIERRO MALEABLE PARA CONDUCTOR DE COBRE # 4 - 4/0 AWG, 15000 LIBRAS DE RUPTURA MECANICA, CATALOGO FQD 58-3, MARCA MACLEAN', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALVANIZADO CON PASADOR Y CHAVETA, DIAMETRO 12 MM, PERFORACION 18 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (332, 'GUARDACABO ACERO GALVANIZADO DE 1/2" PARA CABLE 3/8"', 'UN');
INSERT INTO temp.rendimiento VALUES (334, 'HILO FUSIBLE 1A, CURVA T, PARA SECCIONADOR  FUSIBLE A.T. EXTERIOR, CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (336, 'HILO FUSIBLE 2A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (338, 'HILO FUSIBLE 3A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (341, 'HILO FUSIBLE 6A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (342, 'HILO FUSIBLE 8A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA FIJA', 'UN');
INSERT INTO temp.rendimiento VALUES (343, 'HILO FUSIBLE 10A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (344, 'HILO FUSIBLE 12A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (346, 'HILO FUSIBLE 15A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (348, 'HILO FUSIBLE 20A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOBIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (349, 'HILO FUSIBLE 25A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOBIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (353, 'HILO FUSIBLE 40A, CURVA T, PARA SEC. FUS. A.T. EXTERIOR, CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (369, 'HUINCHA DE GOMA DE 3/4" ANCHO', 'ROL');
INSERT INTO temp.rendimiento VALUES (373, 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 1F 220 V, 1X10A, 6KA RUPTURA, RIEL AMERICANO, SAIME', 'UN');
INSERT INTO temp.rendimiento VALUES (375, 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 1F 220 V, 1X15A, 6KA RUPTURA, RIEL AMERICANO, SAIME', 'UN');
INSERT INTO temp.rendimiento VALUES (376, 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 1F 220 V, 1X20A, 6KA RUPTURA, RIEL AMERICANO, SAIME', 'UN');
INSERT INTO temp.rendimiento VALUES (378, 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 1F 220 V, 1X40A, 6KA RUPTURA, RIEL AMERICANO, SAIME', 'UN');
INSERT INTO temp.rendimiento VALUES (389, 'MEDIA CAÑA GALVANIZADA DE PROTECCIÓN PARA TIRANTE', 'UN');
INSERT INTO temp.rendimiento VALUES (413, 'LAMPARA VAPOR DE NA ALTA PRESION DE 150W, ROSCA E-40, 100V ARCO, 14500 LUMENES', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X5"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (434, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X9"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (435, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X1 1/2"X1" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (436, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X2"X1 1/2" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (437, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X3"X1 1/2" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (438, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X5"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (440, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X7"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (441, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X8"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X9"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (443, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X10"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (444, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X11"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (445, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X12"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X14"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (447, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X15"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (448, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X16"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (484, 'PLETINA GALVANIZADA LARGA DE 75X10X475 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (485, 'PLETINA GALVANIZADA CORTA DE 75X10X365 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (491, 'PRENSA PARALELA DE BRONCE PARA CONDUCTOR 180-1 # 6-1/0 AWG CON CUERPO DE BRONCE, UN PERNO DE COBRE DE 5/16" X 1 3/4" Y 2 TUERCAS DE BRONCE', 'UN');
INSERT INTO temp.rendimiento VALUES (502, 'CONECTOR MUELA BIMETALICO BRONCE ESTAÑADO AL/CU: PASO. 2-4/0, DERIVACION 6-4/0 CON 1 PERNO DE ACERO ZINCADO 3/8 X 1 3/4" Y 1 DE ACERO ZINCADO 3/8"', 'UN');
INSERT INTO temp.rendimiento VALUES (522, 'SEGURO AEREO DE PORCELANA PARA EMPALME, EXTERIOR, 250V, 10A, MONOPOLAR', 'UN');
INSERT INTO temp.rendimiento VALUES (524, 'SEGURO AEREO DE PORCELANA PARA EMPALME, EXTERIOR, 250V, 60A, MONOPOLAR', 'UN');
INSERT INTO temp.rendimiento VALUES (525, 'SEGURO AEREO DE PORCELANA PARA EMPALME, EXTERIOR, 250V, 100A, MONOPOLAR', 'UN');
INSERT INTO temp.rendimiento VALUES (544, 'SOPORTE DE REMATE GALVANIZADO DE 1 VIA, PARA B.T., PARA AISLADOR CARRETE DE 76MM, ORIFICIO CENTRAL 18MM', 'UN');
INSERT INTO temp.rendimiento VALUES (545, 'SOPORTE DE REMATE GALVANIZADO DE 1 VIA, PARA B.T., PARA AISLADOR CARRETE DE 57MM, ORIFICIO CENTRAL 14MM.', 'UN');
INSERT INTO temp.rendimiento VALUES (560, 'CONECTOR SOLDABLE TERMINAL DE CU-NI REMA TIPO ESTAMPADO, PARA CABLE 35 MM2 (2 AWG)', 'UN');
INSERT INTO temp.rendimiento VALUES (569, 'BARRA TOMA TIERRA COPPERWELD DE 5/8" X 3 MTS, 400 MICRONES', 'UN');
INSERT INTO temp.rendimiento VALUES (594, 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA PERNO DE 5/8" HILO GRUESO BSW', 'UN');
INSERT INTO temp.rendimiento VALUES (597, 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA CAÑERIA DE 3/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (599, 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA CAÑERIA DE 1 1/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (616, 'VIGA U PORTA TRANSFORMADOR GALVANIZADA DE 125X60X5X2320 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (618, 'VIGUETA U PORTA VIGA GALVANIZADA DE 125 X 60 X 5 X 500 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (635, 'AISLADOR POLIMERICO DE SILICONA SUSPENSION CLASE 28KV, MARCA SILPAK', 'UN');
INSERT INTO temp.rendimiento VALUES (636, 'FN USAR COD. 637, AISLADOR ESPIGA DE PLASTICO, ALTO IMPACTO, 15KV, ROSCA 1", DISTANCIA DE FUGA 12", CATALOGO HPI-15, MARACA HENDRIX', 'UN');
INSERT INTO temp.rendimiento VALUES (637, 'AISLADOR ESPIGA DE PLASTICO, ALTO IMPACTO, 25 KV, ROSCA 1 3/8", DISTANCIA DE FUGA 13", CATALOGO HPI-25-02, MARCA HENDRIX', 'UN');
INSERT INTO temp.rendimiento VALUES (646, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 15KVA, 15KV, 2X220V., 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (743, 'CABLE DE COBRE DESNUDO, DURO, # 4/0 AWG (107 MM2) 7 HEBRAS', 'KG');
INSERT INTO temp.rendimiento VALUES (762, 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 4 AWG (21,2 MM2), PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (763, 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS, # 1/0 AWG (53,5 MM2), PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (796, 'CAPSULA DE SOLDADURA CADWUELD DE # 90', 'UN');
INSERT INTO temp.rendimiento VALUES (840, 'COPLA GALVANIZADA 1" PARA CAÑERIA', 'UN');
INSERT INTO temp.rendimiento VALUES (844, 'COPLA GALVANIZADA 2" PARA CAÑERIA', 'UN');
INSERT INTO temp.rendimiento VALUES (914, 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA, 50X50X2 MM, PARA CAÑERIA DE 3/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (915, 'GOLILLA PLANA DE FIERRO GALVANIZADO CUADRADA, 60X2MM PARA CAÑERIA DE 1 1/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (1020, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X1 1/2"X1" DE HILO CON TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (1022, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X2"X11/2" DE HILO CON TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (1028, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X13"X3" DE HILO CON TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (1145, 'TUBO CONDUIT 63 MM X 6 MT PVC ALTA DENSIDAD CLASE II TIPO ANGER (NARANJA)', 'M');
INSERT INTO temp.rendimiento VALUES (1146, 'TUBO CONDUIT 90MM X 6 MT PVC ALTA DENSIDAD CLASE II TIPO ANGER (NARANJA)', 'M');
INSERT INTO temp.rendimiento VALUES (1147, 'TUBO CONDUIT 110 MM X 6 MT PVC ALTA DENCIDAD CLASE II TIPO ANGER (NARANJO)', 'M');
INSERT INTO temp.rendimiento VALUES (1149, 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA PERNO DE 3/4" HILO GRUESO BSW', 'UN');
INSERT INTO temp.rendimiento VALUES (1240, 'POSTE DE PINO IMPREGNADO EN SALES 8.00 MTS CLASE V', 'UN');
INSERT INTO temp.rendimiento VALUES (1241, 'POSTE DE PINO IMPREGNADO EN SALES 9.00 MTS CLASE V', 'UN');
INSERT INTO temp.rendimiento VALUES (1242, 'POSTE DE PINO IMPREGNADO EN SALES 10.00 MTS CLASE V', 'UN');
INSERT INTO temp.rendimiento VALUES (1244, 'POSTE DE CONCRETO ARMADO TIPO MOZO DE 6,8 M, C/PLACA DE IDENTIFICACION', 'UN');
INSERT INTO temp.rendimiento VALUES (1248, 'POSTE DE CONCRETO ARMADO DE 9 MTS, C/PLACA DE IDENTIFICACION', 'UN');
INSERT INTO temp.rendimiento VALUES (1250, 'POSTE DE CONCRETO ARMADO DE 10 MTS, C/PLACA DE IDENTIFICACION', 'UN');
INSERT INTO temp.rendimiento VALUES (1252, 'POSTE DE CONCRETO ARMADO DE 11,5 MTS, C/PLACA DE IDENTIFICACION', 'UN');
INSERT INTO temp.rendimiento VALUES (1433, 'SECCIONADOR CUCHILLO S&C, XS, 14,4/25KV, 300A, EXTERIOR, 1F', 'UN');
INSERT INTO temp.rendimiento VALUES (20559, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL GRADO 2 DE 5/8"X2 1/2"X2" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (1463, 'SECCIONADOR FUSIBLE TIPO XS, 14,4/25 KV, 100A, 8000A, RUPTURA, EXTERIOR, MONOPOLAR, CATALOGO 89022R10-CD, MARCA S&C', 'UN');
INSERT INTO temp.rendimiento VALUES (1765, 'FAROL HORNAMENTAL STELLA', 'UN');
INSERT INTO temp.rendimiento VALUES (1900, 'LUMINARIA LED 50W MASON GOLD CLEVER', 'UN');
INSERT INTO temp.rendimiento VALUES (2121, 'LUMINARIA LED 90W MASON GOLD CLEVER BF BLANCO IP66 IK 08, CREE IP 66, CUERPO DE ALUMINIO INYECTADO CONEXIONADO LED INDEPENDIENTE', 'UN');
INSERT INTO temp.rendimiento VALUES (2222, 'TUERCA HEXAGONAL DE FIERRO GALVANIZADO PARA CAÑERIA DE 1"', 'UN');
INSERT INTO temp.rendimiento VALUES (2483, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X 14"X 3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (2677, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 80A, TAMAÑO 1, MARCA ELETROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (635, 'AISL POLIMERICO SILICONA SUSP 28KV', 'UN');
INSERT INTO temp.rendimiento VALUES (2678, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 100A, TAMAÑO 1, MARCA ELETROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (2679, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 125A, TAMAÑO 1, MARCA ELETROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (2680, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 160A, TAMAÑO 1, MARCA ELETROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (2681, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 200A, TAMAÑO 1, MARCA ELETROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (2682, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 250A, TAMAÑO 2, MARCA ELETROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (2683, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 400A, TAMAÑO 2, MARCA ELETROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (2778, 'CONECTOR DE COMPRESIÓN RECTO 3M, CATEGORIA 10003, PARA CABLE STANDARD 2 AWG O COMPACTO 1 AWG', 'UN');
INSERT INTO temp.rendimiento VALUES (3144, 'MUFA TERMINAL 3M TIPO QTM, EXTERIOR 15KV P3/CABLES MONOPOLAR 2 -3/0 AWG AISLACIÓN XLPE', 'JGO');
INSERT INTO temp.rendimiento VALUES (3414, 'TEST BLOCK (REGLETA) PARA MEDIDORES INDIRECTOS DE 3 ELEMENTOS, LANDIS&GIR TVS14', 'UN');
INSERT INTO temp.rendimiento VALUES (3460, 'FN BARRA DE FIERRO ANGULO RANURADO DE 38X38X2X530 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (3509, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 10KVA, 23KV, 1X231V., TAPS 24150/23000/21850/20700/19550', 'UN');
INSERT INTO temp.rendimiento VALUES (3510, 'FN USAR COD. 38432, TRANSFORMADOR DE DISTRIBUCIÓN 2F AEREO, 15KVA, 23KV, 1X231V., TAPS 24150/23000/21850/20700/19550', 'UN');
INSERT INTO temp.rendimiento VALUES (3521, 'FN USAR COD. 38497, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 75KVA, 23KV, 400-231V, TAPS 24150/23000/21850/20700/19550', 'UN');
INSERT INTO temp.rendimiento VALUES (3647, 'PARARRAYOS EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3665, 'BRONCE DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3671, 'CABLE DE ACERO PARA TIRANTE EN MAL ESTADO', 'KG');
INSERT INTO temp.rendimiento VALUES (3676, 'CONDUCTOR DE COBRE DESNUDO DISPONIBLE PARA ENAJENACION (SOLO CABLES Y ALAMBRES)', 'KG');
INSERT INTO temp.rendimiento VALUES (3677, 'CONDUCTOR DE COBRE AISLADO DISPONIBLE PARA ENAJENACION (SOLO CABLES Y ALAMBRES)', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'ELEMENTOS Y PIEZAS DE FIERRO DIPONIBLES PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3959, 'MUERTO DE CONCRETO CONICO DE 35 KG, PARA TRACCION MAX. 1500 KG PARA BT', 'UN');
INSERT INTO temp.rendimiento VALUES (4013, 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO 3F MITSUBISHI, 600V, 3X300A., 35KA RUPTURA, NF-400-CW, CAT. 210257', 'UN');
INSERT INTO temp.rendimiento VALUES (4014, 'INTERRUPTORES AUTOMATICOS TERMOMAGNETICOS EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (4417, 'ELEMENTO FUSIBLE CURVA GL 63A TIPO NH TAMAÑO 00, PARA SECCIONADOR O BASE PORTAFUSIBLE BT, MARCA ELECTROMEC.', 'UN');
INSERT INTO temp.rendimiento VALUES (4525, 'ELEMENTO FUSIBLE CURVA GL 630A TIPO NH TAMANO 3, PARA SECCIONADOR O BASE PORTA FUSIBLE B.T.', 'UN');
INSERT INTO temp.rendimiento VALUES (4586, 'CONDULET (CABEZA DE SERVICIO) PARA CAÑERIA 2" CON SALIDAS PARA 7 CONDUCTORES', 'UN');
INSERT INTO temp.rendimiento VALUES (5154, 'BRAZO DE MONTAJE 3M TIPO MB-3, PARA CABLE SUBTERRANEO MONOPOLAR ENTRE 20 Y 32 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADORES Y SUS ACCESORIOS EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (5273, 'SECCIONADOR FUSIBLE EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (5282, 'POSTE DE CONCRETO EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (5285, 'POSTE DE FIERRO GALVANIZADO COMPAC CURVO DE 8.20 MT C/BRAZO DOBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (5381, 'TUBO CONDUIT RIGIDO DE 32 MM2 X 6 MTS CLASE III, NARANJA', 'M');
INSERT INTO temp.rendimiento VALUES (5404, 'PERNO DE FIERRO ZINCADO CABEZA REDONDA DE 5/32" X 1/2" CON TUERCA HEXAGONAL 5/32"', 'UN');
INSERT INTO temp.rendimiento VALUES (5521, 'SECCIONADOR CUCHILLO EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (5577, 'AISLADOR ESPIGA DE PORCELANA 7 1/2" DE 13" DE FUGA, ROSCA 1 3/8", CLASE ANSI 56-1, COLOR GRIS, 1031, PLANO CGE. M-5920-N, MARCA SANTANA', 'UN');
INSERT INTO temp.rendimiento VALUES (5597, 'CONDULET (CABEZA DE SERVICIO) PARA CAÑERIA 4" CON SALIDAS PARA 7 CONDUCTORES', 'UN');
INSERT INTO temp.rendimiento VALUES (5755, 'CABLE DE COBRE MONOPOLAR APANTALLADO, CON AISLACION SOLIDA XLPE, # 2 AWG O 33,63 MM2, 15KV', 'M');
INSERT INTO temp.rendimiento VALUES (5756, 'CABLE DE COBRE MONOPOLAR APANTALLADO, CON AISLACION SOLIDA XLPE, # 3/0 AWG (85 MM2) 15KV', 'M');
INSERT INTO temp.rendimiento VALUES (5840, 'PARARRAYO CLASE DISTRIBUCIÓN, 12A 15KV, TIPO VARISTAR DE 10,2KV, CUERPO DE GOMA SILICONADA, INC. ESTRUCTURA SOPORTE DE MONTAGE, COOPER POWER', 'UN');
INSERT INTO temp.rendimiento VALUES (5931, 'CAPSULA DE SOLDADURA CADWELD N° 115', 'UN');
INSERT INTO temp.rendimiento VALUES (6002, 'FLEJE DE ACERO INOXIDABLE TIPO 201 DE 1/4"', 'M');
INSERT INTO temp.rendimiento VALUES (6003, 'FLEJE DE ACERO INOXIDABLE TIPO 201 DE 5/8"', 'M');
INSERT INTO temp.rendimiento VALUES (6004, 'HEBILLA DE ACERO INOXIDABLE TIPO 201 DE 1/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (6005, 'HEBILLA DE ACERO INOXIDABLE TIPO 201 DE 5/8"', 'UN');
INSERT INTO temp.rendimiento VALUES (6031, 'HUINCHA DE CONEXIÓN A TIERRA 3M SCOTCH 25 DE 1/2"x 4,6 MTS Y 2,4 MM ESPESOR, 6AWG EQ', 'ROL');
INSERT INTO temp.rendimiento VALUES (6038, 'CONECTOR DE COMPRESIÓN TERMINAL RECTO 3M, CATEGORIA 30021, BORNE 1000, PARA CABLE STD 4 AWG O COMP. 2 AWG, PERFORACION 3/8"', 'UN');
INSERT INTO temp.rendimiento VALUES (6076, 'MUFA EMPALME RECTO RAYCHEM B.T. PARA CABLES 6-2 AWG C/DERIVACION 14-2 AWG, CRSM-CT34/10-150', 'UN');
INSERT INTO temp.rendimiento VALUES (6077, 'MUFA EMPALME RECTO RAYCHEM B.T. PARA CABLES 2-4/0 AWG C/DERIVACION 10-4/0 AWG, CRSM-CT53/13/200', 'UN');
INSERT INTO temp.rendimiento VALUES (6083, 'MUFA TERMINAL EXTERIOR RAYCHEM 15KV C/3 PUNTAS PARA CABLE MONOPOLAR AISLACION SOLIDA 4-3/0 AWG, HVT-151-S-GP-CL', 'KIT');
INSERT INTO temp.rendimiento VALUES (6085, 'MUFA DE UNION RECTA RAYCHEM 15KV PARA CABLE MONOPOLAR AISLACION SOLIDA, 2-4/0 AWG HVS-1521S', 'KIT');
INSERT INTO temp.rendimiento VALUES (6107, 'MUERTO DE CONCRETO SIN ARMADURA DE 75 KG PARA AT, PARA TRACCION MAX. 2500 KG', 'UN');
INSERT INTO temp.rendimiento VALUES (6119, 'BARRA TOMA TIERRA COPPERWELD DE 5/8" X 1,5 MTS, 400 MICRONES', 'UN');
INSERT INTO temp.rendimiento VALUES (6134, 'ABRAZADERA DE PLASTICO TIPO HEBILLA 140/160X3,6 MM, INTEMPERIE COLOR NEGRO', 'UN');
INSERT INTO temp.rendimiento VALUES (6135, 'BASE DE SUJECION ATORNILLADA, PARA ABRAZADERA DE PLASTICO TIPO HEBILLA, INTEMPERIE', 'UN');
INSERT INTO temp.rendimiento VALUES (6234, 'ALAMBRE DE COBRE AISLADO, TIPO THHN, # 14 AWG (2,08 MM2), PARA A.P. COLOR NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (6242, 'CONECTOR DE COMPRESIÓN TERMINAL RECTO 3M, CATEGORIA 30016, PARA CABLE 6 AWG, PERFORACION 5/16"', 'UN');
INSERT INTO temp.rendimiento VALUES (6334, 'CABLE DE ACERO GALVANIZADO DE 3/8" PARA TIRANTE Y MENSAJERO, TIPO EXTRA ALTA RESISTENCIA, KDURA, NORMA ASTM A-475', 'M');
INSERT INTO temp.rendimiento VALUES (6428, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 315A, TAMAÑO 2, MARCA ELETROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (6561, 'LAMPARA VAPOR DE NA ALTA PRESION DE 70 W, ROSCA E-27, 90 V ARCO, 5900 LUMENES, SON/E SIN IGNITOR', 'UN');
INSERT INTO temp.rendimiento VALUES (6644, 'SELLO TERMOCONTRACTIL RAYCHEM, BAJADA 3 CABLES MONOPOLAR AT HASTA 500 MCM, EN DUCTO 3", MODELO 402-W-439', 'UN');
INSERT INTO temp.rendimiento VALUES (6831, 'ALAMBRE DE COBRE DESNUDO, DURO, # 6 AWG (13,3 MM2)', 'KG');
INSERT INTO temp.rendimiento VALUES (6897, 'HUINCHA AISLADORA 3M, 3/4" X 20 MTS X 0,18 MM ESPESOR, SCOTCH SUPER 33+, CAT: 80-6112-0701-2, COLOR NEGRO', 'ROL');
INSERT INTO temp.rendimiento VALUES (6903, 'CABLE DE CONTROL, TIPO CTT O TCC, 7 X # 12 AWG (7 X 3,31 MM2), ESP.29 B-613 (Colores: Rojo-Blanco-Verde-Negro-Azul-Naranja-Gris)', 'M');
INSERT INTO temp.rendimiento VALUES (6910, 'BOQUILLA PARA DUCTO DE PVC DENSO DE 32 MM PARA ENTRADA A CAMARA', 'UN');
INSERT INTO temp.rendimiento VALUES (6912, 'BOQUILLA PARA DUCTO DE PVC DENSO DE 110 MM, PARA ENTRADA A CAMARAS, NARANJA', 'UN');
INSERT INTO temp.rendimiento VALUES (6920, 'CRUCETA DE FIERRO GALVANIZADO L 80X80X8X2000 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (6944, 'ELEMENTO FUSIBLE CURVA GL 16A TIPO NH TAMAÑO 00, PARA SECCIONADOR O BASE PORTA FUSIBLE B.T. MARCA ELECTROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (7147, 'DUCTOS DE PLASTICO INUTILIZABLES (DIFERENTES MEDIDAS) EN MAL ESTADO', 'M');
INSERT INTO temp.rendimiento VALUES (7206, 'ESLABON ANGULAR ESTAMPADO GALVANIZADO PARA PERFORADA PARA PERNO 3/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (7231, 'FN CRUCETA DE FIERRO ANGULO GALVANIZADO DE 100X100X10X2200 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (7475, 'PARARRAYO CLASE DISTRIBUCIÓN, 23KV, TIPO VARISTAR 19,5 KV, CUERPO DE GOMA SILICONADA, INCLUYE ESTR. SOPORTE DE MONTAGE, MARCA COOPER POWER', 'UN');
INSERT INTO temp.rendimiento VALUES (7564, 'SOPORTE DE PASADA LARGO PARA UNA VIA, LARGO TOTAL 374 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (7565, 'SOPORTE DE PASADA CORTO PARA UNA VIA, LARGO TOTAL 317 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (7567, 'SOPORTE DE PASADA CORTO PARA INSTALACION DE LUMINARIAS, LARGO TOTAL 437 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (7615, 'ESPIGA GALVANIZADA 3/4"X150MM UTILES, 295MM TOTALES, CAPSULA 1", PARA CRUCETA DE HORMIGON', 'UN');
INSERT INTO temp.rendimiento VALUES (7616, 'ESPIGA GALVANIZADA 3/4"X150MM UTILES, 210MM TOTALES, CAPSULA 1", PARA CRUCETA METALICA', 'UN');
INSERT INTO temp.rendimiento VALUES (7617, 'ESPIGA GALVANIZADA 3/4"X150MM UTILES, 295MM TOTALES, CAPSULA 1 3/8", PARA CRUCETA DE HORMIGON', 'UN');
INSERT INTO temp.rendimiento VALUES (7618, 'ESPIGA GALVANIZADA 3/4"X150MM UTILES, 210MM TOTALES, CAPSULA 1 3/8", PARA CRUCETA METALICA', 'UN');
INSERT INTO temp.rendimiento VALUES (7641, 'HILO FUSIBLE 15A CURVA T PARASEC.FUS. A.T. EXTERIOR CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (7700, 'PERNO DE FIERRO ZINCADO CABEZA REDONDA DE 3/16" x 1/4" CON TUERCA  DE 3/16"', 'UN');
INSERT INTO temp.rendimiento VALUES (7948, 'TUBO FLEXIBLE DE ACERO GALVANIZADO REVESTIDO CON PVC COLOR GRIS 1" USO INTEMPERIE', 'M');
INSERT INTO temp.rendimiento VALUES (7990, 'CONTROLADOR FOTOELECTRICO PARA USO EN A. P., S/BASE MONTAJE, 220V, 1800VA, 1000 W', 'UN');
INSERT INTO temp.rendimiento VALUES (7991, 'BASE DE MONTAJE DE CONTROL FOTOELECTRICO PARA USO EN A.P., C/BRAZO DE SUJECION', 'UN');
INSERT INTO temp.rendimiento VALUES (8448, 'CAÑERIA GALVANIZADA TIPO ISO R II LIVIANA 3" X 6 METROS CON HILO SIN COPLA', 'M');
INSERT INTO temp.rendimiento VALUES (8505, 'PRENSA PARALELA DE BRONCE PARA CONDUCTOR 3-4/0 AWG CON CUERPO DE BRONCE SAE 40, DOS PERNOS DE COBRE DE 3/8" X 2 1/2" Y 4 TUERCAS DE BRONCE', 'UN');
INSERT INTO temp.rendimiento VALUES (8854, 'CAÑERIA GALVANIZADA TIPO ISO 1 1/4", CON HILO SIN COPLA', 'M');
INSERT INTO temp.rendimiento VALUES (9020, 'CONTACTOR DE MERCURIO MONOPOLAR, 30 -35 A, BOBINA DE 220V, PARA USO EN ALUMBRADO PUBLICO, CATALOGO MDI 35NO-220AH, MARCA MDIPARAUSO EN A.P.', 'UN');
INSERT INTO temp.rendimiento VALUES (9048, 'PLETINA DE FIJACION DE 140X3X30 MM PARA CAJA METALICA PARA MEDIDOR 1F', 'UN');
INSERT INTO temp.rendimiento VALUES (9063, 'POSTE DE HORMIGON ARMADO 13,5 MTS CON DUCTO BAJADA PUESTA A TIERRA, 700 KG CAPACIDAD DE RUPTURA', 'UN');
INSERT INTO temp.rendimiento VALUES (9298, 'CABLE DE ALEACION DE ALUMINIO AAAC DESNUDO 2AWG (33,63MM2), 7 HEBRAS DE 2,47 MM POR HEBRA, PESO LINIAL 92,1 KG/KM, TAMAÑO NOMINAL KCM 66,2', 'KG');
INSERT INTO temp.rendimiento VALUES (9305, 'GRAPA DE ANCLAJE DE ALUMINIO PARA CONDUCTOR AAAC Nº 4-3/0AWG, 10.000LIBRAS DE RUPTURA,  SIN CONECTOR SOCKET, CATALOGO PG-57-N, MARCA HUBBELL', 'UN');
INSERT INTO temp.rendimiento VALUES (9308, 'CAÑERIA GALVANIZADA TIPO ISO R II LIVIANA 2" X 6 METROS CON HILO SIN COPLA', 'M');
INSERT INTO temp.rendimiento VALUES (9443, 'PROTECCIÓN PREFORMADA DE ALUMINIO PARA CABLE AAAC Nº 2 AWG, SIMPRE APOYO (533 MM), COLOR MORADO, CATALOGO MG-0130, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (9444, 'PROTECCIÓN PREFORMADA DE ALUMINIO PARA CABLE AAAC Nº 2 AWG, DOBLE APOYO (838 MM), COLOR MORADO, CATALOGO MG-0313, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (9445, 'PROTECCIÓN PREFORMADA DE ALUMINIO PARA CABLE AAAC Nº 1/0 AWG, SIMPLE APOYO (584 MM), COLOR NEGRO, CATALOGO MG-0134, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (9448, 'PROTECCIÓN PREFORMADA DE ALUMINIO PARA CABLE AAAC Nº 3/0 AWG, DOBLE APOYO (991 MM), COLOR VERDE, CATALOGO MG-0321, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (9451, 'CONECTOR AMPACT, 33-53 MM2, PASO 16 MM2, DERIVACION, IMPULSOR ROJO, 600528', 'UN');
INSERT INTO temp.rendimiento VALUES (9452, 'CONECTOR AMPACT, 33-53 MM2, PASO, 25-33 MM2 DERIVACION, INPULSOR ROJO, 600529', 'UN');
INSERT INTO temp.rendimiento VALUES (9453, 'CONECTOR AMPACT, 33-85 MM2, PASO, 25-67 MM2 DERIVACION, INPULSOR AZUL, 600403', 'UN');
INSERT INTO temp.rendimiento VALUES (9455, 'CONECTOR AMPACT, 70-95 MM2, PASO, 53-70 MM2 DERIVACION, INPULSOR AZUL, 600458', 'UN');
INSERT INTO temp.rendimiento VALUES (9456, 'CONECTOR AMPACT, 85-95 MM2, PASO, 85-95 MM2 DERIVACION, INPULSOR AZUL, 600459', 'UN');
INSERT INTO temp.rendimiento VALUES (9461, 'IMPULSOR ROJO PARA INSTALAR Y DESMONTAR CONECTORES AMPACT, 69338-2', 'UN');
INSERT INTO temp.rendimiento VALUES (9462, 'IMPULSOR AZUL PARA INSTALAR CONECTORES AMPACT, 69338-1', 'UN');
INSERT INTO temp.rendimiento VALUES (9572, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 500KVA, 15KV, TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (9588, 'BOQUILLA RECTA PARA CABLE CONCENTRICO, PARA SISTEMA D.R.P.', 'UN');
INSERT INTO temp.rendimiento VALUES (9589, 'CABLE CONCENTRICO DE 4 MM2, (2,26 MM) PARA SISTEMA D.R.P. B-540', 'M');
INSERT INTO temp.rendimiento VALUES (9590, 'CABLE CONCENTRICO DE 6 MM2, (2,76 MM) PARA SISTEMA D.R.P., B-541', 'M');
INSERT INTO temp.rendimiento VALUES (9591, 'MORDAZA DE ACOMETIDA PARA ALAMBRES CONCENTRICO DE REDES, PARA SISTEMA D.R.P.', 'UN');
INSERT INTO temp.rendimiento VALUES (9769, 'SOPORTE PARA REDES DE B.T. Y EMPALMES EN SISTEMA D.R.P', 'UN');
INSERT INTO temp.rendimiento VALUES (9936, 'CAÑERIA GALVANIZADA TIPO ISO R II LIVIANA 4" X 6 MTS CON HILO SIN COPLA', 'M');
INSERT INTO temp.rendimiento VALUES (9951, 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 3X35/50MM2, FASE Y NEUTRO AISLADOS, AISLACION DE POLIETILENO RETICULADO (XLPE), CAPA PROTECTORA', 'M');
INSERT INTO temp.rendimiento VALUES (9952, 'GRAPA DE RETENCION DE ALUMINIO PARA CABLE PREENSAMBLADO, PINZA DE ANCLAJE CON NEUTRO PORTANTE AISLADO DE 54,6 MM2  DE SECCION, SIMILAR A CAVANNA', 'UN');
INSERT INTO temp.rendimiento VALUES (9954, 'TUERCA DE ACERO GALVANIZADO CON OJO PARA PERNO OJO DE 5/8", HILO GRUESO BSW', 'UN');
INSERT INTO temp.rendimiento VALUES (9956, 'GRAPA DE SUSPENSION PLASTICA PARA CABLE PREENSAMBLADO, SIMILAR A CAVANNA MODELO DSP-500', 'UN');
INSERT INTO temp.rendimiento VALUES (9957, 'CONECTOR DE EMPALME PARA CABLES PREENSAMBLADO A PERFORACION, UNA DERIVACION, RED ALUMINIO 35/95 MM2, PI-71 MARCA NILED', 'UN');
INSERT INTO temp.rendimiento VALUES (9963, 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 3X50/50MM2, FASE Y NEUTRO AISLADOS, AISLACION DE POLIETILENO RETICULADO (XLPE), CAPA PROTECTORA', 'M');
INSERT INTO temp.rendimiento VALUES (10007, 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 2X16 MM2. (NEUTRO DESNUDO),AISLACION DE POLIETILENO RETICULADO (XLPE), TENSION NOMINAL 1.100 VOLT', 'M');
INSERT INTO temp.rendimiento VALUES (10030, 'CONECTOR AMPACTINHO, UDC TIPO IV, PARA UNION 16 MM2 AL-2,08 MM2 CU, CON CUBIERTA, CATEGORIA 493458-1', 'UN');
INSERT INTO temp.rendimiento VALUES (10034, 'CONECTOR TIPO CUNA AMPACTINHO MODELO UDC TIPO I, CAT. 881781-1, (25 CON 25)', 'UN');
INSERT INTO temp.rendimiento VALUES (10035, 'CONECTOR TIPO CUNA AMPACTINHO MODELO UDC TIPO II, CAT. 8817831-1 (16 CON 16)', 'UN');
INSERT INTO temp.rendimiento VALUES (10036, 'CUBIERTA DE POLIETILENO AMPACTINHO TIPO I, PARA CONECTOR TIPO CUNA MOD. UDC TIPO I', 'UN');
INSERT INTO temp.rendimiento VALUES (10037, 'CUBIERTA DE POLIETILENO AMPACTINHO TIPO II, PARA CONECTOR TIPO CUNA MOD. UDC TIPO II, 881225-1', 'UN');
INSERT INTO temp.rendimiento VALUES (10044, 'ELEMENTO PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 63A, TAMAÑO 1, MARCA ELECTROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (10104, 'LUMINARIA 70W SODIO, C/POLICARBONATO S/BASE, C/REACT. COMPEN. E IGNITOR INT. CAT: SRS 203 PHILIPS', 'UN');
INSERT INTO temp.rendimiento VALUES (10173, 'CONECTOR DENTADO DIENTE DE COBRE ESTAÑADO A PERFORACION AISLANTE, ALUMINIO 25/120MM2 (RED), DERIVACION AL-CU 25-120MM2, SIMILAR A CAVANNA', 'UN');
INSERT INTO temp.rendimiento VALUES (10317, 'LUMINARIA 100W SODIO C/POLICARBONATO SRS-204, C/REACTANCIA COMP. E IGNITOR INTERIOR', 'UN');
INSERT INTO temp.rendimiento VALUES (10318, 'LAMPARA VAPOR DE NA ALTA PRESION DE 100W, ROSCA E-40, 100 V ARCO, TUBULAR', 'UN');
INSERT INTO temp.rendimiento VALUES (10493, 'CAJA METALICA PARA MEDIDOR 3F ELECTRPNICO ACTIVO - REACTIVO, DIRECTO', 'UN');
INSERT INTO temp.rendimiento VALUES (10494, 'CAJA METALICA PARA MEDIDOR 3F ELECTRONICO ACTIVO - REACTIVO, INDIRECTO', 'UN');
INSERT INTO temp.rendimiento VALUES (10504, 'PLACA DE IDENTIFICACION DE POSTES', 'UN');
INSERT INTO temp.rendimiento VALUES (10529, 'AMARRA DE PASADA PREFORMADA PLASTICA PARA CABLE PROTEGIDO 70/185MM, CATALOGO TTF-1202, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (10530, 'RETENCION PREFORMADA PARA CABLE PROTEGIDO DE 95MM, CATALOGO ND-0117, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (10531, 'AMARRA DE PASADA CON ANGULO PREFORMADA PLASTICA PARA CABLE PROTEGIDO 95MM, CATALOGO SSF-2253, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (10563, 'FUSIBLE PARA SECCIONADOR O BASE PORTAFUSIBLE BT, TIPO NH, CURVA GL 500A,TAMAÑO 3, MARCA ELETROMEC.', 'UN');
INSERT INTO temp.rendimiento VALUES (10589, 'SECCIONADOR CUCHILLO S&C, 25 KV, 900A. TIPO OVERHEAD POLE-TOP LOADBUSTER, 150KV BIL, CAT. 18933-AB, CON CONECTOR DE ALUMINIO', 'UN');
INSERT INTO temp.rendimiento VALUES (10752, 'SOPORTE GALVANIZADO PARA 3 SECCIONADORES EXTERIORES FUSIBLES NH APR 630', 'UN');
INSERT INTO temp.rendimiento VALUES (10756, 'SECCIONADOR FUSIBLE UNIPOLAR, EXTERIOR, CAPACIDAD HASTA 630A, 500V, PARA FUSIBLES NH TAMAÑO 1, 2 Y 3, SIMILAR A CAVANNA MODELO APR630 HASTA 95MM', 'UN');
INSERT INTO temp.rendimiento VALUES (13347, 'CONECTOR DENTADO CON PORTAFUSIBLE INCORPORADO, AISLADO, PARA CABLE PREENSAMBLADO, SIMILAR A CAVANNA MODELO DCPA-EE', 'UN');
INSERT INTO temp.rendimiento VALUES (13353, 'CAJA PARA DISTRIBUCIÓN DE EMPALMES, FABRICADA EN POLICARBONATO COLOR NEGRO Y TAPA DEL MISMO MATERIAL', 'UN');
INSERT INTO temp.rendimiento VALUES (13370, 'RETENCIÓN PREFORMADA PARA CABLE PROTEGIDO DE 185 MM2, LARGO MÍNIMO 1143MM, DIÁMETRO 26,25MM. MM 25,55 A 27,18, ND-0120, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (13379, 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 2X16 MM2, PARA ACOMETIDAS, FASE Y NEUTRO AISLADOS, AISLACION DE POLIETILENO RETICULADO (XLPE)', 'M');
INSERT INTO temp.rendimiento VALUES (13432, 'FUSIBLE 50 A NEOZED,  PARA CONECTOR DENTADO USO REDES PREENSAMBLADAS, SIMILAR A CAVANNA MODELO INF 50', 'UN');
INSERT INTO temp.rendimiento VALUES (13548, 'ELEMENTO FUSIBLE EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (13559, 'CABLE DE COBRE AISLADO THHN, N° 10 AWG/5,26MM2, COLOR NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13561, 'CABLE DE COBRE AISLADO THHN, Nº 6 AWG/13,3MM2 NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13562, 'CABLE DE COBRE AISLADO THHN, Nº 4 AWG/21,2MM2, NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13563, 'CABLE DE COBRE AISLADO THHN, Nº 2 AWG/33,63MM2, NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13564, 'CABLE DE COBRE AISLADO THHN, Nº 1 AWG/42MM2 NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13576, 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS # 8 AWG (8,37 MM2), PARA B.T. COLOR NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13579, 'CABLE DE COBRE AISLADO THHN 4/0 AWG/107MM2 NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13584, 'CABLE DE ALUMINIO PURO 1350, PROTEGIDO, SECCION 1X50 MM2, PARA LINEAS AEREAS 25 KV, AISLACION XLPE', 'M');
INSERT INTO temp.rendimiento VALUES (13592, 'UNIÓN DE COMPRESIÓN PARA ALAMBRE, # 6 AWG, TIPO NICOPRESS', 'UN');
INSERT INTO temp.rendimiento VALUES (13595, 'UNIÓN DE COMPRESIÓN PARA ALAMBRE, # 5 AWG, TIPO NICOPRESS', 'UN');
INSERT INTO temp.rendimiento VALUES (13613, 'ELEMENTO FUSIBLE CURVA GL 25A TIPO NH TAMAÑO 1, PARA SECCIONADOR O BASE PORTA FUSBLE B.T.', 'UN');
INSERT INTO temp.rendimiento VALUES (13614, 'FUSIBLE PARA SECCIONADOR O BASE PORTA FUSIBLE BT, TIPO NH, CURVA GL 40A, TAMAÑO 1, MARCA ELECTROMEC', 'UN');
INSERT INTO temp.rendimiento VALUES (13639, 'CRUCETA DE FIERRO GALVANIZADO 80X80X8X2400 MM, NORMA CGE, PL M2360-N', 'UN');
INSERT INTO temp.rendimiento VALUES (13661, 'GOLILLA DE FIERRO GALVANIZADA CUADRADA DE 100X100X5 MM PARA PERNO DE 3/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (13696, 'FN USAR COD. 40761, CABLE DE ALEACION DE ALUMINIO AAAC 4/0 (107MM2) 7 HEBRAS 296KG/KM', 'KG');
INSERT INTO temp.rendimiento VALUES (13738, 'CRUCETA DE HORMIGON EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (13758, 'FN USAR COD. 6920, CRUCETA DE FIERRO GALVANIZADO 80X80X8 MM L = 1.8M', 'UN');
INSERT INTO temp.rendimiento VALUES (13764, 'ESPIGA GALVANIZADA CANAL PUNTA DE POSTE 506X125X350 CAPSULA 1 3/8"', 'UN');
INSERT INTO temp.rendimiento VALUES (13768, 'FN USAR COD. 6003, PERNO "J" DE FIERRO GALVANIZADO DE 1/2" X 5 1/2" CON PLETINA PARA CAÑERIA 1/2"', 'UN');
INSERT INTO temp.rendimiento VALUES (13778, 'GRILLETE DE ACERO GALVANIZADO DE ANCLAJE RECTO, 14 MM, PARA PERNO DE 3/4""', 'UN');
INSERT INTO temp.rendimiento VALUES (13780, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X8"X3" DE HILO CON TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (13783, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X10"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (13789, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 5/8"X17"X14" DE HILO CON 3 TUERCAS', 'UN');
INSERT INTO temp.rendimiento VALUES (13804, 'SEPARADOR PARA SOPORTE 5 VÍAS TIPO C', 'UN');
INSERT INTO temp.rendimiento VALUES (13805, 'SOPORTE ACERO GALVANIZADO PORTANTE DE LINEAS 5 VIAS( O DE PASO )', 'UN');
INSERT INTO temp.rendimiento VALUES (13847, 'RETENCION PREFORMADA DE ALUMNIO PARA CABLE PROTEGIDO DE 50 y 70mm2, CATALOGO ND-0115, MARCA PLP., D=18,25MM', 'UN');
INSERT INTO temp.rendimiento VALUES (13885, 'CABLE DE COBRE AISLADO, TIPO THHN, Nº 12 AWG/3,31MM2, PARA B.T., NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13897, 'CABLE DE COBRE AISLADO, TIPO THHN, 2/0 AWG, NEGRO', 'M');
INSERT INTO temp.rendimiento VALUES (13932, 'PLACA DE IDENTIFICACION DE SUBESTACIONES EN TERRENO (VERTICAL), PLANO 9689-A3', 'UN');
INSERT INTO temp.rendimiento VALUES (13960, 'ESPACIADOR POLIMERICO PARA 3 CONDUCTORES EN DISPOSICION TRIANGULAR, PARA REDES COMPACTAS 25KV, MEDIANTE PRENSAS INTEGRALES, MARCA HENDRIX', 'UN');
INSERT INTO temp.rendimiento VALUES (13961, 'BRAZO ANTIBALANCE 25 KV, HENDRIX, CAT. BAS 24F', 'UN');
INSERT INTO temp.rendimiento VALUES (13962, 'RADIO MODEM UHF, MODELO 4710-A/DIAG, PARA FRECUENCIA DE 330-512 MHZ, SISTEMA SCADA, AJUSTADO PARA RANGO DE FRCUENCIA 450-480 MHZ, CON OPCION', 'UN');
INSERT INTO temp.rendimiento VALUES (14366, 'ESPIGA DE ACERO GALVANIZADO DE 3/4" X 250 MM PARA CAPSULA POLIAMIDA DE 13/8" PARA CRUCETA METALICA', 'UN');
INSERT INTO temp.rendimiento VALUES (14378, 'CABLE DE COBRE DESNUDO, DURO, 25 MM2, 7 HEBRAS', 'KG');
INSERT INTO temp.rendimiento VALUES (14460, 'SOPORTE DE PASO GALVANIZADO PARA REDES COMPACTAS EN 23KV', 'UN');
INSERT INTO temp.rendimiento VALUES (14504, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 23KV,  250KVA TAPS 24150/23000/21850/20700/19550', 'UN');
INSERT INTO temp.rendimiento VALUES (14633, 'CABLE DE COBRE AISLADO, TIPO XT, XTU Ó XCS # 10 AWG (5,26 MM2), PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (14648, 'LAMPARA VAPOR DE NA ALTA PRESION 100W, ROSCA E-40, 100V ARCO, PLUS O SUPER, 10.500 LUMENES', 'UN');
INSERT INTO temp.rendimiento VALUES (14664, 'INTERRUPTOR DIFERENCIAL BIPOLAR 2X25A 30MA BVWT-2P-25A-30 RIEL DIN', 'UN');
INSERT INTO temp.rendimiento VALUES (14691, 'TRANSFORMADOR DE MEDIDA COMPACTO 1F 15KV 15400-220 V, 0,5-1/5A', 'UN');
INSERT INTO temp.rendimiento VALUES (14732, 'CONECTOR AMPACT, 150 MM2 PASO, 70-85 MM2, DERIVACION, 602046-6, INPULSOR AZUL', 'UN');
INSERT INTO temp.rendimiento VALUES (14733, 'CONECTOR AMPACT, 150 MM2 PASO, 95 MM2 DERIVACION, 602046-7, INPULSOR AZUL', 'UN');
INSERT INTO temp.rendimiento VALUES (14734, 'CONECTOR AMPACT, 185 MM2 PASO, 185 MM2 DERIVACION, INPULSOR AZUL, 602046-9', 'UN');
INSERT INTO temp.rendimiento VALUES (14735, 'CUBIERTA DE PROTECCIÓN PARA CONECTOR AMPACT, 15KV PARA N 444423-1', 'UN');
INSERT INTO temp.rendimiento VALUES (14741, 'PERNO DE FIERRO GALVANIZADO CON OJO DE 5/8"X7"X3" DE HILO C/TUERCA , GOLILLA PLANA Y DE PRESION', 'UN');
INSERT INTO temp.rendimiento VALUES (14742, 'PERNO DE FIERRO GALVANIZADO CON OJO DE 5/8"X9"X3" DE HILO C/TUERCA , GOLILLA PLANA Y DE PRESION', 'UN');
INSERT INTO temp.rendimiento VALUES (14743, 'PERNO DE FIERRO GALVANIZADO CON OJO DE 5/8"X15"X12" DE HILO C/TUERCA , GOLILLA PLANA Y DE PRESION', 'UN');
INSERT INTO temp.rendimiento VALUES (14851, 'CABLE DE ALEACION DE ALUMINIO PREENSAMBLADO 2X25 MM2 (NEUTRO DESNUDO),AISLACION DE POLIETILENO RETICULADO (XLPE), TENSION NOMINAL 1.100 VOLT', 'M');
INSERT INTO temp.rendimiento VALUES (14904, 'BARRA CON OJO GUARDACABO DOBLE DE 5/8"X2000 MM C/GOLILLA DE 50X50X5 Y TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (14905, 'ESLABON ANGULAR ESTAMPADO GALVANIZADO PARA PERNO DE 5/8" CON GUARDACABO INCLUIDO', 'UN');
INSERT INTO temp.rendimiento VALUES (14914, 'CONECTOR A PERFORACION PARA RED PREENSAMBLADA 35-95 MM2 C/RED DESNUDA AL/CU 7-95 MM2 CATEGORIA NTD301EF, MARCA SICAME', 'UN');
INSERT INTO temp.rendimiento VALUES (14922, 'CAJA EN POLICARBONATO DE DISTRIBUCIÓN DE EMPALMES PARA SIST. DRP, EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (15173, 'LAMPARA  VAPOR DE NA ALTA PRESION 150W, ROSCA E-40, 100V ARCO, PLUS O SUPER, 17.500 LUMENES', 'UN');
INSERT INTO temp.rendimiento VALUES (15185, 'CONECTOR ESTRIBO PUESTA TIERRA AMPAC, PARA CABLE 50 MM2, CON CUBIERTA 444752-3', 'UN');
INSERT INTO temp.rendimiento VALUES (15186, 'CONECTOR ESTRIBO PUESTA TIERRA AMPAC CABLE 70 Y 90 MM2 CON CUBIERTA', 'UN');
INSERT INTO temp.rendimiento VALUES (15187, 'CONECTOR ESTRIBO PUESTA TIERRA AMPAC CABLE 150 MM2 CON CUBIERTA', 'UN');
INSERT INTO temp.rendimiento VALUES (15655, 'TRANSFORMADOR DE MEDIDA COMPACTO 3F 15KV, 8400-224 V, 5-10-20/5A.', 'UN');
INSERT INTO temp.rendimiento VALUES (15886, 'SEPARADOR MONTAJE PARA DESCONECTADOR FUSIBLE 1F', 'UN');
INSERT INTO temp.rendimiento VALUES (15900, 'HILO FUSIBLE 3A CURVA T PARA SEC.FUS. A.T. EXTERIOR CABEZA REMOVIBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (15920, 'AMARRA DE ALUMINIO PARA CONDUCTOR 2 AWG, CUELLO F, MODELO UTF 1203, MARCA PLP', 'UN');
INSERT INTO temp.rendimiento VALUES (16036, 'FIJACION GALVANIZADA TIPO T C/ABRAZADERA PARA CAÑERIA DE 4"', 'UN');
INSERT INTO temp.rendimiento VALUES (16041, 'PERNO DE FIERRO GALVANIZADO CABEZA HEXAGONAL DE 1/2"X11"X3" DE HILO C/TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (16052, 'ALAMBRE DE COBRE AISLADO H07V-U, TIPO NYA, 4 MM2, ROJO', 'M');
INSERT INTO temp.rendimiento VALUES (16380, 'CONECTOR AL-CU, DE ALUMNIO Y ACERO GALVANIZADO, PARA ALUMINIO 50-240 mm2 Y DE COBRE 10-95 mm2, CATÁLOGO Nº SM 4.21, MARCA ENSTO SEKKO', 'UN');
INSERT INTO temp.rendimiento VALUES (16382, 'CONECTOR AL-CU, DE ALUMNIO Y ACERO GALVANIZADO, PARA ALUMINIO 16-120 mm2 Y DE COBRE 6-35 mm2, CATÁLOGO Nº SM 2.25, MARCA ENSTO SEKKO OY.', 'UN');
INSERT INTO temp.rendimiento VALUES (16447, 'CONECTOR DE EMPALME Y CONEXION PARA CABLE DE COBRE 10-95 MM2, MARCA GPH, PETRI, CATALOGO 01095/2KU', 'UN');
INSERT INTO temp.rendimiento VALUES (16448, 'CONECTOR DE EMPALME Y CONEXION PARA CABLE DE COBRE 2,5-25 MM2, MARCA GPH, PETRI, CATALOGO 0425/2 KU6', 'UN');
INSERT INTO temp.rendimiento VALUES (16456, 'CAPUCHON TERMOCONTRAIBLE 1000V RAYCHEM PARA CABLE PREENSAMBLADO 380 -760 MM, 27/50MM, CAT. ESC-4/A', 'UN');
INSERT INTO temp.rendimiento VALUES (16468, 'CONECTOR AL - AL ,DE ALUMNIO Y ALUMINIO, PARA CONDUCTORES DE ALUMNIO 16-120 MM2, CATÁLOGO Nº SL 4.25, MARCA ENSTO SEKKO OY.', 'UN');
INSERT INTO temp.rendimiento VALUES (16513, 'DIAGONAL DE FIERRO GALVANIZADO 0.80 M', 'UN');
INSERT INTO temp.rendimiento VALUES (16536, 'HUINCHA PLASTICA NEGRA 3M SUPER 33 + Nº 06133', 'ROL');
INSERT INTO temp.rendimiento VALUES (16958, 'TUERCA CONTRATUERCA GALVANIZADA 2"', 'UN');
INSERT INTO temp.rendimiento VALUES (17168, 'FN USAR COD. 6003, PERNO J FIERRO GALVANIZADO DE 1/2" x 5 1/2"  S/PLETINA PARA CAÑERIA DE 1/2" CON TUERCA, GOLILLAS PRESION Y PLANA', 'UN');
INSERT INTO temp.rendimiento VALUES (17285, 'GRILLETE GALVANIZADO C/GUARDACABO, PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (17320, 'CINTA SCOTCH 130-C SIN LINER, 3M NEGRA, 3/4"x 9,2 MTS', 'ROL');
INSERT INTO temp.rendimiento VALUES (17594, 'GRAMPA ANCLAJE DE ACERO PARA CONDUCTOR DE COBRE 6 a 2 AWG (13-35 MM2)', 'UN');
INSERT INTO temp.rendimiento VALUES (17633, 'PERNO J FIJACION ACERO GALVANIZADO 1/2"x9" C/PLETINA CAÑERIA 1/2"', 'UN');
INSERT INTO temp.rendimiento VALUES (17656, 'CABLE DE COBRE AISLADO, TIPO XTU, # 1AWG, PARA B.T./35MM2', 'M');
INSERT INTO temp.rendimiento VALUES (17679, 'TABLERO MODULAR 6041 6 CIRCUITO TAPA METALICA', 'UN');
INSERT INTO temp.rendimiento VALUES (17754, 'CAMARA CON TAPA DE CONCRETO Ø 300X400 MM TRANSITO LIVIANO', 'UN');
INSERT INTO temp.rendimiento VALUES (17761, 'CONECTOR MUELA DE BRONCE PARA CONDUCTOR DE COBRE 35 A 70 MM2 CON PERNOSY GOLILLAS DE BRONCE (2-2/0 AWG)', 'UN');
INSERT INTO temp.rendimiento VALUES (17804, 'CONECTOR RECTO PARA TUBO FLEXIBLE 1"', 'UN');
INSERT INTO temp.rendimiento VALUES (17827, 'IMPULSOR AMPACT AMARILLO, CAT. 69338-4', 'UN');
INSERT INTO temp.rendimiento VALUES (18365, 'CONECTOR BRONCE PARA BARRA TOMA TIERRA  3/4"', 'UN');
INSERT INTO temp.rendimiento VALUES (18646, 'BRAZO RECTO DE ACERO GALVANIZADO DE CAÑERIA ISO R65 DE 1 1/2", TIPO L-150, PARA LUMINARIA DE 250 W', 'UN');
INSERT INTO temp.rendimiento VALUES (18661, 'FN USAR COD. 373, INTERRUPTOR AUTOMATICO 1F 10A, 220V CURVA ?? RIEL', 'UN');
INSERT INTO temp.rendimiento VALUES (18711, 'CABLE DE COBRE AISLADO, SUPERFLEX, MULTIFLEX O COVIFLEX # 10 AWG/5,26MM2, CON AISLACION XTU, PARA B.T.', 'M');
INSERT INTO temp.rendimiento VALUES (18724, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 150KVA, 15KV, NIVEL PERDIDA REDUCIDA, TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (18875, 'SECCIONADOR FUSIBLE UNIPOLAR, EXTERIOR, CAPACIDAD HASTA 160A, 500V,PARA FUSIBLES NH TAMAÑO 00, SIMILAR A CAVANNA MODELO APR 1', 'UN');
INSERT INTO temp.rendimiento VALUES (18895, 'SOPORTE GALVANIZADO PARA 3 SECCIONADORES EXTERIORES FUSIBLES NH APR 160', 'UN');
INSERT INTO temp.rendimiento VALUES (18919, 'ELEMENTO FUSIBLE CURVA GL 25A TIPO NH TAMAÑO 00, PARA SECCIONADOR O BASE PORTA FUSIBLE B.T, MARCA ELECTROMEC.', 'UN');
INSERT INTO temp.rendimiento VALUES (18921, 'ELEMENTO FUSIBLE CURVA GL 40A TIPO NH TAMAÑO 00, PARA SECCIONADOR O BASE PORTA FUSIBLE B.T,MARCA ELECTROMEC.', 'UN');
INSERT INTO temp.rendimiento VALUES (19220, 'CABLE DE ALEACION DE ALUMINIO PURO 1350 PROTEGIDO, 1X185 MM2, PARA LINEAS AEREAS 25 KV, AISLACION XLPE', 'M');
INSERT INTO temp.rendimiento VALUES (19221, 'CABLE DE ALEACION DE ALUMINIO PURO 1350 PROTEGIDO, 1X300 MM2, PARA LINEAS AEREAS 25 KV MONOCAPA', 'M');
INSERT INTO temp.rendimiento VALUES (19278, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 200KVA, 15/400-231V. TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (19373, 'RETENCION PREFORMADA PARA CABLE PROTEGIDO DE 300 MM2, CAT. ND-0122, MARCA PLP. LARGO MÍNIMO 1219MM, DIÁMETRO 30,80MM', 'UN');
INSERT INTO temp.rendimiento VALUES (19376, 'AMARRA DE PASADA PREFORMADA PLASTICA PARA CABLE PROTEGIDO 300 MM2 CAT. TTF-1203, MARCA PLP.LARGOMÍNIMO 610 MM, DIÁMETRO 30,80MM.', 'UN');
INSERT INTO temp.rendimiento VALUES (19448, 'SECCIONADOR FUSIBLE XS, 15KV, 100A, 10000A RUPT., 95KV BIL, EXT. MONOPOLAR, CAT.89021R10-CD, MARCA S&C, CON FERRETERIA PARA MONTAJE EN CRUCETA', 'UN');
INSERT INTO temp.rendimiento VALUES (19843, 'CONECTOR AMPACT CUNA Al/CU PASO-DERIVACION (300-240 MM2), CAT. 1-602031-2, IMPULSOR AMARILLO', 'UN');
INSERT INTO temp.rendimiento VALUES (19844, 'CONECTOR AMPACT CUNA AL/CU PASO (300-185 MM2), DERIVACION 185-70 MM2), CAT:1-602031-6, IMPULSOR AMARILLO', 'UN');
INSERT INTO temp.rendimiento VALUES (19845, 'CRUCETILLA DE FIERRO GALVANIZADA DE 65X65X1200 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (19850, 'CONECTOR AMPACT CUNA AL/CU PARA 70-240 MM2, CATALOGO 1-602031-8, INPULSOR AMARILLO', 'UN');
INSERT INTO temp.rendimiento VALUES (19852, 'CONECTOR ESTRIBO C/DERIVACION 185 MM2 -1/0 AWG CATEGORIA. 602047-0 AMPACT', 'UN');
INSERT INTO temp.rendimiento VALUES (19860, 'CUBIERTA DE PROTECCIÓN PARA CONECTOR ESTRIBO 300 MM2, SERIE AMARILLA, CAT. 0-602107 AMPACT', 'UN');
INSERT INTO temp.rendimiento VALUES (19951, 'DIAGONAL PLETINA FIERRO GALVANIZADO 32X6X800 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (20057, 'AMARRA DE COBRE PARA MT SENCILLA DE 800 MM LARGO RECOCIDO', 'UN');
INSERT INTO temp.rendimiento VALUES (20234, 'CABLE DE ALUMINIO PREENSAMBLADO 3X95/50 MM2, FASE Y NEUTRO AISLADOS, AISLACION DE POLIETILENO RETICULADO (XLPE), CAPA PROTECTORA AL SOL, TENSION NOMINAL 1.100V.', 'M');
INSERT INTO temp.rendimiento VALUES (20571, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 250KVA, 15 KV 400-231V. TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (20688, 'EXTENSION PARA SOPORTE PASO 15 y 23 KV, RED COMPACTA', 'UN');
INSERT INTO temp.rendimiento VALUES (20916, 'FN INTERRUPTOR AUTOMATICO SAIME, 1X30A, 10 KA RUPTURA, CURVA C, ENGANCHE AMERICANO', 'UN');
INSERT INTO temp.rendimiento VALUES (22191, 'CAJA METALICA ANTI-HURTO PINTADA CIERRE POR IMPACTO, 49X24X15 CM (ALTO X ANCHO X FONDO) C/PERNO DE 7 RANURAS', 'UN');
INSERT INTO temp.rendimiento VALUES (22192, 'PERNO DE FIERRO 1/2" X12 HILOS X 2 1/2" PARA AFIANCE DE CAJA ANTI-HURTO A SOPORTE METALICO TIPO L', 'UN');
INSERT INTO temp.rendimiento VALUES (22193, 'SOPORTE METALICO TIPO L, 75,5X50X15 CM PARA CAJA METALICA ANTI-HURTO', 'UN');
INSERT INTO temp.rendimiento VALUES (22284, 'BRAZO RECTO DE ACERO GALVANIZADO DE CAÑERIA ISO R65 DE  2", TIPO L- 400 PARA LUMINARIA DE 250 Y 400 W.', 'UN');
INSERT INTO temp.rendimiento VALUES (23063, 'CABLE DE ALEACION DE ALUMINIO PROTEGIDO, 1X95 MM2, PARA LINEA SAEREAS 25 KV, AISLACION XLPE', 'M');
INSERT INTO temp.rendimiento VALUES (23180, 'CONJUNTO BARRA FASE Y NEUTRO 15 VIAS PARA CAJA METALICA 8 REGLETA TRIFASICA', 'UN');
INSERT INTO temp.rendimiento VALUES (23365, 'FN USAR COD. 44523, RECONECTADOR, SERIE U, MODELO ACO-AUTO CHANGE OVER, 15 kV, 630A, 12,5 kA RUPTURA, CON CONTROL PTCC-TEMPERATE-240-7, CATALOGO U27-ACR-15-12', 'UN');
INSERT INTO temp.rendimiento VALUES (23770, 'TRANSFORMADOR COMPACTO DE MEDIDA 3F 15KV 8400-224V, 300-600/5A', 'UN');
INSERT INTO temp.rendimiento VALUES (23955, 'SOPORTE METALICO PARA MEDIDOR ELECTRONICO ACTARIS ACE 1000 SMO', 'UN');
INSERT INTO temp.rendimiento VALUES (25343, 'ANTENA UHF PARA RADIO MODEM 470-490 MHZ, 5 ELEMENTOS, TIPO YUGI, ANTENEX, MOD. Y4705', 'UN');
INSERT INTO temp.rendimiento VALUES (26041, 'POSTE DE FIERRO GALVANIZADO PETITJEAN MOD. OMEGA 2360; 7 M DE LARGO, CIRCULAR CONICO C/BRAZO RECTO DOBLE LARGO TOTAL 2 M (LARGO POR BRAZO 1 M)', 'UN');
INSERT INTO temp.rendimiento VALUES (26574, 'POSTE DE HORMIGON ARMADO 9,5 MTS (POSTE DE 11,5 MTS RECORTADO A 9.5 EN EL EXTREMO SUPERIOR) C/PLACA DE IDENTIFICACION', 'UN');
INSERT INTO temp.rendimiento VALUES (26674, 'CONECTOR SATELITE, CORTO CIRCUITO PARA CONDUCTOR PREENSAMBLADO DE 35 A 95 MM2, CU-AL MODELO TTD-2', 'UN');
INSERT INTO temp.rendimiento VALUES (26706, 'CONECTOR EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (26935, 'INTERRUPTOR AUTOMATICO TERMOMAGNETICO SAIME, 6 KA RUPTURA, RIEL AMERICANO, CURVA C, 1X10A', 'UN');
INSERT INTO temp.rendimiento VALUES (27344, 'BARRA LISA TOMATIERRA DE FIERRO GALVANIZADA DE 1/2" X 7000 MM (TRAMOS RECTOS DE 3000 X 2000 X 1800 MM)', 'UN');
INSERT INTO temp.rendimiento VALUES (28521, 'LUMINARIA 150W SCHREDER, MOD. ONYX 1, C/KIT DE 150 W SODIO, C/VIDRIO TEMPLADO, C/BALLAST DOBLE POTENCIA, C/PINTURA COLOR AZUL RAL 5010', 'UN');
INSERT INTO temp.rendimiento VALUES (31880, 'JUEGO DE 3 SENSORES DE VOLTAJE CVT EXTERNOS, 15 KV, PARA RECONECTADOR SERIE U, MARCA MERLIN GERIN', 'UN');
INSERT INTO temp.rendimiento VALUES (33870, 'GRILLETE GALVANIZADO CON GUARDACABO PASADOR Y CHAVETA TIPO 2 PARA CABLE 300 MM2', 'UN');
INSERT INTO temp.rendimiento VALUES (35737, 'ALUMINIO PROTEGIDO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (36128, 'ALUMINIO PREENSAMBLADO DIPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (36166, 'SOPORTE GALVANIZADO DE PASO EN ANGULO Y CANTILEVER PARAREDES COMPACTAS C/PRENSA', 'UN');
INSERT INTO temp.rendimiento VALUES (36292, 'POSTE DE FIERRO GALVANIZADO TUBULAR DE 3" X 6 M, C/2 VASTAGOS DE 1 1/2"X200MM, C/PLACA Y CANASTILLO', 'UN');
INSERT INTO temp.rendimiento VALUES (36546, 'MUFA TERMINAL 3M QT-28A0-S EXTERIOR 15KV C/3 PUNTAS PARA CABLE MONOPLAR AIS. SOL. 35MM2', 'UN');
INSERT INTO temp.rendimiento VALUES (36547, 'MUFA TERMINAL 3M QT-28A-S EXTERIOR 15KV C/3 PUNTAS PARA CABLE MONOPOLAR AIS. SOL. 85-120MM2', 'UN');
INSERT INTO temp.rendimiento VALUES (36551, 'MUFA TERMINAL 3M QT-15A INTERIOR 15KV C/3 PUNTAS PARA CABLE MONOPOLAR AIS. SOL. 35MM2', 'UN');
INSERT INTO temp.rendimiento VALUES (36779, 'AISLADOR CERÁMICO SEPARADOR PARA DESCONECTADOR FUSIBLE MOD. PSU-047 MARCA SANTANA', 'UN');
INSERT INTO temp.rendimiento VALUES (36805, 'AISLADOR PORCELANA TIPO TENSOR, 86 MM DE DIAMETRO, 136 MM DE ALTO, CLASE ANSI 54-3, 9000 KILOS DE RUPTURA', 'UN');
INSERT INTO temp.rendimiento VALUES (36810, 'ALAMBRE DE COBRE DESNUDO, DURO, # 4 AWG21,2MM2', 'KG');
INSERT INTO temp.rendimiento VALUES (36892, 'BARRA ACERO GALVANIZADO CON OJO 3/4" X 2400 MM CON 2 TUERCAS NORMA ENDESA PLANO TM-G102-1', 'UN');
INSERT INTO temp.rendimiento VALUES (36977, 'BUSHING ACERO BICROMATADO PARA CAÑERIA 1"', 'UN');
INSERT INTO temp.rendimiento VALUES (36987, 'CABLE DE ALUMINIO PREENSAMBLADO 2x25 MM2, CON FASE Y NEUTRO AISLADO', 'M');
INSERT INTO temp.rendimiento VALUES (37346, 'CONTRATUERCA ACERO ELECTRO GALVANIZADO BICROMATADO PARA CAÑERIA 1"', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA DE HORMIGON PRETENSADO 75X75X2220 MM, PL. M- 5485-A4, 31 KG, NORMA CGE', 'UN');
INSERT INTO temp.rendimiento VALUES (37973, 'MUERTO CONICO DE CONCRETO PINTADO NORMA ENDESA', 'UN');
INSERT INTO temp.rendimiento VALUES (38072, 'PERNO DE ACERO GALVANIZADO CON OJO DE 3/4" X 9" X 3" HILO CON TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (38099, 'PERNO HEXAGONAL ACERO GALVANIZADO GRADO 2, 5/8" X 10" X 5" HILO CON TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (38106, 'PERNO HEXAGONAL ACERO GALVANIZADO GRADO 2, 5/8" X 2" X 2" HILO CON TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (38143, 'PLACA DE ACERO GALVANIZADA 300X200X3 MM C/PREFORACION CENTRADAS DE 5/8"', 'UN');
INSERT INTO temp.rendimiento VALUES (38239, 'PRENSA PARALELA BRONCE PARA CONDUCTOR DE COBRE 8 A 2 AWG CON 1PERNO COCHE 5/16" X 13/4" DE COBRE, 1 TUERCA DE BRONCE Y 1 GOLILLA DEPRESION ESTAÑADA', 'UN');
INSERT INTO temp.rendimiento VALUES (38404, 'TORNILLO ROSCA LATA N° 8 1 1/4" LARGO', 'UN');
INSERT INTO temp.rendimiento VALUES (38426, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 10KVA, 13200/231V. TAPS 13860/13530/13200/12540/11880', 'UN');
INSERT INTO temp.rendimiento VALUES (38427, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 15KVA, 13200/231V. TAPS 13860/13530/13200/12540/11880', 'UN');
INSERT INTO temp.rendimiento VALUES (38429, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 25KVA, 13200/231V. TAPS 13860/13530/13200/12540/11880, CON BUSHUING', 'UN');
INSERT INTO temp.rendimiento VALUES (38430, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 25KVA, 13200/231V. TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (38432, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F, AEREO, 25KVA, 23000/231V. TAPS 24150/23000/21850/20700/19550', 'UN');
INSERT INTO temp.rendimiento VALUES (38436, 'TRANSFORMADOR DE DISTRIBUCIÓN 2F AEREO, 5KVA, 13200/231V. TAPS 13860/13530/13200/12540/11880', 'UN');
INSERT INTO temp.rendimiento VALUES (38463, 'FN USAR COD. 38462, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 150KVA, 13200/400-231V. TAPS 13860/13530/13200/12540/11880', 'UN');
INSERT INTO temp.rendimiento VALUES (38466, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 200KVA, 13200/400-231V. TAPS 13530/13200/12540/11880/11550', 'UN');
INSERT INTO temp.rendimiento VALUES (38478, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 30KVA, 13200/400-231V. TAPS 13530/13200/12540/11880/11550', 'UN');
INSERT INTO temp.rendimiento VALUES (38480, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 30KVA, 23000/400-231V, CON BUSHING CLASE 34,5 KV., TAPS 24150/23000/21850/20700/19550', 'UN');
INSERT INTO temp.rendimiento VALUES (38482, 'FN USAR COD. 38481, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 300KVA, 13200/400-231V. TAPS 13860/13530/13200/12540/11880', 'UN');
INSERT INTO temp.rendimiento VALUES (38489, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 45KVA, 13200/400-231V. TAPS 13530/13200/12540/11880/11550', 'UN');
INSERT INTO temp.rendimiento VALUES (38490, 'FN USAR COD. 38489, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 45KVA, 13200/400-231V. TAPS 13860/13530/13200/12540/11880', 'UN');
INSERT INTO temp.rendimiento VALUES (38495, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 75KVA, 13200/400-231V., TAPS 13530/13200/12540/11880/11550', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (38496, 'FN USAR COD. 38495, TRANSFORMADOR DE DISTRIBUCIÓN 3F AEREO, 75KVA, 13200/400-231V., TAPS 13860/13530/13200/12540/11880', 'UN');
INSERT INTO temp.rendimiento VALUES (38512, 'TUBO DE ACERO LAMINADO GALVANIZADO PARA TIRANTE DIA. 90X2500 MM', 'UN');
INSERT INTO temp.rendimiento VALUES (38590, 'TRANSFORMADOR DE MEDIDA COMPACTO 3F 15KV 8400-224V RAZON 1-3-5/5A', 'UN');
INSERT INTO temp.rendimiento VALUES (40577, 'PERNO HEXAGONAL ACERO GALVANIZADO DE 1/2" X 1 1/2" X 1 1/2" DE HILO CON TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (40764, 'CAÑERIA ISO R II LIVIANA GALVANIZADA 1" x 6 METROS CON HILO SIN COPLA', 'TI');
INSERT INTO temp.rendimiento VALUES (40765, 'CAÑERIA ISO R II LIVIANA GALVANIZADA 1/2" x 3 METROS, C/HILO POR UN EXTREMO SIN COPLA', 'TI');
INSERT INTO temp.rendimiento VALUES (40766, 'CAÑERIA ISO R II LIVIANA GALVANIZADA 1/2" x 6 METROS CON HILO SIN COPLA', 'TI');
INSERT INTO temp.rendimiento VALUES (40777, 'SAL GEOELÉCT GEO GEL 8+ PARA MEJORAMIENTO TIERRA BOLSA 7 KG', 'BOL');
INSERT INTO temp.rendimiento VALUES (40958, 'FUSIBLE CABEZA REMOVIBLE 25KV CURVA S 1A .CAT. 1S-FC', 'UN');
INSERT INTO temp.rendimiento VALUES (40998, 'LUMINARIA 70W SODIO, MARCA BRISA VIDRIO LENTICULAR IP OPTICO 65, IP ELECTRICO 64 COLOR GIS STANDARD, SIN BASE, BALLAST LAYRTON NORMAL', 'UN');
INSERT INTO temp.rendimiento VALUES (40999, 'LUMINARIA 100W SODIO MARCA BRISA VIDRIO LENTICULAR IP OPTICO 65, IP ELECTRICO 64 COLOR GIS STANDARD, SIN BASE, BALLAST LAYRTON NORMAL', 'UN');
INSERT INTO temp.rendimiento VALUES (41294, 'ACCESORIOS EN GENERAL EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (41797, 'RIEL DIN SIMETRICO 75 MM T 2 MT', 'M');
INSERT INTO temp.rendimiento VALUES (43453, 'LISTA MATERIALES NO RECUPERABLE', 'UN');
INSERT INTO temp.rendimiento VALUES (44523, 'RECONECTADOR ELECTRONICO, 27 KV, 630A, 12,5 KA DE RUPTURA, MARCA NOJA POWER, Nº CATALOGO OSM-27-12-630 SIN MODULO I/O', 'UN');
INSERT INTO temp.rendimiento VALUES (45016, 'LUMINARIA LED 36W TECEO1 5119 FH VP 16LED 36W NW BACKLIGHT (70W SODIO)', 'UN');
INSERT INTO temp.rendimiento VALUES (45601, 'TRANSFORMADOR DE DISTRIBUCIÓN 3F, AEREO, 112,5KVA, 15KV CON PERDIDA REDUCIDAS, TAPS 15180/14520/13860/13530/13200', 'UN');
INSERT INTO temp.rendimiento VALUES (45989, 'PERNO DE ACERO INOXIDABLE CABEZA HEXAGONAL DE 1/2"X1 1/4" SIN TUERCA', 'UN');
INSERT INTO temp.rendimiento VALUES (45990, 'TUERCA HEXAGONAL DE ACERO INOXIDABLE PARA PERNO 1/2"', 'UN');
INSERT INTO temp.rendimiento VALUES (45991, 'GOLILLA PRESION DE ACERO INOXIDABLE PARA PERNO DE 1/2"', 'UN');
INSERT INTO temp.rendimiento VALUES (48775, 'MEDIDOR ELECTRONICO 1F 5(60) A 220V 50 HZ 1600 PULS/KWH TIPO SC-MR MARCA SCORPION', 'UN');
INSERT INTO temp.rendimiento VALUES (48972, 'TARUGO DE PLASTICO S-8', 'UN');
INSERT INTO temp.rendimiento VALUES (49217, 'AMARRA DE PASADA PREFORMADA PLÁSTICA PARA CABLE PROTEGIDO 50MM2, LARGO MÍNIMO 483 MM, DIÁMETRO 18,25MM. RANGO DIAMETRO MM 13,74 A 18,54', 'UN');
INSERT INTO temp.rendimiento VALUES (51156, 'FN USAR COD. 40998, LUMINARIA 70W SODIO, PHILIPS C/POLICARBONATO IC 220V 50HZ S/BASE, P-P 1X2, SRS-303', 'UN');
INSERT INTO temp.rendimiento VALUES (51157, 'FN USAR COD. 40999, LUMINARIA 100W SODIO PHILIPS C/POLICARBONATO IC 220V 50HZ S/BASE, P-P 1X2, SRS-303', 'UN');
INSERT INTO temp.rendimiento VALUES (51479, 'CONJUNTO SEGURIDAD PERNO TORQUE RADIAL, INCLUYE; 1 PERNO ACERO TEMPLADO Y ZINCADO, 1 TAPÓN ACERO ZINCADO Y 1 GOLILLA DENTADA DE ACERO TEMPLADO Y ZINCADA', 'UN');
INSERT INTO temp.rendimiento VALUES (51554, 'KIT MODEM DIGI 3G, CATÁLOGO WAM-DIGI3G-KIT-001, INCLUYE ADAPTADOR PARARIEL DIN, CABLE DE PODER Y ANTENA OMNI 7.', 'UN');
INSERT INTO temp.rendimiento VALUES (52364, 'TRANSFORMADOR DE DISTRIBUCIÓN 1F, 25KVA, 7620/231V. CON 2 BUSHINGTAPS 7620/7240/6860', 'UN');
INSERT INTO temp.rendimiento VALUES (52460, 'FN USAR COD. 62393, TRANSFORMADOR DE POTENCIAL 1F, 15/0,22 KV, 200VA, TIPO SECO, MARCA NOJA POWER(PARA RECONECTADORES)', 'UN');
INSERT INTO temp.rendimiento VALUES (52924, 'BUSHING GALVANIZADO PARA CONDUIT 2"', 'UN');
INSERT INTO temp.rendimiento VALUES (53481, 'CONECTOR SATELITE TTD2CC 35-95MM2, MARCA SICAME, CAT:TTD2', 'UN');
INSERT INTO temp.rendimiento VALUES (55355, 'LUMINARIA LED 55W MODELO TECEO1 5102 FHV VP 24 LED (55 W) NW CL 1 CNS, SCHREDER (100 W SODIO)', 'UN');
INSERT INTO temp.rendimiento VALUES (55358, 'LUMINARIA LED 90W MODELO TECEO1 5102 FHV VP 40 LED (90 W) NW CL 1 CNS, SCHREDER (150 W SODIO)', 'UN');
INSERT INTO temp.rendimiento VALUES (55429, 'FN USAR COD. 44523, RECONCTADOR MODELO REC27, 27 kV, 630A, 12,5 kA RUPURA, CON CONTROL CC/TEL-01-07, 125 kV, INCLUYE ENTRADAS I/O, 6 SENSORES DE CORRIENTES 6 SENSORES DE VOLTAJE, MARCA TAVRIDA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (56075, 'KIT DE CELDAS SM6 MODELO GAM2 DE ENTRADA DE CABLES C/SECCIONADOR. CLASE24KV 630A 25KA AFL 12,5KA', 'UN');
INSERT INTO temp.rendimiento VALUES (56076, 'KIT DE CELDAS DE SM6 MODELO GBC-B DE MEDICION, CLASE 24KV 630A 25KA AFL12,5KA + 3TI''S+3TT''S', 'UN');
INSERT INTO temp.rendimiento VALUES (56427, 'KIT DE CELDAS SM6 MODELO QM DE PROTECCIÓN, SECCIONADOR-FUSIBLE CLASE24KV 630A 25KA AFL 12.5 KA', 'UN');
INSERT INTO temp.rendimiento VALUES (57075, 'BARRA TOMA TIERRA 3/4 3MT T/2 400 MICAS', 'UN');
INSERT INTO temp.rendimiento VALUES (57315, 'MEDIDOR DIRECTO CL/1 NXT4 3X230/400V 5(120)A', 'UN');
INSERT INTO temp.rendimiento VALUES (57316, 'MEDIDOR 3F INDIRECTO CL/1 NXT4 3X230/400V 1(6)A', 'UN');
INSERT INTO temp.rendimiento VALUES (57365, 'TRANSFORMADOR MEDIDA COMPACTO 15KV 100-200-300/5A 8400-224V', 'UN');
INSERT INTO temp.rendimiento VALUES (62393, 'TRANSFORMADOR POTENCIAL SECO PARA INTEMPERIE 23-15-12/0,220 KV 200 VA, PARA RECONECTADORES, DISTANCIA DE FUGA MÍNIMA 625 MM., IP 67.', 'UN');
INSERT INTO temp.rendimiento VALUES (63153, 'KIT SAE MATERIALES', 'UN');
INSERT INTO temp.rendimiento VALUES (63241, 'CARBONCILLO PUESTAS TIERRA SACO 25KG', 'SA');
INSERT INTO temp.rendimiento VALUES (63934, 'LUMINARIA LED 90W VIAL CLASE P2', 'UN');
INSERT INTO temp.rendimiento VALUES (65340, 'LUMINARIA LED 50W CLEVER GOLD BF BLANCO IK 08, CREE IP 66, CUERPO DE ALUMINIO INYECTADO CONEXIONADO LED INDEPENDIENTE (EQUIVALENTE 100 W NORMAL', 'UN');
INSERT INTO temp.rendimiento VALUES (65351, 'LUMINARIA LED 30W BF CLEVER GOLD BLANCO IP66 IK 08, CREE IP 66, CUERPO DE ALUMINIO INYECTADO CONEXIONADO LED INDEPENDIENTE (EQUIVALENTE 60 W NORMAL)', 'UN');
INSERT INTO temp.rendimiento VALUES (65422, 'LUMINARIA LED 55W MODELO TECEO1 5136 FHV VP 24 LED (55 W) NW CL 1 CNS, SCHREDER  7PIN(100 W SODIO)', 'UN');
INSERT INTO temp.rendimiento VALUES (65424, 'LUMINARIA LED 90W MODELO TECEO1 5136 FHV VP 40 LED (90 W) NW CL 1 CNS, SCHREDER  7PIN(150 W SODIO)', 'UN');
INSERT INTO temp.rendimiento VALUES (65481, 'POSTE CONICO 6M CON BRAZO DOBLE 100CM', 'UN');
INSERT INTO temp.rendimiento VALUES (65517, 'TRANSFORMADOR DE DISTRIBUCION 3F, TIPO SECO 250KVA 15/0,4-0,23KV TRIHAL', 'UN');
INSERT INTO temp.rendimiento VALUES (65519, 'TRANSFORMADOR COMPACTO DE MEDIDA 5-10-20/5 8400/240V', 'UN');
INSERT INTO temp.rendimiento VALUES (66300, 'POSTE TUBULAR 6 M CON BRAZO DOBLE RECTO 1 M', 'UN');
INSERT INTO temp.rendimiento VALUES (66311, 'POSTE TUBULAR 6 M CON 1 BRAZO RECTO 1 M', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (441, 'PERNO HEX 5/8X8IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (444, 'PERNO HEX 5/8X11IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (9452, 'CONECTOR 33-53MM2 25-33MM2 ROJO 600529', 'UN');
INSERT INTO temp.rendimiento VALUES (9461, 'IMPULSOR ROJO P/INSTALAR DESMONTAR', 'UN');
INSERT INTO temp.rendimiento VALUES (7564, 'SOPORTE PASADA LARGO P/UNA VIA 374MM', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (544, 'SOPORTE REMATE GALV 1 VIA P/BT 76MM', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (544, 'SOPORTE REMATE GALV 1 VIA P/BT 76MM', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (7567, 'SOPORTE PASADA CORTO P/LUM 437MM', 'UN');
INSERT INTO temp.rendimiento VALUES (544, 'SOPORTE REMATE GALV 1 VIA P/BT 76MM', 'UN');
INSERT INTO temp.rendimiento VALUES (444, 'PERNO HEX 5/8X11IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (40760, 'CABLE 2AWG/33,63MM2 AL ALE 6201 AAAC', 'M');
INSERT INTO temp.rendimiento VALUES (14851, 'CABLE PREENSAM 25MM2 2 XLPE AL 1100V', 'M');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (9305, 'GRAPA ANCLAJE PG-57-N HUBBELL', 'UN');
INSERT INTO temp.rendimiento VALUES (484, 'PLETINA LARGA GALVANIZADA 75X10X475MM', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO HEX 5/8X14IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (438, 'PERNO HEX 5/8X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALV 12MM C/PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (9305, 'GRAPA ANCLAJE PG-57-N HUBBELL', 'UN');
INSERT INTO temp.rendimiento VALUES (635, 'AISL POLIMERICO SILICONA SUSP 28KV', 'UN');
INSERT INTO temp.rendimiento VALUES (484, 'PLETINA LARGA GALVANIZADA 75X10X475MM', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO HEX 5/8X14IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (438, 'PERNO HEX 5/8X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALV 12MM C/PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (9444, 'PROTECCION PREFOR AL MG-0313 CABLE AAAC', 'UN');
INSERT INTO temp.rendimiento VALUES (7617, 'ESPIGA GALV 3/4INX150MM/295MM CAPS 1-3/8', 'UN');
INSERT INTO temp.rendimiento VALUES (5577, 'AISLADOR ESPIGA M-5920N PORCELANA 7-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (485, 'PLETINA CORTA GALVANIZADA 75X10X365MM', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO HEX 5/8X14IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (635, 'AISL POLIMERICO SILICONA SUSP 28KV', 'UN');
INSERT INTO temp.rendimiento VALUES (484, 'PLETINA LARGA GALVANIZADA 75X10X475MM', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO HEX 5/8X14IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (438, 'PERNO HEX 5/8X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (332, 'GUARDACABO 1/2IN GALVANIZADO', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALV 12MM C/PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (635, 'AISL POLIMERICO SILICONA SUSP 28KV', 'UN');
INSERT INTO temp.rendimiento VALUES (491, 'PRENSA PARALELA BRONCE P/CONDUC 6-1/0AWG', 'UN');
INSERT INTO temp.rendimiento VALUES (484, 'PLETINA LARGA GALVANIZADA 75X10X475MM', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO HEX 5/8X14IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (438, 'PERNO HEX 5/8X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (332, 'GUARDACABO 1/2IN GALVANIZADO', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALV 12MM C/PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (5577, 'AISLADOR ESPIGA M-5920N PORCELANA 7-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (7617, 'ESPIGA GALV 3/4INX150MM/295MM CAPS 1-3/8', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (7617, 'ESPIGA GALV 3/4INX150MM/295MM CAPS 1-3/8', 'UN');
INSERT INTO temp.rendimiento VALUES (5577, 'AISLADOR ESPIGA M-5920N PORCELANA 7-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (1149, 'TUERCA HEX FE PERNO 3/4IN', 'UN');
INSERT INTO temp.rendimiento VALUES (635, 'AISL POLIMERICO SILICONA SUSP 28KV', 'UN');
INSERT INTO temp.rendimiento VALUES (491, 'PRENSA PARALELA BRONCE P/CONDUC 6-1/0AWG', 'UN');
INSERT INTO temp.rendimiento VALUES (484, 'PLETINA LARGA GALVANIZADA 75X10X475MM', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO HEX 5/8X14IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (438, 'PERNO HEX 5/8X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (332, 'GUARDACABO 1/2IN GALVANIZADO', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALV 12MM C/PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (7617, 'ESPIGA GALV 3/4INX150MM/295MM CAPS 1-3/8', 'UN');
INSERT INTO temp.rendimiento VALUES (5577, 'AISLADOR ESPIGA M-5920N PORCELANA 7-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (444, 'PERNO HEX 5/8X11IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (441, 'PERNO HEX 5/8X8IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (7617, 'ESPIGA GALV 3/4INX150MM/295MM CAPS 1-3/8', 'UN');
INSERT INTO temp.rendimiento VALUES (5577, 'AISLADOR ESPIGA M-5920N PORCELANA 7-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (485, 'PLETINA CORTA GALVANIZADA 75X10X365MM', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO HEX 5/8X14IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (301, 'GOLILLA PRESION FE GALV P/PERNO 5/8IN', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (1252, 'POSTE CONCRETO ARMADO 11,5MT C/PLACA', 'UN');
INSERT INTO temp.rendimiento VALUES (9063, 'POSTE CONCRETO ARMADO 13,5MT C/DUCTO', 'UN');
INSERT INTO temp.rendimiento VALUES (10035, 'CONECTOR CUNA UDC II 881783-1', 'UN');
INSERT INTO temp.rendimiento VALUES (10037, 'CUBIERTA II POLIETILENO AMPACTINHO', 'UN');
INSERT INTO temp.rendimiento VALUES (14914, 'CONECTOR PERFORACION P/RED PREENSAMBLADA', 'UN');
INSERT INTO temp.rendimiento VALUES (502, 'CONECTOR MUELA BRONCE ESTAÑADO BIMETAL', 'UN');
INSERT INTO temp.rendimiento VALUES (14905, 'ESLABON ANGULAR AC GALV ESTAM PERNO 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (14904, 'BARRA OJO 5/8INX2000MM GUARDACABO DOBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (6334, 'CABLE ACERO GALV K DURA 3/8IN P/TIRANTE', 'M');
INSERT INTO temp.rendimiento VALUES (3959, 'MUERTO CONICO CONCRETO 35KG P/TRACCION', 'UN');
INSERT INTO temp.rendimiento VALUES (389, 'MEDIA CANA GALV PROTECCION TIRANTE', 'UN');
INSERT INTO temp.rendimiento VALUES (85, 'RETENCION PREFOR AC GALV P/TIRANTE', 'UN');
INSERT INTO temp.rendimiento VALUES (51, 'AISLADOR M-1833-N TENSION PORCELANA 73MM', 'UN');
INSERT INTO temp.rendimiento VALUES (51, 'AISLADOR M-1833-N TENSION PORCELANA 73MM', 'UN');
INSERT INTO temp.rendimiento VALUES (85, 'RETENCION PREFOR AC GALV P/TIRANTE', 'UN');
INSERT INTO temp.rendimiento VALUES (389, 'MEDIA CANA GALV PROTECCION TIRANTE', 'UN');
INSERT INTO temp.rendimiento VALUES (6107, 'MUERTO CONCRETO S/ARMADURA 75KG P/AT', 'UN');
INSERT INTO temp.rendimiento VALUES (6334, 'CABLE ACERO GALV K DURA 3/8IN P/TIRANTE', 'M');
INSERT INTO temp.rendimiento VALUES (14904, 'BARRA OJO 5/8INX2000MM GUARDACABO DOBLE', 'UN');
INSERT INTO temp.rendimiento VALUES (14905, 'ESLABON ANGULAR AC GALV ESTAM PERNO 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (502, 'CONECTOR MUELA BRONCE ESTAÑADO BIMETAL', 'UN');
INSERT INTO temp.rendimiento VALUES (14378, 'CABLE 25MM2 7 CU DESN DURO', 'KG');
INSERT INTO temp.rendimiento VALUES (6831, 'ALAMBRE 6AWG/13,3MM2 CU DESN DURO', 'KG');
INSERT INTO temp.rendimiento VALUES (3676, 'CONDUCTOR CU DESNUDO DISP. P/ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (7564, 'SOPORTE PASADA LARGO P/UNA VIA 374MM', 'UN');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (7565, 'SOPORTE M-5724-N PASADA CORTO P/UNA VIA', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (544, 'SOPORTE REMATE GALV 1 VIA P/BT 76MM', 'UN');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (443, 'PERNO HEX 5/8X10IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (444, 'PERNO HEX 5/8X11IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (544, 'SOPORTE REMATE GALV 1 VIA P/BT 76MM', 'UN');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (7567, 'SOPORTE PASADA CORTO P/LUM 437MM', 'UN');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (544, 'SOPORTE REMATE GALV 1 VIA P/BT 76MM', 'UN');
INSERT INTO temp.rendimiento VALUES (444, 'PERNO HEX 5/8X11IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (50, 'AISL CARRETE PORC 79X76MM ANSI 53-2', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (59, 'ALAMBRE 16MM2 CU DESN', 'KG');
INSERT INTO temp.rendimiento VALUES (3676, 'CONDUCTOR CU DESNUDO DISP. P/ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (44, 'AISLADOR ESPIGA M-5860N PORCELANA 5-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALV 12MM C/PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (491, 'PRENSA PARALELA BRONCE P/CONDUC 6-1/0AWG', 'UN');
INSERT INTO temp.rendimiento VALUES (635, 'AISL POLIMERICO SILICONA SUSP 28KV', 'UN');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3665, 'BRONCE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (44, 'AISLADOR ESPIGA M-5860N PORCELANA 5-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (44, 'AISLADOR ESPIGA M-5860N PORCELANA 5-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALV 12MM C/PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (14742, 'PERNO OJO 5/8X9IN C/TCA GOLILLA', 'UN');
INSERT INTO temp.rendimiento VALUES (17594, 'GRAPA ANCLAJE AC GALVA CONDUCTOR CU 8-2A', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (41294, 'ACCESORIOS EN GENERAL EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (491, 'PRENSA PARALELA BRONCE P/CONDUC 6-1/0AWG', 'UN');
INSERT INTO temp.rendimiento VALUES (484, 'PLETINA LARGA GALVANIZADA 75X10X475MM', 'UN');
INSERT INTO temp.rendimiento VALUES (446, 'PERNO HEX 5/8X14IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (442, 'PERNO HEX 5/8X9IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (438, 'PERNO HEX 5/8X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (332, 'GUARDACABO 1/2IN GALVANIZADO', 'UN');
INSERT INTO temp.rendimiento VALUES (321, 'GRILLETE GALV 12MM C/PASADOR Y CHAVETA', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (13738, 'CRUCETA HORMIGON EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3665, 'BRONCE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (44, 'AISLADOR ESPIGA M-5860N PORCELANA 5-1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (249, 'DIAGONAL FIERRO GALV 32X6MM 935MM', 'UN');
INSERT INTO temp.rendimiento VALUES (291, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 1/2I', 'UN');
INSERT INTO temp.rendimiento VALUES (292, 'GOLILLA PLANA 40X40X5MM FE GALV P/P 5/8I', 'UN');
INSERT INTO temp.rendimiento VALUES (300, 'GOLILLA PRESION FE GALV P/PERNO 1/2IN', 'UN');
INSERT INTO temp.rendimiento VALUES (433, 'PERNO HEX 1/2X5IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (441, 'PERNO HEX 5/8X8IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (444, 'PERNO HEX 5/8X11IN FIERRO GALV C/TCA', 'UN');
INSERT INTO temp.rendimiento VALUES (37379, 'CRUCETA M-5485-A4 HORMIGON PRETENSADO', 'UN');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (3686, 'FIERRO DISPONIBLE PARA ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (13738, 'CRUCETA HORMIGON EN MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (51, 'AISLADOR M-1833-N TENSION PORCELANA 73MM', 'UN');
INSERT INTO temp.rendimiento VALUES (6107, 'MUERTO CONCRETO S/ARMADURA 75KG P/AT', 'UN');
INSERT INTO temp.rendimiento VALUES (6334, 'CABLE ACERO GALV K DURA 3/8IN P/TIRANTE', 'M');
INSERT INTO temp.rendimiento VALUES (5271, 'AISLADOR Y ACCESORIOS MAL ESTADO', 'UN');
INSERT INTO temp.rendimiento VALUES (43453, 'LISTA MATERIALES NO RECUPERABLE', 'UN');
INSERT INTO temp.rendimiento VALUES (3671, 'CABLE ACERO P/TIRANTE MAL ESTADO', 'KG');
INSERT INTO temp.rendimiento VALUES (40760, 'CABLE 2AWG/33,63MM2 AL ALE 6201 AAAC', 'M');
INSERT INTO temp.rendimiento VALUES (6831, 'ALAMBRE 6AWG/13,3MM2 CU DESN DURO', 'KG');
INSERT INTO temp.rendimiento VALUES (3676, 'CONDUCTOR CU DESNUDO DISP. P/ENAJENACION', 'KG');
INSERT INTO temp.rendimiento VALUES (49, 'AISL CARRETE PORC 57X54MM ANSI 53-1', 'UN');
INSERT INTO temp.rendimiento VALUES (7567, 'SOPORTE PASADA CORTO P/LUM 437MM', 'UN');
INSERT INTO temp.rendimiento VALUES (40777, 'ADITIVO GEO GEL 8 + MEJORAMIENTO TIERRA', 'BOL');
INSERT INTO temp.rendimiento VALUES (63241, 'CARBONCILLO PUESTAS TIERRA SACO 25KG', 'SA');


--
-- TOC entry 3948 (class 0 OID 0)
-- Dependencies: 229
-- Name: personas_id_seq; Type: SEQUENCE SET; Schema: _auth; Owner: postgres
--

SELECT pg_catalog.setval('_auth.personas_id_seq', 20, true);


--
-- TOC entry 3949 (class 0 OID 0)
-- Dependencies: 233
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: _auth; Owner: postgres
--

SELECT pg_catalog.setval('_auth.users_id_seq', 23, true);


--
-- TOC entry 3950 (class 0 OID 0)
-- Dependencies: 231
-- Name: camionetas_id_seq; Type: SEQUENCE SET; Schema: _comun; Owner: postgres
--

SELECT pg_catalog.setval('_comun.camionetas_id_seq', 3, true);


--
-- TOC entry 3951 (class 0 OID 0)
-- Dependencies: 219
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: _comun; Owner: postgres
--

SELECT pg_catalog.setval('_comun.cliente_id_seq', 1, false);


--
-- TOC entry 3952 (class 0 OID 0)
-- Dependencies: 216
-- Name: eventos_tipo_id_seq; Type: SEQUENCE SET; Schema: _comun; Owner: postgres
--

SELECT pg_catalog.setval('_comun.eventos_tipo_id_seq', 4, true);


--
-- TOC entry 3953 (class 0 OID 0)
-- Dependencies: 225
-- Name: servicio_comuna_id_seq; Type: SEQUENCE SET; Schema: _comun; Owner: postgres
--

SELECT pg_catalog.setval('_comun.servicio_comuna_id_seq', 20, true);


--
-- TOC entry 3954 (class 0 OID 0)
-- Dependencies: 210
-- Name: servicios_id_seq; Type: SEQUENCE SET; Schema: _comun; Owner: postgres
--

SELECT pg_catalog.setval('_comun.servicios_id_seq', 1, false);


--
-- TOC entry 3955 (class 0 OID 0)
-- Dependencies: 207
-- Name: turnos_id_seq; Type: SEQUENCE SET; Schema: _comun; Owner: postgres
--

SELECT pg_catalog.setval('_comun.turnos_id_seq', 4, true);


--
-- TOC entry 3956 (class 0 OID 0)
-- Dependencies: 252
-- Name: actividades_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.actividades_id_seq', 1, false);


--
-- TOC entry 3957 (class 0 OID 0)
-- Dependencies: 254
-- Name: actividades_obra_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.actividades_obra_id_seq', 1, false);


--
-- TOC entry 3958 (class 0 OID 0)
-- Dependencies: 256
-- Name: adicionales_edp_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.adicionales_edp_id_seq', 1, false);


--
-- TOC entry 3959 (class 0 OID 0)
-- Dependencies: 258
-- Name: bom_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.bom_id_seq', 36, true);


--
-- TOC entry 3960 (class 0 OID 0)
-- Dependencies: 260
-- Name: coordinadores_contratista_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.coordinadores_contratista_id_seq', 1, true);


--
-- TOC entry 3961 (class 0 OID 0)
-- Dependencies: 262
-- Name: delegaciones_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.delegaciones_id_seq', 5, true);


--
-- TOC entry 3962 (class 0 OID 0)
-- Dependencies: 264
-- Name: detalle_edp_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.detalle_edp_id_seq', 1, false);


--
-- TOC entry 3963 (class 0 OID 0)
-- Dependencies: 266
-- Name: detalle_pedido_material_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.detalle_pedido_material_id_seq', 1, false);


--
-- TOC entry 3964 (class 0 OID 0)
-- Dependencies: 268
-- Name: detalle_reporte_diario_actividad_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.detalle_reporte_diario_actividad_id_seq', 1, false);


--
-- TOC entry 3965 (class 0 OID 0)
-- Dependencies: 270
-- Name: detalle_reporte_diario_material_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.detalle_reporte_diario_material_id_seq', 1, false);


--
-- TOC entry 3966 (class 0 OID 0)
-- Dependencies: 272
-- Name: detalle_reporte_diario_otras_actividades_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.detalle_reporte_diario_otras_actividades_id_seq', 1, false);


--
-- TOC entry 3967 (class 0 OID 0)
-- Dependencies: 274
-- Name: empresas_contratista_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.empresas_contratista_id_seq', 1, true);


--
-- TOC entry 3968 (class 0 OID 0)
-- Dependencies: 276
-- Name: encabezado_edp_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.encabezado_edp_id_seq', 1, false);


--
-- TOC entry 3969 (class 0 OID 0)
-- Dependencies: 278
-- Name: encabezado_pedido_material_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.encabezado_pedido_material_id_seq', 1, false);


--
-- TOC entry 3970 (class 0 OID 0)
-- Dependencies: 280
-- Name: encabezado_reporte_diario_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.encabezado_reporte_diario_id_seq', 1, true);


--
-- TOC entry 3971 (class 0 OID 0)
-- Dependencies: 316
-- Name: estado_obra_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.estado_obra_id_seq', 1, true);


--
-- TOC entry 3972 (class 0 OID 0)
-- Dependencies: 320
-- Name: estado_visita_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.estado_visita_id_seq', 1, false);


--
-- TOC entry 3973 (class 0 OID 0)
-- Dependencies: 284
-- Name: jefes_faena_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.jefes_faena_id_seq', 1, false);


--
-- TOC entry 3974 (class 0 OID 0)
-- Dependencies: 286
-- Name: maestro_estructura_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.maestro_estructura_id_seq', 3585, true);


--
-- TOC entry 3975 (class 0 OID 0)
-- Dependencies: 289
-- Name: maestro_unidades_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.maestro_unidades_id_seq', 13, true);


--
-- TOC entry 3976 (class 0 OID 0)
-- Dependencies: 291
-- Name: obras_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.obras_id_seq', 1, true);


--
-- TOC entry 3977 (class 0 OID 0)
-- Dependencies: 293
-- Name: otros_cargos_edp_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.otros_cargos_edp_id_seq', 1, false);


--
-- TOC entry 3978 (class 0 OID 0)
-- Dependencies: 296
-- Name: recibido_bodega_pelom_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.recibido_bodega_pelom_id_seq', 1, false);


--
-- TOC entry 3979 (class 0 OID 0)
-- Dependencies: 298
-- Name: segmento_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.segmento_id_seq', 11, true);


--
-- TOC entry 3980 (class 0 OID 0)
-- Dependencies: 300
-- Name: solicitantes_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.solicitantes_id_seq', 22, true);


--
-- TOC entry 3981 (class 0 OID 0)
-- Dependencies: 302
-- Name: tipo_actividad_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.tipo_actividad_id_seq', 26, true);


--
-- TOC entry 3982 (class 0 OID 0)
-- Dependencies: 304
-- Name: tipo_obra_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.tipo_obra_id_seq', 7, true);


--
-- TOC entry 3983 (class 0 OID 0)
-- Dependencies: 322
-- Name: tipo_operacion_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.tipo_operacion_id_seq', 1, false);


--
-- TOC entry 3984 (class 0 OID 0)
-- Dependencies: 306
-- Name: tipo_trabajo_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.tipo_trabajo_id_seq', 5, true);


--
-- TOC entry 3985 (class 0 OID 0)
-- Dependencies: 308
-- Name: valor_uc_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.valor_uc_id_seq', 1, false);


--
-- TOC entry 3986 (class 0 OID 0)
-- Dependencies: 310
-- Name: visitas_terreno_id_seq; Type: SEQUENCE SET; Schema: obras; Owner: postgres
--

SELECT pg_catalog.setval('obras.visitas_terreno_id_seq', 3, true);


--
-- TOC entry 3987 (class 0 OID 0)
-- Dependencies: 222
-- Name: cargo_fijo_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.cargo_fijo_id_seq', 16, true);


--
-- TOC entry 3988 (class 0 OID 0)
-- Dependencies: 236
-- Name: movil_eventos_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.movil_eventos_id_seq', 41, true);


--
-- TOC entry 3989 (class 0 OID 0)
-- Dependencies: 238
-- Name: movil_jornadas_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.movil_jornadas_id_seq', 7, true);


--
-- TOC entry 3990 (class 0 OID 0)
-- Dependencies: 227
-- Name: precios_base_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.precios_base_id_seq', 80, true);


--
-- TOC entry 3991 (class 0 OID 0)
-- Dependencies: 240
-- Name: reporte_detalle_estado_resultado_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.reporte_detalle_estado_resultado_id_seq', 30, true);


--
-- TOC entry 3992 (class 0 OID 0)
-- Dependencies: 242
-- Name: reporte_errores_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.reporte_errores_id_seq', 6, true);


--
-- TOC entry 3993 (class 0 OID 0)
-- Dependencies: 244
-- Name: reporte_estado_resultado_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.reporte_estado_resultado_id_seq', 11, true);


--
-- TOC entry 3994 (class 0 OID 0)
-- Dependencies: 246
-- Name: reporte_estados_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.reporte_estados_id_seq', 5, true);


--
-- TOC entry 3995 (class 0 OID 0)
-- Dependencies: 248
-- Name: reporte_eventos_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.reporte_eventos_id_seq', 101, true);


--
-- TOC entry 3996 (class 0 OID 0)
-- Dependencies: 250
-- Name: reporte_jornada_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.reporte_jornada_id_seq', 7, true);


--
-- TOC entry 3997 (class 0 OID 0)
-- Dependencies: 313
-- Name: resultado_estado_resultado_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.resultado_estado_resultado_id_seq', 1, false);


--
-- TOC entry 3998 (class 0 OID 0)
-- Dependencies: 311
-- Name: resultado_estados_id_seq; Type: SEQUENCE SET; Schema: sae; Owner: postgres
--

SELECT pg_catalog.setval('sae.resultado_estados_id_seq', 1, true);


--
-- TOC entry 3420 (class 2606 OID 385835)
-- Name: users email_unico; Type: CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.users
    ADD CONSTRAINT email_unico UNIQUE (email);


--
-- TOC entry 3412 (class 2606 OID 385788)
-- Name: personas personas_pkey; Type: CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 385607)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3414 (class 2606 OID 385790)
-- Name: personas rut_unico; Type: CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.personas
    ADD CONSTRAINT rut_unico UNIQUE (rut);


--
-- TOC entry 3427 (class 2606 OID 385850)
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY ("roleId", "userId");


--
-- TOC entry 3423 (class 2606 OID 385837)
-- Name: users username_unico; Type: CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.users
    ADD CONSTRAINT username_unico UNIQUE (username);


--
-- TOC entry 3425 (class 2606 OID 385839)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3396 (class 2606 OID 385714)
-- Name: base base_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.base
    ADD CONSTRAINT base_pkey PRIMARY KEY (id);


--
-- TOC entry 3416 (class 2606 OID 385817)
-- Name: camionetas camionetas_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.camionetas
    ADD CONSTRAINT camionetas_pkey PRIMARY KEY (id);


--
-- TOC entry 3384 (class 2606 OID 385669)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 385599)
-- Name: servicios cod_serv_unico; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicios
    ADD CONSTRAINT cod_serv_unico UNIQUE (codigo);


--
-- TOC entry 3377 (class 2606 OID 385645)
-- Name: eventos_tipo codigo_unico; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.eventos_tipo
    ADD CONSTRAINT codigo_unico UNIQUE (codigo);


--
-- TOC entry 3381 (class 2606 OID 385655)
-- Name: comunas comunas_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.comunas
    ADD CONSTRAINT comunas_pkey PRIMARY KEY (codigo);


--
-- TOC entry 3379 (class 2606 OID 385647)
-- Name: eventos_tipo eventos_tipo_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.eventos_tipo
    ADD CONSTRAINT eventos_tipo_pkey PRIMARY KEY (id);


--
-- TOC entry 3387 (class 2606 OID 385674)
-- Name: paquete id_paq_zonal_unico; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.paquete
    ADD CONSTRAINT id_paq_zonal_unico UNIQUE (id, id_zonal);


--
-- TOC entry 3375 (class 2606 OID 385637)
-- Name: meses meses_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.meses
    ADD CONSTRAINT meses_pkey PRIMARY KEY (id);


--
-- TOC entry 3389 (class 2606 OID 385676)
-- Name: paquete paquete_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.paquete
    ADD CONSTRAINT paquete_pkey PRIMARY KEY (id);


--
-- TOC entry 3418 (class 2606 OID 385819)
-- Name: camionetas patente_unico; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.camionetas
    ADD CONSTRAINT patente_unico UNIQUE (patente);


--
-- TOC entry 3373 (class 2606 OID 385623)
-- Name: provincias provincias_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.provincias
    ADD CONSTRAINT provincias_pkey PRIMARY KEY (codigo);


--
-- TOC entry 3370 (class 2606 OID 385615)
-- Name: regiones regiones_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.regiones
    ADD CONSTRAINT regiones_pkey PRIMARY KEY (codigo);


--
-- TOC entry 3402 (class 2606 OID 385729)
-- Name: servicio_comuna serv_comun_unico; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicio_comuna
    ADD CONSTRAINT serv_comun_unico UNIQUE (servicio, comuna);


--
-- TOC entry 3404 (class 2606 OID 385731)
-- Name: servicio_comuna servicio_comuna_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicio_comuna
    ADD CONSTRAINT servicio_comuna_pkey PRIMARY KEY (id);


--
-- TOC entry 3366 (class 2606 OID 385601)
-- Name: servicios servicios_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicios
    ADD CONSTRAINT servicios_pkey PRIMARY KEY (id);


--
-- TOC entry 3362 (class 2606 OID 385589)
-- Name: tipo_funcion_personal tfp_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.tipo_funcion_personal
    ADD CONSTRAINT tfp_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 385582)
-- Name: turnos turnos_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.turnos
    ADD CONSTRAINT turnos_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 385574)
-- Name: zonal zonal_pkey; Type: CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.zonal
    ADD CONSTRAINT zonal_pkey PRIMARY KEY (id);


--
-- TOC entry 3458 (class 2606 OID 386304)
-- Name: actividades_obra actividades_obra_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.actividades_obra
    ADD CONSTRAINT actividades_obra_pkey PRIMARY KEY (id);


--
-- TOC entry 3456 (class 2606 OID 386306)
-- Name: maestro_actividades actividades_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_actividades
    ADD CONSTRAINT actividades_pkey PRIMARY KEY (id);


--
-- TOC entry 3462 (class 2606 OID 386308)
-- Name: adicionales_edp adicionales_edp_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.adicionales_edp
    ADD CONSTRAINT adicionales_edp_pkey PRIMARY KEY (id);


--
-- TOC entry 3465 (class 2606 OID 386310)
-- Name: bom bom_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.bom
    ADD CONSTRAINT bom_pkey PRIMARY KEY (id);


--
-- TOC entry 3471 (class 2606 OID 386312)
-- Name: coordinadores_contratista coordinadores_contratista_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.coordinadores_contratista
    ADD CONSTRAINT coordinadores_contratista_pkey PRIMARY KEY (id);


--
-- TOC entry 3474 (class 2606 OID 386314)
-- Name: delegaciones delegaciones_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.delegaciones
    ADD CONSTRAINT delegaciones_pkey PRIMARY KEY (id);


--
-- TOC entry 3476 (class 2606 OID 386316)
-- Name: detalle_edp detalle_edp_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_edp
    ADD CONSTRAINT detalle_edp_pkey PRIMARY KEY (id);


--
-- TOC entry 3479 (class 2606 OID 386318)
-- Name: detalle_pedido_material detalle_pedido_material_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_pedido_material
    ADD CONSTRAINT detalle_pedido_material_pkey PRIMARY KEY (id);


--
-- TOC entry 3483 (class 2606 OID 386320)
-- Name: detalle_reporte_diario_actividad detalle_reporte_diario_actividad_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_reporte_diario_actividad
    ADD CONSTRAINT detalle_reporte_diario_actividad_pkey PRIMARY KEY (id);


--
-- TOC entry 3487 (class 2606 OID 386322)
-- Name: detalle_reporte_diario_material detalle_reporte_diario_material_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_reporte_diario_material
    ADD CONSTRAINT detalle_reporte_diario_material_pkey PRIMARY KEY (id);


--
-- TOC entry 3489 (class 2606 OID 386324)
-- Name: detalle_reporte_diario_otras_actividades detalle_reporte_diario_otras_actividades_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_reporte_diario_otras_actividades
    ADD CONSTRAINT detalle_reporte_diario_otras_actividades_pkey PRIMARY KEY (id);


--
-- TOC entry 3491 (class 2606 OID 386326)
-- Name: empresas_contratista empresas_contratista_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.empresas_contratista
    ADD CONSTRAINT empresas_contratista_pkey PRIMARY KEY (id);


--
-- TOC entry 3493 (class 2606 OID 386328)
-- Name: encabezado_edp encabezado_edp_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.encabezado_edp
    ADD CONSTRAINT encabezado_edp_pkey PRIMARY KEY (id);


--
-- TOC entry 3495 (class 2606 OID 386330)
-- Name: encabezado_pedido_material encabezado_pedido_material_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.encabezado_pedido_material
    ADD CONSTRAINT encabezado_pedido_material_pkey PRIMARY KEY (id);


--
-- TOC entry 3497 (class 2606 OID 386332)
-- Name: encabezado_reporte_diario encabezado_reporte_diario_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.encabezado_reporte_diario
    ADD CONSTRAINT encabezado_reporte_diario_pkey PRIMARY KEY (id);


--
-- TOC entry 3562 (class 2606 OID 418078)
-- Name: estado_obra estado_obra_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estado_obra
    ADD CONSTRAINT estado_obra_pkey PRIMARY KEY (id);


--
-- TOC entry 3568 (class 2606 OID 450728)
-- Name: estado_visita estado_visita_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estado_visita
    ADD CONSTRAINT estado_visita_pkey PRIMARY KEY (id);


--
-- TOC entry 3502 (class 2606 OID 386334)
-- Name: estructura_material estructura_material_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estructura_material
    ADD CONSTRAINT estructura_material_pkey PRIMARY KEY (id_estructura, cod_sap_material);


--
-- TOC entry 3505 (class 2606 OID 386336)
-- Name: estructuras_obra estructuras_obra_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estructuras_obra
    ADD CONSTRAINT estructuras_obra_pkey PRIMARY KEY (id_estructura, id_obra);


--
-- TOC entry 3509 (class 2606 OID 386338)
-- Name: jefes_faena jefes_faena_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.jefes_faena
    ADD CONSTRAINT jefes_faena_pkey PRIMARY KEY (id);


--
-- TOC entry 3511 (class 2606 OID 386340)
-- Name: maestro_estructura maestro_estructura_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_estructura
    ADD CONSTRAINT maestro_estructura_pkey PRIMARY KEY (id);


--
-- TOC entry 3514 (class 2606 OID 386342)
-- Name: maestro_materiales maestro_materiales_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_materiales
    ADD CONSTRAINT maestro_materiales_pkey PRIMARY KEY (codigo_sap);


--
-- TOC entry 3516 (class 2606 OID 386344)
-- Name: maestro_unidades maestro_unidades_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_unidades
    ADD CONSTRAINT maestro_unidades_pkey PRIMARY KEY (id);


--
-- TOC entry 3527 (class 2606 OID 386346)
-- Name: obras obras_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT obras_pkey PRIMARY KEY (id);


--
-- TOC entry 3530 (class 2606 OID 386348)
-- Name: otros_cargos_edp otros_cargos_edp_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.otros_cargos_edp
    ADD CONSTRAINT otros_cargos_edp_pkey PRIMARY KEY (id);


--
-- TOC entry 3532 (class 2606 OID 386350)
-- Name: otros_cargos_obra otros_cargos_obra_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.otros_cargos_obra
    ADD CONSTRAINT otros_cargos_obra_pkey PRIMARY KEY (id);


--
-- TOC entry 3535 (class 2606 OID 386352)
-- Name: recibido_bodega_pelom recibido_bodega_pelom_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.recibido_bodega_pelom
    ADD CONSTRAINT recibido_bodega_pelom_pkey PRIMARY KEY (id);


--
-- TOC entry 3564 (class 2606 OID 442528)
-- Name: reservas_obras reservas_obras_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.reservas_obras
    ADD CONSTRAINT reservas_obras_pkey PRIMARY KEY (reserva);


--
-- TOC entry 3537 (class 2606 OID 386354)
-- Name: segmento segmento_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.segmento
    ADD CONSTRAINT segmento_pkey PRIMARY KEY (id);


--
-- TOC entry 3539 (class 2606 OID 386356)
-- Name: solicitantes solicitantes_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.solicitantes
    ADD CONSTRAINT solicitantes_pkey PRIMARY KEY (id);


--
-- TOC entry 3541 (class 2606 OID 386358)
-- Name: tipo_actividad tipo_actividad_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.tipo_actividad
    ADD CONSTRAINT tipo_actividad_pkey PRIMARY KEY (id);


--
-- TOC entry 3543 (class 2606 OID 386360)
-- Name: tipo_obra tipo_obra_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.tipo_obra
    ADD CONSTRAINT tipo_obra_pkey PRIMARY KEY (id);


--
-- TOC entry 3570 (class 2606 OID 467110)
-- Name: tipo_operacion tipo_operacion_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.tipo_operacion
    ADD CONSTRAINT tipo_operacion_pkey PRIMARY KEY (id);


--
-- TOC entry 3545 (class 2606 OID 386362)
-- Name: tipo_trabajo tipo_trabajo_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.tipo_trabajo
    ADD CONSTRAINT tipo_trabajo_pkey PRIMARY KEY (id);


--
-- TOC entry 3550 (class 2606 OID 450736)
-- Name: visitas_terreno unico_id_obra_fecha; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.visitas_terreno
    ADD CONSTRAINT unico_id_obra_fecha UNIQUE (id_obra, fecha_visita);


--
-- TOC entry 3500 (class 2606 OID 458915)
-- Name: encabezado_reporte_diario unico_obra_fecha; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.encabezado_reporte_diario
    ADD CONSTRAINT unico_obra_fecha UNIQUE (id_obra, fecha_reporte);


--
-- TOC entry 3566 (class 2606 OID 442530)
-- Name: reservas_obras unico_reserva_obra; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.reservas_obras
    ADD CONSTRAINT unico_reserva_obra UNIQUE (reserva, id_obra);


--
-- TOC entry 3469 (class 2606 OID 434349)
-- Name: bom uq_reserva_cod_sap; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.bom
    ADD CONSTRAINT uq_reserva_cod_sap UNIQUE (reserva, codigo_sap_material);


--
-- TOC entry 3547 (class 2606 OID 386364)
-- Name: valor_uc valor_uc_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.valor_uc
    ADD CONSTRAINT valor_uc_pkey PRIMARY KEY (id);


--
-- TOC entry 3552 (class 2606 OID 386366)
-- Name: visitas_terreno visitas_terreno_pkey; Type: CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.visitas_terreno
    ADD CONSTRAINT visitas_terreno_pkey PRIMARY KEY (id);


--
-- TOC entry 3560 (class 2606 OID 393397)
-- Name: _oficinas _oficinas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._oficinas
    ADD CONSTRAINT _oficinas_pkey PRIMARY KEY (id);


--
-- TOC entry 3391 (class 2606 OID 385691)
-- Name: cargo_fijo cargo_fijo_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.cargo_fijo
    ADD CONSTRAINT cargo_fijo_pkey PRIMARY KEY (id);


--
-- TOC entry 3444 (class 2606 OID 385949)
-- Name: reporte_eventos eventos_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT eventos_pkey PRIMARY KEY (id);


--
-- TOC entry 3451 (class 2606 OID 385995)
-- Name: reporte_jornada id_movil_j_unico; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada
    ADD CONSTRAINT id_movil_j_unico UNIQUE (id_movil);


--
-- TOC entry 3447 (class 2606 OID 385951)
-- Name: reporte_eventos id_movil_unico; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT id_movil_unico UNIQUE (id_movil);


--
-- TOC entry 3429 (class 2606 OID 385871)
-- Name: movil_eventos movil_eventos_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.movil_eventos
    ADD CONSTRAINT movil_eventos_pkey PRIMARY KEY (id);


--
-- TOC entry 3431 (class 2606 OID 385882)
-- Name: movil_jornadas movil_jornadas_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.movil_jornadas
    ADD CONSTRAINT movil_jornadas_pkey PRIMARY KEY (id);


--
-- TOC entry 3449 (class 2606 OID 385953)
-- Name: reporte_eventos ot_unico; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT ot_unico UNIQUE (numero_ot);


--
-- TOC entry 3407 (class 2606 OID 385758)
-- Name: precios_base precios_base_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.precios_base
    ADD CONSTRAINT precios_base_pkey PRIMARY KEY (id);


--
-- TOC entry 3433 (class 2606 OID 385890)
-- Name: reporte_detalle_estado_resultado reporte_detalle_estado_resultado_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_detalle_estado_resultado
    ADD CONSTRAINT reporte_detalle_estado_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 3435 (class 2606 OID 385901)
-- Name: reporte_errores reporte_errores_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_errores
    ADD CONSTRAINT reporte_errores_pkey PRIMARY KEY (id);


--
-- TOC entry 3440 (class 2606 OID 385912)
-- Name: reporte_estado_resultado reporte_estado_resultado_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_estado_resultado
    ADD CONSTRAINT reporte_estado_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 3442 (class 2606 OID 385938)
-- Name: reporte_estados reporte_estados_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_estados
    ADD CONSTRAINT reporte_estados_pkey PRIMARY KEY (id);


--
-- TOC entry 3454 (class 2606 OID 385997)
-- Name: reporte_jornada reporte_jornada_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada
    ADD CONSTRAINT reporte_jornada_pkey PRIMARY KEY (id);


--
-- TOC entry 3558 (class 2606 OID 393392)
-- Name: resultado_estado_resultado resultado_estado_resultado_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.resultado_estado_resultado
    ADD CONSTRAINT resultado_estado_resultado_pkey PRIMARY KEY (id);


--
-- TOC entry 3554 (class 2606 OID 393381)
-- Name: resultado_estados resultado_estados_nombre_key; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.resultado_estados
    ADD CONSTRAINT resultado_estados_nombre_key UNIQUE (nombre);


--
-- TOC entry 3556 (class 2606 OID 393379)
-- Name: resultado_estados resultado_estados_pkey; Type: CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.resultado_estados
    ADD CONSTRAINT resultado_estados_pkey PRIMARY KEY (id);


--
-- TOC entry 3408 (class 1259 OID 385791)
-- Name: fki_base_fk; Type: INDEX; Schema: _auth; Owner: postgres
--

CREATE INDEX fki_base_fk ON _auth.personas USING btree (base);


--
-- TOC entry 3409 (class 1259 OID 385792)
-- Name: fki_cliente_fk; Type: INDEX; Schema: _auth; Owner: postgres
--

CREATE INDEX fki_cliente_fk ON _auth.personas USING btree (cliente);


--
-- TOC entry 3410 (class 1259 OID 385793)
-- Name: fki_id_funcion_fk; Type: INDEX; Schema: _auth; Owner: postgres
--

CREATE INDEX fki_id_funcion_fk ON _auth.personas USING btree (id_funcion);


--
-- TOC entry 3421 (class 1259 OID 385840)
-- Name: fki_username_fk; Type: INDEX; Schema: _auth; Owner: postgres
--

CREATE INDEX fki_username_fk ON _auth.users USING btree (username);


--
-- TOC entry 3398 (class 1259 OID 385732)
-- Name: fki_comuna_fk; Type: INDEX; Schema: _comun; Owner: postgres
--

CREATE INDEX fki_comuna_fk ON _comun.servicio_comuna USING btree (comuna);


--
-- TOC entry 3397 (class 1259 OID 385715)
-- Name: fki_id_paquete_fk; Type: INDEX; Schema: _comun; Owner: postgres
--

CREATE INDEX fki_id_paquete_fk ON _comun.base USING btree (id_paquete);


--
-- TOC entry 3385 (class 1259 OID 385677)
-- Name: fki_id_zonal_fk; Type: INDEX; Schema: _comun; Owner: postgres
--

CREATE INDEX fki_id_zonal_fk ON _comun.paquete USING btree (id_zonal);


--
-- TOC entry 3399 (class 1259 OID 385733)
-- Name: fki_paquete_fk; Type: INDEX; Schema: _comun; Owner: postgres
--

CREATE INDEX fki_paquete_fk ON _comun.servicio_comuna USING btree (paquete);


--
-- TOC entry 3382 (class 1259 OID 385656)
-- Name: fki_provincia_fk; Type: INDEX; Schema: _comun; Owner: postgres
--

CREATE INDEX fki_provincia_fk ON _comun.comunas USING btree (provincia);


--
-- TOC entry 3371 (class 1259 OID 385624)
-- Name: fki_region_fk; Type: INDEX; Schema: _comun; Owner: postgres
--

CREATE INDEX fki_region_fk ON _comun.provincias USING btree (region);


--
-- TOC entry 3400 (class 1259 OID 385734)
-- Name: fki_serv_fk; Type: INDEX; Schema: _comun; Owner: postgres
--

CREATE INDEX fki_serv_fk ON _comun.servicio_comuna USING btree (servicio);


--
-- TOC entry 3480 (class 1259 OID 386367)
-- Name: fki_fk_bom_id_bom; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_bom_id_bom ON obras.detalle_pedido_material USING btree (id_bom);


--
-- TOC entry 3517 (class 1259 OID 418060)
-- Name: fki_fk_coordinador_contratista; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_coordinador_contratista ON obras.obras USING btree (coordinador_contratista);


--
-- TOC entry 3472 (class 1259 OID 386368)
-- Name: fki_fk_coordinador_empresa; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_coordinador_empresa ON obras.coordinadores_contratista USING btree (id_empresa);


--
-- TOC entry 3518 (class 1259 OID 418054)
-- Name: fki_fk_empresa_contratista; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_empresa_contratista ON obras.obras USING btree (empresa_contratista);


--
-- TOC entry 3528 (class 1259 OID 386369)
-- Name: fki_fk_encabezado_edp_id_encabezado; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_encabezado_edp_id_encabezado ON obras.otros_cargos_edp USING btree (id_encabezado_edp);


--
-- TOC entry 3481 (class 1259 OID 386370)
-- Name: fki_fk_encabezado_pedido_id_encabezado; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_encabezado_pedido_id_encabezado ON obras.detalle_pedido_material USING btree (id_encabezado_pedido);


--
-- TOC entry 3484 (class 1259 OID 467122)
-- Name: fki_fk_id_actividad_maestro_actividad; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_id_actividad_maestro_actividad ON obras.detalle_reporte_diario_actividad USING btree (id_actividad);


--
-- TOC entry 3498 (class 1259 OID 458913)
-- Name: fki_fk_id_area_tipo_trabajo; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_id_area_tipo_trabajo ON obras.encabezado_reporte_diario USING btree (id_area);


--
-- TOC entry 3485 (class 1259 OID 467116)
-- Name: fki_fk_id_encabezado_rep; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_id_encabezado_rep ON obras.detalle_reporte_diario_actividad USING btree (id_encabezado_rep);


--
-- TOC entry 3466 (class 1259 OID 386371)
-- Name: fki_fk_id_obra_obra; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_id_obra_obra ON obras.bom USING btree (id_obra);


--
-- TOC entry 3477 (class 1259 OID 386372)
-- Name: fki_fk_maestro_Actividades_detedp; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX "fki_fk_maestro_Actividades_detedp" ON obras.detalle_edp USING btree (actividad);


--
-- TOC entry 3463 (class 1259 OID 386373)
-- Name: fki_fk_maestro_actividad_actividad; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_maestro_actividad_actividad ON obras.adicionales_edp USING btree (actividad);


--
-- TOC entry 3459 (class 1259 OID 386374)
-- Name: fki_fk_maestro_actividades_actividad; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_maestro_actividades_actividad ON obras.actividades_obra USING btree (actividad);


--
-- TOC entry 3506 (class 1259 OID 386375)
-- Name: fki_fk_maestro_estructura_id_estructura; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_maestro_estructura_id_estructura ON obras.estructuras_obra USING btree (id_estructura);


--
-- TOC entry 3512 (class 1259 OID 386376)
-- Name: fki_fk_maestro_mat_unidad; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_maestro_mat_unidad ON obras.maestro_materiales USING btree (id_unidad);


--
-- TOC entry 3533 (class 1259 OID 386377)
-- Name: fki_fk_maestro_material_cod_sap; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_maestro_material_cod_sap ON obras.recibido_bodega_pelom USING btree (codigo_sap_material);


--
-- TOC entry 3503 (class 1259 OID 386378)
-- Name: fki_fk_maestro_materiales_cod_sap; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_maestro_materiales_cod_sap ON obras.estructura_material USING btree (cod_sap_material);


--
-- TOC entry 3519 (class 1259 OID 418084)
-- Name: fki_fk_obra_estado_estados_obra; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obra_estado_estados_obra ON obras.obras USING btree (estado);


--
-- TOC entry 3520 (class 1259 OID 418066)
-- Name: fki_fk_obras_comuna; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obras_comuna ON obras.obras USING btree (comuna);


--
-- TOC entry 3521 (class 1259 OID 418042)
-- Name: fki_fk_obras_delegacion_id_delegacion; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obras_delegacion_id_delegacion ON obras.obras USING btree (delegacion);


--
-- TOC entry 3460 (class 1259 OID 386379)
-- Name: fki_fk_obras_id; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obras_id ON obras.actividades_obra USING btree (id_obra);


--
-- TOC entry 3507 (class 1259 OID 386380)
-- Name: fki_fk_obras_id_obra; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obras_id_obra ON obras.estructuras_obra USING btree (id_obra);


--
-- TOC entry 3522 (class 1259 OID 418091)
-- Name: fki_fk_obras_segmento; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obras_segmento ON obras.obras USING btree (segmento);


--
-- TOC entry 3523 (class 1259 OID 418030)
-- Name: fki_fk_obras_tipo_obra; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obras_tipo_obra ON obras.obras USING btree (tipo_obra);


--
-- TOC entry 3524 (class 1259 OID 418048)
-- Name: fki_fk_obras_tipo_trabajo; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obras_tipo_trabajo ON obras.obras USING btree (tipo_trabajo);


--
-- TOC entry 3525 (class 1259 OID 418036)
-- Name: fki_fk_obras_zona_zonales; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_obras_zona_zonales ON obras.obras USING btree (zona);


--
-- TOC entry 3467 (class 1259 OID 442536)
-- Name: fki_fk_reserva_id_obra; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_fk_reserva_id_obra ON obras.bom USING btree (reserva, id_obra);


--
-- TOC entry 3548 (class 1259 OID 450734)
-- Name: fki_k; Type: INDEX; Schema: obras; Owner: postgres
--

CREATE INDEX fki_k ON obras.visitas_terreno USING btree (estado);


--
-- TOC entry 3392 (class 1259 OID 385692)
-- Name: fki_id_cliente_fk; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX fki_id_cliente_fk ON sae.cargo_fijo USING btree (id_cliente);


--
-- TOC entry 3405 (class 1259 OID 385759)
-- Name: fki_id_evento_tipo_fk; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX fki_id_evento_tipo_fk ON sae.precios_base USING btree (id_evento_tipo);


--
-- TOC entry 3436 (class 1259 OID 385913)
-- Name: fki_id_mes_fk; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX fki_id_mes_fk ON sae.reporte_estado_resultado USING btree (mes);


--
-- TOC entry 3393 (class 1259 OID 385693)
-- Name: fki_id_paquete_cf_fk; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX fki_id_paquete_cf_fk ON sae.cargo_fijo USING btree (id_paquete);


--
-- TOC entry 3394 (class 1259 OID 385694)
-- Name: fki_id_turno_fk; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX fki_id_turno_fk ON sae.cargo_fijo USING btree (id_turno);


--
-- TOC entry 3437 (class 1259 OID 385914)
-- Name: fki_id_usuario_fk; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX fki_id_usuario_fk ON sae.reporte_estado_resultado USING btree (id_usuario);


--
-- TOC entry 3438 (class 1259 OID 385915)
-- Name: fki_id_zona_fk; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX fki_id_zona_fk ON sae.reporte_estado_resultado USING btree (paquete, zona);


--
-- TOC entry 3445 (class 1259 OID 385954)
-- Name: id_movil_idx; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX id_movil_idx ON sae.reporte_eventos USING btree (id_movil);


--
-- TOC entry 3452 (class 1259 OID 385998)
-- Name: idx_id_movil_j; Type: INDEX; Schema: sae; Owner: postgres
--

CREATE INDEX idx_id_movil_j ON sae.reporte_jornada USING btree (id_movil);


--
-- TOC entry 3641 (class 2620 OID 450717)
-- Name: bom trg_ajusta_reservas; Type: TRIGGER; Schema: obras; Owner: postgres
--

CREATE TRIGGER trg_ajusta_reservas AFTER DELETE OR UPDATE OR TRUNCATE ON obras.bom FOR EACH STATEMENT EXECUTE FUNCTION obras.reservas_obras();


--
-- TOC entry 3585 (class 2606 OID 385794)
-- Name: personas base_fk; Type: FK CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.personas
    ADD CONSTRAINT base_fk FOREIGN KEY (base) REFERENCES _comun.base(id);


--
-- TOC entry 3586 (class 2606 OID 385799)
-- Name: personas cliente_fk; Type: FK CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.personas
    ADD CONSTRAINT cliente_fk FOREIGN KEY (cliente) REFERENCES _comun.cliente(id);


--
-- TOC entry 3587 (class 2606 OID 385804)
-- Name: personas id_funcion_fk; Type: FK CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.personas
    ADD CONSTRAINT id_funcion_fk FOREIGN KEY (id_funcion) REFERENCES _comun.tipo_funcion_personal(id);


--
-- TOC entry 3590 (class 2606 OID 385851)
-- Name: user_roles user_roles_roleId_fkey; Type: FK CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.user_roles
    ADD CONSTRAINT "user_roles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES _auth.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3591 (class 2606 OID 385856)
-- Name: user_roles user_roles_userId_fkey; Type: FK CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.user_roles
    ADD CONSTRAINT "user_roles_userId_fkey" FOREIGN KEY ("userId") REFERENCES _auth.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3589 (class 2606 OID 385841)
-- Name: users username_fk; Type: FK CONSTRAINT; Schema: _auth; Owner: postgres
--

ALTER TABLE ONLY _auth.users
    ADD CONSTRAINT username_fk FOREIGN KEY (username) REFERENCES _auth.personas(rut);


--
-- TOC entry 3578 (class 2606 OID 385735)
-- Name: servicio_comuna comuna_fk; Type: FK CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicio_comuna
    ADD CONSTRAINT comuna_fk FOREIGN KEY (comuna) REFERENCES _comun.comunas(codigo);


--
-- TOC entry 3588 (class 2606 OID 385820)
-- Name: camionetas id_base_camioneta_fk; Type: FK CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.camionetas
    ADD CONSTRAINT id_base_camioneta_fk FOREIGN KEY (id_base) REFERENCES _comun.base(id);


--
-- TOC entry 3577 (class 2606 OID 385716)
-- Name: base id_paquete_fk; Type: FK CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.base
    ADD CONSTRAINT id_paquete_fk FOREIGN KEY (id_paquete) REFERENCES _comun.paquete(id);


--
-- TOC entry 3573 (class 2606 OID 385678)
-- Name: paquete id_zonal_fk; Type: FK CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.paquete
    ADD CONSTRAINT id_zonal_fk FOREIGN KEY (id_zonal) REFERENCES _comun.zonal(id);


--
-- TOC entry 3579 (class 2606 OID 385740)
-- Name: servicio_comuna paquete_fk; Type: FK CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicio_comuna
    ADD CONSTRAINT paquete_fk FOREIGN KEY (paquete) REFERENCES _comun.paquete(id);


--
-- TOC entry 3572 (class 2606 OID 385657)
-- Name: comunas provincia_fk; Type: FK CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.comunas
    ADD CONSTRAINT provincia_fk FOREIGN KEY (provincia) REFERENCES _comun.provincias(codigo);


--
-- TOC entry 3571 (class 2606 OID 385625)
-- Name: provincias region_fk; Type: FK CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.provincias
    ADD CONSTRAINT region_fk FOREIGN KEY (region) REFERENCES _comun.regiones(codigo);


--
-- TOC entry 3580 (class 2606 OID 385745)
-- Name: servicio_comuna serv_fk; Type: FK CONSTRAINT; Schema: _comun; Owner: postgres
--

ALTER TABLE ONLY _comun.servicio_comuna
    ADD CONSTRAINT serv_fk FOREIGN KEY (servicio) REFERENCES _comun.servicios(codigo);


--
-- TOC entry 3607 (class 2606 OID 386381)
-- Name: maestro_actividades fk_actividad_tipo; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_actividades
    ADD CONSTRAINT fk_actividad_tipo FOREIGN KEY (id_tipo_actividad) REFERENCES obras.tipo_actividad(id);


--
-- TOC entry 3617 (class 2606 OID 386386)
-- Name: detalle_pedido_material fk_bom_id_bom; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_pedido_material
    ADD CONSTRAINT fk_bom_id_bom FOREIGN KEY (id_bom) REFERENCES obras.bom(id);


--
-- TOC entry 3627 (class 2606 OID 418055)
-- Name: obras fk_coordinador_contratista; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_coordinador_contratista FOREIGN KEY (coordinador_contratista) REFERENCES obras.coordinadores_contratista(id);


--
-- TOC entry 3614 (class 2606 OID 386391)
-- Name: coordinadores_contratista fk_coordinador_empresa; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.coordinadores_contratista
    ADD CONSTRAINT fk_coordinador_empresa FOREIGN KEY (id_empresa) REFERENCES obras.empresas_contratista(id);


--
-- TOC entry 3628 (class 2606 OID 418049)
-- Name: obras fk_empresa_contratista; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_empresa_contratista FOREIGN KEY (empresa_contratista) REFERENCES obras.empresas_contratista(id);


--
-- TOC entry 3636 (class 2606 OID 386396)
-- Name: otros_cargos_edp fk_encabezado_edp_id_encabezado; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.otros_cargos_edp
    ADD CONSTRAINT fk_encabezado_edp_id_encabezado FOREIGN KEY (id_encabezado_edp) REFERENCES obras.encabezado_edp(id);


--
-- TOC entry 3610 (class 2606 OID 386401)
-- Name: adicionales_edp fk_encabezado_edp_id_encabezado; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.adicionales_edp
    ADD CONSTRAINT fk_encabezado_edp_id_encabezado FOREIGN KEY (id_encabezado_edp) REFERENCES obras.encabezado_edp(id);


--
-- TOC entry 3615 (class 2606 OID 386406)
-- Name: detalle_edp fk_encabezado_edp_id_encabezado; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_edp
    ADD CONSTRAINT fk_encabezado_edp_id_encabezado FOREIGN KEY (id_encabezado_edp) REFERENCES obras.encabezado_edp(id);


--
-- TOC entry 3618 (class 2606 OID 386411)
-- Name: detalle_pedido_material fk_encabezado_pedido_id_encabezado; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_pedido_material
    ADD CONSTRAINT fk_encabezado_pedido_id_encabezado FOREIGN KEY (id_encabezado_pedido) REFERENCES obras.encabezado_pedido_material(id);


--
-- TOC entry 3639 (class 2606 OID 450729)
-- Name: visitas_terreno fk_estado_visita; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.visitas_terreno
    ADD CONSTRAINT fk_estado_visita FOREIGN KEY (estado) REFERENCES obras.estado_visita(id) NOT VALID;


--
-- TOC entry 3619 (class 2606 OID 467117)
-- Name: detalle_reporte_diario_actividad fk_id_actividad_maestro_actividad; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_reporte_diario_actividad
    ADD CONSTRAINT fk_id_actividad_maestro_actividad FOREIGN KEY (id_actividad) REFERENCES obras.maestro_actividades(id);


--
-- TOC entry 3621 (class 2606 OID 458908)
-- Name: encabezado_reporte_diario fk_id_area_tipo_trabajo; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.encabezado_reporte_diario
    ADD CONSTRAINT fk_id_area_tipo_trabajo FOREIGN KEY (id_area) REFERENCES obras.tipo_trabajo(id);


--
-- TOC entry 3620 (class 2606 OID 467111)
-- Name: detalle_reporte_diario_actividad fk_id_encabezado_rep; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_reporte_diario_actividad
    ADD CONSTRAINT fk_id_encabezado_rep FOREIGN KEY (id_encabezado_rep) REFERENCES obras.encabezado_reporte_diario(id);


--
-- TOC entry 3612 (class 2606 OID 386416)
-- Name: bom fk_id_obra_obra; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.bom
    ADD CONSTRAINT fk_id_obra_obra FOREIGN KEY (id_obra) REFERENCES obras.obras(id);


--
-- TOC entry 3611 (class 2606 OID 386421)
-- Name: adicionales_edp fk_maestro_actividad_actividad; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.adicionales_edp
    ADD CONSTRAINT fk_maestro_actividad_actividad FOREIGN KEY (actividad) REFERENCES obras.maestro_actividades(id);


--
-- TOC entry 3608 (class 2606 OID 386426)
-- Name: actividades_obra fk_maestro_actividades_actividad; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.actividades_obra
    ADD CONSTRAINT fk_maestro_actividades_actividad FOREIGN KEY (actividad) REFERENCES obras.maestro_actividades(id);


--
-- TOC entry 3616 (class 2606 OID 386431)
-- Name: detalle_edp fk_maestro_actividades_detedp; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.detalle_edp
    ADD CONSTRAINT fk_maestro_actividades_detedp FOREIGN KEY (actividad) REFERENCES obras.maestro_actividades(id);


--
-- TOC entry 3624 (class 2606 OID 386436)
-- Name: estructuras_obra fk_maestro_estructura_id_estructura; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estructuras_obra
    ADD CONSTRAINT fk_maestro_estructura_id_estructura FOREIGN KEY (id_estructura) REFERENCES obras.maestro_estructura(id);


--
-- TOC entry 3622 (class 2606 OID 386441)
-- Name: estructura_material fk_maestro_estructura_id_estructura; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estructura_material
    ADD CONSTRAINT fk_maestro_estructura_id_estructura FOREIGN KEY (id_estructura) REFERENCES obras.maestro_estructura(id);


--
-- TOC entry 3626 (class 2606 OID 386446)
-- Name: maestro_materiales fk_maestro_mat_unidad; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.maestro_materiales
    ADD CONSTRAINT fk_maestro_mat_unidad FOREIGN KEY (id_unidad) REFERENCES obras.maestro_unidades(id);


--
-- TOC entry 3637 (class 2606 OID 386451)
-- Name: recibido_bodega_pelom fk_maestro_material_cod_sap; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.recibido_bodega_pelom
    ADD CONSTRAINT fk_maestro_material_cod_sap FOREIGN KEY (codigo_sap_material) REFERENCES obras.maestro_materiales(codigo_sap);


--
-- TOC entry 3623 (class 2606 OID 386456)
-- Name: estructura_material fk_maestro_materiales_cod_sap; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estructura_material
    ADD CONSTRAINT fk_maestro_materiales_cod_sap FOREIGN KEY (cod_sap_material) REFERENCES obras.maestro_materiales(codigo_sap);


--
-- TOC entry 3629 (class 2606 OID 418079)
-- Name: obras fk_obra_estado_estados_obra; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_obra_estado_estados_obra FOREIGN KEY (estado) REFERENCES obras.estado_obra(id);


--
-- TOC entry 3630 (class 2606 OID 418061)
-- Name: obras fk_obras_comuna; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_obras_comuna FOREIGN KEY (comuna) REFERENCES _comun.comunas(codigo);


--
-- TOC entry 3631 (class 2606 OID 418037)
-- Name: obras fk_obras_delegacion_id_delegacion; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_obras_delegacion_id_delegacion FOREIGN KEY (delegacion) REFERENCES obras.delegaciones(id);


--
-- TOC entry 3609 (class 2606 OID 386461)
-- Name: actividades_obra fk_obras_id; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.actividades_obra
    ADD CONSTRAINT fk_obras_id FOREIGN KEY (id_obra) REFERENCES obras.obras(id);


--
-- TOC entry 3625 (class 2606 OID 386466)
-- Name: estructuras_obra fk_obras_id_obra; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.estructuras_obra
    ADD CONSTRAINT fk_obras_id_obra FOREIGN KEY (id_obra) REFERENCES obras.obras(id);


--
-- TOC entry 3640 (class 2606 OID 386471)
-- Name: visitas_terreno fk_obras_id_obra; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.visitas_terreno
    ADD CONSTRAINT fk_obras_id_obra FOREIGN KEY (id_obra) REFERENCES obras.obras(id);


--
-- TOC entry 3632 (class 2606 OID 418086)
-- Name: obras fk_obras_segmento; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_obras_segmento FOREIGN KEY (segmento) REFERENCES obras.segmento(id);


--
-- TOC entry 3633 (class 2606 OID 418025)
-- Name: obras fk_obras_tipo_obra; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_obras_tipo_obra FOREIGN KEY (tipo_obra) REFERENCES obras.tipo_obra(id);


--
-- TOC entry 3634 (class 2606 OID 418043)
-- Name: obras fk_obras_tipo_trabajo; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_obras_tipo_trabajo FOREIGN KEY (tipo_trabajo) REFERENCES obras.tipo_trabajo(id);


--
-- TOC entry 3635 (class 2606 OID 418031)
-- Name: obras fk_obras_zona_zonales; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.obras
    ADD CONSTRAINT fk_obras_zona_zonales FOREIGN KEY (zona) REFERENCES _comun.zonal(id);


--
-- TOC entry 3613 (class 2606 OID 442531)
-- Name: bom fk_reserva_id_obra; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.bom
    ADD CONSTRAINT fk_reserva_id_obra FOREIGN KEY (reserva, id_obra) REFERENCES obras.reservas_obras(reserva, id_obra);


--
-- TOC entry 3638 (class 2606 OID 386476)
-- Name: solicitantes fk_segmento_delegacion; Type: FK CONSTRAINT; Schema: obras; Owner: postgres
--

ALTER TABLE ONLY obras.solicitantes
    ADD CONSTRAINT fk_segmento_delegacion FOREIGN KEY (id_delegacion) REFERENCES obras.delegaciones(id);


--
-- TOC entry 3595 (class 2606 OID 385955)
-- Name: reporte_eventos cod_turno_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT cod_turno_fk FOREIGN KEY (codigo_turno) REFERENCES _comun.turnos(id);


--
-- TOC entry 3601 (class 2606 OID 385999)
-- Name: reporte_jornada cod_turno_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada
    ADD CONSTRAINT cod_turno_fk FOREIGN KEY (codigo_turno) REFERENCES _comun.turnos(id);


--
-- TOC entry 3596 (class 2606 OID 385960)
-- Name: reporte_eventos est_evento_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT est_evento_fk FOREIGN KEY (estado) REFERENCES sae.reporte_estados(id);


--
-- TOC entry 3602 (class 2606 OID 386004)
-- Name: reporte_jornada est_jor_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada
    ADD CONSTRAINT est_jor_fk FOREIGN KEY (estado) REFERENCES sae.reporte_estados(id);


--
-- TOC entry 3574 (class 2606 OID 385695)
-- Name: cargo_fijo id_cliente_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.cargo_fijo
    ADD CONSTRAINT id_cliente_fk FOREIGN KEY (id_cliente) REFERENCES _comun.cliente(id);


--
-- TOC entry 3581 (class 2606 OID 385760)
-- Name: precios_base id_cliente_pb_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.precios_base
    ADD CONSTRAINT id_cliente_pb_fk FOREIGN KEY (id_cliente) REFERENCES _comun.cliente(id);


--
-- TOC entry 3582 (class 2606 OID 385765)
-- Name: precios_base id_evento_tipo_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.precios_base
    ADD CONSTRAINT id_evento_tipo_fk FOREIGN KEY (id_evento_tipo) REFERENCES _comun.eventos_tipo(id);


--
-- TOC entry 3592 (class 2606 OID 385916)
-- Name: reporte_estado_resultado id_mes_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_estado_resultado
    ADD CONSTRAINT id_mes_fk FOREIGN KEY (mes) REFERENCES _comun.meses(id);


--
-- TOC entry 3597 (class 2606 OID 385965)
-- Name: reporte_eventos id_paquete_evt_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT id_paquete_evt_fk FOREIGN KEY (id_paquete) REFERENCES _comun.paquete(id);


--
-- TOC entry 3575 (class 2606 OID 385700)
-- Name: cargo_fijo id_paquete_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.cargo_fijo
    ADD CONSTRAINT id_paquete_fk FOREIGN KEY (id_paquete) REFERENCES _comun.paquete(id);


--
-- TOC entry 3603 (class 2606 OID 386009)
-- Name: reporte_jornada id_paquete_jornada_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada
    ADD CONSTRAINT id_paquete_jornada_fk FOREIGN KEY (id_paquete) REFERENCES _comun.paquete(id);


--
-- TOC entry 3583 (class 2606 OID 385770)
-- Name: precios_base id_paquete_pb_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.precios_base
    ADD CONSTRAINT id_paquete_pb_fk FOREIGN KEY (id_paquete) REFERENCES _comun.paquete(id);


--
-- TOC entry 3576 (class 2606 OID 385705)
-- Name: cargo_fijo id_turno_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.cargo_fijo
    ADD CONSTRAINT id_turno_fk FOREIGN KEY (id_turno) REFERENCES _comun.turnos(id);


--
-- TOC entry 3584 (class 2606 OID 385775)
-- Name: precios_base id_turno_pb_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.precios_base
    ADD CONSTRAINT id_turno_pb_fk FOREIGN KEY (id_turno) REFERENCES _comun.turnos(id);


--
-- TOC entry 3593 (class 2606 OID 385921)
-- Name: reporte_estado_resultado id_usuario_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_estado_resultado
    ADD CONSTRAINT id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES _auth.users(id);


--
-- TOC entry 3594 (class 2606 OID 385926)
-- Name: reporte_estado_resultado id_zona_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_estado_resultado
    ADD CONSTRAINT id_zona_fk FOREIGN KEY (paquete, zona) REFERENCES _comun.paquete(id, id_zonal);


--
-- TOC entry 3604 (class 2606 OID 386014)
-- Name: reporte_jornada patente_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada
    ADD CONSTRAINT patente_fk FOREIGN KEY (patente) REFERENCES _comun.camionetas(patente);


--
-- TOC entry 3598 (class 2606 OID 385970)
-- Name: reporte_eventos rut_ay_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT rut_ay_fk FOREIGN KEY (rut_ayudante) REFERENCES _auth.personas(rut);


--
-- TOC entry 3599 (class 2606 OID 385975)
-- Name: reporte_eventos rut_ma_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT rut_ma_fk FOREIGN KEY (rut_maestro) REFERENCES _auth.personas(rut);


--
-- TOC entry 3605 (class 2606 OID 386019)
-- Name: reporte_jornada ruta_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada
    ADD CONSTRAINT ruta_fk FOREIGN KEY (rut_ayudante) REFERENCES _auth.personas(rut);


--
-- TOC entry 3606 (class 2606 OID 386024)
-- Name: reporte_jornada rutm_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_jornada
    ADD CONSTRAINT rutm_fk FOREIGN KEY (rut_maestro) REFERENCES _auth.personas(rut);


--
-- TOC entry 3600 (class 2606 OID 385980)
-- Name: reporte_eventos tipo_evt_fk; Type: FK CONSTRAINT; Schema: sae; Owner: postgres
--

ALTER TABLE ONLY sae.reporte_eventos
    ADD CONSTRAINT tipo_evt_fk FOREIGN KEY (tipo_evento) REFERENCES _comun.eventos_tipo(codigo);


--
-- TOC entry 3896 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2023-10-23 12:46:03

--
-- PostgreSQL database dump complete
--

