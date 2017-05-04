# Natural Language Understanding API Samples

This directory contains sample code for using Natural Language Understanding API.

Samples:

  * olami-nlu-api-test.sh

## Run in bash

1. Replace **api_url, your_app_key, your_app_secret, your_text_input** in accordance to your needs and your own data
2. Run the command in bash
```
./olami-nlu-api-test.sh api_url your_app_key your_app_secret your_text_input
```

For example: (Simplified Chinese Request with the text "我爱欧拉蜜")

```
./olami-nlu-api-test.sh https://cn.olami.ai/cloudservice/api 172c5b7b7121407ba572da444a17977c 2115d0888bd049549581b7a0a67cde62 我爱欧拉蜜
```

For example: (Traditional Chinese Request with the text "我愛歐拉蜜")

```
./olami-nlu-api-test.sh https://tw.olami.ai/cloudservice/api 999888777666555444333222111000aa 111222333444555666777888999000aa 我愛歐拉蜜
```
