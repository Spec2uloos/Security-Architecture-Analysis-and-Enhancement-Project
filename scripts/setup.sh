# SIEM Setup Script (splunk environment for eg)


# Installing Splunk (Ubuntu)
wget -O splunk-8.2.2-linux-2.6-amd64.deb 'https://www.splunk.com/page/download_track?file=8.2.2/linux/splunk-8.2.2-linux-2.6-amd64.deb'
dpkg -i splunk-8.2.2-linux-2.6-amd64.deb


/opt/splunk/bin/splunk start --accept-license

# admin passwrd
/opt/splunk/bin/splunk edit user admin -password newpassword -auth admin:Mouna

# Boot-start
/opt/splunk/bin/splunk enable boot-start

# Configure data inputs
/opt/splunk/bin/splunk add monitor /var/log/syslog -index main -sourcetype syslog

#the firewall should be configured to allow traffic to Splunk server ((see firewall_setup.sh))
