     Github Actions is a native CI/CD platform that automates your software delivery pipeline

     BUILD         ==>>   TEST      ==>>  SECURITY SCANNING     ==>>   PACKAGING    ==>>     DEPLOYMENT     ==>>    COMPLIANCE       ==>> INFRASTRUCTURE PROVISIONING
     
     Developer    ===>  Github      ==>>  Workflow              ===>    Runner      ==>>     Artifacts     ===>>    Security        ===>> Deployment
     Push Code       Event Trigger        starts                     Executes jobs          generated              validation           

    
     Push === >>    pull request   ===>>  workflow dispatch  ==>> schedule  ==>>  release ==>> issue comment

     How do you build cut cost optimization in GitHub actions ========>> by building with a light image like "ubuntu slim"
   ==============================================================================================================================================================

                        DIFFERENCE BETWEEN GITHUB ACTIONS AND JENKINS

     1- GitHub actions is a native C? tool while Jenkins is  based distributed builds
     2- GitHub actions is best for GitHub repos and cloud automation while Jenkins is best for large enterprises and for on-prem/hybrid
     3- GitHub actions auto-scales with GitHub-hosted runner while Jenkins scales with swarm agents
     4- GitHub actions requires low maintenance while Jenkins has high maintenance
     5- GitHub actions is modern, fast and simple while Jenkins is flexible , enterprise -ready.



Interview question: 
               where are workflows stored in gitHub Action/ or what is the default location of workflow files
                                                         Answer: .github/workflows/
               how do you make your pipeline faster:
                                                   By using cache (cache helps to store the dependencies(on your local) so that your next build 
                                                   doesn't need to download dependencies again)
               What is .npm?
                            it is a node manager folder

               
    ===================================================================================================================================================
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
       
       When your workflow gives runners the job to scan or do SAST , it needs to bring you the feedback . Under job ==>> permissions: give R, R, W








                                   
