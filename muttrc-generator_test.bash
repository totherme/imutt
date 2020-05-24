. ./muttrc-generator.bash

T_fail="${T_fail:?This should be provided by basht}"

T_empty_mailbox_list_produces_empty_hook_list() {
  if [[ "$(make_mbox_hooks_from_mailboxes_list "" 2> /dev/null)" != "" ]] ; then
    $T_fail "if there are no mailboxes, no hooks should be generated"
    return
  fi
}

T_singleton_mailbox_list_produces_singleton_hook_list() {
  expected="mbox-hook \"mymailbox$\" \"mymailbox-archive\""
  actual="$(make_mbox_hooks_from_mailboxes_list "\"mymailbox\"")"
  if [[ "${expected}" != "${actual}" ]] ; then
    $T_fail "expected ${actual} to be ${expected}"
    return
  fi
}

T_multiple_mailboxes_produce_multiple_hooks() {
  expected="$(cat <<EOF
mbox-hook "myfirstmailbox$" "myfirstmailbox-archive"
mbox-hook "mysecondmailbox$" "mysecondmailbox-archive"
mbox-hook "anotherbox$" "anotherbox-archive"
EOF
)"
  actual="$(make_mbox_hooks_from_mailboxes_list "\"myfirstmailbox\" \"mysecondmailbox\" \"anotherbox\"")"
  if [[ "${expected}" != "${actual}" ]] ; then
    $T_fail "expected ${actual} to be ${expected}"
    return
  fi
}

T_getting_a_var_from_config_happy_path() {
  expected="awesome value"
  actual="$(get_var_from_config '{"awesome-var": "awesome value"}' 'awesome-var')"
  if [[ "${expected}" != "${actual}" ]] ; then
    $T_fail "expected ${actual} to be ${expected}"
    return
  fi
}

T_getting_a_missing_var_from_config_returns_empty_string() {
  actual="$(get_var_from_config '{"rubbish-var": "some value"}' 'awesome-var')"
  if [[ ! -z "${actual}" ]] ; then
    $T_fail "expected ${actual} to be ${expected}"
    return
  fi
}
