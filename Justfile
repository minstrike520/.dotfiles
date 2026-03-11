default:
  just --choose

lsdiff pathA pathB:
  echo "--- Comparing file listings of {{pathA}} and {{pathB}} ---"
  git diff --no-index <(ls -A {{pathA}}) <(ls -A {{pathB}})

filediff pathA pathB:
  echo "--- Comparing {{pathA}} and {{pathB}} ---"
  git diff --no-index --ignore-cr-at-eol -- {{pathA}} {{pathB}}

ldddiff binA binB:
  echo "--- Comparing shared libraries of {{binA}} and {{binB}} ---"
  GIT_PAGER= git diff --color --no-index \
    <(ldd {{binA}} | sed "s/ (.*)//" | sort) \
    <(ldd {{binB}} | sed "s/ (.*)//" | sort) \
    | grep -P "\e\[31m-|\e\[32m+"

get-ipv4:
  ip a \
    | grep "inet " \
    | grep ".*127\.0\.0\.1.*" -v \
    | sed 's/\/19.*//' \
    | sed 's/.*inet //' \
    | sed 's/\/[0-9]\([0-9]\?\)//' \
    | sed 's/^\([^ ]*\) .* \([^ ]*\)$/\1 \2/'

[arg("numbered", short="n", value="-n")]
catslice file start end numbered="":
  head {{file}} -n {{end}} | tail -n $(({{end}} - {{start}} + 1)) | cat {{numbered}}

compile-md file:
  echo -e \
  "\\usepackage{xeCJK}"\
  "\\setCJKmainfont{Noto Serif CJK TC}"\
  "\\\\newcommand{\\pu}[1]{\\,\\mathrm{#1}}"



