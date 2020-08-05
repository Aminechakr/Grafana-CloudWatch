#!/usr/bin/env bash

### Variables to edit
GRAFANA_AWS_DEFAULT_REGION="eu-west-1" #TODO
GRAFANA_AWS_ACCESS_KEY_ID="" #TODO
GRAFANA_AWS_SECRET="" #TODO
API_KEY="" #TODO
GRAFANA_HOST="https://grafana.com"

#Generate datasource configuration 
#Name of the datasource should be changed dependantly to the source

cat > /tmp/datasource.json << EOF
 {
  "name":"$Project-cloudwatch", 
  "type":"cloudwatch",
  "access":"proxy",
  "jsonData": {
    "authType": "keys",
    "defaultRegion": "$GRAFANA_AWS_DEFAULT_REGION"
  },
  "secureJsonData":{
    "accessKey":"$GRAFANA_AWS_ACCESS_KEY_ID",
    "secretKey":"$GRAFANA_AWS_SECRET"
  }
}
EOF

#Import cloudwatch datasource in grafana

curl -v -k $GRAFANA_HOST/api/datasources \
-H "Authorization: Bearer $API_KEY" \
-H "Accept: application/json" \
-H "Content-Type: application/json" \
-d @/tmp/datasource.json

rm -rf /tmp/datasource.json
