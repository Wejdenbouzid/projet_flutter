<?php

include("dbconnection.php");
$con=dbconnection();

if(isset($_POST["email"]))
{
    $email=$_POST["email"];
}
else return;

$query = "DELETE FROM `user_table` WHERE `uemail`='$email'";

$exe= mysqli_query($con,$query);

$arr=[];

if($exe){
    $arr["success"]="true";
}
else{
    $arr["success"]="false";
}
print(json_encode($arr));
?>