### Hi there <img src="https://raw.githubusercontent.com/MartinHeinz/MartinHeinz/master/wave.gif" width="30px">, I am Manoj Reddy!

# ansible-kubernetes-vagrant
Kubernetes cluster creation using vagrant and ansbile. Create 1 master and 2 worker nodes
Kubernetes version = 1.20

# Access the cluster from host machine
* ssh into master node and copy the `/etc/kubernetes/admin.conf` to the host machine under `~/.kube/config`

### Following steps are optional as they are integrated in the playbook now
* To access the pods and logs of pods from the host machine configure the worker nodes as below

`ssh vagrant@worker-1`
`sudo nano /etc/systemd/system/kubelet.service.d/10-kubeadm.conf`

* Add the following to the file
`Environment="KUBELET_EXTRA_ARGS=--node-ip=IP-OF-WPRKER-MACHINE`
`systemctl daemon-reload`
`systemctl restart kubelet`

* Repeat the above on all the nodes
