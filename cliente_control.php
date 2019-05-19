<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_cliente(" . $_REQUEST['accion'] . ","
        . $_REQUEST['vcod'] . ",'" 
        . $_REQUEST['nombre'] . "','" 
        . $_REQUEST['apellido'] . "'," 
        . $_REQUEST['idciudad'] . ",'" 
        . $_REQUEST['direccion'] . "'," 
        . $_REQUEST['edad'] . "," 
		. $_REQUEST['documento'] . ") as cliente;";
$resultado = consultas::get_datos($sql);


if ($resultado[0]['cliente'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso ' + $sql;
    header('location:./' . $_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['cliente'] . "_" . $_REQUEST['accion'];

    header('location:./' . $_REQUEST['pagina']);
}
?>



			