
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

  


















    
