<?php

require './clases/conexion.php';

session_start();
//subtrae cadena con explode
$articulo = explode("_", $_REQUEST['varti']);


$sql = "SELECT sp_detventas(".$_REQUEST['accion'].",".
        $_REQUEST['vcod'].",".
        $articulo[0].", 1,".
        $_REQUEST['vprecio'].",".
        $_REQUEST['vcant'].",".
        $_REQUEST['vsubtotal'].") as detventas;";
       
$resultado = consultas::get_datos($sql);
if ($resultado[0]['detventas'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso '+$sql;
    header('location:./'.$_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['detventas']."_".
            $_REQUEST['accion'];

    header('location:./'.$_REQUEST['pagina']."?vcod=".
            $_REQUEST['vcod']);

}
?>


 