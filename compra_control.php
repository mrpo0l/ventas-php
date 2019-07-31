
<?php

require './clases/conexion.php';

session_start();

$sql = "SELECT sp_compra(".$_REQUEST['accion'].",".
        $_REQUEST['vcodven'].",".
	$_REQUEST['vusucod'].",".
        $_REQUEST['vcliente'].",'".
        $_REQUEST['vfecha']."',".
	$_REQUEST['viva10'].",".
	$_REQUEST['viva5'].",".
	$_REQUEST['vexenta'].",".
	$_REQUEST['vtotal_factura'].",".
        $_REQUEST['vestado'].",".
        $_REQUEST['vcondicion'].") as compra;";
 
	   
$resultado = consultas::get_datos($sql);

if ($resultado[0]['compra'] == null) {
    $_SESSION['mensaje'] = 'Error de Proceso '+$sql;
    header('location:./'.$_REQUEST['pagina']);
} else {
    $_SESSION['mensaje'] = $resultado[0]['compra']."_".
            $_REQUEST['accion'];

    header('location:./'.$_REQUEST['pagina']);
}
?>