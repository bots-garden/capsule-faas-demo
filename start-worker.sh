#!/bin/bash
CAPSULE_REVERSE_PROXY_ADMIN_TOKEN="1234567890" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
capsule-worker \
   -reverseProxy=http://localhost:8888 \
   -backend=memory \
   -capsulePath=capsule \
   -httpPortCounter=10000 \
   -httpPort=9999
