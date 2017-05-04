# Cloud Speech Recognition API Samples

This directory contains sample code for using Cloud Speech Recognition API.

Samples:

  * olami-asr-api-test.sh

## Audio File Requirements

The audio file is required in WAV file format PCM, **mono** recording with a sample rate of **16000 (16 KHz)** and a bit resolution of **16 bits**.

## Run in bash

1. Replace **api_url, your_app_key, your_app_secret, your_wav_file** in accordance to your needs and your own data
2. Replace compress_flag to 1 if the audio file is a Speex audio, otherwise 0
3. Run the command in bash
```
./olami-asr-api-test.sh api_url your_app_key your_app_secret your_wav_file compress_flag 
```

For example: (Simplified Chinese Request with the sample.wav file)

```
./olami-asr-api-test.sh https://cn.olami.ai/cloudservice/api 172c5b7b7121407ba572da444a17977c 2115d0888bd049549581b7a0a67cde62 sample.wav 0
```

For example: (Traditional Chinese Request with the sample.wav file)

```
./olami-asr-api-test.sh https://tw.olami.ai/cloudservice/api 999888777666555444333222111000aa 111222333444555666777888999000aa sample.wav 0
```
