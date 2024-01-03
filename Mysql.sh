MYSQL_PASSWORD=$1
if [ -z "$MYSQL_PASSWORD" ]; then
  echo Input MYSQL_PASSWORD is missing
  exit 1
fi

source common.sh

Head Disabling MYSQL
dnf module disable mysql -y

Head Copying Repo Files
cp mysql.repo /etc/yum.repos.d/mysql.repo

Head Installing Mysql Community Server
dnf install mysql-community-server -y

Head Enabling and starting MYSQL
systemctl enable mysqld
systemctl restart mysqld

Head Inputing Password
mysql_secure_installation --set-root-pass ${MYSQL_PASSWORD}