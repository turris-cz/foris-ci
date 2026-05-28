FROM registry.nic.cz/turris/foris-ci/base:latest

# Install pyenv
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN \
  curl https://pyenv.run | bash

# Install pythons
RUN pyenv install 3.9.25
RUN pyenv install 3.10.20
RUN pyenv install 3.11.15
RUN pyenv install 3.12.13
RUN pyenv install 3.13.13
RUN pyenv install 3.14.5

# Install ubus and pyuci to all pythons (cant be compiled within tox)
RUN pyenv local 3.9.25 && pip install ubus pyuci
RUN pyenv local 3.10.20 && pip install ubus pyuci
RUN pyenv local 3.11.15 && pip install ubus pyuci
RUN pyenv local 3.12.13 && pip install ubus pyuci
RUN pyenv local 3.13.13 && pip install ubus pyuci
RUN pyenv local 3.14.5 && pip install ubus pyuci

# Set root python config
RUN pyenv local system 3.9.25 3.10.20 3.11.15 3.12.13 3.13.13 3.14.5

CMD [ "bash" ]
