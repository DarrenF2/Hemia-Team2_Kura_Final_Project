<?php
session_start();
include "db_connect.php";

if (isset($_POST['email']) && isset($_POST['passw'])) {

    function validate($data)
    {
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    }
}

$email = validate($_POST["email"]);
$password = validate($_POST["passw"]);
//$hash_p = password_hash($password, PASSWORD_DEFAULT);


if (empty($email)) {
    header("Location: sign-in-doc.html?erro=Email is required");
    exit();
} else if (empty($password)) {
    header("Location: sign-in-doc.html?erro=Password is required");
    exit();
}

$sql = "SELECT * from doc_info WHERE email='$email';";
//var_dump($sql);

$result = mysqli_query($conn, $sql);
//var_dump(mysqli_error($conn));

//var_dump($result);

if (mysqli_num_rows($result) === 1) {
    $row = mysqli_fetch_assoc($result);
    //var_dump(mysqli_num_rows($result));
    //if($row['email'] === $email) {
        // var_dump($password);
        // var_dump($row['passw']);
    //if (password_verify($row['passw'], $password))
    if ($row['passw'] == $password) {
        echo "Logged In";
        //$password = password_hash($_POST['passw'], PASSWORD_DEFAULT);

        $_SESSION['email'] = $row['email'];
        $_SESSION['Fname'] = $row['Fname'];
        $_SESSION['id'] = $row['id'];
        header("Location: doctor-list.html");
        exit();
     } 
    else {
         header("Location: sign-in-doc.html?error=Incorrect Email or Password");
         exit();
     }
}
else {
     header("Location: sign-in-doc.html");
     exit();
}
