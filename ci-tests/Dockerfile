FROM registry.nic.cz/turris/foris-ci/base:latest

# Install pyenv
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN \
  curl https://pyenv.run | bash

# Install pythons
RUN pyenv install 3.9.16 
RUN pyenv install 3.10.11
RUN pyenv install 3.11.3
RUN pyenv install 3.12.9

# Install ubus and pyuci to all pythons (cant be compiled within tox)
RUN pyenv local 3.9.16 && pip install ubus pyuci
RUN pyenv local 3.10.11 && pip install ubus pyuci
RUN pyenv local 3.11.3 && pip install ubus pyuci
RUN pyenv local 3.12.9 && pip install ubus pyuci

# Set root python config
RUN pyenv local system 3.9.16 3.10.11 3.11.3 3.12.9

CMD [ "bash" ]
