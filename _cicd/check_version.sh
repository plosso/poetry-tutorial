#!/bin/bash

packageVersion=$(poetry version | awk '{print $2}')    
echo "Your pyproject.toml version: $packageVersion"

versionRegex="^${packageVersion}$"
echo "Your regex: $versionRegex"

repoVersionList=$(gcloud artifacts versions list --package=poet --repository=python --location=us-central1 --format="csv(VERSION)")
echo "Version in repository: $repoVersionList"
 
if gcloud artifacts versions list --package=poet --repository=python --location=us-central1 --format="csv(VERSION)" | grep "$versionRegex"; 

#if [[ "$repoVersionList" =~ $versionRegex ]]
then
	echo "Version already exists in repo"
    #exit 1
else
	echo "Version does not yet exist in repo"                                       
fi