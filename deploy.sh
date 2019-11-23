# install sshpass to by pass password manual ask
sudo apt-get update
sudo apt-get install sshpass
# compress files to deploy
tar -czf deploy.tar.gz .
# upload compressed files to the server
sshpass -p $INSTANCE_PASSWORD scp -o StrictHostKeyChecking=no -rp deploy.tar.gz cd@$INSTANCE_IP:/opt/application
# stop running application
# rename current directory version to be able to rollback it if necessary
# extract the new downloaded version as current
# start the new application version
sshpass -p $INSTANCE_PASSWORD ssh cd@$INSTANCE_IP << EOF
  mv /opt/application/current /opt/application/$(date +"%Y-%m-%d_%H-%M-%S")
  kill -9 $(ps aux | grep '\snode\s' | awk '{print $2}')
  tar -zxf /opt/application/deploy.tar.gz /opt/application/current
  rm /opt/application/deploy.tar.gz
  mkdir /opt/application/current
  cd /opt/application/current
  npm install
  npm start
EOF