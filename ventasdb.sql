--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.1

-- Started on 2019-05-24 22:29:07

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
-- TOC entry 229 (class 1255 OID 16651)
-- Name: sp_ciudad(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_ciudad(ban integer, vcod integer, pagina character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select idciudad into repetido from ciudad where idciudad = vcod;

		if found then
		
			mensaje = 'El codigo de ciudad  <strong>'||idciudad||'</strong> ya esta registrado';
		else
			INSERT INTO ciudad
			    VALUES ((select coalesce(max(idciudad),0)+1 from ciudad)
			    ,pagina);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select idciudad into repetido from ciudad where desc_ciudad=pagina and idciudad = vcod;

		if found then

			mensaje = 'El nombre de la ciudad  <strong>'||pagina||'</strong> ya esta registrado';

		else
			UPDATE ciudad
			SET idciudad = vcod ,
			desc_ciudad = pagina
			
			
			WHERE idciudad=vcod;
			
			mensaje = 'Modificado Exitosamente';


		end if;
when 3 then
	delete from ciudad
	WHERE idciudad=vcod;

mensaje = 'Borrado Exitosamente';	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_ciudad(ban integer, vcod integer, pagina character varying) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 24851)
-- Name: sp_cliente(integer, integer, character varying, character varying, integer, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_cliente(ban integer, vcod integer, vnombre character varying, vapellido character varying, vidciudad integer, vdireccion character varying, vedad integer, vdocumento integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select documento into repetido from cliente where documento = vdocumento;

		if found then
		
			mensaje = 'El cliente con Nro Doc  <strong>'||repetido||'</strong> ya esta registrado';
		else
			INSERT INTO cliente
                  VALUES ((select coalesce(max(cod_cliente),0)+1 from cliente),
                  vnombre,
                  vapellido,
                  vidciudad,
                  vdireccion,
                  vedad,
                  vdocumento
                );

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		--select cod_cliente into repetido from cliente a where a.documento = vdocumento and cod_cliente = vcod;

		if found then

			mensaje = 'El nombre del cliente  <strong>'||vnombre||'</strong> ya esta registrado';

		else
			UPDATE cliente
			SET cod_cliente = vcod ,
			nombre = vnombre,
            apellido = vapellido,
			cod_ciudad = vidciudad,
            direccion = vdireccion,
            edad = vedad,
            documento = vdocumento
			
			WHERE cod_cliente=vcod;
			
			mensaje = 'Modificado Exitosamente';


		end if;
when 3 then
	delete from cliente
	WHERE cod_cliente=vcod;

mensaje = 'Borrado Exitosamente';	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_cliente(ban integer, vcod integer, vnombre character varying, vapellido character varying, vidciudad integer, vdireccion character varying, vedad integer, vdocumento integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 16421)
-- Name: ciudad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudad (
    idciudad integer NOT NULL,
    desc_ciudad character varying(50) NOT NULL
);


ALTER TABLE public.ciudad OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16424)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    cod_cliente integer NOT NULL,
    nombre character(50) NOT NULL,
    apellido character(50) NOT NULL,
    cod_ciudad integer NOT NULL,
    direccion character varying(140) NOT NULL,
    edad integer NOT NULL,
    documento integer NOT NULL
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16427)
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca (
    cod_marca integer NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.marca OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16590)
-- Name: modulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modulo (
    id_modulo integer NOT NULL,
    desc_modulo character(50) NOT NULL
);


ALTER TABLE public.modulo OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16595)
-- Name: paginas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paginas (
    pag_cod integer NOT NULL,
    pag_direc character varying NOT NULL,
    pag_nombre character varying NOT NULL,
    id_modulo integer NOT NULL
);


ALTER TABLE public.paginas OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16525)
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    gru_cod integer NOT NULL,
    desc_perfil character varying(20) NOT NULL
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16603)
-- Name: permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permisos (
    pag_cod integer NOT NULL,
    leer boolean NOT NULL,
    insertar boolean NOT NULL,
    editar boolean NOT NULL,
    borrar boolean NOT NULL,
    gru_cod integer
);


ALTER TABLE public.permisos OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16430)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    cod_producto integer NOT NULL,
    nombre "char" NOT NULL,
    cod_marca integer NOT NULL,
    cod_impuesto integer NOT NULL,
    cod_tipo_producto integer NOT NULL,
    descripcion character varying(100) NOT NULL,
    precio numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    estado boolean NOT NULL
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24847)
-- Name: repetido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.repetido (
    cod_cliente integer
);


