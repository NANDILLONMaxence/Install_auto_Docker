# install auto Docker

Welcome to my Github repository dedicated to automating the installation of Docker, an essential technology for container management. Here you'll find a set of scripts and resources designed to simplify and speed up the process of installing Docker on various platforms (Mainly Linux). Whether you're a developer, a system administrator or a container enthusiast, this repository aims to make Docker setup easier, saving you time and effort.

Automating Docker installation is crucial to ensuring consistent configuration, avoiding human error and simplifying the deployment of container-based applications. The scripts provided here are designed to work seamlessly on different Linux distributions and other operating systems, allowing you to concentrate on developing and managing your applications.

Feel free to explore the scripts and guides provided in this repository to get started quickly with Docker and take advantage of its benefits for application development, deployment and management. If you have any questions or suggestions, please don't hesitate to share them. We welcome your input and expertise.

Ready to simplify your Docker installation process? Let's dive into the world of automation!
## Install

Clone repository Install_auto_docker on your Docker host:
```bash
git clone https://github.com/NANDILLONMaxence/Install_auto_Docker
chmod +x Install_auto_Docker/*.sh
cd Install_auto_Docker
```

launch the script
```bash
./000_Bug-CATCHER.sh
```
```bash
./001_Install_Docker.sh
```
```bash
./002_Install_Docker_compose.sh
```
```bash
./003-0_Install_Graylog.sh
```
```bash
./005_Install_GLPI.sh
```
---
## Error log :
 - [ERROR_LOG](https://github.com/NANDILLONMaxence/Install_auto_Docker/blob/main/ERROR_LOG.md)

## Bug catcher :
 - [Bug-CATCHER](https://github.com/NANDILLONMaxence/Install_auto_Docker/blob/main/000_Bug-CATCHER.sh)
  
## Graylog4.2 Documentation with Docker compose :
 - [003-1_Send_logs_Rsyslog_on_Graylog](https://github.com/NANDILLONMaxence/Install_auto_Docker/blob/main/003-1_Send_logs_Rsyslog_on_Graylog.md)
---
## Install Prometheus and graphana with Docker compose :
 - [Repository_dockprom](https://github.com/NANDILLONMaxence/dockprom)
     
