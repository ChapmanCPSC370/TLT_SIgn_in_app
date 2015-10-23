<?php
 
    $postVar = $_POST['data'];
    
    if (!empty($postVar)) {
        mail("sachour96@gmail.com","email subject","The POST was set and button was pressed");
    }

?>