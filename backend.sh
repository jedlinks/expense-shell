echo -e "\e[33m Disabling Nodejs\e[0m"
dnf module disable nodejs -y &>>/tmp/expense.log

echo -e "\e[33m Enabling Nodejs:18\e[0m"
dnf module enable nodejs:18 -y &>>/tmp/expense.log

echo -e "\e[33m Insatalling Nodejs\e[0m"
dnf install nodejs -y &>>/tmp/expense.log

echo -e "\e[33m Downloading Backend Content\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

echo -e "\e[33m Adding User\e[0m"
useradd expense &>>/tmp/expense.log

echo -e "\e[33m Deleting Application Files and Installing Content\e[0m"
rm -rf /app &>>/tmp/expense.log
mkdir /app &>>/tmp/expense.log
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>/tmp/expense.log
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log

echo -e "\e[33m Insatalling Dependencies\e[0m"
npm install &>>/tmp/expense.log

echo -e "\e[33m Reloading and Restarting Backend\e[0m"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log

echo -e "\e[33m Installing MYSQL\e[0m"
dnf install mysql -y &>>/tmp/expense.log

echo -e "\e[33m Loading Schema\e[0m"
mysql -h mysql-dev.jedlinks.com -uroot -pExpenseApp@1 < /app/schema/backend.sql  &>>/tmp/expense.log