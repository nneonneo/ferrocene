#!/bin/bash
# SPDX-License-Identifier: MIT OR Apache-2.0
# SPDX-FileCopyrightText: The Ferrocene Developers
set -xeo pipefail

# Ensure we never get asked/prompted, always take the new config
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

apt install -y \
    git \
    build-essential \
    ninja-build \
    zlib1g-dev

if [[ ! -z "${INSTALL_LLVM}" ]]; then
    apt install -y \
        llvm-18-tools \
        llvm-18-dev
else
    echo 'Not installing LLVM, $INSTALL_LLVM is unset.'
fi
