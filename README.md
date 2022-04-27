# Visitor counter
## Description
Application counts the number of unique visitors on Main page.
Each unique IP address is counted as unique visitor. Also application counts the total number of visits for each IP address.
Main page shows the total number of visits for current IP address.
Site Visits Report page shows the overall statistics: list of unique visitors & total visits for each unique visitor.
Note: visiting Site Visits Report page is NOT counted as site visit.

- WEB Server - Apache 
- Language - PHP
- Database Redis
## Installation
- Copy repository
- Start up ./start.sh script
## Tested on
Amazon EC2 instances:
- Amazon Linux 2
- Ubuntu, 20.04
- Red Hat 8
- SUSE Linux 15
- Debian 10
## Jenkins
Jenkins pull code from github and deliver it to 1 node.

- [WEB](http://jenkins.romalap.com/)
- JOB visitor-counter
- [Node with counter](http://141.147.49.184/)