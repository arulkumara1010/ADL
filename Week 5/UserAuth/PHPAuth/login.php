<?php
session_start();
$conn = new mysqli("localhost", "root", "", "user_auth");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];

    $stmt = $conn->prepare("SELECT password FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->store_result();
    $stmt->bind_result($db_password);

    if ($stmt->num_rows > 0) {
        $stmt->fetch();
        if ($password == $db_password) {
            $_SESSION["username"] = $username;
            header("Location: welcome.php");
            exit();
        }
    }
    echo "Invalid username or password.";
}
?>
