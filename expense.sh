log_file=/tmp/expense.log

Head() {
echo -e "\e[36m$*\e[0m"
}

Head Installing Nginx
dnf install nginx -y
echo $?

Head Copying Application Contents
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

Head Removing Old/Default Contens
rm -rf /usr/share/nginx/html/*
echo $?

Head Downloading Application Contents
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip
echo $?

cd /usr/share/nginx/html

Head Installing Frontend
unzip /tmp/frontend.zip
echo $?

Head Enabling and Starting Nginx
systemctl enable nginx
systemctl restart nginx
echo $?