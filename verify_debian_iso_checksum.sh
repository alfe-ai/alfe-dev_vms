#!/bin/bash

ISO_PATH="/mnt/partition3/Downloads/debian-12.9.0-amd64-netinst.iso"
EXPECTED_CHECKSUM="1257373c706d8c07e6917942736a865dfff557d21d76ea3040bb1039eb72a054"

echo "Verifying: $ISO_PATH"

CALCULATED_CHECKSUM="$(sha256sum "$ISO_PATH" | awk '{print $1}')"

if [ "$CALCULATED_CHECKSUM" = "$EXPECTED_CHECKSUM" ]; then
  echo "Checksum verified OK."
else
  echo "Checksum mismatch. Expected:"
  echo "$EXPECTED_CHECKSUM"
  echo "But got:"
  echo "$CALCULATED_CHECKSUM"
  exit 1
fi
