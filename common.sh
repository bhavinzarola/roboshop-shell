log_file=/tmp/roboshop.log
rm -f $log_file
nodejs_setup() {

echo -e \\e[36m onfigure Nodejs Repos \\e[0m
curl -fsSL https://rpm.nodesource.com/setup_20.x | bash - &>>${log_file}
echo $?

echo -e \\e[36m Installing nodejs \\e[0m
dnf install -y nodejs &>>${log_file}
echo $?


echo -e \\e[36m Crete App user \\e[0m
useradd -r -s /bin/false appuser &>>${log_file}
echo $?

rm -rf /app
mkdir -p /app

echo -e \\e[36m Download App code \\e[0m
curl -L -o /tmp/${app-name}.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/${app-name}.zip
echo $?
cd /app

echo -e \\e[36m Extract App code\\e[0m
unzip /tmp/${app-name}.zip &>>${log_file}
echo $?

echo -e \\e[36m Compile App Code \\e[0m
npm install --production &>>${log_file}
echo $?

echo -e \\e[36m Set up permission to the App Code \\e[0m
chown -R appuser:appuser /app
chmod o-rwx /app -R
echo $?

echo -e \\e[36m Start Service \\e[0m
systemctl daemon-reload &>>${log_file}
systemctl enable ${app_name} &>>${log_file}
systemctl restart ${app-name} &>>${log_file}
}