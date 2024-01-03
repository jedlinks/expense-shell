source common.sh
Head Installing Nginx
dnf install nginx -y &>>log_file
Stat $?

Head Copying Application Contents
cp expense.conf /etc/nginx/default.d/expense.conf &>>log_file
Stat $?

Head Removing Old/Default Contens
rm -rf /usr/share/nginx/html/* &>>log_file
Stat $?

Head Downloading Application Contents
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>log_file
Stat $?

cd /usr/share/nginx/html &>>log_file

Head Installing Frontend
unzip /tmp/frontend.zip &>>log_file
Stat $?

Head Enabling and Starting Nginx
systemctl enable nginx &>>log_file
systemctl restart nginx &>>log_file
Stat $?