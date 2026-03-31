#!/bin/bash
set -e

source /opt/ros/jazzy/setup.bash
source /ws/install/setup.bash

# Ensure save directory exists
mkdir -p /data/paths

exec ros2 launch transit_backend transit.launch.py
