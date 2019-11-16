wget https://github.com/Tencent/TBase/archive/master.zip -O TBase.zip
unzip TBase.zip
mv TBase-master TBase

sh delete_docker.sh
docker rmi tbase:2
docker build -t tbase:2 .
rm -rf TBase*
#docker run  --privileged=true -itd --name tbase -p 222:22 tbase:2
