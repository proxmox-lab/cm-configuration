# Initially Installed via Kickstart Post Processor
/etc/pki/tls/certs/ca-bundle.crt:
  file.managed:
    - source: https://curl.se/ca/cacert.pem
    - source_hash: https://curl.se/ca/cacert.pem.sha256

# Initially Installed via Kickstart Post Processor
python:
  pkg.installed:
    - version: 2.7.5

# Initially Installed via Kickstart Post Processor
python-pygit2:
  pkg.installed:
    - version: 0.26.4

/usr/local/sbin/get-pip.py:
  file.managed:
    - source: https://bootstrap.pypa.io/get-pip.py
    - skip_verify: True

getpip:
  cmd.run:
    - name: /usr/bin/python /usr/local/sbin/get-pip.py
    - unless: which pip
    - require:
      - pkg: python
      - file: /usr/local/sbin/get-pip.py
    - reload_modules: True

cloud-init:
  pkg.installed:
    - version: 19.4

jq:
  pkg.installed:
    - version: 1.6
