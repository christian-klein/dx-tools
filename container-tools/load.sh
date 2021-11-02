#!/bin/bash

# Copyright 2021 HCL Technologies
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script will load all DX docker images that are accessible 
# into the local docker registry and then upload them to a private registry.

CWD="$PWD"
REGISTRY="$2"

# Begins

# Pass the file path of the docker images through command line argument
filePath=$1

if [ -z "$1" ]
  then
    echo "You must supply a folder path to the DX image tar.gz files (Ex: ./load.sh ~/Downloads/myDXimages myregistry.local)."
    exit
fi

if [ -z "$2" ]
  then
    echo "You must supply a Private repository to prepend (Ex: ./load.sh ~/Downloads/myDXimages myregistry.local)."
    exit
fi


if [[ -d ${filePath} ]]
then
    cd ${filePath}
else
    echo "ERROR: No such directory exists. Please try again."
    exit
fi

# Declaring array of Images
for f in *-image-*.gz; do
    echo "-------------------------------------------------------"
    echo
    echo "Processing: $f"
    echo
    echo "Loading Image to local registry ..."
    dockerLoadResult="$(docker load -i $f)"
    echo $dockerLoadResult
    echo
    dockerImgName="$(cut -d ':' -f 2 <<< "$dockerLoadResult"|xargs)"
    dockerImgTag="$(cut -d ':' -f 3 <<< "$dockerLoadResult"|xargs)"
    echo "Image Name: $dockerImgName"
    echo "Image Tag: $dockerImgTag"
    echo
    echo "Tagging Image with local registry [$REGISTRY/$dockerImgName:$dockerImgTag] ..."
    dockerTagResult="$(docker tag $dockerImgName:$dockerImgTag $REGISTRY/$dockerImgName:$dockerImgTag)"
    echo 
    echo "Pushing Image to local registry ..."
    dockerPushResult="$(docker push $REGISTRY/$dockerImgName:$dockerImgTag)"
    echo
    echo "Image Push Result: $dockerPushResult"
done

echo "-------------------------------------------------------"
echo "Finished processing all image files"