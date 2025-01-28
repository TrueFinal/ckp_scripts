#!/bin/bash

# Função para verificar se uma variável está vazia
check_empty() {
    while [ -z "$1" ]; do
        read -p "$2 cannot be empty. Please enter again: " var
        eval "$3=\"$var\""
    done
}

# *** DESCLAIMER ***
echo 'READ CAREFULLY! SCRIPT WIP(Work In Progress)'
echo 'Developed based on R81.20 GAIA, you must have admin previlegies to run this script!'
echo 'For more details and documentation on how to create a First Time Wizard Installation template, go to https://truefinal.github.io/'

# *** DEVICE INFORMATION CONFIGURATION ***
echo 'Configuring the device information...'

# Set Hostname
read -p 'Enter the Hostname: ' HOSTNAME
check_empty "$HOSTNAME" "Hostname" HOSTNAME
set hostname "$HOSTNAME"

# Set domain name
read -p 'Enter the Domain: ' DOMAIN
check_empty "$DOMAIN" "Domain" DOMAIN
set domain "$DOMAIN"

# Set device location
read -p 'Enter SNMP contact: ' SNMP_CONTACT
check_empty "$SNMP_CONTACT" "SNMP contact" SNMP_CONTACT
read -p 'Enter SNMP location: ' SNMP_LOCATION
check_empty "$SNMP_LOCATION" "SNMP location" SNMP_LOCATION
set snmp contact "$SNMP_CONTACT"
set snmp location "$SNMP_LOCATION"

# Set the organization name
read -p 'Enter the Organization Name: ' ORG_NAME
check_empty "$ORG_NAME" "Organization Name" ORG_NAME
set organization "$ORG_NAME"

# Set the description of the device
read -p 'Enter the device description: ' DESCRIPTION
check_empty "$DESCRIPTION" "Device description" DESCRIPTION
set description "$DESCRIPTION"

# *** NETWORK CONFIGURATION ***
echo 'Configuring the device network settings...'
echo 'By default configuring eth0...'

# Configure the Management Interface
read -p 'Enter Management Interface IP address: ' MGMT_IP
check_empty "$MGMT_IP" "Management Interface IP address" MGMT_IP
read -p 'Enter Management Interface Mask Length: ' MASK_LENGTH
check_empty "$MASK_LENGTH" "Mask Length" MASK_LENGTH
read -p 'Enter comments: ' COMMENTS
set interface eth0 ipv4-address "$MGMT_IP" mask-length "$MASK_LENGTH"
set interface eth0 state on
set interface eth0 comments "$COMMENTS"

# Configure Default Gateway
read -p 'Enter Default Gateway IP: ' GATEWAY_IP
check_empty "$GATEWAY_IP" "Default Gateway IP" GATEWAY_IP
set static-route default nexthop gateway address "$GATEWAY_IP" on

# Set DNS Servers
read -p 'Enter Primary DNS: ' DNS_PRIMARY
check_empty "$DNS_PRIMARY" "Primary DNS" DNS_PRIMARY
read -p 'Enter Secondary DNS: ' DNS_SECONDARY
check_empty "$DNS_SECONDARY" "Secondary DNS" DNS_SECONDARY
read -p 'Enter Tertiary DNS: ' DNS_TERTIARY
set dns primary "$DNS_PRIMARY"
set dns secondary "$DNS_SECONDARY"
set dns tertiary "$DNS_TERTIARY"

# Set NTP Servers
read -p 'Enter Primary NTP Server: ' NTP_PRIMARY
check_empty "$NTP_PRIMARY" "Primary NTP Server" NTP_PRIMARY
read -p 'Enter Secondary NTP Server: ' NTP_SECONDARY
check_empty "$NTP_SECONDARY" "Secondary NTP Server" NTP_SECONDARY
set ntp server primary "$NTP_PRIMARY" 3
set ntp server secondary "$NTP_SECONDARY" 3

# *** NEW ADMINISTRATOR SETUP ***
echo 'Adding a new administrator...'

read -p 'Enter new admin username: ' NEW_ADMIN_USER
check_empty "$NEW_ADMIN_USER" "Admin username" NEW_ADMIN_USER
read -s -p 'Enter new admin password: ' NEW_ADMIN_PASSWORD
check_empty "$NEW_ADMIN_PASSWORD" "Admin password" NEW_ADMIN_PASSWORD
echo
echo 'New Admin User Password Set!'
set user "$NEW_ADMIN_USER" password "$NEW_ADMIN_PASSWORD"
set user "$NEW_ADMIN_USER" roles "adminRole"

# Administration Configuration
echo 'Setting Administrator Password: '

read -s -p 'Enter new admin password: ' ADMIN_PASSWORD
check_empty "$ADMIN_PASSWORD" "Administrator password" ADMIN_PASSWORD
echo
echo 'New Administrator Password Set!'
set user admin password "$ADMIN_PASSWORD"

# Set Expert Mode password
echo 'Setting Expert Mode password...'

read -s -p 'Set expert mode password: ' EXPERT_PASSWORD
check_empty "$EXPERT_PASSWORD" "Expert Mode password" EXPERT_PASSWORD
echo
echo 'New Expert Mode Password Set!'
set expert-password "$EXPERT_PASSWORD"

# Enable WebUI and SSH Access
echo 'Enabling WebUI and SSH server...'

set web https enable
set ssh server enable

# Setting timezone
echo 'Setting timezone...'

read -p 'Enter Timezone (E.x, America/Sao_Paulo): ' TIMEZONE
check_empty "$TIMEZONE" "Timezone" TIMEZONE
set timezone "$TIMEZONE"

# *** DEPLOYMENT TYPE ***
echo 'Configuring deployment type...'
echo 'By default Deployment Type S-GW disabled, SMS enable set to primary'

# Disable Security Gateway functionality
set security-gateway disable

# Enable Security Management and set as Primary
set management enable
set management primary

# Set SIC (Secure Internal Communication) key
echo 'Configure SIC key...'
read -s -p 'Enter SIC key: ' SIC_KEY
check_empty "$SIC_KEY" "SIC key" SIC_KEY
echo
echo 'SIC Key Set!'
set sic "$SIC_KEY"

# *** SAVE CHANGES AND OPTIONAL REBOOT ***
read -p 'Do you want to save the configuration? (y/n): ' SAVE_CONFIG
if [[ "$SAVE_CONFIG" == "y" || "$SAVE_CONFIG" == "Y" ]]; then
    echo 'Saving configuration...'
    save config
fi

read -p 'Do you want to reboot the device now? (y/n): ' REBOOT
if [[ "$REBOOT" == "y" || "$REBOOT" == "Y" ]]; then
    echo 'Rebooting the device...'
    reboot
else
    echo 'Reboot skipped.'
fi

# *** VARIABLES EXCLUSION (Cleanup) ***
read -p 'Do you want to clean up sensitive variables? (y/n): ' CLEANUP
if [[ "$CLEANUP" == "y" || "$CLEANUP" == "Y" ]]; then
    unset NEW_ADMIN_PASSWORD ADMIN_PASSWORD EXPERT_PASSWORD SIC_KEY
    echo "Sensitive variables cleaned up."
else
    echo "Variables were not cleaned."
fi

echo "Script finished! Thanks for using, hope it was usefull :P !"