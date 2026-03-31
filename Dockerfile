FROM ros:jazzy

# Install Python dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-websockets \
    ros-jazzy-geographic-msgs \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install websockets aiohttp --break-system-packages

# Copy and build transit_msgs
COPY src/transit_msgs /ws/src/transit_msgs
RUN cd /ws && \
    . /opt/ros/jazzy/setup.sh && \
    colcon build --packages-select transit_msgs

# Copy transit backend
COPY src/transit_backend /ws/src/transit_backend
RUN cd /ws && \
    . /opt/ros/jazzy/setup.sh && \
    . install/setup.sh && \
    colcon build --packages-select transit_backend

# Copy frontend
COPY src/transit_frontend /ws/src/transit_frontend

# Entry point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
