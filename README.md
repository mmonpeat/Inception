# Inception

## Introduction

Welcome to the Inception project for 42. This repository contains all the necessary configuration files and resources to deploy a small infrastructure using Docker Compose on a Debian-based Virtual Machine. The goal is to build and orchestrate three services—NGINX (with TLSv1.2/1.3), WordPress (with PHP-FPM), and MariaDB—each in its own container, following Docker best practices and ensuring automatic restarts, secure handling of credentials, and network isolation.

This project is structured to help you learn step by step:

* Define and configure each service via custom Dockerfiles.
* Store sensitive data securely using environment variables and Docker secrets.
* Use volumes for persisting database data and website files.
* Expose only the NGINX container on port 443 with TLS.

> *Note: The bonus part is omitted due to time constraints.*

## Read Before Start

Before you begin, please review the following guidelines and recommended workflow taken from [vbachele/inception](https://github.com/vbachele/Inception):

```
Don't try to do all the containers (Nginx, WordPress and MariaDB) at the same time. You will be lost and you will not understand properly how it works. Do it step by step.

Begin with Nginx by displaying an index.html page:
  • Learn first how to launch a Docker image & execute it without using docker-compose.
  • Learn how to display an HTML page on http://localhost:80.
  • Learn how to display an HTML page with SSL on https://localhost:443.

Then move on to WordPress:
  • You can begin your docker-compose file here; it’s not required before setting up Nginx.

Finish with MariaDB.

If you want to test each container individually, you can pull the official WordPress and MariaDB images from Docker Hub to verify functionality before writing your own Dockerfiles.
```

## Summary

#### 1. [INSTALLING DEBIAN](https://github.com/mmonpeat/Inception/blob/main/README.md#INSTALLING-DEBIAN)
#### 2. [DOCKER](#docker)
#### 3. [NGINX](#nginx)
#### 4. [WORDPRESS](#wordpress)
#### 5. [MARIADB](#mariadb)

---

## 1. INSTALLING DEBIAN

I’m currently setting up a Debian 12 virtual machine using Oracle VirtualBox as part of a development environment for future projects involving Docker, Nginx, and WordPress.
To download the iso: https://www.debian.org/download

To ensure I don’t run into limitations later, I’ve assigned generous resources to the VM:

    RAM: 4000 MB

    CPUs: 2 cores

    Disk size: 40 GB

Yes, I’m aware this might seem like overkill for a basic Debian install. However, considering the future use of containers, servers, and potentially multiple services running in parallel, I prefer to have headroom rather than regret a minimal setup later. Planning ahead saves pain later — especially with Docker's storage and RAM needs.

### Installation Steps
I opted for the text-based installer (instead of the graphical one) for speed and simplicity. It's more transparent and often more reliable on VMs.
1. Boot Menu
<img width="636" height="530" alt="Captura de pantalla de 2025-07-10 04-21-28" src="https://github.com/user-attachments/assets/c71e7765-bee6-4632-8979-bf984fd9791f" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-23-52" src="https://github.com/user-attachments/assets/7c5278bd-6f41-4326-8ef2-2e1eefb19870" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-24-06" src="https://github.com/user-attachments/assets/f206a306-97cb-476d-ab0e-7d2e2a479612" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-24-56" src="https://github.com/user-attachments/assets/9f17c400-33f5-485d-b52d-d385eab6a533" />

2. User Creation

<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-25-30" src="https://github.com/user-attachments/assets/326e93e9-dfdb-40cc-af19-ab2c2f5e7084" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-25-30" src="https://github.com/user-attachments/assets/e829f0cd-974b-4dcd-8e8d-670dd6ac7186" />

3. Disk Partitioning

<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-26-55" src="https://github.com/user-attachments/assets/70f5047b-1c79-4ca0-a409-0dbc33a46b20" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-27-08" src="https://github.com/user-attachments/assets/86495e98-8bf8-4624-8a24-c1200f8b3768" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-27-22" src="https://github.com/user-attachments/assets/628c33e1-aac9-4ae0-a858-bbc32e7a65ab" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-27-33" src="https://github.com/user-attachments/assets/bbe78de1-14df-4ceb-a31f-f2fbe6d3d320" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-28-23" src="https://github.com/user-attachments/assets/7bcbad71-1823-40b0-9f9a-6a15814b0c57" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-32-24" src="https://github.com/user-attachments/assets/e57f55c9-c579-4da2-9bc3-74ceb38e703d" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-33-04" src="https://github.com/user-attachments/assets/a1e7fbd5-e747-4f32-9029-776665fcda99" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-33-35" src="https://github.com/user-attachments/assets/e748135e-188d-4ab9-89e5-4342c12f5305" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-34-56" src="https://github.com/user-attachments/assets/23755b5b-61bb-4f63-a3d7-ccf15eaa938e" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-55-58" src="https://github.com/user-attachments/assets/54ba5f34-6313-41e2-8648-40fbb42b0c18" />
<img width="800" height="678" alt="Captura de pantalla de 2025-07-10 04-56-20" src="https://github.com/user-attachments/assets/1c430742-a415-4dac-a2ba-0542974d3836" />


## 2. DOCKER
#### Definition
actualitza sistema
sudo apt update && sudo apt upgrade -y

Instal.la prerequisits doker
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt upgrade

sudo docker run hello-world

sudo apt install -y docker-ce docker-ce-cli containerd.io

### Docker Compose
#### Definition

sudo apt install docker-compose-plugin

docker compose version

*(Setup Docker, Docker Compose, and basic commands.)*

## 3. NGINX

*(Configuration of NGINX container with TLS.)*

## 4. WORDPRESS

*(Configuration of WordPress with php-fpm.)*

## 5. MARIADB

*(Configuration of MariaDB, users, and volumes.)*


