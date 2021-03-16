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

# /etc/systemd/system/multi-user.target.wants/containerd.service:
#   file.symlink:
#     - target: /opt/containerd-1.4.4/containerd.service
#     - user: root
#     - group: root
#     - mode: 777

/etc/containerd:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

configure containerd:
  cmd.run:
    - name: containerd config default | sudo tee /etc/containerd/config.toml
    - runas: root

use the systemd cgroup driver:
  file.blockreplace:
    - name: /etc/containerd/config.toml
    - insert_after_match: /\[.*runc\.options\]/
    - content: '             SystemdCgroup = true'

containerd:
  service.running:
    - enable: True
