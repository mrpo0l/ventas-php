--
-- PostgreSQL database dump
--

-- Dumped from database version 10.8
-- Dumped by pg_dump version 11.1

-- Started on 2019-07-16 20:38:00

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
-- TOC entry 248 (class 1255 OID 16394)
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
-- TOC entry 251 (class 1255 OID 24661)
-- Name: sp_cliente(integer, integer, character varying, character varying, character varying, integer, character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_cliente(ban integer, vcod integer, vnombre character varying, vfecha_nac character varying, vapellido character varying, vidciudad integer, vdireccion character varying, vedad integer, vdocumento integer) RETURNS character varying
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
                  vdocumento,
                  TO_DATE(vfecha_nac, 'dd-mm-yyyy')
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
            documento = vdocumento,
            fecha_nac = TO_DATE(vfecha_nac, 'yyyy-mm-dd')
			
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


ALTER FUNCTION public.sp_cliente(ban integer, vcod integer, vnombre character varying, vfecha_nac character varying, vapellido character varying, vidciudad integer, vdireccion character varying, vedad integer, vdocumento integer) OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 24670)
-- Name: sp_departamentos(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_departamentos(ban integer, vcod integer, vdescripcion character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;
existe integer;

begin

case ban
when 1 then

	select cod_dep into repetido from departamentos where cod_dep = vcod;

		if found then
		
			mensaje = 'El codigo de departamento  <strong>'||cod_dep||'</strong> ya esta registrado';
		else
			INSERT INTO departamentos
			    VALUES ((select coalesce(max(cod_dep),0)+1 from departamentos)
			    ,vdescripcion);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select cod_dep into repetido from departamentos where descripcion=vdescripcion and cod_dep = vcod;

		if found then

			mensaje = 'El nombre de la ciudad  <strong>'||vdescripcion||'</strong> ya esta registrado';

		else
			UPDATE departamentos
			SET cod_dep = vcod ,
			descripcion = vdescripcion
			
			
			WHERE cod_dep=vcod;
			
			mensaje = 'Modificado Exitosamente';


		end if;
when 3 then

      	delete from departamentos
    	WHERE cod_dep=vcod;
		mensaje = 'Borrado Exitosamente';
        
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_departamentos(ban integer, vcod integer, vdescripcion character varying) OWNER TO postgres;

--
-- TOC entry 260 (class 1255 OID 25745)
-- Name: sp_detventas(integer, integer, integer, integer, numeric, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_detventas(ban integer, codven integer, codarti integer, coddepo integer, preciounit numeric, cantidad integer, subtotal integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;
iva integer;
porexe float;
poriva5 float;
poriva10 float;
begin

case ban
when 1 then

	select id_venta into repetido from det_venta where id_articulo = codarti and cod_depo=coddepo and id_venta=codven;

		if found then
		
			mensaje = 'El articulo ya se encuentra agregado en el detalle';
		else
			iva = (select b.porcentaje from producto a join tipo_impuestos b on b.cod_impuesto=a.cod_impuesto where a.cod_producto = codarti);
			if iva = 10 then
			   poriva10 = (preciounit * cantidad);
			end if;
			if iva = 5 then
			   poriva5 = (preciounit * cantidad);
			end if;
			if iva = 0 then
		           porexe = (preciounit * cantidad);
		        end if;
				
			INSERT INTO det_venta
			VALUES (codven,codarti,coddepo,preciounit,cantidad,subtotal,porexe,poriva5,poriva10);

			mensaje = 'Guardado Exitosamente';
		end if;
when 3 then
	delete from det_venta where id_articulo=codarti and cod_depo=coddepo and id_venta=codven;
	mensaje = 'Borrado Exitosamente';
	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_detventas(ban integer, codven integer, codarti integer, coddepo integer, preciounit numeric, cantidad integer, subtotal integer) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 24684)
-- Name: sp_marca(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_marca(ban integer, vcod integer, vnombre character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select cod_marca into repetido from marca where cod_marca = vcod;

		if found then
		
			mensaje = 'El codigo de marca  <strong>'||vcod||'</strong> ya esta registrado';
		else
			INSERT INTO marca
			    VALUES ((select coalesce(max(cod_marca),0)+1 from marca)
			    ,vnombre);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select cod_marca into repetido from marca where nombre=vnombre and cod_marca = vcod ;

		if found then

			mensaje = 'El nombre de la marca  <strong>'||pagina||'</strong> ya esta registrado';

		else
			UPDATE marca
			SET cod_marca = vcod ,
			nombre = vnombre			
			
			WHERE cod_marca=vcod;
			
			mensaje = 'Modificado Exitosamente';


		end if;
when 3 then
    if (SELECT COUNT(*) FROM producto where cod_marca = vcod) > 0 then
    	mensaje = 'La marca que desea eliminar esta siendo usada';
    else
      	delete from marca
	WHERE cod_marca=vcod;
		mensaje = 'Borrado Exitosamente';
    end if;
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_marca(ban integer, vcod integer, vnombre character varying) OWNER TO postgres;

--
-- TOC entry 255 (class 1255 OID 24702)
-- Name: sp_producto(integer, integer, character varying, character varying, integer, integer, integer, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_producto(ban integer, vidproducto integer, vdesc_producto character varying, vestado character varying, vcod_tipo_producto integer, vcod_tipo_impuesto integer, vcod_marca integer, vprecio numeric, vstock numeric) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select nombre into repetido from producto where cod_producto = vidproducto;

		if found then
		
			mensaje = 'El producto  <strong>'||repetido||'</strong> ya esta registrado';
		else
			INSERT INTO producto
			    VALUES ((select coalesce(max(cod_producto),0)+1 from producto),
			  vdesc_producto,
              vcod_marca,
              vcod_tipo_impuesto,
              vcod_tipo_producto,
			  vprecio,
			  vstock,
              vestado);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		--select idproducto into repetido from producto where desc_producto=vdesc_producto and 
		--idproducto = vidproducto and 
		--estado=vestado and 
		--cod_tipo_producto=vcod_tipo_producto and 
		--cod_tipo_impuesto=vcod_tipo_impuesto and 
		--cod_marca=vcod_marca and 
		--precio=vprecio and 
		--stock=vstock;

		if found then

			mensaje = 'El producto  <strong>'||vdesc_producto||'</strong> ya esta registrado';

		else
			UPDATE producto
			SET cod_producto = vidproducto ,
			nombre = vdesc_producto ,
			estado=vestado,
			cod_tipo_producto=vcod_tipo_producto,
			cod_impuesto=vcod_tipo_impuesto,
			cod_marca=vcod_marca,
			precio=vprecio,
			stock=vstock
						
			WHERE cod_producto=vidproducto;
			
			mensaje = 'Modificado Exitosamente';

		end if;
when 3 then
	delete from producto
	WHERE cod_producto=vidproducto;

mensaje = 'Borrado Exitosamente';	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_producto(ban integer, vidproducto integer, vdesc_producto character varying, vestado character varying, vcod_tipo_producto integer, vcod_tipo_impuesto integer, vcod_marca integer, vprecio numeric, vstock numeric) OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 24732)
-- Name: sp_sucursal(integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_sucursal(ban integer, vcod integer, vnombre character varying, vdireccion character varying, vtelefono integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select cod_sucursal into repetido from sucursal where cod_sucursal = vcod;

		if found then
		
			mensaje = 'El codigo de ciudad  <strong>'||vcod||'</strong> ya esta registrado';
		else
			INSERT INTO sucursal
			    VALUES ((select coalesce(max(cod_sucursal),0)+1 from sucursal)
			    ,vnombre,
                vdireccion,
                vtelefono);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select cod_sucursal into repetido from sucursal where suc_nombre=vnombre and cod_sucursal = vcod;

		if found then

			mensaje = 'El nombre de la ciudad  <strong>'||vnombre||'</strong> ya esta registrado';

		else
			UPDATE sucursal
			SET cod_sucursal = vcod ,
			suc_nombre = vnombre,
            suc_direccion = vdireccion,
            suc_tel = vtelefono
			
			
			
			WHERE cod_sucursal=vcod;
			
			mensaje = 'Modificado Exitosamente';

		end if;
when 3 then
	delete from sucursal
	WHERE cod_sucursal=vcod;

mensaje = 'Borrado Exitosamente';	
end case;
return mensaje;
end;

$$;


ALTER FUNCTION public.sp_sucursal(ban integer, vcod integer, vnombre character varying, vdireccion character varying, vtelefono integer) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 24605)
-- Name: sp_tipo_comprobante(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_tipo_comprobante(ban integer, vcod integer, nombre character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;
existe integer;

begin

case ban
when 1 then

	select cod_tipo_comprobante into repetido from tipo_comprobante where cod_tipo_comprobante = vcod;

		if found then
		
			mensaje = 'El codigo de comprobante  <strong>'||cod_tipo_comprobante||'</strong> ya esta registrado';
		else
			INSERT INTO tipo_comprobante
			    VALUES ((select coalesce(max(cod_tipo_comprobante),0)+1 from tipo_comprobante)
			    ,nombre);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select cod_tipo_comprobante into repetido from tipo_comprobante where nombre_comprobante=nombre and cod_tipo_comprobante = vcod;

		if found then

			mensaje = 'El nombre de la ciudad  <strong>'||nombre||'</strong> ya esta registrado';

		else
			UPDATE tipo_comprobante
			SET cod_tipo_comprobante = vcod ,
			nombre_comprobante = nombre
			
			
			WHERE cod_tipo_comprobante=vcod;
			
			mensaje = 'Modificado Exitosamente';


		end if;
when 3 then
	SELECT COUNT(*) INTO existe FROM venta_cabecera where cod_tipo_comprobante = vcod;
    if existe > 0 then
    	mensaje = 'El tipo de comprobante que desea eliminar esta siendo usada';
    else
      	delete from tipo_comprobante
    	WHERE cod_tipo_comprobante=vcod;
		mensaje = 'Borrado Exitosamente';
    end if;
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_tipo_comprobante(ban integer, vcod integer, nombre character varying) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 24736)
-- Name: sp_tipo_impuesto(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_tipo_impuesto(ban integer, vcod integer, vnombre character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select cod_impuesto into repetido from tipo_impuestos where cod_impuesto = vcod;

		if found then
		
			mensaje = 'El codigo del tipo impuesto  <strong>'||vcod||'</strong> ya esta registrado';
		else
			INSERT INTO tipo_impuestos
			    VALUES ((select coalesce(max(cod_impuesto),0)+1 from tipo_impuestos)
			    ,vnombre);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select cod_impuesto into repetido from tipo_impuestos where nombre=vnombre and cod_impuesto = vcod;

		if found then

			mensaje = 'El nombre del tipo de impuesto  <strong>'||vnombre||'</strong> ya esta registrado';

		else
			UPDATE tipo_impuestos
			SET cod_tipo_impuesto = vcod ,
			desc_tipo_impuesto = vnombre 
						
			
			WHERE cod_tipo_impuesto= vcod ;
			
			mensaje = 'Modificado Exitosamente';

		end if;
when 3 then
	delete from tipo_impuestos
	WHERE cod_impuesto = vcod;

mensaje = 'Borrado Exitosamente';	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_tipo_impuesto(ban integer, vcod integer, vnombre character varying) OWNER TO postgres;

--
-- TOC entry 259 (class 1255 OID 24738)
-- Name: sp_tipo_impuesto(integer, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_tipo_impuesto(ban integer, vcod integer, vnombre character varying, vporcentaje integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select cod_impuesto into repetido from tipo_impuestos where cod_impuesto = vcod;

		if found then
		
			mensaje = 'El codigo del tipo impuesto  <strong>'||vcod||'</strong> ya esta registrado';
		else
			INSERT INTO tipo_impuestos
			    VALUES ((select coalesce(max(cod_impuesto),0)+1 from tipo_impuestos)
			    ,vnombre,
                vporcentaje);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select cod_impuesto into repetido from tipo_impuestos where nombre=vnombre and cod_impuesto = vcod;

		if found then

			mensaje = 'El nombre del tipo de impuesto  <strong>'||vnombre||'</strong> ya esta registrado';

		else
			UPDATE tipo_impuestos
			SET cod_impuesto = vcod ,
			nombre = vnombre,
            porcentaje = vporcentaje
						
			
			WHERE cod_impuesto= vcod ;
			
			mensaje = 'Modificado Exitosamente';

		end if;
when 3 then
	delete from tipo_impuestos
	WHERE cod_impuesto = vcod;

mensaje = 'Borrado Exitosamente';	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_tipo_impuesto(ban integer, vcod integer, vnombre character varying, vporcentaje integer) OWNER TO postgres;

--
-- TOC entry 258 (class 1255 OID 24737)
-- Name: sp_tipo_impuesto(integer, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_tipo_impuesto(ban integer, vcod integer, vnombre character varying, vporcentaje character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select cod_impuesto into repetido from tipo_impuestos where cod_impuesto = vcod;

		if found then
		
			mensaje = 'El codigo del tipo impuesto  <strong>'||vcod||'</strong> ya esta registrado';
		else
			INSERT INTO tipo_impuestos
			    VALUES ((select coalesce(max(cod_impuesto),0)+1 from tipo_impuestos)
			    ,vnombre,
                vporcentaje);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select cod_impuesto into repetido from tipo_impuestos where nombre=vnombre and cod_impuesto = vcod;

		if found then

			mensaje = 'El nombre del tipo de impuesto  <strong>'||vnombre||'</strong> ya esta registrado';

		else
			UPDATE tipo_impuestos
			SET cod_impuesto = vcod ,
			nombre = vnombre,
            porcentaje = vporcentaje
						
			
			WHERE cod_impuesto= vcod ;
			
			mensaje = 'Modificado Exitosamente';

		end if;
when 3 then
	delete from tipo_impuestos
	WHERE cod_impuesto = vcod;

mensaje = 'Borrado Exitosamente';	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_tipo_impuesto(ban integer, vcod integer, vnombre character varying, vporcentaje character varying) OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 24733)
-- Name: sp_tipo_producto(integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_tipo_producto(ban integer, vcod integer, vnombre character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
 declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then

	select cod_tipo_producto into repetido from tipo_producto where cod_tipo_producto = vcod;

		if found then
		
			mensaje = 'El codigo del tipo de producto  <strong>'||vcod||'</strong> ya esta registrado';
		else
			INSERT INTO tipo_producto
			    VALUES ((select coalesce(max(cod_tipo_producto),0)+1 from tipo_producto)
			    ,vnombre);

			mensaje = 'Guardado Exitosamente';
		end if;
when 2 then
		select cod_tipo_producto into repetido from tipo_producto where nombre=vnombre and cod_tipo_producto = vcod;

		if found then

			mensaje = 'El nombre de la tipo_producto  <strong>'||vnombre||'</strong> ya esta registrado';

		else
			UPDATE tipo_producto
			SET cod_tipo_producto = vcod ,
			nombre = vnombre 
						
			
			WHERE cod_tipo_producto= vcod ;
			
			mensaje = 'Modificado Exitosamente';

		end if;
when 3 then
	
    
    if (SELECT COUNT(*) FROM tipo_producto where cod_tipo_producto = vcod) > 0 then
    	mensaje = 'El tipo de producto que desea eliminar esta siendo usada';
    else
      	delete from tipo_producto
		WHERE cod_tipo_producto = vcod;
		mensaje = 'Borrado Exitosamente';
    end if;	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_tipo_producto(ban integer, vcod integer, vnombre character varying) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 25748)
-- Name: sp_venta(integer, integer, integer, integer, integer, date, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_venta(ban integer, codven integer, usucod integer, cliente integer, nro_factura integer, fecha date, iva10 integer, iva5 integer, exenta integer, total_factura integer, estado integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then


    
		INSERT INTO venta
		VALUES ((select coalesce(max(idventa),0)+1 from venta), usucod, cliente,  nro_factura, fecha, iva10, iva5, exenta, total_factura, 
		 estado);
	

	mensaje = 'Guardado Exitosamente';

when 2 then

	update venta set idestado = estado where idventa=codven;		
	mensaje = 'Anulado Exitosamente';
	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_venta(ban integer, codven integer, usucod integer, cliente integer, nro_factura integer, fecha date, iva10 integer, iva5 integer, exenta integer, total_factura integer, estado integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 226 (class 1259 OID 25600)
-- Name: articulos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.articulos (
    id_articulo integer NOT NULL,
    mar_cod integer NOT NULL,
    art_descripcion character varying(45) NOT NULL,
    art_precio numeric(12,0) NOT NULL,
    art_imagen character varying(200),
    art_iva integer NOT NULL
);


ALTER TABLE public.articulos OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16396)
-- Name: ciudad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ciudad (
    idciudad integer NOT NULL,
    desc_ciudad character varying(50) NOT NULL
);


ALTER TABLE public.ciudad OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16399)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    cod_cliente integer NOT NULL,
    nombre character(50) NOT NULL,
    apellido character(50) NOT NULL,
    cod_ciudad integer NOT NULL,
    direccion character varying(140) NOT NULL,
    edad integer NOT NULL,
    documento integer NOT NULL,
    fecha_nac date,
    telefono numeric(30,0)
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24665)
-- Name: departamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departamentos (
    cod_dep integer NOT NULL,
    descripcion character varying(150)
);


ALTER TABLE public.departamentos OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25697)
-- Name: deposito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deposito (
    cod_depo integer NOT NULL,
    dep_descrip character varying(45) NOT NULL
);


ALTER TABLE public.deposito OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25717)
-- Name: det_venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.det_venta (
    id_venta integer NOT NULL,
    id_articulo integer NOT NULL,
    cod_depo integer NOT NULL,
    det_precio_unit numeric(12,0) NOT NULL,
    det_cantidad numeric(10,0) NOT NULL,
    det_subtotal integer,
    exenta integer,
    iva5 integer,
    iva10 integer
);


ALTER TABLE public.det_venta OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 25590)
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado (
    idestado integer NOT NULL,
    desc_estado character varying(50)
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24678)
-- Name: existe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.existe (
    count bigint
);


ALTER TABLE public.existe OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16402)
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca (
    cod_marca integer NOT NULL,
    nombre character varying(20) NOT NULL
);


ALTER TABLE public.marca OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24681)
-- Name: marcasenuso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marcasenuso (
    count bigint
);


ALTER TABLE public.marcasenuso OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16405)
-- Name: modulo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modulo (
    id_modulo integer NOT NULL,
    desc_modulo character(50) NOT NULL
);


ALTER TABLE public.modulo OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16408)
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
-- TOC entry 201 (class 1259 OID 16414)
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfil (
    gru_cod integer NOT NULL,
    desc_perfil character varying(20) NOT NULL
);


ALTER TABLE public.perfil OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16417)
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
-- TOC entry 225 (class 1259 OID 25597)
-- Name: presupuesto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.presupuesto (
    codpresupuesto integer NOT NULL,
    fecha date,
    total_presupuesto integer,
    total_iva_10 integer,
    total_iva_5 integer,
    total_exenta integer,
    usu_cod integer,
    id_cliente integer,
    idestado integer
);


ALTER TABLE public.presupuesto OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16420)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    cod_producto integer NOT NULL,
    nombre character(50) NOT NULL,
    cod_marca integer NOT NULL,
    cod_impuesto integer NOT NULL,
    cod_tipo_producto integer NOT NULL,
    precio numeric(10,2) NOT NULL,
    stock integer NOT NULL,
    estado character(10) NOT NULL
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16423)
-- Name: repetido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.repetido (
    cod_cliente integer
);


ALTER TABLE public.repetido OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25702)
-- Name: stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock (
    id_articulo integer NOT NULL,
    cod_depo integer NOT NULL,
    cantidad integer NOT NULL
);


ALTER TABLE public.stock OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16426)
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
-- TOC entry 206 (class 1259 OID 16429)
-- Name: tipo_comprobante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_comprobante (
    cod_tipo_comprobante integer NOT NULL,
    nombre_comprobante character(30) NOT NULL
);


ALTER TABLE public.tipo_comprobante OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16432)
-- Name: tipo_impuestos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_impuestos (
    cod_impuesto integer NOT NULL,
    nombre character varying(15) NOT NULL,
    porcentaje numeric(3,0) NOT NULL
);


