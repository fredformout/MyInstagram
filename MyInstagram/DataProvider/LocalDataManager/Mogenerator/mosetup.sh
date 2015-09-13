#!/bin/bash

setup ()
{
    cd "${PROJECT_DIR}"

    DATAMANAGERPATH="${PROJECT_DIR}/MyInstagram/DataProvider/LocalDataManager"
    MODELPACKETPATH="${DATAMANAGERPATH}/Model.xcdatamodeld"
    VOMITPATH="${DATAMANAGERPATH}/Model"
    HUMANPATH="${VOMITPATH}/Human"
    MACHINEPATH="${VOMITPATH}/Machine"

    COUNT=$(find $MODELPACKETPATH -type f | wc -l)

    if [ $COUNT == 1 ]
    then
    mogenerator --model "${MODELPACKETPATH}/model.xcdatamodel" --machine-dir "${MACHINEPATH}"  --human-dir "${HUMANPATH}" --template-var arc=true
    else
    mogenerator --model "${MODELPACKETPATH}" --machine-dir "${MACHINEPATH}" --human-dir "${HUMANPATH}" --template-var arc=true
    fi
}

setup


