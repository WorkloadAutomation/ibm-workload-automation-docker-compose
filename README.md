# IBM Workload Automation

## Introduction
IBM Workload Automation is a fully-featured version of the Server, Console and Agent components of IBM Workload Automation with the following restriction:

    Single node instance

## Accessing the container images

You can access the IBM Workload Automation container images from the Entitled Registry:

1. Access to the entitled registry. Log in to [MyIBM Container Software Library](https://myibm.ibm.com/products-services/containerlibrary) with the IBMid and password that are associated with the entitled software.

2.  In the **Container software library** tile, click **View library** and then click **Copy key** to copy the entitlement key to the clipboard.
3.  Execute the following command to login into the IBM Entitled Registry:
      
        docker login -u cp -p <your_entitled_key> cp.icr.io

 The images are as follows:

* cp.icr.io/cp/ibm-workload-automation-agent-dynamic:9.5.0.02.20200727
* cp.icr.io/cp/ibm-workload-automation-server:9.5.0.02.20200727
* cp.icr.io/cp/ibm-workload-automation-console:9.5.0.02.20200727


## Getting Started

If you want to start the containers via Docker Compose, use the following command to clone the current repository:

    git clone https://github.com/WorkloadAutomation/<repo_da_scegliere_ancora>.git

If you don't have git installed in your environment, download the ZIP file from the main page of the repository:

    Click on "Code" and select "Download ZIP"

If you want customize the installation parameters, modify the **docker-compose.yml** file.

In the directory where  the **docker-compose.yml** file has been located, you can start the containers by running the following command:

    docker-compose up -d

Once the command has been launched, be sure that the containers are started by checking the docker logs.

## Supported Docker versions
This image is officially supported on Docker version 1.11.0.

Support for older versions (down to 1.11.0) is provided on a best-effort basis.

Please see the [Docker installation documentation](https://docs.docker.com/engine/installation/) for details on how to upgrade your Docker daemon. 

## Limitations
The owner of all product files is the wauser user, thus the product doesn't run as root, but as wauser only. Don't perform the login as root to start processes or execute other commands such as Jnextplan, otherwise it might create some issues.

Limited to amd64 platforms.

## Additional Information
For additional information on using the IBM Workload Automation, see the [online](https://www.ibm.com/support/knowledgecenter/en/SSGSPN_9.5.0/com.ibm.tivoli.itws.doc_9.5/distr/src_pi/awspipartdepcont.htm) documentation. For technical issues, search for Workload Scheduler or Workload Automation on [StackOverflow](http://stackoverflow.com/search?q=workload+scheduler).

## License
The Dockerfile and associated scripts are licensed under the [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0). IBM Workload Automation is licensed under the IBM International Program License Agreement. This license for IBM Workload Automation can be found [online](https://www14.software.ibm.com/cgi-bin/weblap/lap.pl?li_formnum=L-AGOO-BNFE4V). Note that this license does not permit further distribution.
