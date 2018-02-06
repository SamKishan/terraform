 <?php
 function connect(&$db)
 {
	 $db_host="172.28.3.12";
	 $db_user="root";
	 $db_pass="secret";
	 $db_port="3306";
	 $db_name="tennis";
	 $db = mysqli_connect($db_host, $db_user, $db_pass, $db_name, $db_port);
 	if (!$db) 
	{
		print ("Error connecting to DB ". mysqli_connect_error());
			exit;
	} 
} 
	 
 connect($db);
 $query("SELECT * from tennis.player");  
 $result=mysqli_query($db,$query); 
 echo "<html> <title>Sampy Kishan Cloud Tech </title> <table> <tr> <th> name </th><th>Picture</th></tr> "; 
 while($row=mysqli_fetch_row($result)) 
 {
	 echo "<tr><td>$row[1]</td><td> <img src=$row[2]></td></tr>";
 }
 echo "</table></html>"; 
?> 

