list="master coord node1 node2"


for name in $list
do
docker exec tbase-${name} sh -c "rm -rf /data/*"
docker exec tbase-${name} sh -c "mkdir -p /data/pg_xlog mkdir -p /data/gtm_master && mkdir -p /data/cn_master/cn001 && mkdir -p /data/dn_master/dn001 && mkdir -p /data/dn_master/dn002 && chown -R postgres:postgres /data"
done





