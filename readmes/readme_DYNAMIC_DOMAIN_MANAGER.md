


# Workload Automation Dynamic domain manager

## Introduction
Workload Automation is a complete, modern solution for batch and real-time workload management. It enables organizations to gain complete visibility and control over attended or unattended workloads. 

From a single point of control, it supports multiple platforms and provides advanced integration with enterprise applications including ERP, Business Analytics, File Transfer, Big Data, and Cloud applications. See [Installing Automation Hub integrations](#installing-automation-hub-integrations) for more information about integrating third-party plug-ins and integrations.

Docker adoption ensures standardization of your workload scheduling environment and provides an easy method to replicate environments quickly in development, build, test, and production environments, speeding up the time it takes to get from build to production significantly. Install your environment using Docker to improve scalability, portability, and efficiency.




## Supported tags
- 10.2.8.00.20260727

 
 ## Supported platforms
 The supported operating systems are: Windows, Linux intel based 64-bit, and Linux on Z.
 
## Accessing the container images

### From the Entitled Registry
You can access the Dynamic domain manager container image from the Entitled Registry:

1. Access the entitled registry. Log in to [MyIBM Container Software Library](https://myibm.ibm.com/products-services/containerlibrary) with the IBMid and password that are associated with the entitled software.


2.  In the **Container software library** tile, click **View library** and then click **Copy key** to copy the entitlement key to the clipboard.

3.  Run the following command to login into the IBM Entitled Registry:
      
        docker login -u cp -p <your_entitled_key> cp.icr.io
	

 The image is as follows:

* cp.icr.io/cp/ibm-workload-automation-server:10.2.8.00.20260727


### From IBM Fix Central

If you are accessing the images from IBM Fix Central, use the following command to upload the image to your local Docker environment:

     docker load -i <tar_name>
	 
  where <tar_name> is the name of the .tar file containing the image.





Before you deploy IBM Workload Automation components on Linux on Z, see  [Deploying Docker compose on Linux on Z](https://www.ibm.com/docs/en/workload-automation/10.2.8?topic=compose-deploying-docker-linux-z)


## Getting Started
You can deploy the IBM Workload Automation containers using either Docker compose or Docker run. For both of these methods, ensure you download and install [Docker](https://www.docker.com). 

### Getting started with Docker compose

Download and install [Docker compose](https://docs.docker.com/compose/). We recommend version 1.27 or later to take advantage of named volumes.

To start the container via Docker Compose, run the following command to clone the current repository:



         git clone https://github.com/WorkloadAutomation/ibm-workload-automation-docker-compose.git



If you do not have GitHub installed in your environment, download the ZIP file from the main page of the repository:

    Click "Code" and select "Download ZIP"

If you want customize the installation parameters, modify the **docker-compose.yml** file.

Accept the product licenses by setting the **LICENSE** parameter to **"accept"** in the **wa.env** file located in the container package as follows: **LICENSE=accept**

In the directory where  the **docker-compose.yml** file has been located, you can start the containers by running the following command:

    docker-compose up -d wa-ddm wa-db2

Once the command has been launched, be sure that the containers are started using the following command:

    docker ps 

You can optionally check the container logs using the following commands:

    docker-compose logs -f wa-ddm
     OR
    docker-compose logs -f wa-db2


### Getting Started with Docker run

The IBM Workload Automation container has the following prerequisites:

 - Create a DB instance and schema

   For example, use the following command to create a DB2 instance and schema:   

       docker run --rm ibm-workload-automation-server:<version_number> cat /opt/wa/TWS/tws_tools/create_database.sql >create_database.sql
       
   Copy the "create_database.sql" file on the workstation where the DB2 has been installed, perform a login as administrator and run the following command:
 
       db2 -tvf create_database.sql 
       
To start the container from the command-line, launch the following command by adding the name of the image that has been loaded:

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
		ibm-workload-automation-server:<version_number>.\<release_date>
		-e DDM_MASTER=WA_FTA
		-e DDM_MDM_HOSTNAME=wa-server
		-e DDM_MDM_HTTPS_PORT=31116
		-e DDM_DOMAIN=DYNAMICDM
		-e DWBNAME=WA_DWB_DDM
		-e AGT_NAME=WA_AGT_DDM			  
> **Note:** The name of the image has to be the same as the one you loaded on your local workstation when you launched the docker load command.


### Installing with custom .PEM certificates
To use custom certificates, modify the volume `<path_on_host_containing_certs>:/opt/wautils/certs` with the path of the directory that contains your certificates at the place of `<path_on_host_containing_certs>`. In the defined folder, add the following certificates:

      - ca.crt
      - tls.key
      - tls.crt
### Additional configuration
For information regarding additional configurations and integrations, refer to the Workload Automation Server readme.

## Configuration Variables

The following table lists the configurable variables for the Dynamic domain manager:

For example, specify the variable and its value as follows: LICENSE=ACCEPT


| Variable                | Description                                                                                                                                                                                                                                                                   | Mandatory   | Example              |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- | -------------------- |
| LICENSE                 | Use ACCEPT to agree to the license agreement                                                                                                                                                                                                                                  | yes         | notaccept            |
| PUBLIC_PORT             | The public HTTPS port to reach the Server in this container. It must be the same one mapped in the internal HTTPS port. The default value is 31116                                                                                                                            | yes         | 31116                |
| WA_PASSWORD             | The *wauser* password to connect to the Server (the same password used for the installation of the Server)                                                                                                                                                                    | yes         | <password>           |
| AGT_NAME                | The name to be assigned to the dynamic agent of the Server. The default value is WA_AGT                                                                                                                                                                                       | no          | WA_AGT               | 
| DATE_FORMAT             | The date format defined in the plan. The default value is MM/DD/YYYY                                                                                                                                                                                                          | no          | MM/DD/YYYY           |
| COMPANY_NAME            | The name of your Company. The default value is my-company                                                                                                                                                                                                                     | no          | my-company           |
| LANG                    | The language of the container internal system. The supported language are: en (English), de (German), es (Spanish), fr (French), it (Italian), ja (Japanese), ko (Korean), pt_BR (Portuguese (BR)), ru (Russian), zh_CN (Simplified Chinese) and zh_TW (Traditional Chinese)  | yes         | en                   |
| PUBLIC_HOSTNAME         | The Hostname or IP address that the external dynamic agents contact to reach the Server                                                                                                                                                                                       | yes         | <pubhostname>        |
| EVENTPROCESSOR_HOSTNAME | The Hostname or IP address that the external dynamic agents contact to reach the event processor.                                                                                                                                                                             | no          | <evtprocpuhostname>  |
| TZ                      | If used, it sets the TZ operating system environment variable                                                                                                                                                                                                                 | no          | Europe/Rome          |
| START_OF_DAY            | The start time of the plan processing day in 24 hour format: "hhmm"                                                                                                                                                                                                           | no          | 0000                 |
| TIMEZONE                | The timezone used for the start time of the plan processing day (it is used only if START_OF_DAY is defined)                                                                                                                                                                  | no          | Europe/Rome          |
| SERVERHOSTNAME          | The hostname on which the server is contacted by internal dynamic agents                                                                                                                                                                                                      | yes         | wa-server            |
| SERVERPORT              | The port on which the server is contacted by internal dynamic agents                                                                                                                                                                                                          | yes         | 31116                |
| SSL_PASSWORD              | The password to open the private key (tls.key)                                                                                                                                                                                                          | Only if you use custom certificates in PEM format         |                      |
|DDM_MASTER              | The name of the CPU of the master domain manager                                                                                                                                                                                                        | yes       | WA_FTA                     |
|DDM_MDM_HOSTNAME              | The hostname used by the dynamic domain manager to connect to the master domain manager                                                                                                                                                                                                          | yes         | wa-server                     |
|DDM_MDM_HTTPS_PORT              | The port used by the dynamic domain manager to connect to the master domain manager                                                                                                                                                                                                       | yes        |   31116                   |
|DDM_DOMAIN              | The domain used by the dynamic domain manager to register the components                                                                                                                                                                                                          | no        | DYNAMICDM                     |
|DWBNAME              | The broker workstation used to identify the dynamic domain manager                                                                                                                                                                                                      | yes        | WA_DWB_DDM                     |

- DB variables

| Variable                      | Description                                                                                                                                                                               | Mandatory   | Example             |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------  | ------------------- |
| DB_TYPE                       | The preferred remote database server type (e.g. DB2, POSTGRES, ORACLE, MSSQL, IDS). The default value is DB2                                                                                        | yes         | DB2                 |
| DB_HOSTNAME                   | The Hostname or the IP Address of the database server                                                                                                                                     | yes         | <dbhostname>        |
| DB_PORT                       | The port of the database server. The default value is 50000                                                                                                                               | yes         | 50000               |
| DB_NAME                       | Depending on the database type, the name is different; enter the name of the Server's database for DB2/POSTGRES/Informix/MSSQL/OneDB, enter the Oracle Service Name for Oracle. The default value is TWS | yes         | TWS                 |
| DB_SERVER                     | The name of the Informix or OneDB database server | yes only for IDS or ONEDB         | IDS
| DB_USER                       | The database user who accesses the Server tables on the database server. The defualt value is db2inst1                                                                                    | yes         | db2inst1            |
| DB_PASSWORD                   | The password of the database user who accesses the Server tables on the database server                                                                                                   | yes         | <password>          |
| DB_ADMIN_USER                 | The database user administrator who accesses the Server tables on the database server. The defualt value is db2inst1                                                                      | yes         | db2inst1            |
| DB_ADMIN_PASSWORD             | The password of the database user administrator who accesses the Server tables on the database server                                                                                     | yes         | <password>          |
| DB_SSL_CONNECTION             | If true, SSL connection is used to connect to remote database server. Valid only for DB2                                                                                                  | no          | true                |
| DB_TS_NAME                    | The name of the DATA table space. The defualt value is TWS_DATA                                                                                                                           | no          | TWS_DATA            |
| DB_TS_PATH                    | The path of the DATA table space. The defualt value is TWS_DATA                                                                                                                           | no          | TWS_DATA            |
| DB_LOG_TS_NAME                | The name of the LOG table space. The defualt value is TWS_LOG                                                                                                                             | no          | TWS_LOG             |
| DB_LOG_TS_PATH                | The path of the LOG table space. The defualt value is TWS_LOG                                                                                                                             | no          | TWS_LOG             |
| DB_PLAN_TS_NAME               | The name of the PLAN table space. The defualt value is TWS_PLAN                                                                                                                           | no          | TWS_PLAN            |
| DB_PLAN_TS_PATH               | The path of the PLAN table space. The defualt value is TWS_PLAN                                                                                                                           | no          | TWS_PLAN            |
| DB_TEMP_TS_NAME               | The name of the TEMP table space. The defualt value is TEMP                                                                                                                               | no          | TEMP                |
| DB_SBSPACE                    | The name of the SB table space. Valid only for IDS. By default, leave it empty                                                                                                             | no          |                     |
| DB_ENABLE_PARTITIONING_OPTION | If true, the Oracle Partitioning feature is enabled. Valid only for Oracle, it is ignored by other databases. The default value is true                                                | no          | true                |
| DB_SKIP_CHECK                 | If you want to skip db check set true. Validy only for Oracle                                                                                                                             | no          | true                |
   
> **Note**: The Dynamic Agent component included in the Workload Automation Dynamic domain manager container is deployed and configured with a gateway.

- Open telemetry variables

| Variable                      | Description                                                                                                                                                                               | Mandatory   | Example             |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------  | ------------------- |
| otel_traces_exporter          | The trace exporter to be used                                                                                                                                                             | no          | otlp                |
| otel_exporter_otlp_endpoint   | A base endpoint URL for any signal type, with an optionally-specified port number. Helpful for when you’re sending more than one signal to the same endpoint and want one environment variable to control the endpoint | no | http://localhost:4317 |
| otel_exporter_otlp_traces_endpoint | Endpoint URL for trace data only, with an optionally-specified port number. Typically ends with v1/traces when using OTLP/HTTP                                                       | no          | http://localhost:4317 |
| otel_exporter_otlp_protocol   | Specifies the OTLP transport protocol to be used for all telemetry data                                                                                                                   | no          | grpc                |
| otel_exporter_otlp_traces_protocol | Specifies the OTLP transport protocol to be used for trace data                                                                                                                      | no          | grpc                |   
| otel_sdk_disabled             | Disables the SDK for all signals                                                                                                                                                          | no          | true                |


	
## Report CLI 	

To run reports in batch mode, perform the following steps:

1. Browse to `/home/wauser/wadata/config/report`
2. Open the **common.properties** file in a flat-text editor.
3. Edit the file inserting the information for your database. Instructions on editing the file are provided in the file itself. 

The Report CLI is now ready for running. To start the Report CLI, browse to `/opt/wa/report` and run the following command: `./reportcli.sh`

Consider the following example:

`./reportcli.sh -p reports/templates/jrh.properties -r my_report -commonPropsFile /home/wauser/wadata/config/report`

For more information, see: 

[Running batch reports from the command line interface](https://www.ibm.com/docs/en/workload-automation/10.2.8?topic=reports-running-batch-from-command-line-interface)

## Supported Docker versions
This image is officially supported on Docker version 19.xx.xx, or later.

Support for versions earlier than 19.xx.xx, is provided on a best-effort basis.

See the [Docker installation documentation](https://docs.docker.com/engine/installation/) for details on how to upgrade your Docker daemon.  


  

## Limitations
The owner of all product files is the wauser user, thus the product does not run as root, but as wauser only. Do not perform the login as root to start processes or run other commands, otherwise it might create some issues.

On amd64 and Linux on Z platforms.

## Troubleshooting

For information about troubleshooting processes, refer to the Workload Automation Server readme.

## Additional Information
For additional information about how to use the IBM Workload Automation, see the [online](https://www.ibm.com/docs/en/workload-automation/10.2.8) documentation. For technical issues, search for Workload Scheduler or Workload Automation on [StackOverflow](http://stackoverflow.com/search?q=workload+scheduler).


## License
The Dockerfile and associated scripts are licensed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0). IBM Workload Automation is licensed under the IBM International Program License Agreement. This license for IBM Workload Automation can be found [online](https://www14.software.ibm.com/cgi-bin/weblap/lap.pl?li_formnum=L-AGOO-C87LWG). Note that this license does not permit further distribution.
