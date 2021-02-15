docker-repo:
  pkgrepo.managed:
    - humanname: Official Docker Repository
    - baseurl: https://download.docker.com/linux/centos/7/x86_64/stable/
    - gpgkey: https://download.docker.com/linux/centos/gpg

device-mapper-persistent-data:
  pkg:
    - installed

lvm2:
  pkg:
    - installed

nfs-utils:
  pkg:
    - installed

docker-ce:
  pkg:
    - installed

add-user-to-group:
  cmd.run:
    - name: usermod -a -G docker packer
    - runas: root

/usr/lib/systemd/system/docker.service:
  file.managed:
    - source: salt://docker-package/docker.service
    - user: root
    - group: root
    - mode: 644

docker:
  service.running:
    - enable: true
    - watch:
      - pkg: docker-ce
