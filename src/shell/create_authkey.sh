list="master coord node1 node2"


echo "免密postgres设置..."
rm -f authorized_keys
#从容器内将公钥取出
for name in $list
do
  docker cp tbase-${name}:/home/postgres/.ssh/id_rsa.pub idrsa-${name}.pub
  cat idrsa-${name}.pub >> authorized_keys
done
rm -f idrsa-*.pub

#copy到容器内
for name in $list
do
  docker cp authorized_keys  tbase-${name}:/home/postgres/.ssh/
  docker exec tbase-${name} sh -c "chmod 700 -R /home/postgres/.ssh"
  docker exec tbase-${name} sh -c "chmod 600 /home/postgres/.ssh/authorized_keys"
  docker exec tbase-${name} sh -c "chown postgres:postgres /home/postgres/.ssh/authorized_keys"
  docker exec tbase-${name} sh -c "mkdir -p /data/pg_xlog mkdir -p /data/gtm_master && mkdir -p /data/cn_master/cn001 && mkdir -p /data/dn_master/dn001 && mkdir -p /data/dn_master/dn002 && chown -R postgres:postgres /data"
done



echo "免密root设置..."
#root
rm -f authorized_keys
#从容器内将公钥取出
for name in $list
do
  docker cp tbase-${name}:/root/.ssh/id_rsa.pub idrsa-${name}.pub
  cat idrsa-${name}.pub >> authorized_keys
done
rm -f idrsa-*.pub

#copy到容器内
for name in $list
do
  docker cp authorized_keys tbase-${name}:/root/.ssh/
  docker exec tbase-${name} sh -c "chmod 700 -R /root/.ssh"
  docker exec tbase-${name} sh -c "chmod 600 /root/.ssh/authorized_keys"
done


