#!/bin/bash
# shellcheck disable=SC2086

# bashsupport disable=SpellCheckingInspection
_dir="$HOME/Downloads/blocknote-master"
_rqm="$_dir/requirements.txt"

true > $_rqm

prs() {
  local c
  local er

  [[ $1 =~ ^\.[a-zA-Z_]+ ]] && return || c=${1%%.*}
  er=$(python -c "import $c" 2>&1)


  if [ -z "$er" ]; then echo
  else printf '\t\tno\n' && { echo $c >> $_rqm; }
  fi
}

find $_dir -regex '^[^.]+.py$' |

  while read -r fl; do
    echo $fl

    while read -r s; do
      if [[ $s =~ ^import ]]; then
        dps=${s#*import}

        printf '@\t%s\n' $dps

        prs $dps
      elif [[ $s =~ ^from ]]; then
        dps=${s#*from}
        dps=${dps%import*}

        printf '#\t%s\n' $dps

        prs $dps
      fi
    done < $fl
  done

_rqm2="${_rqm}_"

true > $_rqm2
while read -r rqm; do
  echo $rqm >> $_rqm2
done < <(sort -u $_rqm)

cat $_rqm2 > $_rqm
rm $_rqm2
