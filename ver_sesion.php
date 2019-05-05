<?php
//Reanudamos la sesión 

//Validamos si existe realmente una sesión activa o no 
session_start();

if($_SESSION['usu_cod']==null){
    $_SESSION['error']='Inicie Sesión';
    header('location:http://localhost/ventas');
    exit(); 
}
?>

