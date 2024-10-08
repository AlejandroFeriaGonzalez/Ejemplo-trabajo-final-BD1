<?php
include "../includes/header.php";
?>

<!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
<h1 class="mt-3">Entidad análoga a CLIENTE (ADMINISTRATIVO)</h1>

<!-- FORMULARIO. Cambiar los campos de acuerdo a su trabajo -->
<div class="formulario p-5 m-4 border rounded-3">

    <form action="cliente_insert.php" method="post" class="form-group">

        <div class="mb-4">
            <label for="cedula" class="form-label">Cédula</label>
            <input type="number" class="form-control" id="cedula" name="cedula" required>
        </div>

        <div class="mb-4">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
        </div>

        <div class="mb-4">
            <label for="salario" class="form-label">Salario</label>
            <input type="number" class="form-control" id="salario" name="salario" required>
        </div>

        <!-- <div class="mb-4">
            <label for="facultad" class="form-label">Facultad</label>
            <input type="text" class="form-control" id="facultad" name="facultad" required>
        </div> -->

        <div class="mb-4">
            <label for="facultad" class="form-label">facultad</label>
            <select name="facultad" id="facultad" class="form-select">
                
                <!-- Option por defecto -->
                <option value="" selected disabled hidden></option>

                <?php
                // Importar el código del otro archivo
                require("../facultad/empresa_select.php");
                
                // Verificar si llegan datos
                if($resultadoEmpresa):
                    
                    // Iterar sobre los registros que llegaron
                    foreach ($resultadoEmpresa as $fila):
                ?>

                <!-- Opción que se genera -->
                <option value="<?= $fila["codigo"]; ?>"><?= $fila["nombre"]; ?> - C.C. <?= $fila["codigo"]; ?></option>

                <?php
                        // Cerrar los estructuras de control
                    endforeach;
                endif;
                ?>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Agregar</button>

    </form>
    
</div>

<?php
// Importar el código del otro archivo
require("cliente_select.php");

// Verificar si llegan datos
if($resultadoCliente and $resultadoCliente->num_rows > 0):
?>

<!-- MOSTRAR LA TABLA. Cambiar las cabeceras -->
<div class="tabla mt-5 mx-3 rounded-3 overflow-hidden">

    <table class="table table-striped table-bordered">

        <!-- Títulos de la tabla, cambiarlos -->
        <thead class="table-dark">
            <tr>
                <th scope="col" class="text-center">Cédula</th>
                <th scope="col" class="text-center">Nombre</th>
                <th scope="col" class="text-center">Salario</th>
                <th scope="col" class="text-center">Facultad</th>
                <th scope="col" class="text-center">Acciones</th>
            </tr>
        </thead>

        <tbody>

            <?php
            // Iterar sobre los registros que llegaron
            foreach ($resultadoCliente as $fila):
            ?>

            <!-- Fila que se generará -->
            <tr>
                <!-- Cada una de las columnas, con su valor correspondiente -->
                <td class="text-center"><?= $fila["cedula"]; ?></td>
                <td class="text-center"><?= $fila["nombre"]; ?></td>
                <td class="text-center"><?= $fila["salario"]; ?></td>
                <td class="text-center"><?= $fila["facultad"]; ?></td>
                
                <!-- Botón de eliminar. Debe de incluir la CP de la entidad para identificarla -->
                <td class="text-center">
                    <form action="cliente_delete.php" method="post">
                        <input hidden type="text" name="cedulaEliminar" value="<?= $fila["cedula"]; ?>">
                        <button type="submit" class="btn btn-danger">Eliminar</button>
                    </form>
                </td>

            </tr>

            <?php
            // Cerrar los estructuras de control
            endforeach;
            ?>

        </tbody>

    </table>
</div>

<?php
endif;

include "../includes/footer.php";
?>