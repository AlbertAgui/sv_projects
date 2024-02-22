#!/bin/bash

#set base path relative to "repository"
export BASE_PATH=script/check_updated_tests

#set vars
source get_updated_tests_var.sh

#clone spike
if [ ! -d "$REPO_ISS_FOLDER_PATH" ]; then
    git clone $REPO_ISS_SSH -b $REPO_ISS_BRANCH $REPO_ISS_FOLDER_PATH
fi

#compile spike
if [ ! -d "$REPO_ISS_FOLDER_PATH"/build ]; then
    mkdir "$REPO_ISS_FOLDER_PATH"/build
    ./compile.sh -t ep -b normal
fi

#get modified files, but only added, modified and renamed, not deleted 
updated_tests=$(git diff --name-only HEAD~ HEAD --diff-filter=AMR)

#run tests
for test in $updated_tests; do
    #folder is in aimed path
    if [[ $test = $TEST_FOLDER_PATH/* ]]; then 
        echo "$test to be tested"
        timeout 1m "$REPO_ISS_FOLDER_PATH"/build/spike $test
    else
        echo "$test NOT to be tested"
    fi
done

#erase temp files
#rm -rf $REPO_ISS_FOLDER_PATH
