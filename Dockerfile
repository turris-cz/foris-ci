FROM ubuntu:xenial

ENV HOME=/root
ENV LC_ALL=en_US.utf8

# Install base packages
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  echo "# Installing base packages" && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install --no-install-recommends \
    lua5.1 liblua5.1-0-dev libjson-c-dev ca-certificates \
    git cmake make pkg-config gcc g++ openssh-client \
    python-prctl python-dev python-setuptools python-jsonschema \
    python-pip python-pbkdf2 locales \
    && \
  apt-get clean

# Generate locales
RUN \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen

# Use updated version of some core python packages
RUN \
  easy_install -U pip && \
  pip install --upgrade setuptools

# Compile libubox
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf libubox && \
  git clone git://git.openwrt.org/project/libubox.git && \
  cd ~/build/libubox && \
  git checkout master && \
  cmake CMakeLists.txt && \
  make install

# Compile uci
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf uci && \
  git clone git://git.openwrt.org/project/uci.git && \
  cd ~/build/uci && \
  git checkout master && \
  cmake cmake CMakeLists.txt && \
  make install

# Compile ubus
RUN \
  mkdir -p ~/build && \
  cd ~/build && \
  rm -rf ubus && \
  git clone https://gitlab.labs.nic.cz/turris/ubus.git && \
  cd ~/build/ubus && \
  git checkout python_bindings && \
  cmake CMakeLists.txt -DBUILD_PYTHON='ON' && \
  make && \
  cmake CMakeLists.txt -DBUILD_PYTHON='OFF' && \
  make install && \
  cd python && \
  pip install --upgrade .

# Add Gitlab's SSH key
RUN \
  mkdir /root/.ssh && \
  ssh-keyscan gitlab.labs.nic.cz > /root/.ssh/known_hosts

CMD [ "bash" ]
