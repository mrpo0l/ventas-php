<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_banco(" . $_REQUEST['accion'] . ","
        . $_REQUEST['vcod'] . "," . $_REQUEST['vciu'] . ",'" .
        $_REQUEST['vnombre'] . "','" 
		.$_REQUEST['vdirec'] . "','" . $_REQUEST['vtel'] ."' ) as banco;";
		
$resultado = consultas::get_datos($sql);


if ($resultado[0]['banco'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['banco'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['pagina']);
}
?>


			