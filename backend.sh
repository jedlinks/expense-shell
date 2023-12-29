echo Disabling Nodejs
dnf module disable nodejs -y

echo Enabling Nodejs:18
dnf module enable nodejs:18 -y

echo Insatalling Nodejs
dnf install nodejs -y

echo Downloading Backend Content
cp backend.service /etc/systemd/system/backend.service

echo Adding User
useradd expense

echo Deleting Application Files and Installing Content
rm -rf /app
mkdir /app
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip
cd /app
unzip /tmp/backend.zip

echo Insatalling Dependencies
npm install

echo Reloading and Restarting Backend
systemctl daemon-reload
systemctl enable backend
systemctl restart backend

echo Installing MYSQL
dnf install mysql -y

echo Loading Schema
mysql -h mysql-dev.jedlinks.com -uroot -pExpenseApp@1 < /app/schema/backend.sql