# Snort IDS/IPS Configuration Script

sudo snort -T -c /etc/snort/snort.conf -l /var/log/snort

# network variables
var HOME_NET [192.168.1.0/24]
var EXTERNAL_NET any

# Detection rules
alert tcp $EXTERNAL_NET any -> $HOME_NET 80 (msg:"Possible HTTP attack"; flow:to_server,established; content:"GET"; nocase; http_method; content:"/etc/passwd"; nocase; classtype:web-application-attack; sid:1000001; rev:1;)

# Start Snort in NIDS mode
sudo snort -c /etc/snort/snort.conf -i eth0
