
                  MONITORING MEANS OBSERVING THE BEHAVIOUR OF A SYSTEM . IT CAN BE APP, INFRASTRUCTURE, or even SERVERS

                          MOST WIDELY USED TOOLS HERE ARE 
                                                       - PROMETHEUSE AND GRAFANA
        =======================================================================================================================

                                    PROMETHEUSE
        - TYPE: It is a free and OPEN SOURCE toll
        - MAJORITY: It is used to monitor cloud Native Applications(app build, run and managed on cloud only)
        - PURPOSE: It is used to monitor servers, app, infra
        - WHAT: we monitor the metrics ( i.e CPU, RAM, DISK..)
        - STORE DATA: Prometheuse stores the data is collects in the TSDB ( Time Series Data Base)
        - INTEGRATE: It can be intergrated to alert managers to get notifications such as (Email, Mobile, Slack< ..)
        - PORT: it's default port is 9090
        - TO SHOW THE OUTPUT:  WE use PROMQL ===>> Prometheus Query Language 
  =============================================================================================================================

         .                  What is SQL?
                    SQL stands for Structured Query Language.

              It is a language used to communicate with relational databases. You use it to:
                           - Store data.
                           - Retrieve data.
                           - Update existing data.
                           - Delete data.
                           - Create and manage database structures.
             Examples of relational databases include:
                           - PostgreSQL
                           - MySQL
                           - Microsoft SQL Server
                           - Oracle Database
            Imagine a banking application storing customer information in a database. SQL allows you to ask that database questions such as:
                           - Show me all customers.
                           - Find customers with account balances above £5,000.
                           - Update a customer's address.
                           - Find all transactions made today.
           2. SQL vs PromQL
           
                              Let's compare them.
                  
                      SQL	                                                       PromQL
             Structured Query Language	                                 Prometheus Query Language
             Queries relational database records	                      Queries time-series monitoring metrics
             Works with tables, rows and columns	                      Works with metrics and labels
             Used for application and business data	                    Used for monitoring and observability
             Example: Find customers	                                    Example: Find CPU usage



                     5. The five SQL commands I want you to know first
                      
                                  Command	                             Purpose
                                  SELECT	                         Retrieve data
                                  INSERT	                         Add new data
                                  UPDATE	                         Modify existing data
                                  DELETE	                         Delete data
                                  CREATE	                         Create database objects

    ===============================================================================================================================================================

                                                GRAFANA

           - TYPE: It is a free and open source tool
           - PURPOSE: it is used to create Monitoring dashboards for servers
           - PORT: 3000
           - INTERGRATE: It can be intergraded to Alert managers like Email, Mobile and Slack
           - CRED : Username: admin and Password: admin

    =======================================================================================================================================================

                                              NODE-EXPORTER

          - To monitor any server/vm you need to install a node-exporter inside the vm

          - Tool: Node Exporter
          - TYPE: It's a data source
          - PURPOSE:  It is used to send metrics from a worker Node to prometheus
          - PORT: 9100

          for the node exporter to be able to send the data collected to the TSDB in prometheus, you need to configure it 
                                                             vi /etc/prometheus/prometheus.yml
                                                             under targets ( add the IP address of the vm where you installed the node exporter)
          
          In real life we use service discovery to add targets to prometheuse because as we scale and more vm are prodcued it dificult to manually add ip to prometheus

                           ====================================================================================================

                                  SERVICE DISCOVERY (SD)

                manually we can do: 
                           file based
                           http


                automated method of monitoring we
                            service discovery
     
          - For EC2 based 
                   1- create a Role: 
                             ==>> go to IAM on aws ==>> scroll down to IAM resources and select Roles ==>> create a role ==>> chose who ur adding the role for (EC2)
                                                      ==> go to add permissions ===>> use existing policy
                                                     ==>> Permission policy select ==>> AmazonEC2ReadOnlyAccess ==>> give any name
                            ==>> attach the role to the vm you are monitoring: go to actions ==>> security ==>> modify the IAM role ==>. chose the role you created
                   2- Install Node exporter
                   3- vim /etc/prometheus/prometheus.yml

                               scrape_configs:
                                 - job_name: 'ec2-discovery' 
                                 #for k8s we use port-discovery, for Azure we use azure-service-discovery

                                   ec2_sd_configs:
                                     - region: us-east-1
                                       port: 9100

                                   relabel_configs:
                                     - source_labels: [__meta_ec2_private_ip]
                                       target_label: instance

                  4- systemctl daemon-reload
                     systemctl restart prometheus.service



          

    ===============================================================================================================================================================

           since it is difficult to go an query prometheus all the time, you need to go to grafana and add the data source 

           data source ==>>  add == >> prometheus ==>> url of prometheus ==>> save and test

           import dashboard ==>> 1860 ( 10180, 14731, 11074) ==>> load ==>> prometheus ==>> import

                -  apt update && apt install stress -y && stress -c 10

