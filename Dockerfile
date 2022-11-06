FROM node:latest

RUN apt-get update && \
    apt-get install -yq --no-install-recommends gcc g++ make libzmq3-dev jupyter python3-pip && \
    apt-get clean

RUN pip3 install -I \
    setuptools \
    wheel \
    jupyterlab \
    ipywidgets \
    jupyter_contrib_nbextensions

# RUN chmod 777 /usr/local/lib/node_modules
# RUN chmod 777 /usr/local/bin

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

USER node

WORKDIR /home/node

COPY --chown=node:node . .

RUN npm install -g npm

RUN npm install -g ijavascript
RUN ijsinstall

RUN rm -rf node_modules && npm install jupyter-ijavascript-utils


CMD npm run test && node bin/ijsinstall.js

CMD jupyter contrib nbextension install --user
CMD jupyter nbextension enable --py widgetsnbextension
CMD jupyter labextension install @jupyter-widgets/jupyterlab-manager@0.38 --minimize=False
CMD jupyter labextension install @aquirdturtle/collapsible_headings
