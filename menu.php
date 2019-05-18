<?php
session_start();
?>

<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>FretSmart</title>
  <?php 
        //require './ver_sesion.php';
        ?>
  <!-- Bootstrap Core CSS -->
  <link href="./vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- MetisMenu CSS -->
  <link href="./vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

  <!-- Custom CSS -->
  <link href="./dist/css/sb-admin-2.css" rel="stylesheet">

  <!-- Custom Fonts -->
  <link href="./vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
  <script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/53148/snap.svg-min.js"></script>

  <style>
    @import url(https://fonts.googleapis.com/css?family=Share+Tech);

    body {
      background: #efefef;
    }

    .container {
      width: 400px;
      height: 200px;
      position: relative;
      margin: auto;
      font-family: 'Share Tech', sans-serif;
      color: #444;
    }

    #percent,
    #svg {
      width: 200px;
      height: 200px;
      position: absolute;
      top: 0;
      left: 0;
    }

    #percent {
      line-height: 20px;
      height: 20px;
      width 100%;
      top: 90px;
      font-size: 43px;
      text-align: center;
      color: #3da08d;
      opacity: 0.8
    }

    p,
    .btn {
      position: relative;
      left: 220px;
      width: 200px;
      display: block;
      text-transform: uppercase;
      font-size: 24px;
      top: 30px;
    }

    .btn {
      text-align: center;
      background: #5fc2af;
      color: #fff;
      width: 120px;
      height: 37px;
      line-height: 37px;
      cursor: pointer;
    }

    input {
      border: 0;
      outline: 0;
      border-bottom: 1px solid #eee;
      width: 30px;
      font-family: helvetica;
      font-size: 24px;
      text-transform: capitalise;
      font-family: 'Share Tech', sans-serif;
      background: transparent;

    }
  </style>
  </style>
</head>

<body>
  <div id="wrapper">
    <?php require 'menu/navbar.ctp'; ?>
    <!--BARRA DE HERRAMIENTAS-->
    <?php $fechas = consultas::get_datos("select *from vfecha") ?>
    <div id="page-wrapper">
      <div class="row">
        <div class="col-lg-12">
          <h4 class="page-header"><i><?php echo $fechas[0]['fecha'];  ?></i></h4>
        </div>
        <p>
          <img src="./img/logo2.png" width=200% height=10% align="middle">
          <!-- /.row -->
        </p>
      </div>
    </div>

  </div>
  </div>

  <script>
    var canvasSize = 200,
      centre = canvasSize / 2,
      radius = canvasSize * 0.8 / 2,
      s = Snap('#svg'),
      path = "",
      arc = s.path(path),
      startY = centre - radius,
      runBtn = document.getElementById('run'),
      percDiv = document.getElementById('percent'),
      input = document.getElementById('input');

    input.onkeyup = function (evt) {
      if (isNaN(input.value)) {
        input.value = '';
      }
    };

    runBtn.onclick = function () {
      run(input.value / 100);
    };

    function run(percent) {
      var endpoint = percent * 360;
      Snap.animate(0, endpoint, function (val) {
        arc.remove();

        var d = val,
          dr = d - 90;
        radians = Math.PI * (dr) / 180,
          endx = centre + radius * Math.cos(radians),
          endy = centre + radius * Math.sin(radians),
          largeArc = d > 180 ? 1 : 0;
        path = "M" + centre + "," + startY + " A" + radius + "," + radius + " 0 " + largeArc + ",1 " + endx + "," + endy;

        arc = s.path(path);
        arc.attr({ viewBox: "0 0 500 500" });
        //        var r = s.circle(100,100,100,100).attr({ stroke: '#123456', 'strokeWidth': 20, fill: 'red', 'opacity': 0.2, viewBox: "0 0 500 500" });

        arc.attr({ stroke: 'blue', 'strokeWidth': 12, fill: 'red', 'opacity': 0.2, viewBox: "0 0 500 500" });
        //        arc.attr({
        //         
        //          stroke: '#3da08d',
        //          fill:"none",
        //          strokeWidth: 12
        //        });
        percDiv.innerHTML = Math.round(val / 360 * 100) + '%';

      }, 2000, mina.easeinout);
    }

    run(input.value / 100);

  </script>
  <!-- jQuery -->
  <script src="./vendor/jquery/jquery.min.js"></script>

  <!-- Bootstrap Core JavaScript -->
  <script src="./vendor/bootstrap/js/bootstrap.min.js"></script>

  <!-- Metis Menu Plugin JavaScript -->
  <script src="./vendor/metisMenu/metisMenu.min.js"></script>

  <!-- Custom Theme JavaScript -->
  <script src="./dist/js/sb-admin-2.js"></script>


</body>

</html>