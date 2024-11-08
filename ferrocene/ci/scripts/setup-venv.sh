#!/bin/bash
# SPDX-License-Identifier: MIT OR Apache-2.0
# SPDX-FileCopyrightText: The Ferrocene Developers

set -xeuo pipefail

curl -LsSf https://astral.sh/uv/0.5.0/install.sh | sh

export PATH="$HOME/.local/bin:$PATH"
if [ -z ${BASH_ENV+x} ]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> $BASH_ENV
fi

# Use the full path here since Windows might not have it on PATH yet
uv venv
uv python install 3.12
uv python pin 3.12
uv pip sync requirements.txt