#!/bin/bash

pwd=`pwd`
fileList=`ls ${pwd}/protoc`

for dir in ${fileList}
do
    protoc_cmd="protoc -I. -I protoc --go_out=plugins=grpc,paths=source_relative:. protoc/${dir}/*.proto"
    eval "${protoc_cmd}"
done