ALTER TABLE public.tipo_impuestos OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16435)
-- Name: tipo_producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_producto (
    cod_tipo_producto integer NOT NULL,
    nombre character varying(15) NOT NULL
);


ALTER TABLE public.tipo_producto OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16438)
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
-- TOC entry 210 (class 1259 OID 16441)
-- Name: v_ciudad; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_ciudad AS
 SELECT a.idciudad,
    a.desc_ciudad
   FROM public.ciudad a;


ALTER TABLE public.v_ciudad OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24657)
-- Name: v_cliente; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_cliente AS
 SELECT a.cod_cliente,
    a.apellido,
    a.nombre,
    a.fecha_nac,
    ( SELECT ciudad.desc_ciudad
           FROM public.ciudad
          WHERE (ciudad.idciudad = a.cod_ciudad)) AS desc_ciudad,
    a.documento,
    a.edad,
    a.direccion
   FROM public.cliente a;


ALTER TABLE public.v_cliente OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 25732)
-- Name: v_detventas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_detventas AS
 SELECT a.id_venta,
    a.id_articulo,
    a.cod_depo,
    a.det_precio_unit,
    a.det_cantidad,
    b.nombre AS desc_producto,
    c.dep_descrip,
    a.det_subtotal,
    a.exenta,
    a.iva5,
    a.iva10
   FROM public.det_venta a,
    public.producto b,
    public.deposito c
  WHERE ((a.id_articulo = b.cod_producto) AND (a.cod_depo = c.cod_depo));


