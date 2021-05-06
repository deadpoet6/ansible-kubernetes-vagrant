### Hi there <img src="https://raw.githubusercontent.com/MartinHeinz/MartinHeinz/master/wave.gif" width="30px">, I am Manoj Reddy!

# ansible-kubernetes-vagrant
Kubernetes cluster creation using vagrant and ansible. Creates 1 master and 2 worker nodes of
Kubernetes version = 1.20

### Tested on 
  * vagrant version = 2.2.7
  * virtual box = 6.x.x

* create the cluster using `vagrant up`

# Access the cluster from host machine
* ssh into master node and copy the `/etc/kubernetes/admin.conf` to the host machine under `~/.kube/config`

### Following steps are optional as they are integrated in the playbook now
#### Optional
  * To access the pods and logs of pods from the host machine configure the worker nodes as below

    `ssh vagrant@worker-1`

    `sudo nano /etc/systemd/system/kubelet.service.d/10-kubeadm.conf`

  * Add the following to the file

    `Environment="KUBELET_EXTRA_ARGS=--node-ip=IP-OF-WPRKER-MACHINE`

    `systemctl daemon-reload`

    `systemctl restart kubelet`

  * Repeat the above on all the nodes

### Metrics server
* apply metrics server  with `kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`  and edit the deplyoment file under contianers --> args --> add `- '--kubelete-insecure-tls'` and add under dnsPolicy: ClusterFirst --> add  `hostNetwork: true`