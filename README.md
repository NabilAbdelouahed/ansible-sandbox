# ansible-sandbox


This project sets up a mini-lab using Docker to simulate an Ansible control node and two managed nodes (Ubuntu and CentOS). It's ideal for testing Ansible playbooks and automating configuration across multiple systems in a safe environment.

##  Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/NabilAbdelouahed/ansible-sandbox.git
cd ansible-sandbox
````

### 2. Build the Environment

```bash
docker-compose build
```

### 3. Start the Lab

```bash
docker-compose up -d
```

### 4. Access the Control Node

```bash
docker exec -it control bash
su - ansible
```

Now you're in the Ansible control node as the `ansible` user.

### 5. Set Up SSH Keys for Passwordless Access to Managed Nodes

Run the following commands inside the control node to generate SSH keys and copy them to the managed nodes:

```bash
# Generate SSH key pair (accept defaults)
ssh-keygen -t rsa -b 2048

# Copy public key to the managed nodes to enable passwordless SSH
sshpass -p "ansible" ssh-copy-id -o StrictHostKeyChecking=no ansible@ubuntu-node
sshpass -p "ansible" ssh-copy-id -o StrictHostKeyChecking=no ansible@centos-node

# Test SSH access to each node (should not prompt for password)
ssh ansible@ubuntu-node
ssh ansible@centos-node
```
This will allow the control node to connect to managed nodes without password prompts, which is required for smooth Ansible automation.

Note that you can also just add `ansible_ssh_pass=ansible` directly in the `./volumes/control/inventory.ini` file to provide the SSH password but let’s not lose good security habits just because this is a sandbox environment.
## Example Inventory

The folder `./volumes/control` is mapped to `/home/ansible` inside the container. 

We set up `inventory.ini` in that directory and elso an example playbook `playbook.yml` to ping all nodes.

##  Test Connectivity

From inside the control container run :

```bash
ansible all -m ping -i inventory.ini
```
Or you can run the playbook.yml : 
```bash
ansible-playbook -i inventory.ini ping.yml
```

##  Stopping and Cleaning

To stop the containers:

```bash
docker-compose down
```


##  Notes

* All containers are on the same Docker network to allow hostname-based access.
* SSH is configured to run in each container (`CMD ["/usr/sbin/sshd", "-D"]`).
* `/home/ansible` in the control container is mapped to `./volumes/control` for persistence and easy editing.
* You can modify the Dockerfiles to include additional tools or customize users.
* Passwords are not stored in the `inventory.ini` file for security reasons. The containers include user accounts with preset passwords configured at build time. The Ansible control node connects to target containers via SSH using these accounts, and password authentication is handled separately (e.g., via `sshpass` or SSH keys)


##  Resources

* [Ansible Documentation](https://docs.ansible.com/)
* [Docker Compose Docs](https://docs.docker.com/compose/)

---

