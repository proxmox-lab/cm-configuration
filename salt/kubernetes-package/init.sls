kubernetes-repo:
  pkgrepo.managed:
    - name: kubernetes
    - humanname: Kubernetes
    - baseurl: https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
    - enabled: True
    - gpgcheck: 1
    - gpgkey: https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
    - kwargs:
      repo_gpgcheck: 1
      exclude:  kubelet,kubeadm,kubectls

/etc/modules-load.d/containerd.conf:
  file.managed:
    - source: salt://kubernetes-package/files/etc/modules-load.d/containerd.conf
    - user: root
    - group: root
    - mode: 644

containerd_prerequisites:
  kmod.present:
    - persist: True
    - mods:
      - overlay
      - br_netfilter

/etc/sysctl.d/99-kubernetes-cri.conf:
  file.managed:
    - source: salt://kubernetes-package/files/etc/sysctl.d/99-kubernetes-cri.conf
    - user: root
    - group: root
    - mode: 644

apply sysctl params without reboot:
  cmd.run:
    - name: sysctl --system
    - runas: root

containerd_install:
  archive.extracted:
    - name: /
    - enforce_toplevel: False
    - source: https://github.com/containerd/containerd/releases/download/v1.4.4/cri-containerd-cni-1.4.4-linux-amd64.tar.gz
    - source_hash: 96641849cb78a0a119223a427dfdc1ade88412ef791a14193212c8c8e29d447b
    - user: root
    - group: root
    - mode: 755

/etc/containerd:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/containerd/config.toml:
  file.managed:
    - source: salt://kubernetes-package/files/etc/containerd/config.toml
    - user: root
    - group: root
    - mode: 644

containerd:
  service.running:
    - enable: True

disable selinux:
  cmd.run:
    - name: setenforce 0
    - runas: root

permissive:
  selinux.mode

kubernetes.packages:
  pkg.installed:
    - pkgs:
      - kubelet
      - kubeadm
      - kubectl
    - kwargs: {
      disableexcludes: kubernetes
    }

kubelet:
  service.running:
    - enable: True
