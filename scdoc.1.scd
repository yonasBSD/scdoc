SCDOC(1)

# NAME

scdoc - generate _man_(7) manual pages

# SYNOPSIS

*scdoc* < _input_

# DESCRIPTION

The scdoc utility reads _scdoc_(5) syntax from the standard input and writes
_man_(7) style roff to the standard output.

# ENVIRONMENT

The scdoc utility supports the standard _SOURCE_DATE_EPOCH_ environment
variable for reproducible builds. This variables specifies the date in number
of seconds since the Unix epoch, see:
https://reproducible-builds.org/specs/source-date-epoch/

# SEE ALSO

_scdoc_(5)

# AUTHORS

Maintained by Drew DeVault <sir@cmpwn.com>. Up-to-date sources can be found at
https://git.sr.ht/~sircmpwn/scdoc and bugs/patches can be submitted by email to
~sircmpwn/public-inbox@lists.sr.ht.
