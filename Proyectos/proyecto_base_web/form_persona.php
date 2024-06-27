<?php
include("connection.php");
$con = connection();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Registro</title>
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <div class="contenedor">
        <h2>Formulario de Registro</h2>
    </div>
    <form action="ingresar_cliente.php" id="registroForm" method="POST">

        <label for="ci_cli">Cédula de Identidad:</label><br>
        <input type="text" id="ci_cli" name="ci_cli" required><br><br>

        <label for="nombre_cli">Nombre:</label><br>
        <input type="text" id="nombre_cli" name="nombre_cli" required><br><br>

        <label for="apellido_cli">Apellido:</label><br>
        <input type="text" id="apellido_cli" name="apellido_cli" required><br><br>

        <label for="direccion_cli">Dirección:</label><br>
        <input type="text" id="direccion_cli" name="direccion_cli" placeholder="Dirección de tu negocio" required><br><br>

        <label for="username">Usuario:</label><br>
        <input type="text" id="username" name="username" required><br><br>

        <label for="username">Contraseña:</label><br>
        <input type="password" id="contrasena" name="contrasena" required><br><br>

        <label for="fecha_reg_cli">Fecha de Registro:</label><br>
        <input type="date" id="fecha_reg_cli" name="fecha_reg_cli" readonly><br><br>

        <label for="tipo_cli">Tipo De Cliente:</label><br>
        <select name="tipo_cli" required>
            <option value="mayorista" selected>Mayorista</option>
            <option value="minorista">Minorista</option>
        </select><br><br>

        <input type="submit" value="Enviar">
    </form>

    <script>
        document.getElementById("registroForm").addEventListener("submit", function(event) {
            event.preventDefault(); // Evitar que se envíe el formulario automáticamente
            
            // Obtener valores de los campos del formulario
            var ci_cli = document.getElementById("ci_cli").value;
            var nombre_cli = document.getElementById("nombre_cli").value;
            var apellido_cli = document.getElementById("apellido_cli").value;
            var direccion_cli = document.getElementById("direccion_cli").value;
            var username = document.getElementById("username").value;
            var contrasena = document.getElementById("contrasena").value;
            
            // Inicializar variable para almacenar mensajes de alerta
            var alert_messages = "";

            // Validar el tamaño del Carnet de Identidad
            if (ci_cli.length != 8 && ci_cli.length != 9) {
                alert("El Carnet de Identidad debe tener 8 o 9 caracteres");
                event.preventDefault();
                return;
            }

            // Validar que el nombre, apellido y dirección tengan más de 3 caracteres
            if (nombre_cli.length < 4 || apellido_cli.length < 4 || direccion_cli.length < 4) {
                alert("El nombre, apellido y dirección deben tener al menos 4 caracteres.");
                event.preventDefault();
                return;
            }

            // Validar que la contraseña sea segura
            var isSecure = isPasswordSecure(contrasena);
            if (isSecure) {
                alert("La contraseña no es segura. Debe tener al menos 8 caracteres, incluyendo una letra mayúscula, una letra minúscula, un número y un carácter especial.");
                event.preventDefault();
                return;
            }

            // Si hay mensajes de alerta, los mostramos
            if (alert_messages != "") {
                document.getElementById("alertMessages").innerHTML = alert_messages;
            } else {
                // Enviamos el formulario si no hay errores
                document.getElementById("registroForm").submit();
            }
        });

        // Función para validar la seguridad de la contraseña
        function isPasswordSecure(password) {
            var minLength = 8;
            var hasUpperCase = /[A-Z]/.test(password);
            var hasLowerCase = /[a-z]/.test(password);
            var hasNumber = /\d/.test(password);
            var hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

            return password.length >= minLength && hasUpperCase && hasLowerCase && hasNumber && hasSpecialChar;
        }

        // Obtener la fecha actual
        var fechaActual = new Date();
        
        // Formatear la fecha en el formato adecuado para el campo de entrada de fecha
        var formattedDate = fechaActual.getFullYear() + "-" + ((fechaActual.getMonth() + 1) < 10 ? '0' : '') + (fechaActual.getMonth() + 1) + "-" + (fechaActual.getDate() < 10 ? '0' : '') + fechaActual.getDate();
        
        // Establecer la fecha actual en el campo de entrada de fecha
        document.getElementById("fecha_reg_cli").value = formattedDate;
    </script>
</body>
</html>