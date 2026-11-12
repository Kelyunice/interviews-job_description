
                                WHAT IS A WAR ROOM


  In real life you might create an application but application stops working. 
              - there might be bugs
              - there might be vulnerabiltities
              - there might be memory leakage
              - or database issues

  In such a situation, a group of people will come together to solve critical issues with their agenda to restore the application to normal service.

   A WAR ROOM is a room where people from different teams come together to solve a critical issue

===============================================================================================================================================
              WHEN DO WE CREATE A WAR ROOM

  1- when we have major outage ( service is down or degraded) e.g once customer logs in applications closes out
  2- When customers are impacted. millions of users are affected e.g even after logging in service is not responding
  3- When Revenue is at Risk. Business and revenue loss.
  4- When escalations Triggered. Alerts, CEO, or Twitter

===================================================================================================================================
              KEY PRINCIPLES OF A WAR ROOM

  1- FOCUS:
         one goal: Restore service
  2- RIGHT PEOPLE:
         Engineers, SREs, Ops, Backend Engineer, Database Engineer, Cloud engineer, Security Engineer, PMs, Communications lead
  3- CLEAR COMMUNICATION:
         Real-time updates and decisions
  4- ACTION ORIENTED:
         Identify, fix, validate, monitor
  5- STAY UNTIL RESOLVED:
        No one leaves until stable

============================================================================================================================
           IN REAL LIFE HOW INCIDENT SEVERITY IS MANAGED

  - SEV-1:  The entire Platform is down e.g Netflix cannot stream
  - SEV-2:  A major feature is broken e.g login broken, payment broken
  - SEV-3   Minor issue e.g few users are affected . Although the the feature is broken some people are still able to use it successfully
  - SEV-4   BUG issue e.g low priority

           REAL LIFE INVESTIGATION (DEVOPS QUESTION)
    
    1-  CHECK DASHBOARDS:
             Grafana:
                 CPU, Memory, DISK, Latency, Errors, Request
    2-  LOGS:
            Loki, ELK, Splunk:
                search Errors, 500, Timeout, Connection refused
    3-  TRACING:
            Jaeger, Tempo, Zipkin
                Find ==>> slow service
    4-  KUBERNETES:
            Commands
               kubectl get pods, kubectl describe pod, kubectl logs, kubectl top pod
    5-  AWS:
            Check
               Ec2, RDS, ALB, NLB, EKS, CloudWatch, IAM, VPC
========================================================================================================================================

                     DECISION TREE   (SRE question)        

    Suppose deployment caused issues we have 2 options
             1- ROOLBACK:
                        IF: ROLLBACK can fix the issue in 5 min then we chose this option.
             2- FIX FORWARD
                        IF: Database schema changed. Here we cannot rollback. We need a HOTFIX


======================================================================================================================================

                          GOLDEN SIGNALS TO CONSIDER AN APPLICATION AS HEALTHY (SRE question)

      1- LATENCY:
             How long it takes to serve a request
      2- TRAFFIC:
             How much demand your system handles. millions of request per sec
      3- ERRORS:
             The rate of requests that fail. for every 100 people only 1% are experiencing the issue then its okay. But if 10 people or
             20 people then its not acceptable
      4- SATURATION:
             How full your system resources are. How much of CPU and Memory comes under your Vm pressure

==================================================================================================================================

                        WAR ROOMS TOOL

      CATEGORY                                            TOOLS
      
      ALERTING                ============>>>      PagerDuty, Opsgenie
      CHAT                    ===========>>>       Slack or Microsoft Teams
      MONITORING              ===========>>>       Prometheus or Grafana
      LOGS                    ===========>>>       Loki, or ELK, or Splunk
      TRACING                 ===========>>>       Jaeger or Tempo
      INCIDENT MANAGEMENT     ===========>>>       Jira or servicenow , or ServiceNow
      CLOUD                   ===========>>>       aws , or aws cloudWatch
      STATUS PAGE             ===========>>>       Atlassian Statuspage
      RUNBOOKS                ===========>>>       Confluence , or Notion














   

