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

   ========================================================================================================================

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
     ================================================================================================================================
                     
                                             WHAT IS PROMETHEUS
                                    NAME              : PROMETHEUS
                                    TYPE              : FREE & OPEN SOURCE
                                    MAJORLY           : CLOUD NATIVE APPLICATIONS
                                   PURPOSE            : TO MONITOR SERVERS
                                   WHAT               : METRICS (CPU, RAM, DISK ----)
                                   STORE DATA : TSDB [TIME SERIES DATA BASE]
                                   INTEGRATE    : TO ALEART MANAGER LIKE EMAIL, MOBILE, SLACK --
                                   PORT              : 9090
                                TO SHOW      : PROMQL -- > PROMETHEUS QUERY LANGUAGE

=======================================================================================================================================

                                     WHAT IS GRAFANA
                               TOOL            : GRAFANA
                               TYPE              : FREE & OPEN SOURCE
                               PURPOSE      : TO CREATE MONITROING DASHBOARD FOR SERVERS
                               PORT             : 3000
                               INTEGRATE   : TO ALEART MANAGER LIKE EMAIL, MOBILE, SLACK --
                               CREDS           : Username:admin & Password: admin

========================================================================================================================================
                              WHAT IS NODE-EXPORTER
                          TOOL          : NODE EXPORTER
                          TYPE           : ITS A DATA SOURCE
                         PURPOSE   : TO SEND METRIC FROM WORKER NODE TO PROMETHEUS
                           PORT          : 9100a


                  SCRIPTS : https://github.com/RAHAMSHAIK007/all-setups
                 use ubuntu-pegion script to install 


              STEP-1: CREATE A WEB-SERVER AND INSTALL NODE-EXPORTER
              STEP-2: CREATE A MONITORING-SERVER AND INSTALL PROMETHEUS & GRAFANA

               CONNECTION TO WORKER NODES
           STEP-3: GO TO MONITORING SERVER [vim /etc/prometheus/prometheus.yml] 
                    ADD IP OF YOUR WORKER NODES in target

           NOTE: AFTER MODIFIYING PROPERTY OF ANY SERVERCIE WE NEED TO RESTART.
                    systemctl restart prometheus.service


                     QUERIES:
            to show number of servers running	: up
            to show number of reqeuest to server	: promhttp_metric_handler_requests_total
            to show number of reqeuest per 1 min	: promhttp_metric_handler_requests_total[1m]
            to show number of reqeuest in %	        : rate(promhttp_metric_handler_requests_total[1m])
            to show memory information		: node_memory_Active_bytes
            to show cpu  information		: node_cpu_seconds_total	
            to show cpu  information		: node_cpu_seconds_total	
            to show disk information		: node_disk_info


=======================================================================================================================
                 connect to grafana dashboard 
           STEP-1: LOGIN TO GRAFANA (username: admin password: admin)
           STEP-2: ADD DATA SOURCE (WHERE DATA IS COMMING FROM)

           Data source -- > add -- > promethus -- > url of prometheus -- > save & test 

           import dashboard -- > 1860 -- > laod --- > prometheus -- > import	

          apt update && apt install stress -y && stress -c 10

              IDS:

           1860
           10180
           14731
           11074
           8919

==============================================================================================


SD:
FILE BASE SD:

# prometheus.yml
scrape_configs:
  - job_name: 'file-sd'
    file_sd_configs:
      - files:
          - 'targets/*.json'
        refresh_interval: 30s



[
  {
    "targets": ["web-01:9100", "web-02:9100", "web-03:9100"],
    "labels": {
      "env": "production",
      "service": "frontend",
      "team": "platform"
    }
  }
]


EC2 BASED SD: 

1. CREATE A ROLE (EC2readonly Access) -- < add to ec2
2. INSTALL NODE EXPORTER ON ALL NODES (USE ASG & ami/TEMPLATE/USER SCRIPT)
3. vim /etc/prometheus/prometheus.yml


scrape_configs:
  - job_name: 'ec2-discovery'

    ec2_sd_configs:
      - region: us-east-1
        port: 9100

    relabel_configs:
      - source_labels: [__meta_ec2_private_ip]
        target_label: instance