ALTER TABLE public.v_detventas OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24672)
-- Name: v_marca; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_marca AS
 SELECT a.cod_marca,
    a.nombre
   FROM public.marca a;


ALTER TABLE public.v_marca OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16449)
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
-- TOC entry 230 (class 1259 OID 25691)
-- Name: v_presupuesto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_presupuesto AS
 SELECT a.codpresupuesto,
    to_char((a.fecha)::timestamp with time zone, 'DD/MM/YYYY'::text) AS fecha,
    a.id_cliente,
    b.usu_nombres,
    (((c.nombre)::text || ' '::text) || (c.apellido)::text) AS cliente,
    a.total_presupuesto,
    a.total_iva_10,
    a.total_iva_5,
    a.total_exenta,
    a.idestado,
    c.cod_cliente,
    c.direccion,
    c.telefono,
    d.desc_estado
   FROM (((public.presupuesto a
     JOIN public.usuarios b ON ((b.usu_cod = a.usu_cod)))
     JOIN public.cliente c ON ((c.cod_cliente = a.id_cliente)))
     JOIN public.estado d ON ((d.idestado = a.idestado)));


ALTER TABLE public.v_presupuesto OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24722)
-- Name: v_producto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_producto AS
 SELECT a.cod_producto AS idproducto,
    a.nombre AS desc_producto,
    a.estado,
    a.cod_tipo_producto,
    a.cod_impuesto AS cod_tipo_impuesto,
    a.cod_marca,
    a.precio,
    a.stock,
    b.nombre AS desc_tipo_producto,
    c.nombre AS desc_tipo_impuesto,
    c.porcentaje AS valor_tipo_impuesto,
    d.nombre AS desc_marca
   FROM (((public.producto a
     JOIN public.tipo_producto b ON ((a.cod_tipo_producto = b.cod_tipo_producto)))
     JOIN public.tipo_impuestos c ON ((a.cod_impuesto = c.cod_impuesto)))
     JOIN public.marca d ON ((a.cod_marca = d.cod_marca)));


