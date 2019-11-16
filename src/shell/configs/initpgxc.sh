echo "先尝试清理..."
su - postgres<<EOF
pgxc_ctl clean all
pgxc_ctl init all
#exit
EOF
echo "............"
sleep 3s
echo "尝试初始化..."
su - postgres<<EOF
pgxc_ctl init all
EOF

echo "初始化完毕,测试是否成功"
psql -p 30004 -h 172.42.0.11 -U postgres<<EOF
select * from pgxc_node;
EOF
