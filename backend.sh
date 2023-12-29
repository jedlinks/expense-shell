log_file=/tmp/expense.log
echo -e "\e[33m Disabling Nodejs\e[0m"
dnf module disable nodejs -y &>>log_file

echo -e "\e[33m Enabling Nodejs:18\e[0m"
dnf module enable nodejs:18 -y &>>log_file

echo -e "\e[33m Insatalling Nodejs\e[0m"
dnf install nodejs -y &>>log_file

echo -e "\e[33m Downloading Backend Content\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>log_file

echo -e "\e[33m Adding User\e[0m"
useradd expense &>>log_file

echo -e "\e[33m Deleting Application Files and Installing Content\e[0m"
rm -rf /app &>>log_file
mkdir /app &>>log_file
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>log_file
cd /app &>>log_file
unzip /tmp/backend.zip &>>log_file

echo -e "\e[33m Insatalling Dependencies\e[0m"
npm install &>>log_file

echo -e "\e[33m Reloading and Restarting Backend\e[0m"
systemctl daemon-reload &>>log_file
systemctl enable backend &>>log_file
systemctl restart backend &>>log_file

echo -e "\e[33m Installing MYSQL\e[0m"
dnf install mysql -y &>>log_file

echo -e "\e[33m Loading Schema\e[0m"
mysql -h mysql-dev.jedlinks.com -uroot -pExpenseApp@1 < /app/schema/backend.sql  &>>log_file