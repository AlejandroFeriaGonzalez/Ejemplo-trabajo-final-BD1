<?php
include "../includes/header.php";
?>

<!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
<h1 class="mt-3">Búsqueda 1</h1>

<p class="mt-3">
    Dos fechas f1 y f2 (cada fecha con día, mes y año), f2 ≥ f1. Se debe mostrar el total de dinero proveniente de revisiones de un administrativo entre en dicho rango de fechas [f1, f2].
</p>

<!-- FORMULARIO. Cambiar los campos de acuerdo a su trabajo -->
<div class="formulario p-4 m-3 border rounded-3">

    <!-- En esta caso, el Action va a esta mismo archivo -->
    <form action="busqueda1.php" method="post" class="form-group">

        <div class="mb-3">
            <label for="fecha1" class="form-label">Fecha 1</label>
            <input type="date" class="form-control" id="fecha1" name="fecha1" required>
        </div>

        <div class="mb-3">
            <label for="fecha2" class="form-label">Fecha 2</label>
            <input type="date" class="form-control" id="fecha2" name="fecha2" required>
        </div>

        <div class="mb-3">
            <label for="numero" class="form-label">Cédula</label>
            <input type="number" class="form-control" id="numero" name="cedula" required>
        </div>

        <button type="submit" class="btn btn-primary">Buscar</button>

    </form>
    
</div>

<?php
// Dado que el action apunta a este mismo archivo, hay que hacer eata verificación antes
if ($_SERVER['REQUEST_METHOD'] === 'POST'):

    // Crear conexión con la BD
    require('../config/conexion.php');

    $fecha1 = $_POST["fecha1"];
    $fecha2 = $_POST["fecha2"];
    $cedula = $_POST["cedula"];

    // Validar y formatear las fechas
    // try {
    //     $fecha1 = (new DateTime($fecha1))->format('Y-n-j');
    //     $fecha2 = (new DateTime($fecha2))->format('Y-n-j');
    // } catch (Exception $e) {
    //     die("Formato de fecha inválido");
    // }

    // // Escapar los valores para evitar inyecciones SQL
    // $fecha1 = mysqli_real_escape_string($conn, $fecha1);
    // $fecha2 = mysqli_real_escape_string($conn, $fecha2);
    // $cedula = mysqli_real_escape_string($conn, $cedula);
    // Query SQL a la BD -> Crearla acá (No está completada, cambiarla a su contexto y a su analogía)

    $query = "SELECT SUM(valor) AS total FROM SOLICITUD_ACADEMICA WHERE REVISOR = $cedula AND fecha_solicitud BETWEEN '$fecha1' AND '$fecha2'";

    // imprimir los valores
    echo "Fecha 1: $fecha1 <br>";
    echo "Fecha 2: $fecha2 <br>";

    // Ejecutar la consulta
    $resultadoB1 = mysqli_query($conn, $query) or die(mysqli_error($conn));

    mysqli_close($conn);

    // Verificar si llegan datos
    if($resultadoB1 and $resultadoB1->num_rows > 0):
?>
<!-- Mostrar total recaudado -->
<div class="alert alert-success text-center mt-5">
    <?php 
    foreach ($resultadoB1 as $fila):
        echo "Total recaudado: " . $fila["total"];
    endforeach;
    ?>
</div>

<!-- Mensaje de error si no hay resultados -->
<?php
else:
?>

<div class="alert alert-danger text-center mt-5">
    No se encontraron resultados para esta consulta
</div>

<?php
    endif;
endif;

include "../includes/footer.php";
?>