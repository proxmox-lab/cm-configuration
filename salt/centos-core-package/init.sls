/etc/pki/tls/certs/ca-bundle.crt
  file.managed:
    - source: https://curl.se/ca/cacert.pem

python:
  pkg.installed:
    - version: 2.7.5

python-pygit2:
  pkg.installed:
    - version: 0.26.4

cloud-init:
  pkg.installed:
    - version: 19.4

jq:
  pkg.installed:
    - version: 1.6
