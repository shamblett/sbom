#!/bin/bash
#
# Simple linux script to generate the all.json license file
#
# Assumes the SPDX license files are in json format and in the same directory
# as this script.
#
# The all.json should be copied into the sbom_licenses.dart file
#
jq -s '.' *.json > all.json
