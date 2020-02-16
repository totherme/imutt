. ./gmail-helpers.bash

T_fail="${T_fail:?This should be provided by basht}"

T_fix_wrapped_messageid_does_not_break_good_messageids() {
  local expected actual

  expected="
some text
some more text
Message-ID: <an-actual-id>
even more text"
  actual="$(echo "$expected" | fix_wraped_messageid)"

  if [[ "$expected" != "$actual" ]] ; then
    echo "****** Expected: "
    echo "${actual}"
    echo "****** to Equal:"
    echo "${expected}"
    $T_fail "strings were not equal"
  fi
}

T_fix_wrapped_messageid_fixes_one_line_wraps() {
  local input expected actual

  input="
some text
some more text
Message-ID: 
 <an-actual-id>
even more text"

  expected="
some text
some more text
Message-ID: <an-actual-id>
even more text"
  actual="$(echo "$input" | fix_wraped_messageid)"

  if [[ "$expected" != "$actual" ]] ; then
    echo "****** Expected: "
    echo "${actual}"
    echo "****** to Equal:"
    echo "${expected}"
    $T_fail "strings were not equal"
  fi
}
