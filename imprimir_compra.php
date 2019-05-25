<?php

include_once 'clases/tcpdf/tcpdf.php';
include_once 'clases/conexion.php';

// Extend the TCPDF class to create custom Header and Footer
class MYPDF extends TCPDF {

    // Page footer
    public function Footer() {
        // Position at 15 mm from bottom
        $this->SetY(-15);
        // Set font
        $this->SetFont('helvetica', 'I', 8);
        // Page number
        $this->Cell(0, 0, 'Pag. ' . $this->getAliasNumPage() . '/' . $this->getAliasNbPages(), 0, false, 'R', 0, '', 0, false, 'T', 'M');
    }

}

// create new PDF document // CODIFICACION POR DEFECTO ES UTF-8
$pdf = new MYPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

// set document information
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor('LORENA MENDOZA');
$pdf->SetTitle('REPORTE DE COMPRAS');
$pdf->SetSubject('TCPDF Tutorial');
$pdf->SetKeywords('TCPDF, PDF, example, test, guide');
$pdf->setPrintHeader(false);
// set default header data
$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE, PDF_HEADER_STRING);

// set header and footer fonts
$pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
$pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));


// set default monospaced font
$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

//set margins POR DEFECTO
$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
//$pdf->SetMargins(8,10, PDF_MARGIN_RIGHT);
$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

//set auto page breaks SALTO AUTOMATICO Y MARGEN INFERIOR
$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);
$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

// ---------------------------------------------------------
// TIPO DE LETRA
$pdf->SetFont('times', 'B', 16);

// AGREGAR PAGINA
$pdf->AddPage('L', 'LEGAL');
//celda para titulo

$pdf->Image('img/logo2.png', 25, 5, 50, 30, 'png', '', 'T');
$pdf->Ln();
$pdf->Cell(300, 35, "REPORTE DE COMPRA POR RANGO DE FECHA", 1, 5, 'C');

//SALTO DE LINEA
$pdf->Cell(0, 0, "", 0, 0, 'C');
$pdf->Ln();

//COLOR DE TABLA
$pdf->SetFillColor(255, 255, 255);
$pdf->SetTextColor(0);
$pdf->SetDrawColor(0, 0, 0);
$pdf->SetLineWidth(0.2);


//$pdf->Ln(); //salto
$pdf->SetFont('', '');
$pdf->SetFillColor(255, 255, 255);



