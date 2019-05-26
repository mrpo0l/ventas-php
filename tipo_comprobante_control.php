<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_tipo_comprobante(" . $_REQUEST['accion'] . ","
        . $_REQUEST['vcod'] . ",'" 
		. $_REQUEST['vnombre'] . "') as tipo_comprobante;";
$resultado = consultas::get_datos($sql);


if ($resultado[0]['tipo_comprobante'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['tipo_comprobante'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['pagina']);
}
?>



			