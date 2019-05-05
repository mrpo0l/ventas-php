
<?php
require 'clases/conexion.php'; //llamar a la conexion
?>


<ul class="nav" id="side-menu">
    <li>
        <a href="/ventas/menu.php"><i class="fa fa-dashboard fa-fw">            
            </i> Inicio</a>
    </li>
    
    <?php
    //Obtener el nombre de los modulos
    $modulos = consultas::get_datos("select distinct(mod_cod),
        (mod_nombre) from v_permisos 
        where gru_cod =" . $_SESSION['gru_cod'] . " order by mod_cod");
    ?>  
    <?php foreach ($modulos as $modulo) { ?>
        <li>
            <!--mostrar el nombre de los modulos dentro de cada <li>-->
            <a href="#"><i class="fa fa-edit"></i><?php echo $modulo['mod_nombre']; ?>
                <span class="fa arrow"></span></a> 

            <?php
            //Ob|tener las paginas de acuerdo al modulo
            $paginas = consultas::get_datos("select pag_direc,pag_nombre,
                    leer,insertar,editar,borrar from v_permisos  
                        where mod_cod=" . $modulo['mod_cod'] .
                            " and gru_cod =" . $_SESSION['gru_cod'] .
                            " order by pag_nombre");
            ?>   
            <ul class="nav nav-second-level">                             
                <?php foreach ($paginas as $pagina) { ?>
                    <li>
                        <a href="/ventas/<?php echo $pagina['pag_direc']; ?>">
                            <?php echo $pagina['pag_nombre']; ?>
                        </a>                        
                    </li>
                    <?php $_SESSION[$pagina['pag_nombre']] = $pagina; ?>
                <?php } ?>  
            </ul>
        </li>
    <?php } ?>
</ul>

