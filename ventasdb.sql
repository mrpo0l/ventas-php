--
-- PostgreSQL database dump
--

-- Dumped from database version 10.8
-- Dumped by pg_dump version 11.1

-- Started on 2019-07-30 20:49:40

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
-- TOC entry 261 (class 1255 OID 25786)
-- Name: funcion_actualiza_total(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.funcion_actualiza_total() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
	IF (TG_OP = 'INSERT') THEN
		update venta
		set total_factura_venta = (select coalesce(sum(det_subtotal),0) from det_venta where id_venta=new.id_venta)
		where  idventa = new.id_venta;
		return new;     
	END IF;
	
	IF (TG_OP = 'DELETE') THEN
		update venta
		set total_factura_venta = (select coalesce(sum(det_subtotal),0) from det_venta where id_venta=old.id_venta)
		where  idventa = old.id_venta;
		return new;     
	END IF;

        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.funcion_actualiza_total() OWNER TO postgres;

--
-- TOC entry 257 (class 1255 OID 34014)
-- Name: funcion_actualiza_total_compra(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.funcion_actualiza_total_compra() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
	IF (TG_OP = 'INSERT') THEN
		update compra
		set total_factura_compra = (select coalesce(sum(det_subtotal),0) from det_compra where id_compra=new.id_compra)
		where  idcompra = new.id_compra;
		return new;     
	END IF;
	
	IF (TG_OP = 'DELETE') THEN
		update compra
		set total_factura_compra = (select coalesce(sum(det_subtotal),0) from det_compra where id_compra=old.id_compra)
		where  idcompra = old.id_compra;
		return new;     
	END IF;

        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.funcion_actualiza_total_compra() OWNER TO postgres;

--
-- TOC entry 256 (class 1255 OID 33951)
-- Name: numero_letras(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.numero_letras(numero numeric) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
     lnEntero INTEGER;
     lcRetorno TEXT;
     lnTerna INTEGER;
     lcMiles TEXT;
     lcCadena TEXT;
     lnUnidades INTEGER;
     lnDecenas INTEGER;
     lnCentenas INTEGER;
     lnFraccion INTEGER;
     lnSw INTEGER;
BEGIN
     lnEntero := FLOOR(numero)::INTEGER;--Obtenemos la parte Entera
     lnFraccion := FLOOR(((numero - lnEntero) * 100))::INTEGER;--Obtenemos la Fraccion del Monto
     lcRetorno := '';
     lnTerna := 1;
     IF lnEntero > 0 THEN
     lnSw := LENGTH(lnEntero::text);
     WHILE lnTerna <= lnSw LOOP
        -- Recorro terna por terna
        lcCadena = '';
        lnUnidades = lnEntero % 10;
        lnEntero = CAST(lnEntero/10 AS INTEGER);
        lnDecenas = lnEntero % 10;
        lnEntero = CAST(lnEntero/10 AS INTEGER);
        lnCentenas = lnEntero % 10;
        lnEntero = CAST(lnEntero/10 AS INTEGER);
    -- Analizo las unidades
       SELECT
         CASE /* UNIDADES */
           WHEN lnUnidades = 1 AND lnTerna = 1 THEN 'UNO ' || lcCadena
           WHEN lnUnidades = 1 AND lnTerna <> 1 THEN 'UN ' || lcCadena
           WHEN lnUnidades = 2 THEN 'DOS ' || lcCadena
           WHEN lnUnidades = 3 THEN 'TRES ' || lcCadena
           WHEN lnUnidades = 4 THEN 'CUATRO ' || lcCadena
           WHEN lnUnidades = 5 THEN 'CINCO ' || lcCadena
           WHEN lnUnidades = 6 THEN 'SEIS ' || lcCadena
           WHEN lnUnidades = 7 THEN 'SIETE ' || lcCadena
           WHEN lnUnidades = 8 THEN 'OCHO ' || lcCadena
           WHEN lnUnidades = 9 THEN 'NUEVE ' || lcCadena
           ELSE lcCadena
          END INTO lcCadena;
          /* UNIDADES */
    -- Analizo las decenas
    SELECT
    CASE /* DECENAS */
      WHEN lnDecenas = 1 THEN
        CASE lnUnidades
          WHEN 0 THEN 'DIEZ '
          WHEN 1 THEN 'ONCE '
          WHEN 2 THEN 'DOCE '
          WHEN 3 THEN 'TRECE '
          WHEN 4 THEN 'CATORCE '
          WHEN 5 THEN 'QUINCE '
          ELSE 'DIECI' || lcCadena
        END
      WHEN lnDecenas = 2 AND lnUnidades = 0 THEN 'VEINTE ' || lcCadena
      WHEN lnDecenas = 2 AND lnUnidades <> 0 THEN 'VEINTI' || lcCadena
      WHEN lnDecenas = 3 AND lnUnidades = 0 THEN 'TREINTA ' || lcCadena
      WHEN lnDecenas = 3 AND lnUnidades <> 0 THEN 'TREINTA Y ' || lcCadena
      WHEN lnDecenas = 4 AND lnUnidades = 0 THEN 'CUARENTA ' || lcCadena
      WHEN lnDecenas = 4 AND lnUnidades <> 0 THEN 'CUARENTA Y ' || lcCadena
      WHEN lnDecenas = 5 AND lnUnidades = 0 THEN 'CINCUENTA ' || lcCadena
      WHEN lnDecenas = 5 AND lnUnidades <> 0 THEN 'CINCUENTA Y ' || lcCadena
      WHEN lnDecenas = 6 AND lnUnidades = 0 THEN 'SESENTA ' || lcCadena
      WHEN lnDecenas = 6 AND lnUnidades <> 0 THEN 'SESENTA Y ' || lcCadena
      WHEN lnDecenas = 7 AND lnUnidades = 0 THEN 'SETENTA ' || lcCadena
      WHEN lnDecenas = 7 AND lnUnidades <> 0 THEN 'SETENTA Y ' || lcCadena
      WHEN lnDecenas = 8 AND lnUnidades = 0 THEN 'OCHENTA ' || lcCadena
      WHEN lnDecenas = 8 AND lnUnidades <> 0 THEN 'OCHENTA Y ' || lcCadena
      WHEN lnDecenas = 9 AND lnUnidades = 0 THEN 'NOVENTA ' || lcCadena
      WHEN lnDecenas = 9 AND lnUnidades <> 0 THEN 'NOVENTA Y ' || lcCadena
      ELSE lcCadena
    END INTO lcCadena; /* DECENAS */
    -- Analizo las centenas
    SELECT
    CASE /* CENTENAS */
      WHEN lnCentenas = 1 AND lnUnidades = 0 AND lnDecenas = 0 THEN 'CIEN ' || lcCadena
      WHEN lnCentenas = 1 AND NOT(lnUnidades = 0 AND lnDecenas = 0) THEN 'CIENTO ' || lcCadena
      WHEN lnCentenas = 2 THEN 'DOSCIENTOS ' || lcCadena
      WHEN lnCentenas = 3 THEN 'TRESCIENTOS ' || lcCadena
      WHEN lnCentenas = 4 THEN 'CUATROCIENTOS ' || lcCadena
      WHEN lnCentenas = 5 THEN 'QUINIENTOS ' || lcCadena
      WHEN lnCentenas = 6 THEN 'SEISCIENTOS ' || lcCadena
      WHEN lnCentenas = 7 THEN 'SETECIENTOS ' || lcCadena
      WHEN lnCentenas = 8 THEN 'OCHOCIENTOS ' || lcCadena
      WHEN lnCentenas = 9 THEN 'NOVECIENTOS ' || lcCadena
      ELSE lcCadena
    END INTO lcCadena;/* CENTENAS */
    -- Analizo la terna
    SELECT
    CASE /* TERNA */
      WHEN lnTerna = 1 THEN lcCadena
      WHEN lnTerna = 2 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN lcCadena || 'MIL '
      WHEN lnTerna = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND
        lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0 THEN lcCadena || 'MILLON '
      WHEN lnTerna = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) AND
        NOT (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0) THEN lcCadena || 'MILLONES '
      WHEN lnTerna = 4 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN lcCadena || 'MIL MILLONES '
      ELSE ''
    END INTO lcCadena;/* TERNA */
 
    --Retornamos los Valores Obtenidos
    lcRetorno = lcCadena  || lcRetorno;
    lnTerna = lnTerna + 1;
    END LOOP;
  END IF;
  IF lnTerna = 1 THEN
    lcRetorno := 'CERO';
  END IF;
  --lcRetorno := RTRIM(lcRetorno) || ' ENTEROS CON ' || LTRIM(lnFraccion::text) || 'CENTÉSIMOS';
RETURN lcRetorno;
END;
$$;


ALTER FUNCTION public.numero_letras(numero numeric) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 16394)
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
-- TOC entry 253 (class 1255 OID 24661)
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
-- TOC entry 258 (class 1255 OID 34008)
-- Name: sp_compra(integer, integer, integer, integer, date, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_compra(ban integer, codven integer, usucod integer, cliente integer, fecha date, iva10 integer, iva5 integer, exenta integer, total_factura integer, estado integer, condicion integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then


    
		INSERT INTO compra
		VALUES ((select coalesce(max(idcompra),0)+1 from compra), usucod, cliente,  (select coalesce(max(nro_factura),0)+1 from compra), fecha, iva10, iva5, exenta, total_factura, 
		 estado, condicion);
	

	mensaje = 'Guardado Exitosamente';

when 2 then

	update compra set idestado = estado where idcompra=codven;		
	mensaje = 'Anulado Exitosamente';
	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_compra(ban integer, codven integer, usucod integer, cliente integer, fecha date, iva10 integer, iva5 integer, exenta integer, total_factura integer, estado integer, condicion integer) OWNER TO postgres;

--
-- TOC entry 254 (class 1255 OID 24670)
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
-- TOC entry 259 (class 1255 OID 34013)
-- Name: sp_detcompras(integer, integer, integer, integer, numeric, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_detcompras(ban integer, codven integer, codarti integer, coddepo integer, preciounit numeric, cantidad integer, subtotal integer) RETURNS character varying
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

	select id_compra into repetido from det_compra where id_articulo = codarti and cod_depo=coddepo and id_compra=codven;

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
				
			INSERT INTO det_compra
			VALUES (codven,codarti,coddepo,preciounit,cantidad,subtotal,porexe,poriva5,poriva10);

			mensaje = 'Guardado Exitosamente';
		end if;
when 3 then
	delete from det_compra where id_articulo=codarti and cod_depo=coddepo and id_compra=codven;
	mensaje = 'Borrado Exitosamente';
	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_detcompras(ban integer, codven integer, codarti integer, coddepo integer, preciounit numeric, cantidad integer, subtotal integer) OWNER TO postgres;

--
-- TOC entry 267 (class 1255 OID 25745)
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
-- TOC entry 260 (class 1255 OID 24684)
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
-- TOC entry 262 (class 1255 OID 24702)
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
-- TOC entry 263 (class 1255 OID 24732)
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
-- TOC entry 251 (class 1255 OID 24605)
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
-- TOC entry 252 (class 1255 OID 24736)
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
-- TOC entry 266 (class 1255 OID 24738)
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
-- TOC entry 265 (class 1255 OID 24737)
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
-- TOC entry 264 (class 1255 OID 24733)
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
-- TOC entry 255 (class 1255 OID 25770)
-- Name: sp_venta(integer, integer, integer, integer, date, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_venta(ban integer, codven integer, usucod integer, cliente integer, fecha date, iva10 integer, iva5 integer, exenta integer, total_factura integer, estado integer, condicion integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare mensaje varchar;
repetido integer;

begin

case ban
when 1 then


    
		INSERT INTO venta
		VALUES ((select coalesce(max(idventa),0)+1 from venta), usucod, cliente,  (select coalesce(max(nro_factura),0)+1 from venta), fecha, iva10, iva5, exenta, total_factura, 
		 estado, condicion);
	

	mensaje = 'Guardado Exitosamente';

when 2 then

	update venta set idestado = estado where idventa=codven;		
	mensaje = 'Anulado Exitosamente';
	
end case;
return mensaje;
end;
$$;


ALTER FUNCTION public.sp_venta(ban integer, codven integer, usucod integer, cliente integer, fecha date, iva10 integer, iva5 integer, exenta integer, total_factura integer, estado integer, condicion integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

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
-- TOC entry 234 (class 1259 OID 33952)
-- Name: compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compra (
    idcompra integer NOT NULL,
    cod_usu integer NOT NULL,
    id_cliente integer NOT NULL,
    nro_factura integer NOT NULL,
    fecha date,
    total_iva_10 integer NOT NULL,
    total_iva_5 integer NOT NULL,
    total_exenta integer NOT NULL,
    total_factura_compra integer NOT NULL,
    idestado integer,
    ven_condicion integer
);


ALTER TABLE public.compra OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25755)
-- Name: condicion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.condicion (
    idcondicion integer NOT NULL,
    desc_condicion character varying(50)
);


ALTER TABLE public.condicion OWNER TO postgres;

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
-- TOC entry 227 (class 1259 OID 25697)
-- Name: deposito; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deposito (
    cod_depo integer NOT NULL,
    dep_descrip character varying(45) NOT NULL
);


ALTER TABLE public.deposito OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 33987)
-- Name: det_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.det_compra (
    id_compra integer NOT NULL,
    id_articulo integer NOT NULL,
    cod_depo integer NOT NULL,
    det_precio_unit numeric(12,0) NOT NULL,
    det_cantidad numeric(10,0) NOT NULL,
    det_subtotal integer,
    exenta integer,
    iva5 integer,
    iva10 integer
);


ALTER TABLE public.det_compra OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25717)
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
-- TOC entry 223 (class 1259 OID 25590)
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
-- TOC entry 224 (class 1259 OID 25597)
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
-- TOC entry 228 (class 1259 OID 25702)
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
-- TOC entry 236 (class 1259 OID 34003)
-- Name: v_compras; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_compras AS
 SELECT a.idcompra AS id_compra,
    a.id_cliente,
    a.fecha AS ven_fecha,
    to_char((a.fecha)::timestamp with time zone, 'DD/MM/YYYY'::text) AS fecha,
    to_char((a.fecha)::timestamp with time zone, 'TMDay, DD "de" TMMonth "del" yyyy'::text) AS fecdate,
    ( SELECT estado.desc_estado
           FROM public.estado
          WHERE (estado.idestado = a.idestado)) AS ven_estado,
    a.total_factura_compra AS ven_total,
    a.cod_usu AS usu_cod,
    (((b.nombre)::text || ' '::text) || (b.apellido)::text) AS cliente,
    c.usu_nombres,
    b.direccion AS cli_direccion,
    b.documento AS cli_ci,
    b.telefono AS cli_telefono,
    ((((btrim(to_char(1, '000'::text)) || '-'::text) || btrim(to_char(1, '000'::text))) || '-'::text) || btrim(to_char(a.idcompra, '0000000'::text))) AS factura,
    ( SELECT condicion.desc_condicion
           FROM public.condicion
          WHERE (condicion.idcondicion = a.ven_condicion)) AS ven_condicion
   FROM public.compra a,
    public.cliente b,
    public.usuarios c
  WHERE ((a.id_cliente = b.cod_cliente) AND (a.cod_usu = c.usu_cod));


ALTER TABLE public.v_compras OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 34009)
-- Name: v_detcompras; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_detcompras AS
 SELECT a.id_compra AS id_venta,
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
   FROM public.det_compra a,
    public.producto b,
    public.deposito c
  WHERE ((a.id_articulo = b.cod_producto) AND (a.cod_depo = c.cod_depo));


ALTER TABLE public.v_detcompras OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 25732)
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
-- TOC entry 226 (class 1259 OID 25691)
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
-- TOC entry 221 (class 1259 OID 24722)
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
-- TOC entry 231 (class 1259 OID 25741)
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
-- TOC entry 222 (class 1259 OID 24727)
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
-- TOC entry 220 (class 1259 OID 24696)
-- Name: v_tipo_impuesto; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_tipo_impuesto AS
 SELECT a.cod_impuesto AS cod_tipo_impuesto,
    a.nombre AS desc_tipo_impuesto,
    a.porcentaje AS valor_tipo_impuesto
   FROM public.tipo_impuestos a;


ALTER TABLE public.v_tipo_impuesto OWNER TO postgres;

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
-- TOC entry 225 (class 1259 OID 25644)
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
    idestado integer,
    ven_condicion integer
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25781)
-- Name: v_ventas; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.v_ventas AS
 SELECT a.idventa AS id_venta,
    a.id_cliente,
    a.fecha AS ven_fecha,
    to_char((a.fecha)::timestamp with time zone, 'DD/MM/YYYY'::text) AS fecha,
    to_char((a.fecha)::timestamp with time zone, 'TMDay, DD "de" TMMonth "del" yyyy'::text) AS fecdate,
    ( SELECT estado.desc_estado
           FROM public.estado
          WHERE (estado.idestado = a.idestado)) AS ven_estado,
    a.total_factura_venta AS ven_total,
    a.cod_usu AS usu_cod,
    (((b.nombre)::text || ' '::text) || (b.apellido)::text) AS cliente,
    c.usu_nombres,
    b.direccion AS cli_direccion,
    b.documento AS cli_ci,
    b.telefono AS cli_telefono,
    ((((btrim(to_char(1, '000'::text)) || '-'::text) || btrim(to_char(1, '000'::text))) || '-'::text) || btrim(to_char(a.idventa, '0000000'::text))) AS factura,
    ( SELECT condicion.desc_condicion
           FROM public.condicion
          WHERE (condicion.idcondicion = a.ven_condicion)) AS ven_condicion
   FROM public.venta a,
    public.cliente b,
    public.usuarios c
  WHERE ((a.id_cliente = b.cod_cliente) AND (a.cod_usu = c.usu_cod));


ALTER TABLE public.v_ventas OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16464)
-- Name: vfecha; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vfecha AS
 SELECT to_char((('now'::text)::date)::timestamp with time zone, 'TMDay, DD, "del" yyyy'::text) AS fecha;


