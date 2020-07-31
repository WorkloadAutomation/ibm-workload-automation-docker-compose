FROM ibmcom/db2:11.5.0.0a
ARG DB2INST1_PASSWORD
ARG LICENSE

ENV DB2INST1_PASSWORD $DB2INST1_PASSWORD
ENV LICENSE $LICENSE

RUN mkdir -p /var/custom
RUN mkdir -p /db_tools

ADD  create_db.sh /var/custom
ADD  create_db.sql /db_tools

RUN chmod a+x /var/custom/*
RUN chmod 644 /db_tools/*

EXPOSE 50000

