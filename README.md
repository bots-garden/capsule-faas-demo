# capsule-faas-demo

## Start the registry

```bash
./start-registry.sh
```

## Build the functions samples

```bash
cd src/functions/hello
tinygo build -o hello.wasm -scheduler=none -target wasi ./hello.go
```

```bash
cd src/functions/hey
tinygo build -o hey.wasm -scheduler=none -target wasi ./hey.go
```

## Publish the 2 wasm function to the registry

```bash
CAPSULE_REGISTRY_ADMIN_TOKEN="AZERTYUIOP" \
cc publish \
-wasmFile=./src/functions/hello/hello.wasm -wasmInfo="this is the hello module" \
-wasmOrg=demo -wasmName=hello -wasmTag=0.0.0 \
-registryUrl=http://localhost:4999
```

```bash
CAPSULE_REGISTRY_ADMIN_TOKEN="AZERTYUIOP" \
cc publish \
-wasmFile=./src/functions/hey/hey.wasm -wasmInfo="this is the hey module" \
-wasmOrg=demo -wasmName=hey -wasmTag=0.0.0 \
-registryUrl=http://localhost:4999
```

> 🖐 the wasm modules are published to `registry/functions/demo`

```bash
./registry
├── functions
│  └── demo
│     ├── hello
│     │  └── 0.0.0
│     │     ├── hello.info
│     │     └── hello.wasm
│     └── hey
│        └── 0.0.0
│           ├── hey.info
│           └── hey.wasm
```

## Start the reverse-proxy

```bash
./start-reverse-proxy.sh
```


## Start the worker

```bash
./start-worker.sh
```

## Deploy a function (wasm module)

> - A function deployment is always related to a revision
> - The revision is created at the same time
> - A function can be "linked" to several revisions
> - A revision is a version of a function

```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc deploy \
-function=hello \
-revision=orange \
-downloadUrl=http://localhost:4999/demo/hello/0.0.0/hello.wasm \
-envVariables='{"MESSAGE": "Revision 🟠","TOKEN": "😡"}'
```

output:
```bash
⏳ [deploying to worker] hello / orange
🙂 [deployed to worker] hello / orange
🌍 [serving] http://localhost:8888/functions/hello/orange
```

