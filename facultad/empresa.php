<?php
include "../includes/header.php";
?>

<!-- TÍTULO. Cambiarlo, pero dejar especificada la analogía -->
<h1 class="mt-3">Entidad análoga a EMPRESA (FACULTAD)</h1>

<!-- FORMULARIO. Cambiar los campos de acuerdo a su trabajo -->
<div class="formulario p-5 m-4 border rounded-3">

    <form action="empresa_insert.php" method="post" class="form-group">

        <div class="mb-4">
            <label for="codigo" class="form-label">codigo</label>
            <input type="number" class="form-control" id="codigo" name="codigo" required>
        </div>

        <div class="mb-4">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
        </div>

        <div class="mb-4">
            <label for="numero_contacto" class="form-label">numero de contacto</label>
            <input type="number" class="form-control" id="numero_contacto" name="numero_contacto" required>
        </div>

        <div class="mb-4">
            <label for="correo_institucional" class="form-label">correo</label>
            <input type="text" class="form-control" id="correo_institucional" name="correo_institucional" required>
        </div>
        
        

        <button type="submit" class="btn btn-primary">Agregar</button>

    </form>
    
</div>

<?php
// Importar el código del otro archivo
require("empresa_select.php");

// Verificar si llegan datos
if($resultadoEmpresa and $resultadoEmpresa->num_rows > 0):
?>

<!-- MOSTRAR LA TABLA. Cambiar las cabeceras -->
<div class="tabla mt-5 mx-3 rounded-3 overflow-hidden">

    <table class="table table-striped table-bordered">

        <!-- Títulos de la tabla, cambiarlos -->
        <thead class="table-dark">
            <tr>
                <th scope="col" class="text-center">codigo</th>
                <th scope="col" class="text-center">nombre</th>
                <th scope="col" class="text-center">numero de contacto</th>
                <th scope="col" class="text-center">correo institucional</th>
                <!-- <th scope="col" class="text-center">Cliente</th> -->
                <th scope="col" class="text-center">Acciones</th>
            </tr>
        </thead>

        <tbody>

            <?php
            // Iterar sobre los registros que llegaron
            foreach ($resultadoEmpresa as $fila):
            ?>

            <!-- Fila que se generará -->
            <tr>
                <!-- Cada una de las columnas, con su valor correspondiente -->
                <td class="text-center"><?= $fila["codigo"]; ?></td>
                <td class="text-center"><?= $fila["nombre"]; ?></td>
                <td class="text-center"><?= $fila["numero_contacto"]; ?></td>
                <td class="text-center"><?= $fila["correo_institucional"]; ?></td>
                <!-- <td class="text-center">C.C. <?= $fila["cliente"]; ?></td> -->
                
                <!-- Botón de eliminar. Debe de incluir la CP de la entidad para identificarla -->
                <td class="text-center">
                    <form action="empresa_delete.php" method="post">
                        <input hidden type="text" name="codigoEliminar" value="<?= $fila["codigo"]; ?>">
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