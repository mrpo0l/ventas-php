<?php
require 'clases/conexion.php';//llamar a la conexion

$sql="select * from v_usuarios where usu_nick='".
        $_REQUEST['usuario']."' "
     . " and usu_clave = '".$_REQUEST['pass']."'";
//realiza el recurrido de la consulta
$resultado = consultas::get_datos($sql);
//reanudar una sesion o pregunta si existe una sesion activa
session_start();
//compara el resultado de la consulta

//verifica si la consulta esta o no vacia
if ($resultado[0]['usu_cod'] == NULL) {
//si esta vacia imprime el error y es asignada a una variable
//$_Session['error']
    $_SESSION['error'] = 'Usuario o contraseña incorrectos';
    header('location:index.php');
}else{
    //recupera la variables en variables de sesion al 
    //momento de ingresar
    $_SESSION['usu_cod'] = $resultado[0]['usu_cod'];
    $_SESSION['usu_nick'] = $resultado[0]['usu_nick'];
    $_SESSION['nombres'] = $resultado[0]['usu_nombres'];
    $_SESSION['usu_foto'] = 'https://img.icons8.com/bubbles/2x/administrator-male.png';
    $_SESSION['gru_cod'] = $resultado[0]['gru_cod'];
    $_SESSION['grupo'] = $resultado[0]['gru_nombre'];
    $_SESSION['cod_suc'] = $resultado[0]['cod_suc'];
    header('location:menu.php');//direccionar al menu principal
}
?>

