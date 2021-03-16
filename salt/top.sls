base:
  'roles:docker':
    - match: grain
    - docker-package
  'roles:kubernetes':
    - match: grain
    - kubernetes-package