ALTER TABLE public.vfecha OWNER TO postgres;

--
-- TOC entry 3066 (class 0 OID 16396)
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
-- TOC entry 3067 (class 0 OID 16399)
-- Dependencies: 197
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cliente VALUES (1, 'Juan Daniel                                       ', 'Fretes Cantero                                    ', 4, 'Ruta 1 km 21 - porvenir don luis', 24, 5454334, '1995-05-22', NULL);
INSERT INTO public.cliente VALUES (2, 'Thanos                                            ', 'Thanitos                                          ', 5, 'Planeta titan', 2000, 1234325435, '2018-11-12', NULL);
INSERT INTO public.cliente VALUES (3, 'Daft                                              ', 'Punk                                              ', 3, 'De otro mundo', 45, 12345, '2019-06-10', NULL);


--
-- TOC entry 3090 (class 0 OID 33952)
-- Dependencies: 234
-- Data for Name: compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.compra VALUES (1, 1, 3, 1, '2019-07-31', 0, 0, 0, 2000000, 2, 4);
INSERT INTO public.compra VALUES (2, 1, 2, 2, '2019-07-31', 0, 0, 0, 4000000, 1, 5);


--
-- TOC entry 3089 (class 0 OID 25755)
-- Dependencies: 232
-- Data for Name: condicion; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.condicion VALUES (1, 'Tarjeta de credito');
INSERT INTO public.condicion VALUES (2, 'Tarjeta de debito');
INSERT INTO public.condicion VALUES (3, 'Efectivo');
INSERT INTO public.condicion VALUES (4, 'Bitcoin');
INSERT INTO public.condicion VALUES (5, '1 Riñon');


