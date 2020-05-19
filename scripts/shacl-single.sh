#!/bin/sh

usage(){
cat << EOF
usage: $0 <shapes-file> <data-file> [output-directory] [expected-output-directory]
    
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

source ${script_path}/common.sh 
source ${script_path}/settings.sh 

valSuffix="-val.ttl"
infSuffix="-inf.ttl"
if (${verbose})
then
    echo "shapes: ${shapesFile}"
    echo "data: ${dataFile}"
    if (${outputToDir})
    then 
        echo "output to: ${outputDir}"
    fi 
    if (${compareToExpected})
    then 
        echo "comparing to data in : ${expectedOutputDir}"
    fi 
fi

redirValOut=/dev/null
redirInfOut=/dev/null
if (${outputToDir})
then
    redirValOut=${outputDir}/`basename ${dataFile}`${valSuffix}
    redirInfOut=${outputDir}/`basename ${dataFile}`${infSuffix}
fi



if (${compareToExpected})
then
    compareValTo=${expectedOutputDir}/`basename ${dataFile}`${valSuffix}
    compareInfTo=${expectedOutputDir}/`basename ${dataFile}`${infSuffix}
fi

tmpFile=$(mktemp ${script_path}/../tmp/tmp-data.XXX.ttl)
cat ${dataFile} > ${tmpFile}
cat `dirname ${shapesFile}`/"valueflows-and-required-ontologies.ttl" >> ${tmpFile}

function statusColor() {
if (${1})
then
    echo "${GREEN}${2}${NC}"
else
    echo "${RED}${2}${NC}"
fi
}

function statusColorText() {
if (${1})
then
    echo "${GREEN}${2}${NC}"
else
    echo "${RED}${3}${NC}"
fi
}


${SHACL_VALIDATE} -shapesfile ${shapesFile} -datafile ${tmpFile} > ${redirValOut} 2>&1 && validateSuccess=true || validateSuccess=false
${SHACL_INFER} -shapesfile ${shapesFile} -datafile ${tmpFile} > ${redirInfOut} 2>&1 && inferenceSuccess=true || inferenceSuccess=false

rm ${tmpFile}
showFile=`realpath --relative-to . ${dataFile}`
validateMessage=validation:
inferenceMessage=inference:
compareVal=false
compareInf=false
if (${compareToExpected})
then
    if (${validateSuccess} || ! ${validateSuccess}) # validate reports status 1 if data graph does not conform or there is an exception!
    then
        test -f $compareValTo && compareVal=true || compareVal=false
        test ${compareVal} && cmp -s $redirValOut $compareValTo && compareValExpected=true || compareValExpected=false
        if ( ${compareVal} )
        then
            compareValMessage=`statusColorText $compareValExpected 'ok' 'failed' `
        else 
            compareValMessage="${YELLOW}no spec${NC}"
        fi
    else 
        compareValMessage="${RED}failed${NC}"
    fi

    if (${inferenceSuccess})
    then
        test -f $compareInfTo && compareInf=true || compareInf=false
        test ${compareInf} && cmp -s $redirInfOut $compareInfTo && infResultExpected=true || infResultExpected=false
        if ( ${compareInf} )
        then
            compareInfMessage=`statusColorText $infResultExpected 'ok' 'failed' `
        else 
            compareInfMessage="${YELLOW}no spec${NC}"
        fi
    else 
        compareInfMessage="${RED}failed${NC}"
    fi
else 
    compareValMessage=""
    compareInfMessage=""
fi

echo -e "${showFile}:  ${validateMessage} ${compareValMessage}  ${inferenceMessage} ${compareInfMessage}"



