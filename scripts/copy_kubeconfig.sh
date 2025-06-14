#!/bin/bash

# Manually configure these variables before running the script
NAMESPACE="mcp"              # Set your namespace
POD_NAME="your-pod-name"         # Set your pod name
CONTAINER_NAME="your-container"  # Set your container name
LOCAL_KUBECONFIG="$HOME/.kube/config"  # Set your local kubeconfig path
TARGET_PATH="/root/.kube/config"  # Set the target path in the pod

# Ensure the target directory exists in the pod
TARGET_DIR=$(dirname "$TARGET_PATH")
kubectl exec -n "$NAMESPACE" "$POD_NAME" -c "$CONTAINER_NAME" -- mkdir -p "$TARGET_DIR"

# Copy the kubeconfig file
kubectl cp "$LOCAL_KUBECONFIG" "$NAMESPACE/$POD_NAME:$TARGET_PATH" -c "$CONTAINER_NAME"

echo "Copied $LOCAL_KUBECONFIG to $POD_NAME:$TARGET_PATH in namespace $NAMESPACE (container: $CONTAINER_NAME)" 