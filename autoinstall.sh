#!/usr/bin/env bash
# Currently only supports Fedora/RHEL
set -eu -o pipefail

# Arguments are a plus++
if [ "$#" -eq 0 ]; then
	echo "Hey! I need some input"
	echo "Usage $0 hostname options"
	exit 0
else
	echo "Cool, I'll use $1 as your Hostname"
	readonly H_NAME=$1
fi

# Grab updates
echo "First, let's update!"
sudo yum update

# Check for PIP/VirtualEnv
echo "Checking for Pip, GCC, and VirtualEnv"
if ! command -v "gcc" >/dev/null 2>&1;then
	echo "GCC is missing. Installing"
	sudo yum install -q -y gcc
fi
if ! command -v "pip" >/dev/null 2>&1;then
	echo "Pip is missing. Installing"
	sudo yum install -q -y python-pip
fi

if ! command -v "virtualenv" >/dev/null 2>&1;then
	echo "VirtualEnv is missing. Installing"
	sudo yum install -q -y python-virtualenv python-virtualenvwrapper
fi

# Create VirtualEnv
if ! [ -d .env ]; then
	echo "Creating Virtual env in .env/"

	# Need Yum
	virtualenv --system-site-packages .env
fi

# Setup VirtualEnv
echo "PIP: Installing requirements.txt"
.env/bin/pip install --quiet -r requirements.txt

# Run playbook
echo "Running Ansible Playbook"
.env/bin/ansible-playbook play_local.yml -e hostname=$H_NAME ${@:2}
