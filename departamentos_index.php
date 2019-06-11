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
                        <h3 class="page-header">Departamentos
                            <a href="departamentos_agregar.php" class="btn btn-primary btn-circle pull-right">
                                <i class="fa fa-plus" rel="tooltip" data-title="Registrar"></i>
                            </a>  
                        </h3>
                    </div>     
                    <!--Buscador-->
                    <div class="col-lg-12">
                        <!--<div class="panel panel-default">-->
                        <div class="panel-heading">
                            <div class="input-group custom-search-form">
                                <input id="filtrar" type="text" class="form-control" placeholder="Buscar...">
                                <span class="input-group-btn">
                                    <button class="btn btn-default" type="button" rel="tooltip" title="Buscar">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </span>
                            </div>
                        </div>
                        <!--</div>-->
                    </div>
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                Datos
                            </div>
                            <?php
                            $departamentos = consultas::get_datos("select * from departamentos 
                                         order by cod_dep asc");
                            if (!empty($departamentos)) {
                                ?>                         
                                <!--fin-->
                                <!-- /.panel-heading -->
                                <div class="panel-body">
                                    <div>
                                        <table id="example1" width="100%" class="table table-striped table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th class="text-center">#</th>
                                                   
                                                    <th class="text-center">Descripcion</th>   
                                                     
                                                    <!-- <th class="text-center">Departamento</th>    -->
                                                    <th class="text-center">Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody class="buscar">
                                                <?php foreach ($departamentos as $departamento) { ?> 
                                                    <tr>
                                                        <td class="text-center"><?php echo $departamento['cod_dep']; ?></td>
                                                       
                                                        <td class="text-center"><?php echo $departamento['descripcion']; ?></td>                                           
                                                        <!-- <td class="text-center"><?php //echo $ciudades['des_descripcion']; ?></td> -->
                                                        <td class="text-center">
                                                            <a href="departamentos_editar.php?vcod=<?php echo $departamento['cod_dep']; ?>" 
                                                               class="btn btn-xs btn-primary" rel='tooltip' data-title="Editar">
                                                                <span class="glyphicon glyphicon-pencil"></span></a>

                                                            <a onclick="borrar(<?php echo "'". $departamento['cod_dep']."_".
                                                                    $departamento['descripcion']."'"; ?>)"
                                                               data-toggle="modal" data-target="#delete"
                                                               class="btn btn-xs btn-primary" rel='tooltip' 
                                                               data-title="Borrar">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                        </td>
                                                    </tr>
                                                <?php } ?>
                                            </tbody>
                                        </table>                         
                                    </div>
                                <?php } else { ?>
                                    <div class="alert alert-info alert-dismissable">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                                        <strong>No se encontraron registro....!</strong>
                                    </div>
                                <?php } ?>  
                            </div>
                        </div>
                    </div>
                </div>

                <!--borrar-->
                <div class="modal fade" id="delete" tabindex="-1" role="dialog">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                <h4 class="modal-title custom_align" id="Heading">Atención!!!</h4>
                            </div>
                            <div class="modal-body">

                                <div class="alert alert-warning" id="confirmacion"></div>

                            </div>
                            <div class="modal-footer">
                                <a id="si" role="button" class="btn btn-primary" ><span class="glyphicon glyphicon-ok-sign"></span> Si</a>
                                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> No</button>
                            </div>
                        </div>
                    </div>
                </div> 
            </div> 
            <!--fin-->
            <!--archivos js-->   
            <?php require 'menu/js.ctp'; ?>


            <script>
                function borrar(datos) {
                    var dat = datos.split("_");
                    $('#si').attr('href', 
                    'departamentos_control.php?vcod=' + dat[0] + 
                            '&vdescripcion=null'+
                            '&vdepar=null'+
                       
                            '&accion=3'+
                            '&pagina=departamentos_index.php');
                    $('#confirmacion').html
                    ('<span class="glyphicon glyphicon-warning-sign"></span>\n\
                Desea Borrar el tipo de comprobante <i><strong>' + dat[1] + '</strong></i> ?');
                }
            </script>
            


    </body>
</html>
