<?php

require './clases/conexion.php';

session_start();
//subtrae cadena con explode
$articulo = explode("_", $_REQUEST['varti']);


$sql = "SELECT sp_detcompras(".$_REQUEST['accion'].",".
        $_REQUEST['vcod'].",".
        $articulo[0].", 1,".
        $_REQUEST['vprecio'].",".
        $_REQUEST['vcant'].",".
        $_REQUEST['vsubtotal'].") as detcompras;";
       
$resultado = consultas::get_datos($sql);
if ($resultado[0]['detcompras'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso '+$sql;
    header('location:./'.$_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['detcompras']."_".
            $_REQUEST['accion'];

    header('location:./'.$_REQUEST['pagina']."?vcod=".
            $_REQUEST['vcod']);

}
?>


 