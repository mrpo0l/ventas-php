<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>SYS - VENTA</title>

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
                    <div class="col-md-12">
                        <h3 class="page-header">Datos de Compra
                            <a href="venta_index.php" 
                               class="btn btn-primary btn-circle pull-right" 
                               rel='tooltip' title="Atras">
                                <i class="glyphicon glyphicon-arrow-left"></i>
                            </a> 
                        </h3>
                    </div>                       
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                Datos Cabecera
                            </div>
                            <?php
                            $compras = consultas::get_datos
                                            ("select * from v_compras where id_compra=" .
                                            $_REQUEST['vcod'] . " order by id_compra asc");
                            ?>
                            <div class="panel-body">
                                <div class="table-responsive">                          
                                    <table width="100%" 
                                           class="table table-bordered">
                                        <thead>
                                            <tr class="success">                                               
                                                <th class="text-center">CLIENTE</th>   
                                                <th class="text-center">FECHA</th>   
                                                <th class="text-center">MONTO</th>   
                                                <th class="text-center">COND VENTA</th>                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($compras as $venta) { ?> 
                                                <tr>
                                                    <td class="text-center">
                                                        <?php echo $venta['cliente']; ?></td>
                                                    <td class="text-center">
                                                        <?php echo $venta['fecha']; ?></td>
                                                    <td class="text-center">
                                                        <?php echo number_format($venta['ven_total'], 0, ',', '.'); ?>
                                                    </td>
                                                    <td class="text-center">
                                                        <?php echo $venta['ven_condicion']; ?></td>                                                                                                      
                                                </tr>
                                            <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--comienzo para el detalle-->
                <?php
                $detcompras = consultas::get_datos
                                ("select * from v_detcompras "
                                . " where id_venta=" . $_REQUEST['vcod'] .
                                " order by id_venta asc");
                ?>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                Detalle de Compras
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">   
                                    <?php if (!empty($detcompras)) { ?>
                                        <table width="100%" class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Articulos</th>
                                                    <th>Deposito</th>
                                                    <th>Precio Unit</th>
                                                    <th>Cantidad</th>
                                                    <th>Exenta</th>
                                                    <th>Iva 5%</th>
                                                    <th>Iva 10%</th>
                                                    <!--<th>Subtotal</th>-->
                                                    <th>Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php 
                                                $exe = $iva5 = $iva10 = $subtotal = 0;
                                                foreach ($detcompras as $detventa) { 
                                                    $exe += $detventa['exenta'];
                                                    $iva5 += $detventa['iva5'];
                                                    $iva10 += $detventa['iva10'];
                                                    $subtotal += $detventa['det_subtotal'];
                                                    ?> 
                                                    <tr>                                                    
                                                        <td><?php echo $detventa['id_articulo']; ?></td>
                                                        <td><?php echo $detventa['desc_producto']; ?></td>
                                                        <td><?php echo $detventa['dep_descrip']; ?></td>
                                                        <td><?php echo number_format($detventa['det_precio_unit'], 0, ',', '.');?></td>
                                                        <td><?php echo number_format($detventa['det_cantidad'], 0, ',', '.'); ?></td>
                                                        <td><?php echo number_format($detventa['exenta'], 0, ',', '.'); ?></td>
                                                        <td><?php echo number_format($detventa['iva5'], 0, ',', '.'); ?></td>
                                                        <td><?php echo number_format($detventa['iva10'], 0, ',', '.'); ?></td>
                                                        <!--<td><?php // echo number_format($detventa['det_subtotal'], 0, ',', '.');?></td>-->
                                                        <td>
                                                            <a onclick="borrar(<?php
                                                            echo "'" . $detventa['id_articulo'] . "_" .
                                                            $_REQUEST['vcod'] . "_" .
                                                            $detventa['cod_depo'] . "_" .
                                                            $detventa['det_cantidad'] . "_" .
                                                            $detventa['desc_producto'] . "'";
                                                            ?>)" 

                                                               class="btn btn-xs btn-danger" 
                                                               rel='tooltip' data-title="Borrar"
                                                               data-toggle="modal"
                                                               data-target="#delete">
                                                                <span class="glyphicon glyphicon-trash">                                                              
                                                                </span></a>                                                                                                                             
                                                        </td>                                                    
                                                    </tr>
                                                <?php } ?>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <td colspan="5" class="text-center">SUB-TOTAL</td> 
                                                    <td><?= ($exe) ? number_format($exe, 0, ',', '.') : 0?></td>
                                                    <td><?= ($iva5) ? number_format($iva5, 0, ',', '.') : 0?></td>
                                                    <td><?= ($iva10) ? number_format($iva10, 0, ',', '.') : 0?></td>
                                                    <!--<td><?= ($subtotal) ? number_format($subtotal, 0, ',', '.') : 0?></td>-->
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5" class="text-center">TOTAL IVA</td>
                                                    <td><?= ($exe) ? number_format($exe, 0, ',', '.') : 0?></td>
                                                    <td><?= ($iva5) ? number_format(($iva5 / 21), 0, ',', '.') : 0?></td>
                                                    <td><?= ($iva10) ? number_format(($iva10 / 11), 0, ',', '.') : 0?></td>
                                                    <!--<td><?= ($subtotal) ? number_format($subtotal, 0, ',', '.') : 0?></td>-->
                                                    <td></td>
                                                </tr>                                                
                                            </tfoot>
                                        </table> 
                                    <?php } else { ?>
                                        <br>
                                        <div class="col-md-12">
                                            <div class="alert alert-info 
                                                 alert-dismissable">
                                                <button type="button" class="close" 
                                                        data-dismiss="alert" aria-hidden="true">&times;
                                                </button>
                                                <strong>No se encontraron detalles para la venta....!</strong>
                                            </div>
                                        </div>
                                    <?php } ?> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--//carga para el detalles-->
                <div class="row">       
                    <div class="col-md-12">
                        <div class="panel-body">
                            <form action="detcompras_control.php" method="post" 
                                  role="form" class="form-horizontal">
                                <input type="hidden" name="accion" value="1">
                                <input type="hidden" name="vcod" 
                                       value="<?php echo $_REQUEST['vcod'] ?>">
                                <input type="hidden" name="vtotal" value="0">
                                <input type="hidden" name="pagina" 
                                       value="detcompras_agregar.php">  

                                <div class="form-group" style="display: none">
                                    <label class="col-md-4 control-label">Deposito:
                                    </label>
                                    <div class="col-md-4">
                                        <?php $depositos = consultas::get_datos("select * from deposito");
                                        ?>                                 
                                        <select name="vdep" 
                                                class="form-control" id="depo" 
                                                >
                                            <option  value="0">Seleccione un deposito</option>
                                            <?php
                                            if (!empty($depositos)) {
                                                foreach ($depositos as $deposito) {
                                                    ?>
                                                    <option 
                                                        value="<?php echo $deposito['cod_depo']; ?>">
                                                            <?php echo $deposito['dep_descrip']; ?>
                                                    </option>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Debe insertar un deposito</option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div> 
                                <div class="form-group">
                                    <label class="col-md-4 control-label">Producto:</label>
                                    <div class="col-md-3">
                                        <?php $stocks = consultas::get_datos("select * from v_stock "); ?>
                                        <select class="form-control select2" style="height: 25px" name="varti" id="artic" onchange="preciosArticulo(this)" onkeyup="preciosArticulo(this)" required="">
                                            <?php
                                            if (!empty($stocks)) {
                                                foreach ($stocks as $stock) {
                                                    ?>
                                                    <option value="<?php echo $stock['idproducto'] . "_" .$stock['precio']."_".$stock['cantidad'];?>">
                                                        <?php echo $stock['desc_producto'] ?></option>  
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option>Debe insertar al menos un articulo</option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label">Precio Unit:</label>
                                    <div class="col-md-3">
                                        <input type="number" required="" 
                                               placeholder="Precio del articulo"  
                                               class="form-control"  
                                               name="vprecio" id="precio" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label">Cantidad:</label>
                                    <div class="col-md-3">
                                        <input type="number" required
                                               class="form-control"  
                                               required  min="1" name="vcant" onchange="stock()" onkeyup="calsubtotal()" onclick="calsubtotal()"
                                               id="cant" value="0">  
                                        <input type="hidden" name="cantidad" 
                                               value="" 
                                               id="cantstock">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-4 control-label">Subtotal:</label>
                                    <div class="col-md-3">
                                        <input type="text" required="" 
                                               placeholder="Subtotal del producto"  
                                               class="form-control"  
                                               name="vsubtotal" value="0" 
                                               readonly="" id="subtotal">
                                    </div>
                                </div>
                                <br>
                                <div class="form-group">
                                    <div class="col-md-offset-4 col-md-10">
                                        <button class="btn btn-success" 
                                                type="submit"><i class="fa fa-floppy-o">

                                            </i> Grabar</button>
                                    </div>
                                </div>
                            </form>
                        </div>
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
                        <h4 class="modal-title custom_align" id="Heading">Atenci&oacute;n!!!</h4>
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
        <!--fin-->
        <!--archivos js-->   
        <?php require 'menu/js.ctp'; ?>

        <script>
            var cant = null;
            $(document).ready(function () {
                    preciosArticulo($("#artic"));
            });

            function preciosArticulo(obj) {
                var dato = $(obj).val();
                console.log(dato);
                var dat = dato.split("_");
                $("#cantstock").val(dat[2]);
                $("#precio").val(dat[1]);
            }

            function calsubtotal() {
                var precio = $('#precio').val();
                var subtotal = parseInt(precio) * parseInt($('#cant').val());
                $('#subtotal').val(subtotal ? subtotal : 0);
            }


            function stock() {
                var cant = parseInt($('#cantstock').val());
                if (cant > 0) {
                    if (parseInt($('#cant').val()) > cant) {
                        notificacion('Atención', 'SOLO HAY ' + cant + ' EN STOCK ESTE PRODUCTO', 'error');
                        $('#cant').val(cant);
                        calsubtotal();
                    }
                } else {
                    calsubtotal();
                    $('#cant').val('0');
                }
            }

            function borrar(datos) {
                var dat = datos.split("_");
                $('#si').attr('href',
                        'detcompras_control.php?vcod=' + dat[1] +
                        '&varti=' + dat[0] +
                        '&vdep=' + dat[2] +
                        '&vprecio=null' +
                        '&vcant=' + dat[3]
                        + '&vsubtotal=null'
                        + '&accion=3' +
                        '&pagina=detcompras_agregar.php');
                $('#confirmacion').html
                        ('<span class="glyphicon glyphicon-warning-sign"></span>\n\
           Desea Borrar el aritculo  <i><strong>' +
                                dat[4] + '</strong></i> del detalle ?');
            }

        </script>
    </body>
</html>
