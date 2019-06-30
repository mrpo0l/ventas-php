<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>ELECTROSYSTEM</title>

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
                        <h3 class="page-header">Editar Bancos  
                            <a href="banco_index.php" class="btn btn-primary btn-circle pull-right" rel='tooltip' title="Atras">
                                <i class="glyphicon glyphicon-arrow-left"></i>
                            </a> 
                        </h3>
                    </div>                       
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">                                         
                        <div class="panel-body">
                            <?php $banco=  consultas::get_datos
                         ("select * from banco where idbanco=".$_REQUEST['vcod']) ?>
                            
                            <form action="banco_control.php" method="post" role="form" class="form-horizontal">
                                <input type="hidden" name="accion" value="2">
                                <input type="hidden" name="vcod" 
                                      value="<?php echo $banco[0]['idbanco']; ?>">
                                <input type="hidden" name="pagina" value="banco_index.php">
                               
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nombre</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese nombre"  
                                               class="form-control" name="vnombre" 
                                         value="<?php echo $banco[0]['ban_nombre']; ?>">
                                    </div>
                                </div>
                                
								
								 <div class="form-group">
                                    <label class="col-md-2 control-label">Dirección</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese direccion"  
                                               class="form-control" name="vdirec" 
                                         value="<?php echo $banco[0]['ban_direccion']; ?>">
                                    </div>
                                </div>
								
								
								 <div class="form-group">
                                    <label class="col-md-2 control-label">Telefono</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese numero de telefono"  
                                               class="form-control" name="vtel" 
                                         value="<?php echo $banco[0]['ban_telefono']; ?>">
                                    </div>
                                </div>
				
                                
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Ciudad</label>
                                    <?php $ciudades = 
                                            consultas::get_datos
                                          ("select * from ciudad order by idciudad=".$banco[0]['idciudad']." desc"); ?>
                                    <div class="col-md-3">
                                        <select name="vciu" class="form-control select2" >
                                            <?php
                                            if (!empty($ciudades)) {
                                                foreach ($ciudades as $ciudad) {
                                                    ?>
                                                    <option value="<?php echo $ciudad['idciudad']; ?>">
                                                        <?php echo $ciudad['desc_ciudad']; ?></option>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Debe insertar una ciudad</option>
                                            <?php } ?>    
                                        </select>
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
