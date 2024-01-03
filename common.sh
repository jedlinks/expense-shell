MYSQL_PASSWORD=$1
if [ -z "$MYSQL_PASSWORD"]; then
  echo Input MYSQL_PASSWORD is missing
  exit 1
fi
log_file=/tmp/expense.log

Head() {
echo -e "\e[36m$*\e[0m"
}

Stat() {
  if [ "$1" -eq 0 ]; then
     echo SUCCESS
  else
     echo FAILURE
     exit 1
  fi
  }