# Initially Installed via Kickstart Post Processor
open-vm-tools:
  pkg.installed:
    - version: 11.0.5

# Initially Installed via Kickstart Post Processor
perl:
  pkg.installed:
    - version: 5.16.3

vmware-packages:
  cmd.script:
    - source: https://raw.githubusercontent.com/vmware/cloud-init-vmware-guestinfo/master/install.sh
    - unless: stat /usr/lib/python2.7/site-packages/cloudinit/sources/DataSourceVMwareGuestInfo.py
