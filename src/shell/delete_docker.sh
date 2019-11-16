source ./config-list
for name in $list
do
  docker stop tbase-${name}
  docker rm tbase-${name}
done
