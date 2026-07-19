#!/bin/bash

## Copyright (C) 2026 - 2026 ENCRYPTED SUPPORT LLC <adrelanos@whonix.org>
## See the file COPYING for copying conditions.

## AI-Assisted

## CI helper: run pyflakes across the project's installable Python
## scripts. They live at usr/libexec/msgcollector/ with no
## extension (Debian libexec convention) so pyflakes' default
## glob discovery does not find them; the file list is enumerated
## here explicitly.

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace
shopt -s inherit_errexit
shopt -s shift_verbose

## TODO: Should ALLOW_LOCAL also be checked here?
if [ "${CI:-}" != "true" ]; then
   printf '%s\n' \
      'error: this script must run with CI=true (GitHub Actions or equivalent).' >&2
   exit 1
fi

readonly files=(
   usr/libexec/msgcollector/alert.py
   usr/libexec/msgcollector/generic_gui_message.py
   usr/libexec/msgcollector/msgdispatcher_dispatch_x.py
   usr/libexec/msgcollector/one-time-popup.py
   usr/libexec/msgcollector/tb_updater_gui.py
   usr/libexec/msgcollector/br_add.py
)

exit_code=0
for file_name in "${files[@]}"; do
   printf '%s\n' "Checking: ${file_name}"
   pyflakes "${file_name}" || exit_code=1
done

exit "${exit_code}"
