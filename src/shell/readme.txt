执行顺序如下：
1. re_build_docker.sh 重新构建镜像,编译安装tbase
2. create_docker.sh 创建容器并且复制脚本
3. 执行容器下的run_createuser.sh(必须)  run_createrootrsa.sh(可选)
4. 执行create_authkey.sh
5. init_tbase.sh

直接执行脚本:autoStart.sh

观察最终结果成功如下：
初始化完毕,测试是否成功
 node_name | node_type | node_port |  node_host  | nodeis_primary | nodeis_preferred |  node_id   | node_cluster_name 
-----------+-----------+-----------+-------------+----------------+------------------+------------+-------------------
 gtm       | G         |     50001 | 172.42.0.10 | t              | f                |  428125959 | tbase_cluster
 cn001     | C         |     30004 | 172.42.0.11 | f              | f                | -264077367 | tbase_cluster
 dn001     | D         |     20008 | 172.42.0.12 | t              | f                | 2142761564 | tbase_cluster
 dn002     | D         |     20009 | 172.42.0.13 | f              | f                |  -17499968 | tbase_cluster
(4 rows)
