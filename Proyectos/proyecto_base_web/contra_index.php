<?php
include("connection.php"); 
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restablecer Contraseña</title>
    <link href="css/style.css" rel="stylesheet">
    <style>
        /* Estilo para ocultar el formulario adicional inicialmente */
        .formulario-adicional {
            display: none;
            margin-top: 20px;
        }
    </style>
    <script>
        // Función para mostrar el formulario adicional al hacer clic en el botón "Aceptar"
        function mostrarFormularioAdicional() {
            var formularioAdicional = document.getElementById('formulario-adicional');
            formularioAdicional.style.display = 'block';
        }
    </script>
</head>
<body>
<br><br><br>
<div class="contenedor">
    <h2>Restablecer contraseña</h2>
</div>

<form action="actualizar_contra.php" method="POST">
    <label for="username"><b>Usuario</b></label>
    <input type="text" placeholder="Ingresa tu Usuario" name="username" required>

    <label for="contrasena"><b>Nueva Contraseña</b></label>
    <input type="password" placeholder="Ingresa tu Nueva Contraseña" name="contrasena" required>
    
    <div class="contenedor">
        <!-- Llama a la función mostrarFormularioAdicional() al hacer clic en el botón -->
        <button type="button" class="boton" onclick="mostrarFormularioAdicional()">Aceptar</button>
    </div>
</form>

<!-- Formulario adicional oculto inicialmente -->
<form id="formulario-adicional" class="formulario-adicional" action="procesar_datos_adicionales.php" method="POST">
    <label for="correo"><b>Correo electrónico</b></label>
    <input type="email" placeholder="Ingresa tu correo electrónico" name="correo" required>

    <label for="ubicacion"><b>Ubicación de tu casa</b></label>
    <input type="text" placeholder="Ingresa la ubicación de tu casa" name="ubicacion" required>

    <div class="contenedor">
        <button class="boton">Confirmar</button>
    </div>
</form>

</body>
</html>