Open the link (http://localhost:8888/functions/hello/orange) in a browser.

### Deploy the same revision again (twice)

> - With different values for the environment variables
> - Deploying the same revision several times, it's like scaling the revision

```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc deploy \
-function=hello \
-revision=orange \
-downloadUrl=http://localhost:4999/demo/hello/0.0.0/hello.wasm \
-envVariables='{"MESSAGE": "Revision 🟠","TOKEN": "😡🤬"}'
```

```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc deploy \
-function=hello \
-revision=orange \
-downloadUrl=http://localhost:4999/demo/hello/0.0.0/hello.wasm \
-envVariables='{"MESSAGE": "Revision 🟠","TOKEN": "😡🤬🥵"}'
```

Open the link (http://localhost:8888/functions/hello/orange) in a browser, and refresh the page several times.

### Deploy some new revisions of the function 

```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc deploy \
-function=hello \
-revision=blue \
-downloadUrl=http://localhost:4999/demo/hello/0.0.0/hello.wasm \
-envVariables='{"MESSAGE": "Revision 🔵","TOKEN": "👩‍🔧🧑‍🔧👨‍🔧"}'
```

output:
```bash
⏳ [deploying to worker] hello / blue
🙂 [deployed to worker] hello / blue
🌍 [serving] http://localhost:8888/functions/hello/blue
```


```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc deploy \
-function=hello \
-revision=green \
-downloadUrl=http://localhost:4999/demo/hello/0.0.0/hello.wasm \
-envVariables='{"MESSAGE": "Revision 🟢","TOKEN": "🍏🥝🍉"}'
```

output:
```bash
⏳ [deploying to worker] hello / green
🙂 [deployed to worker] hello / green
🌍 [serving] http://localhost:8888/functions/hello/green
```

Open the 2 links in your browser:
- http://localhost:8888/functions/hello/blue
- http://localhost:8888/functions/hello/green


## Define a default revision

Right now, we have 3 revisions of the `hello` function:

- http://localhost:8888/functions/hello/orange
- http://localhost:8888/functions/hello/blue
- http://localhost:8888/functions/hello/green

Defining a **"default"** revision means you can call the default revision without the name of the selected revision:

- http://localhost:8888/functions/hello

For example, we set the default revision to the blue revision=
```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc set-default \
-function=hello \
-revision=blue
```

output:
```bash
⏳ [setting default revision] hello / blue
🙂 [the default revision is set]-> hello / blue
🌍 [serving] http://localhost:8888/functions/hello
```

Now, we can call the blue revision directly with http://localhost:8888/functions/hello

### Switch to another revision

To change the default revision, use the same command with only changing the name of the revision:
```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc set-default \
-function=hello \
-revision=green
```

output:
```bash
⏳ [setting default revision] hello / green
🙂 [the default revision is set]-> hello / green
🌍 [serving] http://localhost:8888/functions/hello
```

### Remove the default revision of a function

```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc unset-default \
-function=hello
```

output:
```bash
⏳ [unsetting default revision] hello
🙂 [the default revision is unset]-> hello
```

### Undeploy a revision

You can un-deploy the revision of a function (and kill the related process):

```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc un-deploy \
-function=hello \
-revision=green
```

output:
```bash
⏳ [un-deploying revision] hello / green
🙂 [the revision is un-deployed (all processes killed)]-> hello / green
```

## Get information about the worker

To get all the deployed revisions, use the following command:

```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
cc worker
```

output:
```json
{
    "hello": {
        "blue": {
            "isDefaultRevision": "false",
            "wasmModules": {
                "8540": {
                    "envVariables": {
                        "MESSAGE": "Revision 🔵",
                        "TOKEN": "👩‍🔧🧑‍🔧👨‍🔧"
                    },
                    "localUrl": "http://localhost:10004",
                    "remoteUrl": "http://localhost:8888/functions/hello/blue"
                }
            },
            "wasmRegistryUrl": "http://localhost:4999/demo/hello/0.0.0/hello.wasm"
        },
        "orange": {
            "isDefaultRevision": "false",
            "wasmModules": {
                "7518": {
                    "envVariables": {
                        "MESSAGE": "Revision 🟠",
                        "TOKEN": "😡"
                    },
                    "localUrl": "http://localhost:10001",
                    "remoteUrl": "http://localhost:8888/functions/hello/orange"
                },
                "7908": {
                    "envVariables": {
                        "MESSAGE": "Revision 🟠",
                        "TOKEN": "😡🤬"
                    },
                    "localUrl": "http://localhost:10002",
                    "remoteUrl": "http://localhost:8888/functions/hello/orange"
                },
                "8095": {
                    "envVariables": {
                        "MESSAGE": "Revision 🟠",
                        "TOKEN": "😡🤬🥵"
                    },
                    "localUrl": "http://localhost:10003",
                    "remoteUrl": "http://localhost:8888/functions/hello/orange"
                }
            },
            "wasmRegistryUrl": "http://localhost:4999/demo/hello/0.0.0/hello.wasm"
        }
    }
}
```

## Call a function with a POST request

You can create functions that you will call with a POST request, passing it parameters and then retrieving a return value.

Look at the source code of the **`hey`** function (`./src/functions/hey/hey.go`).

### Deploy the hey function

```bash
CAPSULE_WORKER_URL="http://localhost:9999" \
CAPSULE_BACKEND="memory" \
CAPSULE_WORKER_ADMIN_TOKEN="0987654321" \
cc deploy \
-function=hey \
-revision=yellow \
-downloadUrl=http://localhost:4999/demo/hey/0.0.0/hey.wasm
```

output:
```bash
⏳ [deploying to worker] hey / yellow
🙂 [deployed to worker] hey / yellow
🌍 [serving] http://localhost:8888/functions/hey/yellow
```

### Query the hey function:

```bash
curl -v -X POST \
  http://localhost:8888/functions/hey/yellow \
  -H 'content-type: application/json; charset=utf-8' \
  -H 'my-token: I love Pandas' \
  -d '{"message": "Golang 💚💜 wasm", "author": "k33g"}'
```

output:
```bash
< HTTP/1.1 200 OK
< Content-Length: 49
< Content-Type: application/json; charset=utf-8
< Date: Sun, 14 Aug 2022 17:21:44 GMT
< Message: 👋 hello world 🌍
< Mytoken: I love Pandas
< 
* Connection #0 to host localhost left intact
{"author":"Bob","message":"👋 hey! What's up?"}
```
