# common functionality for all scripts
# expects a usage() function already defined at the point this file is sourced.

script_name=$0

RED='\033[0;31m' #red
NC='\033[0m' # No Color
GREEN='\033[0;32m' #green
verbose=false

function error_handler() {
  echo "Error occurred in ${script_name} at line: ${1}."
  echo "Line exited with status: ${2}"
}

trap 'error_handler ${LINENO} $?' ERR

set -o errexit
set -o errtrace
set -o nounset

if [[ -z ${1+x} ]]
then
	echo "Error: no shapes file specified" >&2
	usage
	exit 1	
fi

if [[ ! -f "$1" ]]
then
	echo "Error: shapes file $1 is not a file" >&2
	exit 2
fi
shapesFile="$( cd `dirname "$1"` >/dev/null 2>&1 && pwd )"/"$(basename $1)"

if [[ -z ${2+x} ]]
then
	echo "Error: no data file specified" >&2
	usage
	exit 1	
fi

if [[ ! -f "$2" ]]
then
	echo "Error: data file $2 is not a file" >&2
	exit 2
fi
dataFile="$( cd `dirname "$2"` >/dev/null 2>&1 && pwd )"/"$(basename $2)"

outputToDir=false
if [[ ! -z ${3+x} ]]
then
	if [[ ! -d "$3" ]]
    then
        echo "Error: output dir $3 is not a directory" >&2
        exit 2
    fi
    outputToDir=true
    outputDir="$( cd "$3" >/dev/null 2>&1 && pwd )"
fi

compareToExpected=false
if [[ ! -z ${4+x} ]]
then
	if [[ ! -d "$4" ]]
    then
        echo "Error: expected dir $4 is not a directory" >&2
        exit 2
    fi
    compareToExpected=true
    expectedOutputDir="$( cd "$4" >/dev/null 2>&1 && pwd )"
fi

# echos the 2nd param if the first is empty
function echoDefault() {
    if [[ -z $1 ]] 
    then
        echo $2
    else
        echo $1
    fi   
}