4. systemctl restart prometheus 
5. systemctl daemon-reload

==================================================================

DAY-3: 24-04-2026
ALEART MANAGER CODE: https://prometheus.io/docs/alerting/latest/configuration/#route
ALEART RULES: https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/
SLACK INTEGRATION: https://grafana.com/blog/step-by-step-guide-to-setting-up-prometheus-alertmanager-with-slack-pagerduty-and-gmail/



STEP-1: INSTALL PROMETHEUS & ALERT MANAGER IN MONITORING SERVER
STEP-2: INSTALL NODE EXPORTER IN WEB SERVER

STEP-3: WRITE RULES FILE IN (vim /etc/prometheus/rules/cpu_alert.yml)
mkdir /etc/prometheus/rules
vim /etc/prometheus/rules/cpu_alert.yml

groups:
  - name: cpu-alerts
    rules:
      - alert: HighCPUUsage
        expr: 100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[1m])) * 100) > 50
        for: 1m
        labels:
          severity: warning
        annotations:
          summary: "High CPU on {{ $labels.instance }}"
          description: "CPU usage > 50% on {{ $labels.instance }}"



STEP-4: CONFIGURE RULES FILE (vim /etc/prometheus/prometheus.yml)


global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - "rules/cpu_alert.yml"

scrape_configs:
  - job_name: "ec2-discovery"

    ec2_sd_configs:
      - region: us-east-1
        port: 9100

    relabel_configs:
      - source_labels: [__meta_ec2_private_ip]
        target_label: instance


STEP-5: ADD ALEART MANAGER FEILD (vim /etc/prometheus/prometheus.yml)
vim /etc/prometheus/prometheus.yml


global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - "rules/cpu_alert.yml"

scrape_configs:
  - job_name: "ec2-discovery"

    ec2_sd_configs:
      - region: us-east-1
        port: 9100

    relabel_configs:
      - source_labels: [__meta_ec2_private_ip]
        target_label: instance

alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - "localhost:9093"


#NOTE: LOCAL HOST INDICATE MONITORING SERVER WHERE ALEART MANAGER IS INSTALLED


STEP-6: CONNECT SLACK FOR NOTIFICATION (vim /etc/alertmanager/alertmanager.yml)


global:
  resolve_timeout: 5m

route:
  receiver: "slack-notifications"
  routes:
    - match:
        severity: warning
      receiver: "slack-notifications"

receivers:
  - name: "slack-notifications"
    slack_configs:
      - api_url: "https://hooks.slack.com/services/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"
        channel: "#prod-incidents"
        text: |
          ALERT: {{ .CommonAnnotations.summary }}
          {{ .CommonAnnotations.description }}


SLACK CONFIG:

https://api.slack.com/apps
CREATE NEW APP -- > FROM SCRATCH -- > PICK FEATURES 
SELECT INCOMMING WEBHOOKS
ENABLE TOGGLE BUTTON
ADD NEW WEBHOOK
SELECT CHANNEL NAME
ALLOW
COPY AND PAST THE TOKEN CONFIG FILE


systemctl restart prometheus.service
systemctl restart alertmanager.service



INCREASE THE LOAD ON WEB SERVER:
apt update && apt install stress && stress -c 10


USE-CASE:2 

Vim /etc/prometheus/rules/vmdown.yml

groups:
  - name: ServerDown
    rules:
      - alert: ServerDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Server {{ $labels.instance }} down"
          description: "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute."

ADD THE FILE NAME TO : Vim /etc/prometheus/prometheus.yml
systemctl restart prometheus.service


SILENCES: IF YOU WANT TO MUTE ANY ALERTS USE SILENCES
GO TO UI AND CREATE SILENCES FOR PATCHING AND GIVE EXPIRY TIME
=========================================================================================================================

PUSH GATEWAY:

STEP 1: INSTALL Pushgateway

apt update
apt install docker.io -y
docker run -d -p 9091:9091 prom/pushgateway
docker ps -a

STEP 2: Configure Prometheus to Scrape Pushgateway
vim /etc/prometheus/prometheus.yml

