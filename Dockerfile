FROM base

RUN apt-get update

COPY node2/.bashrc /.bashrc

# ETCD
RUN rm -rf /etc/default/etcd
RUN rm -rf /lib/systemd/system/etcd.service
COPY node2/etcd /etc/default/etcd 
COPY etcd.service /lib/systemd/system/etcd.service 

# Postgresql
RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Master Node Postgresql Config
COPY pg_hba.conf /pg_hba.conf

# Patroni
RUN apt-get install python3-pip python3-dev libpq-dev -y
# RUN apt-get install patroni -y
RUN pip3 install psycopg2-binary wheel python-etcd
# RUN rm -rf /etc/patroni/config.yml
COPY node2/config.yml /config.yml
# RUN chown postgres:postgres -R /etc/patroni
# RUN chmod 700 /etc/patroni
# RUN systemctl enable --now patroni.service

CMD ["bash"]
# patroni python3-pip python3-yaml gnupg2