if ($_REQUEST['vop'] == '1') {
 $totalCompra = 0;
//consulta a la base de datos
    $compra = consultas::get_datos("select * from v_compra "
                    . " where com_fecha between '" .
                    $_REQUEST['vdesde'] .
                    "' and '" . $_REQUEST['vhasta'] .
                    "' order by id_compra");

    if (!empty($compra)) {

        foreach ($compra as $compra) {
            $pdf->SetFont('', 'B', 10);
            //columnas
            $pdf->SetFillColor(120, 120, 120);
            $pdf->Cell(20, 5, '# COMPRA', 0, 0, 'C', 1);
            $pdf->Cell(70, 5, 'PROVEEDOR', 0, 0, 'C', 1);
            $pdf->Cell(30, 5, 'CI O RUC', 0, 0, 'C', 1);
            $pdf->Cell(30, 5, 'CONDICION', 0, 0, 'C', 1);
            $pdf->Cell(30, 5, 'TOTAL COMPRA', 0, 0, 'C', 1);
            $pdf->Cell(30, 5, 'FECHA', 0, 0, 'C', 1);
            $pdf->Cell(30, 5, 'FACTURA', 0, 0, 'C', 1);
            $pdf->Cell(50, 5, 'ESTADO', 0, 0, 'C', 1);
            $pdf->Ln();

            $pdf->SetFillColor(255, 255, 255);
            $pdf->SetFont('', '', 10);
            $pdf->Cell(20, 5, $compra['id_compra'], 0, 0, 'C', 1);
            $pdf->Cell(70, 5, $compra['proveedor'], 0, 0, 'C', 1);
            $pdf->Cell(30, 5, $compra['ruc'], 0, 0, 'C', 1);
            $pdf->Cell(30, 5, $compra['com_condicion'], 0, 0, 'C', 1);
            $pdf->Cell(30, 5, number_format($compra['com_total'], 0, ',', '.'), 0, 0, 'C', 1);
            $pdf->Cell(30, 5, $compra['fecha'], 0, 0, 'C', 1);
            $pdf->Cell(30, 5, $compra['nro_factura'], 0, 0, 'C', 1);
            $pdf->Cell(50, 5, $compra['com_estado'], 0, 0, 'C', 1);
            $pdf->Ln(); //salto
//            
            $pdf->Ln();
            $pdf->SetFont('times', 'B', 9);
            $pdf->Cell(0, 3, 'DETALLE DE COMPRA NRO.:    ' . $compra['id_compra'], 0, 0, 'C', 0);
            $pdf->Ln();

            $detalles = consultas::get_datos("select * from v_detcompra "
                            . "where id_compra=" . $compra['id_compra'] . " order by id_compra");

            $pdf->SetFont('', 'B', 10);
            $pdf->SetFillColor(188, 188, 188);
            $pdf->Cell(20, 5, 'COD', 1, 0, 'C', 1);
            $pdf->Cell(120, 5, 'ARTICULO', 1, 0, 'C', 1);
            $pdf->Cell(50, 5, 'PRECIO UNIT', 1, 0, 'C', 1);
            $pdf->Cell(40, 5, 'CANT', 1, 0, 'C', 1);
            $pdf->Cell(60, 5, 'SUBTOTAL', 1, 0, 'C', 1);
            $pdf->Ln(); //salto

            $pdf->SetFont('', '', 10);
            $pdf->SetFillColor(255, 255, 255);
            
           
            if (!empty($detalles)) {
                foreach ($detalles as $detalle) {
                    $totalCompra += $detalle['det_subtotal'];
                    $pdf->Cell(20, 5, $detalle['id_articulo'], 1, 0, 'C', 1);
                    $pdf->Cell(120, 5, $detalle['art_descripcion'], 1, 0, 'C', 1);
                    $pdf->Cell(50, 5, number_format($detalle['det_precio_unit'], 0, ',', '.'), 1, 0, 'C', 1);
                    $pdf->Cell(40, 5, $detalle['det_cantidad'], 1, 0, 'C', 1);
                    $pdf->Cell(60, 5, number_format($detalle['det_subtotal'], 0, ',', '.'), 1, 0, 'C', 1);
                    $pdf->Ln();
                }
                $pdf->Ln();
                $pdf->Cell(350, 0, '----------------------------------------------------------------------------------------------------------------------------------------'
                        . '--------------------------------------------------------------------------------------------------------------', 0, 1, 'L');
                $pdf->Ln();
            }else{
                $pdf->SetFont('times', 'B', '10');
                $pdf->SetFillColor(255, 255, 255);
                $pdf->SetTextColor(255, 0, 0);
                $pdf->SetDrawColor(0, 0, 0);
                $pdf->Cell(320, 6, 'NO SE ENCONTRARON DETALLES PARA ESTA COMPRA', 0, 0, 'C', 0);
                $pdf->Ln(); //salto
            }
        }
            $pdf->Ln(); //salto
            $pdf->SetFont('', 'B', 14);
            $pdf->SetTextColor(0);
            $pdf->Cell(65, 5, 'Total de Compras', 1, 0, 'C', 1);
            $pdf->Cell(210, 5,number_format(($totalCompra) ? $totalCompra : 0, 0, ',', '.'), 1, 0, 'R', 1);
            $pdf->Ln(); //salto
    } else {
        $pdf->SetFont('times', 'B', '14');
        $pdf->SetFillColor(255, 255, 255);
        $pdf->SetTextColor(255, 0, 0);
        $pdf->SetDrawColor(0, 0, 0);
        $pdf->Cell(320, 6, 'NO SE ENCONTRARON COMPRAS EN ESE RANGO DE FECHA', 0, 0, 'C', 0);
    }
}



//SALIDA AL NAVEGADOR
$pdf->Output('reporte_compra.pdf', 'I');
?>
