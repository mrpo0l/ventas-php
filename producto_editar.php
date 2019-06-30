
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
                        <h3 class="page-header">Editar Producto 
                            <a href="producto_index.php" class="btn btn-primary btn-circle pull-right" rel='tooltip' title="Atras">
                                <i class="glyphicon glyphicon-arrow-left"></i>
                            </a> 
                        </h3>
                    </div>                       
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">                                         
                        <div class="panel-body">
                            <?php $producto=  consultas::get_datos
                         ("select * from v_producto where idproducto =".$_REQUEST['vidproducto']) ?>
                            
                            <form action="producto_control.php" method="post" role="form" class="form-horizontal">
                                <input type="hidden" name="accion" value="2">
                                <input type="hidden" name="vidproducto" 
                                      value="<?php echo $producto[0]['idproducto']; ?>">
                                <input type="hidden" name="vdesc_producto" value="producto_index.php">
                           
                                



                                <div class="form-group">
                                    <label class="col-md-2 control-label">Descripcion</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese nombre del producto"  
                                               class="form-control" name="desc_producto" 
                                         value="<?php echo $producto[0]['desc_producto']; ?>">
                                    </div>
                                </div>
                                
                                

                               
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Estado</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese nombre del producto"  
                                               class="form-control" name="estado" 
                                         value="<?php echo $producto[0]['estado']; ?>">
                                    </div>
                                </div>


                                


                            <div class="form-group">
                                    <label class="col-md-2 control-label">Tipo de Producto</label>
                                    <div class="col-md-3">
                                        <?php
                                        $tipo_productos = consultas::get_datos("select * from v_tipo_producto "
                                                        . " order by desc_tipo_producto");
                                        
                                        ?>                                 
                                        <select name="cod_tipo_producto" class="form-control select2">
                                            <?php
                                            if (!empty($tipo_productos)) {
                                                foreach ($tipo_productos as $tipo_producto) {
                                            ?>


                                            <?php
                                            if ($diego == $producto['idproducto']) {
                                                
                                            ?>
                                            
                                                    <option selected="selected" value="<?php echo $tipo_producto['cod_tipo_producto']; ?>">
                                                        <?php echo $tipo_producto['desc_tipo_producto']; ?></option>
                                                    <?php
                                                
                                            } else {
                                                ?>
                                                <option value="<?php echo $tipo_producto['cod_tipo_producto']; ?>">
                                                        <?php echo $tipo_producto['desc_tipo_producto']; ?></option>
                                            <?php } ?>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Si no esta el tipo de producto debe agregar en la seccion producto</option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>










                              <div class="form-group">
                                    <label class="col-md-2 control-label">Tipo de Impuesto</label>
                                    <div class="col-md-3">
                                        <?php
                                        $tipo_impuestos = consultas::get_datos("select * from v_tipo_impuesto "
                                                        . " order by desc_tipo_impuesto");
                                        
                                        ?>                                 
                                        <select name="cod_tipo_impuesto" class="form-control select2">
                                            <?php
                                            if (!empty($tipo_impuestos)) {
                                                foreach ($tipo_impuestos as $tipo_impuesto) {
                                            ?>


                                            <?php
                                            if ($FALTASADY == $tipo_impuesto['cod_tipo_impuesto']) {
                                                
                                            ?>
                                            
                                                    <option selected="selected" value="<?php echo $tipo_impuesto['cod_tipo_impuesto']; ?>">
                                                        <?php echo $tipo_impuesto['desc_tipo_impuesto']; ?></option>
                                                    <?php
                                                
                                            } else {
                                                ?>
                                                <option value="<?php echo $tipo_impuesto['cod_tipo_impuesto']; ?>">
                                                        <?php echo $tipo_impuesto['desc_tipo_impuesto']; ?></option>
                                            <?php } ?>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Si no esta el tipo de impuesto debe agregar en la seccion tipo de impuesto</option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>








                                 <div class="form-group">
                                    <label class="col-md-2 control-label">Marca</label>
                                    <div class="col-md-3">
                                        <?php
                                        $marcas = consultas::get_datos("select * from v_marca "
                                                        . " order by nombre");
                                        $darius = $marcas[0]['cod_marca']
                                        ?>                                 
                                        <select name="cod_marca" class="form-control select2">
                                            <?php
                                            if (!empty($marcas)) {
                                                foreach ($marcas as $marca) {
                                            ?>


                                            <?php
                                            if ($darius == $marca['cod_marca']) {
                                                
                                            ?>
                                            
                                                    <option selected="selected" value="<?php echo $marca['cod_marca']; ?>">
                                                        <?php echo $marca['nombre']; ?></option>
                                                    <?php
                                                
                                            } else {
                                                ?>
                                                <option value="<?php echo $marca['cod_marca']; ?>">
                                                        <?php echo $marca['nombre']; ?></option>
                                            <?php } ?>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Si no esta la Marca, agregar en la seccion Marca </option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>


                                 <div class="form-group">
                                    <label class="col-md-2 control-label">Stock</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese el Precio"  
                                               class="form-control" name="stock" 
                                         value="<?php echo $producto[0]['stock']; ?>">
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label class="col-md-2 control-label">Precio</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese el Stock"  
                                               class="form-control" name="precio" 
                                         value="<?php echo $producto[0]['precio']; ?>">
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
