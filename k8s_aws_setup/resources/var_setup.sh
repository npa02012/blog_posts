#!/bin/bash
set -e

# PYSPARK_PYTHON
#echo 'PYSPARK_PYTHON="/usr/bin/python3"' | sudo tee -a /etc/environment # Do profile for now
echo 'PYSPARK_PYTHON="/usr/bin/python3"' | sudo tee -a /etc/profile
export PYSPARK_PYTHON="/usr/bin/python3"

# For jupyter to work
export PATH=$PATH:~/.local/bin
echo 'PATH=$PATH:~/.local/bin' | sudo tee -a /etc/profile # Single quotes avoids variable expansion






