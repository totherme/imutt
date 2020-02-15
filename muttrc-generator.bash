get_var_from_config() {
  local config varname
  config="${1:?Expected config json to get a variable from}"
  varname="${2:?Expected a variable to get from the config}"

  echo "$config" | jq -r ".\"$varname\""
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
