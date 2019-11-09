FROM ageron/handson-ml2
USER root
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
RUN jupyter contrib nbextension install --system
RUN jupyter nbextensions_configurator enable --system