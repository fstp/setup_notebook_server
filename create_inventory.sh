#!/bin/bash
set -ux
terraform output ip | sed 's/"//g' > inventory
cat inventory
