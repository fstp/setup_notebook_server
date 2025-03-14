#!/bin/bash
set -ux
source .env
curl -H "Authorization: Bearer $TF_VAR_lambdalabs_api_key" https://cloud.lambdalabs.com/api/v1/instance-types | jq '.data' | bat
