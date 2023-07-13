FROM registry.nic.cz/turris/foris-ci/base:latest

# Install pyenv
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH "$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN \
  curl https://pyenv.run | bash

# Install pythons
RUN pyenv install 3.9.16 
RUN pyenv install 3.10.11
RUN pyenv install 3.11.3
RUN pyenv local system 3.9.16 3.10.11 3.11.3

CMD [ "bash" ]
