FROM centos:7
MAINTAINER Daniil <zamyatin.daniil@gmail.com>

RUN yum -y update \
  && yum -y install make \
  && yum -y install wget perl-TermReadKey perl-DBI perl-DBD-mysql perl-ExtUtils-MakeMaker perl-Time-HiRes \
  && yum clean all

WORKDIR /var

RUN wget https://github.com/innotop/innotop/archive/v1.11.1.tar.gz \
  && tar xvzf v1.11.1.tar.gz \
  && cd ./innotop-1.11.1 \
  && perl Makefile.PL \
  && make install \
  && cd ../ \
  && rm -rf ./innotop-1.11.1 ./v1.11.1.tar.gz

#https://www.tecmint.com/install-innotop-to-monitor-mysql-server-performance/
#Press “?” to get the summary of command
RUN echo 'alias inno="innotop -u $MYSQL_USER -p $MYSQL_PWD -h $MYSQL_HOSTNAME"' >> ~/.bashrc

RUN touch /random.file
CMD ["tail","-f","/random.file"]
