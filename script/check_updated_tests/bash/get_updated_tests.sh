#!/bin/bash

#set vars
source get_updated_tests_var.sh

#go to git folder top
cd $(git rev-parse --show-toplevel)

#clone spike / TODO: downolad package registry instead
if [ ! -d "$REPO_ISS_FOLDER_PATH" ]; then
    git clone $REPO_ISS_SSH -b $REPO_ISS_BRANCH $REPO_ISS_FOLDER_PATH
    #compile spike
    if [ ! -d "$REPO_ISS_FOLDER_PATH"/build ]; then
        cd $REPO_ISS_FOLDER_PATH
        mkdir build
        ./compile.sh -t ep -b debug
        cd -
    fi
fi

#get modified files, but only added, modified and renamed, not deleted
#TODO: maybe run them all? think about update to package registry
updated_tests=$(git diff --name-only HEAD~ HEAD --diff-filter=AMR)
#
##go to git folder top
PWD_PATH=$(pwd)
cd "$(git rev-parse --show-toplevel)"/$REPO_ISS_FOLDER_PATH
#
#run tests
for test in $updated_tests; do
    #folder is in aimed path, TODO: .info inside of build!
    if [[ $test = $TEST_FOLDER_PATH/* ]]; then 
        echo "$test to be tested"
        echo "$PWD_PATH"/"$test" test path
        #timeout --signal=SIGINT 5s 
        timeout --signal=SIGINT 5s bash -c "./build/spike -l $PWD_PATH/$test"
        # &> log.txt
        #does file exists?
#        if [ -d "log.txt"]; then
#            #is pattern there? has test finished succesfully?
#            if [ ! grep -e "tohost" -f log.txt]; then
#                exit 1
#            fi
#            #erase temp file
#            rm log.txt
#        else
#            exit 1
#        fi
    else
        echo "$test NOT to be tested"
    fi
done

#erase temp files
rm -rf $REPO_ISS_FOLDER_PATH

#not needed
exit 0