ALTER TABLE public.v_producto OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 25741)
-- Name: v_stock; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_stock AS
 SELECT a.cod_producto AS idproducto,
    a.stock AS stock_actual,
    a.nombre AS desc_producto,
    a.precio,
    b.cantidad
   FROM (public.producto a
     JOIN public.stock b ON ((b.id_articulo = a.cod_producto)));


ALTER TABLE public.v_stock OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24727)
-- Name: v_sucursal; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_sucursal WITH (security_barrier='false') AS
 SELECT a.cod_sucursal,
    a.suc_nombre,
    a.suc_direccion,
    a.suc_tel
   FROM public.sucursal a;


ALTER TABLE public.v_sucursal OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24696)
-- Name: v_tipo_impuesto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_tipo_impuesto AS
 SELECT a.cod_impuesto AS cod_tipo_impuesto,
    a.nombre AS desc_tipo_impuesto,
    a.porcentaje AS valor_tipo_impuesto
   FROM public.tipo_impuestos a;


ALTER TABLE public.v_tipo_impuesto OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24692)
-- Name: v_tipo_producto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_tipo_producto AS
 SELECT a.cod_tipo_producto,
    a.nombre AS desc_tipo_producto
   FROM public.tipo_producto a;


ALTER TABLE public.v_tipo_producto OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24601)
-- Name: v_tipos_comprobantes; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_tipos_comprobantes AS
 SELECT a.cod_tipo_comprobante,
    a.nombre_comprobante
   FROM public.tipo_comprobante a;


