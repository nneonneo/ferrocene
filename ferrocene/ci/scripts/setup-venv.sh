#!/bin/bash
# SPDX-License-Identifier: MIT OR Apache-2.0
# SPDX-FileCopyrightText: The Ferrocene Developers

set -xeuo pipefail

if command -v uv &> /dev/null; then
    echo "uv was already installed, skipping"
    exit 0
fi

curl -LsSf https://astral.sh/uv/0.5.0/install.sh | sh

echo 'export PATH="$PATH:$HOME/.local/bin"' >> $BASH_ENV

uv venv
uv python install 3.12
uv python pin 3.12
uv pip sync requirements.txt