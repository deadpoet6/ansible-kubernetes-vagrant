### Hi there <img src="https://raw.githubusercontent.com/MartinHeinz/MartinHeinz/master/wave.gif" width="30px">, I am Manoj Reddy! This is repo creates a 3 node kubernetes cluster

# ansible-kubernetes-vagrant
Kubernetes cluster creation using vagrant and ansible. Creates 1 master and 2 worker nodes of
Kubernetes version = 1.20

### Tested on 
  * vagrant version = 2.2.7
  * virtual box = 6.x.x
  * OSx (Mac)

* create the cluster using `vagrant up`

# Access the cluster from host machine
* ssh into master node and copy the `/etc/kubernetes/admin.conf` to the host machine under `~/.kube/config`

# ISSUES Troubleshooting 

Following are general issues when creating the cluster and solutions how to overcome them
### Following steps are integrated into the playbook now
  * To access the pods and logs of pods from the host machine configure the worker nodes as below

    `ssh vagrant@worker-1`

    `sudo nano /etc/systemd/system/kubelet.service.d/10-kubeadm.conf`

  * Add the following to the file

    `Environment="KUBELET_EXTRA_ARGS=--node-ip=IP-OF-WORKER-MACHINE`

    `systemctl daemon-reload`

    `systemctl restart kubelet`

  * Repeat the above on all the master and worker nodes

### Metrics server
  * apply metrics server  with `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`  and edit the deplyoment file under containers --> args --> add `- '--kubelete-insecure-tls'` and add under dnsPolicy: ClusterFirst --> add  `hostNetwork: true`

### Pod to service communication issue
  * https://www.jeffgeerling.com/blog/2019/debugging-networking-issues-multi-node-kubernetes-on-virtualbox