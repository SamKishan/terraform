/*resource "aws_network_interface" "multi-ip" {
  subnet_id   = "${aws_subnet.main.id}"
  private_ips = ["172.28.3.12", "172.28.0.12"]
}*/
resource "aws_instance" "phpapp" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  private_ip="172.28.0.12"	
  subnet_id = "${aws_subnet.PublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]
  key_name = "${var.key_name}"
  tags {
        Name = "Web Server"
  }
  user_data = <<HEREDOC
  #!/bin/bash
  yum update -y
  yum install -y httpd24 php56 php56-mysqlnd
  service httpd start
  chkconfig httpd on
  sudo mkdir /var/www/html/cloudtech
  sudo touch /var/www/html/cloudtech/index.php
#-------------------------------------  
  sudo echo "   
 <?php
 function connect(&\$db)
 {
         \$db_host=\"172.28.3.12\";
         \$db_user=\"root\";
         \$db_pass=\"secret\";
         \$db_port=\"3306\";
         \$db_name=\"tennis\";
         \$db = mysqli_connect(\$db_host, \$db_user, \$db_pass, \$db_name, \$db_port);
        if (!\$db)
        {
                print (\"Error connecting to DB \". mysqli_connect_error());
                        exit;
        }
}

 connect(\$db);
 \$query(\"SELECT * from tennis.player\");
 \$result=mysqli_query(\$db,\$query);
 echo \"<html> <title>Sampy Kishan Cloud Tech </title> <table> <tr> <th> name </th><th>Picture</th></tr> \";
 while(\$row=mysqli_fetch_row(\$result))
 {
         echo \"<tr><td>$row[1]</td><td> <img src=$row[2]></td></tr>\";
 }
 echo \"</table></html>\";
?>
" > /var/www/html/cloudtech/index.php


 
  


















#-------------------------------------------------
  provisioner "file" {
    source      = " /root/Documents/AWS/a-complete-aws-environment-with-terraform/webserver.php"
    destination = "/var/www/html/cloudtech/index.php"
    private_key = "/root/Documents/Cloud Tech AWS Keys/Fedora.pem"	
	}  
  
HEREDOC
}
	



 
resource "aws_instance" "database" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.micro"
  associate_public_ip_address = "false" 
  private_ip="172.28.3.12"
  subnet_id = "${aws_subnet.PrivateAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.Database.id}"]
  key_name = "${var.key_name}"
  tags {
        Name = "Database Server"
  }
  user_data = <<HEREDOC
  #!/bin/bash
  sleep 180
  yum update -y
  yum install -y mysql55-server
  service mysqld start
  /usr/bin/mysqladmin -u root password 'secret'
  mkdir /home/ec2-user/database
  cd /home/ec2-user/database
  sudo touch database.php
  mysql -u root -p secret -e "create user 'root'@'%' identified by 'secret';" mysql
  mysql -u root -p secret -e "grant select, update, delete, insert on test.* to 'root'@'localhost';" test
 mysql -u root -p secret -e "grant select, update, delete, insert on test.* to 'root'@'172.28.0.12';" test
 mysql -u root -p secret -e "grant select, update, delete, insert on test.* to 'ec2-user'@'localhost';" test
 mysql -u root -p secret -e "grant select, update, delete, insert on test.* to 'ec2-user'@'172.28.0.12';" test

  mysql -u root -p secret -e "CREATE TABLE `test`.`players` 
                                (`id` INT NOT NULL AUTO_INCREMENT, 
                                `Name` VARCHAR(20) NULL,
                                `Picture` VARCHAR(200) NULL,
                                PRIMARY KEY(`id`))
        ENGINE=InnoDB;" test
  mysql -u root -p secret -e "INSERT INTO test.players (Name, Picture) VALUES ('Roger Federer','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Roger_Federer_%2818566686046%29.jpg/350px-Roger_Federer_%2818566686046%29.jpg');" test
 

 mysql -u root -p secret -e "INSERT INTO test.players (Name, Picture) VALUES ('Rafael Nadal','https://static01.nyt.com/images/2017/11/02/sports/02NADAL/02NADAL-master768.jpg');" test
  	
HEREDOC
}
