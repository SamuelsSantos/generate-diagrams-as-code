#!/bin/bash

set -e

echo $DIAGRAM_FILE

if [[ -z "${DIAGRAM_FILE}" ]]; then
  echo "Set the DIAGRAM_FILE env variable."
  exit 1
fi

python3 $DIAGRAM_FILE