ALTER TABLE public.repetido OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16530)
-- Name: sucursal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sucursal (
    cod_sucursal integer NOT NULL,
    suc_nombre character varying(20) NOT NULL,
    suc_direccion character varying(50) NOT NULL,
    suc_tel character varying(15) NOT NULL
);


ALTER TABLE public.sucursal OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16433)
-- Name: tipo_comprobante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_comprobante (
    cod_tipo_comprobante integer NOT NULL,
    nombre "char" NOT NULL
);


ALTER TABLE public.tipo_comprobante OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16436)
-- Name: tipo_impuestos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_impuestos (
    cod_impuesto integer NOT NULL,
    nombre character varying(15) NOT NULL,
    porcentaje numeric(3,0) NOT NULL
);


ALTER TABLE public.tipo_impuestos OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16439)
-- Name: tipo_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_producto (
    cod_tipo_producto integer NOT NULL,
    nombre character varying(15) NOT NULL
);


ALTER TABLE public.tipo_producto OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16535)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    usu_cod integer NOT NULL,
    usu_nick character(20) NOT NULL,
    id_perfil integer NOT NULL,
    usu_nombres character(20) NOT NULL,
    usu_estado character(20) NOT NULL,
    cod_suc integer NOT NULL,
    usu_clave character(20) NOT NULL,
    gru_cod integer,
    gru_nombre character(30)
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16647)
-- Name: v_ciudad; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_ciudad AS
 SELECT a.idciudad,
    a.desc_ciudad
   FROM public.ciudad a;


ALTER TABLE public.v_ciudad OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24839)
-- Name: v_cliente; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_cliente AS
 SELECT a.cod_cliente,
    a.apellido,
    a.nombre,
    ( SELECT ciudad.desc_ciudad
           FROM public.ciudad
          WHERE (ciudad.idciudad = a.cod_ciudad)) AS desc_ciudad,
    a.documento,
    a.edad,
    a.direccion
   FROM public.cliente a;


ALTER TABLE public.v_cliente OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16641)
-- Name: v_permisos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_permisos AS
 SELECT a.pag_cod,
    b.pag_direc,
    b.pag_nombre,
    b.id_modulo AS mod_cod,
    c.desc_modulo AS mod_nombre,
    a.gru_cod,
    d.desc_perfil AS gru_nombre,
    a.leer,
    a.insertar,
    a.editar,
    a.borrar
   FROM (((public.permisos a
     JOIN public.paginas b ON ((b.pag_cod = a.pag_cod)))
     JOIN public.modulo c ON ((c.id_modulo = b.id_modulo)))
     JOIN public.perfil d ON ((d.gru_cod = a.gru_cod)));


ALTER TABLE public.v_permisos OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16633)
-- Name: v_usuarios; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_usuarios AS
 SELECT a.usu_cod,
    a.usu_nick,
    a.usu_nombres,
    a.usu_clave,
    a.id_perfil AS gru_cod,
    b.desc_perfil AS gru_nombre,
    a.usu_estado
   FROM public.usuarios a,
    public.perfil b;


ALTER TABLE public.v_usuarios OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16442)
-- Name: venta_cabecera; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta_cabecera (
    cod_venta_cabecera integer NOT NULL,
    nro numeric(10,0) NOT NULL,
    cod_cliente integer NOT NULL,
    fecha date NOT NULL,
    direccion character varying(15) NOT NULL,
    ruc character varying(10) NOT NULL,
    sub_total numeric(15,0) NOT NULL,
    total numeric(15,0) NOT NULL,
    cod_impuesto integer NOT NULL,
    cod_tipo_comprobante integer NOT NULL,
    total_iva_10 numeric(10,0) NOT NULL,
    total_iva_5 numeric(10,0) NOT NULL,
    usu_cod integer NOT NULL
);


ALTER TABLE public.venta_cabecera OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16445)
-- Name: venta_detalles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta_detalles (
    cod_venta_detalle integer NOT NULL,
    cod_venta_cabecera integer NOT NULL,
    cod_producto integer NOT NULL,
    catidad numeric(10,0) NOT NULL
);


ALTER TABLE public.venta_detalles OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16620)
-- Name: vfecha; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vfecha AS
 SELECT to_char((('now'::text)::date)::timestamp with time zone, 'TMDay, DD, "del" yyyy'::text) AS fecha;


ALTER TABLE public.vfecha OWNER TO postgres;

