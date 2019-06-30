<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_sucursal(" . $_REQUEST['accion'] . ","
        . $_REQUEST['vcod'] . ",'"
        . $_REQUEST['vnombre'] . "','"
        . $_REQUEST['vdireccion'] . "',". 
		        $_REQUEST['vtelefono']. ") as sucursal;";
$resultado = consultas::get_datos($sql);


if ($resultado[0]['sucursal'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['sucursal'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['pagina']);
}
?>



			