FROM ubuntu:20.04
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install sudo openssl perl

RUN useradd -ms /bin/bash mk
RUN usermod -aG sudo mk
RUN usermod -p `perl -e "print crypt("123","Q4")"` mk

USER mk

WORKDIR /home/mk/

CMD ["/bin/bash"]
