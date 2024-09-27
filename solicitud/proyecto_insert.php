<?php
 
// Crear conexión con la BD
require('../config/conexion.php');

// Sacar los datos del formulario. Cada input se identifica con su "name"
$codigo = $_POST["codigo"];
$fecha_solicitud = $_POST["fecha_solicitud"];
$tipo_solicitud = $_POST["tipo_solicitud"];
$estudiante = $_POST["estudiante"];
$valor = $_POST["valor"];
$recepcionista = $_POST["recepcionista"];
$revisor = $_POST["revisor"];

// Query SQL a la BD. Si tienen que hacer comprobaciones, hacerlas acá (Generar una query diferente para casos especiales)
$query = "INSERT INTO `solicitud_academica`(`codigo`,`fecha_solicitud`, `tipo_solicitud`,`estudiante`, `valor`, `recepcionista`, `revisor`)
VALUES ('$codigo', '$fecha_solicitud', '$tipo_solicitud',  '$estudiante', '$valor', '$recepcionista', '$revisor')";

// Ejecutar consulta
$result = mysqli_query($conn, $query) or die(mysqli_error($conn));

// Redirigir al usuario a la misma pagina
if($result):
    // Si fue exitosa, redirigirse de nuevo a la página de la entidad
	header("Location: proyecto.php");
else:
	echo "Ha ocurrido un error al crear la persona";
endif;

mysqli_close($conn);