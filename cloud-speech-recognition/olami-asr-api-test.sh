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
FILE_PATH=$4
COMPRESS=$5

timestamp=$(($(date +%s%N)/1000000))

# Prepare message to generate an MD5 digest.
md5_text="${APP_SECRET}api=asrappkey=${APP_KEY}timestamp=${timestamp}${APP_SECRET}"

# Generate MD5 digest.
sign=`echo -n $md5_text | md5sum | awk '{ print $1 }'`

# Assemble all the HTTP parameters you want to send
post_data="api=asr&appkey=${APP_KEY}&timestamp=${timestamp}&sign=${sign}&seq=seg,nli&stop=1"

# Prepare cURL command. Why not print out to see the whole command? 
cmd_post="curl -X POST \"${API_BASE_URL}?${post_data}&compress=${COMPRESS}\" -H \"content-type:application/octet-stream\" --data-binary @${FILE_PATH} -c mycookie"
echo $cmd_post

# Request ASR service by 'HTTP POST' to upload a audio file
post_result=`eval $cmd_post`
echo -e
echo "Audio file has been sent! Server response: ${post_result}"
echo -e

# Check response status
if [[ $post_result == *'"error"'* ]]; then
    echo "[ERROR] Error occurred!"
    echo -e
    exit $?
fi

sleep 1

# Prepare cURL command to get ASR result. Also print out to see the whole command.
cmd_get="curl -X GET \"${API_BASE_URL}?${post_data}\" -b mycookie"
echo $cmd_get
echo -e

# Request ASR service by 'HTTP GET' to get the speech recognition result
# Depending on the audio length, you may need to issue the request multiple times for the final result.
while true; do
    echo "Sending request to get result by HTTP GET..."
    echo -e
    get_result=`eval $cmd_get`
    if [[ $get_result == *'"final":true,"status":0'* ]]; then
        echo -e
        echo "Here is the result:"
        echo -e
        echo $get_result
        break
    fi
    sleep 2
done

