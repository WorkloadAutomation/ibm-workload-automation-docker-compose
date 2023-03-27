
# Workload Automation Server

## Introduction

Workload Automation is a complete, modern solution for batch and real-time workload management. It enables organizations to gain complete visibility and control over attended or unattended workloads.

From a single point of control, it supports multiple platforms and provides advanced integration with enterprise applications including ERP, Business Analytics, File Transfer, Big Data, and Cloud applications. See [Installing Automation Hub integrations](#installing-automation-hub-integrations) for more information about integrating third-party plug-ins and integrations.

Docker adoption ensures standardization of your workload scheduling environment and provides an easy method to replicate environments quickly in development, build, test, and production environments, speeding up the time it takes to get from build to production significantly. Install your environment using Docker to improve scalability, portability, and efficiency.

## Supported tags

- 9.5.0.06.20230324
- 9.5.0.06.20221216
- 9.5.0.06.20220617
- 9.5.0.05.20211217
- 9.5.0.04.20210804

## Supported platforms

The supported operating systems are: Windows, Linux intel based 64-bit, and Linux on Z.

## Accessing the container images

### From the Entitled Registry

You can access the Server container image from the Entitled Registry:

1. Access the entitled registry. Log in to [MyIBM Container Software Library](https://myibm.ibm.com/products-services/containerlibrary) with the IBMid and password that are associated with the entitled software.
2. In the **Container software library** tile, click **View library** and then click **Copy key** to copy the entitlement key to the clipboard.
3. Run the following command to login into the IBM Entitled Registry:

       docker login -u cp -p <your_entitled_key> cp.icr.io

The image is as follows:

- cp.icr.io/cp/ibm-workload-automation-server:9.5.0.06.20230324

### From IBM Fix Central

If you are accessing the images from IBM Fix Central, use the following command to upload the image to your local Docker environment:

    docker load -i <tar_name>

where *<tar_name>* is the name of the .tar file containing the image.

Before you deploy IBM Workload Automation components on Linux on Z, see  [Deploying Docker compose on Linux on Z](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_9.5.0/distr/src_pi/awspizLinuxDeployments.html)

## Getting Started

You can deploy the IBM Workload Automation containers using either Docker compose or Docker run. For both of these methods, ensure you download and install [Docker](https://www.docker.com).

### Getting started with Docker compose

Download and install [Docker compose](https://docs.docker.com/compose/). We recommend version 1.27 or later to take advantage of named volumes.

To start the container via Docker Compose, run the following command to clone the current repository:

    git clone https://github.com/WorkloadAutomation/ibm-workload-automation-docker-compose.git

If you do not have GitHub installed in your environment, download the ZIP file from the main page of the repository:

    Click on "Code" and select "Download ZIP"

If you want customize the installation parameters, modify the **docker-compose.yml** file.

Accept the product licenses by setting the **LICENSE** parameter to **"accept"** in the **wa.env** file located in the container package as follows: **LICENSE=accept**

In the directory where  the **docker-compose.yml** file has been located, you can start the containers by running the following command:

    docker-compose up -d wa-server wa-db2

Once the command has been launched, be sure that the containers are started using the following command:

    docker ps

You can optionally check the container logs using the following commands:

    docker-compose logs -f wa-server
     OR
    docker-compose logs -f wa-db2

### Getting Started with Docker run

The IBM Workload Automation container has the following prerequisites:

- Create a DB instance and schema

  For example, use the following command to create a DB2 instance and schema:

      docker run --rm ibm-workload-automation-server:9.5.0.06 cat /opt/wa/TWS/tws_tools/create_database.sql >create_database.sql

  Copy the "create_database.sql" file on the workstation where the DB2 has been installed, perform a login as administrator and run the following command:

      db2 -tvf create_database.sql

- To start the container from the command-line, launch the following command by adding the name of the image that has been loaded:

      docker run \
          -d -e PUBLIC_HOSTNAME=server_host_name \
          -e PUBLIC_PORT=server_port \
          -e LICENSE=ACCEPT \
          -e WA_PASSWORD=wa_password \
          -e DB_TYPE=db_type \
          -e DB_HOSTNAME=db_hostname \
          -e DB_PORT=db port \
          -e DB_NAME=db_name \
          -e DB_USER=db_user \
          -e DB_PASSWORD=db_password \
          -e DB_ADMIN_USER=db_admin_user \
          -e DB_ADMIN_PASSWORD=db_admin_password \
          -v workload-automation-server-data:/home/wauser \
          ibm-workload-automation-server:9.5.0.06.\<release_date>

  > **Note:** The name of the image has to be the same as the one you loaded on your local workstation when you launched the docker load command.

### Installing with custom .PEM certificates

To use custom certificates, modify the volume `<path_on_host_containing_certs>:/opt/wautils/certs` with the path of the directory that contains your certificates at the place of `<path_on_host_containing_certs>`. In the defined folder, add the following certificates:

    ca.crt
    tls.key
    tls.crt

### Additional configuration

The following information applies to both deploying with Docker compose and Docker run.

> **Note**: Internal ports are predefined and must not be changed. External ports can be customized.

If your server component uses a timezone different from the default timezone, then to avoid problems with the FINAL job stream, you must update MAKEPLAN within the DOCOMMAND, specifying the timezone parameter and value. For example, if you are using the America/Los Angeles timezone, then it must be specified as follows:

    WA_WA-SERVER_XA#MAKEPLAN
    DOCOMMAND "TODAY_DATE=`${UNISONHOME}/bin/datecalc today pic YYYYMMDD`; ${UNISONHOME}/MakePlan -to `${UNISONHOME}/bin/datecalc ${TODAY_DATE}070
    0 + 1 day + 2 hours pic MM/DD/YYYY^HHTT` timezone America/Los_Angeles"
    STREAMLOGON wauser
    DESCRIPTION "Added by composer."
    TASKTYPE OTHER
    SUCCOUTPUTCOND CONDSUCC "(RC=0) OR (RC=4)"
    RECOVERY STOP

## Configuration Variables

The following table lists the configurable variables for the Server:

For example, specify the variable and its value as follows: LICENSE=ACCEPT

| Variable                | Description                                                                                                                                                                                                                                                                   | Mandatory   | Example              |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | -------------------- |
| LICENSE                 | Use ACCEPT to agree to the license agreement                                                                                                                                                                                                                                  | yes         | notaccepted            |
| PUBLIC_PORT             | The public HTTPS port to reach the Server in this container. It must be the same one mapped in the internal HTTPS port. The default value is 31116                                                                                                                            | yes         | 31116                |
| WA_PASSWORD             | The *wauser* password to connect to the Server (the same password used for the installation of the Server)                                                                                                                                                                    | yes         | \<password>           |
| AGT_NAME                | The name to be assigned to the dynamic agent of the Server. The default value is WA_AGT                                                                                                                                                                                       | no          | WA_AGT               |
| DATE_FORMAT             | The date format defined in the plan. The default value is MM/DD/YYYY                                                                                                                                                                                                          | no          | MM/DD/YYYY           |
| CREATE_PLAN             | If true, an automatic JnextPlan is executed at the same time of the container deployment. The default value is true                                                                                                                                                           | no          | true                 |
| COMPANY_NAME            | The name of your Company. The default value is my-company                                                                                                                                                                                                                     | no          | my-company           |
| LANG                    | The language of the container internal system. The supported language are: en (English), de (German), es (Spanish), fr (French), it (Italian), ja (Japanese), ko (Korean), pt_BR (Portuguese (BR)), ru (Russian), zh_CN (Simplified Chinese) and zh_TW (Traditional Chinese)  | yes         | en                   |
| PUBLIC_HOSTNAME         | The Hostname or IP address that the external dynamic agents contact to reach the Server                                                                                                                                                                                       | yes         | \<pubhostname>        |
| EVENTPROCESSOR_HOSTNAME | The Hostname or IP address that the external dynamic agents contact to reach the event processor.                                                                                                                                                                             | no          | \<evtprocpuhostname>  |
| TZ                      | If used, it sets the TZ operating system environment variable                                                                                                                                                                                                                 | no          | Europe/Rome          |
| START_OF_DAY            | The start time of the plan processing day in 24 hour format: "hhmm"                                                                                                                                                                                                           | no          | 0000                 |
| TIMEZONE                | The timezone used for the start time of the plan processing day (it is used only if START_OF_DAY is defined)                                                                                                                                                                  | no          | Europe/Rome          |
| SERVERHOSTNAME          | The hostname on which the server is contacted by internal dynamic agents                                                                                                                                                                                                      | yes         | wa-server            |
| SERVERPORT              | The port on which the server is contacted by internal dynamic agents                                                                                                                                                                                                          | yes         | 31116                |
| SSL_PASSWORD              | The password to open the private key (tls.key)                                                                                                                                                                                                          | Only if you use custom certificates in PEM format         | \<password>                     |

### DB variables

The following variables are valid only if you set a database different from Derby, such as DB2, Informix (IDS), OneDB, MSSQL, or Oracle.

| Variable                      | Description                                                                                                                                                                               | Mandatory   | Example             |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------  | ------------------- |
| DB_TYPE                       | The preferred remote database server type (e.g. DB2, ORACLE, MSSQL, IDS). The default value is DB2                                                                                        | yes         | DB2                 |
| DB_HOSTNAME                   | The Hostname or the IP Address of the database server                                                                                                                                     | yes         | \<dbhostname>        |
| DB_PORT                       | The port of the database server. The default value is 50000                                                                                                                               | yes         | 50000               |
| DB_NAME                       | Depending on the database type, the name is different; enter the name of the Server's database for DB2/Informix/MSSQL/OneDB, enter the Oracle Service Name for Oracle. The default value is TWS | yes         | TWS  
| DB_SERVER                     | The name of the Informix or OneDB database server | yes only for IDS or ONEDB         | IDS               |
| DB_USER                       | The database user who accesses the Server tables on the database server. The default value is db2inst1                                                                                    | yes         | db2inst1            |
| DB_PASSWORD                   | The password of the database user who accesses the Server tables on the database server                                                                                                   | yes         | \<password>          |
| DB_ADMIN_USER                 | The database user administrator who accesses the Server tables on the database server. The default value is db2inst1                                                                      | yes         | db2inst1            |
| DB_ADMIN_PASSWORD             | The password of the database user administrator who accesses the Server tables on the database server                                                                                     | yes         | \<password>          |
| DB_SSL_CONNECTION             | If true, SSL connection is used to connect to remote database server. Valid only for DB2                                                                                                  | no          | true                |
| DB_TS_NAME                    | The name of the DATA table space. The default value is TWS_DATA                                                                                                                           | no          | TWS_DATA            |
| DB_TS_PATH                    | The path of the DATA table space. The default value is TWS_DATA                                                                                                                           | no          | TWS_DATA            |
| DB_LOG_TS_NAME                | The name of the LOG table space. The default value is TWS_LOG                                                                                                                             | no          | TWS_LOG             |
| DB_LOG_TS_PATH                | The path of the LOG table space. The default value is TWS_LOG                                                                                                                             | no          | TWS_LOG             |
| DB_PLAN_TS_NAME               | The name of the PLAN table space. The default value is TWS_PLAN                                                                                                                           | no          | TWS_PLAN            |
| DB_PLAN_TS_PATH               | The path of the PLAN table space. The default value is TWS_PLAN                                                                                                                           | no          | TWS_PLAN            |
| DB_TEMP_TS_NAME               | The name of the TEMP table space. The default value is TEMP                                                                                                                               | no          | TEMP                |
| DB_SBSPACE                    | The name of the SB table space. Valid only for IDS. By default, leave it empty                                                                                                             | no          |                     |
| DB_ENABLE_PARTITIONING_OPTION | If true, the Oracle Partitioning feature is enabled. Valid only for Oracle, it is ignored by other databases. The default value is true                                                | no          | true                |
| DB_SKIP_CHECK                 | If you want to skip db check set true. Valid only for Oracle                                                                                                                             | no          | true                |

> **Note**: The Dynamic Agent component included in the Workload Automation Server container is deployed and configured with a gateway.

## Single Sign-On (SSO) configuration

To enable SSO between console and server, LTPA tokens must be the same. The following procedure explains how to create LTPA tokens to be shared between server and console (this procedure must be run only once and not on both systems).

To create new LTPA token, launch the following command:

    docker run -i --rm -v <host_dir>:/output ibm-workload-automation-server:9.5.0.05 /opt/wautils/wa_create_ltpa_keys.sh -p <keys_password>

where: **<host_dir>** is an existing folder on the local machine where docker runs and **<keys_password>** is LTPA keys password ( for further details, see the [online](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_9.5.0/com.ibm.tivoli.itws.doc_9.5/distr/src_ad/awsadshareltpa.htm) documentation).

The "ltpa.keys" and "wa_ltpa.xml" files are created in the local folder \<hostdir>.

The "ltpa.keys" file must be placed into the volume that stores customized SSL certificates (on both server and console charts).

In both server and console charts, useCustomizedCert property must be set on "true".

The "wa_ltpa.xml" file must be placed in the volume that stores all custom liberty configuration (on both server and console charts).

## Installing Automation Hub integrations  

You can extend Workload Automation with a number of out-of-the-box integrations, or plug-ins. Complete documentation for the integrations is available on [Automation Hub](https://www.yourautomationhub.io/). Use this procedure to integrate only the integrations you need to automate your business workflows.

You can also extend Workload Automation with custom plug-ins or integrations that you create. For information about creating a custom plug-in and deploying the plug-in see [Workload Automation Lutist Development Kit](https://www.yourautomationhub.io/toolkit) on Automation Hub.

> **Note:** You must perform this procedure before deploying the product components. Any changes made post-installation are applied the next time you perform an upgrade.

By default, your HCL Workload Automation deployment includes a number of integrations that are ready to be used after you deploy the server and console containers. The integrations available are defined in a **.properties** file. Create and customize the **.properties** file that pertains to your environment to exclude any integrations you do not need.

To exclude an integration, follow these steps:

1. Depending on your environment, whether it is a distributed environment or a z/OS environment, create a **.properties** file named **plugins.properties** in the same directory where the docker-compose file resides with the following content:

       com.hcl.scheduling.agent.kubernetes
       com.hcl.scheduling.agent.udeploycode
       com.hcl.wa.plugin.ansible
       com.hcl.wa.plugin.automationanywherebotrunner
       com.hcl.wa.plugin.automationanywherebottrader
       com.hcl.wa.plugin.awscloudformation
       com.hcl.wa.plugin.awslambda
       com.hcl.wa.plugin.awssns
       com.hcl.wa.plugin.awssqs
       com.hcl.wa.plugin.azureresourcemanager
       com.hcl.wa.plugin.azuredatabricks
       com.hcl.wa.plugin.azurestorage
       com.hcl.wa.plugin.blueprism
       com.hcl.wa.plugin.compression
       com.hcl.wa.plugin.encryption
       com.hcl.wa.plugin.gcpcloudstorage
       com.hcl.wa.plugin.gcpcloudfunction
       com.hcl.wa.plugin.gcpdeploymentmanager
       com.hcl.wa.plugin.obiagent
       com.hcl.wa.plugin.odiloadplan
       com.hcl.wa.plugin.oraclehcmdataloader
       com.hcl.wa.plugin.oracleucm
       com.hcl.wa.plugin.saphanaxsengine
       com.hcl.waPlugin.chefbootstrap
       com.hcl.waPlugin.chefrunlist
       com.hcl.waPlugin.obirunreport
       com.hcl.waPlugin.odiscenario
       com.ibm.scheduling.agent.apachespark
       com.ibm.scheduling.agent.aws
       com.ibm.scheduling.agent.azure
       com.ibm.scheduling.agent.biginsights
       com.ibm.scheduling.agent.centralizedagentupdate
       com.ibm.scheduling.agent.cloudant
       com.ibm.scheduling.agent.cognos
       com.ibm.scheduling.agent.database
       com.ibm.scheduling.agent.datastage
       com.ibm.scheduling.agent.ejb
       com.ibm.scheduling.agent.filetransfer
       com.ibm.scheduling.agent.hadoopfs
       com.ibm.scheduling.agent.hadoopmapreduce
       com.ibm.scheduling.agent.hcllaunch
       com.ibm.scheduling.agent.j2ee
       com.ibm.scheduling.agent.java
       com.ibm.scheduling.agent.jobdurationpredictor
       com.ibm.scheduling.agent.jobmanagement
       com.ibm.scheduling.agent.jobstreamsubmission
       com.ibm.scheduling.agent.jsr352javabatch
       com.ibm.scheduling.agent.mqtt
       com.ibm.scheduling.agent.mssqljob
       com.ibm.scheduling.agent.oozie
       com.ibm.scheduling.agent.oracleebusiness
       com.ibm.scheduling.agent.pichannel
       com.ibm.scheduling.agent.powercenter
       com.ibm.scheduling.agent.restful
       com.ibm.scheduling.agent.remotecommand
       com.ibm.scheduling.agent.salesforce
       com.ibm.scheduling.agent.sapbusinessobjects
       com.ibm.scheduling.agent.saphanalifecycle
       com.ibm.scheduling.agent.softlayer
       com.ibm.scheduling.agent.sterling
       com.ibm.scheduling.agent.variabletable
       com.ibm.scheduling.agent.webspheremq
       com.ibm.scheduling.agent.ws

2. Delete the lines related to the integrations you do not want to make available in your environment. The remaining integrations will be integrated into Workload Automation at deployment time. Save your changes to the file.

   You can always refer back to this readme file and add an integration back into the file in the future. The integration becomes available the next time you update the console and server containers.

3. In the docker-compose.yml file, add the following entry under the volume section of the wa-server component so that it appears as follows:

       wa-server:
         env_file:
           [...]
         volumes:
           - wa-server-data:/home/wauser/
           - ./plugins.properties:/opt/wautils/config/plugins.properties

4. In the volumes section at the end of the file, add an additional line with "plugins.properties:" so that the section appears as follows:

       volumes:
         wa-db2inst1_home:
         wa-server-data:
         wa-console-data:
         wa-agent-data:
         plugins.properties:
  
5. Save the changes to the docker-composer.yml file.

Proceed to deploy the product components. After the deployment, you can include jobs related to these integrations when defining your workload.

## Metrics Monitoring

Workload Automation exposes a number of metrics to provide you with insight into the state, health, and performance of your environment and infrastructure. You can access the product APIs for monitoring and retrieving insightful metrics data. The metrics are exposed and can be visualized with tools for displaying application metrics such as, the open source tool Grafana.

If you use Grafana, you can take advantage of the preconfigured dashboard that is available on [Automation Hub](https://www.yourautomationhub.io/integrations). Automation Hub gives you access to the downloadable JSON file on the Grafana web site. Use the **Grafana Dashboard: Distributed Environments** for you on-premises deployments including Docker. A separate preconfigured dashboard named, **Grafana Dashboard: Kubernetes Environments**, is available for cluster monitoring, including monitoring pods. In a Docker environment, by default, the user that performs the cloud deployment is already authenticated to access the metrics. However, to grant other users access to the metrics securely using a set of credentials, add additional users to the `authentication_config.xml` file and then modify the `prometheus.xml` file that is automatically created in a Docker environment. For more information about this procedure and the list of metrics available, see [Metrics monitoring](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_9.5.0/com.ibm.tivoli.itws.doc_9.5/distr/src_ref/awsrgmonprom.html).

## Supported Docker versions

This image is officially supported on Docker version 19.xx.xx, or later.

Support for versions earlier than 19.xx.xx, is provided on a best-effort basis.

See the [Docker installation documentation](https://docs.docker.com/engine/installation/) for details on how to upgrade your Docker daemon.

## Limitations

The owner of all product files is the wauser user, thus the product does not run as root, but as wauser only. Do not perform the login as root to start processes or run other commands such as Jnextplan, otherwise it might create some issues.

On amd64 and Linux on Z platforms.

## Troubleshooting

If you switch the event processor and move it to a workstation different from the workstation where the dynamic domain manager resides, dynamic agents still point to the previous workstation and fail to contact the event processor.

To work around this problem, edit the BrokerWorkstation.properties file as follows:

on the master domain manager:

    Broker.Workstation.evtproc.wa-server=<wa_server_name>

on the backup domain manager:

    Broker.Workstation.evtproc.wa-server-bkm=<wa_server_bkm_name>

where **<wa_server_name>** is the hostname of the master domain manager and **<wa_server_bkm_name>** is the hostname of the backup domain manager.

This limitation applies only to the stand-alone Docker environment.

## Additional Information

For additional information about how to use the IBM Workload Automation, see the [online](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_9.5.0/com.ibm.tivoli.itws.doc_9.5/distr/src_pi/awspipartdepcont.htm) documentation. For technical issues, search for Workload Scheduler or Workload Automation on [StackOverflow](http://stackoverflow.com/search?q=workload+scheduler).

## License

The Dockerfile and associated scripts are licensed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0). IBM Workload Automation is licensed under the IBM International Program License Agreement. This license for IBM Workload Automation can be found [online](https://www14.software.ibm.com/cgi-bin/weblap/lap.pl?li_formnum=L-DDDO-C7LFG9). Note that this license does not permit further distribution.
