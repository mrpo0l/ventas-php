
<!-- jQuery -->
<script src="./vendor/jquery/jquery.min.js"></script>  
<!-- Bootstrap Core JavaScript -->
<script src="./vendor/bootstrap/js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="./vendor/metisMenu/metisMenu.min.js"></script>
<!-- DataTables JavaScript -->
<script src="./js/jquery.dataTables.js"></script>
<script src="./vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<script src="./vendor/datatables-responsive/dataTables.responsive.js"></script>
<script src="./js/bootstrap-notify.js"></script>
<script src="./js/select2.js"></script> 
<script src="./js/bootstrap-formhelpers-number.js"></script> 
<script src="./js/bootstrap-formhelpers.min.js"></script> 

<script src="//cdnjs.cloudflare.com/ajax/libs/moment.js/2.9.0/moment-with-locales.js"></script>
<script src="./js/bootstrap-datetimepicker.js"></script> 
<!-- Custom Theme JavaScript -->
<script src="./dist/js/sb-admin-2.js"></script>

<script src="./vendor/pnotify/pnotify.custom.min.js"></script>

     
<!--captura los mensajes desde la base de datos-->
<script>
    jQuery("document").ready(function () {
        var mensaje = "<?php echo $_SESSION['mensaje'] ?>".split("_");
        var tipo;
        var icono;
        switch (mensaje[1]) {
            case '1':
                tipo = 'success';
                icono = 'glyphicon glyphicon-ok';
                break;
            case '2':
                tipo = 'warning';
                icono = 'glyphicon glyphicon-pencil';
                break;
            case '3':
                tipo = 'danger';
                icono = 'glyphicon glyphicon-trash';
                break;
            default:
                tipo = 'info';
                icono = 'glyphicon glyphicon-exclamation-sign';
        }
        if (mensaje[0] !== '') {
            $.notifyDefaults({
                type: tipo,
                delay: '3000',
                dismiss: false
            });
            $.notify(
                    {
                        icon: icono,
                        message: mensaje[0]
                    }
            , {
                animate: {
                    enter: 'animated lightSpeedIn',
                    exit: 'animated lightSpeedOut'
                }
            });
        }
    });
    "<?php $_SESSION['mensaje'] = null; ?>";
</script>
<!--fin-->
<!--para colocar un tooltip a los elementos-->
<script>
    $(function () {
        $("[rel='tooltip']").tooltip();
    });
</script>
<!--fin-->

<!--enviar foco al elemento input-->
<script>
    $('.modal').on('shown.bs.modal', function () {
        $(this).find('input:text:visible:first').focus();
    });
</script>
<!--fin-->
<!--para el buscador y filtrar-->
<script type="text/javascript">
    $(document).ready(function () {
        (function ($) {
            $('#filtrar').keyup(function () {
                var rex = new RegExp($(this).val(), 'i');
                $('.buscar tr').hide();
                $('.buscar tr').filter(function () {
                    return rex.test($(this).text());
                }).show();
            })

        }(jQuery));
    });
</script> 
<!--lista desplegable buscar-->
<script>
    $(document).ready(function () {
        $(".select2").select2();
    });
</script>
<!--fin-->
<!--Paginación-->
<script type="text/javascript">
    $(document).ready(function() {
        $('#example1').dataTable( {
            responsive: true,
            "language": {
               "url": espanol
            }
        } );
         var espanol = {
        "sProcessing":     "Procesando...",
	"sLengthMenu":     "Mostrar _MENU_ registros",
	"sZeroRecords":    "No se encontraron resultados",
	"sEmptyTable":     "Ningún dato disponible en esta tabla",
	"sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
	"sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
	"sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
	"sInfoPostFix":    "",
	"sSearch":         "Buscar:",
	"sUrl":            "",
	"sInfoThousands":  ",",
	"sLoadingRecords": "Cargando...",
	"oPaginate": {
		"sFirst":    "Primero",
		"sLast":     "Último",
		"sNext":     "Siguiente",
		"sPrevious": "Anterior"
	},
	"oAria": {
		"sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
		"sSortDescending": ": Activar para ordenar la columna de manera descendente"
	}
    }
    } );
   
</script>
   
<script>
    function notificacion(titulo, msg, tipo, time) {
        var option = new Object();
        option.title = titulo;
        option.text = msg;
        option.type = tipo;
        option.delay = time ? time : 2500;
        new PNotify(option);
    }
</script>

