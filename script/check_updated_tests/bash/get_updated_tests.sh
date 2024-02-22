#!/bin/bash
export BASE_PATH=$(pwd)
source get_updated_tests_var.sh

#clone spike
#if [ ! -d "$REPO_ISS_FOLDER_PATH" ]; then
#    git clone $REPO_ISS_SSH
#    cd $REPO_ISS_FOLDER_PATH
#    git checkout $REPO_ISS_BRANCH
#    cd -
#fi

#get files
updated_tests=$(git diff --name-only HEAD~1 HEAD)

#run tests
for test in updated_tests; do
    echo $TEST_FOLDER_PATH
    echo $test
done

#erase temp files
#rm -rf $REPO_ISS_BRANCH
