#!/bin/bash
set -euo pipefail

# We can just setup enclave with apt (so upgrades work)
curl -fsSL https://packages.enclave.io/apt/enclave.unstable.gpg | sudo apt-key add -
curl -fsSL https://packages.enclave.io/apt/enclave.unstable.list | sudo tee /etc/apt/sources.list.d/enclave.unstable.list
sudo apt-get update
sudo apt-get install enclave -y

# If you've defined a codespace secret ENCLAVE_ENROLMENT_KEY, we can auto-enrol here.
# Otherwise, you'll need to run sudo enclave enrol manually.
if [ ! -f /etc/enclave/profiles/Universe.profile ] && [ ! -z "${ENCLAVE_ENROLMENT_KEY:-}" ]; then
    sudo enclave enrol $ENCLAVE_ENROLMENT_KEY
fi