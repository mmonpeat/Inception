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
Encenem la maquina virtual.
Desde la terminal del sitema principal possem:
`ssh login@127.0.0.1 -p 2222 o ssh login@10.0.2.15`

## 3. DEFINITIONS

### DOCKER

Docker is a platform that enables packaging applications and their dependencies into containers - lightweight, isolated environments that guarantee consistency across different environments (dev, test, production).

**Key benefits:**
- **Portability:** Containers run identically on any machine with Docker installed.
- **Efficiency:** They share the host system's kernel, consuming fewer resources than virtual machines (VMs).
- **Reproducibility:** `Dockerfile` allow defining infrastructure as version-controlled code.

**Comparison with VMs:**  
| Docker (Containers) | Virtual Machines (VMs) |  
|----------------------|-------------------------|  
| Shares host OS kernel | Includes complete OS |  
| Fast startup (~seconds) | Slow startup (~minutes) |  
| Lower CPU/RAM usage | More resource-intensive |  

----

Docker és una plataforma que permet empaquetar aplicacions i les seves dependències en **contenidors**, entorns aïllats i lleugers que garanteixen consistència entre diferents entorns (dev, test, producció).

**Beneficis clau:**
- **Portabilitat:** Els contenidors s’executen igual a qualsevol màquina amb Docker.
- **Eficiència:** Comparteixen el nucli del sistema host, consumint menys recursos que una màquina virtual (VM).
- **Reproduïbilitat:** Els `Dockerfile` permeten definir infraestructura com a codi (versionable).

**Comparació amb VMs:**  
| Docker (Contenidors) | Màquines Virtuals (VMs) |  
|----------------------|-------------------------|  
| Comparteix nucli OS | Inclou OS complet |  
| Inici ràpid (~segons) | Inici lent (~minuts) |  
| Menys consum de CPU/RAM | Més exigent en recursos |  

---

### DOCKER COMPOSE

Tool for defining and managing **multi-container applications** using a `docker-compose.yml` file.  

**Difference from standalone Docker:**  
- **Without Compose:** You manually manage each container using CLI commands (`docker run`, networks, volumes).  
- **With Compose:** Orchestrate all services (e.g., WordPress + NGINX + MariaDB) with **a single command** (`docker-compose up`).  

**Usage example:**  
```yaml
services:
  nginx:
    image: nginx:alpine
    ports: ["443:443"]
  wordpress:
    build: ./wordpress
    depends_on: ["db"]
  db:
    image: mariadb:10.5
    volumes: ["db_data:/var/lib/mysql"]
```
---- 

Eina per definir i gestionar **aplicacions multi-contenidor** mitjançant un fitxer `docker-compose.yml`.  

**Diferència amb Docker sol:**  
- **Sense Compose:** Has de gestionar cada contenidor manualment, exeecutant la imatge amb comandes CLI() (`docker run`, xarxes, volums).  
- **Amb Compose:** Orquestres tots els serveis (ex: WordPress + NGINX + MariaDB) amb **una sola comanda** (`docker-compose up`).  

**Exemple d’ús:**  
```yaml
services:
  nginx:
    image: nginx:alpine
    ports: ["443:443"]
  wordpress:
    build: ./wordpress
    depends_on: ["db"]
  db:
    image: mariadb:10.5
    volumes: ["db_data:/var/lib/mysql"]
```

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

#### General docker commands

```
- docker ps or docker ps -a //show the names of all the containers you have + the id you need and the port associated.
- docker pull "NameOfTheImage" // pull an image from dockerhub
- docker "Three first letter of your docker" // show the logs of your last run of dockers
- docker rm $(docker ps -a -q) //allow to delete all the opened images
- docker exec -it "Three first letter of your docker" sh // to execute the program with the shell
```
#### Docker run
```
- docker run "name of the docker image" //to run the docker image
- docker run -d, // run container in background
- docker run -p,// publish a container's port to the host
- docker run -P, // publish all exposed port to random ports
- docker run -it "imageName", //le programme continuera de fonctionner et on pourra interagir avec le container
- docker run -name sl mysql, //give a name for the container instead an ID
- docker run -d -p 7000:80 test:latest
```
#### Docker image
```
- docker image rm -f "image name/id", //delete the image, if the image is running you need to kill it first.
- docker image kill "name", //stop a running image,
```

### Docker Compose

`sudo apt install docker-compose-plugin`

`docker compose version`

### HOW TO WRITE A DOCKER FILE


