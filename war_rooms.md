
                                WHAT IS A WAR ROOM


  In real life you might create an application but application stops working. It might 
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
           IN REAL LIFE WHO HAVE INCIDENT SEVERITY

  - SEV-1:  The entire Platform is down e.g Netflix cannot stream
  - SEV-2:  A major feature is broken e.g login broken, payment broken
  - SEV-3   Minor issue e.g few users are affected . Although the the feature is broken some people are still able to use it successfully
  - SEV-4   BUG issue e.g low priority

           REAL LIFE INVESTIGATION
    
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

                     






   

