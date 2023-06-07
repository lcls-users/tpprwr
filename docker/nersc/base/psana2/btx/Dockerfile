FROM fpoitevi/nersc:base-psana2

WORKDIR /home/psana2-build

RUN cd btx && git pull origin psana2_demo

ENTRYPOINT ["/opt/entrypoint.sh"]