<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_marca(" . $_REQUEST['accion'] . ","
        . $_REQUEST['vcod'] . ",'". 
		        $_REQUEST['vnombre']. "') as marca;";
$resultado = consultas::get_datos($sql);


if ($resultado[0]['marca'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['marca'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['pagina']);
}
?>



			