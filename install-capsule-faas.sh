#!/bin/bash
CAPSULE_VERSION="0.1.7"
CAPSULE_OS="linux"
CAPSULE_ARCH="amd64"
#CAPSULE_ARCH="arm64"

echo "💊 Installing the capsule launcher..."
wget https://github.com/bots-garden/capsule/releases/download/${CAPSULE_VERSION}/capsule-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz
sudo tar -zxf capsule-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz --directory /usr/local/bin
rm capsule-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz

echo "💊 Installing the capsule registry..."
wget https://github.com/bots-garden/capsule/releases/download/${CAPSULE_VERSION}/capsule-registry-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz
sudo tar -zxf capsule-registry-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz --directory /usr/local/bin
rm capsule-registry-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz

echo "💊 Installing the capsule reverse-proxy..."
wget https://github.com/bots-garden/capsule/releases/download/${CAPSULE_VERSION}/capsule-reverse-proxy-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz
sudo tar -zxf capsule-reverse-proxy-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz --directory /usr/local/bin
rm capsule-reverse-proxy-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz

echo "💊 Installing the capsule worker..."
wget https://github.com/bots-garden/capsule/releases/download/${CAPSULE_VERSION}/capsule-worker-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz
sudo tar -zxf capsule-worker-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz --directory /usr/local/bin
rm capsule-worker-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz

echo "💊 Installing capsule cli..."
wget https://github.com/bots-garden/capsule/releases/download/${CAPSULE_VERSION}/caps-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz
sudo tar -zxf caps-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz --directory /usr/local/bin
rm caps-${CAPSULE_VERSION}-${CAPSULE_OS}-${CAPSULE_ARCH}.tar.gz
