<?php
function connection(){//Coneccion con la base de datos
    $host = "localhost";
    $user = "root";
    $pass = "";

    $bd = "prueba_base";

    $connect=mysqli_connect($host, $user, $pass);

    mysqli_select_db($connect, $bd);

    return $connect;
}

?>