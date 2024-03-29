FROM debian:stable

ENV HOME=/root
ENV TZ=Europe/Prague
ENV LC_ALL=en_US.utf8
ENV DEBIAN_FRONTEND=noninteractive

# Install base packages
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  sed -i 's#debian-security stable/updates#debian-security stable-security/updates#g' /etc/apt/sources.list && \
  echo "# Installing base packages" && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install --no-install-recommends \
    lua5.1 liblua5.1-0-dev libjson-c-dev ca-certificates \
    git cmake make pkg-config gcc g++ openssh-client bzip2 \
    python3-prctl python3-dev python3-setuptools python3-jsonschema \
    python3-pip python3-pbkdf2 locales gpg gpg-agent libcap-dev \
    mosquitto wireguard-tools \
    curl wget build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev llvm libncurses5-dev libncursesw5-dev  \
    xz-utils tk-dev libffi-dev liblzma-dev \
    && \
  apt-get clean

# Set Timezone
RUN \
  rm -f /etc/localtime && \
  echo "$TZ" > /etc/timezone && \
  dpkg-reconfigure -f noninteractive tzdata

# Update python paths
RUN \
  update-alternatives --install /usr/bin/python python /usr/bin/python3 1 && \
  update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Generate locales
RUN \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen

# Compile libubox
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf libubox && \
  git clone git://git.openwrt.org/project/libubox.git && \
  cd ~/build/libubox && \
  git checkout master && \
  cmake CMakeLists.txt -DCMAKE_INSTALL_PREFIX:PATH=/usr && \
  make install

# Compile uci
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf uci && \
  git clone git://git.openwrt.org/project/uci.git && \
  cd ~/build/uci && \
  git checkout master && \
  cmake CMakeLists.txt -DCMAKE_INSTALL_PREFIX:PATH=/usr && \
  make install

# Compile ubus
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf ubus && \
  git clone https://gitlab.nic.cz/turris/ubus.git && \
  cd ~/build/ubus && \
  git checkout master && \
  cmake CMakeLists.txt -DCMAKE_INSTALL_PREFIX:PATH=/usr && \
  make install

# Install ubus python bindings
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf python-ubus && \
  git clone https://gitlab.nic.cz/turris/python-ubus.git && \
  cd ~/build/python-ubus && \
  pip install --break-system-packages .

# Compile iwinfo
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf iwinfo && \
  git clone git://git.openwrt.org/project/iwinfo.git && \
  cd iwinfo && \
  ln -s /usr/lib/x86_64-linux-gnu/liblua5.1.so liblua.so && \
  CFLAGS="-I/usr/include/lua5.1/" LD=ld FPIC="-fPIC" LDFLAGS="-lc -shared" make && \
  cp -r include/* /usr/local/include/ && \
  cp libiwinfo.so /usr/local/lib/

# Compile rpcd
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf rpcd && \
  git clone git://git.openwrt.org/project/rpcd.git && \
  cd rpcd && \
  cmake CMakeLists.txt && \
  make install

# Add Gitlab's SSH key
RUN \
  mkdir /root/.ssh && \
  ssh-keyscan gitlab.nic.cz > /root/.ssh/known_hosts

# Install pyenv
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN \
  curl https://pyenv.run | bash

# Install pythons
RUN pyenv install 3.6.14
RUN pyenv install 3.7.11
RUN pyenv install 3.8.11
RUN pyenv install 3.9.6 
RUN pyenv local system 3.6.14 3.7.11 3.8.11 3.9.6

CMD [ "bash" ]