--
-- TOC entry 3080 (class 0 OID 24665)
-- Dependencies: 216
-- Data for Name: departamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.departamentos VALUES (5, 'Canindeyu');
INSERT INTO public.departamentos VALUES (6, 'prueba');
INSERT INTO public.departamentos VALUES (4, 'Central');
INSERT INTO public.departamentos VALUES (7, 'Prueba 2');
INSERT INTO public.departamentos VALUES (3, 'Paraguari123');


--
-- TOC entry 3086 (class 0 OID 25697)
-- Dependencies: 227
-- Data for Name: deposito; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.deposito VALUES (1, 'Deposito 1');
INSERT INTO public.deposito VALUES (2, 'Deposito 2');


--
-- TOC entry 3091 (class 0 OID 33987)
-- Dependencies: 235
-- Data for Name: det_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.det_compra VALUES (1, 1, 1, 2000000, 1, 2000000, NULL, NULL, 2000000);
INSERT INTO public.det_compra VALUES (2, 3, 1, 4000000, 1, 4000000, NULL, 4000000, NULL);


--
-- TOC entry 3088 (class 0 OID 25717)
-- Dependencies: 229
-- Data for Name: det_venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.det_venta VALUES (2, 1, 1, 2000000, 1, 2000000, NULL, NULL, 2000000);
INSERT INTO public.det_venta VALUES (2, 2, 1, 5000000, 1, 5000000, NULL, NULL, 5000000);
INSERT INTO public.det_venta VALUES (2, 4, 1, 6000000, 2, 12000000, NULL, 12000000, NULL);
INSERT INTO public.det_venta VALUES (1, 2, 1, 5000000, 1, 5000000, NULL, NULL, 5000000);
INSERT INTO public.det_venta VALUES (1, 4, 1, 6000000, 2, 12000000, NULL, 12000000, NULL);
INSERT INTO public.det_venta VALUES (9, 3, 1, 4000000, 1, 4000000, NULL, 4000000, NULL);
INSERT INTO public.det_venta VALUES (9, 2, 1, 5000000, 2, 10000000, NULL, NULL, 10000000);


