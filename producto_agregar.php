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
                        <h3 class="page-header">Registar Producto 
                            <a href="producto_index.php" 
                               class="btn btn-primary btn-circle pull-right" 
                               rel='tooltip' title="Atras">
                                <i class="glyphicon glyphicon-arrow-left"></i>
                            </a> 
                        </h3>
                    </div>                       
                </div>
                <!-- /.row -->
                <div class="row">
                    <div class="col-lg-12">                                         
                        <div class="panel-body">
                            <form action="producto_control.php" method="post" 
                                  role="form" class="form-horizontal">
                                <input type="hidden" name="accion" value="1">
                                <input type="hidden" name="vidproducto" value="0">
                                <input type="hidden" name="vdesc_producto" value="producto_index.php">
                                
                         
                                 <div class="form-group">
                                    <label class="col-md-2 control-label">Descripcion</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese la description del producto"  
                                               class="form-control" name="desc_producto" id="nom"
                                               >
                                    </div>
                                </div>
                                
                                 <div class="form-group">
                                    <label class="col-md-2 control-label">Estado</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese nombre del estado"  
                                               class="form-control" name="estado" id="nom"
                                               >
                                    </div>
                                </div>

                               



                                 <div class="form-group">
                                    <label class="col-md-2 control-label">Tipo de Producto</label>
                                    <?php $tipo_productos = consultas::get_datos("select * from v_tipo_producto order by desc_tipo_producto"); ?>
                                    <div class="col-md-3">
                                        <select name="cod_tipo_producto" class="form-control select2" >
                                            <?php
                                            if (!empty($tipo_productos)) {
                                                foreach ($tipo_productos as $tipo_producto) {
                                                    ?>
                                                    <option value="<?php echo $tipo_producto['cod_tipo_producto']; ?>">
                                                        <?php echo $tipo_producto['desc_tipo_producto']; ?></option>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Debe insertar un tipo de producto</option>
                                            <?php } ?>    
                                        </select>
                                    </div>
                                </div>   







                                <div class="form-group">
                                    <label class="col-md-2 control-label">Tipo de Impuesto</label>
                                    <?php $tipo_impuestos = consultas::get_datos("select * from v_tipo_impuesto order by desc_tipo_impuesto"); ?>
                                    <div class="col-md-3">
                                        <select name="cod_tipo_impuesto" class="form-control select2" >
                                            <?php
                                            if (!empty($tipo_impuestos)) {
                                                foreach ($tipo_impuestos as $tipo_impuesto) {
                                                    ?>
                                                    <option value="<?php echo $tipo_impuesto['cod_tipo_impuesto']; ?>">
                                                        <?php echo $tipo_impuesto['desc_tipo_impuesto']; ?></option>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Debe insertar un tipo de impuesto</option>
                                            <?php } ?>    
                                        </select>
                                    </div>
                                </div>   





                                 


                                 <div class="form-group">
                                    <label class="col-md-2 control-label">Marca</label>
                                    <?php $marcas = consultas::get_datos("select * from v_marca order by nombre"); ?>
                                    <div class="col-md-3">
                                        <select name="cod_marca" class="form-control select2" >
                                            <?php
                                            if (!empty($marcas)) {
                                                foreach ($marcas as $marca) {
                                                    ?>
                                                    <option value="<?php echo $marca['cod_marca']; ?>">
                                                        <?php echo $marca['nombre']; ?></option>
                                                    <?php
                                                }
                                            } else {
                                                ?>
                                                <option value="0">Debe insertar una Marca</option>
                                            <?php } ?>    
                                        </select>
                                    </div>
                                </div>   





                              
                                  <div class="form-group">
                                    <label class="col-md-2 control-label">Stock</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese nombre del Stock"  
                                               class="form-control" name="stock" id="nom"
                                               >
                                    </div>
                                </div>




                                  <div class="form-group">
                                    <label class="col-md-2 control-label">Precio</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese el Precio"  
                                               class="form-control" name="precio" id="nom"
                                               >
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
                <!-- /.col-lg-12 -->
            </div>

        </div> 
        <!--fin-->
        <!--archivos js-->   
        <?php require 'menu/js.ctp'; ?>
        <script>
            
            function reemplazar() {
                var res = document.getElementById("nom").value.replace("'", "");
                document.getElementById("nom").value = res;
//                alert(res);
            }
            
        </script>
        
        <script>
            function sololetras() {
                var letras = document.getElementById("nom").value;
                if(letras.match((/[a-z]/))){
                   
                }else{
                    alert('Solo letras por favor');
                    document.getElementById("nom").value = "";                  
                }
            }
        </script>

       
    </body>
</html>