scrape_configs:
  - job_name: "pushgateway"
    static_configs:
      - targets: ["localhost:9091"]


STEP 3: Create Backup Script (THIS IS CORE)

vim /tmp/backup.sh

#!/bin/bash

START=$(date +%s)

# simulate backup (10 sec)
sleep 10

END=$(date +%s)
DURATION=$((END - START))

echo "backup_duration_seconds $DURATION" | \
curl --data-binary @- http://localhost:9091/metrics/job/backup_job


STEP-4: MAKE IT EXECUTABLE AND RUN SCRIPT
chmod +x /tmp/backup.sh
sh /tmp/backup.sh

Now check:
http://localhost:9091/metrics

You’ll see:
backup_duration_seconds 10



RBAC: ROLE BASE ACCESS CONTROL
TO CONTROL THE PERMISSIONS OF A USER

STEPS: Create Users
Sheild Symbol → Users → Add user
SETTINGS → Teams → Create Team
FOLDER -- > PERMISSION -- > ADD TEAM AND GIVE PERMISSIONS


LOKI:

Loki is a log aggregation system created by Grafana Labs. 
Loki does not index the content of logs, but rather uses labels to categorize them. 
This makes it highly efficient and scalable. 
It works seamlessly with Grafana.



Component	Role
Promtail	Agent that tails log files and sends them to Loki
Loki		Log storage. Label indexing + chunk storage
Grafana		Log visualization, dashboards, and alert configuration




INSTALLATION OF LOKI & PROMTAIL IN WEB-SEVER:

apt update && apt install docker.io -y

wget https://raw.githubusercontent.com/grafana/loki/v2.8.0/cmd/loki/loki-local-config.yaml -O loki-config.yaml
docker run -itd --name loki -v /root/:/mnt/config -p 3100:3100 grafana/loki:2.8.0
publicip:3100/ready


wget https://raw.githubusercontent.com/grafana/loki/v2.8.0/clients/cmd/promtail/promtail-docker-config.yaml -O promtail-config.yaml
docker run -itd --name promtail -v $(pwd):/mnt/config -v /var/log:/var/log --link loki grafana/promtail:2.8.0 --config.file=/mnt/config/promtail-config.yaml


CONFIGURE LOKI IN GRAFANA:

Cnfigurtaion -- > datasource -- > add -- > loki -- > http://52.90.35.175:3100 -- > save and test
explore view

INSTALL ANY APP ON WEB SERVER AND TAIL THE LOGS

Data Organization

Head Block: The most recent, in-memory, mutable block where new samples are written
Persisted Blocks: Immutable blocks on disk containing older data
WAL (Write-Ahead Log): Ensures data durability even in case of crashes

Chunks: The actual compressed time series data
Storage: 512MB

BY DEFAULT PROMETHEUS STORES ONLY 30GB
IF YOU WANT TO STORE MORE THAN 30GB USE THANSO


THANOS:
Extend the system with the object storage of your choice to store your metrics for unlimited time. 
Supports GCP, S3, Azure, Swift and Tencent COS.



BUILD OWN-DASHBOARDS: CONCEPT-1

METHOD-1: MODIFYING PRE-DEFINED CODE OF DASHBOARDS

STEP-1:
GO TO GRAFANA 
SELRCT ON DASHBOARD (EX: 10242 ID)
DOWNLOAD JSON CODE 
MODIFY THE VALUES


STEP-2: DOWNLOAD API KEY AUTHENTICATION





STEP-1: WRITE CODE 
STEP-2: EXECURE SCRIPT


vim script.sh

#!/bin/bash

API_KEY=""
GRAFANA_URL="http://13.49.158.250:3000"

cat all-dashboards.json | jq -c '.[]' | while read dashboard; do
  curl -s -X POST "$GRAFANA_URL/api/dashboards/db" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d "$dashboard"
done




DASHBOARD CODE:

vim all-dashboards.json