ALTER TABLE public.v_tipos_comprobantes OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16454)
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
-- TOC entry 228 (class 1259 OID 25674)
-- Name: ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventas (
    id_venta integer NOT NULL,
    usu_cod integer,
    id_cliente integer NOT NULL,
    ven_fecha date NOT NULL,
    ven_condicion character varying(45) NOT NULL,
    ven_total numeric(12,0) NOT NULL,
    ven_estado character varying(20) DEFAULT 'Activo'::character varying NOT NULL,
    cant_cuo integer DEFAULT 1
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25686)
-- Name: v_ventas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_ventas AS
 SELECT a.id_venta,
    a.id_cliente,
    a.ven_fecha,
    to_char((a.ven_fecha)::timestamp with time zone, 'DD/MM/YYYY'::text) AS fecha,
    to_char((a.ven_fecha)::timestamp with time zone, 'TMDay, DD "de" TMMonth "del" yyyy'::text) AS fecdate,
    a.ven_condicion,
    a.ven_estado,
    a.ven_total,
    a.usu_cod,
    (((b.nombre)::text || ' '::text) || (b.apellido)::text) AS cliente,
    c.usu_nombres,
    b.direccion AS cli_direccion,
    b.documento AS cli_ci,
    b.telefono AS cli_telefono,
    ((((btrim(to_char(1, '000'::text)) || '-'::text) || btrim(to_char(1, '000'::text))) || '-'::text) || btrim(to_char(a.id_venta, '0000000'::text))) AS factura
   FROM public.ventas a,
    public.cliente b,
    public.usuarios c
  WHERE ((a.id_cliente = b.cod_cliente) AND (a.usu_cod = c.usu_cod));


ALTER TABLE public.v_ventas OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25644)
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta (
    idventa integer NOT NULL,
    cod_usu integer NOT NULL,
    id_cliente integer NOT NULL,
    nro_factura integer NOT NULL,
    fecha date,
    total_iva_10 integer NOT NULL,
    total_iva_5 integer NOT NULL,
    total_exenta integer NOT NULL,
    total_factura_venta integer NOT NULL,
    idestado integer
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16464)
-- Name: vfecha; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vfecha AS
 SELECT to_char((('now'::text)::date)::timestamp with time zone, 'TMDay, DD, "del" yyyy'::text) AS fecha;


ALTER TABLE public.vfecha OWNER TO postgres;

