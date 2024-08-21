# VLAN Configuration Script
# ... on a Cisco switch.

# Create VLANs
vlan 10
 name HR_Department
vlan 20
 name IT_Department
vlan 30
 name Finance_Department

# lets assign VLANs to ports 
interface range GigabitEthernet0/1-10
 switchport mode access
 switchport access vlan 10

interface range GigabitEthernet0/11-20
 switchport mode access
 switchport access vlan 20

interface range GigabitEthernet0/21-30
 switchport mode access
 switchport access vlan 30

# we configure trunk ports
interface GigabitEthernet0/0
 switchport mode trunk
 switchport trunk allowed vlan 10,20,30

# Spanning tree protocol to prevent loops
spanning-tree vlan 10,20,30 root primary

# lET S NOT LOSE THE CONGIURATION 
write memory
