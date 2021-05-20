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
    * the problem is VirtualBox creates a number of virtual network interfaces. Flannel and Calico, at least, both pick the first interface on a server, and use that to set up their own virtual networks. If they pick the default first VirtualBox network, they'll use a 10.0.2.x network that's used for the default NAT interface (enp0s3), and not the external bridge interface you configure (in my case, 192.168.7.x, or enp0s8 on Debian).

    * For Flannel, you need to edit the kube-flannel-ds-amd64 DaemonSet, adding the cli option `- --iface=enp0s8` under the kube-flannel container spec.
      * https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/#default-nic-when-using-flannel-as-the-pod-network-in-vagrant

    * For Calico, you need to edit the calico-node DaemonSet, adding the IP_AUTODETECTION_METHOD environment variable with the value `interface=enp0s8`.


TODO:
* edit the k3s config file and change the IP from 127.0.0.1 to 10.0.0.11