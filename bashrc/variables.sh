# Colors
export RED="\033[0;91m"
export GREEN="\033[0;92m"
export YELLOW="\033[0;93m"
export BLUE="\033[0;94m"
export RESET="\033[0m"

# Set the PS1 variable
# \u: username
# \h: hostname (short)
# \W: basename of current working directory
# \$: displays '#' if root, '$' otherwise
#
# Note: \[\] brackets are used to mark non-printable characters 
# (e.g. color codes)
# This ensures Bash correctly calculates the prompt length and prevents
# display issues like incorrect cursor positioning and line wrapping
export PS1="\[${GREEN}\]\u@\h\[${RESET}\] \[${BLUE}\]\W\[${RESET}\]\$ "
