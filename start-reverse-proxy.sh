#!/bin/bash
CAPSULE_REVERSE_PROXY_ADMIN_TOKEN="1234567890" \
capsule-reverse-proxy \
   -backend="memory" \
   -httpPort=8888
