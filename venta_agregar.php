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
                        <h3 class="page-header">Registar Compra 

                            <a href="compra_index.php" 
                               class="btn btn-primary btn-circle pull-right" 
                               rel='tooltip' title="Atras">
                                <i class="glyphicon glyphicon-arrow-left"></i>
                            </a> 

                        </h3>
                    </div>
                    <!-- /.row -->

					
										
                    <div class="row">
                        <div class="col-lg-12">                                         
                            <div class="panel-body">
                                <form action="compra_control.php" method="post" role="form" class="form-horizontal">
                                    <input type="hidden" name="accion" value="1">
                                    <input type="hidden" name="vcodcom" value="0">
                                    <input type="hidden" name="vtotal_factura" value="0">
									    <input type="hidden" name="viva10" value="0">
										    <input type="hidden" name="viva5" value="0">
											    <input type="hidden" name="vexenta" value="0">
                                    <input type="hidden" name="vestado" value="1">
                                    <input type="hidden" name="vusucod" 
                                           value="<?php echo $_SESSION['usu_cod']; ?>">
                                    <input type="hidden" name="pagina" value="compra_index.php">  

                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Fecha de Carga:</label>
                                        <div class="col-md-2">
                                            <input type="date" required="" 
                                                   placeholder="Especifique fecha"  
                                                   class="form-control" 
                                                   value="<?php echo date("Y-m-d") ?>" 
                                                   name="vfecha" readonly="">
                                        </div>
                                    </div>
									
									   <div class="form-group">
                                        <label class="col-md-2 control-label">Fecha de Comprobante:</label>
                                        <div class="col-md-2">
                                            <input type="date" required="" 
                                                   placeholder="Especifique fecha"  
                                                   class="form-control" 
                                                   value="<?php echo date("Y-m-d") ?>" 
                                                   name="vfechafactura" >
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Proveedor:</label>
                                        <div class="col-md-4">
                                            <?php
                                            $proveedores = consultas::get_datos("select * "
                                                            . "from v_proveedor");
                                            ?>                                 
                                            <select name="vproveedor" class="form-control select2">
                                                <?php
                                                if (!empty($proveedores)) {
                                                    foreach ($proveedores as $proveedor) {
                                                        ?>
                                                        <option value=
                                                                "<?php echo $proveedor['id_proveedor']; ?>">
                                                            <?php echo $proveedor['proveedores']; ?></option>
                                                        <?php
                                                    }
                                                } else {
                                                    ?>
                                                    <option value="0">Debe insertar un Proveedor</option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div> 
									
									
									 <div class="form-group">
                                        <label class="col-md-2 control-label">Condicion:</label>
                                        <div class="col-md-4">
                                            <?php
                                            $condiciones = consultas::get_datos("select * "
                                                            . "from condicion");
                                            ?>                                 
                                            <select name="vcondicion" class="form-control select2">
                                                <?php
                                                if (!empty($condiciones)) {
                                                    foreach ($condiciones as $condicion) {
                                                        ?>
                                                        <option value=
                                                                "<?php echo $condicion['idcondicion']; ?>">
                                                            <?php echo $condicion['desc_condicion']; ?></option>
                                                        <?php
                                                    }
                                                } else {
                                                    ?>
                                                    <option value="0">Debe insertar una Condicion de Compra </option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div> 
									
									
								
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">Numero Factura Compra:</label>
                                        <div class="col-md-2">
                                            <input type="text" class="form-control" name="vnro_factura" 
                                                   required="" autofocus="">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                    <label class="col-md-2 control-label">Nro Pedido:</label>                               
                                    <div class="col-md-4">
                                        <?php $pedidos = consultas::get_datos("select * "
                                                . "from v_pedido where estado != 'ANULADO'"); ?>                                 
                                        <select name="vpedido" class="form-control select2">
                                            <?php
                                            if (!empty($pedidos)) {
                                                echo '<option value="0">Seleccione Pedido</option>';
                                                foreach ($pedidos as $pedido) {
                                                    ?>
                                                    <option value="<?php echo $pedido['idpedido']; ?>">
                                                        <?php echo "Nro Pedido: ".$pedido['idpedido']." - "." Proveedor: ". $pedido['proveedor']; ?></option>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Debe insertar un Pedido</option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>  
                                     <div class="form-group">
                                        <label class="col-md-2 control-label">Tipo Comprobante:</label>
                                        <div class="col-md-4">
                                            <?php
                                            $tipocomprobantes = consultas::get_datos("select * "
                                                            . "from tipocomprobante");
                                            ?>                                 
                                            <select name="vtipocomprobante" class="form-control select2">
                                                <?php
                                                if (!empty($tipocomprobantes)) {
                                                    foreach ($tipocomprobantes as $tipocomprobante) {
                                                        ?>
                                                        <option value=
                                                                "<?php echo $tipocomprobante['idtipocomprobante']; ?>">
                                                            <?php echo $tipocomprobante['desc_tipocomprobante']; ?></option>
                                                        <?php
                                                    }
                                                } else {
                                                    ?>
                                                    <option value="0">Debe insertar un Tipo de Comprobante</option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div> 
                                    <br>
                                    <div class="form-group">
                                        <div class="col-md-offset-2 col-md-10">
                                            <button class="btn btn-primary" type="submit"><i class="fa fa-floppy-o"></i> Grabar</button>
                                        </div>
                                    </div>


                                </form>  
                            </div>
                        </div>
                    </div>
                </div>

            </div> 
            <!--fin-->
            <!--archivos js-->   
            <?php require 'menu/js.ctp'; ?>

            <script>
                function tiposelect() {
                    if (document.getElementById('vcondicion').
                            value === "CONTADO") {
                        document.getElementById('vcancuo').
                                setAttribute('disabled', 'true');
                        document.getElementById('vcancuo').
                                value = '1';
                    } else {
                        document.getElementById('vcancuo').
                                removeAttribute('disabled');
                        document.getElementById('vcancuo').
                                value = '1';
                    }
                }
                window.onload = tiposelect;
            </script>

    </body>
</html>
