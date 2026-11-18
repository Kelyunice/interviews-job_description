                      Docker monitoring and Slack alerting


                       Tools we will install
                   
                    Tool	                                         Purpose
                  Prometheus                              	Metrics collection
                    Grafana                               	Monitoring dashboards
                  Alertmanager	                           Alert management
                  cAdvisor	                                Docker container metrics
                   Nginx exporter	                           Nginx metrics




                                     What we will monitor
Test	What should happen
Stop Mango container	Slack sends an alert
CPU exceeds 80%	Slack sends an alert
Memory exceeds 85%	Slack sends an alert
Website becomes unavailable	Slack sends an alert
Container recovers	Slack sends a recovery notification

   ==========================================================================================================================================

                     docker --version 
                     docker compose version
                     docker ps
                     sudo apt install docker-compose-v2
                     mkdir -p ~/devops-practice/monitoring


                     create the docker compose file and run it (docker compose up)
                     inside the same directory create (mkdir -p "grafana', 'alertmanager','blackbox','prometheus')
                     create docker network (docker network create monitoring-network)

                     docker network create monitoring-network

                     docker network connect monitoring-network mango-website

                     docker network inspect monitoring-network

                     



















   
