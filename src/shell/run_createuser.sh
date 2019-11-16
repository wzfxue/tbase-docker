list="master coord node1 node2"


for name in $list
do
  #docker cp createUser.sh tbase-${name}:/createUser.sh
  echo "exec tbase-${name}  createUser.sh ****************"
  docker exec -it tbase-${name} sh -c "sh /createUser.sh"
done

echo "配置postgres用户的环境变量"
for name in $list
do
  docker exec tbase-${name} sh -c "echo 'export INSTALL_PATH=/usr/local'>>/home/postgres/.bashrc"
  docker exec tbase-${name} sh -c "echo 'export PG_HOME=\$INSTALL_PATH/tbase_bin_v2.0'>>/home/postgres/.bashrc"
  docker exec tbase-${name} sh -c "echo 'export PATH=\$PATH:\$PG_HOME/bin'>>/home/postgres/.bashrc"
done

