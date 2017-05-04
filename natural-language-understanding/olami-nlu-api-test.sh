#!/bin/bash

# Copyright 2017, VIA Technologies, Inc. & OLAMI Team.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


API_BASE_URL=$1
APP_KEY=$2
APP_SECRET=$3
INPUT_TEXT=$4

function request_nlu_api()
{
    api_name=$1
    timestamp=$(($(date +%s%N)/1000000))
    
    # Prepare message to generate an MD5 digest.
    md5_text="${APP_SECRET}api=${api_name}appkey=${APP_KEY}timestamp=${timestamp}${APP_SECRET}"
    
    # Generate MD5 digest.
    sign=`echo -n $md5_text | md5sum | awk '{ print $1 }'`
    
    # Prepare rq JSON data
    if [[ "${api_name}" == "seg" ]]; then
        rq=${INPUT_TEXT}
    else
        rq="{\"data_type\":\"stt\",\"data\":{\"input_type\":\"1\",\"text\":\"${INPUT_TEXT}\"}}"
    fi
    
    # Assemble all the HTTP parameters you want to send
    post_data="api=${api_name}&appkey=${APP_KEY}&timestamp=${timestamp}&sign=${sign}&rq=${rq}"
    
    # Prepare cURL command. Why not print out to see the whole command?
    cmd="curl -X POST ${API_BASE_URL} -d '${post_data}'"
    echo $cmd
    echo -e
    
    # Request ASR service by 'HTTP POST' to get the NLU recognition result
    echo "Here is the result:"
    echo -e
    eval $cmd
    echo -e
}

# Test API and using 'api=seg'
echo -e
echo "---------- Test NLU API, api=seg ----------"
echo -e
request_nlu_api 'seg'

# Test API and using 'api=nli'
echo -e
echo "---------- Test NLU API, api=nli ----------"
echo -e
request_nlu_api 'nli'
