# install sshpass to by pass password manual ask
sudo apt-get update
sudo apt-get install sshpass
# compress files to deploy
tar -cvzf deploy.tar.gz *
# upload compressed files to the server
sshpass -p $INSTANCE_PASSWORD scp -o StrictHostKeyChecking=no -rp deploy.tar.gz cd@$INSTANCE_IP:/opt/application
# delete compressed file after sent
rm deploy.tar.gz
# stop running application
# rename current directory version to be able to rollback it if necessary
# extract the new downloaded version as current
# start the new application version
sshpass -p $INSTANCE_PASSWORD ssh cd@$INSTANCE_IP << EOF
  killall node
  mv /opt/application/current /opt/application/$(date +"%Y-%m-%d_%H-%M-%S")
  mkdir /opt/application/current
  tar -zxf /opt/application/deploy.tar.gz -C /opt/application/current/
  rm /opt/application/deploy.tar.gz
  cd /opt/application/current
  npm install
  npm start
EOF
