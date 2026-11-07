     Github Actions is a native CI/CD platform that automates your software delivery pipeline

     BUILD         ==>>   TEST      ==>>  SECURITY SCANNING     ==>>   PACKAGING    ==>>     DEPLOYMENT     ==>>    COMPLIANCE       ==>> INFRASTRUCTURE PROVISIONING
     
     Developer    ===>  Github      ==>>  Workflow              ===>    Runner      ==>>     Artifacts     ===>>    Security        ===>> Deployment
     Push Code       Event Trigger        starts                     Executes jobs          generated              validation           

    
     Push === >>    pull request   ===>>  workflow dispatch  ==>> schedule  ==>>  release ==>> issue comment

     How do you build cut cost optimization in GitHub actions ========>> by building with a light image like "ubuntu slim"
   ==============================================================================================================================================================

                                     uses: These are pre-build github actions command.
                                     Run: when you want to pass a shell command


            If you are using a node.js app and need a sample code, ====>> google ==>> github actions nodejs installation code
                                                                       For the Artifact===>> GitHub actions nodejs artifact upload stage code

           IF you asked to build a Java app ===>> new workflows ==>> java or Dockerfile , or deploy to k8s

  ========================================================================================================================================================

                                   There are 2 types of RUNNERS IN GITHUB ACTIONS

           1- Github Hosted Runner
           2- Self Hosted Runner
===================================================================================================================================================

                                 SAST  =  STATIC APPLICATION SECURITY TEST

          Nowadays most company use it because when dev push code it has issues such as
                   - coding flaws 
                   - hardcoded credentials ( dev mistakenly pushed their credentials)
                   - SQL injections
                   - security vulnerabilities
          Some of the tools used for SAST include
                   - sonaqube
                   - codeQl
                   - vera cora

=============================================================================================================================================

                          CODEQL HAS 3 STAGES
          1- INITIALIZE
                   It prepares the env and detects languages ( e.g JavaScript, Python, GO).
          2- AUTOBUILD
                   It compile langauges (Java, C==), It watches the code compile to understand the data flow. (Python bypasses this)
          3- ANALYZE
                   Runs thousands of security queries and uploads a report to the Github Security UI

       CodeQl automatically scans your code for security bugs and blocks risky code.








                                   
