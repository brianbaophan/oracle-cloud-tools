FROM store/oracle/serverjre:1.8.0_241-b07
MAINTAINER Brian Phan brianxphan@gmail.com
ENV LC_ALL=en_US.utf8 \
    LANG=en_US.utf8
ARG OPC_CLI_VERSION=18.1.2
ARG CS_FTM_CLI_VERSION=2.4.3
ENV OPC_CLI_PKG=opc-cli.$OPC_CLI_VERSION.zip
ENV CS_FTM_CLI_PKG=ftmcli-v${CS_FTM_CLI_VERSION}.zip
ADD ${OPC_CLI_PKG} ${CS_FTM_CLI_PKG} /oracle-cloud-tools/
WORKDIR /oracle-cloud-tools/
RUN curl -o /etc/yum.repos.d/public-yum-ol7.repo http://yum.oracle.com/public-yum-ol7.repo \
    && yum-config-manager --enable ol7_developer_EPEL \
    && yum-config-manager --enable ol7_developer \
    && yum -y install unzip python-oci-cli \
    && unzip /oracle-cloud-tools/${OPC_CLI_PKG} \
    && unzip -j ${CS_FTM_CLI_PKG} */*.jar \
    && yum -y install opc-cli-${OPC_CLI_VERSION}.x86_64.rpm \
    && rm -f opc-cli-${OPC_CLI_VERSION}.x86_64.rpm ${OPC_CLI_PKG} ${CS_FTM_CLI_PKG} \
    && rm -rf /var/cache/yum/*
CMD ["/bin/bash"]