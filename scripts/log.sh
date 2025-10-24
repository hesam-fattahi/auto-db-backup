#!/bin/bash
# A standard way to print timestamped messages

log() {
  local level=$1
  shift
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*"
}

