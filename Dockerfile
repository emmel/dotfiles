FROM ubuntu:trusty

MAINTAINER emmel9@gmail.com

RUN apt-get update && \
    apt-get install -y python python-dev python-pip git emacs zsh git-svn texinfo \
                       install-info nodejs npm unixODBC-dev ruby ncurses-term

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN pip install virtualenv
RUN npm install -g yo gulp

RUN mkdir /root/.ssh

RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV TERM screen-256color

ADD ./home /tmp/home

RUN rsync -avz /tmp/home/ /root

CMD /bin/zsh

