FROM registry.nic.cz/turris/foris-ci/base:latest

# Install pyenv
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN \
  curl https://pyenv.run | bash

# Install pythons
RUN pyenv install 3.9.22
RUN pyenv install 3.10.18
RUN pyenv install 3.11.13
RUN pyenv install 3.12.11
RUN pyenv install 3.13.5

# Install ubus and pyuci to all pythons (cant be compiled within tox)
RUN pyenv local 3.9.22 && pip install ubus pyuci
RUN pyenv local 3.10.18 && pip install ubus pyuci
RUN pyenv local 3.11.13 && pip install ubus pyuci
RUN pyenv local 3.12.11 && pip install ubus pyuci
RUN pyenv local 3.13.5 && pip install ubus pyuci

# Set root python config
RUN pyenv local system 3.9.22 3.10.18 3.11.13 3.12.11 3.13.5

CMD [ "bash" ]
