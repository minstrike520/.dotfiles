# Colors
RED="\033[0;91m"
GREEN="\033[0;92m"
YELLOW="\033[0;93m"
BLUE="\033[0;94m"
RESET="\033[0m"

# Set the PS1 variable
# \u: username
# \h: hostname (short)
# \W: basename of current working directory
# \$: displays '#' if root, '$' otherwise
export PS1="${GREEN}\u@\h${RESET} ${BLUE}\W${RESET}\$ "
