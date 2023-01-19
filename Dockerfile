FROM ubuntu:jammy

ARG UID
ARG GID
ARG UNAME

# install package required for apt-key to work
RUN apt-get update \
    && apt-get install -y gnupg

COPY nymea.list /etc/apt/sources.list.d

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key A1A19ED6 \
    && apt-get update \
    && apt-get install -y nymea-app

RUN if [ $(getent group  ${GID}) ]; then echo 'group exists.'; else groupadd -g ${GID} ${UNAME}; fi

RUN useradd -d /home/${UNAME} -s /bin/bash -m ${UNAME} -u ${UID} -g ${GID}
USER ${UNAME}
ENV HOME /home/${UNAME}

CMD ["/usr/bin/nymea-app"]