[
  {
    "dashboard": {
      "id": null,
      "title": "RAHAM CPU Dashboard",
      "schemaVersion": 38,
      "panels": [
        {
          "id": 1,
          "type": "timeseries",
          "title": "CPU",
          "datasource": {
            "type": "prometheus",
            "uid": "PROM_UID"
          },
          "gridPos": { "h": 8, "w": 12, "x": 0, "y": 0 },
          "targets": [
            { "expr": "up", "refId": "A" }
          ]
        }
      ]
    },
    "overwrite": true
  },
  {
    "dashboard": {
      "id": null,
      "title": "RAHAM Memory Dashboard",
      "schemaVersion": 38,
      "panels": [
        {
          "id": 2,
          "type": "timeseries",
          "title": "Memory",
          "datasource": {
            "type": "prometheus",
            "uid": "PROM_UID"
          },
          "gridPos": { "h": 8, "w": 12, "x": 0, "y": 0 },
          "targets": [
            { "expr": "node_memory_MemAvailable_bytes", "refId": "A" }
          ]
        }
      ]
    },
    "overwrite": true
  }
]



========================================================================
STEP-1: SET ENV VARS


export CLUSTER_NAME="raham-cluster-1"
export AWS_REGION="ap-southeast-1"
export AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
export KARPENTER_NAMESPACE="kube-system"
export KARPENTER_VERSION="v1.14.1" 

STEP-2: TAGGING SUBNET & SG (TO IDENFIFY AND LAUNCH VMS)

# Tag all subnets used by the cluster
for SUBNET_ID in $(aws eks describe-cluster --name $CLUSTER_NAME --query "cluster.resourcesVpcConfig.subnetIds[]" --output text); do
  aws ec2 create-tags --resources $SUBNET_ID --tags Key=karpenter.sh/discovery,Value=$CLUSTER_NAME
done

# Tag the cluster's primary security group
SECURITY_GROUP_ID=$(aws eks describe-cluster --name $CLUSTER_NAME --query "cluster.resourcesVpcConfig.clusterSecurityGroupId" --output text)
aws ec2 create-tags --resources $SECURITY_GROUP_ID --tags Key=karpenter.sh/discovery,Value=$CLUSTER_NAME


STEP-3: GIVE PERMISSION FOR KARPENTER TO ADD NODE TO EKS


cat <<EOF > node-trust-policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF

aws iam create-role --role-name KarpenterNodeRole-${CLUSTER_NAME} --assume-role-policy-document file://node-trust-policy.json


aws iam attach-role-policy --role-name KarpenterNodeRole-${CLUSTER_NAME} --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
aws iam attach-role-policy --role-name KarpenterNodeRole-${CLUSTER_NAME} --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
aws iam attach-role-policy --role-name KarpenterNodeRole-${CLUSTER_NAME} --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
aws iam attach-role-policy --role-name KarpenterNodeRole-${CLUSTER_NAME} --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore





Step 4: Map the Node Role via EKS Access Entries

aws eks create-access-entry --cluster-name $CLUSTER_NAME \
  --principal-arn arn:aws:iam::${AWS_ACCOUNT_ID}:role/KarpenterNodeRole-${CLUSTER_NAME} \
  --type EC2_LINUX



STEP-5: CREATE POD IDENDITITY

aws eks create-addon --cluster-name $CLUSTER_NAME --addon-name eks-pod-identity-agent


# Get your cluster OIDC provider URL
export OIDC_PROVIDER=$(aws eks describe-cluster --name ${CLUSTER_NAME} --query "cluster.identity.oidc.issuer" --output text | sed -e "s/^https:\/\///")

# 2. Create the Controller Trust Policy (IRSA) locally
cat <<EOF > controller-trust-policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${AWS_ACCOUNT_ID}:oidc-provider/${OIDC_PROVIDER}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "${OIDC_PROVIDER}:aud": "sts.amazonaws.com",
                    "${OIDC_PROVIDER}:sub": "system:serviceaccount:karpenter:karpenter"
                }
            }
        }
    ]
}
EOF

# 3. Create the Karpenter Controller IAM Role
aws iam create-role \
  --role-name KarpenterControllerRole-${CLUSTER_NAME} \
  --assume-role-policy-document file://controller-trust-policy.json

