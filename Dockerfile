FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN bash
RUN chmod 1777 /tmp
RUN chmod -R 1777 /var/tmp
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# update sources list
RUN apt-get clean
RUN apt-get update

# install basic apps, one per line for better caching
RUN apt-get install -qy apt-utils
RUN apt-get install -qy git
RUN apt-get install -qy locales
RUN apt-get install -qy nano
RUN apt-get install -qy tmux
RUN apt-get install -qy wget
RUN apt-get install -qy sudo
RUN apt-get install -qy curl
RUN apt-get install -qy ssh
RUN apt-get install -qy vim

# remove packages with vulnerabilities 
RUN apt-get -qy purge --auto-remove perl
RUN apt-get -qy purge --auto-remove libapparmor1 
RUN apt-get -qy purge --auto-remove libldap-2.4-2
RUN apt-get -qy purge --auto-remove libsqlite3-0
RUN apt-get -qy purge --auto-remove libxml2
RUN apt-get -qy purge --auto-remove xdg-user-dirs

# cleanup
RUN apt-get -qy autoremove

# locales to UTF-8
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8
