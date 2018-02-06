<?php
$username = "root";
$password = "secret";
$mycon = mysqli_connect("localhost", $username, $password);
$query_1="create user 'root'@'%' identified by 'secret';" ;
$query_2="CREATE DATABASE `tennis`;";
$query_3="grant select, insert, update, delete on tennis.* to 'root'@'localhost';";
$query_4="grant select, insert, update, delete on tennis.* to 'root'@'172.28.0.12';";
$query_5="grant select, insert, update, delete on tennis.* to 'ec2-user'@'localhost';";
$query_6="grant select, insert, update, delete on tennis.* to 'ec2-user'@'172.28.0.12';";
$query_7="CREATE TABLE `tennis`.`players` 
                                (`id` INT NOT NULL AUTO_INCREMENT, 
                                `Name` VARCHAR(20) NULL,
                                `Picture` VARCHAR(200) NULL,
                                PRIMARY KEY(`id`))
        ENGINE=InnoDB;";
$query_8="INSERT INTO tennis.players (Name, Picture) VALUES ('Roger Federer','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Roger_Federer_%2818566686046%29.jpg/350px-Roger_Federer_%2818566686046%29.jpg');";
$query_9="INSERT INTO tennis.players (Name, Picture) VALUES ('Rafael Nadal','https://static01.nyt.com/images/2017/11/02/sports/02NADAL/02NADAL-master768.jpg');";
mysqli_query($mycon,$query_1);
mysqli_query($mycon,$query_2);
mysqli_query($mycon,$query_3);
mysqli_query($mycon,$query_4);
mysqli_query($mycon,$query_5);
mysqli_query($mycon,$query_6);
mysqli_query($mycon,$query_7);
mysqli_query($mycon,$query_8);
mysqli_query($mycon,$query_9);
mysqli_close($mycon);

?>