# 4. Download and apply the official CloudFormation/IAM controller policy template directly
curl -fsSL https://raw.githubusercontent.com/aws/karpenter-provider-aws/${KARPENTER_VERSION}/website/content/en/preview/getting-started/getting-started-with-karpenter/cloudformation.yaml > karpenter.yaml

# (Optional Alternative): Instead of manual parsing, you can deploy the official AWS Cloudformation stack directly which sets up all required IAM roles and policies safely:
# aws cloudformation deploy \
#   --stack-name Karpenter-${CLUSTER_NAME} \
#   --template-file karpenter.yaml \
#   --capabilities CAPABILITY_NAMED_IAM \
#   --parameter-overrides ClusterName=${CLUSTER_NAME}




Step 6: Install Karpenter via Helm
export KARPENTER_VERSION="1.14.1"

aws ecr-public get-login-password --region us-east-1 | helm registry login --username AWS --password-stdin oci://public.ecr.aws

# Install Karpenter Custom Resource Definitions (CRDs)
helm upgrade --install karpenter-crd oci://public.ecr.aws/karpenter/karpenter-crd --version "v${KARPENTER_VERSION}" --namespace $KARPENTER_NAMESPACE --create-namespace

helm upgrade --install karpenter oci://public.ecr.aws/karpenter/karpenter --version "v${KARPENTER_VERSION}" --namespace $KARPENTER_NAMESPACE \
  --set settings.clusterName=${CLUSTER_NAME} \
  --set serviceAccount.create=true \
  --set replicationController.replicaCount=1

==========================================================================================================================================================

                                               NOTES

          - What is monitoring:
                             It is the continous process of checking the health, performance, and the availabiltiy of servers, applications,
                             networks, and infrastructure.
                             For example: monitoring and EC2 instance to check whether CPU USAGE is 90% or MORE USAGE is increasing.

          
                           IMPORTANCE OF MONITORING

          - AVAILABILITY:
                        To ensure applications and servers are running
          - PERFORMANCE:
                        It helps identify slow applications and services
          - TROUBLESHOOTING:
                        It helps identify issues quickly
          - ALERTING:
                    It notifies engineers when something goes wrong e.g RAM is leaking
          - SECURITY:
                     It helps detect unusual activities
          - CAPACITY PLANNING:
                     It helps predict future infrastructure requirements
          - RELIABILITY:
                      It reduces downtime and improves user experience
          
  ======================================================================================================================

                      TOP MONITORING TOOLS IN DEVOPS
  Prometheus: Collects and stores monitoring metrics
  Grafana: Displays metrics through dashboards and graphs
  Nagios: Monitors infrastructure and checks availability
  Zabbix: Monitors servers, networks, and applications
  Datadog: Provides cloud infrastructure and application monitoring
  New Relic: Monitors application performance and user experience
  Dynatrice: Provides automated application and infrastructure abservability
  Elastic Stack: collects, search, and analyzes logs
  Splunk: Analyzes machine-generated data and logs
  OpenTelemetry: collects and exports metrics, logs, and traces
  
=========================================================================================================================

                                          PROMETHEUS

            - Its is an open-source monitoring tool that collects , stores, and queries time-series metrics from servers and applications
            - It scrapes metrics every 15 seconds
            - It monitors EC2 , CPU, and memory metrics
            - Monitors Kubernetes pod health
            - Monitors application request rates
            - It tracks HTTP error rates
            - It stores data it the TSDB
            - It default port is 9090


                                          WHAT IS A Node EXPORTER
            - It is a Prometheus exporter that collects linux server hardware and operating system metrics and exposes them for Prometheus to scrape.
            - Use cases:
                     CPU utilization, Memory utilization, Disk usage, Network Traffic and server load, the number of processes running in the server
            - Its default port: 9100

     ==========================================================================================================================

                                            GRAFANA

          Grafana is an open-source visualization tool used to display monitoring data through dashboards, graphs, and charts,
          - use cases:
                    Create CPU and memory dashboards
                    Monitor Kubernetes clusters
                    Visualize application performance
                    Track server health in real time
          - It default port is 3000












   
