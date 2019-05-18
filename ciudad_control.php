<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_ciudad(" . $_REQUEST['accion'] . ","
        . $_REQUEST['vcod'] . ",'" 
		. $_REQUEST['vnombre'] . "') as ciudad;";
$resultado = consultas::get_datos($sql);


if ($resultado[0]['ciudad'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['ciudad'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['pagina']);
}
?>



			