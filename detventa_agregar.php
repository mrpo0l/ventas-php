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
                    <div class="col-md-12">
                        <h3 class="page-header">Datos de Compra
                            <a href="compra_index.php" 
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
                                            ("select * from v_compra where idcompra=" .
                                            $_REQUEST['vcod'] . " order by idcompra asc");
                            ?>
                            <div class="panel-body">
                                <div class="table-responsive">                          
                                    <table width="100%" 
                                           class="table table-bordered">
                                        <thead>
                                            <tr class="success">                                               
                                                <th class="text-center">PROVEEDOR</th>   
                                                <th class="text-center">FECHA</th>   
                                                <th class="text-center">MONTO</th>   
                                                <th class="text-center">COND COMPRA</th>                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php //foreach ($compras as $compra) { ?> 
                                                <tr>
                                                    <td class="text-center">
                                                        <?php echo $compras[0]['proveedor']; ?></td>
                                                    <td class="text-center">
                                                        <?php echo $compras[0]['fechafactura']; ?></td>
                                                    <td class="text-center">
                                                        <?php echo number_format($compras[0]['total_factura_compra'], 0, ',', '.'); ?>
                                                    </td>
                                                    <td class="text-center">
                                                        <?php echo $compras[0]['desc_condicion']; ?></td>                                                                                                      
                                                </tr>
                                            <?php //} ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!--detalles de pedido-->
                        <?php
                        $detPedidos = consultas::get_datos
                                        ("select * from v_detpedido "
                                        . " where idpedido=" . $compras[0]["idpedido"] .
                                        " order by idproducto asc");
                        ?>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-success">
                                    <div class="panel-heading">
                                        Detalle de Pedido a Confirmar
                                    </div>
                                        <div class="table-responsive">    
                                           <?php if (!empty($detPedidos)) { ?>
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Producto</th>
                                                        <th>Cantidad</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php foreach ($detPedidos as $detPedido) { ?> 
                                                        <tr>                                                    
                                                            <td><?php echo $detPedido['idproducto']; ?></td>
                                                            <td><?php echo $detPedido['desc_producto']; ?></td>
                                                            <td><?php echo $detPedido['saldo']; ?></td>
                                                            <td>
                                                                <a onclick="editar(this)"
                                                                   data-datos='<?= json_encode($detPedido)?>'
                                                                   class="btn btn-xs btn-primary" 
                                                                   rel='tooltip' data-title="Editar"
                                                                   data-toggle="modal"
                                                                   data-target="#editarDet">
                                                                    <span class="glyphicon glyphicon-pencil">                                                              
                                                                    </span></a>                                                                                                                             
                                                            </td>                                                    
                                                        </tr>
                                                    <?php } ?>
                                                </tbody>
                                            </table>  
                                            <?php } else { ?>
                                    <br>
                                        <div class="col-md-12">
                                            <div class="alert alert-info 
                                                 alert-dismissable">
                                                <button type="button" class="close" 
                                                        data-dismiss="alert" aria-hidden="true">&times;
                                                </button>
                                                <strong>No se encontraron pedidos para esta compra....!</strong>
                                            </div>
                                        </div>
                                    <?php } ?> 
                                        </div>
                                </div>
                            </div>
                        </div>
                        <!--comienzo para el detalle-->
                        <?php
                        $detcompras = consultas::get_datos
                                        ("select * from v_detcompra "
                                        . " where idcompra=" . $_REQUEST['vcod'] .
                                        " order by idcompra asc");
                        ?>
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        Detalle de Compra
                                    </div>
                                        <div class="table-responsive">   
                                            <?php if (!empty($detcompras)) { ?>
                                            <table class="table table-striped">
                                                <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Producto</th>
                                                     
                                                        <th>Costo</th>
                                                        <th>Cantidad</th>
                                                        <th>Subtotal</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php foreach ($detcompras as $detcompra) { ?> 
                                                        <tr>                                                    
                                                            <td><?php echo $detcompra['idproducto']; ?></td>
                                                            <td><?php echo $detcompra['desc_producto']; ?></td>
                                                          
                                                            <td><?php
                                                                echo
                                                                number_format($detcompra['precio'], 0, ',', '.');
                                                                ?></td>
                                                            <td><?php echo $detcompra['cantidad']; ?></td>
                                                            <td><?php
                                                                echo
                                                                number_format($detcompra['subtotal'], 0, ',', '.');
                                                                ?></td>
                                                            <td>
                                                                <a onclick="borrar(<?php
                                                                echo "'" . $detcompra['idproducto'] . "_" .
                                                                $_REQUEST['vcodcom'] . "_" .
                                                              
                                                                $detcompra['cantidad'] . "_" .
                                                                $detcompra['desc_producto'] . "'";
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
                                            </table>   
                                             <?php } else { ?>
                                            <br>
                                        <div class="col-md-12">
                                            <div class="alert alert-info 
                                                 alert-dismissable">
                                                <button type="button" class="close" 
                                                        data-dismiss="alert" aria-hidden="true">&times;
                                                </button>
                                                <strong>No se encontraron detalles 
                                                    para la compra....!</strong>
                                            </div>
                                        </div>
                                    <?php } ?> 
                                        </div>
                                </div>
                            </div>
                        </div>
                        <!--//carga para el detalles-->

                        <div class="col-lg-12">                                         
                            <div class="panel-body">
                                <form action="detcompra_control.php" method="get" 
                                      role="form" class="form-horizontal">
                                    <input type="hidden" name="accion" value="1">
                                    <input type="hidden" name="vcod" 
                                           value="<?php echo $_REQUEST['vcodcom'] ?>">
                                    <input type="hidden" name="vtotalfactura" value="0">
                                    <input type="hidden" name="pagina" 
                                           value="detcompra_agregar.php">  

                                    
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">Productos:</label>
                                        <div class="col-md-4" id="detalles">
                                            <select class="form-control" required>
                                                <option>Seleccione un producto</option>        
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">Precio:</label>
                                        <div class="col-md-3" id="precio">
                                            <input type="number" required
                                                   placeholder="Precio del Producto"  
                                                   class="form-control"  
                                                   name="vprecio" id="precio" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-4 control-label">Cantidad:</label>
                                        <div class="col-md-3">
                                            <input type="number" required
                                                   class="form-control"  
                                                   required  min="1" name="vcantidad" 
                                                   id="cant" value="0"                                                    
                                                   onmouseup="calsubtotal()" 
                                                   onkeyup="calsubtotal(),stock()" 
                                                   onchange="calsubtotal()"
                                                   onclick="stock()" 
                                                   onkeypress="stock()">                                                     
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
        <!--fin-->
        <!--editar-->
            <div id="editarDet" class="modal fade" role="dialog">
                <div class="modal-dialog">
                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" 
                                    data-dismiss="modal" arial-label="Close">x</button>
                            <h4 class="modal-title"><strong>Editar Cantidad de Pedido</strong></h4>
                        </div>
                        <form action="detCompraPedidoControl.php" method="post" 
                              accept-charset="utf-8" class="form-horizontal">
                            <div class="panel-body">
                                <input name="accion" value="1" type="hidden"/>
                                <input type="hidden" name="pagina" value="detcompra_agregar.php">
                                <input id="vcodproducto" type="hidden" name="vcodproducto" value=""/>
                                <input type="hidden" name="vcod" 
                                           value="<?php echo $_REQUEST['vcodcom'] ?>">
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">Producto:</label>
                                    <div class="col-lg-10">
                                        <input id="vdesc_producto" type="text" class="form-control" name="vdesc_producto" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">Costo:</label>
                                    <div class="col-lg-10">
                                        <input id="vprecio" type="text" class="form-control" name="vprecio" readonly="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">Cantidad:</label>
                                    <div class="col-lg-10">
                                        <input id="vcantarti" type="number" class="form-control" name="vcantidad" required="" onclick="valCantidad(this)">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">Subtotal:</label>
                                    <div class="col-lg-10">
                                        <input id="vsubt" type="number" class="form-control" name="vsubtotal" readonly="">
                                    </div>
                                </div>
                                <br>
                            </div>
                            <div class="modal-footer">
                                <button type="reset" data-dismiss="modal" class="btn btn-default pull-left">
                                    <i class="fa fa-close"></i> Cerrar</button>
                                <button type="submit" class="btn btn-primary pull-right">
                                    <i class="fa fa-refresh"></i> Guardar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!--fin-->
        <!--archivos js-->   
        <?php require 'menu/js.ctp'; ?>

        <script>
            function articulo() {
                if (parseInt($('#depo').val()) > 0) {
                    $.ajax({
                        type: "GET",
                        url: "/electro/lista_producto.php?vdep=" + $('#depo').val(),
                        cache: false,
                        beforeSend: function () {
                            $('#detalles').
                                    html('<img src="/electro/img/cargando.GIF">\n\
                     <strong><i>Cargando...</i></strong>');
                        },
                        success: function (msg) {
                            $('#detalles').html(msg);
                            obtenerprecio();

                        }
                    });
                }
            }

            function obtenerprecio() {
                var dat = $('#artic').val().split("_");
                if (parseInt($('#artic').val()) > 0) {
                    $.ajax({
                        type: "GET",
                        url: "/electro/lista_precios.php?vcodproducto=" + dat[0] + '&vdep=' + $('#depo').val(),
                        cache: false,
                        beforeSend: function () {
                            $('#precio').html('<img src="/electro/img/cargando.GIF"><strong><i>Cargando...</i></strong>');
                        },
                        success: function (msg) {
                            $('#precio').html(msg);
                            calsubtotal();
                            $('#cant').select();
                        }

                    });
                }
            }
            
            var cantAnt = 0;
            function editar(obj){
                 var dat = $(obj).data("datos");
                 $("#vcodproducto").val(dat.id_articulo);
                 $("#vdesc_producto").val(dat.art_descripcion);
                 $("#vcantidad").val(dat.saldo);
                 $("#vprecio").val(dat.art_precio);
                 $("#vsubtotal").val(dat.subtotal);
                 cantAnt =  parseInt(dat.saldo);
            }
            
            function valCantidad(obj){
                var cant = $(obj).val();
                if(cant > cantAnt){
                    notificacion('Acceso', "La cantidad supera al actual. Verifique..!", 'error');
                    $("#vcantidad").val(cantAnt);
                }
            }
        </script>

        <script>
            function calsubtotal() {
                var dat = $('#artic').val().split("_");
                $('#subtotal').val(parseInt(dat[1]) * parseInt($('#cantidad').val()));
            }
        </script>

        <script>
            function stock() {
                var cant = parseInt($('#cantstock').val());
                if (cant > 0) {
                    if (parseInt($('#cantidad').val()) > cant) {
                        alert('SOLO HAY ' + cant + ' EN STOCK ESTE PRODUCTO');
                        $('#cantidad').val(cant);
                        calsubtotal();
                    }
                } else {
                    $('#cantidad').val('0');
                }
            }
        </script>

        <script>
            function borrar(datos) {
                var dat = datos.split("_");
                $('#si').attr('href', 
                'detcompra_control.php?vcod=' + dat[1] +
                        '&varti=' + dat[0] +
                        '&vdep=' + dat[2] +
                        '&vprecio=null' +
                        '&vcant=' + dat[3]
                        + '&vsubtotal=null'
                        + '&accion=3' +
                        '&pagina=detcompra_agregar.php');
                $('#confirmacion').html
           ('<span class="glyphicon glyphicon-warning-sign"></span>\n\
           Desea Borrar el aritculo  <i><strong>' + 
            dat[4] + '</strong></i> del detalle ?');
            }
        </script>


    </body>
</html>