--
-- TOC entry 2950 (class 0 OID 16421)
-- Dependencies: 196
-- Data for Name: ciudad; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ciudad VALUES (1, 'Capiata');
INSERT INTO public.ciudad VALUES (3, 'Asuncion');
INSERT INTO public.ciudad VALUES (4, 'Ñemby');
INSERT INTO public.ciudad VALUES (5, 'Luque');
INSERT INTO public.ciudad VALUES (6, 'San Lorenzo');
INSERT INTO public.ciudad VALUES (7, 'Paraguari');
INSERT INTO public.ciudad VALUES (9, 'San Lorenzo');


--
-- TOC entry 2951 (class 0 OID 16424)
-- Dependencies: 197
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cliente VALUES (1, 'Juan Daniel                                       ', 'Fretes Cantero                                    ', 4, 'Ruta 1 km 21 - porvenir don luis', 24, 5454334);
INSERT INTO public.cliente VALUES (2, 'Thanos                                            ', 'Thanitos                                          ', 5, 'Planeta titan', 2000, 1234325435);


--
-- TOC entry 2952 (class 0 OID 16427)
-- Dependencies: 198
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.marca VALUES (1, 'Apple');


--
-- TOC entry 2962 (class 0 OID 16590)
-- Dependencies: 208
-- Data for Name: modulo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.modulo VALUES (1, 'Parametros iniciales                              ');
INSERT INTO public.modulo VALUES (2, 'Venta                                             ');


--
-- TOC entry 2963 (class 0 OID 16595)
-- Dependencies: 209
-- Data for Name: paginas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paginas VALUES (1, 'ciudad_index.php', 'Ciudades', 1);
INSERT INTO public.paginas VALUES (2, 'cliente_index.php', 'Clientes', 1);
INSERT INTO public.paginas VALUES (3, 'venta_index.php', 'Ventas', 2);


--
-- TOC entry 2959 (class 0 OID 16525)
-- Dependencies: 205
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.perfil VALUES (1, 'admin');


