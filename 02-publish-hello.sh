#!/bin/bash
CAPSULE_REGISTRY_ADMIN_TOKEN="AZERTYUIOP" \
caps publish \
-wasmFile=./src/functions/hello/hello.wasm -wasmInfo="this is the hello module" \
-wasmOrg=demo -wasmName=hello -wasmTag=0.0.0 \
-registryUrl=http://localhost:4999
