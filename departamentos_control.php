<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_departamentos(" . $_REQUEST['accion'] . ","
        . $_REQUEST['vcod'] . ",'" 
		. $_REQUEST['vdescripcion'] . "') as departamentos;";
$resultado = consultas::get_datos($sql);


if ($resultado[0]['departamentos'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['departamentos'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['pagina']);
}
?>



			