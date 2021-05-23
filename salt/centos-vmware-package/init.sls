# Initially Installed via Kickstart Post Processor
open-vm-tools:
  pkg.installed:
    - version: 11.0.5

# Initially Installed via Kickstart Post Processor
perl:
  pkg:
    - installed

vmware-packages:
  cmd.script:
    - source: https://raw.githubusercontent.com/vmware/cloud-init-vmware-guestinfo/master/install.sh
    - unless: stat /usr/lib/python2.7/site-packages/cloudinit/sources/DataSourceVMwareGuestInfo.py

/lib/systemd/system/vmtoolsd.service:
  file.managed:
    - source: salt://centos-vmware-package/vmtoolsd.service
    - user: root
    - group: root
    - mode: 644
