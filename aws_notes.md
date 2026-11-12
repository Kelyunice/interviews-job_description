
   - after creating your instance, add the name of the instance and chose the size of your machine
   - Port 22 is the default port for ssh connection
   - Create the new key pair, and select the key pair type (RSA) with a .pem extension. if you chose .ppk then you need a puTTy terminal

===============================================================================================================================================

                                     How to connect 2 machines
     - create a key
    - To copy a file which has root access as a regular user==> sudo cp =r (path to file) .
    - copy the public key from your download on your machine and paste in the .ssh directory on the local machine. (sudo ls -l .ssh)
      or   copy the public key on local (sudo cat .ssh/id_rsa.pub) machine, and put it in the .ssh directory on the aws server (vi .ssh/authorized_key)
    -  sudo ssh -i ~/.ssh/id_rsa ubuntu@pub Ip ( name of server @ ip of aws server) or if the key is in the default location ( sudo ssh ubuntu@pub IP)
    - To copy a file from another into another server
             sudo scp -i ~/.ssh/id_rsa filename ubuntu@IP:/path to the directory
============================================================================================================================================
                                How to use environment variables
    - When you copy a file or script from a server to another , you cannot run it because you are not in the path of the file or script
    - All commands we run have their env stored in the .bashrc dir
    - To be able to run a copied file without using the path to the file you need to set the env in the .bashrc directory as well
    - vi .bashrc and at the extreme bottom ==> add a line after fi (PATH=$PATH: plus the path to that file/filename)
    - on your terminal set the information by typing the command ===>> source ~/.bashrc
            cat /etc/environment
    - sometimes when developers are working on a java script they might request you add java to the PATh so that they can run the script anywhere
    - To see all env var available ===>> printenv
    - Env var can be set at different levels
                   - terminal level which will not be persisted
                   -  individual level which will persisted for that individual (.bashrc file) once done reinitialize it
                   - Global level so that every use locked into the system can use it (/etc/environment

================================================================================================================================================

                          AWS NOTES FROM NEW DEVOPS CLASS

                        CLOUD AUDITING

                          
   1-  If you realize someone accidentally deleted the s3 of your org with over 100 people how do you check?
                CloudTrail==>> Event History==> event name or even source
   2- which AWS resource Audits logs?
                CloudTrial: It records every API call , user action, console login, CLI command, SDK request, and service activity happening inside your aws account
   3- When ever you create a resource or click on create any resource what actually happends on the backend?
               USER REQUEST ==>>  API CALL (REST) ==>> Cloud control plane (Brain of the cloud)  ==>> Resource is created
   4- How can we log in to AWS?
               By using ; IAM USER, IAM ROLE or FEDERATED USER  which will be used check the authentication if you have the permission to login
                                                                then it will check the authorization; permission to create the resources
   5- what actually creates the resource in AWs after the controle plane has verified when, where and how to create the resources?
            Data Plane is the one that actually creates the resource
   6- Connectivity.
            ones you create any server s3 or EKS cluster, without connectivity no resource can be able to communicate to the users?
   7- MONITORING AND AUDITING===VISIBILTY
           Monitoring: it questions is it healthy by using tools such as ( cloudWatch, grafana, Prometheus, Datadog) to check metrics such as (CPU, Memory,                       Disk, Network, Errors, Latency)
           AUDITING: Questions who changes something by using tools such as ( cloudTrial, AWS config, Security Hub) to check metrics such as (who, what, when,                          from where)
   8- Data captured by CloudTrail on AWS can be stored either in s3 or CloudWatch logs        
   9- CloudTrial events and Pricing
           Management Events are free. Events such as e. creating, stop , start deleting resources ( Control AWS resourcs, ENable by default, cheap, create EC@,
                                       Create IAM USer)
           Data Reource are not free. Events such as upload, download , copying data ( ACCESS resource data, Disabled, Expensive, Read file in s3, GetObject)

  10- To track the records of a particular resource e.g ECS you need to record the trial although by default AWS records everything.
          TO create the Trial: CLoudTrial==>> Trials ==>> Add Trail Name ==>. Storage Location ==> Disable Log file SSE-KMS encryption ==>. Enable additional                                     setting
                               click on next ==> chose and management events or add data events ==>> select all the resource type (EC2 , S3) ==>> next
                              under aggregation templates==>> select ALL ==>> Next and create the trial
 11- In AWS by default every resource is being monitored, but if you want to monitor your resource you are going  to create a dashboard. 
      99% of the time we use PROMETHEUSE for monitoring but it can also be done using AWS cloudWatch
      To create a dashboard
          cloudwatch ==>> dashboards ==>> create dashboards ==.. add the name you want ==>> chose what you want to monitor ( metrics, logs, Alarms)==>> then                                widget type
                        metrics are in line widget form ==>> next ==>> which resource ==>> copy the server private Ip and paste under Per-instance Metrics ==>>
                         chose what you want to monitor e.g CPU Utilization by checking options==>> create ==>> save dashboard

                         sudo -i
                         apt install stress -y
                         stress -c 10
                         
 12- In AWS with the help of which components are you going to monitor you use Prometheus.
        Prometheuse pulls the metrics from the server (VM)
        Grafana uses the metrics to create the dashboard so that we can visualize the metrics

13- To monitor the metrics on grafana , you need to connect it and enter the Id of Prometheus by doing (vi /etc/Prometheus/prometheuse.yml) under targets 
          add the pub Ip of server and port its listening to
                           then do a systemctl restart prometheus service

=================================================================================================================================================================      
                              Content Delivery Network (CDN) = GLOBAL CONTENT ACCELERATOR its most asked in interviews

 1- Generally when we launch vm and create load balancers for them
 2- If you want to create a copy of a server without going through the normal procedure, select the vm that you already created ==>> actions drop down select           Image and templates ==> launch more like this. 
    You need to change the name and the availability zone, for high availability. Proceed now to create the load balancer 
    select load balancers ==>> create load balancer ==>> select Application load balancer  then create ==>> add the name ==>> select scheme (internet facing 
     bc it follows 
                              Http protocols and all web servers use internet) ==>> create the availability zone and subnets ==>> launch the security groups. 
                              Proceed to create target group( add the name) ==>> select the instances you want to create the LB for
 3- We have a web server hosted in USA but people access the app in India at same speed. How does this happen. This is made possible through the use of 
              EDGE LOCATION which are dommy servers .
 4- If an app uses CDN its benefits are( faster reach by user, lower latency, better user experience) wheras an app that doesn't use CDN faces challenges such as         (high latency, slow video loading, Buffering, Expensive bandwidth)
    
    WHY CDN EXIST
         - Performance: to reduce latency
         - Scalability: Handle millions of users
         - Cost reduction: reduce origin server traffic
         - Security: Protect against attacks
         - High availability: serve content even during origin issues
5- CORE CDN COMPONENTS
         - ORIGIN SERVER
               Examples: EC2, S3, load Balancer, Web server, Kubernetes cluster
         - EDGE LOCATIONS
               Examples: mumbai, Hyderabad, London, New York, Tokyo, Sydney
         - CACHE
              Examples temporary storage: Images, Videos, CSS, JS, API Responses

       when you make a request for the first time, your request goes to the edge location and since it doesn't have data it will go and fetch from origin server.        The next time you make a request it goes to edge location and since edge location now has data it no longer has to ask from origin, it will respond with          the data (Cache) it first collected.

               HOW TO IMPLEMENT THE CDN

6-  CDN are attached to only few resources e.g s3, ALB, EC2, API GATEWAY, MEDIA SERVER
    
     A- create the LB
         check if the LB is active, copy the DNS name

           504 gateway time-out means application is running but not loading due to port number issue
               ( SG issues,
           404 error means  application is loading but not running ( incorrect API endpoint ,incorrect file path, page not found, wrong url, routing problem)
              
           401 unauthorized meaning your credentials are not allowed or has expired or missing token
               check username and password spelling, check if API token is present or has expired, does the user have the required authentication method
           400 bad request
           500 internal server error
           502 bad gateway. gateway or proxy cannot communicate properly
               is backend app working (ps aux | grep node), is backend listening to correct port (sudo ss -tulpn), can the proxy reach the backend, 
               is the DNS name correct, are firewalls rules blocking, are there app crashes or timeouts
           503 service unavailable( temporarily unavailable service ( may be down, undergoing maintenance, or have no healthy backend instance)
               
                           What to check:
                1. Are all application instances running? kubectl get pods
                2. Are the servers overloaded? kubectl get services
                3. Are Kubernetes pods healthy? 
                4. Does the Kubernetes Service have healthy endpoints? kubectl get endpoints
                5. Is the application undergoing maintenance? kubectl logs POD_NAME
                6. Are resource limits such as CPU and memory causing problems? ps aux



    
          to check this go to your terminal and do
                   sudo -i
                   systemctl status (apache2.service)
                   if all good check security groups on AWS and change them
     B- create the CLOUDFRONT
        cloudfront ==>> create distribution ==>> choose plan based on how fast you want the app to be available to user ===>> add distribution name ==>>under              domain, if you have your own domain name you can use it ==>> click next ==>> under origin type chose Elastic Load balancer( based on how your traffic 
         is routed) ==>> browse load balancer and chose the name of the hosting zone where you created the LB, then select the name of the app ==> under 
         settings select customize origin settings. For security you can enable origin mutual TLS for high security, proceed to create the CDN. 
        
        Once you have a time stamp then it has fully loaded, you copy the distribution domain name

        to test it, go to a new browser start with the LB DNS and paste on your browser to see if the app will be accessible
                                              take the CDN and paste on another browser and test which is faster

   9-  Interview question
       How can you limit users from hitting your servers multiple times?
        By using rate limiting in cloufront as you create your distribution

  10- How to block the app for certain region
       Go to security still while inside the cloudFront, scroll down to==>> CloudFront geographic restrictions ==>> countries select Block list ==>>
  11- what is CDN?
        It is a globally distributed network that caches content closer to users
  12- what is cache HIT?
        Content serves from EDGE CACHE
  13- What is cache MISS?
        Content fetched from origin
  14- What is TTL?
        Duration content remains in cache
  15- What is CloudFront?
        It is the service used in Aws to implement CDN service.
  16- What is Origin?
       source location of content

   ==============================================================================================================================================================

                                                TTL ( TIME TO LIVE) 

      1- when you create an edge location served by a CDN or geolocation, when user send their request the first time is might take 4 sec to get a response and the next              time 3 sec or less since the data is stored in cache> you need to set the TTL after which if another request comes in it will go back to the origin server

      2- TTL describes how much you are going to store the temporary content (cache) . It be 24 hours or up to 1 week

      3- There are 2 types of content (cache)
           - STATIC CONTENT
                 It rarely changes. example include; images, videos, CSS,JavaScript, Fonts, PDF. 
                 Static content is good for CDN. TTL here can be 7 hours
           - DYNAMIC CONTENT
                 It changes frequently. Examples include Bank Balance, Shopping Cart, Stock prices, Live Scores.
                 More difficult to cache. Cache here can be put lower

   =================================================================================================================================================================
                  MULTI-CDN STRATEGY
                  
      - In real life you can check the number servers on a particular cloud for a particular app e.g netflix servers on aws regions
      - This is the ability to use multiple CDNs for max Reliability and Performance. It is used by companies such as ( Netflix, META, GOOGLE, AMAZON
      - The architecture is such that the user request is sent to (DN1, CDN 2, CDN3) and the all fetch their data from 1 CDN which is the origin server
      - The benefits: It helps with better availability , Better performance, Failover capability

==============================================================================================================================================================

                                   SNAPSHOTS- EBS VOLUMES   to check your EBS volume (lsblk)


                                   VARIOUS WAYS TO TAKE SNAPSHOTS
                                   - SCRIPTS
                                   - LAMBDA FUNCTIONS
                                   - MANUAL
                                   - LIFCYCLE MANAGER

     -  It is a storage used for EC2 instances. It is a kind of storage used from the server only
     -  You attach it to the instance or server with the help of a VN (virtual Network)
     -  It is a persistent volume so even if you stop the server, the data will still be available

                CHARCTERISTICS OF EBS 
    - PERSISTENT STORAGE
          It means data survives even if you reboot the server, you stop and start your server, or you migrate the server( instance replacement) data will not be           removed So it is persistent
    - BLOCK STORAGE
         It provides raw disk blocks. examples NTFS, EXT4 (it supports EXT by default), XFS .
         You can format it just like a physical hard disk

                                 There are 2 types of Volumes
   - ROOT VOLUME
       It contains Operating systems and Boot files. It can also be called Boot volume. Examples include; Ubuntu, AMAZON, Windows. Without ROOT VOLUME EC2
       cannot boot
   - DATA VOLUME or non root volume
       It stores database files, logs, application data. It can be attached or detached ANYTIME

        ( ROOT VOLUME = BOOT THE SERVER, DATA VOLUME = STORE YOUR DATA)

                                  There 2 kinds of EBS VOLUMES TYPES
     
    1- SSD
       - Genral Purpose
         GP3 and GP2 (Legacy)
         Here we store data that is not very important but we just want to store it for reusability. Here you store the data with no details
         When creating webserver and Applications servers,containers, Dev/Test, medium databses we use genral purpose
         Features: it is independent IOPS, it is throughout, it has lower cost. 
         GP2 is an older version of GP3. 
       - Provisioned 
       Here we store important data. It is also known as IOPS. Once you store data and provision IOPS , your data will be very fast(speed to open)
       when creating volumes for database you need to provision it reason why we us IOPS
          - IO2: used for high performance SSD
                it used for oracle, SQL server, SAP HANA, MYSQL Production PostgrSQL
                It provides extremly high IOPS
                High durabiltiy
          - IO2 Block Express: Highest performance EBS offering
               used for Netflix scale systems
               enterprise database
               SAP 
               supports millions of IOPS, multi TB database
    2- HDD
       - ST1 : It is throughput Optimized HDD
               It used for data lakes, hadpop, and log processing
       - SC1 : Its also called Cold HDD
               It is used for archive storage, rarely accessed data. 
               It is lowest in cost


                                      EBS PERFORMANCE FUNDAMENTALS

         1- Storage Size
                  here we look at capacity( GB and TB) max storage is 64TB of data
         2- IOPS -Input Output Per Second
                you can check it under an instance , under configuration storage==>> IOPS
         3- Throughput
                Amount of data transferred e.g ( 500 MB/s)
         4- Latency
              Time required to complete an operation. 
            The goal is low latency especially for databases

               ==============================================================================================================

              An app is running in (asia-singapore) hosted region and we want to migrate it to USA for example. How to proceed

    1- we need to take a snapshot of the server
       when ever you create an instance it stores your data on EBS volume and snapshot takes a copy of it also and send to s3 backend. If your EBS volume is             deleted you can always have a copy of it by using the snapshot or using the restoration.
       Benefits: it is a backup , it helps in disaster recovery, Migration (moving the Vm from one region to another) and Cloning

   2- How do you take the snaptshot?
      - go to your server, scroll down to storage ,==>> click on the volume ==>  actions at the top ==>. create snapshot ==>> add snapshot details
      - Always stop the server before taking the snapshot. Snapshots can also be created using python scripts and also from the CLI using linux commands
      - Go back to the snapshot ==>> select actions and copy the snapshot ==>> add destination Region ==>>
   3- You cannot create a vm from a snapshot or attach a server to a snapshot. It is meant only for backup
      - From a snapshot you can create a volume by clicking on the snapshot, then actions,==>. create volume
      - After creating the volume , you can attache it to a server by launching a new instance, add the name you want , then under storage volume select advance           options ==>> select default
      - NOTE: if you create a volume in an availability zone, your new VM must be in that same zone else you cannot attach them. 
        Stop the running Vm  and remove the root volume by going to actions ==>> detach volume . 
      -  Go back to the new instance and attach old volume, under actions

          ============================================================================================================

               HOW TO TAKE A SNAPSHOT USING LIFECYCLE MANAGER
      -  under Elastic Block Store on the left choose ===>> lifecycle manager  ===>> custom policy, check for policy type as: EBS snapshot policy==>> click on              next step
      - under target resource types chose ==>> volume,  target resource tags ==>> chose (NAME), then add server name under (enter a value) then add 
      - Add a description, it will add a default IAM ROLE so don't touch, then click next. Under configure schedule 1 - Schedule 1, chose frequency : DAILY ,
         ==>> 24 hours
      - Indicate at what time ( chose when people are using the app less)==> specify the retention type: either "age" or "count" is fine ==>> Expiry date
      - If you want to copy for another region then chose (cross-Region copy) ==>> chose (REGION 1) where you are copying it to ==>> expire days
      
      - you can copy from one account to another ==>> enabling Cross-account sharing ==>> add account
                                        This is not done in real world
      
           ======================================================================================================================================================

                                           HOW TO CUT DOWN ON COST OF SNAPSHOT AS SOLUTION ARCHITECH
                                           
      -  you need to make use of archiving under Actions ( once you archive a snapshot its cost is reduced by 75%)
         when you put a snapshot in archive it takes 24 to 72 hours to retrive and if you need it within that time you need to make use of the 
         FSR = fast snapshot Restore  mechanism

              To enable it, chose the snapshot you archive ==>> Actions ==>> snapshot setting ==>> manage fast snapshot restore

         =====================================================================================================================================================
                                          INCREMENTAL SNAPSHOTS

      - This is a process where by whenever you store volumes(snapshots) on day 1 and day 2 you need to store more snapshots, only the new snapshot not store on           day 1 will move to snapshot 2 to reduce cost
      - You can have more than one volume attached to a vm 
         volume ==>> create the volume ==>> go back to actions and attach the volume ==>> chose the instance ==>> here you attach data volume not root volume
                    
                  
         In real life we don't add multiple volumes on a vm. we instead increase the size of the storage by choosing the volume and the ==>>actions

        =======================================================================================================================================================
                                          AWS RELATIONAL DATA BASE

         - Before RDS developers would have to:
                           - Develope the app code,
                           - install the EC2 server,
                           - install Database,
                           - configure the Backups,
                           - Configure Replication,
                           - Patch the OS,
                           - Monitor the Database

         - Today with RDS
                           - Developer creates AWS RDS
                           - it handles Patching
                           - Backup
                           - Monitoring
                           - Replication
                           - Failover
                           - Scaling
       
   
       =============================================================================================================================================
                          DIFFERENT DATABSE ENGINES SUPPORTED BY RDS

         - MySQL:
                Best database For web Application ( it port number is 3306)
         - PostgreSQL:
                For enterprise Applications it works best
         - MariaDB:
                It is also good for web Application and is an alternative for MySQl
         - ORACLE:
                It is best for enterprise ERP
         - Microsoft SQL server:
                 It is best for windows applications
         - Aurora MySQL:
                 If you want High performance of your database, it is best fit. It is developed by Aurora which is an AWS proprietor solution
         - Aurora PostgreSQL:
                 It is highest performance . Created by Aurora as well

            Aurora supports MySQL and PostgreSQL databases
   
         ================================================================================================================================
                                          AWS RDS ARCHITECTURE


        RDS is a fully managed database. AWS manages the database, so you can focus on your application.


       As a user when ever you provide your data (e.g name, email, phone number), this data is stored in the RDS instance . For the application
       to connect to the RDS instance it needs the RDS Endpoint. In the RDS instance what ever data you provide is stored in the EBS 

                                COMPONENTS OF RDS

                     - DB instance
                     - STorage
                     - Security Groups
                     - Endponit
                     - Parameter Groups
                     - Option Groups
                     - Snapshots

             RDS INSTANCE CLASSES ( different types /size of engines)

            - GENERAL PURPOSE:
                     This type is used mostly for development , and for Testing 
                     - db.t3
                     - db.t4g
            - MEMORY OPTIMIZED
                     This type of engine is mostly used for Production Databases , and Large querires
                     - db.r5
                     - db.r6g
                     - db.r7g

            MULTI - AZ DEPLOYMENT

            One of the most important architect tpoics

            - SINGLE AZ
                     Here we have the application and the data is stored in the primary Db only
                     Here if AZ fails, Database id down
            - MULTI - AZ
                     Here we have the application and data is stored in 2 places. Firstly in the Primary Db(100% of the data)  and we also store the same 
                      data on a standby DB with through a synchronous repliaction.

                    BENEFITS:
                    IF AZ fails we still have a copy on the standby DB. it provides 
                    - high availability
                    - Automatic Failover
                    - enhances Disaster Recovery
                    
            Interview Question:
                 As a senior cloud architect how can you design a high level disaster recovery for database for automatic failure.
                 What is the kind of architecture you are going to use?

                 ANSWER. 
                     i will use the multi AZ availability zone where by data will will sync automatically to a standby DB so that if Primary DB fails( due to                          network issue, or it was corrupted), standby will still be available. Automatically AWS will understand that there is an issue, it will                           remove the primary DB and promote the secondary DB (standby DB). AS users are entering data DNX will be updated automatically as well (URL)
                       
                       (failover : is usually 60 - 120 sec)

           ==================================================================================================================================================

                                      READ REPLICAS  -  It is used for SCALING PURPOSES

          Architecture :
                      We have the Primary DB which will be replicated through asynchronous replication and produce 
                                                                      - Replica 1
                                                                      - Replica 2
                                                                      - Replica 3

                     Used cases:
                             It is used for reporting, Analytics, READ-Heavy APLLICATIOns

                     MUTLI - AZ VS READ REPLICA ( Read replicas are used after Multi AZ has already been implemented depending on the need)


                 FEATURE                         MULTI - AZ                          READ REPLICA
                High avail                          YES                                   NO
                Read Scaling                        No                                    Yes                     
                Replication                         Sync                                  Async
                Automatic failover                  yes                                   No

                                         HOW TO SCALE RDS

                     VERTICAL SCALING                                               STORAGE SCALING
                db.r5.large ===>> db.r5.2xlarge                                 100 GB ===>> 500 GB
                More CPU and RAM                                                No downtime for most engines


          ==================================================================================================================================
                                                   AUTOMATED BACKUPS OF RDS in AWS

          - AWS automatically creates and manages your database backups. 
                    - FULL BACKUP: it is done daily
                    - Transaction Logs: it can be scheduled every 5 minutes
                    - Retention: 1 to 35 days max but in real life backups are stored in s3 because its cheap
                    - Default: by default data is stored for 7 days

            PRACTICALL WORK  -- AWS has introduce a new feature called express configuration, meaning best options are selected my default

            - First lunch your instance with name as mysql==>> check its default port ==>>create from existing group
            - create RDS ==>. create full config, ==>>chose mysql ==>> full configuration -->> under templates set Production(for real world app)
                            for practice you can select sandbox

                        - under engine version==>. if you enable RDS extended support when ever the engine expires you can still be able to use it. 
                          there's a new engine you cannot go for a new one. Else do not enable it so you can always update to newer engines

           - add DB cluster identifier and Master username (any name of your choice)
              generally to login to a database you need a password
          - since most often we forget password, AWS has added "managed in AWS Secrets Manager) . This password can be changed for every hour
          - under Additional credential setting chose ==>> password or password and IAM
          - Instance type ==>> for prod chose db.m5d.4xlarge
          - storage type==>> allocated storage ( RDS supports max 64 TB of data)
          - under compute resource==>> chose connect to an EC2 compute resource
          - Check Public access and make sure "NO" because a database should not have public access
          - under additional VPC security group==>> chose mysql
          - Under RDS Proxy==>> if you enable RDS proxy the best advantage is we save alot of time and alot of money

       
       FOr example 10,000 people are trying to access the database. They want to run queries. We can pull all of them and serve the traffic
       from RDS proxy. The advantage of RDS proxy is that instaed of having individual queries we will pull all the queries togther and serve 
       the data as one. We can also do better scaling with the help of RDS proxy and connection will be faster and safer
         
                 AS for ENGINES UPGRADES OR MAINTENANCE WINDOW

                 
      - we have MINOR UPGRADE
                      mysql 8.0.35 ==>> mysql 8.0.36
      - WE HAVE MAJOR UPGRADE
                     mysql 5.7 ==>> mysql 8

       - GENRALLY for database while we are doing Patching and minor upgrades, server needs to be stopped especially for production and 
          nobody can access the data.
             - we enable AWS upgrades for AWS performs maintenance during configured window. to do so

             - select database ==>> create database ==>> additional configuration ==>> maintenance window ==>> choose window (set your preferred window)


  ==========================================================================================================================================
  
       interview question:
                   As a cloud architect i want you to design an architect where you can save time and cost both?

            ANswer: I will make use of RDS Proxy: with the help of RDS proxy it saves 55% of cost

         - Once fully connected, scroll down to endpoint( it is like our url) and copy the endpoint and port
         - go to your terminal and type
                                 MySQL -h (endpoint and point) -u (host name of database by default) -p(copy from aws secret manager)

            IF you want to make sure your data is higly available : 
                        make use of MULTI - AZ architecture
            If you want your database to perform a number of read operations for every 1 minutes: 
                        make use of READ REPLICAS
            If you are creating a database but you want to ensure data is available globally (for entire regions what do you use) what do you use: 
                        AUrora Global database
            if you want to create one database that would not to maintain the server ?  
                        make use of Aurora serverless DB
            If you want your database to make pooling connections at a time what are you going to use?
                       make use of DS PROXY




             to get the password go back to secret manager
        - create database kely;
          show databases;
          use kely;

        CREATE TABLE users (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(100),
            email VARCHAR(100),
            password VARCHAR(20),
            city VARCHAR(20),
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );

        - to run the queries
                           SELECT * FROM users;

        SNAPSHOTS: when ever you take backups, it is available for max 35 days. If you want it to be available forever you need to take snapshots

          - Go back to the database ===>> actions ==>> take a snapshot

           - To delete the database select the database==>> modify at the top ==>> disable deletion protection ==>>modify DB instance
    ================================================================================================================================================

                               REAL LIFE CLOUD ARCHITECTURE DESIGN

     WHEN users send their request, ===>> it goes to CLOUDFRONT ( Global CDN for fast content deliver) ==>> the request will go to ALB which will distribute traffic. Next the traffic goes to EKS/ECS ( container orchestration-Runs microservices). Since people will be using the app from the cluster , we will create  RDS proxy ( which manages and pools database connections). When it pools millions of request , it will send it to Primary DB( Primary DB handles writes). This Primary DB will send the same data to multiple READ REPLICAs. (netflix doesn't use multi-az it uses global aurora replication because once this is created it will available for all the regions.)


 In real life when you type www.netflix.com, it goes to rout53( for domain  name resolution), then it goes to
                                                        WAF ( WEB APP firewall which acts as security layer against DDOS/ other attacks 
                                                        Next it goes to CDN (to maintain low latency)
                                                        it goes to API gateway: centralize request and routes it to the different backend services)/ 
                                                        it then goes to the microservices/ EKS cluster (manages or run workloads)
                                                        it goes to kafka/apache kafka for messaging
                                                        database (if the data crashes people will not be able to reach the app, then comes a war room


            
        
