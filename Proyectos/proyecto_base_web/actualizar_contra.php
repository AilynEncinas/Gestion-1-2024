<?php
include("connection.php"); // Incluir archivo de conexión a la base de datos
$con = connection();
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = mysqli_real_escape_string($con, $_POST['username']);
    $new_password = $_POST['contrasena'];

    // Validar la nueva contraseña
    if (isPasswordSecure($new_password)) {
        die("Error: La nueva contraseña no es segura.");
    }

    // Llamar al procedimiento almacenado para actualizar la contraseña
    $sql = "CALL actualizar_contra_cli_2('$username', '$new_password')";
    $query = mysqli_query($con, $sql);

    if ($query) {
        Header("Location: index.php");
    } else {
        echo "Error al ejecutar la consulta: " . mysqli_error($con);
    }
} else {
    echo "Método de solicitud no permitido.";
}

// Función para validar la seguridad de la contraseña
function isPasswordSecure($password) {
    $minLength = 8;
    $hasUpperCase = preg_match('/[A-Z]/', $password);
    $hasLowerCase = preg_match('/[a-z]/', $password);
    $hasNumber = preg_match('/\d/', $password);
    $hasSpecialChar = preg_match('/[!@#$%^&*(),.?":{}|<>]/', $password);

}
?>