--
-- TOC entry 3083 (class 0 OID 25590)
-- Dependencies: 223
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.estado VALUES (1, 'Activo');
INSERT INTO public.estado VALUES (2, 'Anulado');


--
-- TOC entry 3081 (class 0 OID 24678)
-- Dependencies: 218
-- Data for Name: existe; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.existe VALUES (2);


--
-- TOC entry 3068 (class 0 OID 16402)
-- Dependencies: 198
-- Data for Name: marca; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.marca VALUES (1, 'Apple');
INSERT INTO public.marca VALUES (2, 'Xiaomi');
INSERT INTO public.marca VALUES (3, 'Oppo');
INSERT INTO public.marca VALUES (5, 'Nokia');
INSERT INTO public.marca VALUES (4, 'Sony');
INSERT INTO public.marca VALUES (6, 'Huawei');
INSERT INTO public.marca VALUES (7, 'Lenovo');


--
-- TOC entry 3082 (class 0 OID 24681)
-- Dependencies: 219
-- Data for Name: marcasenuso; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.marcasenuso VALUES (2);


--
-- TOC entry 3069 (class 0 OID 16405)
-- Dependencies: 199
-- Data for Name: modulo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.modulo VALUES (1, 'Parametros iniciales                              ');
INSERT INTO public.modulo VALUES (2, 'Venta                                             ');
INSERT INTO public.modulo VALUES (3, 'Compra                                            ');


