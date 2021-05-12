base:
  'roles:docker':
    - match: grain
    - docker-package
  'roles:kubernetes':
    - match: grain
    - kubernetes-package
development:
  'roles:docker':
    - match: grain
    - docker-package
  'roles:kubernetes':
    - match: grain
    - kubernetes-package
  'roles:developer-desktop':
    - match: grain
    - developer-desktop-package
