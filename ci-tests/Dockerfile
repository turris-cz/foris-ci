FROM registry.nic.cz/turris/foris-ci/base:latest

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
