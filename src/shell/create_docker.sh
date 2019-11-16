source config-list

docker network rm pgsql
docker network create --subnet=172.42.0.0/16 -d bridge pgsql


count=10
index=0
for name in $list
do
  echo "docker stop tbase-${name}"
  docker stop tbase-${name}
  echo "docker rm tbase-${name}"
  docker rm tbase-${name}
  echo "docker run tbase-${name}  ip=172.42.0.${count}"
  docker run  --privileged=true --network pgsql --hostname ${name} --ip 172.42.0.${count} ${portlist[$index]} -itd --name tbase-${name}  tbase:2
  docker cp configs/createUser.sh tbase-${name}:/createUser.sh
  #docker exec tbase-${name} sh -c "ssh-keygen -t rsa"
  #docker cp tbase-${name}:/root/.ssh/idrsa.pub idrsa-${name}.pub 
  #cat idrsa-${name}.pub >> authorized_keys
  count=$((${count} + 1))
  index=$((${index} + 1))
done

#chmod 700 -R ~/.ssh
#chmod 600 ~/.ssh/authorized_keys 
