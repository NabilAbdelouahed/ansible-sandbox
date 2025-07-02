# ansible-sandbox


This project sets up a mini-lab using Docker to simulate an Ansible control node and two managed nodes (Ubuntu and CentOS). It's ideal for testing Ansible playbooks and automating configuration across multiple systems in a safe environment.

##  Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/NabilAbdelouahed/ansible-sandbox.git
cd ansible-sandbox
````

### 2. Build and start the Lab

```bash
docker-compose up -d --build
```

### 3. Access the Control Node

```bash
docker exec -it control bash
su - ansible
```

Now you're in the Ansible control node as the `ansible` user.

### 4. Set Up SSH Keys for Passwordless Access to Managed Nodes

```bash
./script.sh
```
This will allow the control node to connect to managed nodes without password prompts, which is required for smooth Ansible automation.

## Example Inventory

We set up `inventory.ini` and also an example playbook `playbook.yml` to ping all nodes.

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
docker-compose down -v
```


##  Notes

* All containers are on the same Docker network to allow hostname-based access.
* SSH is configured to run in each container (`CMD ["/usr/sbin/sshd", "-D"]`).

* You can modify the Dockerfiles to include additional tools or customize users.


##  Resources

* [Ansible Documentation](https://docs.ansible.com/)
* [Docker Compose Docs](https://docs.docker.com/compose/)

---

