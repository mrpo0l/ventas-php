<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_producto(" 
        . $_REQUEST['accion'] . ","
        . $_REQUEST['vidproducto'] . ",'" 
        . $_REQUEST['desc_producto'] . "','" 
        . $_REQUEST['estado'] . "'," 
        . $_REQUEST['cod_tipo_producto'] . "," 
        . $_REQUEST['cod_tipo_impuesto'] . "," 
        . $_REQUEST['cod_marca'] . "," 
        . $_REQUEST['precio'] . "," 
		. $_REQUEST['stock'] . 
        ") as producto;";
$resultado = consultas::get_datos($sql);


if ($resultado[0]['producto'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['vdesc_producto']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['producto'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['vdesc_producto']);
}
?>