==========================================================================================================================================
                                  MONITORING TEST 

    1- Create VPC
                                VPC configuration
                                
                             Setting	                                 Value
                           Name tag	devops-monitoring-vpc
                          IPv4 CIDR	10.20.0.0/16
                          IPv6 CIDR	No IPv6 CIDR block
                          Tenancy	Default
                           Number of Availability Zones	2
                           Number of public subnets	2
                           Number of private subnets	0
                           NAT gateways	None
                             VPC endpoints	None


                                      Customize subnet CIDR blocks, if the wizard allows:
                                              - Public subnet 1: 10.20.1.0/24
                                              - Public subnet 2: 10.20.2.0/24
  
                                                 Additional settings
                                               - Enable DNS resolution.
                                               - Enable DNS hostnames.

                  1- Next inspect 
                         - VPC.
                         - Subnets.
                         - Internet Gateway.
                         - Route tables.
                         - Security Groups.


                             VPC: Our own isolated virtual network in AWS
                             Subnet: A smaller network inside our VPC.
                             Availability Zone: A separate physical location within the AWS region.
                             Internet Gateway: Provides a path between our VPC and the internet.
                             Route table: Determines where network traffic goes


2- Step 2: Create our EC2 key pair

        
3- Step 3: Prepare your SSH key in Ubuntu WSL
                  if you don't have a key pair already created and dowload

                   - mkdir -p ~/.ssh
                   - cp /mnt/c/Users/YOUR_WINDOWS_USERNAME/Downloads/devops-monitoring-key.pem ~/.ssh/
                   - chmod 400 ~/.ssh/devops-monitoring-key.pem
4- step 4: create sg
      1- monitoring server
                  - inbound role 1  SSH with source My Ip
                  - Inbound role 2  grafana port 3000 and source My IP
                  - inn bound role 3- Prometheus 9090 with source My IP


                  - Outbound role A:: traffic
                  
       2- Application server
                   - inbound roles 1 SSH port 22 source My IP
                                     HTTP port 80 source anywhere IPv4 (0.0.0.0/0)
                                     custom TCP port 8080 source monitoring server
                                     custom TCP port 9100 source monitoring server
                   - outbound rules all traffic

 5- Launch The EC2 intsnaces
          1- launch the monitoring EC2 instance
                 Instance type: t3.medium
                 Security group: monitoring-server2
                 Key pair: self-hosting
                 Public subnet: 10.20.1.0/24
          2- Launch the application EC2 instance
                  Instance type: t3.small
                  Security group: application-server
                  Key pair: dev-new-key
                 Public subnet: 10.20.2.0/24

 6- connect the monitoring vm 
          1- install docker with a script
              check docker --version
              check docker compose version
              check docker ps
          2- create a project directory: mkdir -p /opt/monitoring/{prometheus,grafana,alertmanager,blackbox}
                                         cd /opt/monitoring

          3- create the prometheus configuration file 
                                        vim prometheus/prometheus.yml

          4- create the Docker compose file 
                                - vi compose.yaml
                                - validate the file( docker compose config)
                                - pull the images ( docker compose pull)
                                - docker images
                                - docker compose up -d
                                - docker ps
          5- login to grafana on browser using public Ip and add dashboard. 
                                 - you can add all visualization and select stat on the left hand side
  7- connect to the application vm
           1- install node exporter
           2- install docker 
           3- install cadvisor
           4- verify cAdvisor 
                   docker ps
                   curl -s http://localhost:8080/metrics | head
                   systemctl is-active node_exporter
                   docker exec prometheus promtool check config /etc/prometheus/prometheus.yml




    
