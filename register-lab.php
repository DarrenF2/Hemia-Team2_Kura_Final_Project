<?php
include "db_connect.php";

if(mysqli_connect_error()) {
    exit("Error connecting to the database" . mysqli_connect_error());
}

if(!isset($_POST['Fname'], $_POST['email'], $_POST['lab-name'], $_POST['tel-num'], $_POST['lab-code'], $_POST['passw'])) {
    exit("Empty Field(s)");
}

if(empty($_POST['Fname'] || $_POST['email'] || $_POST['lab-name'] || $_POST['tel-num'] || $_POST['lab-code'] || $_POST['passw'])) {
    exit('Values Empty');
}

//Variable log dump
// $stmt = $conn->prepare("SELECT id, passw FROM users WHERE email = ?");
// var_dump($stmt);

if($stmt = $conn->prepare("SELECT id, passw FROM tech_info WHERE email = ?")) {
    $stmt->bind_param("s", $_POST['email']);
    $stmt->execute();
    $stmt->store_result();

    if($stmt->num_rows>0) {
        echo "Email already exists. Try a different email.";
        header("Location: registration-lab.html");
        exit();
    }
    else {
        if($stmt = $conn->prepare("INSERT INTO tech_info (Fname, email, lab_name, tel_num, lab_code, passw) VALUES (?, ?, ?, ?, ?, ?)")) {
            //$password = password_hash($_POST['passw'], PASSWORD_DEFAULT);
            $password = $_POST['passw'];
            $stmt->bind_param("ssssss", $_POST['Fname'], $_POST['email'],  $_POST['lab-name'], $_POST['tel-num'], $_POST['lab-code'], $password);
            $stmt->execute();
            echo "Successfully Registered";
            header("Location: sign-in-lab.html");
            exit();
        }
        else {
            echo  "has Occurred";
        }
    }
}
else {
    echo "An Error has Occurred";
}
$conn->close();
?>