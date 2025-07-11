# Inception
## Read before start
# SUMMARY
#### 1. [INSTALLING DEBIAN](https://github.com/mmonpeat/Inception/blob/main/README.md#INSTALLING-DEBIAN)

# INSTALLING DEBIAN
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

