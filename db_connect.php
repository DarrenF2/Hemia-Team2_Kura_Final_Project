<?php
    $DATABASE_HOST = "database-2.ceggbiv2fjia.us-east-1.rds.amazonaws.com";
    $DATABASE_USER = "adminroot";
    $DATABASE_PASS = "welcome123";
    $DATABASE_NAME = "hemia";

    $conn = mysqli_connect($DATABASE_HOST, $DATABASE_USER, $DATABASE_PASS, $DATABASE_NAME);

    if(!$conn) {
        echo "Connection Failed";
    }
?>