# !/bin/bash

ID=$(id-u)

R= "\e [31m"
G= "\e [32m"
Y= "\e [33m"
N= "\e [0m"

TIMESTAMP= $(date +%F -%H -%M -%S )
LOGFILE= "/tmp/$0-$TIMESTAMP.log"
echo "script started exceuting at $TIMESTAMP" &>> $LOGFILE

VALIDATE () {
    
if [ $1 -ne 0]
     then
        echo -e "$2...$R FAILED $N"
    exit 1 # it comes out once it failed
else 
     echo -e "$2...$G SUCCESS $N"
     
     fi # Reverse of if 

}

if [ $ID -ne 0]

  then 
  echo -e  "$R ERROR :: Please run this script with root access $N"

  exit 1

else 
  echo "you are root User"

fi

cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

VALIDATE $? "copied MongoDB Repo"

dnf install mongodb-org -y &>> $LOGFILE

VALIDATE $? "Installing MongoDB"

systemctl enable mongod &>> $LOGFILE

VALIDATE $? "enabling  MongoDB"

systemctl start mongod &>> $LOGFILE

VALIDATE $? "starting  MongoDB"

sed -i 's /127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $LOGFILE

VALIDATE $? "Remote acess to MongoDB"

systemctl restart mongod &>> $LOGFILE

VALIDATE $? "Restarting MongoDB"






