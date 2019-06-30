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
                        <h3 class="page-header">Registar Bancos  
                            <a href="banco_index.php" 
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
                            <form action="banco_control.php" method="post" 
                                  role="form" class="form-horizontal">
                                <input type="hidden" name="accion" value="1">
                                <input type="hidden" name="vcod" value="0">
                                <input type="hidden" name="pagina" value="banco_index.php">
                                
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Nombre</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" placeholder="Ingrese nombre"  
                                               class="form-control" name="vnombre" id="nom"
                                               >
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Dirección</label>
                                    <div class="col-md-8">
                                        <input type="text" required="" 
                                               placeholder="Ingrese dirección" 
                                               class="form-control" name="vdirec">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-md-2 control-label">Telefono</label>
                                    <div class="col-md-5">
                                        <input type="text" required="" 
                                               placeholder="Ingrese telefono" 
                                               class="form-control bfh-phone" data-format="+595 (ddd) ddd-ddd" name="vtel">
											  
                                    </div>
                                </div>
                                

                                <div class="form-group">
                                    <label class="col-md-2 control-label">Ciudad</label>
                                    <?php $ciudades = consultas::get_datos("select * from ciudad order by idciudad"); ?>
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
            function validar() {
                var hoy = new Date();
                var fechaFormulario = new Date($('#fec').val());
                if (fechaFormulario > hoy) {
                    alert('Fecha superior al actual..!!');
                    $('#fec').val(hoy);
                }
                else {

                }
            }
            function nronegativo() {
                //ID numero puede ser un input text.
                var numero = document.getElementById("ci").value;
                //numero ahora es string
                if (numero.match(/^-?[0-9]+(\.[0-9]{1,2})?$/))
                {
//                    alert("numero ok");
                }
                else
                {
                    alert("No se permite numeros negativos ni letras");
                    document.getElementById("ci").value = "";
                }
            }
            function reemplazar() {
                var res = document.getElementById("nom").value.replace("'", "");
                document.getElementById("nom").value = res;
//                alert(res);
            }
            
        </script>
        
        

        <script type="text/javascript">
            $(function () {
                $('#datetimepicker5').datetimepicker({
                    defaultDate: "01/01/1900",
                    locale: 'es',
                    viewMode: 'years',
                    format: 'DD/MM/YYYY'
                  
                });
            });
        </script>
    </body>
</html>
