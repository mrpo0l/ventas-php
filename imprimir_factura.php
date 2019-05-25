<?php

// Include the main TCPDF library (search for installation path).
include_once 'clases/tcpdf/tcpdf.php';
include_once 'clases/conexion.php';

$sqlpedidos = "select *,(select numero_letras(total_pedido)) "
        . "as total_letra "
      . " from v_pedido where idpedido = " . 
        $_REQUEST ['vcod'] . " order by 1";
$rspedidos = consultas::get_datos($sqlpedidos);


// create new PDF document
$pdf = new TCPDF('P', 'mm', 'A4');
$pdf->SetMargins(15, 15, 18);
$pdf->SetTitle('PEDIDO');
$pdf->SetPrintHeader(false);
$pdf->SetPrintFooter(false);

$pdf->AddPage();
// posicion para la imagen izquierda, arriba, ancho, derecha
$pdf->Ln(5);
$pdf->Image ('img/logo2.png',35,15,50,30,'png','','T');

// primero se define el formato y despues el texto
$pdf->SetFont('Times', 'B', 18);

//$pdf->Cell(85, 1, 'LM Electricidad', 0, 0, 'C',null,null,1);

$pdf->Cell(125, 20, 'Factura ' , 0, 1, 'C');

$pdf->SetFont('Times', 'B', 9);

$pdf->Cell(85, 20, 'INSUMOS ELECTRICOS POR MAYOR Y MENOR', 0, 0, 'C');

$pdf->SetFont('Times', 'B', 12);

$pdf->Cell(100, 1, 'NRO.: ' . $rspedidos[0]['idpedido'], 0, 1, 'C');

$pdf->SetFont('Times', '', 9);

$pdf->Cell(85, 25, 'Dirección: Tacuary c/ Rodriguez de Francia', 0, 0, 'C');

$pdf->Cell(100, 2, 'Usuario: ' . 'admin', 0, 1, 'C');

$pdf->Cell(85, 30, 'Teléfono: 0983 651 623', 0, 0, 'C');

//$pdf->Cell(100, 1, 'Vigencia: ' . '2017-12-31', 0, 1, 'C');

$style6 = array('width' => 0.5, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0));
//$pdf->SetLineStyle(array('width' => 0.5, 'cap' => 'butt', 'join' => 'miter', 'dash' => 0, 'color' => array(0, 0, 255)));

//cuadros de arriba
$pdf->RoundedRect(15, 12, 90, 50, 6.0, '1111', '', $style6, array(200, 200, 200));
$pdf->RoundedRect(105, 12, 87, 50, 6.0, '1111', '', $style6, array(200, 200, 200));

//cuadro de cabecera
$pdf->RoundedRect(15, 62, 177, 30, 5.0, '1111', '', $style6, array(200, 200, 200));

//datos de cabecera
$pdf->Ln(22);
//Fecha
$pdf->SetFont('Times', 'B', 10);
$pdf->Cell(30, 1, '   FECHA: ', 0, 0, 'L');
$pdf->SetFont('Times', '', 10);
$pdf->Cell(/*1*/90, /*2*/1, /*3*/$rspedidos[0]['fecha'], /*4*/0, /*5*/1, /*6*/'L', /*7*/null, /*8*/null, /*9*/1, /*10*/null, /*11*/null, /*12*/null);
$pdf->Ln(3);
//nombre cliente
$pdf->SetFont('Times', 'B', 10);
$pdf->Cell(30, 1, '   PROVEEDOR: ', 0, 0, 'L');
$pdf->SetFont('Times', '', 10);
$pdf->Cell(/*1*/90, /*2*/1, /*3*/$rspedidos[0]['proveedor'], /*4*/0, /*5*/0, /*6*/'L', /*7*/null, /*8*/null, /*9*/1, /*10*/null, /*11*/null, /*12*/null);

//ruc cliente
$pdf->SetFont('Times', 'B', 10);
$pdf->Cell(20, 1, 'RUC o CI: ', 0, 0, 'L');
$pdf->SetFont('Times', '', 10);
$pdf->Cell(90, 1, $rspedidos[0]['pro_ci'], 0, 1, 'L');

$pdf->Ln(3);
//dirección cliente
$pdf->SetFont('Times', 'B', 10);
$pdf->Cell(30, 1, '   DIRECCION: ', 0, 0, 'L');
$pdf->SetFont('Times', '', 10);
$pdf->Cell(/*1*/90, /*2*/1, /*3*/$rspedidos[0]['pro_direccion'], /*4*/0, /*5*/0, /*6*/'L', /*7*/null, /*8*/null, /*9*/1, /*10*/null, /*11*/null, /*12*/null);


//telefono cliente
$pdf->SetFont('Times', 'B', 10);
$pdf->Cell(25, 1, 'TELEFONO:   ', 0, 0, 'L');
$pdf->SetFont('Times', '', 10);
$pdf->Cell(/*1*/37, /*2*/1, /*3*/$rspedidos[0]['pro_telefono'], /*4*/0, /*5*/0, /*6*/'L', /*7*/null, /*8*/null, /*9*/1, /*10*/null, /*11*/null, /*12*/null);

//cuadro de detalles
$pdf->RoundedRect(15, 92, 177, 140, 5.0, '1111', '', $style6, array(200, 200, 200));

$pdf->Ln(20);
$pdf->SetFont('Times', 'B', 10);
$pdf->Cell(15, 1, '#', 0, 0, 'C');
$pdf->Cell(51, 1, 'Descripcion', 0, 0, 'L');
$pdf->Cell(25, 1, 'Cant.', 0, 0, 'C');
$pdf->Cell(40, 1, 'Precio Unit', 0, 0, 'R');
$pdf->Cell(30, 1, 'Subtotal', 0, 0, 'R');
$pdf->Ln(5);

$consultas = "select * from v_detpedido where idpedido=".$_REQUEST ['vcod'];
$detpedidos = consultas::get_datos($consultas);

foreach ($detpedidos as $report) {
    $pdf->SetFont('Times', '', 10);
	  

    $pdf->Cell(15, 1, $report['idproducto'], 0, 0, 'C');
	$pdf->Cell(51, 1, /*3*/$report['desc_producto'], 0, 0,'L',null,null,1,null,null,null);
      $pdf->Cell(25, 1,$report['cantidad_pedido'] , 0, 0, 'C');
    $pdf->Cell(40, 1, $report['precio'] , 0, 0, 'R'); 
    $pdf->Cell(30, 1, number_format(($report['subtotal']),0,',','.'), 0, 1, 'R');
	}
// linea de cierre de pedido
	$posicion = $pdf->GetY();
$pdf->Line(190,230,15,$posicion);


//cuadro de subtotales
$pdf->RoundedRect(15, 232, 177, 30, 4.0, '1111', '', 
        $style6, array(200, 200, 200));


$pdf->SetFont('Times', 'B', 10);
$pdf->Text(18, 243, 'TOTAL GENERAL');
$pdf->SetFont('Times', '', 10);
$pdf->Text(165, 243, 'Gs. '.
        number_format(($rspedidos[0]['total_pedido']),0,',','.'));
$pdf->SetFont('Times', 'B', 10);
$pdf->Text(18, 251, 'TOTAL EN LETRAS');
$pdf->SetFont('Times', '', 10);
$pdf->Text(55, 251, 'Son Gs. '.
        ucfirst(strtolower ($rspedidos[0]['total_letra'])));
// Close and output PDF document
// This method has several options, check the source code documentation for more information.
$pdf->Output('Pedido.pdf', 'I');

//============================================================+
// END OF FILE
//============================================================+

