base:
  'os:CentOS':
    - match: grain
    - centos-core-package
  'G@os:CentOS and G@location:aws':
    - match: compound
    - centos-aws-package
  'G@os:CentOS and G@location:onprem':
    - match: compound
    - centos-vmware-package
  'roles:docker':
    - match: grain
    - docker-package
  'roles:kubernetes':
    - match: grain
    - kubernetes-package
development:
  'os:CentOS':
    - match: grain
    - centos-core-package
  'G@os:CentOS and G@location:aws':
    - match: compound
    - centos-aws-package
  'G@os:CentOS and G@location:onprem':
    - match: compound
    - centos-vmware-package
  'roles:docker':
    - match: grain
    - docker-package
  'roles:kubernetes':
    - match: grain
    - kubernetes-package
  'roles:developer-desktop':
    - match: grain
    - developer-desktop-package
