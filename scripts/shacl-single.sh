#!/bin/sh

usage(){
cat << EOF
usage: $0 <shapes-file> <data-file> [output-directory] [expected-output-directory]
    
    For each ttl file in the [data-directory], uses [shapes-file] to 
    1. validate it (and output a message if validation fails)
    2. makes SHACL-AF inferences (and outputs a message if there were inferences)
    3. writes the output for each file to a file suffixed with 
       '-val.ttl' and '-inf.ttl' to [output-directory](default: ${script_path}/tmp/out) 
    4. compares the output to the expected output 
        in [expected-output-directory] if one is set
    

EOF
}
script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
input_path="$( cd ${script_path}/../rdf/input >/dev/null 2>&1 && pwd )" # determine where our input files are

source ${script_path}/common.sh 
source ${script_path}/settings.sh 



if $( ! ${outputToDir})
then
    outputToDir=true
    outputDir="$( cd ${script_path}/../tmp/out >/dev/null 2>&1 && pwd )"
fi
mkdir -p ${outputDir}
echo "input_path:${input_path}"
if [[ $dataFile =~ "${input_path}" ]]
then 
    dataFileDir="$( cd "$( dirname "$dataFile" )" >/dev/null 2>&1 && pwd )"
    outputSubDir=${dataFileDir#$input_path}
else  
    outputSubDir=""
fi 
outputDir=${outputDir}$outputSubDir
echo "output to: ${outputDir}"
mkdir -p ${outputDir}


valSuffix="-val.ttl"
infSuffix="-inf.ttl"
infValSuffix="-inf-val.ttl"
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
dataFileBase=`basename $dataFile`
okRegex='.+-ok(-.+)?\.ttl'
failRegex='.+-fail(-.+)?\.ttl'
expectedOk=false
expectedFail=false
filenameBaseExpectation=false
if [[ `basename ${dataFile}` =~ ${okRegex} ]]
then
    expectedOk=true
fi
if [[ `basename ${dataFile}` =~ ${failRegex} ]]
then
    expectedFail=true
fi
if ($expectedOk || $expectedFail )
then
    filenameBaseExpectation=true
fi

redirValOut=/dev/null
redirInfOut=/dev/null
redirInfValOut=/dev/null
if (${outputToDir})
then
    redirValOut=${outputDir}/`basename ${dataFile}`${valSuffix}
    redirInfOut=${outputDir}/`basename ${dataFile}`${infSuffix}
    redirInfValOut=${outputDir}/`basename ${dataFile}`${infValSuffix}
fi



if (${compareToExpected})
then
    compareValTo=${expectedOutputDir}${outputSubDir}/`basename ${dataFile}`${valSuffix}
    compareInfTo=${expectedOutputDir}${outputSubDir}/`basename ${dataFile}`${infSuffix}
fi
tmpFile=$(mktemp ${script_path}/../tmp/tmp-data.XXX.ttl)
cat ${dataFile} > ${tmpFile}
additionalValueflowsData=`dirname ${shapesFile}`/"valueflows-and-required-ontologies.ttl"
if [[ -f ${additionalValueflowsData} ]]
then
    cat ${additionalValueflowsData} >> ${tmpFile}
fi

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

function statusColorTextPink() {
if (${1})
then
    echo "${TURQUOISE}${2}${NC}"
else
    echo "${PINK}${3}${NC}"
fi
}

function statusText() {
if (${1})
then
    echo "${2}"
else
    echo "${3}"
fi
}

showFile=`realpath --relative-to . ${dataFile}`
echo -e -n "${showFile}: " 

# VALIDATION

${SHACL_VALIDATE} -shapesfile ${shapesFile} -datafile ${tmpFile} > ${redirValOut} 2>&1 && validateSuccess=true || validateSuccess=false

if (${validateSuccess})
then
    validateConforms=true
else
    grep -q -e 'conforms[ \t]*false' ${redirValOut} && validateConforms=false || validateConforms="unknown"
    if [[ ${validateConforms} = "unknown" ]]
    then
        grep -q -e 'conforms[ \t]*true' ${redirValOut} && validateConforms=true || validateConforms="unknown"
    fi
    if [[ ${validateConforms} = "unknown" ]]
    then
        # validate reports status 1 if data graph does not conform or there is an exception! 
        # so we have to check the output to see what was the case. 
        # In this branch, we did not find a validation result, so we assume the command failed
        validateSuccess=false
    else 
        validateSuccess=true
    fi
fi

validateMessage="valid:"  
inferenceMessage="inferences:"
compareVal=false
compareInf=false
if (${validateSuccess}) 
then
    compareValMessage="`statusColorTextPink ${validateConforms} 'true' 'false'`"
    # evaluate result based on filename (-ok- or -fail-)
    if (${filenameBaseExpectation})
    then
        compareValExpected=false
        if ($validateConforms && $expectedOk || ( ! $validateConforms && $expectedFail))
        then
            compareValExpected=true
        fi
        compareValMessage="${compareValMessage}(`statusColorText $compareValExpected 'expected' 'unexpected' `)"
    fi
    if (${compareToExpected})
    then
        # evaluate result based on expected file and filename
        test -f $compareValTo && compareVal=true || compareVal=false
        test ${compareVal} && cmp -s $redirValOut $compareValTo && compareValExpected=true || compareValExpected=false
        if ( ${compareVal} )
        then
            compareValMessage="${compareValMessage} output: `statusColorText $compareValExpected 'expected' 'unexpected' `"
        else 
            compareValMessage="${compareValMessage} (${YELLOW}no output spec${NC})"
        fi
    fi
else 
    compareValMessage="${RED}error${NC}"
fi

echo -ne "${validateMessage} ${compareValMessage}"

# INFERENCES

${SHACL_INFER} -shapesfile ${shapesFile} -datafile ${tmpFile} > ${redirInfOut} 2>&1 && inferenceSuccess=true || inferenceSuccess=false
if (${inferenceSuccess})
then
    compareInfMessage="`cat ${redirInfOut} | wc -l` lines"
    if (${compareToExpected})
    then
        test -f $compareInfTo && compareInf=true || compareInf=false
        test ${compareInf} && cmp -s $redirInfOut $compareInfTo && infResultExpected=true || infResultExpected=false
        if ( ${compareInf} )
        then
            compareInfMessage="${compareInfMessage} (`statusColorText $infResultExpected 'expected' 'unexpected' `)"
        else 
            compareInfMessage="${compareInfMessage} (${YELLOW}no spec${NC})"
        fi
    fi
else 
    compareInfMessage="${RED}failed${NC}"
fi

echo -en ", ${inferenceMessage} ${compareInfMessage}"

# VALIDATION of DATA + INFERENCES
cat ${redirInfOut} >> ${tmpFile}

# almost identical code as above
${SHACL_VALIDATE} -shapesfile ${shapesFile} -datafile ${tmpFile} > ${redirInfValOut} 2>&1 && validateSuccess=true || validateSuccess=false

if (${validateSuccess})
then
    validateConforms=true
else
    grep -q -e 'conforms[ \t]*false' ${redirInfValOut} && validateConforms=false || validateConforms="unknown"
    if [[ ${validateConforms} = "unknown" ]]
    then
        grep -q -e 'conforms[ \t]*true' ${redirInfValOut} && validateConforms=true || validateConforms="unknown"
    fi
    if [[ ${validateConforms} = "unknown" ]]
    then
        # validate reports status 1 if data graph does not conform or there is an exception! 
        # so we have to check the output to see what was the case. 
        # In this branch, we did not find a validation result, so we assume the command failed
        validateSuccess=false
    else 
        validateSuccess=true
    fi
fi

validateMessage="inferences valid:"  
compareVal=false
if (${validateSuccess}) 
then
    compareValMessage="`statusColorTextPink ${validateConforms} 'true' 'false'`"
    # evaluate result based on filename (-ok- or -fail-)
    if (${filenameBaseExpectation})
    then
        compareValExpected=false
        if ($validateConforms && $expectedOk || ( ! $validateConforms && $expectedFail))
        then
            compareValExpected=true
        fi
        compareValMessage="${compareValMessage}(`statusColorText $compareValExpected 'expected' 'unexpected' `)"
    fi
    if (${compareToExpected})
    then
        test -f $compareValTo && compareVal=true || compareVal=false
        test ${compareVal} && cmp -s $redirInfValOut $compareValTo && compareValExpected=true || compareValExpected=false
        if ( ${compareVal} )
        then
            compareValMessage="${compareValMessage} output: `statusColorText $compareValExpected 'expected' 'unexpected' `"
        else 
            compareValMessage="${compareValMessage} (${YELLOW}no spec${NC})"
        fi
    fi
else 
    compareValMessage="${RED}error${NC}"
fi
echo -e ", ${validateMessage} ${compareValMessage}"

rm ${tmpFile}

