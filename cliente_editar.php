<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Fretsmart</title>

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
                        <h3 class="page-header">Editar Datos del Cliente 
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
                            <?php $cliente=  consultas::get_datos
                         ("select * from cliente where cod_cliente=".$_REQUEST['vcod']) ?>
                            
                            <form action="cliente_control.php" method="post" role="form" class="form-horizontal">
                                <input type="hidden" name="accion" value="2">
                                <input type="hidden" name="vcod" 
                                      value="<?php echo $cliente[0]['cod_cliente']; ?>">
                                <input type="hidden" name="pagina" value="cliente_index.php">

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nombre</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese el nombre"  
                                               class="form-control" name="nombre" value="<?php echo $cliente[0]['nombre']; ?>">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Fecha de Nacimiento</label>
                                    <div class="col-md-5">
                                        <input type="date" required="" placeholder="Ingrese la fecha"  
                                               class="form-control" name="fecha_nac" value="<?php echo $cliente[0]['fecha_nac']; ?>"
                                               >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Apellido</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese el Apellido"  
                                               class="form-control" name="apellido" value="<?php echo $cliente[0]['apellido']; ?>">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Ciudad</label>
                                    <div class="col-md-3">
                                        <?php
                                        $ciudades = consultas::get_datos("select * from v_ciudad "
                                                        . " order by desc_ciudad");
                                        $ciudadCliente = $cliente[0]['cod_ciudad']
                                        ?>                                 
                                        <select name="idciudad" class="form-control select2">
                                            <?php
                                            if (!empty($ciudades)) {
                                                foreach ($ciudades as $ciudad) {
                                            ?>


                                            <?php
                                            if ($ciudadCliente == $ciudad['idciudad']) {
                                                
                                            ?>
                                            
                                                    <option selected="selected" value="<?php echo $ciudad['idciudad']; ?>">
                                                        <?php echo $ciudad['desc_ciudad']; ?></option>
                                                    <?php
                                                
                                            } else {
                                                ?>
                                                <option value="<?php echo $ciudad['idciudad']; ?>">
                                                        <?php echo $ciudad['desc_ciudad']; ?></option>
                                            <?php } ?>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Si no esta la ciudad debe agregar en la seccion ciudad</option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nro Documento</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese el numero de documento"  
                                               class="form-control" name="documento" value="<?php echo $cliente[0]['documento']; ?>">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Edad</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese la edad del cliente"  
                                               class="form-control" name="edad" id="edad" value="<?php echo $cliente[0]['edad']; ?>">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Direccion</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese la direccion del cliente"  
                                               class="form-control" name="direccion" value="<?php echo $cliente[0]['direccion']; ?>">
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
