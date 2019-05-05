<?php
//Iniciar una nueva sesión o reanudar la existente
session_start();

if ($_SESSION) {
//    Destruye toda la información registrada de una sesión
    session_destroy();
}
?>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>FretSmart</title>

    <!-- Bootstrap Core CSS -->
    <link href="./vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="./vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="./dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="./vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Acceso al Sistema</h3>
                    </div>

                    <div class="panel-body">
                        <?php
                            //Mensaje de error  
                            if (!empty($_SESSION['error'])) {
                                ?>
                        <div class="alert alert-danger" role="alert">
                            <span class="glyphicon glyphicon-remove"></span>
                            <?php echo $_SESSION['error']; ?>
                        </div>
                        <?php } ?>

                        <p>
                            <center>
                                <img src="./img/logo2.png" width=30% height=5% align="middle">
                            </center>
                            <!-- /.row -->
                        </p>
                        <form role="form" action="acceso.php" method="post">
                            <fieldset>
                                <div class="form-group has-feedback">
                                    <input class="form-control" placeholder="Ingrese el usuario" value="juanda" name="usuario"
                                        type="text" required="" autofocus>
                                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                                </div>
                                <div class="form-group has-feedback">
                                    <input class="form-control" placeholder="Contraseña" value="juanda22" name="pass" type="password"
                                        required="">
                                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                                </div>

                                <button class="btn btn-lg btn-success btn-block" type="submit">Acceder</button>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="./vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="./vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="./vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="./dist/js/sb-admin-2.js"></script>

</body>

</html>