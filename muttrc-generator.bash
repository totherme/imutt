get_var_from_config() {
  local config varname result
  config="${1:?Expected config json to get a variable from}"
  varname="${2:?Expected a variable to get from the config}"

  if result="$(echo "$config" | jq -er ".\"$varname\"")" ; then
    echo "${result}"
  else
    echo ""
  fi
}

make_mbox_hooks_from_mailboxes_list() {
  local mailboxes boxlist box
  mailboxes="${1:?expected mailboxes to generate mbox-hooks from}"
  (
    IFS='"'
    read -ra boxlist <<< "$mailboxes"
    for box in "${boxlist[@]}" ; do
      if [[ -z "${box// }" ]] ; then continue ; fi
      echo "mbox-hook \"${box}$\" \"${box}-archive\""
    done
  )
}
