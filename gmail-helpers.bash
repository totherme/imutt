
fix_wraped_messageid() {
  local current_line next_line
  while read -r current_line ; do
    if echo "${current_line}" | grep '^Message-I[dD]:\s*$' > /dev/null ; then
      read -r next_line
      echo "${current_line} ${next_line}"
    else
      echo "${current_line}"
    fi
  done
}
