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
#### 2. [SET UP](https://github.com/mmonpeat/Inception/blob/main/README.md#How-to-set-up-your-environment-in-your-vm?)
#### 3. [DEFINITIONS](https://github.com/mmonpeat/Inception/blob/main/README.md#DEFINITIONS)
#### 4. [DOCKER](https://github.com/mmonpeat/Inception/blob/main/README.md#DOCKER)
#### 5. [NGINX](https://github.com/mmonpeat/Inception/blob/main/README.md#NGINX)
#### 6. [WORDPRESS](https://github.com/mmonpeat/Inception/blob/main/README.md#WORDPRESS)
#### 7. [MARIADB](https://github.com/mmonpeat/Inception/blob/main/README.md#MARIADB)

---

## 1. INSTALLING DEBIAN

I’m currently setting up a Debian 12 virtual machine using Oracle VirtualBox as part of a development environment for future projects involving Docker, Nginx, and WordPress.
To download the iso: [https://www.debian.org/download](https://cdimage.debian.org/debian-cd/12.11.0-live/amd64/iso-hybrid/) debian-live-12.11.0-amd64-standard.iso

To ensure I don’t run into limitations later, I’ve assigned generous resources to the VM:

    RAM: 4000 MB

    CPUs: 2 cores

    Disk size: 40 GB

Yes, I’m aware this might seem like overkill for a basic Debian install. However, considering the future use of containers, servers, and potentially multiple services running in parallel, I prefer to have headroom rather than regret a minimal setup later. Planning ahead saves pain later — especially with Docker's storage and RAM needs.

### Installation Steps
I opted for the text-based installer (instead of the graphical one) for speed and simplicity. It's more transparent and often more reliable on VMs.
```bash
1. Boot Menu
<img width="886" height="606" alt="Captura de pantalla de 2025-07-17 09-36-37" src="https://github.com/user-attachments/assets/930f7b67-7c36-49ab-a8a0-27f9f2ba0f43" />
<img width="886" height="606" alt="Captura de pantalla de 2025-07-17 09-36-48" src="https://github.com/user-attachments/assets/a65ac34c-45d5-45ef-b232-d3d7c93dde2d" />
<img width="886" height="606" alt="Captura de pantalla de 2025-07-17 09-36-57" src="https://github.com/user-attachments/assets/9899908d-92b9-40ff-9bb7-dbde0fe6db71" />
<img width="640" height="555" alt="Captura de pantalla de 2025-07-17 09-38-20" src="https://github.com/user-attachments/assets/639ebd52-15ee-40c9-889e-9306f62b9dfe" />
<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-42-11" src="https://github.com/user-attachments/assets/a5ab91b3-f769-4943-8521-27ea024bf9db" />

User Creation

<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-43-53" src="https://github.com/user-attachments/assets/c3ef9240-e00a-4784-8d70-6f751d4d4707" />

3. Disk Partitioning

<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-45-36" src="https://github.com/user-attachments/assets/15284f0f-6d38-40ee-9192-91b1eeb4850c" />
<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-45-44" src="https://github.com/user-attachments/assets/84b97e2c-1a39-4919-9243-baeb663209ed" />
<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-45-49" src="https://github.com/user-attachments/assets/e44b440c-3906-4877-9781-c5a4172473fd" />

<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-45-59" src="https://github.com/user-attachments/assets/b63eb055-a9a6-408e-874d-09d4132b5b5f" />
<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-46-25" src="https://github.com/user-attachments/assets/c8bace74-7f52-4675-83e0-a3342542f6f1" />
<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-48-02" src="https://github.com/user-attachments/assets/e9eda6a0-9f3c-4e12-af9f-4af48cc66295" />

<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-48-11" src="https://github.com/user-attachments/assets/6505d54e-8b8b-4c7d-8515-d83228c6569b" />
<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-48-43" src="https://github.com/user-attachments/assets/d9c6cc4a-cdef-4552-b8aa-e97ec0f63be0" />
<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-50-36" src="https://github.com/user-attachments/assets/9210531b-db6e-425a-89a4-e0d69c35ab92" />
<img width="794" height="679" alt="Captura de pantalla de 2025-07-17 09-50-52" src="https://github.com/user-attachments/assets/827eaabb-0bdf-4799-b93d-12505613963f" />

```

## 2. How to set up your environment in your vm?

#### Create a new user named after your login and assign it to the different groups

`su`
per entrar com superusuari i poder ficar login com a superuser

`sudo adduser login`

`sudo usermod -aG sudo login`

`sudo usermod -aG docker login` //despres de instalació doker

m'he equivocat al crear el usuari durant la creacio vm pertant he creat un altre amb el login

`sudo deluser --remove-home maria`

#### Connect with SSH to you VM


## 3. DEFINITIONS

## 4. DOCKER

Actualitza sistema
`sudo apt update && sudo apt upgrade -y`

Instal.la prerequisits doker

`sudo apt install -y ca-certificates curl gnupg lsb-release`

Afegeix la clau GPG i repositori oficial de Docker
```bash
sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
Instal·la Docker
```bash
sudo apt upgrade
sudo apt install -y docker-ce docker-ce-cli containerd.io
```
Comprova que Docker funciona
`sudo docker run hello-world`

### Docker Compose

`sudo apt install docker-compose-plugin`

`docker compose version`

*(Setup Docker, Docker Compose, and basic commands.)*

## 5. NGINX

*(Configuration of NGINX container with TLS.)*

## 6. WORDPRESS

*(Configuration of WordPress with php-fpm.)*

## 7. MARIADB

*(Configuration of MariaDB, users, and volumes.)*


