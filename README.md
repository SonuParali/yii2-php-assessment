# Yii2 Docker Swarm Deployment

## Overview

This project deploys a PHP Yii2 application using Docker Swarm with NGINX as a reverse proxy. Infrastructure provisioning is automated via Ansible, and CI/CD is managed using GitHub Actions.

---

## ✅ Setup Instructions

1. **Configure EC2**
   - Launch an Ubuntu EC2 instance (t2.micro or larger)
   - Ensure these ports are open in security groups:
     - 22 (SSH)
     - 80 (HTTP)
     - 443 (HTTPS)
     - 9090 (Prometheus)
     - 3000 (Grafana)

2. **Provision using Ansible**
   - Update `ansible/inventory.ini` with your EC2 IP and SSH key path
   - Run: `ansible-playbook -i ansible/inventory.ini ansible/playbook.yml`

3. **NGINX Configuration**
   - Configured to forward traffic to your Docker container (port 8080)
   - Works with direct EC2 public IP access

4. **GitHub Actions CI/CD**
   - Automated workflow on push to main branch:
     1. Builds Docker image
     2. Pushes to Docker Hub
     3. Performs health check
     4. SSHs into EC2 and updates Docker Swarm service

---

## 🔧 Prerequisites & Assumptions

- Docker Hub credentials stored in GitHub Secrets:
  - `DOCKER_HUB_USERNAME`
  - `DOCKER_HUB_TOKEN`
- EC2 SSH key stored as GitHub Secret `EC2_KEY`
- NGINX runs directly on host EC2 instance

---

## 🚀 Verification & Testing

1. After deployment, access via:
   - `http://<your-ec2-public-ip>`

2. Expected response:
   - `Yii2 App Running via Docker Swarm!`

3. Monitoring:
   - Prometheus: `http://<ec2-ip>:9090`
   - Grafana: `http://<ec2-ip>:3000`