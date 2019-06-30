<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_tipo_producto(" . $_REQUEST['accion'] . ","
        . $_REQUEST['vcod'] . ",'"
        . $_REQUEST['vnombre'] . "') as tipo_producto;";
$resultado = consultas::get_datos($sql);


if ($resultado[0]['tipo_producto'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['tipo_producto'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['pagina']);
}
?>



			