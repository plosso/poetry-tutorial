#!/bin/bash
#  if ./check_version.sh | grep 0.1.3; then 
# echo "matched"
# else
# echo "not matched"
# fi

echo packageVersion=$(poetry version) | awk '{print $2}'     


#echo repoPoetryVersionTmp=$(gcloud artifacts versions list --package=poet --repository=python --location=us-central1 --format="csv(VERSION)")
# repoPoetryVersion=$(echo $repoPoetryVersionTmp | awk '{print $2}')
# echo $repoPoetryVersion 
 
# if [[ $poetryVersion -eq $repoPoetryVersion ]]
# then
# 	echo "Version already exists in repo"
# else
# 	echo "Version does not yet exist in repo"                                        
# fi