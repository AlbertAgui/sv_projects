#!/bin/bash
export BASE_PATH=$(pwd)/..
source get_updated_tests_var.sh

#clone spike
#if [ ! -d "$REPO_ISS_FOLDER_PATH" ]; then
#    git clone $REPO_ISS_SSH
#    cd $REPO_ISS_FOLDER_PATH
#    git checkout $REPO_ISS_BRANCH
#    cd -
#fi

#compile spike
#./compile.sh -t ep -b normal &> spike_transcript.txt

#get modified files, but only added, modified and renamed, not deleted 
updated_tests=$(git diff --name-only HEAD~ HEAD --diff-filter=AMR)

#run tests
for test in updated_tests; do
    echo $test
    #folder is in aimed path
    if [[ $test = $TEST_FOLDER_PATH* ]]; then 
        echo "$test to be tested"
        #timeout 15 min ./build/spike $test &> "$test"_log.txt
    fi
done

#erase temp files
#rm -rf $REPO_ISS_BRANCH
