FROM ubuntu

ENV DISPLAY :0

ENV USERNAME developer

WORKDIR /app

RUN apt update

RUN apt-get install -y --no-install-recommends \
    sudo \
    g++ \
    mesa-common-dev

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME sudo
USER $USERNAME

WORKDIR /home/$USERNAME

COPY bin .

RUN gcc -o main main.c -lGL -lX11

CMD "./main"