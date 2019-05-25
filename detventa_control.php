<?php

require './clases/conexion.php';

session_start();
  ban integer,
    codcom integer,
    pedido integer,
    proveedor integer,
    usucod integer,
    tipocomprobante integer,
    nro_factura integer,
    fecha date,
    iva10 integer,
    iva5 integer,
    exenta integer,
    total_factura integer,
    fechafactura date,
    condicion integer,
    estado integer)



//subtrae cadena con explode
$producto = explode("_", $_REQUEST['vcodproducto']);


$sql = "SELECT sp_detcompra(".$_REQUEST['accion'].",".
        $_REQUEST['vcodproducto'].",".
        $producto[0].",".
      
        $_REQUEST['vcostoc'].",".
        $_REQUEST['vcantidad'].",".
        $_REQUEST['vsubtotal'].") as detcompra;";
       
$resultado = consultas::get_datos($sql);
if ($resultado[0]['detcompra'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso '+$sql;
    header('location:./'.$_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['detcompra']."_".
            $_REQUEST['accion'];

    header('location:./'.$_REQUEST['pagina']."?vcod=".
            $_REQUEST['vcod']);

}
?>


 