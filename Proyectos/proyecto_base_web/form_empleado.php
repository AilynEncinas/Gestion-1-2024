<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Empleado</title>
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <div class="contenedor">
        <h2>Formulario de Empleado</h2>
    </div>
    <form id="employeeForm" action="ingresar_empleado.php" method="POST">
        <label for="ci_persona">Cédula de Identidad:</label><br>
        <input type="text" id="ci_persona" name="ci_persona" required pattern="[0-9]{7,8}"><br>

        <label for="nombre">Nombre:</label><br>
        <input type="text" id="nombre" name="nombre" required pattern="[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]{4,}"><br>

        <label for="apellido">Apellido:</label><br>
        <input type="text" id="apellido" name="apellido" required pattern="[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]{4,}"><br>

        <label for="username">Nombre de Usuario:</label><br>
        <input type="text" id="username" name="username" required><br>

        <label for="contrasena">Contraseña:</label><br>
        <input type="password" id="contrasena" name="contrasena" required><br>

        <label for="fecha_nacimiento">Fecha de Nacimiento:</label><br>
        <input type="date" id="fecha_nacimiento" name="fecha_nacimiento" required max="2005-12-31"><br>

        <label for="correo">Correo Electrónico:</label><br>
        <input type="email" id="correo" name="correo"><br>

        <label for="numero_telefono">Número de Teléfono:</label><br>
        <input type="text" id="numero_telefono" name="numero_telefono" required pattern="[0-9]{8}" maxlength="8"><br>

        <label for="direccion">Dirección:</label><br>
        <input type="text" id="direccion" name="direccion"><br>

        <label for="salario">Salario:</label><br>
        <input type="text" id="salario" name="salario" required><br>

        <input type="submit" value="Guardar Empleado">
    </form>

    <script>
        document.getElementById('employeeForm').addEventListener('submit', function(event) {
            const requiredFields = document.querySelectorAll('#employeeForm [required]');
            let allFieldsFilled = true;

            requiredFields.forEach(function(field) {
                if (!field.value) {
                    alert('Por favor, complete todos los campos obligatorios.');
                    event.preventDefault();
                    allFieldsFilled = false;
                    return;
                }
            });

            if (!allFieldsFilled) return;

            const ci_persona = document.getElementById('ci_persona').value;
            if (!ci_persona.match(/^\d{7,8}$/)) {
                alert('La cédula de identidad debe tener entre 7 y 8 dígitos.');
                event.preventDefault();
                return;
            }

            const nombre = document.getElementById('nombre').value;
            if (nombre.length < 4) {
                alert('El nombre debe tener al menos 4 caracteres.');
                event.preventDefault();
                return;
            }

            const apellido = document.getElementById('apellido').value;
            if (apellido.length < 4) {
                alert('El apellido debe tener al menos 4 caracteres.');
                event.preventDefault();
                return;
            }

            const fecha_nacimiento = document.getElementById('fecha_nacimiento').value;
            const birthYear = new Date(fecha_nacimiento).getFullYear();
            if (birthYear > 2005) {
                alert('La fecha de nacimiento no puede ser posterior al año 2005.');
                event.preventDefault();
                return;
            }

            const numero_telefono = document.getElementById('numero_telefono').value;
            if (numero_telefono.length !== 8 || !numero_telefono.match(/^\d{8}$/)) {
                alert('El número de teléfono debe tener exactamente 8 dígitos.');
                event.preventDefault();
                return;
            }

            const password = document.getElementById('contrasena').value;
            if (isPasswordSecure(password)) {
                alert('La contraseña no es segura. Debe tener al menos 8 caracteres, incluyendo una letra mayúscula, una letra minúscula, un número y un carácter especial.');
                event.preventDefault();
            }
        });

        function isPasswordSecure(password) {
            const minLength = 8;
            const hasUpperCase = /[A-Z]/.test(password);
            const hasLowerCase = /[a-z]/.test(password);
            const hasNumber = /\d/.test(password);
            const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

            return password.length >= minLength && hasUpperCase && hasLowerCase && hasNumber && hasSpecialChar;
        }
    </script>
</body>
</html>
