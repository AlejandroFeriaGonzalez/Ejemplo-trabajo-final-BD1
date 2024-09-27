<?php
include "../includes/header.php";
?>

<!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
<h1 class="mt-3">Consulta 2</h1>

<p class="mt-3">
Codigo y nombre de las 3 facultades que mas dinero han manejado revisando solicitudes
</p>

<?php
// Crear conexión con la BD
require('../config/conexion.php');

// Query SQL a la BD -> Crearla acá (No está completada, cambiarla a su contexto y a su analogía)
$query = "SELECT f.codigo, f.nombre
FROM FACULTAD f
JOIN ADMINISTRATIVO a ON f.codigo = a.facultad
JOIN (
    SELECT REVISOR
    FROM SOLICITUD_ACADEMICA
    GROUP BY REVISOR
    ORDER BY SUM(valor) DESC
    LIMIT 3
) top_revisores ON a.cedula = top_revisores.REVISOR";

// Ejecutar la consulta
$resultadoC2 = mysqli_query($conn, $query) or die(mysqli_error($conn));

// Imprimir resultados de la consulta

while ($fila = mysqli_fetch_assoc($resultadoC2)) {
    echo "codigo: " . $fila["codigo"] . " - Nombre: " . $fila["nombre"] . "<br>";
}

// while ($fila = mysqli_fetch_assoc($resultadoC2)) {
//     echo "Código: " . $fila["codigo"] . " - Valor: " . $fila["valor"] . "<br>";
// }

mysqli_close($conn);
?>

<?php
// Verificar si llegan datos
if($resultadoC2 and $resultadoC2->num_rows > 0):
?>

<!-- MOSTRAR LA TABLA. Cambiar las cabeceras -->
<div class="tabla mt-5 mx-3 rounded-3 overflow-hidden">

    <table class="table table-striped table-bordered">

        <!-- Títulos de la tabla, cambiarlos -->
        <thead class="table-dark">
            <tr>
                <th scope="col" class="text-center">Codigo</th>
                <th scope="col" class="text-center">Nombre</th>
            </tr>
        </thead>

        <tbody>

            <?php
            // Iterar sobre los registros que llegaron
            foreach ($resultadoC2 as $fila):
            ?>

            <!-- Fila que se generará -->
            <tr>
                <!-- Cada una de las columnas, con su valor correspondiente -->
                <td class="text-center"><?= $fila["codigo"]; ?></td>
                <td class="text-center"><?= $fila["nombre"]; ?></td>
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

include "../includes/footer.php";
?>