--
-- TOC entry 3070 (class 0 OID 16408)
-- Dependencies: 200
-- Data for Name: paginas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.paginas VALUES (1, 'ciudad_index.php', 'Ciudades', 1);
INSERT INTO public.paginas VALUES (2, 'cliente_index.php', 'Clientes', 1);
INSERT INTO public.paginas VALUES (4, 'tipo_comprobante_index.php', 'Tipos Comprobantes', 1);
INSERT INTO public.paginas VALUES (5, 'departamentos_index.php', 'Departamentos', 1);
INSERT INTO public.paginas VALUES (6, 'marca_index.php', 'Marcas', 1);
INSERT INTO public.paginas VALUES (7, 'producto_index.php', 'Productos', 1);
INSERT INTO public.paginas VALUES (9, 'tipo_impuesto_index.php', 'Tpos Inpuestos', 1);
INSERT INTO public.paginas VALUES (10, 'tipo_producto_index.php', 'Tipo Productos', 1);
INSERT INTO public.paginas VALUES (8, 'sucursal_index.php', 'Sucursales', 1);
INSERT INTO public.paginas VALUES (3, 'venta_index.php', 'Ventas', 2);
INSERT INTO public.paginas VALUES (11, 'compra_index.php', 'Compras', 3);


--
-- TOC entry 3071 (class 0 OID 16414)
-- Dependencies: 201
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.perfil VALUES (1, 'admin');


--
-- TOC entry 3072 (class 0 OID 16417)
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
INSERT INTO public.permisos VALUES (11, true, true, true, true, 1);


