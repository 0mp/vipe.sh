#! /bin/sh -
#
# SPDX-License-Identifier: BSD-2-Clause-FreeBSD
#
# Copyright (c) 2019 Mateusz Piotrowski <0mp@FreeBSD.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

set -u

clean_up() {
	if [ -f "${temp_file}" ]
	then
		rm -f -- "${temp_file}"
	fi

	trap - EXIT
}

err() {
	printf -- 'vipe.sh: %s [%d]: %s\n' "${1}" "${2}" "${3}"
	exit 1
}

editor="${VISUAL:-${EDITOR:-vi}}"

if temp_file="$(mktemp)"
then :; else
	err mktemp "${?}" "Failed to create temporary file"
fi
trap clean_up EXIT


if cat - > "${temp_file}"
then :; else
	err cat "${?}" "Failed to save standard input to \"${temp_file}\""
fi

if [ ! -t 0 ]; then
	if ${editor} "${temp_file}" < /dev/tty > /dev/tty
	then :; else
		err "${editor}" "${?}" "Exited with non-zero status"
	fi
fi

if cat "${temp_file}"
then :; else
	err cat "${?}" "Failed to print contents of \"${temp_file}\" to standard output"
fi
