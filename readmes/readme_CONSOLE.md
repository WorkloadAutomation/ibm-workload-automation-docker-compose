



# Workload Automation Console

## Introduction
Workload Automation is a complete, modern solution for batch and real-time workload management. It enables organizations to gain complete visibility and control over attended or unattended workloads. From a single point of control, it supports multiple platforms and provides advanced integration with enterprise applications including ERP, Business Analytics, File Transfer, Big Data, and Cloud applications.

Docker adoption ensures standardization of your workload scheduling environment and provides an easy method to replicate environments quickly in development, build, test, and production environments, speeding up the time it takes to get from build to production significantly. Install your environment using Docker to improve scalability, portability, and efficiency.


## Supported tags
- 9.5.0.03.20210326
- 9.5.0.02.20200727 (only for distributed)
 
 ## Supported platforms
 The supported operating systems are: Windows, Linux Intel based 64-bit, and Linux on Z.
 

## Accessing the container images

### From the Entitled Registry
You can access the Console container image from the Entitled Registry:

1. Access the entitled registry. Log in to [MyIBM Container Software Library](https://myibm.ibm.com/products-services/containerlibrary) with the IBMid and password that are associated with the entitled software.


2.  In the **Container software library** tile, click **View library** and then click **Copy key** to copy the entitlement key to the clipboard.

3.  Run the following command to login into the IBM Entitled Registry:
      
        docker login -u cp -p <your_entitled_key> cp.icr.io
	

 The image is as follows:

* cp.icr.io/cp/ibm-workload-automation-console:9.5.0.03.20210218


### From IBM Fix Central

If you are accessing the images from IBM Fix Central, use the following command to upload the image to your local Docker environment:

     docker load -i <tar_name>
	 
  where <tar_name> is the name of the .tar file containing the image.




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

    docker-compose up -d wa-console wa-db2

Once the command has been launched, be sure that the containers are started using the following command:

    docker ps 

You can optionally check the container logs using the following commands:

    docker-compose logs -f wa-console
     OR
    docker-compose logs -f wa-db2


### Getting Started with Docker run

The IBM Workload Automation container has the following prerequisites:

 - Create a DB instance and schema

   For example, use the following command to create a DB2 instance and schema:   

       docker run --rm cp.icr.io/cp/ibm-workload-automation-console:9.5.0.03.20210218 cat /opt/dwc/tools/create_database.sql > create_database.sql
       
   Copy the "create_database.sql" file on the workstation where the DB2 has been installed, perform a login as administrator and run the following command:
 
       db2 -tvf create_database.sql 
       
To start the container from the command-line, launch the following command by adding the name of the image that has been loaded:

	 docker run \
		-d -e LICENSE=ACCEPT \
		-e WA_PASSWORD=wa_password \
		-e DB_TYPE=db_type \
		-e DB_HOSTNAME=db_hostname \
		-e DB_PORT=db_port \
		-e DB_NAME=db_name \
		-e DB_USER=db_user \
		-e DB_PASSWORD=db_password \
		-e DB_ADMIN_USER=db_admin_user \
		-e DB_ADMIN_PASSWORD=db_admin_password \
		-v workload-automation-console-data:/home/wauser \
		ibm-workload-automation-console:9.5.0.03.20210218

> **Note:** The name of the image has to be the same as the one you loaded on your local workstation when you launched the docker load command.

### Additional configuration

The following information applies to both deploying with Docker compose and Docker run.

> **Note**: Internal ports are predefined and must not be changed. External ports can be customized.

> **Note:** To use custom certificates, modify the volume `<path_on_host_containing_certs>:/opt/wautils/certs` with the path of the directory that contains your certificates at the place of `<path_on_host_containing_certs>`. In the defined folder, add the following certificates:

    - TWSServerTrustFile.jks
    - TWSServerKeyFile.jks
    - ltpa.keys

> **Note**: If you set on true the "DB_SSL_CONNECTION" setting, you must add the following certificates to the volume that stores customized certificates: TWSServerTrustFile.jks and TWSServerTrustFile.jks.pwd
 
  "TWSServerTrustFile.jks.pwd" file must contain the password for "TWSServerTrustFile.jks" file.









## Configuration Variables

The following table lists the configurable variables for the Console:

For example, specify the variable and its value as follows: LICENSE=ACCEPT

| Variable        | Description                                                                                                                                                                                                                                                                   | Mandatory   | Example         |
| ------------    |-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  | ----------  | --------------  |
| LICENSE         | Use ACCEPT to agree to the license agreement                                                                                                                                                                                                                                  | yes         | notaccept       |
| WA_PASSWORD     | The *wauser* password to connect to the Console (the same password used for the installation of the Console)                                                                                                                                                                  | yes         | <password>      |
| LANG            | The language of the container internal system. The supported language are: en (English), de (German), es (Spanish), fr (French), it (Italian), ja (Japanese), ko (Korean), pt_BR (Portuguese (BR)), ru (Russian), zh_CN (Simplified Chinese) and zh_TW (Traditional Chinese)  | yes         | en              |
| TZ              | If used, it sets the TZ operating system environment variable                                                                                                                                                                                                                 | no          | Europe/Rome     |
| ENGINE_HOSTNAME | The hostname or IP address of the engine where the server is installed. Configuring this setting, the engine hostname field on the UI is automatically filled in                                                                                                                            | no          | wa-server       |
| ENGINE_PORT     | The port on which the engine - where the server is installed - is contacted by the console. Configuring this setting, the engine port field on the UI is automatically filled in                                                                                              | no          | 31116           |
| ENGINE_USER     | The user who accesses the engine where the server is installed. Configuring this setting, the engine user field on the UI is automatically filled in                                                                                                                          | no          | wauser          |


- DB variables

The following variables are valid only if you set a database different from Derby, such as DB2, DB2 for z/OS (DB2Z), Informix (IDS), MSSQL or Oracle. Use Derby database only for demo or test purposes.

| Variable                      | Description                                                                                                                                                                                                        | Mandatory   | Example             |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                         | ----------  | ---------------     |
| DB_TYPE                       | The preferred remote database server type (i.e. DERBY, DB2, DB2Z, ORACLE, MSSQL or IDS). The default value is DB2                                                                                                 | yes         | DB2                 |
| DB_HOSTNAME                   | The Hostname or the IP Address of the database server                                                                                                                                                              | yes         | <dbhostname>        |
| DB_PORT                       | The port of the database server. The defualt value is 50000                                                                                                                                                        | yes         | 50000               |
| DB_NAME                       | Depending on the database type the name is different; enter the name of the Console's database for DB2/Informix/MSSQL, enter the Oracle Service Name for Oracle. The default value is DWC                          | yes         | DWC                 |
| DB_USER                       | The database user who accesses the Console tables on the database server. The default value is db2inst1                                                                                                            | yes         | db2inst1            | 
| DB_PASSWORD                   | The password of the database user who accesses the Console tables on the database server                                                                                                                           | yes         | <password>          |
| DB_ADMIN_USER                 | The database user administrator who accesses the Console tables on the database server. The default value is db2inst1                                                                                              | yes         | db2inst1            |
| DB_ADMIN_PASSWORD             | The password of the database user administrator who accesses the Console tables on the database server                                                                                                             | yes         | <password>          |
| DB_SSL_CONNECTION             | If true, SSL connection is used to connect to remote database server. Valid only for DB2                                                                                                                           | no          | true                |
| DB_TS_NAME                    | The name of the DATA table space. The default value is TWS_DATA                                                                                                                                                    | no          | TWS_DATA            |
| DB_TS_PATH                    | The path of the DATA table space. The default value is TWS_DATA                                                                                                                                                    | no          | TWS_DATA            |
| DB_SBSPACE                    | The name of the SB table space. Valid only for IDS. By default, leave it empty                                                                                                                                     | no          |                     |
| DB_ENABLE_PARTITIONING_OPTION | If true, the Oracle Partitioning feature is enabled. Valid only for Oracle, it is ignored by other databases. The default value is true                                                   | no          | true                |
| DB_ZLOCATION_NAME             | The name of an already existing location in the z/OS environment that will contain the database.       Valid only for DB2 for z/OS. The default value is LOC1                              | yes         | LOC1                |	
| DB_ZBUFFERPOOL_NAME           | The name of an already existing buffer pool created in the location specified b ZLOCATIONNAME. The      default value is BP32K                                                              | no          | BP32K               |
	


## Single Sign-On (SSO) configuration

To enable SSO between console and server, LTPA tokens must be the same. The following procedure explains how to create LTPA tokens to be shared between server and console (this procedure must be run only once and not on both systems). 

To create new LTPA token, issue the following command:

     docker run -i --rm -v <host_dir>:/output cp.icr.io/cp/ibm-workload-automation-console:9.5.0.03.20210218 /opt/wautils/wa_create_ltpa_keys.sh -p <keys_password>

  where:
  - **<host_dir>** is an existing folder on the local machine where docker runs
  - **<keys_password>** is LTPA keys password ( for further details, see the [online](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_9.5.0/com.ibm.tivoli.itws.doc_9.5/distr/src_ad/awsadshareltpa.htm) documentation).
	
The "ltpa.keys" and "wa_ltpa.xml" files are created in the local folder \<hostdir>.

The "ltpa.keys" file must be placed into the volume that stores customized SSL certificates (on both server and console charts).

In both server and console charts, useCustomizedCert property must be set on "true".

The "wa_ltpa.xml" file must be placed in the volume that stores all custom liberty configuration (on both server and console charts).

## Supported Docker versions
This image is officially supported on Docker version 19.xx.xx, or later.

Support for versions earlier than 19.xx.xx, is provided on a best-effort basis.

See the [Docker installation documentation](https://docs.docker.com/engine/installation/) for details on how to upgrade your Docker daemon.  

## Limitations
The IBM Workload Automation container has the following limitations:

 - Derby database can be used only in a single node environment for testing purposes.

  



## Additional Information
For additional information about how to use the IBM Workload Automation, see the [online](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_9.5.0/com.ibm.tivoli.itws.doc_9.5/distr/src_pi/awspipartdepcont.htm) documentation. For technical issues, search for Workload Scheduler or Workload Automation on [StackOverflow](http://stackoverflow.com/search?q=workload+scheduler).


## License
The Dockerfile and associated scripts are licensed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0). IBM Workload Automation is licensed under the IBM International Program License Agreement. This license for IBM Workload Automation can be found [online](https://www14.software.ibm.com/cgi-bin/weblap/lap.pl?li_formnum=L-AGOO-BW6R23). Note that this license does not permit further distribution.

