#!/bin/bash
# SPDX-License-Identifier: MIT OR Apache-2.0
# SPDX-FileCopyrightText: The Ferrocene Developers

set -xeuo pipefail

curl -LsSf https://astral.sh/uv/0.5.0/install.sh | sh

export PATH="$PATH:$HOME/.local/bin"
echo 'export PATH="$PATH:$HOME/.local/bin"' >> $BASH_ENV

# Use the full path here since Windows might not have it on PATH yet
$HOME/.local/bin/uv venv
$HOME/.local/bin/uv python install 3.12
$HOME/.local/bin/uv python pin 3.12
$HOME/.local/bin/uv pip sync requirements.txt