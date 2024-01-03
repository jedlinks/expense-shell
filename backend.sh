source common.sh
Head Disabling Nodejs
dnf module disable nodejs -y &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Enabling Nodejs:18
dnf module enable nodejs:18 -y &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Insatalling Nodejs
dnf install nodejs -y &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Downloading Backend Content
cp backend.service /etc/systemd/system/backend.service &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Adding User
useradd expense &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Deleting Application Files and Installing Content
rm -rf /app &>>log_file
mkdir /app &>>log_file
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
cd /app &>>log_file
unzip /tmp/backend.zip &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Insatalling Dependencies
npm install &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Reloading and Restarting Backend
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Installing MYSQL
dnf install mysql -y &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi

Head Loading Schema
mysql -h mysql-dev.jedlinks.com -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql  &>>log_file
 if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILURE
    exit 1
    fi