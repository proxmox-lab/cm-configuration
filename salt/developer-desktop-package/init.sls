Background Intelligent Transfer Service:
  module.run:
    - service.modify:
      - name: BITS
      - start_type: auto

windows_updates:
  wua.installed:
    - updates:
      - KB4579311
      - KB4580419
      - KB4580325
      - KB4580364
      - KB890830

xming:
  pkg.installed:
    - version: 6.9.0.31

vscode:
  pkg.installed:
    - version: 1.50.1

install_linux_subsystem:
  dism.feature_installed:
    - name: Microsoft-Windows-Subsystem-Linux
    - restart: false

install_hyperv:
  dism.feature_installed:
    - name: VirtualMachinePlatform
    - restart: true
    - require:
      - install_linux_subsystem

wsl2-update:
  pkg.installed:
    - version: latest
    - require:
      - install_hyperv

wsl2-set-default:
  cmd.run:
    - name: wsl --set-default-version 2 | echo %ERRORLEVEL% > c:\salt\error.txt
    - runas: root
    - require:
      - wsl2-update
