
# Workload Automation Dynamic Agent


## Introduction
Workload Automation is a complete, modern solution for batch and real-time workload management. It enables organizations to gain complete visibility and control over attended or unattended workloads. From a single point of control, it supports multiple platforms and provides advanced integration with enterprise applications including ERP, Business Analytics, File Transfer, Big Data, and Cloud applications.

Docker adoption ensures standardization of your workload scheduling environment and provides an easy method to replicate environments quickly in development, build, test, and production environments, speeding up the time it takes to get from build to production significantly. Install your environment using Docker to improve scalability, portability, and efficiency.

> **Note**: The Dynamic Agent component (also the one included in the Workload Automation Server container) is deployed and configured with a gateway.






## Supported tags
- 10.1.0.03.20230511-amd64
- 10.1.0.02.20230301
- 10.1.0.00.20220722
- 10.1.0.00.20220512
- 10.1.0.00.20220304
- 9.5.0.06.20220617
- 9.5.0.05.20211217
 
 ## Supported platforms
 The supported operating systems are: Windows, Linux intel based 64-bit, and Linux on Z.
 


## Accessing the container images

### From the Entitled Registry
You can access the Dynamic Agent container image from the Entitled Registry:

1. Access the entitled registry. Log in to [MyIBM Container Software Library](https://myibm.ibm.com/products-services/containerlibrary) with the IBMid and password that are associated with the entitled software.


2.  In the **Container software library** tile, click **View library** and then click **Copy key** to copy the entitlement key to the clipboard.

3.  Run the following command to login into the IBM Entitled Registry:
      
        docker login -u cp -p <your_entitled_key> cp.icr.io
	

 The image is as follows:

* cp.icr.io/cp/ibm-workload-automation-agent-dynamic:10.1.0.00.20220722


### From IBM Fix Central

If you are accessing the images from IBM Fix Central, use the following command to upload the image to your local Docker environment:

     docker load -i <tar_name>
	 
  where <tar_name> is the name of the .tar file containing the image.




Before you deploy IBM Workload Automation components on Linux on Z, see  [Deploying Docker compose on Linux on Z](https://www.ibm.com/docs/workload-scheduler/10.1.0?topic=SSGSPN_10.1.0/compose-deploying-docker-linux-z)




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

    docker-compose up -d wa-agent

Once the command has been launched, be sure that the containers are started using the following command:

    docker ps 

You can optionally check the container logs using the following command:

    docker-compose logs -f wa-agent


### Getting Started with Docker run

To start the container from the command-line, launch the following command by adding the name of the image that has been loaded:

    docker run \
        -d -e AGT_NAME=agent_name \
        -e SERVERHOSTNAME=server_host_name \
        -e SERVERPORT=server_port \
        -e LICENSE=ACCEPT \
        -v workload-automation-agent-dynamic-data:/home/wauser \
        ibm-workload-automation-agent-dynamic:10.1.0.00.<release_date>


> **Note:** The name of the image has to be the same as the one you loaded on your local workstation when you launched the docker load command.

> **Note:** After launching the docker load command, you can see the name of the loaded image that should be defined either in the *docker run* command or in the *docker-compose.yml* file to start the container. For further information, see the Configuration Variables section.


### Installing with custom .PEM certificates
To use custom certificates, modify the volume `<path_on_host_containing_certs>:/opt/wautils/certs` with the path of the directory that contains your certificates at the place of `<path_on_host_containing_certs>`. In the defined folder, add the following certificates:
	 
      - ca.crt
      - tls.key
      - tls.crt
      
### Enabling communication with the server using JWT 

If you want to install the agents without using certificates and also enable communication with the server through the JWT Token, use the following configuration variables:

**WA_USER_ENGINE**

**WA_USER_ENGINE_PASSWORD**

As an alternative to specifying user name and password, you can use the **WA_API_KEY** configuration variable and specify a valid API key. Ensure the API key has not expired.

The variables are described in the **Configuration Variables** section.

## Configuration Variables

The following table lists the configurable variables for the Dynamic Agent:

For example, specify the variable and its value as follows: LICENSE=ACCEPT

| Variable           | Description                                                                                                                                                                                                                                                                   | Mandatory   | Example           |
| -----------------  | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  | ----------  |-----------------  |
| LICENSE            | Use ACCEPT to agree to the license agreement                                                                                                                                                                                                                                  | yes         | notaccept         |
| SERVERHOSTNAME     | The hostname of the master domain manager                                                                                                                                                                                                                                     | yes         | wamdm.demo.com    |
| SERVERPORT         | The HTTPS port that the dynamic agent must use to connect to the master domain manager. The default value is 31116                                                                                                                                                            | yes         | 31116             |
| AGT_NAME           | The workstation name of the dynamic agent to be run. The default value is WA_AGT                                                                                                                                                                                              | no          | WA_AGT            |
| LANG               | The language of the container internal system. The supported language are: en (English), de (German), es (Spanish), fr (French), it (Italian), ja (Japanese), ko (Korean), pt_BR (Portuguese (BR)), ru (Russian), zh_CN (Simplified Chinese) and zh_TW (Traditional Chinese)  | yes         | en                |
| POOLS              | The static pools of which the Agent should be a member                                                                                                                                                                                                                        | no          | Pool1, Pool2      |
| BKMSERVERHOSTNAME  | The hostname of the backup master domain manager                                                                                                                                                                                                                              | no          | wabkm.demo.com    | 
| MAXWAITONEXIT      | The number of seconds the Agent waits for the completion of all processes before stopping the container. The Default value is 60 sec, the maximum value is 3600 sec                                                                                                           | no          | 60 sec            |   
| TZ                 | If used, it sets the TZ operating system environment variable                                                                                                                                                                                                                 | no          | Europe/Rome       |
| WA_USER_ENGINE                 | The user for which you have installed the master domain manager to which the agent is connecting                                                                                                                                                                                                                 | no          | wa_user       |
| WA_USER_ENGINE_PASSWORD                 | The password for the user for which you have installed the master domain manager to which the agent is connecting                                                                                                                                                                                                                 | no          | wa_user_password       |
| SSL_PASSWORD              | The password to open the private key (tls.key)                                                                                                                                                                                                          | Only if you use custom certificates in PEM format         |                      |
| WA_API_KEY              | A valid API key                                                                                                                                                                                                          | no         |                      |


## Deploying and starting the IBM Workload Automation Agent dynamic agent container on Red Hat OpenShift

Ensure you have installed Red Hat OpenShift v3.10 or later.

* To modify default values that are not shown as parameters, modify your existing **openshift-template.yml** file.

* To use customized certificates or bind a persistent volume using labels, modify your existing **openshift-template.yml** file by uncommenting the related sections. For further details, see the table below.

> **Note**: Ensure you maintain the indentation when uncommenting the object and variable sections. 

* Import the template objects contained in the **openshift-template.yml** file in the OpenShift console; if you are using the OpenShift command line, create them by issuing the following command:

      oc create -f <file_name>
	  
      where <file_name> is **openshift-template.yml**.
	  
* Configure the variables listed in the table above, and the following additional ones specific to OpenShift:

| Variable               | Description                                                                         | Mandatory | Example                                        |
| ---------------------- | ----------------------------------------------------------------------------------- | --------- | ---------------------------------------------- |
| PULL_POLICY            | The Docker image pull policy (Always/ IfNotPresent/Never)                           | yes       | Always                                         |
| INSTANCE_NAME          | The application instance name                                                       | yes       |                                                |
| REPLICA_COUNT          | The number of replicas to deploy                                                    | yes       | 1                                              |
| STORAGE_CLASS          | The name of the StorageClass to be used. Leave empty to not use a storage class     | no        |                                                |
| WA_DEBUG               | The container is executed in debug mode to keep container running in case of errors | yes       | false                                          |
| PV_LABEL_NAME (\*)      | The Persistent Volume label name to bind (only limited to single label)             | yes       |                                                |
| PV_LABEL_VALUE (\*)     | The Persistent Volume label value to bind (only limited to single value)            | yes       |                                                |
| CUSTOM_CERT_SECRET (\*\*) | The name of the secret to store customized SSL certificates                         | yes       | waagent-cert-secret                            |

(\*) The parameters are available only if the "BEGIN SECTION - PV Selector" sections have been uncommented in the **openshift-template.yml** file. If commented, they are ignored.

(\*\*) The parameters are available only if the "BEGIN SECTION - Certificates' Secret" sections have been uncommented in the **openshift-template.yml** file. If commented, the default certificates are used.

* Deploy the objects defined in the **openshift-template.yml**; if you are using the OpenShift command line, deploy them by launching the oc process command. For example:

      oc process <template_name> -p LICENSE=ACCEPT -p INSTANCE_NAME=<instance_name> -p SERVERHOSTNAME=<serverhostname> -p IMAGE=<image_name> | oc create -f -

      where <template_name> is the template name defined in the **openshift-template.yml** file
	  
#### Certificates' Secret

If you want to use custom Agent certificates, uncomment the "BEGIN SECTION - Certificates' Secret" sections in the **openshift-template.yml** file, and create the secret in the same namespace where you want to deploy the objects:   
     
      oc create secret generic release_name-secret --from-file=TWSClientKeyStoreJKS.jks --from-file=TWSClientKeyStoreJKS.sth --from-file=TWSClientKeyStore.kdb --from-file=TWSClientKeyStore.sth

    
where TWSClientKeyStoreJKS.jks  TWSClientKeyStoreJKS.sth  TWSClientKeyStore.kdb  TWSClientKeyStore.sth are the container keystore and stash file containing your customized certificates.
For details about custom certificates, see the [online](https://www.ibm.com/docs/workload-scheduler/10.1.0?topic=cso-customizing-certificates-master-domain-manager-dynamic-agent-communication) documentation.
    
    See an example where `release_name` = myname and `namespace` = default: 
    
      oc create secret generic myname-secret --from-file=TWSClientKeyStore.kdb --from-file=TWSClientKeyStore.sth
	  
    > **Note**: Customized certificates must have the same name of the ones listed above.
		
#### Storage
To make persistent all configuration and runtime data, the Persistent Volume you specify is mounted in the following container folder:
   
      /home/wauser

The Pod is based on a StatefulSet. This to guarantee that each Persistent Volume is mounted in the same Pod when it is scaled up or down.  

You can pre-create Persistent Volumes to be bound to the StatefulSet using Label or StorageClass. Anyway, it is highly suggested to use persistence with dynamic provisioning. In this case you must have defined your own Dynamic Persistence Provider.







## Supported Docker versions
This image is officially supported on Docker version 19.xx.xx, or later.

Support for versions earlier than 19.xx.xx, is provided on a best-effort basis.

See the [Docker installation documentation](https://docs.docker.com/engine/installation/) for details on how to upgrade your Docker daemon.  


## Limitations
The owner of all product files is the wauser user, thus the product does not run as root, but as wauser only. Do not perform the login as root to start processes or run other commands, otherwise it might create some issues.

On amd64 and Linux on Z platforms.
  



## Additional Information
For additional information about how to use the IBM Workload Automation Agent, see the [online](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_10.1.0/com.ibm.tivoli.itws.doc_9.5/distr/src_pi/awspipartdepcont.htm) documentation. For technical issues, search for Workload Scheduler or Workload Automation on [StackOverflow](http://stackoverflow.com/search?q=workload+scheduler).


## License
The Dockerfile and associated scripts are licensed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0). IBM Workload Automation Agent is licensed under the IBM International Program License Agreement. This license for IBM Workload Automation Agent can be found [online](https://www14.software.ibm.com/cgi-bin/weblap/lap.pl?li_formnum=L-AGOO-C87LWG). Note that this license does not permit further distribution.