--
-- TOC entry 3084 (class 0 OID 25597)
-- Dependencies: 224
-- Data for Name: presupuesto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.presupuesto VALUES (1, '2019-07-13', 0, 0, 0, 0, 1, 1, 1);


--
-- TOC entry 3073 (class 0 OID 16420)
-- Dependencies: 203
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.producto VALUES (1, 'Iphone 7                                          ', 1, 2, 1, 2000000.00, 13, 'true      ');
INSERT INTO public.producto VALUES (2, 'Iphone X                                          ', 1, 2, 1, 5000000.00, 12, 'true      ');
INSERT INTO public.producto VALUES (3, 'Huawei P30                                        ', 6, 1, 1, 4000000.00, 123, 'nuevo     ');
INSERT INTO public.producto VALUES (4, 'Lenovo ideapad 330                                ', 7, 1, 1, 6000000.00, 12, 'nuevo     ');


--
-- TOC entry 3074 (class 0 OID 16423)
-- Dependencies: 204
-- Data for Name: repetido; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.repetido VALUES (1);


--
-- TOC entry 3087 (class 0 OID 25702)
-- Dependencies: 228
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.stock VALUES (1, 1, 20);
INSERT INTO public.stock VALUES (2, 1, 11);
INSERT INTO public.stock VALUES (3, 1, 10);
INSERT INTO public.stock VALUES (4, 1, 12);


--
-- TOC entry 3075 (class 0 OID 16426)
-- Dependencies: 205
-- Data for Name: sucursal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sucursal VALUES (1, 'Asuncion', 'Palma 633
1711 Asunción
Paraguay
', ' +595 985 329 5');


--
-- TOC entry 3076 (class 0 OID 16429)
-- Dependencies: 206
-- Data for Name: tipo_comprobante; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_comprobante VALUES (1, 'Factura                       ');
INSERT INTO public.tipo_comprobante VALUES (2, 'Ticket                        ');


--
-- TOC entry 3077 (class 0 OID 16432)
-- Dependencies: 207
-- Data for Name: tipo_impuestos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_impuestos VALUES (2, 'Iva 10%', 10);
INSERT INTO public.tipo_impuestos VALUES (1, 'Iva 5%', 5);


--
-- TOC entry 3078 (class 0 OID 16435)
-- Dependencies: 208
-- Data for Name: tipo_producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tipo_producto VALUES (2, 'Notebook');
INSERT INTO public.tipo_producto VALUES (1, 'celulares');


--
-- TOC entry 3079 (class 0 OID 16438)
-- Dependencies: 209
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios VALUES (1, 'juanda              ', 1, 'Juan Fretes
       ', '1                   ', 1, 'juanda22            ', 1, 'Grupo de ventas               ');


--
-- TOC entry 3085 (class 0 OID 25644)
-- Dependencies: 225
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.venta VALUES (2, 1, 1, 2, '2019-07-26', 0, 0, 0, 19000000, 1, 1);
INSERT INTO public.venta VALUES (3, 1, 1, 3, '2019-07-31', 0, 0, 0, 0, 1, 3);
INSERT INTO public.venta VALUES (4, 1, 1, 4, '2019-07-31', 0, 0, 0, 0, 1, 3);
INSERT INTO public.venta VALUES (5, 1, 1, 5, '2019-07-31', 0, 0, 0, 0, 1, 1);
INSERT INTO public.venta VALUES (1, 1, 1, 1, '2019-07-19', 0, 0, 0, 17000000, 2, 3);
INSERT INTO public.venta VALUES (8, 1, 3, 8, '2019-07-31', 0, 0, 0, 0, 2, 4);
INSERT INTO public.venta VALUES (7, 1, 1, 7, '2019-07-31', 0, 0, 0, 0, 2, 3);
INSERT INTO public.venta VALUES (6, 1, 1, 6, '2019-07-31', 0, 0, 0, 0, 2, 2);
INSERT INTO public.venta VALUES (9, 1, 3, 9, '2019-07-31', 0, 0, 0, 14000000, 1, 3);


--
-- TOC entry 2852 (class 2606 OID 16469)
-- Name: ciudad ciudad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ciudad
    ADD CONSTRAINT ciudad_pkey PRIMARY KEY (idciudad);


--
-- TOC entry 2854 (class 2606 OID 16471)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cod_cliente);


--
-- TOC entry 2899 (class 2606 OID 25759)
-- Name: condicion condicion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.condicion
    ADD CONSTRAINT condicion_pkey PRIMARY KEY (idcondicion);


--
-- TOC entry 2885 (class 2606 OID 24669)
-- Name: departamentos departamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departamentos
    ADD CONSTRAINT departamentos_pkey PRIMARY KEY (cod_dep);


--
-- TOC entry 2893 (class 2606 OID 25701)
-- Name: deposito deposito_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deposito
    ADD CONSTRAINT deposito_pk PRIMARY KEY (cod_depo);


--
-- TOC entry 2903 (class 2606 OID 33991)
-- Name: det_compra det_compra_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_compra
    ADD CONSTRAINT det_compra_pk PRIMARY KEY (id_compra, id_articulo, cod_depo);


--
-- TOC entry 2897 (class 2606 OID 25721)
-- Name: det_venta det_venta_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_venta
    ADD CONSTRAINT det_venta_pk PRIMARY KEY (id_venta, id_articulo, cod_depo);


--
-- TOC entry 2887 (class 2606 OID 25621)
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (idestado);


--
-- TOC entry 2857 (class 2606 OID 16473)
-- Name: marca marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (cod_marca);


--
-- TOC entry 2859 (class 2606 OID 16475)
-- Name: modulo modulo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modulo
    ADD CONSTRAINT modulo_pkey PRIMARY KEY (id_modulo);


--
-- TOC entry 2862 (class 2606 OID 16477)
-- Name: paginas paginas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paginas
    ADD CONSTRAINT paginas_pkey PRIMARY KEY (pag_cod);


--
-- TOC entry 2864 (class 2606 OID 16479)
-- Name: perfil perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfil
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (gru_cod);


--
-- TOC entry 2866 (class 2606 OID 16481)
-- Name: permisos permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (pag_cod);


--
-- TOC entry 2901 (class 2606 OID 33956)
-- Name: compra pf_compra; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT pf_compra PRIMARY KEY (idcompra);


--
-- TOC entry 2891 (class 2606 OID 25648)
-- Name: venta pf_venta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT pf_venta PRIMARY KEY (idventa);


--
-- TOC entry 2889 (class 2606 OID 25643)
-- Name: presupuesto presupuesto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.presupuesto
    ADD CONSTRAINT presupuesto_pkey PRIMARY KEY (codpresupuesto);


--
-- TOC entry 2871 (class 2606 OID 16483)
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (cod_producto);


--
-- TOC entry 2895 (class 2606 OID 25706)
-- Name: stock stock_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pk PRIMARY KEY (id_articulo, cod_depo);


--
-- TOC entry 2873 (class 2606 OID 16485)
-- Name: sucursal sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (cod_sucursal);


--
-- TOC entry 2875 (class 2606 OID 16487)
-- Name: tipo_comprobante tipo_comprobante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_comprobante
    ADD CONSTRAINT tipo_comprobante_pkey PRIMARY KEY (cod_tipo_comprobante);


--
-- TOC entry 2877 (class 2606 OID 16489)
-- Name: tipo_impuestos tipo_impuestos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_impuestos
    ADD CONSTRAINT tipo_impuestos_pkey PRIMARY KEY (cod_impuesto);


--
-- TOC entry 2879 (class 2606 OID 16491)
-- Name: tipo_producto tipo_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_producto
    ADD CONSTRAINT tipo_producto_pkey PRIMARY KEY (cod_tipo_producto);


--
-- TOC entry 2883 (class 2606 OID 16493)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usu_cod);


