#! /bin/sh
# Usage: ./prowl.sh priority(-2 to 2) app event description
# Example: ./prowl.sh 0 "transmission" "torrent has finished" "Coen Brothers Compilation has finised downloading"

event=${1:-'Testing Message'}
description=${2:-"${event}"}
priority=${3:-2}
app=${4:-'piRouter'}

apikey="9127857854f6cc518d8ab3171bb31d54e466fa59"
prowl="https://api.prowlapp.com/publicapi/"
method="add"
URL="${prowl}${method}"

curl $URL -F apikey=$apikey -F priority=$priority -F application="$app" -F event="$event" -F description="$description"
