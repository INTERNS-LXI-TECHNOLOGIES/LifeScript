package com.lxisoft.voiceassistant.controller;

import org.springframework.ai.openai.OpenAiAudioSpeechOptions;
import org.springframework.ai.openai.api.OpenAiAudioApi;
import org.springframework.ai.openai.audio.speech.SpeechModel;
import org.springframework.ai.openai.audio.speech.SpeechPrompt;
import org.springframework.ai.openai.audio.speech.SpeechResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/tts")
public class TTSController {

    private final SpeechModel speechModel;

    public TTSController(SpeechModel speechModel) {
        this.speechModel = speechModel;
    }

    @PostMapping("/synthesize")
    public ResponseEntity<byte[]> synthesizeText(@RequestParam String text) {
        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_TYPE, "audio/mpeg");
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"output.mp3\"");

        try {
            // Configure speech options
            OpenAiAudioSpeechOptions speechOptions = OpenAiAudioSpeechOptions.builder()
                .withVoice(OpenAiAudioApi.SpeechRequest.Voice.ALLOY) // Use a specific voice
                .withSpeed(1.0f) // Set default speed
                .withResponseFormat(OpenAiAudioApi.SpeechRequest.AudioResponseFormat.MP3) // MP3 format
                .withModel(OpenAiAudioApi.TtsModel.TTS_1.value) // Model for TTS
                .build();

            // Create a speech prompt
            SpeechPrompt speechPrompt = new SpeechPrompt(text, speechOptions);

            // Generate speech
            SpeechResponse response = speechModel.call(speechPrompt);

            // Retrieve audio bytes
            byte[] audioBytes = response.getResult().getOutput();

            // Return the audio as a response
            return new ResponseEntity<>(audioBytes, headers, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