--
-- TOC entry 2964 (class 0 OID 16603)
-- Dependencies: 210
-- Data for Name: permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.permisos VALUES (1, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (2, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (3, true, true, true, true, 1);


--
-- TOC entry 2953 (class 0 OID 16430)
-- Dependencies: 199
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.producto VALUES (1, 'I', 1, 1, 1, '8 ram, 64 gb', 3000000.00, 13, true);
INSERT INTO public.producto VALUES (2, 'I', 1, 1, 1, '3 ram, 128gb', 5000000.00, 12, true);


--
-- TOC entry 2965 (class 0 OID 24847)
-- Dependencies: 216
-- Data for Name: repetido; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.repetido VALUES (1);


--
-- TOC entry 2960 (class 0 OID 16530)
-- Dependencies: 206
-- Data for Name: sucursal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sucursal VALUES (1, 'Asuncion', 'Palma 633
1711 Asunción
Paraguay
', ' +595 985 329 5');


--
-- TOC entry 2954 (class 0 OID 16433)
-- Dependencies: 200
-- Data for Name: tipo_comprobante; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_comprobante VALUES (1, 'T');


--
-- TOC entry 2955 (class 0 OID 16436)
-- Dependencies: 201
-- Data for Name: tipo_impuestos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_impuestos VALUES (2, 'Iva 10%', 10);
INSERT INTO public.tipo_impuestos VALUES (1, 'Iva 5%', 5);


--
-- TOC entry 2956 (class 0 OID 16439)
-- Dependencies: 202
-- Data for Name: tipo_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_producto VALUES (1, 'celulares');


--
-- TOC entry 2961 (class 0 OID 16535)
-- Dependencies: 207
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios VALUES (1, 'juanda              ', 1, 'Juan Fretes
        ', '1                   ', 1, 'juanda22            ', 1, 'Grupo de ventas               ');


--
-- TOC entry 2957 (class 0 OID 16442)
-- Dependencies: 203
-- Data for Name: venta_cabecera; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.venta_cabecera VALUES (1, 1, 1, '2019-05-23', 'Asuncion carmel', '5454334-7', 100000, 100000, 1, 1, 1000, 0, 1);
INSERT INTO public.venta_cabecera VALUES (2, 2, 2, '2019-05-23', 'Shoping asa', '76776776-2', 100000, 100000, 1, 1, 1000, 0, 1);


--
-- TOC entry 2958 (class 0 OID 16445)
-- Dependencies: 204
-- Data for Name: venta_detalles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.venta_detalles VALUES (1, 1, 1, 2);
INSERT INTO public.venta_detalles VALUES (2, 1, 2, 3);
INSERT INTO public.venta_detalles VALUES (3, 2, 1, 4);


--
-- TOC entry 2767 (class 2606 OID 16449)
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (idciudad);


--
-- TOC entry 2769 (class 2606 OID 16451)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cod_cliente);


--
-- TOC entry 2772 (class 2606 OID 16453)
-- Name: marca marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (cod_marca);


--
-- TOC entry 2803 (class 2606 OID 16594)
-- Name: modulo modulo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT modulo_pkey PRIMARY KEY (id_modulo);


--
-- TOC entry 2806 (class 2606 OID 16602)
-- Name: paginas paginas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paginas
    ADD CONSTRAINT paginas_pkey PRIMARY KEY (pag_cod);


--
-- TOC entry 2795 (class 2606 OID 16529)
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (gru_cod);


--
-- TOC entry 2808 (class 2606 OID 16607)
-- Name: permisos permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (pag_cod);


--
-- TOC entry 2777 (class 2606 OID 16455)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (cod_producto);


--
-- TOC entry 2797 (class 2606 OID 16534)
-- Name: sucursal sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (cod_sucursal);


--
-- TOC entry 2779 (class 2606 OID 16484)
-- Name: tipo_comprobante tipo_comprobante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_comprobante
    ADD CONSTRAINT tipo_comprobante_pkey PRIMARY KEY (cod_tipo_comprobante);


--
-- TOC entry 2781 (class 2606 OID 16457)
-- Name: tipo_impuestos tipo_impuestos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_impuestos
    ADD CONSTRAINT tipo_impuestos_pkey PRIMARY KEY (cod_impuesto);


--
-- TOC entry 2783 (class 2606 OID 16459)
-- Name: tipo_producto tipo_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_producto
    ADD CONSTRAINT tipo_producto_pkey PRIMARY KEY (cod_tipo_producto);


--
-- TOC entry 2801 (class 2606 OID 16539)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usu_cod);


--
-- TOC entry 2789 (class 2606 OID 16506)
-- Name: venta_cabecera venta_cabecera_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_cabecera
    ADD CONSTRAINT venta_cabecera_pkey PRIMARY KEY (cod_venta_cabecera);


--
-- TOC entry 2793 (class 2606 OID 16504)
-- Name: venta_detalles venta_detalles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT venta_detalles_pkey PRIMARY KEY (cod_venta_detalle);


--
-- TOC entry 2770 (class 1259 OID 16460)
-- Name: fki_cod_ciudad_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_ciudad_fk ON public.cliente USING btree (cod_ciudad);


--
-- TOC entry 2784 (class 1259 OID 16490)
-- Name: fki_cod_cliente_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_cliente_fk ON public.venta_cabecera USING btree (cod_cliente);


--
-- TOC entry 2773 (class 1259 OID 16461)
-- Name: fki_cod_impuesto_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_impuesto_fk ON public.producto USING btree (cod_impuesto);


--
-- TOC entry 2774 (class 1259 OID 16462)
-- Name: fki_cod_marca_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_marca_fk ON public.producto USING btree (cod_marca);


--
-- TOC entry 2790 (class 1259 OID 16518)
-- Name: fki_cod_producto_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_producto_fk ON public.venta_detalles USING btree (cod_producto);


--
-- TOC entry 2798 (class 1259 OID 16556)
-- Name: fki_cod_suc_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_suc_fk ON public.usuarios USING btree (cod_suc);


--
-- TOC entry 2785 (class 1259 OID 16502)
-- Name: fki_cod_tipo_comprobante_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_tipo_comprobante_fk ON public.venta_cabecera USING btree (cod_tipo_comprobante);


--
-- TOC entry 2786 (class 1259 OID 16496)
-- Name: fki_cod_tipo_impuestos_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_tipo_impuestos_fk ON public.venta_cabecera USING btree (cod_venta_cabecera);


--
-- TOC entry 2775 (class 1259 OID 16524)
-- Name: fki_cod_tipo_producto_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_tipo_producto_fk ON public.producto USING btree (cod_tipo_producto);


--
-- TOC entry 2791 (class 1259 OID 16512)
-- Name: fki_cod_venta_cabecera_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_venta_cabecera_fk ON public.venta_detalles USING btree (cod_venta_cabecera);


--
-- TOC entry 2804 (class 1259 OID 16613)
-- Name: fki_id_modulo_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_modulo_fk ON public.paginas USING btree (id_modulo);


--
-- TOC entry 2799 (class 1259 OID 16545)
-- Name: fki_id_perfil_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_perfil_fk ON public.usuarios USING btree (id_perfil);


--
-- TOC entry 2787 (class 1259 OID 16589)
-- Name: fki_usu_cod_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_usu_cod_fk ON public.venta_cabecera USING btree (usu_cod);


--
-- TOC entry 2809 (class 2606 OID 16463)
-- Name: cliente cod_ciudad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cod_ciudad_fk FOREIGN KEY (cod_ciudad) REFERENCES public.ciudad(idciudad);


--
-- TOC entry 2814 (class 2606 OID 16485)
-- Name: venta_cabecera cod_cliente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_cabecera
    ADD CONSTRAINT cod_cliente_fk FOREIGN KEY (cod_cliente) REFERENCES public.cliente(cod_cliente);


--
-- TOC entry 2810 (class 2606 OID 16468)
-- Name: producto cod_impuesto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_impuesto_fk FOREIGN KEY (cod_impuesto) REFERENCES public.tipo_impuestos(cod_impuesto);


--
-- TOC entry 2811 (class 2606 OID 16473)
-- Name: producto cod_marca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_marca_fk FOREIGN KEY (cod_marca) REFERENCES public.marca(cod_marca);


--
-- TOC entry 2819 (class 2606 OID 16513)
-- Name: venta_detalles cod_producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT cod_producto_fk FOREIGN KEY (cod_producto) REFERENCES public.producto(cod_producto);


--
-- TOC entry 2820 (class 2606 OID 16551)
-- Name: usuarios cod_suc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT cod_suc_fk FOREIGN KEY (cod_suc) REFERENCES public.sucursal(cod_sucursal);


--
-- TOC entry 2816 (class 2606 OID 16497)
-- Name: venta_cabecera cod_tipo_comprobante_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_cabecera
    ADD CONSTRAINT cod_tipo_comprobante_fk FOREIGN KEY (cod_tipo_comprobante) REFERENCES public.tipo_comprobante(cod_tipo_comprobante);


--
-- TOC entry 2812 (class 2606 OID 16478)
-- Name: producto cod_tipo_impuesto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_tipo_impuesto_fk FOREIGN KEY (cod_impuesto) REFERENCES public.tipo_impuestos(cod_impuesto);


--
-- TOC entry 2815 (class 2606 OID 16491)
-- Name: venta_cabecera cod_tipo_impuestos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_cabecera
    ADD CONSTRAINT cod_tipo_impuestos_fk FOREIGN KEY (cod_venta_cabecera) REFERENCES public.tipo_impuestos(cod_impuesto);


--
-- TOC entry 2813 (class 2606 OID 16519)
-- Name: producto cod_tipo_producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_tipo_producto_fk FOREIGN KEY (cod_tipo_producto) REFERENCES public.tipo_producto(cod_tipo_producto);


--
-- TOC entry 2818 (class 2606 OID 16507)
-- Name: venta_detalles cod_venta_cabecera_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_detalles
    ADD CONSTRAINT cod_venta_cabecera_fk FOREIGN KEY (cod_venta_cabecera) REFERENCES public.venta_cabecera(cod_venta_cabecera);


--
-- TOC entry 2822 (class 2606 OID 16608)
-- Name: paginas id_modulo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paginas
    ADD CONSTRAINT id_modulo_fk FOREIGN KEY (id_modulo) REFERENCES public.modulo(id_modulo);


--
-- TOC entry 2821 (class 2606 OID 16579)
-- Name: usuarios id_perfil_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT id_perfil_fk FOREIGN KEY (id_perfil) REFERENCES public.perfil(gru_cod);


--
-- TOC entry 2823 (class 2606 OID 16624)
-- Name: permisos permisos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_fk FOREIGN KEY (gru_cod) REFERENCES public.perfil(gru_cod);


--
-- TOC entry 2817 (class 2606 OID 16584)
-- Name: venta_cabecera usu_cod_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta_cabecera
    ADD CONSTRAINT usu_cod_fk FOREIGN KEY (usu_cod) REFERENCES public.usuarios(usu_cod);


-- Completed on 2019-05-24 22:29:11

--
-- PostgreSQL database dump complete
--

