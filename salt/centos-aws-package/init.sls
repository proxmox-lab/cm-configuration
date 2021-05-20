amazon-packages:
  pkg.installed:
    - sources:
      - amazon-cloudwatch-agent: https://s3.amazonaws.com/amazoncloudwatch-agent/centos/amd64/latest/amazon-cloudwatch-agent.rpm
      - amazon-ssm-agent: https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

amazon-cli-extraction:
  archive.extracted:
    - name: /tmp
    - source: https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
    - skip_verify: True

amazon-cli-install:
  cmd.run:
    - name: /tmp/aws/install --update
    - unless: aws --version | grep 2.0.42

/usr/bin/aws:
  file.symlink:
    - target: /usr/local/bin/aws
    - user: root
    - group: root
    - mode: 555
