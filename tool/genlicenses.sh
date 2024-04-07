#!/bin/bash
#
# Simple linux script to generate the all.json license file
#
jq -s '.' ../lib/src/spdx/licences/*.json > ../lib/src/spdx/licences/all.json
