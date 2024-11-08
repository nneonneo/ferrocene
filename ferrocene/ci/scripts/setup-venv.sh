#!/bin/bash
# SPDX-License-Identifier: MIT OR Apache-2.0
# SPDX-FileCopyrightText: The Ferrocene Developers

set -xeuo pipefail

curl -LsSf https://astral.sh/uv/0.5.0/install.sh | sh

source $HOME/.local/bin/env
echo 'source $HOME/.local/bin/env' >> $BASH_ENV

# Use the full path here since Windows might not have it on PATH yet
uv venv
uv python install 3.12
uv python pin 3.12
uv pip sync requirements.txt