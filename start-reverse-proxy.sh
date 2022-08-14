#!/bin/bash
CAPSULE_REVERSE_PROXY_ADMIN_TOKEN="1234567890" \
capsule \
   -mode=reverse-proxy \
   -backend="memory" \
   -httpPort=8888
