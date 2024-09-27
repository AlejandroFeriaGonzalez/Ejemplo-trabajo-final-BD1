<?php
include "../includes/header.php";
?>

<!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
<h1 class="mt-3">Búsqueda 2</h1>

<p class="mt-3">
mostrar todas las solicitudes que ha revisado el empleado de mayor salario de la facultad de Ingenieria.
</p>

<!-- FORMULARIO. Cambiar los campos de acuerdo a su trabajo -->
<div class="formulario p-4 m-3 border rounded-3">

    <!-- En esta caso, el Action va a esta mismo archivo -->
    <form action="busqueda2.php" method="post" class="form-group">

        <div class="mb-3">
            <label for="codigo" class="form-label">Numero 1</label>
            <input type="number" class="form-control" id="numero1" name="codigo" required>
        </div>
        <button type="submit" class="btn btn-primary">Buscar</button>

    </form>
    
</div>

<?php
// Dado que el action apunta a este mismo archivo, hay que hacer eata verificación antes
if ($_SERVER['REQUEST_METHOD'] === 'POST'):

    // Crear conexión con la BD
    require('../config/conexion.php');

    $codigo = $_POST["codigo"];

    // Query SQL a la BD -> Crearla acá (No está completada, cambiarla a su contexto y a su analogía)
    $query = "SELECT * 
FROM SOLICITUD_ACADEMICA 
JOIN (
    SELECT cedula 
    FROM ADMINISTRATIVO 
    WHERE facultad = $codigo 
    ORDER BY salario DESC 
    LIMIT 1
) AS top_revisor 
ON SOLICITUD_ACADEMICA.revisor = top_revisor.cedula";

    // codigo, fecha_solicitud, tipo_solicitud, valor, estudiante, recepcionista, revisor

    // Ejecutar la consulta
    $resultadoB2 = mysqli_query($conn, $query) or die(mysqli_error($conn));

    mysqli_close($conn);

    // Verificar si llegan datos
    if($resultadoB2 and $resultadoB2->num_rows > 0):
?>

<!-- MOSTRAR LA TABLA. Cambiar las cabeceras -->
<div class="tabla mt-5 mx-3 rounded-3 overflow-hidden">

    <table class="table table-striped table-bordered">

        <!-- Títulos de la tabla, cambiarlos -->
        <thead class="table-dark">
            <tr>
                <th scope="col" class="text-center">Codigo</th>
                <th scope="col" class="text-center">Fecha solicitud</th>
                <th scope="col" class="text-center">Tipo solicitud</th>
                <th scope="col" class="text-center">Valor</th>
                <th scope="col" class="text-center">Estudiante</th>
                <th scope="col" class="text-center">Recepcionista</th>
                <th scope="col" class="text-center">Revisor</th>
            </tr>
        </thead>

        <tbody>

            <?php
            // Iterar sobre los registros que llegaron
            foreach ($resultadoB2 as $fila):
            ?>

            <!-- Fila que se generará -->
            <tr>
                <!-- Cada una de las columnas, con su valor correspondiente -->
                <td class="text-center"><?php echo $fila['codigo']; ?></td>
                <td class="text-center"><?php echo $fila['fecha_solicitud']; ?></td>
                <td class="text-center"><?php echo $fila['tipo_solicitud']; ?></td>
                <td class="text-center"><?php echo $fila['valor']; ?></td>
                <td class="text-center"><?php echo $fila['estudiante']; ?></td>
                <td class="text-center"><?php echo $fila['recepcionista']; ?></td>
                <td class="text-center"><?php echo $fila['revisor']; ?></td>
            </tr>

            <?php
            // Cerrar los estructuras de control
            endforeach;
            ?>

        </tbody>

    </table>
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