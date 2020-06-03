#!/bin/sh

usage(){
cat << EOF
usage: $0 <shapes-file> <data-folder> [output-directory] [expected-output-directory]
    
    For each ttl file in the [data-directory], uses [shapes-file] to 
    1. validate it (and output a message if validation fails)
    2. makes SHACL-AF inferences (and outputs a message if there were inferences)
    3. writes the output for each file to a file suffixed with 
       '-val.ttl' and '-inf.ttl' to [output-directory] if one is set
    4. compares the output to the expected output 
        in [expected-output-directory] if one is set

EOF
}
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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
	echo "Error: $1 is not a file" >&2
	exit 2
fi
shapesFile="$( cd `dirname "$1"` >/dev/null 2>&1 && pwd )"/"$(basename $1)"

if [[ -z ${2+x} ]]
then
	echo "Error: no data folder specified" >&2
	usage
	exit 1	
fi

if [[ ! -d "$2" ]]
then
	echo "Error: $2 is not a folder" >&2
	exit 2
fi
dataFolder="$( cd `dirname "$2"` >/dev/null 2>&1 && pwd )"/"$(basename $2)"

outputToDir=false
if [[ ! -z ${3+x} ]]
then
	if [[ ! -d "$3" ]]
    then
        echo "Error: $3 is not a directory" >&2
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
        echo "Error: $4 is not a directory" >&2
        exit 2
    fi
    compareToExpected=true
    expectedOutputDir="$( cd "$4" >/dev/null 2>&1 && pwd )"
fi
shopt -s globstar
for dataFile in ${dataFolder}/**/*.ttl
do
    command="${script_path}/shacl-single.sh ${shapesFile} ${dataFile}"
    if (${outputToDir})
    then
        command="${command} ${outputDir}"
    fi
    if (${compareToExpected})
    then
        command="${command} ${expectedOutputDir}"
    fi
    ${command}
done