## 5. NGINX
### que es NGINX?
NGINX és un servidor web d'alt rendiment que també pot funcionar com a balancejador de càrrega i servidor proxy invers. En aquest projecte, l'utilitzarem com a:
- Punt d'entrada únic a la infraestructura (via port 443)
- Terminació SSL/TLS per a connexions segures
- Proxy cap a WordPress (redirigint les peticions HTTPS al servei intern de WordPress/PHP-FPM)
* Un balancejador de càrrega és un sistema que reparteix el tràfic d’entrada entre diversos servidors o contenidors, per evitar que un sol es col·lapsi. Això millora el rendiment i la disponibilitat.
  Exemple: Imagina que tens 3 contenidors de WordPress, i entren 100 peticions. NGINX pot actuar com a load balancer, enviant 33 peticions a cada contenidor, equilibrant la càrrega.
* Un proxy invers és un servidor que rep les peticions dels clients (per exemple, navegadors) i les redirigeix cap a altres serveis interns, com WordPress, MariaDB o APIs. El client no veu què hi ha darrere, només veu el proxy.
  Exemple: Quan algú entra a https://elmeuusuari.42.fr, NGINX rep la petició al port 443, fa la connexió segura (SSL/TLS), i després la redirigeix internament cap al contenidor de WordPress pel port 9000, per exemple. El client no ho sap: per ell, tot és "el mateix servidor".

inception/
└── srcs/
    └── nginx/
        ├── Dockerfile
        ├── conf/
        │   └── default
        └── tools/
            └── nginx.sh
            
### Dockerfile per NGINX
🔹 debian:bullseye
Tracking de la versió estable Bullseye (rolling dentro la major release).
Es pot actualitzar (passa de 11.6 → 11.7 automàticament quan Docker fa pull).
No tan previsible: si una nova 11.8 surt, pot canviar el teu entorn.

🔹 debian:11.7
Versió fixa i predictible de Bullseye. Suport Fins juny 2026
Mateix comportament sempre: ideal per entorns educatius i defensables.
```
FROM debian:11.7

EXPOSE 443//Declara que el contenidor escoltarà al port 443 (HTTPS).
//No obre el port físicament (es farà a docker-compose.yml) i Bloqueja implícitament el port 80 (com demana el projecte)

RUN apt-get update && apt-get install -y \ 
	nginx \
	openssl
//Actualitza l'índex de paquets i instala nginx: Servidor web, openssl: Generar certificats TLS (Nota: -y auto-accepta instal·lacions)

COPY conf/default /etc/nginx/sites-enabled/ //Sobreescriu la configuració per defecte que posem en el fitxer default
COPY --chmod=755 tools/nginx.sh /var/www/nginx.sh //Copia un script d'inici (nginx.sh) al contenidor. --chmod=755: Assigna permisos d'execució (owner: rwx, grup/altres: rx) (Necessari perquè l'ENTRYPOINT pugui executar-lo)

ENTRYPOINT [ "/var/www/nginx.sh" ] //Executa aquest script abans de l'arrencada del NGINX

CMD [ "nginx", "-g", "daemon off;" ] //Comanda final per iniciar NGINX. daemon off: Executa NGINX en primer pla (requerit per Docker) Es llança després de l'ENTRYPOINT
```

## 6. WORDPRESS

*(Configuration of WordPress with php-fpm.)*

## 7. MARIADB

*(Configuration of MariaDB, users, and volumes.)*

## 8. CORRECIÓ ABANS COMENCAR

- Before starting the evaluation, run this command in the terminal:
"docker stop $(docker ps -qa); docker rm $(docker ps -qa);
docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q);
docker network rm $(docker network ls -q) 2>/dev/null"

- Read the docker-compose.yml file. There musn't be 'network: host' in
it or 'links:'. Otherwise, the evaluation ends now.

- Read the docker-compose.yml file. There must be 'network(s)' in it.
Otherwise, the evaluation ends now.

- Examine the Makefile and all the scripts in which Docker is used.
There musn't be '--link' in any of them. Otherwise, the evaluation
ends now.

- Examine the Dockerfiles. If you see 'tail -f' or any command run in
background in any of them in the ENTRYPOINT section, the evaluation
ends now. Same thing if 'bash' or 'sh' are used but not for running a
script (e.g, 'nginx & bash' or 'bash').

- If the entrypoint is a script (e.g., ENTRYPOINT ["sh", "my_entrypoint.sh"],
ENTRYPOINT ["bash", "my_entrypoint.sh"]), ensure it runs no program
in background (e.g, 'nginx & bash').

- Examine all the scripts in the repository. Ensure none of them runs
an infinite loop.
The following are a few examples of prohibited commands:
'sleep infinity', 'tail -f /dev/null', 'tail -f /dev/random'

- Run the Makefile.
