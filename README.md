# NAME

**vipe.sh** - portable, shell-compatible version of vipe(1) from moreutils

# SYNOPSIS

**vipe.sh**
|
*...*

# DESCRIPTION

**vipe.sh**
is a utility, which makes it possible to use an editor
in pipelines of Bourne-compatible shells.

It aims to address pipeline limitations which result in warnings like:
"Vim: Warning: Output is not to a terminal".

# ENVIRONMENT

The following environmental variables are recognized by
**vipe.sh**:

`EDITOR` (default: "vi")

> The editor to use if
> `VISUAL`
> is not set.

`VISUAL` (default: unset)

> The editor to use.

# EXIT STATUS

The **vipe.sh** utility exits&#160;0 on success, and&#160;&gt;0 if an error occurs.

# EXAMPLES

The following is an example of a typical usage
of the
**vipe.sh**
command:

	find /usr/ports | vipe.sh | grep 'Important file' > result.txt

# COMPATIBILITY

The
**vipe.sh**
command makes use of
mktemp(1)
to create temporary files.

# SEE ALSO

vipe(1),
which is a part of
[moreutils](https://joeyh.name/code/moreutils/).

# HISTORY

**vipe.sh**
is a reimplementation of the popular, Perl-based
vipe(1)
from the moreutils project.

# AUTHORS

**vipe.sh**
and this manual page was written by
Mateusz Piotrowski &lt;[0mp@FreeBSD.org](mailto:0mp@FreeBSD.org)&gt;.
