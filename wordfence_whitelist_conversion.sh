#!/bin/bash


# Created by 2019-04-07
# Script name: wordfence_whitelist_ddns.sh
# Original Author: Andrew Fore, andy.fore@arfore.com
# Purpose: Updates the whitelist field of the WordFence WordPress plugin with the
#          IP address of the FQDN passed in either via commandline interactive mode
#          or via hardcoded configuration value.  Mainly intended for use with DDNS.

# Variable definitions
#
# wp_mysql_user - WordPress database username
# wp_database - WordPress database name
# wp_tableprefix - WordPress database table prefix
# fqdn_list - FQDN list of the domains to add to the WAF whitelist
# wp_mysql_pwd - MySQL password for the WordPress user
# ip_addr - space delimited converted list of domain names
# ip_addr_adj - comma delimited converted list of domain names
# MYSQL_PWD - shell variable to hold the MySQL password for the duration of the script run

interactive=false

if [ "$interactive" = true ]; then
{
    # read in the WordPress database username
    read -p "Enter the MySQL database username for the WordPress database user: " wp_mysql_user
    # read in the WordPress database name
    read -p "Enter the MySQL database name for the WordPress database: " wp_database
    # read in the WordPress database table prefix
    read -p "Enter the MySQL database table prefix for the WordPress database: " wp_tableprefix
    # read in the FQDN list of the domains to add to the WAF whitelist
    read -p "Enter the list of FQDNs: " fqdn_list
    read -a arr <<< $fqdn_list
    echo ${arr[@]}

    # read in the MySQL password for the WordPress user from the commandline
    read -s -p "Enter the WordPress DB Password: " wp_mysql_pwd
}
else
{

    # WordPress configuration variables
    wp_mysql_user="wparforecomuser"
    wp_database="wp_arforecom"
    wp_tableprefix="wp_"

    # DDNS configuration variable
    fqdn="homelab.onthewifi.com external.arfore.com"
    read -a arr <<< $fqdn
    echo ${arr[@]}

    # MySQL password for the WordPress user
    wp_mysql_pwd="sea8e!ght6th@t"
}
fi

# pull the IP address using the dig command
# convert list from space delimited to comma delimited
ip_addr=`dig +short $fqdn`
ip_addr_adj=`echo $ip_addr | sed 's/ /,/g'`

# export the MySQL user password for temporary usage
# usage with the MySQL update statement
MYSQL_PWD=$wp_mysql_pwd
export MYSQL_PWD

mysql -u ${wp_mysql_user} << EOF
  update ${wp_database}.${wp_tableprefix}wfconfig set val="${ip_addr_adj}" where name="whitelisted";
EOF

unset MYSQL_PWD