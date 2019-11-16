
source config-list

#copy到容器内
for name in $list
do
  echo "exec tbase-${name} createRootRsa..."
  docker exec tbase-${name} sh -c "echo 'ssh-keygen -t rsa' > /createRootRsa.sh"
  docker exec tbase-${name} sh -c "chmod +x /createRootRsa.sh"
  docker exec -it tbase-${name} sh -c "/createRootRsa.sh"
done

