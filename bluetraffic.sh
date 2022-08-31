#!/bin/bash
kubectl patch service bluegreen-service -p '{"spec":{"selector":{"version":"v1"}}}'