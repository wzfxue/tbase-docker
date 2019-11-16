
useradd postgres
passwd postgres
#su - postgres

mkdir /home/postgres/.ssh
chmod 700 /home/postgres/.ssh
chown -R postgres:postgres /home/postgres
su - postgres -c "ssh-keygen -t rsa"
chown -R postgres:postgres /home/postgres

cat "source /etc/profile">>/home/postgres/.bashrc

#mkdir ~/.ssh
#chmod 700 ~/.ssh
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
#chmod 600 ~/.ssh/authorized_keys