--
-- TOC entry 2855 (class 1259 OID 16498)
-- Name: fki_cod_ciudad_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_ciudad_fk ON public.cliente USING btree (cod_ciudad);


--
-- TOC entry 2867 (class 1259 OID 16500)
-- Name: fki_cod_impuesto_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_impuesto_fk ON public.producto USING btree (cod_impuesto);


--
-- TOC entry 2868 (class 1259 OID 16501)
-- Name: fki_cod_marca_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_marca_fk ON public.producto USING btree (cod_marca);


--
-- TOC entry 2880 (class 1259 OID 16503)
-- Name: fki_cod_suc_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_suc_fk ON public.usuarios USING btree (cod_suc);


--
-- TOC entry 2869 (class 1259 OID 16506)
-- Name: fki_cod_tipo_producto_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_cod_tipo_producto_fk ON public.producto USING btree (cod_tipo_producto);


--
-- TOC entry 2860 (class 1259 OID 16508)
-- Name: fki_id_modulo_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_modulo_fk ON public.paginas USING btree (id_modulo);


--
-- TOC entry 2881 (class 1259 OID 16509)
-- Name: fki_id_perfil_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_id_perfil_fk ON public.usuarios USING btree (id_perfil);


--
-- TOC entry 2927 (class 2620 OID 25787)
-- Name: det_venta trg_actualiza_total; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_actualiza_total AFTER INSERT OR DELETE OR UPDATE ON public.det_venta FOR EACH ROW EXECUTE PROCEDURE public.funcion_actualiza_total();


--
-- TOC entry 2928 (class 2620 OID 34015)
-- Name: det_compra trg_actualiza_total_compra; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_actualiza_total_compra AFTER INSERT OR DELETE OR UPDATE ON public.det_compra FOR EACH ROW EXECUTE PROCEDURE public.funcion_actualiza_total_compra();


--
-- TOC entry 2904 (class 2606 OID 16511)
-- Name: cliente cod_ciudad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cod_ciudad_fk FOREIGN KEY (cod_ciudad) REFERENCES public.ciudad(idciudad);


