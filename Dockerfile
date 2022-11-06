FROM node:latest

RUN apt-get update && \
    apt-get install -yq --no-install-recommends libzmq3-dev jupyter python3-pip && \
    apt-get clean

RUN pip3 install -I \
    setuptools \
    wheel \
    jupyterlab \
    ipywidgets \
    jupyter_contrib_nbextensions

USER node

WORKDIR /home/node

COPY --chown=node:node . .

RUN rm -rf node_modules && npm install jupyter-ijavascript-utils

CMD npm run test && node bin/ijsinstall.js

CMD jupyter contrib nbextension install --user
CMD jupyter nbextension enable --py widgetsnbextension
CMD jupyter labextension install @jupyter-widgets/jupyterlab-manager@0.38 --minimize=False
CMD jupyter labextension install @aquirdturtle/collapsible_headings