--
-- TOC entry 3064 (class 0 OID 25600)
-- Dependencies: 226
-- Data for Name: articulos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.articulos VALUES (1, 1, 'descripcion del articulo', 2000000, 'https://www.miaparato.es/file/2019/01/Xiaomi-Redmi-Note-7-.jpg', 1);


--
-- TOC entry 3045 (class 0 OID 16396)
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
-- TOC entry 3046 (class 0 OID 16399)
-- Dependencies: 197
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cliente VALUES (1, 'Juan Daniel                                       ', 'Fretes Cantero                                    ', 4, 'Ruta 1 km 21 - porvenir don luis', 24, 5454334, '1995-05-22', NULL);
INSERT INTO public.cliente VALUES (2, 'Thanos                                            ', 'Thanitos                                          ', 5, 'Planeta titan', 2000, 1234325435, '2018-11-12', NULL);
INSERT INTO public.cliente VALUES (3, 'Daft                                              ', 'Punk                                              ', 3, 'De otro mundo', 45, 12345, '2019-06-10', NULL);


--
-- TOC entry 3059 (class 0 OID 24665)
-- Dependencies: 216
-- Data for Name: departamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departamentos VALUES (5, 'Canindeyu');
INSERT INTO public.departamentos VALUES (6, 'prueba');
INSERT INTO public.departamentos VALUES (4, 'Central');
INSERT INTO public.departamentos VALUES (7, 'Prueba 2');
INSERT INTO public.departamentos VALUES (3, 'Paraguari123');


--
-- TOC entry 3067 (class 0 OID 25697)
-- Dependencies: 231
-- Data for Name: deposito; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.deposito VALUES (1, 'Deposito 1');
INSERT INTO public.deposito VALUES (2, 'Deposito 2');


--
-- TOC entry 3069 (class 0 OID 25717)
-- Dependencies: 233
-- Data for Name: det_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.det_venta VALUES (1, 1, 1, 2000000, 2, 4000000, NULL, NULL, 4000000);
INSERT INTO public.det_venta VALUES (1, 2, 1, 5000000, 1, 5000000, NULL, NULL, 5000000);


--
-- TOC entry 3062 (class 0 OID 25590)
-- Dependencies: 224
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.estado VALUES (1, 'Activo');
INSERT INTO public.estado VALUES (2, 'Anulado');


--
-- TOC entry 3060 (class 0 OID 24678)
-- Dependencies: 218
-- Data for Name: existe; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.existe VALUES (2);


--
-- TOC entry 3047 (class 0 OID 16402)
-- Dependencies: 198
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.marca VALUES (1, 'Apple');
INSERT INTO public.marca VALUES (2, 'Xiaomi');
INSERT INTO public.marca VALUES (3, 'Oppo');
INSERT INTO public.marca VALUES (5, 'Nokia');
INSERT INTO public.marca VALUES (4, 'Sony');


--
-- TOC entry 3061 (class 0 OID 24681)
-- Dependencies: 219
-- Data for Name: marcasenuso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.marcasenuso VALUES (2);


--
-- TOC entry 3048 (class 0 OID 16405)
-- Dependencies: 199
-- Data for Name: modulo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.modulo VALUES (1, 'Parametros iniciales                              ');
INSERT INTO public.modulo VALUES (2, 'Venta                                             ');


--
-- TOC entry 3049 (class 0 OID 16408)
-- Dependencies: 200
-- Data for Name: paginas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paginas VALUES (1, 'ciudad_index.php', 'Ciudades', 1);
INSERT INTO public.paginas VALUES (2, 'cliente_index.php', 'Clientes', 1);
INSERT INTO public.paginas VALUES (3, 'venta_index.php', 'Ventas', 2);
INSERT INTO public.paginas VALUES (4, 'tipo_comprobante_index.php', 'Tipos Comprobantes', 1);
INSERT INTO public.paginas VALUES (5, 'departamentos_index.php', 'Departamentos', 1);
INSERT INTO public.paginas VALUES (6, 'marca_index.php', 'Marcas', 1);
INSERT INTO public.paginas VALUES (7, 'producto_index.php', 'Productos', 1);
INSERT INTO public.paginas VALUES (9, 'tipo_impuesto_index.php', 'Tpos Inpuestos', 1);
INSERT INTO public.paginas VALUES (10, 'tipo_producto_index.php', 'Tipo Productos', 1);
INSERT INTO public.paginas VALUES (8, 'sucursal_index.php', 'Sucursales', 1);


--
-- TOC entry 3050 (class 0 OID 16414)
-- Dependencies: 201
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.perfil VALUES (1, 'admin');


