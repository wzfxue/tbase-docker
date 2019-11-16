FROM jdeathe/centos-ssh:latest
#FROM centos
MAINTAINER wzhoufeng 1039580989@qq.com

RUN yum -y install gcc gcc-c++ kernel-devel && \
yum -y install readline-devel && \
yum -y install zlib-devel &&\
yum -y install make.x86_64 &&\
yum -y install openssl openssl-devel &&\
yum -y install libxml2 libxml2-devel &&\
yum -y install libxslt libxslt-devel &&\
yum -y install openldap openldap-devel &&\
yum -y install python python-devel &&\
yum -y install gcc-c++ &&\
yum install uuid-devel -y &&\
yum -y install bison.x86_64 &&\
yum -y install flex-devel &&\
yum -y install flex \
yum install -y openssh openssh-server

#修改sshd配置
ADD configs/sshd_config /etc/ssh/

#RUN systemctl enable sshd.service
#RUN systemctl restart sshd.service
VOLUME /tmp/docker
ENV SOURCECODE_PATH /TBase
ENV INSTALL_PATH /usr/local
ADD TBase /TBase
WORKDIR ${SOURCECODE_PATH}

#配置环境变量
ENV PG_HOME=${INSTALL_PATH}/tbase_bin_v2.0    
ENV PATH="${PATH}:${PG_HOME}/bin"
ENV LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PG_HOME/lib"  
ENV LC_ALL=C
#编译tbase
RUN rm -rf ${INSTALL_PATH}/tbase_bin_v2.0
RUN chmod +x configure*
RUN ./configure --prefix=${INSTALL_PATH}/tbase_bin_v2.0  --enable-user-switch --with-openssl  --with-ossp-uuid CFLAGS=-g
RUN make clean
RUN make -sj
RUN make install
RUN chmod +x contrib/pgxc_ctl/make_signature
WORKDIR ${SOURCECODE_PATH}/contrib
RUN make -sj
RUN make install

RUN rm -rf ${SOURCECODE_PATH}
#CMD /usr/sbin/init
ENTRYPOINT /usr/sbin/init
