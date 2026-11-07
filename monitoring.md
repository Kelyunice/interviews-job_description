
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



          

    ===============================================================================================================================================================

           since it is difficult to go an query prometheus all the time, you need to go to grafana and add the data source 

           data source ==>>  add == >> prometheus ==>> url of prometheus ==>> save and test

           import dashboard ==>> 1860 ( 10180, 14731, 11074) ==>> load ==>> prometheus ==>> import

                -  apt update && apt install stress -y && stress -c 10










    
