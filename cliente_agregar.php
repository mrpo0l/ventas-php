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
                        <h3 class="page-header">Registar Cliente 
                            <a href="cliente_index.php" 
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
                            <form action="cliente_control.php" method="post" 
                                  role="form" class="form-horizontal">
                                <input type="hidden" name="accion" value="1">
                                <input type="hidden" name="vcod" value="0">
                                <input type="hidden" name="pagina" value="cliente_index.php">
                                
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nombre</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese el nombre"  
                                               class="form-control" name="nombre" id="nom"
                                               >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Apellido</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese el Apellido"  
                                               class="form-control" name="apellido" id="nom"
                                               >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Ciudad</label>
                                    <div class="col-md-3">
                                        <?php
                                        $ciudades = consultas::get_datos("select * from v_ciudad "
                                                        . " order by desc_ciudad");
                                        ?>                                 
                                        <select name="idciudad" class="form-control select2">
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
                                                <option value="0">Si no esta la ciudad debe agregar en la seccion ciudad</option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nro Documento</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese el numero de documento"  
                                               class="form-control" name="documento"
                                               >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Edad</label>
                                    <div class="col-md-5">
                                        <input type="number" required="" placeholder="Ingrese la edad del cliente"  
                                               class="form-control" name="edad" id="edad"
                                               >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Direccion</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese la direccion del cliente"  
                                               class="form-control" name="direccion"
                                               >
                                    </div>
                                </div>


                               
                                <br>
                                <div class="form-group">
                                    <div class="col-md-offset-2 col-md-10">
                                        <button class="btn btn-primary" type="submit"><i class="fa fa-floppy-o"></i> Guardar</button>
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

        <script>
        function shortEdad() {
                var edad = document.getElementById("edad").value;
                console.log(edad)
                if(letras.match((/[a-z]/))){
                   
                }else{
                    alert('Solo letras por favor');
                    document.getElementById("nom").value = "";                  
                }
                
            }
        </script>

       
    </body>
</html>
