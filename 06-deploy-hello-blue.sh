#!/bin/bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
caps deploy \
-function=hello \
-revision=blue \
-downloadUrl=http://localhost:4999/demo/hello/0.0.0/hello.wasm \
-envVariables='{"MESSAGE": "Revision 🔵","TOKEN": "👩‍🔧🧑‍🔧👨‍🔧"}'
