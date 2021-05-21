vmware-packages:
  cmd.run:
    - name: install.sh
    - source: https://raw.githubusercontent.com/vmware/cloud-init-vmware-guestinfo/master/install.sh
    - unless: stat /usr/lib/python2.7/site-packages/cloudinit/sources/DataSourceVMwareGuestInfo.py
