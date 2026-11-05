
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
                   -  individual level which will persisted at for that individual (.bashrc file) once done reinitialize it
                   - Glosbl level so that every use locked into the system can use it (/etc/environment

================================================================================================================================================

                          AWS NOTES FROM NEW DEVOPS CLASS
   1-  If you realize someone accidentally deleted the s3 of your org with over 100 people who do you check?
                CloudTrail==>> Event History==> event name or even source
   2- which AWS resource Audits logs?
                CloudTrial: It records every API call , user action, console login, CLI command, SDK request, and service activity happening inside your aws account
   3- When ever you create a resource or click on create any resource what actually happends on the ebackend?
               USER REQUEST ==>>  API CALL (REST) ==>> Cloud control plane (Brain of the cloud)  ==>> Resource is created
   4- How can we log in to AWS?
               By using ; IAM USER, IAM ROLE or FEDERATED USER  which will be used check the authentication if you have the permission to login
                                                                then it will check the authorization; permission to create the resources
   5- what actually creates the resource in AWs after the controle plane has verified when, where and how to create the resources?
            Data Plane is the one that actually creates the resource
   6- Connectivity.
            ones you create any server s3 or EKS cluster without connectivity no resource can be able to communicate to the users?
   7- MONITORING AND AUDITING===VISIBILTY
           Monitoring: it questions is it healthy by using tools such as ( cloudWatch, grafana, Prometheuse, Datadog) to check metrics such as (CPU, Memory, Disk, Network
                       Errors, Latency)
           AUDITING: Questions who changes something by using tools such as ( cloudTrial, AWS config, Security Hub) to check metrics such as (who, what, when, from where)
   8- Data captured by CloudTrail on AWS can be stored either in s3 or CloudWatch lods        
   9- CloudTrial events and Pricing
           Management Events are free. Events such as e. creating, stop , start deleting resources ( Control AWS resourcs, ENable by default, cheap, create EC@,
                                       Create IAM USer)
           Data Reource are not free. Events such as upload, download , copying data ( ACCESS resource data, Disabled, Expensive, Read file in s3, GetObject)

  10- To track the records of a particular resource e.g ECS you need to record the trial although by default AWS records everything.
          TO create the Trial: CLoudTrial==>> Trials ==>> Add Trail Name ==>. Storage Location ==> Disable Log file SSE-KMS encryption ==>. Enable additional setting
                               click on next ==> chose und management events or add data events ==>> select all the resource type (EC2 , S3) ==>> next
                              under aggregation templates==>> select ALL ==>> Next and create the trial
 11- in AWS by default every resource is being monitored, but if you want to monitor your resource you are going  to create a dashboard. 
      99% of the time we use PROMETHEUSE for monitoring but it can also be done using AWS cloudWatch
      To create a dashboard
          cloudwatch ==>> dashboards ==>> create dashboards ==.. add the name you want ==>> chose what you want to monitor ( metrics, logs, Alarms)==>> then widget type
                        metrics are in line widget form ==>> next ==>> which resource ==>> copy the server private Ip and paste under Per-instance Metrics ==>>
                         chose what you want to monitor e.g CPU Utilization by checking options==>> create ==>> save dashboard

                         sudo -i
                         apt install stress -y
                         stress -c 10
 12- In aws with the help of which components are you going to monitor you use prometheuse.
        Prometheuse pulls the metrics fro the server (VM)
        Grafana uses the metrics to create the dashboard and visualize the metrics



        

                



                                     
