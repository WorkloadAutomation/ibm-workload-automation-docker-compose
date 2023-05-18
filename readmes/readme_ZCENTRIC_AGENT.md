

# Workload Automation z-centric Agent

## Introduction
Workload Automation is a complete, modern solution for batch and real-time workload management. It enables organizations to gain complete visibility and control over attended or unattended workloads. From a single point of control, it supports multiple platforms and provides advanced integration with enterprise applications including ERP, Business Analytics, File Transfer, Big Data, and Cloud applications.

Docker adoption ensures standardization of your workload scheduling environment and provides an easy method to replicate environments quickly in development, build, test, and production environments, speeding up the time it takes to get from build to production significantly. Install your environment using Docker to improve scalability, portability, and efficiency.

z-centric Agent has the following restriction:

 - Single node instance 




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
You can access the z-centric Agent container image from the Entitled Registry:

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
        -e LICENSE=ACCEPT \
	    -e ZCONN_URL=https://zconn_hostname:zconn_port/twsz/v1/plugin \
        -v workload-automation-agent-zcentric-data:/home/wauser \
        ibm-workload-automation-agent-zcentric:10.1.0.00.<release_date>

> **Note:** The name of the image has to be the same as the one you loaded on your local workstation when you launched the docker load command.


> **Note:** After launching the docker load command, you can see the name of the loaded image that should be defined either in the *docker run* command or in the *docker-compose.yml* file to start the container. For further information, see the Configuration Variables section.

### Installing with custom .PEM certificates
To use custom certificates, modify the volume `<path_on_host_containing_certs>:/opt/wautils/certs` with the path of the directory that contains your certificates at the place of `<path_on_host_containing_certs>`. In the defined folder, add the following certificates:
	 
      - ca.crt
      - tls.key
      - tls.crt
 


  
      
## Configuration Variables

The following table lists the configurable variables for the z-centric Agent:

For example, specify the variable and its value as follows: LICENSE=ACCEPT

| Variable        | Description                                                                                                                                                                                                                                                                   | Mandatory   | Example     |
| --------------  | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  | ----------  | ----------- |
| LICENSE         | Use ACCEPT to agree to the license agreement                                                                                                                                                                                                                                  | yes         | notaccept   |
| AGT_NAME        | Computer System Display Name. The default value is WSAGENT99                                                                                                                                                                                                                  | yes         | WSAGENT99   |
| LANG            | The language of the container internal system. The supported language are: en (English), de (German), es (Spanish), fr (French), it (Italian), ja (Japanese), ko (Korean), pt_BR (Portuguese (BR)), ru (Russian), zh_CN (Simplified Chinese) and zh_TW (Traditional Chinese)  | yes         | en          |
| HTTPS           | If yes, the controller connects to the Agent by using the HTTPS protocol; otherwise it is established by using the HTTP protocol                                                                                                                                              | no          | YES         |
| MAXWAITONEXIT   | The number of seconds the Agent waits for the completion of all processes before stopping the container. The default value is 60 sec, the maximum value is 3600 sec                                                                                                           | no          | 60 sec      |
| TZ              | If used, it sets the TZ operating system environment variable                                                                                                                                                                                                                 | no          | Europe/Rome |
| ZCONN_URL       | Specified in the format zconn_hostname:zconn_port where zconn_hostname is the fully qualified host name of the Z connector (this is coincident with the Dynamic Workload Console host name) and zconn_port is the HTTP or HTTPS port number of the Z connector (valid range is from 1 to 65535). This parameter adds the capability to download the plug-ins from the Z connector. The default value is https://zconn_hostname:zconn_port/twsz/v1/plugin         | no          | https://zconn_hostname:zconn_port/twsz/v1/plugin |
| SSL_PASSWORD              | The password to open the private key (tls.key)                                                                                                                                                                                                          | Only if you use custom certificates in PEM format         |                      |








## Supported Docker versions
This image is officially supported on Docker version 19.xx.xx, or later.

Support for versions earlier than 19.xx.xx, is provided on a best-effort basis.

See the [Docker installation documentation](https://docs.docker.com/engine/installation/) for details on how to upgrade your Docker daemon.  


  
## Limitations
The owner of all product files is the wauser user, thus the product does not run as root, but as wauser only. Do not perform the login as root to start processes or run other commands such as Jnextplan, otherwise it might create some issues.

On amd64 and Linux on Z platforms.



## Additional Information
For additional information about how to use the IBM Workload Automation Agent, see the [online](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_10.1.0/com.ibm.tivoli.itws.doc_9.5/distr/src_pi/awspipartdepcont.htm) documentation. For technical issues, search for Workload Scheduler or Workload Automation on [StackOverflow](http://stackoverflow.com/search?q=workload+scheduler).


## License
The Dockerfile and associated scripts are licensed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0). IBM Workload Automation Agent is licensed under the IBM International Program License Agreement. This license for IBM Workload Automation Agent can be found [online](https://www14.software.ibm.com/cgi-bin/weblap/lap.pl?li_formnum=L-AGOO-C8MLWF). Note that this license does not permit further distribution.
