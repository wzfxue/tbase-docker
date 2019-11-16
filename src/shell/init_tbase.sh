source config-list

echo "创建目录"
for name in $list
do
  docker exec tbase-${name} sh -c "rm -rf /data/*"
  docker exec tbase-${name} sh -c "mkdir -p /data/pg_xlog mkdir -p /data/gtm_master && mkdir -p /data/cn_master/cn001 && mkdir -p /data/dn_master/dn001 && mkdir -p /data/dn_master/dn002 && chown -R postgres:postgres /data"
done

echo "从master节点初始化..."
  echo "初始化pgxc_ctl模版..."
  docker exec tbase-master sh -c "su - postgres -c pgxc_ctl"
  echo "复制配置到容器内..."
  docker cp configs/pgxc_ctl.conf tbase-master:/home/postgres/pgxc_ctl/pgxc_ctl.conf
  docker cp configs/initpgxc.sh tbase-master:/home/postgres/initpgxc.sh
  docker exec tbase-master sh -c "chown postgres:postgres /home/postgres/initpgxc.sh && chmod +x /home/postgres/initpgxc.sh"
  echo "执行tbase初始化..."
  #docker exec -it tbase-master sh -c /home/postgres/initpgxc.sh
  #清理
  docker exec -it tbase-master sh -c "su - postgres -c 'pgxc_ctl clean all'"
  docker exec -it tbase-master sh -c "su - postgres -c 'pgxc_ctl init all'"
