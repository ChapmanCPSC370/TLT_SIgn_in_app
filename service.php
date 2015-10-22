<?php
 
// Create connection
$con=mysqli_connect("sql303.byethost7.com","b7_16771638","!Socrat0","b7_16771638_tltsigninapp");
 
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 
$postVar = $_POST['data'];

if (!empty($postVar)) {
    mail("sachour96@gmail.com","IT WORKED","The POST was set and button was pressed!!!!");
}

$sql = $postVar;
 
mysqli_query($con, $sql)
 
// Close connections
mysqli_close($con);
?>