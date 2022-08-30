#!/bin/bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
caps set-default \
-function=hello \
-revision=orange
