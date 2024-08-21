# Firewall Configuration Script, in order to enforce security policies in the NGFW 
#++++++++ allowing the traffic to splunk server 


# Variables
SPLUNK_SERVER_IP="192.168.1.100"  
HTTP_PORT=8000                    # Splunk Web Interface
MGMT_PORT=8089                    # Splunk Management Port
HEC_PORT=8088                     #HTTP Event Collector Port 


# Network zones 
set security zones zone trust interfaces ge-0/0/1
set security zones zone untrust interfaces ge-0/0/2
set security zones zone dmz interfaces ge-0/0/3

# Configure NAT
set security nat source rule-set trust-to-untrust from zone trust
set security nat source rule-set trust-to-untrust to zone untrust
set security nat source rule-set trust-to-untrust rule source-nat match source-address 192.168.1.0/24
set security nat source rule-set trust-to-untrust rule source-nat then source-nat interface

# Basic firewall rules
set security policies from-zone trust to-zone untrust policy allow-web traffic match source-address 192.168.1.0/24
set security policies from-zone trust to-zone untrust policy allow-web traffic match destination-address any
set security policies from-zone trust to-zone untrust policy allow-web traffic match application http
set security policies from-zone trust to-zone untrust policy allow-web traffic then permit

# Allow incoming traffic to Splunk Web Interface
set security policies from-zone untrust to-zone trust policy allow-splunk-web match source-address any
set security policies from-zone untrust to-zone trust policy allow-splunk-web match destination-address $SPLUNK_SERVER_IP
set security policies from-zone untrust to-zone trust policy allow-splunk-web match application tcp port $HTTP_PORT
set security policies from-zone untrust to-zone trust policy allow-splunk-web then permit

# Allow incoming traffic to Splunk Management Port
set security policies from-zone untrust to-zone trust policy allow-splunk-mgmt match source-address any
set security policies from-zone untrust to-zone trust policy allow-splunk-mgmt match destination-address $SPLUNK_SERVER_IP
set security policies from-zone untrust to-zone trust policy allow-splunk-mgmt match application tcp port $MGMT_PORT
set security policies from-zone untrust to-zone trust policy allow-splunk-mgmt then permit

# we could do the same to allow incoming traffic to Splunk HTTP Event Collector (HEC)

# Commit this configuration
commit and-quit

# Save the iptables rules (if using iptables as a secondary firewall)
sudo iptables-save > /etc/iptables/rules.v4

echo "NGFW and iptables firewall rules updated to allow traffic to Splunk server on IP: $SPLUNK_SERVER_IP"


#for the tests: 
#####show security policies
#####show security nat source rule-set
##### use nmap for open ports/// curl for HTTP/HTTPS  /// ping for basic connectivity testing /// use NGFW CLI to manage and view configs