--
-- TOC entry 2907 (class 2606 OID 16521)
-- Name: producto cod_impuesto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_impuesto_fk FOREIGN KEY (cod_impuesto) REFERENCES public.tipo_impuestos(cod_impuesto);


--
-- TOC entry 2908 (class 2606 OID 16526)
-- Name: producto cod_marca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_marca_fk FOREIGN KEY (cod_marca) REFERENCES public.marca(cod_marca);


--
-- TOC entry 2911 (class 2606 OID 16536)
-- Name: usuarios cod_suc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT cod_suc_fk FOREIGN KEY (cod_suc) REFERENCES public.sucursal(cod_sucursal);


--
-- TOC entry 2909 (class 2606 OID 16546)
-- Name: producto cod_tipo_impuesto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_tipo_impuesto_fk FOREIGN KEY (cod_impuesto) REFERENCES public.tipo_impuestos(cod_impuesto);


--
-- TOC entry 2910 (class 2606 OID 16556)
-- Name: producto cod_tipo_producto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT cod_tipo_producto_fk FOREIGN KEY (cod_tipo_producto) REFERENCES public.tipo_producto(cod_tipo_producto);


--
-- TOC entry 2916 (class 2606 OID 25765)
-- Name: venta condicion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT condicion_fk FOREIGN KEY (ven_condicion) REFERENCES public.condicion(idcondicion);


--
-- TOC entry 2921 (class 2606 OID 33957)
-- Name: compra condicion_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT condicion_fk FOREIGN KEY (ven_condicion) REFERENCES public.condicion(idcondicion);


--
-- TOC entry 2917 (class 2606 OID 25707)
-- Name: stock deposito_stock_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT deposito_stock_fk FOREIGN KEY (cod_depo) REFERENCES public.deposito(cod_depo);


--
-- TOC entry 2913 (class 2606 OID 25649)
-- Name: venta fk_cli; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_cli FOREIGN KEY (id_cliente) REFERENCES public.cliente(cod_cliente);


--
-- TOC entry 2922 (class 2606 OID 33962)
-- Name: compra fk_cli; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_cli FOREIGN KEY (id_cliente) REFERENCES public.cliente(cod_cliente);


--
-- TOC entry 2914 (class 2606 OID 25654)
-- Name: venta fk_estados; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_estados FOREIGN KEY (idestado) REFERENCES public.estado(idestado);


--
-- TOC entry 2923 (class 2606 OID 33967)
-- Name: compra fk_estados; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_estados FOREIGN KEY (idestado) REFERENCES public.estado(idestado);


--
-- TOC entry 2915 (class 2606 OID 25669)
-- Name: venta fk_usuarios; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT fk_usuarios FOREIGN KEY (cod_usu) REFERENCES public.usuarios(usu_cod);


--
-- TOC entry 2924 (class 2606 OID 33972)
-- Name: compra fk_usuarios; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra
    ADD CONSTRAINT fk_usuarios FOREIGN KEY (cod_usu) REFERENCES public.usuarios(usu_cod);


--
-- TOC entry 2905 (class 2606 OID 16566)
-- Name: paginas id_modulo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paginas
    ADD CONSTRAINT id_modulo_fk FOREIGN KEY (id_modulo) REFERENCES public.modulo(id_modulo);


--
-- TOC entry 2912 (class 2606 OID 16571)
-- Name: usuarios id_perfil_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT id_perfil_fk FOREIGN KEY (id_perfil) REFERENCES public.perfil(gru_cod);


--
-- TOC entry 2906 (class 2606 OID 16576)
-- Name: permisos permisos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_fk FOREIGN KEY (gru_cod) REFERENCES public.perfil(gru_cod);


--
-- TOC entry 2919 (class 2606 OID 25722)
-- Name: det_venta stock_det_venta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_venta
    ADD CONSTRAINT stock_det_venta_fk FOREIGN KEY (id_articulo, cod_depo) REFERENCES public.stock(id_articulo, cod_depo);


--
-- TOC entry 2925 (class 2606 OID 33992)
-- Name: det_compra stock_det_venta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_compra
    ADD CONSTRAINT stock_det_venta_fk FOREIGN KEY (id_articulo, cod_depo) REFERENCES public.stock(id_articulo, cod_depo);


--
-- TOC entry 2918 (class 2606 OID 25712)
-- Name: stock stock_id_articulo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_id_articulo_fkey FOREIGN KEY (id_articulo) REFERENCES public.producto(cod_producto);


--
-- TOC entry 2920 (class 2606 OID 33941)
-- Name: det_venta ventas_det_venta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_venta
    ADD CONSTRAINT ventas_det_venta_fk FOREIGN KEY (id_venta) REFERENCES public.venta(idventa);


--
-- TOC entry 2926 (class 2606 OID 33997)
-- Name: det_compra ventas_det_venta_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.det_compra
    ADD CONSTRAINT ventas_det_venta_fk FOREIGN KEY (id_compra) REFERENCES public.compra(idcompra);


-- Completed on 2019-07-30 20:49:42

--
-- PostgreSQL database dump complete
--