--
-- TOC entry 3051 (class 0 OID 16417)
-- Dependencies: 202
-- Data for Name: permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.permisos VALUES (1, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (2, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (3, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (4, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (5, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (6, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (7, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (8, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (9, true, true, true, true, 1);
INSERT INTO public.permisos VALUES (10, true, true, true, true, 1);


--
-- TOC entry 3063 (class 0 OID 25597)
-- Dependencies: 225
-- Data for Name: presupuesto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.presupuesto VALUES (1, '2019-07-13', 0, 0, 0, 0, 1, 1, 1);


--
-- TOC entry 3052 (class 0 OID 16420)
-- Dependencies: 203
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.producto VALUES (4, 'Redmi note 7 pro                                  ', 1, 2, 1, 3000000.00, 30, 'nuevo     ');
INSERT INTO public.producto VALUES (1, 'Iphone 7                                          ', 1, 2, 1, 2000000.00, 13, 'true      ');
INSERT INTO public.producto VALUES (2, 'Iphone X                                          ', 1, 2, 1, 5000000.00, 12, 'true      ');


--
-- TOC entry 3053 (class 0 OID 16423)
-- Dependencies: 204
-- Data for Name: repetido; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.repetido VALUES (1);


--
-- TOC entry 3068 (class 0 OID 25702)
-- Dependencies: 232
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stock VALUES (1, 1, 20);
INSERT INTO public.stock VALUES (2, 1, 11);


--
-- TOC entry 3054 (class 0 OID 16426)
-- Dependencies: 205
-- Data for Name: sucursal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sucursal VALUES (1, 'Asuncion', 'Palma 633
1711 Asunción
Paraguay
', ' +595 985 329 5');


--
-- TOC entry 3055 (class 0 OID 16429)
-- Dependencies: 206
-- Data for Name: tipo_comprobante; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_comprobante VALUES (1, 'Factura                       ');
INSERT INTO public.tipo_comprobante VALUES (2, 'Ticket                        ');


--
-- TOC entry 3056 (class 0 OID 16432)
-- Dependencies: 207
-- Data for Name: tipo_impuestos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_impuestos VALUES (2, 'Iva 10%', 10);
INSERT INTO public.tipo_impuestos VALUES (1, 'Iva 5%', 5);


--
-- TOC entry 3057 (class 0 OID 16435)
-- Dependencies: 208
-- Data for Name: tipo_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_producto VALUES (2, 'Notebook');
INSERT INTO public.tipo_producto VALUES (1, 'celulares');


--
-- TOC entry 3058 (class 0 OID 16438)
-- Dependencies: 209
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios VALUES (1, 'juanda              ', 1, 'Juan Fretes
       ', '1                   ', 1, 'juanda22            ', 1, 'Grupo de ventas               ');


--
-- TOC entry 3065 (class 0 OID 25644)
-- Dependencies: 227
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.venta VALUES (1, 1, 1, 12, '2019-07-13', 0, 0, 0, 0, 1);
INSERT INTO public.venta VALUES (2, 1, 1, 12, '2019-07-17', 0, 0, 0, 0, 1);
INSERT INTO public.venta VALUES (3, 1, 1, 12, '2019-07-17', 0, 0, 0, 0, 1);
INSERT INTO public.venta VALUES (4, 1, 1, 12, '2019-07-17', 0, 0, 0, 0, 1);
INSERT INTO public.venta VALUES (5, 1, 2, 12, '2019-07-17', 0, 0, 0, 0, 1);


--
-- TOC entry 3066 (class 0 OID 25674)
-- Dependencies: 228
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ventas VALUES (1, 1, 1, '2019-07-27', '1', 2000000, 'Activo', 1);


--
-- TOC entry 2880 (class 2606 OID 25604)
-- Name: articulos articulos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos
    ADD CONSTRAINT articulos_pk PRIMARY KEY (id_articulo);


--
-- TOC entry 2841 (class 2606 OID 16469)
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (idciudad);


--
-- TOC entry 2843 (class 2606 OID 16471)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cod_cliente);


--
-- TOC entry 2874 (class 2606 OID 24669)
-- Name: departamentos departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (cod_dep);


--
-- TOC entry 2886 (class 2606 OID 25701)
-- Name: deposito deposito_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposito
    ADD CONSTRAINT deposito_pk PRIMARY KEY (cod_depo);


--
-- TOC entry 2890 (class 2606 OID 25721)
-- Name: det_venta det_venta_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_venta
    ADD CONSTRAINT det_venta_pk PRIMARY KEY (id_venta, id_articulo, cod_depo);


--
-- TOC entry 2876 (class 2606 OID 25621)
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (idestado);


--
-- TOC entry 2846 (class 2606 OID 16473)
-- Name: marca marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (cod_marca);


--
-- TOC entry 2848 (class 2606 OID 16475)
-- Name: modulo modulo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT modulo_pkey PRIMARY KEY (id_modulo);


--
-- TOC entry 2851 (class 2606 OID 16477)
-- Name: paginas paginas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paginas
    ADD CONSTRAINT paginas_pkey PRIMARY KEY (pag_cod);


--
-- TOC entry 2853 (class 2606 OID 16479)
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (gru_cod);


--
-- TOC entry 2855 (class 2606 OID 16481)
-- Name: permisos permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (pag_cod);


--
-- TOC entry 2882 (class 2606 OID 25648)
-- Name: venta pf_venta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT pf_venta PRIMARY KEY (idventa);


--
-- TOC entry 2878 (class 2606 OID 25643)
-- Name: presupuesto presupuesto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presupuesto
    ADD CONSTRAINT presupuesto_pkey PRIMARY KEY (codpresupuesto);


--
-- TOC entry 2860 (class 2606 OID 16483)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (cod_producto);


--
-- TOC entry 2888 (class 2606 OID 25706)
-- Name: stock stock_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pk PRIMARY KEY (id_articulo, cod_depo);


--
-- TOC entry 2862 (class 2606 OID 16485)
-- Name: sucursal sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (cod_sucursal);


--
-- TOC entry 2864 (class 2606 OID 16487)
-- Name: tipo_comprobante tipo_comprobante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_comprobante
    ADD CONSTRAINT tipo_comprobante_pkey PRIMARY KEY (cod_tipo_comprobante);


--
-- TOC entry 2866 (class 2606 OID 16489)
-- Name: tipo_impuestos tipo_impuestos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_impuestos
    ADD CONSTRAINT tipo_impuestos_pkey PRIMARY KEY (cod_impuesto);


--
-- TOC entry 2868 (class 2606 OID 16491)
-- Name: tipo_producto tipo_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_producto
    ADD CONSTRAINT tipo_producto_pkey PRIMARY KEY (cod_tipo_producto);


--
-- TOC entry 2872 (class 2606 OID 16493)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usu_cod);


--
-- TOC entry 2884 (class 2606 OID 25680)
-- Name: ventas ventas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pk PRIMARY KEY (id_venta);


--
-- TOC entry 2844 (class 1259 OID 16498)
-- Name: fki_cod_ciudad_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_ciudad_fk ON public.cliente USING btree (cod_ciudad);


--
-- TOC entry 2856 (class 1259 OID 16500)
-- Name: fki_cod_impuesto_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_impuesto_fk ON public.producto USING btree (cod_impuesto);


--
-- TOC entry 2857 (class 1259 OID 16501)
-- Name: fki_cod_marca_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_marca_fk ON public.producto USING btree (cod_marca);


--
-- TOC entry 2869 (class 1259 OID 16503)
-- Name: fki_cod_suc_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_suc_fk ON public.usuarios USING btree (cod_suc);


--
-- TOC entry 2858 (class 1259 OID 16506)
-- Name: fki_cod_tipo_producto_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_tipo_producto_fk ON public.producto USING btree (cod_tipo_producto);


--
-- TOC entry 2849 (class 1259 OID 16508)
-- Name: fki_id_modulo_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_modulo_fk ON public.paginas USING btree (id_modulo);


--
-- TOC entry 2870 (class 1259 OID 16509)
-- Name: fki_id_perfil_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_perfil_fk ON public.usuarios USING btree (id_perfil);


--
-- TOC entry 2891 (class 2606 OID 16511)
-- Name: cliente cod_ciudad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cod_ciudad_fk FOREIGN KEY (cod_ciudad) REFERENCES public.ciudad(idciudad);


--
-- TOC entry 2894 (class 2606 OID 16521)
-- Name: producto cod_impuesto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_impuesto_fk FOREIGN KEY (cod_impuesto) REFERENCES public.tipo_impuestos(cod_impuesto);


--
-- TOC entry 2895 (class 2606 OID 16526)
-- Name: producto cod_marca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_marca_fk FOREIGN KEY (cod_marca) REFERENCES public.marca(cod_marca);


--
-- TOC entry 2898 (class 2606 OID 16536)
-- Name: usuarios cod_suc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT cod_suc_fk FOREIGN KEY (cod_suc) REFERENCES public.sucursal(cod_sucursal);


--
-- TOC entry 2896 (class 2606 OID 16546)
-- Name: producto cod_tipo_impuesto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_tipo_impuesto_fk FOREIGN KEY (cod_impuesto) REFERENCES public.tipo_impuestos(cod_impuesto);


--
-- TOC entry 2897 (class 2606 OID 16556)
-- Name: producto cod_tipo_producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_tipo_producto_fk FOREIGN KEY (cod_tipo_producto) REFERENCES public.tipo_producto(cod_tipo_producto);


--
-- TOC entry 2905 (class 2606 OID 25707)
-- Name: stock deposito_stock_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT deposito_stock_fk FOREIGN KEY (cod_depo) REFERENCES public.deposito(cod_depo);


--
-- TOC entry 2901 (class 2606 OID 25649)
-- Name: venta fk_cli; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_cli FOREIGN KEY (id_cliente) REFERENCES public.cliente(cod_cliente);


--
-- TOC entry 2902 (class 2606 OID 25654)
-- Name: venta fk_estados; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_estados FOREIGN KEY (idestado) REFERENCES public.estado(idestado);


--
-- TOC entry 2903 (class 2606 OID 25669)
-- Name: venta fk_usuarios; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_usuarios FOREIGN KEY (cod_usu) REFERENCES public.usuarios(usu_cod);


--
-- TOC entry 2892 (class 2606 OID 16566)
-- Name: paginas id_modulo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paginas
    ADD CONSTRAINT id_modulo_fk FOREIGN KEY (id_modulo) REFERENCES public.modulo(id_modulo);


--
-- TOC entry 2899 (class 2606 OID 16571)
-- Name: usuarios id_perfil_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT id_perfil_fk FOREIGN KEY (id_perfil) REFERENCES public.perfil(gru_cod);


--
-- TOC entry 2900 (class 2606 OID 25605)
-- Name: articulos marcas_articulos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.articulos
    ADD CONSTRAINT marcas_articulos_fk FOREIGN KEY (mar_cod) REFERENCES public.marca(cod_marca);


--
-- TOC entry 2893 (class 2606 OID 16576)
-- Name: permisos permisos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_fk FOREIGN KEY (gru_cod) REFERENCES public.perfil(gru_cod);


--
-- TOC entry 2907 (class 2606 OID 25722)
-- Name: det_venta stock_det_venta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_venta
    ADD CONSTRAINT stock_det_venta_fk FOREIGN KEY (id_articulo, cod_depo) REFERENCES public.stock(id_articulo, cod_depo);


--
-- TOC entry 2906 (class 2606 OID 25712)
-- Name: stock stock_id_articulo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_id_articulo_fkey FOREIGN KEY (id_articulo) REFERENCES public.producto(cod_producto);


--
-- TOC entry 2904 (class 2606 OID 25681)
-- Name: ventas usuarios_ventas_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT usuarios_ventas_fk FOREIGN KEY (usu_cod) REFERENCES public.usuarios(usu_cod);


--
-- TOC entry 2908 (class 2606 OID 25727)
-- Name: det_venta ventas_det_venta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_venta
    ADD CONSTRAINT ventas_det_venta_fk FOREIGN KEY (id_venta) REFERENCES public.ventas(id_venta);


-- Completed on 2019-07-16 20:38:01

--
-- PostgreSQL database dump complete
--

