# Yii2 Docker Swarm Deployment

## Overview

This project deploys a PHP Yii2 application using Docker Swarm and NGINX as a host-based reverse proxy. Infrastructure provisioning is automated via Ansible, and CI/CD is managed using GitHub Actions.

---

## ✅ Setup Instructions

1. **Configure EC2**
   - Launch a Ubuntu 22.04 EC2 instance.
   - Ensure ports 22 (SSH) and 80 (HTTP) are open.

2. **Provision using Ansible**
   - Update `ansible/inventory.ini` with your EC2 IP and SSH key.
   - Run: `ansible-playbook -i ansible/inventory.ini ansible/playbook.yml`

3. **NGINX**
   - Configured to forward traffic from `yourdomain.com` to Docker container on port 8080.

4. **GitHub Actions**
   - On push to main, GitHub:
     - Builds Docker image
     - Pushes to Docker Hub
     - SSHs into EC2 and updates Docker Swarm service

---

## 🔧 Assumptions

- Docker Hub credentials are stored in GitHub Secrets.
- EC2 private SSH key is stored as `EC2_KEY` secret.
- NGINX runs directly on EC2, not in a container.

---

## 🚀 Testing

- Visit `http://yourdomain.com` after deployment.
- You should see `Yii2 App Running via Docker Swarm!`.

