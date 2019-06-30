<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>COPETROL</title>

        <?php
        require './ver_sesion.php';
        require 'menu/css.ctp';
        ?>

    </head>
    <body>
        <div id="wrapper">
            <?php require 'menu/navbar.ctp'; ?><!--BARRA DE HERRAMIENTAS-->
            <div id="page-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="page-header">Editar Sucursales 
                            <a href="clientes_index.php" class="btn btn-primary btn-circle pull-right" rel='tooltip' title="Atras">
                                <i class="glyphicon glyphicon-arrow-left"></i>
                            </a> 
                        </h3>
                    </div>                       
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">                                         
                        <div class="panel-body">
                            <?php $sucursal=  consultas::get_datos
                         ("select * from sucursal where cod_sucursal =".$_REQUEST['vcod']) ?>
                            
                            <form action="sucursal_control.php" method="post" role="form" class="form-horizontal">
                                <input type="hidden" name="accion" value="2">
                                <input type="hidden" name="vcod" 
                                      value="<?php echo $sucursal[0]['cod_sucursal']; ?>">
                                <input type="hidden" name="pagina" value="sucursal_index.php">
                           

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nombre</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese nombre de la sucursal"  
                                               class="form-control" name="vnombre" value="<?php echo $sucursal[0]['suc_nombre']; ?>"
                                               >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Direccion</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese nombre de la sucursal"  
                                               class="form-control" name="vdireccion" value="<?php echo $sucursal[0]['suc_direccion']; ?>"
                                               >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Telefono</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese nombre de la sucursal"  
                                               class="form-control" name="vtelefono" value="<?php echo $sucursal[0]['suc_tel']; ?>"
                                               >
                                    </div>
                                </div>
                                
                                
                                

                                <br>
                                <div class="form-group">
                                    <div class="col-md-offset-2 col-md-10">
                                        <button class="btn btn-primary" type="submit"><i class="fa fa-refresh"></i> Actualizar</button>
                                    </div>
                                </div>
                            </form>     
                        </div>
                    </div>
                </div>
                <!-- /.col-lg-12 -->
            </div>

        </div> 
        <!--fin-->
        <!--archivos js-->   
        <?php require 'menu/js.ctp'; ?>

    </body>
</html>
