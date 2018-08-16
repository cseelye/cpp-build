FROM centos:6.9

# Get a newer set of kernel headers and dev toolchain
RUN rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org && \
    rpm -Uvh http://www.elrepo.org/elrepo-release-6-8.el6.elrepo.noarch.rpm && \
    yum --assumeyes --enablerepo=elrepo-kernel install kernel-lt kernel-lt-headers kernel-lt-devel && \
    yum install --assumeyes centos-release-scl && \
    yum install --assumeyes devtoolset-7 glibc-static doxygen && \
    yum clean all
# Build a newer version of boost
RUN yum install --assumeyes libicu libicu-devel xz-devel zlib-devel zlib python-devel bzip2-devel texinfo && \
    yum clean all && \
    cd /opt && \
    curl -LO https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz && \
    tar xzf boost_1_67_0.tar.gz && \
    scl enable devtoolset-7 "bash -c 'cd /opt/boost_1_67_0 && ./bootstrap.sh --with-icu && ./b2 -d0 -a -j4 --layout=tagged'" && \
    rm boost_1_67_0.tar.gz

CMD ["/usr/bin/scl", "enable", "devtoolset-7", "bash"]

